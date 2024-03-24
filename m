Return-Path: <linux-kernel+bounces-113362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7D58883B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:18:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DD11C23075
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC6319CAC3;
	Sun, 24 Mar 2024 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDMqmxLi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8578C19C3D5;
	Sun, 24 Mar 2024 22:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320163; cv=none; b=GhRcvnFXjzQyQ/viKaJ++FD6W+oFw5n8RT0BgAmfxBx378tNbp+VeNr6BCg16a5SwQpra+Q3BCiz16mr+aXNkpvc6ovkOrvJAFgvQooflX1rSufc26hca8Ln+BHw2/ne7AEz44R3ZNNRY452z001+BYxVYCrTGBpuXyX4IlYdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320163; c=relaxed/simple;
	bh=4oJ854NlLxpw6GGC2faTFne/mnmaH0Ek75Xm2V29Cs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPjSAfbS8UtN5gHf1sYfgnwGQtywBkihfVfIIFBzNjrX/Hu/aFhsLT2rD3xHnYk56HmmOWph/rcDCLNP3NlcqTf7LloOxXXmaaKM+KPFk4Ovn6WL306anGZRraIeKcVqzwPve9HPxi10128BW6bX5iNt88x1d7kl0jnh2tpXW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDMqmxLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBADC43394;
	Sun, 24 Mar 2024 22:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320163;
	bh=4oJ854NlLxpw6GGC2faTFne/mnmaH0Ek75Xm2V29Cs8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDMqmxLiAB8Y6zHWFraezJSDRQgabG8tEJx4MOfovW13JnLJPBX106NnYYj0TqArb
	 8wXs8jQy6Q/4nEquAeaLQqiIc+Bh5kKiPVMNz4xX2Q8a2z+IUGElxHnu9YRh9ROxgi
	 aneALNDFl4Ibhwt7hW7Vvfx5AzJeW0Kxe+oCCZej8KHrl5n9g9FdW7sVefWz0nvCrj
	 fYlosO/m37xD7tedyxu6JU6krWr8wrNvY7T1Yj0GvcHSd1tvjE4TWawqfTSDe/TwBo
	 aKxJ2Na6ex65ZGRa+dxI3VHY1n/kqMLBp9FnAjsqbZrINaGrQSJNHjN1HtNGp2aUwd
	 9kFzYPyzR0kvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damian Muszynski <damian.muszynski@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 471/715] crypto: qat - fix ring to service map for dcc in 4xxx
Date: Sun, 24 Mar 2024 18:30:50 -0400
Message-ID: <20240324223455.1342824-472-sashal@kernel.org>
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
index 94a0ebb03d8c9..e171cddf6f025 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -331,6 +331,13 @@ static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
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
@@ -359,6 +366,7 @@ static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
 		}
 	}
 
+set_mask:
 	ring_to_svc_map = rps[RP_GROUP_0] << ADF_CFG_SERV_RING_PAIR_0_SHIFT |
 			  rps[RP_GROUP_1] << ADF_CFG_SERV_RING_PAIR_1_SHIFT |
 			  rps[RP_GROUP_0] << ADF_CFG_SERV_RING_PAIR_2_SHIFT |
-- 
2.43.0


