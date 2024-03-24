Return-Path: <linux-kernel+bounces-113361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0776D8883B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C761C2315F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C54A19C3D0;
	Sun, 24 Mar 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK6c9G6Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B419C3B4;
	Sun, 24 Mar 2024 22:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320162; cv=none; b=rPFpnWBqCuUSPAgkAPk4R+n9Q8ewpwD4D6Ta7G9ebrIerU62rHwYIFmf6sFa5hAewmgK7j1NqVY8ep4LD9+IPyrwlg2f+DdisbvhJt5TWpN9OBQS3N9qzjFddmCCDPg7SLi76DSVWZAyXtCgZgqFh6rYa/EEE/Qx3oyile4uyTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320162; c=relaxed/simple;
	bh=6U5Xrb0s90JnDdGWdSIaci7y6uJqRFUxnTGE2SLegaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkG0UHLF5UBemOqZG3PhTtg4DAP7OGk96QX9IduT8tQKY1h1jHfXJ9V+iiWUAVOaNriMMSlK/kEQe0K73VanPEy8xlkQi1pWCQVUQzx1C+DSfV7RfWqwZlDBLBnZkGsBCotGmR6phRHlBqumojwnWbFU/67JuX3Xatcfv3+7xNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK6c9G6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F91C433F1;
	Sun, 24 Mar 2024 22:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320162;
	bh=6U5Xrb0s90JnDdGWdSIaci7y6uJqRFUxnTGE2SLegaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LK6c9G6ZVbRpr/KVN9gnXAegT/1Nd+k/45uVcECyIKSur2F7vJqYRtWyVCOLkokIs
	 DvKvEb7oj1ifqXUlOp7faDu3sghJ12KATcC5EAFcG6bRwLc/w6a19DgOuB3qPyWBu8
	 vW7/vDsRGRG17OqcrpgiU4qNSQfm1BRxufJ2yxiU0BXyr9wOPF2axYIL0jE3pFt3Xs
	 MTGaGL5FVfIkhC1ctOCnWfBSqBNGs+M3ueBMzYenNIR3Q7LVZKYdL3GAkGYQyhyuzj
	 iw4z84qiOrBhtAe79eR3hAnTNCRGjgOUiVy/HyvInRdtqoCm1FTt1NTWdc5KAnQSSI
	 j382ZVhmy5dbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 470/715] crypto: qat - remove double initialization of value
Date: Sun, 24 Mar 2024 18:30:49 -0400
Message-ID: <20240324223455.1342824-471-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


