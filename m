Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C16D7CDF84
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjJROYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345580AbjJROYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:24:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872C32718;
        Wed, 18 Oct 2023 07:13:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA27C43397;
        Wed, 18 Oct 2023 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638438;
        bh=dof2p00H8SGYhoK5E/UwLs4l9o+cUpC9HGlfL9HmobA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKIXim2ZPJ/RZW/iijWx4o+0glJOsjb/KbTNT+687/XyNw7pq5/usisah2pdu+Efm
         l/rxzj1wJJcwZtxOGucR8vEixqla0nRx76dnOsnIMBdG0n8M63F4EuhMrjAz1kDriy
         QfrBtPjW8isfV8yElFmGxMq160O5dszAHImm+lSVF4taCSBQf9bYfEUVSrMa/jLqmm
         nSHTHd7IDbR1v2UXoO9KYee95D+oz7jn5C8K0TgMe0OOugKXUBriPP00GezjDRwxZR
         f0DWP6iKxFmy8Ch3i3ZARczmS56GJgc18hAbIVknh7MmZwUhEfj4t1OZnyLlN4zopj
         DAYpn91SaO5DA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 15/19] net: macsec: indicate next pn update when offloading
Date:   Wed, 18 Oct 2023 10:13:17 -0400
Message-Id: <20231018141323.1334898-15-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141323.1334898-1-sashal@kernel.org>
References: <20231018141323.1334898-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.58
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>

[ Upstream commit 0412cc846a1ef38697c3f321f9b174da91ecd3b5 ]

Indicate next PN update using update_pn flag in macsec_context.
Offloaded MACsec implementations does not know whether or not the
MACSEC_SA_ATTR_PN attribute was passed for an SA update and assume
that next PN should always updated, but this is not always true.

The PN can be reset to its initial value using the following command:
$ ip macsec set macsec0 tx sa 0 off #octeontx2-pf case

Or, the update PN command will succeed even if the driver does not support
PN updates.
$ ip macsec set macsec0 tx sa 0 pn 1 on #mscc phy driver case

Comparing the initial PN with the new PN value is not a solution. When
the user updates the PN using its initial value the command will
succeed, even if the driver does not support it. Like this:
$ ip macsec add macsec0 tx sa 0 pn 1 on key 00 \
ead3664f508eb06c40ac7104cdae4ce5
$ ip macsec set macsec0 tx sa 0 pn 1 on #mlx5 case

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/macsec.c | 2 ++
 include/net/macsec.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 578f470e9fad9..81453e84b6413 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2384,6 +2384,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2477,6 +2478,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/include/net/macsec.h b/include/net/macsec.h
index 5b9c61c4d3a62..65c93959c2dc5 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -257,6 +257,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
-- 
2.40.1

