Return-Path: <linux-kernel+bounces-113186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FB9888224
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDF71F21B5F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886D65B20F;
	Sun, 24 Mar 2024 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/r3pZ23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66B17830D;
	Sun, 24 Mar 2024 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319989; cv=none; b=hCKvLBKAR8MQCXBtHoMZ6/5yzXEK/RvSiYQwwHUd6cY/uTs1T34S/iVYAC6aVuSOra1HlHLCfl87gi6JiqPOPIcfaf7FJdq84f5Yid6ti/LgPCD8xXq96q4cPMXmKiw9J056yI8xpUZHkVb3gTWdcO+8DOLpzWhk3jjQtTk5aAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319989; c=relaxed/simple;
	bh=+5Vq+qVxbbUVom2yStWiKQ6O7ZceOnXGwq1aKdAD+0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYLpCZpVBU/yR+8QcFt98n4jl8huVgohJd8Ck8yfAor6U1fNj2D1sKH+3ze+Jb9mNuDkOSo2luCCatuR8QE/0f+gjzCiwdUnsOq/PNjRVPGmn3HMrnn4gAHh8iANd621w6EXiKghfsFxbtvdFnezZLIp3i4ouDATVh1aabA4VAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/r3pZ23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7095FC433F1;
	Sun, 24 Mar 2024 22:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319989;
	bh=+5Vq+qVxbbUVom2yStWiKQ6O7ZceOnXGwq1aKdAD+0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/r3pZ23edKjgv9D8lqVXQ7KDCwM/gsaTlv89H4cJ4NrqOaxrzu/A362KpAJLQDCl
	 dXZL4HoUT72fvDZFPylQdVSfNwjfJgANgw5+l8qUNjrtg1zEQEGjj5aHhntFjOQ2rB
	 XQNwrrm/dc5xUZCxDuz34K/ib/mjSIyc631qOojFZj17NYljjEmh/hrptPXjD1kZ6L
	 NmJ9nn4A3YUTMwYe2+XPSGBFLgmTjOAs0qzJ6sVrp9+uAppKI97NCgf2lnTPXtO3KO
	 BnzK1o/FpRMYW+05GO9jgu98RvCsSi+SNeIv2bmIUWQ259c7/wRBOvL0qDvIrdOmql
	 4PbUwMTu+8OxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ethan Zhao <haifeng.zhao@linux.intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 295/715] iommu/vt-d: Improve ITE fault handling if target device isn't present
Date: Sun, 24 Mar 2024 18:27:54 -0400
Message-ID: <20240324223455.1342824-296-sashal@kernel.org>
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

From: Ethan Zhao <haifeng.zhao@linux.intel.com>

[ Upstream commit 80a9b50c0b9e297669a8a400eb35468cd87a9aed ]

Because surprise removal could happen anytime, e.g. user could request safe
removal to EP(endpoint device) via sysfs and brings its link down to do
surprise removal cocurrently. such aggressive cases would cause ATS
invalidation request issued to non-existence target device, then deadly
loop to retry that request after ITE fault triggered in interrupt context.
this patch aims to optimize the ITE handling by checking the target device
presence state to avoid retrying the timeout request blindly, thus avoid
hard lockup or system hang.

Devices TLB should only be invalidated when devices are in the
iommu->device_rbtree (probed, not released) and present.

Fixes: 6ba6c3a4cacf ("VT-d: add device IOTLB invalidation support")
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Ethan Zhao <haifeng.zhao@linux.intel.com>
Link: https://lore.kernel.org/r/20240301080727.3529832-4-haifeng.zhao@linux.intel.com
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel/dmar.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
index f9b63c2875f71..ad8a340fc7f1d 100644
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1272,6 +1272,8 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 {
 	u32 fault;
 	int head, tail;
+	struct device *dev;
+	u64 iqe_err, ite_sid;
 	struct q_inval *qi = iommu->qi;
 	int shift = qi_shift(iommu);
 
@@ -1316,6 +1318,13 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 		tail = readl(iommu->reg + DMAR_IQT_REG);
 		tail = ((tail >> shift) - 1 + QI_LENGTH) % QI_LENGTH;
 
+		/*
+		 * SID field is valid only when the ITE field is Set in FSTS_REG
+		 * see Intel VT-d spec r4.1, section 11.4.9.9
+		 */
+		iqe_err = dmar_readq(iommu->reg + DMAR_IQER_REG);
+		ite_sid = DMAR_IQER_REG_ITESID(iqe_err);
+
 		writel(DMA_FSTS_ITE, iommu->reg + DMAR_FSTS_REG);
 		pr_info("Invalidation Time-out Error (ITE) cleared\n");
 
@@ -1325,6 +1334,19 @@ static int qi_check_fault(struct intel_iommu *iommu, int index, int wait_index)
 			head = (head - 2 + QI_LENGTH) % QI_LENGTH;
 		} while (head != tail);
 
+		/*
+		 * If device was released or isn't present, no need to retry
+		 * the ATS invalidate request anymore.
+		 *
+		 * 0 value of ite_sid means old VT-d device, no ite_sid value.
+		 * see Intel VT-d spec r4.1, section 11.4.9.9
+		 */
+		if (ite_sid) {
+			dev = device_rbtree_find(iommu, ite_sid);
+			if (!dev || !dev_is_pci(dev) ||
+			    !pci_device_is_present(to_pci_dev(dev)))
+				return -ETIMEDOUT;
+		}
 		if (qi->desc_status[wait_index] == QI_ABORT)
 			return -EAGAIN;
 	}
-- 
2.43.0


