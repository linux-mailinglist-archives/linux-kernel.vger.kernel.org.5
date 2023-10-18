Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB57CDF2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345048AbjJRORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344901AbjJROR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:17:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7815386A;
        Wed, 18 Oct 2023 07:14:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6467BC433CB;
        Wed, 18 Oct 2023 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638477;
        bh=+qvG0XTru+KrTr6le1sTm/1/16/rrY7hNUFgaFoouRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hDOEm6l8ITMRO6ltHLEQ6bFRDrWUKQcyR1SSENvV6Y5BMrgjU38rk2MAkJ0j5CXd0
         vSkpsrIf0h8gvuVsdgZJ98cwymRmnRWfVB6dnQjNwt80wTii321ItGmzbEJVdS15OT
         JBInhsMGbRPGMFKnFvJxB68L0jbjMJxvMmeLMt7u0hkyOHPYiwO522Cj+8WQaBrua/
         xE0fFxtoyODr8vLp5QBmN/TltDzq8xeXN2QJ2ad/ghvU5QcHpjeVNCQ3jgKl1Rebec
         /qoc3au3q0Gsk3Zw6qSqrhipYQl/xXxet9UKAE/MsSAGl274YhHt8OpY2NNObxxMwG
         sHre/RClHFE9g==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/14] net: macsec: indicate next pn update when offloading
Date:   Wed, 18 Oct 2023 10:14:10 -0400
Message-Id: <20231018141416.1335165-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141416.1335165-1-sashal@kernel.org>
References: <20231018141416.1335165-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.135
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
index 21f41f25a8abe..07c822c301185 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -2410,6 +2410,7 @@ static int macsec_upd_txsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.tx_sa = tx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_txsa, &ctx);
@@ -2503,6 +2504,7 @@ static int macsec_upd_rxsa(struct sk_buff *skb, struct genl_info *info)
 
 		ctx.sa.assoc_num = assoc_num;
 		ctx.sa.rx_sa = rx_sa;
+		ctx.sa.update_pn = !!prev_pn.full64;
 		ctx.secy = secy;
 
 		ret = macsec_offload(ops->mdo_upd_rxsa, &ctx);
diff --git a/include/net/macsec.h b/include/net/macsec.h
index d6fa6b97f6efa..0dc4303329391 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -240,6 +240,7 @@ struct macsec_context {
 	struct macsec_secy *secy;
 	struct macsec_rx_sc *rx_sc;
 	struct {
+		bool update_pn;
 		unsigned char assoc_num;
 		u8 key[MACSEC_MAX_KEY_LEN];
 		union {
-- 
2.40.1

