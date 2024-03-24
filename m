Return-Path: <linux-kernel+bounces-113870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9357A88870A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48471C26270
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C16152169;
	Sun, 24 Mar 2024 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/Ijg3//"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08312AAE2;
	Sun, 24 Mar 2024 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320940; cv=none; b=WOOlPrGnWD1D8T0n3pz6uhWsAzddXG3j7Vrkar6oUi1XW8/9izgTm7jE+n1rFhIzOlAEZYjCXE5beacp0MTgdd4NNm3nEszZoYOW2pkojETNK/CcfIH8rS+H3NcNwZPjgEEGgNdi32aki9C8Pdmv8EcRDgLAotbNfpjW5+qfB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320940; c=relaxed/simple;
	bh=SK+PLDMOyoD3aBAgoKmN5QhdMdDgTyOmf/l3ra9AFnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+gJXjjgVXeLh3viOi03yB51pABjxVKw67OnFbh20QbpU1koEx2QbIRoZqK8NvHy+6JehksfGX49wmrK/e7kzrTRNyF2sTPovywggKlQoycEO+7dZXSYFehnZFykmpIi063fvnQJaLrbkoP43wozAXiARMkQWxVcDBDekvjP2Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/Ijg3//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC99C433C7;
	Sun, 24 Mar 2024 22:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320940;
	bh=SK+PLDMOyoD3aBAgoKmN5QhdMdDgTyOmf/l3ra9AFnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l/Ijg3//1e2bIPO7UYm4YSFneUHZrVE2pZby/nObBB6Z80Bo5nQ/mYTlUNoT+VGPE
	 EKnurYSmAC74nNG+w4Vpm2rMkELwbWQwwM/65ElhWmTf/xyrbiCcESlcuz/Ecr7asG
	 ZkZUMvcRpLOyvnTLwGadhoPQpiu95zNZDnlb6jZWye/RymyavqmgaXOqJpzGm7u6Jo
	 tpWz+0sQ53KQGQKQ+yzLi7z9mnrc5LR1eF18PgYBux/LwRxSLUIpFXBRMNIqyBCWV5
	 XSaRbAP+KuoUNio7FdHI5YXTKO0ElwD1kMyKzq16fz63FQMUtEjuYSnfgNPmjLaP6D
	 ofg+YQ5fSwoHw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damian Muszynski <damian.muszynski@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 503/713] crypto: qat - fix ring to service map for dcc in 4xxx
Date: Sun, 24 Mar 2024 18:43:49 -0400
Message-ID: <20240324224720.1345309-504-sashal@kernel.org>
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

From: Damian Muszynski <damian.muszynski@intel.com>

[ Upstream commit df018f82002a8b4dc407bc9a6f416b9241d14415 ]

If a device is configured for data compression chaining (dcc), half of the
engines are loaded with the symmetric crypto image and the rest are loaded
with the compression image.
However, in such configuration all rings can handle compression requests.

Fix the ring to service mapping so that when a device is configured for
dcc, the ring to service mapping reports that all rings in a bank can
be used for compression.

Fixes: a238487f7965 ("crypto: qat - fix ring to service map for QAT GEN4")
Signed-off-by: Damian Muszynski <damian.muszynski@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
index 9763402cd486b..b64aaecdd98ba 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -437,6 +437,13 @@ static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
 	if (!fw_config)
 		return 0;
 
+	/* If dcc, all rings handle compression requests */
+	if (adf_get_service_enabled(accel_dev) == SVC_DCC) {
+		for (i = 0; i < RP_GROUP_COUNT; i++)
+			rps[i] = COMP;
+		goto set_mask;
+	}
+
 	for (i = 0; i < RP_GROUP_COUNT; i++) {
 		switch (fw_config[i].ae_mask) {
 		case ADF_AE_GROUP_0:
@@ -465,6 +472,7 @@ static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
 		}
 	}
 
+set_mask:
 	ring_to_svc_map = rps[RP_GROUP_0] << ADF_CFG_SERV_RING_PAIR_0_SHIFT |
 			  rps[RP_GROUP_1] << ADF_CFG_SERV_RING_PAIR_1_SHIFT |
 			  rps[RP_GROUP_0] << ADF_CFG_SERV_RING_PAIR_2_SHIFT |
-- 
2.43.0


