Return-Path: <linux-kernel+bounces-26715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D52482E582
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DFAAB233EC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A911BC2D;
	Tue, 16 Jan 2024 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k85Qk/Wd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621EA1B968;
	Tue, 16 Jan 2024 00:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B471C433F1;
	Tue, 16 Jan 2024 00:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364620;
	bh=uWnWtrqieC9Vvspv3brBuB+s8l8BstgLh0mqhN/S4Us=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k85Qk/WdeCAtfMQur0RkpPaLM9Psx53Oyk1yfyLyhLAn+479LzAmnxTdWdOEFrXGb
	 uEnTYd2ieVudDubQcvxy2+ruxbc/qtF3v1fE2S5AzDfGwAV9mH5iDLfBV+fP0ND1FX
	 JoLPCQ3Z8acJVzn1jrOOLQLZauqrrOkeKpgg84YLNztdcC0mE4sSK0ZExRKIwvGREL
	 b6gbyd7JBDmMPXESLjP2FfuKABMNprnyNVSFFcmsToK9puNV4zXYqINifeEDhxyDQJ
	 EW8YUqgdnHclXZBk/p/r2GBX0m9+f6IviwMYGvyYVIQYmngo4D7zGTkks5JP+UaMVR
	 OqKKdMbnHxZkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>,
	bbrezillon@kernel.org,
	arno@natisbad.org,
	schalla@marvell.com,
	davem@davemloft.net,
	ndabilpuram@marvell.com,
	alobakin@pm.me,
	masahiroy@kernel.org,
	tj@kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 12/19] crypto: octeontx2 - Fix cptvf driver cleanup
Date: Mon, 15 Jan 2024 19:22:48 -0500
Message-ID: <20240116002311.214705-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002311.214705-1-sashal@kernel.org>
References: <20240116002311.214705-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Bharat Bhushan <bbhushan2@marvell.com>

[ Upstream commit c480a421a4faf693c38e60b0fe6e554c9a3fee02 ]

This patch fixes following cleanup issues:
 - Missing instruction queue free on cleanup. This
   will lead to memory leak.
 - lfs->lfs_num is set to zero before cleanup, which
   will lead to improper cleanup.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/marvell/octeontx2/otx2_cptlf.c      | 6 ++++--
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
index 6edd27ff8c4e..e4bd3f030cec 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptlf.c
@@ -419,8 +419,8 @@ int otx2_cptlf_init(struct otx2_cptlfs_info *lfs, u8 eng_grp_mask, int pri,
 	return 0;
 
 free_iq:
-	otx2_cpt_free_instruction_queues(lfs);
 	cptlf_hw_cleanup(lfs);
+	otx2_cpt_free_instruction_queues(lfs);
 detach_rsrcs:
 	otx2_cpt_detach_rsrcs_msg(lfs);
 clear_lfs_num:
@@ -431,11 +431,13 @@ EXPORT_SYMBOL_NS_GPL(otx2_cptlf_init, CRYPTO_DEV_OCTEONTX2_CPT);
 
 void otx2_cptlf_shutdown(struct otx2_cptlfs_info *lfs)
 {
-	lfs->lfs_num = 0;
 	/* Cleanup LFs hardware side */
 	cptlf_hw_cleanup(lfs);
+	/* Free instruction queues */
+	otx2_cpt_free_instruction_queues(lfs);
 	/* Send request to detach LFs */
 	otx2_cpt_detach_rsrcs_msg(lfs);
+	lfs->lfs_num = 0;
 }
 EXPORT_SYMBOL_NS_GPL(otx2_cptlf_shutdown, CRYPTO_DEV_OCTEONTX2_CPT);
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index bac729c885f9..215a1b17b6ce 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -249,8 +249,11 @@ static void cptvf_lf_shutdown(struct otx2_cptlfs_info *lfs)
 	otx2_cptlf_unregister_interrupts(lfs);
 	/* Cleanup LFs software side */
 	lf_sw_cleanup(lfs);
+	/* Free instruction queues */
+	otx2_cpt_free_instruction_queues(lfs);
 	/* Send request to detach LFs */
 	otx2_cpt_detach_rsrcs_msg(lfs);
+	lfs->lfs_num = 0;
 }
 
 static int cptvf_lf_init(struct otx2_cptvf_dev *cptvf)
-- 
2.43.0


