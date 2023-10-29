Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7A7DB049
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjJ2XE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjJ2XEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:04:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05C27EDF;
        Sun, 29 Oct 2023 16:02:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E4C6C433AB;
        Sun, 29 Oct 2023 23:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620543;
        bh=4/C17ww5DjA3eWjC0vh6NWIdEDDn79fbftPuDSQdUzE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YZosUkxcBAn2tN0i2E5bMxUtpukL+On8blUdvweylqhKxtg4gRWjsKFtJ7JQzkuQI
         WWIZKfCPREAjAOCXjSc+4XEfRB0p5M8ndtR0ZcmoW1457+BY2jK/DctWpAAYs6Yf45
         rLoHaODWcj1MAOklJGT0mURCygJn78k0FoWbjE/HylLyX6cQJ0dp4LxrE5NvvojeMy
         YcqpgIdKisSRmft8hE1d5w/zNrJeABmsc6tOonb6qQO4vc/tPSNVd1oRTYPPwNMVW/
         qA4uqfz15k8ehuR+UVW1hL3tMOw+/0eox6lyaCUa+yY494MTbxRXdGm5tWND3KElsp
         cBs80Mb0pKzpA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>, kernel test robot <lkp@intel.com>,
        Sasha Levin <sashal@kernel.org>, pablo@netfilter.org,
        kadlec@netfilter.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 05/11] netfilter: nfnetlink_log: silence bogus compiler warning
Date:   Sun, 29 Oct 2023 19:01:56 -0400
Message-ID: <20231029230213.793581-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029230213.793581-1-sashal@kernel.org>
References: <20231029230213.793581-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 2e1d175410972285333193837a4250a74cd472e6 ]

net/netfilter/nfnetlink_log.c:800:18: warning: variable 'ctinfo' is uninitialized

The warning is bogus, the variable is only used if ct is non-NULL and
always initialised in that case.  Init to 0 too to silence this.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202309100514.ndBFebXN-lkp@intel.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nfnetlink_log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 40ba9c8e3c078..7d7a94e3fc507 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -637,8 +637,8 @@ nfulnl_log_packet(struct net *net,
 	unsigned int plen;
 	struct nfnl_log_net *log = nfnl_log_pernet(net);
 	const struct nfnl_ct_hook *nfnl_ct = NULL;
+	enum ip_conntrack_info ctinfo = 0;
 	struct nf_conn *ct = NULL;
-	enum ip_conntrack_info ctinfo;
 
 	if (li_user && li_user->type == NF_LOG_TYPE_ULOG)
 		li = li_user;
-- 
2.42.0

