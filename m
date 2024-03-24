Return-Path: <linux-kernel+bounces-113884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D107F88871A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:51:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71B75B23B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD0C720CDEF;
	Sun, 24 Mar 2024 23:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoEKy7bI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5651EBD5D;
	Sun, 24 Mar 2024 22:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320939; cv=none; b=Fj3F7kgcQg5x6CLV2isEgngAtasHZvJNTGPGxRXCA1GmYai/acEpuK37mQwQ5Eii1UK15OCKtndkkODfBXMcJjDUIVLSQC8P/Is8JEmrvvSVfI0Afv4540RK58U5TpII+R3zBKK9BzD5EZgx7PstpGYbitH4GZttL2RScbZ0i1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320939; c=relaxed/simple;
	bh=6U5Xrb0s90JnDdGWdSIaci7y6uJqRFUxnTGE2SLegaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQraTSrIgBDyB/zWuKiHvYs8D0OPBwJIwyhw9okcmajVU4x90jp96Mf+LHmGJY+r2/Qhxuwh1a0gxSnaUFxOUfbzpZFARPWsIP+7e+Kp0XbZb5HIUTNeORGTM3MyUvHIFe4IiBHJtMocJpnettpPfj++8lC0w5fJt7lkeg1/K+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoEKy7bI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40B2EC43394;
	Sun, 24 Mar 2024 22:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320938;
	bh=6U5Xrb0s90JnDdGWdSIaci7y6uJqRFUxnTGE2SLegaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoEKy7bIguMww0TvqT11sHrN1uvBPGDWZUT1magQ8P7NkbeFyj95WPHoZhI8VlqYr
	 xq/4YnEp4nrt1x4T9iVR9pkwH5Fy60FzchtBJxxKTfOZlO07eTEShCJovYQEpdNEEM
	 G7oF9uhJsmrpfqGFSbUQO/tFo5cuaGepLHd4CjIrIHlhXiJCapi+eg081DpEgFAAiZ
	 9HJV1hdQZW/nlE2BD5gsTlZkdhwnZ/GUCChkBdjegSKr4v7//TL/nubumQOSwTc9Zp
	 q+JI8LTDsZZzvqLsW0HOaYSo2SftG/nUY2wQUtaL+7cEhMucXs+yg2BLKRULHN2Bxo
	 mL80FXj06Mfww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 501/713] crypto: qat - remove double initialization of value
Date: Sun, 24 Mar 2024 18:43:47 -0400
Message-ID: <20240324224720.1345309-502-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Adam Guerin <adam.guerin@intel.com>

[ Upstream commit a66cf93ab33853f17b8cc33a99263dd0a383a1a1 ]

Remove double initialization of the reg variable.

This is to fix the following warning when compiling the QAT driver
using clang scan-build:
    drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c:1010:6: warning: Value stored to 'reg' during its initialization is never read [deadcode.DeadStores]
     1010 |         u32 reg = ADF_CSR_RD(csr, ADF_GEN4_SSMCPPERR);
          |             ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c:1109:6: warning: Value stored to 'reg' during its initialization is never read [deadcode.DeadStores]
     1109 |         u32 reg = ADF_CSR_RD(csr, ADF_GEN4_SER_ERR_SSMSH);
          |             ^~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 99b1c9826e48 ("crypto: qat - count QAT GEN4 errors")
Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
index 048c246079390..2dd3772bf58a6 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_ras.c
@@ -1007,8 +1007,7 @@ static bool adf_handle_spppar_err(struct adf_accel_dev *accel_dev,
 static bool adf_handle_ssmcpppar_err(struct adf_accel_dev *accel_dev,
 				     void __iomem *csr, u32 iastatssm)
 {
-	u32 reg = ADF_CSR_RD(csr, ADF_GEN4_SSMCPPERR);
-	u32 bits_num = BITS_PER_REG(reg);
+	u32 reg, bits_num = BITS_PER_REG(reg);
 	bool reset_required = false;
 	unsigned long errs_bits;
 	u32 bit_iterator;
@@ -1106,8 +1105,7 @@ static bool adf_handle_rf_parr_err(struct adf_accel_dev *accel_dev,
 static bool adf_handle_ser_err_ssmsh(struct adf_accel_dev *accel_dev,
 				     void __iomem *csr, u32 iastatssm)
 {
-	u32 reg = ADF_CSR_RD(csr, ADF_GEN4_SER_ERR_SSMSH);
-	u32 bits_num = BITS_PER_REG(reg);
+	u32 reg, bits_num = BITS_PER_REG(reg);
 	bool reset_required = false;
 	unsigned long errs_bits;
 	u32 bit_iterator;
-- 
2.43.0


