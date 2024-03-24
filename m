Return-Path: <linux-kernel+bounces-114339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D1F888A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5339CB22ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B697F170EB0;
	Sun, 24 Mar 2024 23:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZV2cLOs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259781ED71B;
	Sun, 24 Mar 2024 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321722; cv=none; b=WOVP44kKl/lG51QpY9/xXHEnjqw0o61mEuCp9vqTlhb+37c2+Djl2mavzJcPu0rPZKmWOM+yN+viGm6yYI1OL5TxR/yObVuU+gbimZchYLvofo46Cb6XPudXZbyCp9/1bQAhOIPVmvwnmEfldlWeZgeh/C8M7o5O170bVS8DFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321722; c=relaxed/simple;
	bh=iVIo1tJZbll1NQ+L0HoLpLV8c4g7AVa5XZyCJ8sGWBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXcgWHukEtyJcxkFEv5Rnmv+kCXbCc1FG0mLRfmXAi26jXUHY3JfBGiodwVZxkjayXR63fEfTYIVVolFSpN6NSb+I7ElEqhnh23Kq6vpAhU94kjBqqB8apMOheeSCUpX6ozA8H/6HdB20dtWoFqNpJwGz+tdiJu5tTqHzXs0pfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZV2cLOs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52EA9C433C7;
	Sun, 24 Mar 2024 23:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321721;
	bh=iVIo1tJZbll1NQ+L0HoLpLV8c4g7AVa5XZyCJ8sGWBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZV2cLOsVZDHv77J9M5Mq3JyUgPMwMsrnDwWGJCo8CiDHSvPrhndgTqPxDcwstEaR
	 VxDpGEtZuOwHMxKD4gSSQdAL7jHVtNxnfhEHuzpXTh9LOfI0czkfcfvHmhjhUcv7GD
	 4K19pn8XMQB75CXhOFGOdgLTQMWMD01NG+48PmOm7/ViaTNzW3B8uOLb2o2NrPU57y
	 u6Y5ossTalijmb4s/rbIN2zZFfmOOdZOZ8Bv9sBCMXQqsuIr+WCgueJHUv3xGXG5jO
	 dAd/1rlsqVD+cSMhhDlu56sLplow10X+qiNcAARfTLq2fo0+jOVvh/k7BWQ/EPTGJ0
	 a9E+L105syk9Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Damian Muszynski <damian.muszynski@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 449/638] crypto: qat - fix ring to service map for dcc in 4xxx
Date: Sun, 24 Mar 2024 18:58:06 -0400
Message-ID: <20240324230116.1348576-450-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 524fdcf3d973b..615af08832076 100644
--- a/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
+++ b/drivers/crypto/intel/qat/qat_4xxx/adf_4xxx_hw_data.c
@@ -417,6 +417,13 @@ static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
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
@@ -445,6 +452,7 @@ static u16 get_ring_to_svc_map(struct adf_accel_dev *accel_dev)
 		}
 	}
 
+set_mask:
 	ring_to_svc_map = rps[RP_GROUP_0] << ADF_CFG_SERV_RING_PAIR_0_SHIFT |
 			  rps[RP_GROUP_1] << ADF_CFG_SERV_RING_PAIR_1_SHIFT |
 			  rps[RP_GROUP_0] << ADF_CFG_SERV_RING_PAIR_2_SHIFT |
-- 
2.43.0


