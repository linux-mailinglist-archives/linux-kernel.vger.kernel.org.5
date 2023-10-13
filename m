Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2117C7E55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjJMHF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjJMHF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:05:27 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C5FC5B7;
        Fri, 13 Oct 2023 00:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=frMwB
        +yQcrqfw7+mUC1RLpFWBfRdjTmzx1BGRb9nPkY=; b=bgcKwGfHHQLttJDR/zMLu
        yNDKelR5y7v871iubA92RBIKiOGPXIx2bs5JZcWRTJLe1NANMVqZXPh7HiFJ7AQo
        CNTJHEsYpvnCmyWhHsIaaeGFw7oBGh8BFTH5/bqD95iE+A4nm/b3/imnEO9W2WmK
        sZeR1GX1E1p6kIW6BZiqvs=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wD3_9Dr6yhlQ_y2AQ--.20479S4;
        Fri, 13 Oct 2023 15:04:20 +0800 (CST)
From:   Ma Ke <make_ruc2021@163.com>
To:     jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] tipc: Fix uninit-value access in tipc_nl_node_get_link()
Date:   Fri, 13 Oct 2023 15:04:08 +0800
Message-Id: <20231013070408.1979343-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3_9Dr6yhlQ_y2AQ--.20479S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr4rCw4ktrW5WFyxJFW8WFg_yoWfJFX_Z3
        92g3yfAry8J39Yyr4DXa95JrZ3Jan8G3Z5uw1akryUK34DCrWrZan5JFn8CrW3urZ7u3sr
        Ga40vF1fXF12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMg4SUUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbivggIC1ZcjGryowAAsI
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Names must be null-terminated strings. If a name which is not 
null-terminated is passed through netlink, strstr() and similar 
functions can cause buffer overrun. This patch fixes this issue 
by returning -EINVAL if a non-null-terminated name is passed.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 net/tipc/node.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index 3105abe97bb9..a02bcd7e07d3 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2519,6 +2519,9 @@ int tipc_nl_node_get_link(struct sk_buff *skb, struct genl_info *info)
 		return -EINVAL;
 
 	name = nla_data(attrs[TIPC_NLA_LINK_NAME]);
+	if (name[strnlen(name,
+			 nla_len(attrs[TIPC_NLA_LINK_NAME]))] != '\0')
+		return -EINVAL;
 
 	msg.skb = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
 	if (!msg.skb)
-- 
2.37.2

