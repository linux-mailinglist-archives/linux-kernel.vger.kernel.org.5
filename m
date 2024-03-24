Return-Path: <linux-kernel+bounces-114686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E69888BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC71F27CEB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4DE239478;
	Sun, 24 Mar 2024 23:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA8LKDWN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D4D23A764;
	Sun, 24 Mar 2024 23:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322349; cv=none; b=IL1OZGixAxxXL9eYdjt4BGxDGfjmbaCAnmOIxvZ9XfdBIX1PJqHtG2lxUhIvFIb+Er6BMjkBsSoScy5hBeLqRegbtLYJ4KslPrPFsKxyxcOwMDqQprv4xMGm6uoZESAWmghmprPEtJMxyC83/QYATlpRbpeU9DelHa9WigxH798=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322349; c=relaxed/simple;
	bh=yL2hvudX4plorCm7akPwfZ0zBhqLhXo5nsRHPp4CSaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UPg61xn+Yc9mZ+GMXH2XgZglSRUGdK2jEzJhwLwEJVZizg0BcibiRLTn9PTssl8pR2BKHcrUQVnAGW0lBDsvpefe6NHf5/Stsp9ZcHm80NStvM/c6cIJg3Z02LLeDiqGprrGEkffLoHwO8iiyUjONo6ikpeRqWYpYou90zVPiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA8LKDWN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8510AC43330;
	Sun, 24 Mar 2024 23:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322348;
	bh=yL2hvudX4plorCm7akPwfZ0zBhqLhXo5nsRHPp4CSaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YA8LKDWNXITiQwWsKe07a/RdEa/LY2ldbzboPL+bVlIg5EjWmCO+60QcKV7R9P7a5
	 xjsTi/H16DT2XO8mrioTNfNGFoeTIXc8XCXk84UbPO/MEZX72sUKyj9MQ7hiATpjMj
	 VlqGM1TtD0bbn3GWENSGc4peXd6r9xQ0oJJfIr3aImJyNP+GyTqBi/HVKhs3BzqbGa
	 JthbD9xE64mIACjjLA7RayZWfL6oKGz9Hu8QcVE0qQsucXWQ6+nHN4mlGgdshMDhTN
	 t8hpthiKPHbs1qa1vBpPBfil7+lJxkcWaMiCCGloB4tpKRSB+1I252Dk0pf0RvgvFl
	 rb6rJdpdxNudA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srujana Challa <schalla@marvell.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 430/451] octeontx2-af: optimize cpt pf identification
Date: Sun, 24 Mar 2024 19:11:46 -0400
Message-ID: <20240324231207.1351418-431-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Srujana Challa <schalla@marvell.com>

[ Upstream commit 9adb04ff62f51265002c2c83e718bcf459e06e48 ]

Optimize CPT PF identification in mbox handling for faster
mbox response by doing it at AF driver probe instead of
every mbox message.

Signed-off-by: Srujana Challa <schalla@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a88e0f936ba9 ("octeontx2: Detect the mbox up or down message via register")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu.c     |  8 ++++++++
 drivers/net/ethernet/marvell/octeontx2/af/rvu.h     |  2 ++
 drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c | 13 ++++++++++---
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index d88d86bf07b03..8f5b7d14e3f7c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -1164,8 +1164,16 @@ static int rvu_setup_hw_resources(struct rvu *rvu)
 		goto nix_err;
 	}
 
+	err = rvu_cpt_init(rvu);
+	if (err) {
+		dev_err(rvu->dev, "%s: Failed to initialize cpt\n", __func__);
+		goto mcs_err;
+	}
+
 	return 0;
 
+mcs_err:
+	rvu_mcs_exit(rvu);
 nix_err:
 	rvu_nix_freemem(rvu);
 npa_err:
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index 0b76dfa979d4e..e1760f9298b17 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -506,6 +506,7 @@ struct rvu {
 	struct ptp		*ptp;
 
 	int			mcs_blk_cnt;
+	int			cpt_pf_num;
 
 #ifdef CONFIG_DEBUG_FS
 	struct rvu_debugfs	rvu_dbg;
@@ -872,6 +873,7 @@ void rvu_cpt_unregister_interrupts(struct rvu *rvu);
 int rvu_cpt_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int lf,
 			int slot);
 int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc);
+int rvu_cpt_init(struct rvu *rvu);
 
 #define NDC_AF_BANK_MASK       GENMASK_ULL(7, 0)
 #define NDC_AF_BANK_LINE_MASK  GENMASK_ULL(31, 16)
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
index 1cd34914cb86b..923af460db296 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_cpt.c
@@ -340,7 +340,7 @@ static int get_cpt_pf_num(struct rvu *rvu)
 
 static bool is_cpt_pf(struct rvu *rvu, u16 pcifunc)
 {
-	int cpt_pf_num = get_cpt_pf_num(rvu);
+	int cpt_pf_num = rvu->cpt_pf_num;
 
 	if (rvu_get_pf(pcifunc) != cpt_pf_num)
 		return false;
@@ -352,7 +352,7 @@ static bool is_cpt_pf(struct rvu *rvu, u16 pcifunc)
 
 static bool is_cpt_vf(struct rvu *rvu, u16 pcifunc)
 {
-	int cpt_pf_num = get_cpt_pf_num(rvu);
+	int cpt_pf_num = rvu->cpt_pf_num;
 
 	if (rvu_get_pf(pcifunc) != cpt_pf_num)
 		return false;
@@ -1023,7 +1023,7 @@ int rvu_cpt_lf_teardown(struct rvu *rvu, u16 pcifunc, int blkaddr, int lf, int s
 static int cpt_inline_inb_lf_cmd_send(struct rvu *rvu, int blkaddr,
 				      int nix_blkaddr)
 {
-	int cpt_pf_num = get_cpt_pf_num(rvu);
+	int cpt_pf_num = rvu->cpt_pf_num;
 	struct cpt_inst_lmtst_req *req;
 	dma_addr_t res_daddr;
 	int timeout = 3000;
@@ -1167,3 +1167,10 @@ int rvu_cpt_ctx_flush(struct rvu *rvu, u16 pcifunc)
 
 	return 0;
 }
+
+int rvu_cpt_init(struct rvu *rvu)
+{
+	/* Retrieve CPT PF number */
+	rvu->cpt_pf_num = get_cpt_pf_num(rvu);
+	return 0;
+}
-- 
2.43.0


