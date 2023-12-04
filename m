Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79A0C80402B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345744AbjLDUjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235535AbjLDUjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:39:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4112F26B9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:36:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B74FC433CB;
        Mon,  4 Dec 2023 20:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722193;
        bh=5aaVddaxnZ8/nE7jtW/8lqmeta3wu189jxHfWgQbNzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGFqefgP9MKZ83rtRL0dtF64fgNPtHm1OGFbVwUkkNbUFRN46SBMYbov1210SZOuQ
         1X5s1sOLq3ZWa708xJjlSEGBs/jGasijqdIBRvX7RPVKZJMnANND8zzUxLOkrVuOhE
         he9aFlKBa/gRfjus0Iks048ex3V9+XejS+rAjIDYVMzGQBu3NmLZrpKPbYvhMjcq6/
         2NFs1zbJiS/l6dJwRtN7RhR7V/CatSqG9CTwihSHEfP8w9Tz6bZkZkzUeRi0q+r9yO
         ohigYDBABLy1R6Z+AKBec5UkFYm3qG2SceduVH6oM2OxF+DTc2Y88ffzJtaxWVjTcc
         /Q6kB4tGCSbhQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Edward Adam Davis <eadavis@qq.com>,
        syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, matttbe@kernel.org,
        martineau@kernel.org, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: [PATCH AUTOSEL 5.15 04/10] mptcp: fix uninit-value in mptcp_incoming_options
Date:   Mon,  4 Dec 2023 15:36:01 -0500
Message-ID: <20231204203616.2094529-4-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203616.2094529-1-sashal@kernel.org>
References: <20231204203616.2094529-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.141
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 237ff253f2d4f6307b7b20434d7cbcc67693298b ]

Added initialization use_ack to mptcp_parse_option().

Reported-by: syzbot+b834a6b2decad004cfa1@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mptcp/options.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index aa4b0cf7c6380..012e0e352276f 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -103,6 +103,7 @@ static void mptcp_parse_option(const struct sk_buff *skb,
 			mp_opt->suboptions |= OPTION_MPTCP_DSS;
 			mp_opt->use_map = 1;
 			mp_opt->mpc_map = 1;
+			mp_opt->use_ack = 0;
 			mp_opt->data_len = get_unaligned_be16(ptr);
 			ptr += 2;
 		}
-- 
2.42.0

