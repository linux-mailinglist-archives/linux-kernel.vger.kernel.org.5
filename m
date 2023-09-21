Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3767A9DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjIUTwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjIUTvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:51:47 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C061481D;
        Thu, 21 Sep 2023 12:42:27 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 32ABE1BF203;
        Thu, 21 Sep 2023 19:42:22 +0000 (UTC)
From:   Ilya Maximets <i.maximets@ovn.org>
To:     netdev@vger.kernel.org
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
        Eelco Chaudron <echaudro@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next v2] openvswitch: reduce stack usage in do_execute_actions
Date:   Thu, 21 Sep 2023 21:42:35 +0200
Message-ID: <20230921194314.1976605-1-i.maximets@ovn.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: i.maximets@ovn.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_execute_actions() function can be called recursively multiple
times while executing actions that require pipeline forking or
recirculations.  It may also be re-entered multiple times if the packet
leaves openvswitch module and re-enters it through a different port.

Currently, there is a 256-byte array allocated on stack in this
function that is supposed to hold NSH header.  Compilers tend to
pre-allocate that space right at the beginning of the function:

     a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp

NSH is not a very common protocol, but the space is allocated on every
recursive call or re-entry multiplying the wasted stack space.

Move the stack allocation to push_nsh() function that is only used
if NSH actions are actually present.  push_nsh() is also a simple
function without a possibility for re-entry, so the stack is returned
right away.

With this change the preallocated space is reduced by 256 B per call:

     b18:       48 81 ec b0 00 00 00    sub    $0xb0,%rsp

Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
---

Version 2:
  - Added 'noinline_for_stack' to avoid potential inlining. [Eric]

 net/openvswitch/actions.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 5f8094acd056..6fcd7e2ca81f 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -311,11 +311,18 @@ static int push_eth(struct sk_buff *skb, struct sw_flow_key *key,
 	return 0;
 }
 
-static int push_nsh(struct sk_buff *skb, struct sw_flow_key *key,
-		    const struct nshhdr *nh)
+static noinline_for_stack int push_nsh(struct sk_buff *skb,
+				       struct sw_flow_key *key,
+				       const struct nlattr *a)
 {
+	u8 buffer[NSH_HDR_MAX_LEN];
+	struct nshhdr *nh = (struct nshhdr *)buffer;
 	int err;
 
+	err = nsh_hdr_from_nlattr(a, nh, NSH_HDR_MAX_LEN);
+	if (err)
+		return err;
+
 	err = nsh_push(skb, nh);
 	if (err)
 		return err;
@@ -1439,17 +1446,9 @@ static int do_execute_actions(struct datapath *dp, struct sk_buff *skb,
 			err = pop_eth(skb, key);
 			break;
 
-		case OVS_ACTION_ATTR_PUSH_NSH: {
-			u8 buffer[NSH_HDR_MAX_LEN];
-			struct nshhdr *nh = (struct nshhdr *)buffer;
-
-			err = nsh_hdr_from_nlattr(nla_data(a), nh,
-						  NSH_HDR_MAX_LEN);
-			if (unlikely(err))
-				break;
-			err = push_nsh(skb, key, nh);
+		case OVS_ACTION_ATTR_PUSH_NSH:
+			err = push_nsh(skb, key, nla_data(a));
 			break;
-		}
 
 		case OVS_ACTION_ATTR_POP_NSH:
 			err = pop_nsh(skb, key);
-- 
2.41.0

