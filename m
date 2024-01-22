Return-Path: <linux-kernel+bounces-33285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A28F8367F7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50CC28AEEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CB240C03;
	Mon, 22 Jan 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpxPDBUs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BE45BAE9;
	Mon, 22 Jan 2024 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935612; cv=none; b=j/B7jk92JqRAs+q6JdsIyJ2Aqrb0PIB47/rpkEvUoRuquR+eon3JoD1f1bqDzYeVgH0uRPxQVtohhXRTGqTCtRaUFGEyFuIlrmywbWzIjJpwgJ6dYMozNZnV6fofJ/LaLrSw6uiBPR/15s50TrRacjPysK3p8xYXP5dpCaG5A54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935612; c=relaxed/simple;
	bh=tAG6oSvI88C2HV+Ni+JtLfU6sUpFj5b4hsKwm4etEmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HhEhPh+sMaoQMlDYzFzTRNvvuA95YLg5ueR05pYd7k/5n5oE3BC0BBMQfnTN8OeeZ6O6AykhrNtuyyNRgry/kGxTJ+6k25+nFTyg2GF0QUewtMyUZO4kuRVLkGBifn8E9J/+YwtovVumVBO74fy9DJteRS4a4mg8wKhLo43F2r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpxPDBUs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EF0C43142;
	Mon, 22 Jan 2024 15:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935611;
	bh=tAG6oSvI88C2HV+Ni+JtLfU6sUpFj5b4hsKwm4etEmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fpxPDBUs2/1qHwBDZA1V+jv+bt6v5sXW4vXaAimC9AcHiX6t27zm+562LvYpLs41K
	 6sUj/HUcmrSIGLHRYB917frVs7dBcaO6Ei3b3mO1AEHppSRsoEpwdFpxTNi3CSKe1Y
	 VBfSoCy9iEvEYll+pxYwK85zoGCHJTvSkpacDIOKQcSm+7+6xV+/ECQwVkPUI5j2NS
	 riHDbnlR7QtgtPt+V8zoRisf+xdJLMLOkIyhwRRY4xlfBlPv93taodAhjjcDtiNkXK
	 rZ/qA9Wl3Wg9tsLjroNFsKaQ04RA7GSM59CVHmlg3KrCGzdVh43QMSIRTXL3+fO3xo
	 u4LFkJtZP9dUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oded Gabbay <ogabbay@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ttayar@habana.ai,
	stanislaw.gruszka@linux.intel.com,
	kelbaz@habana.ai,
	dhirschfeld@habana.ai,
	fkassabri@habana.ai,
	obitton@habana.ai,
	osharabi@habana.ai,
	mhaimovski@habana.ai,
	xupengfei@nfschina.com,
	dliberman@habana.ai,
	asuller@habana.ai,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 63/88] accel/habanalabs: add support for Gaudi2C device
Date: Mon, 22 Jan 2024 09:51:36 -0500
Message-ID: <20240122145608.990137-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Oded Gabbay <ogabbay@kernel.org>

[ Upstream commit 42422993cf28d456778ee9168d73758ec037cd51 ]

Gaudi2 with PCI revision ID with the value of '3' represents Gaudi2C
device and should be detected and initialized as Gaudi2.

Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/device.c                 | 3 +++
 drivers/accel/habanalabs/common/habanalabs.h             | 2 ++
 drivers/accel/habanalabs/common/habanalabs_drv.c         | 3 +++
 drivers/accel/habanalabs/common/mmu/mmu.c                | 1 +
 drivers/accel/habanalabs/common/sysfs.c                  | 3 +++
 drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h | 1 +
 6 files changed, 13 insertions(+)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 9711e8fc979d..9e461c03e705 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -853,6 +853,9 @@ static int device_early_init(struct hl_device *hdev)
 		gaudi2_set_asic_funcs(hdev);
 		strscpy(hdev->asic_name, "GAUDI2B", sizeof(hdev->asic_name));
 		break;
+	case ASIC_GAUDI2C:
+		gaudi2_set_asic_funcs(hdev);
+		strscpy(hdev->asic_name, "GAUDI2C", sizeof(hdev->asic_name));
 		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 1655c101c705..d0fd77bb6a74 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -1262,6 +1262,7 @@ struct hl_dec {
  * @ASIC_GAUDI_SEC: Gaudi secured device (HL-2000).
  * @ASIC_GAUDI2: Gaudi2 device.
  * @ASIC_GAUDI2B: Gaudi2B device.
+ * @ASIC_GAUDI2C: Gaudi2C device.
  */
 enum hl_asic_type {
 	ASIC_INVALID,
@@ -1270,6 +1271,7 @@ enum hl_asic_type {
 	ASIC_GAUDI_SEC,
 	ASIC_GAUDI2,
 	ASIC_GAUDI2B,
+	ASIC_GAUDI2C,
 };
 
 struct hl_cs_parser;
diff --git a/drivers/accel/habanalabs/common/habanalabs_drv.c b/drivers/accel/habanalabs/common/habanalabs_drv.c
index 306a5bc9bf89..51fb04bbe376 100644
--- a/drivers/accel/habanalabs/common/habanalabs_drv.c
+++ b/drivers/accel/habanalabs/common/habanalabs_drv.c
@@ -141,6 +141,9 @@ static enum hl_asic_type get_asic_type(struct hl_device *hdev)
 		case REV_ID_B:
 			asic_type = ASIC_GAUDI2B;
 			break;
+		case REV_ID_C:
+			asic_type = ASIC_GAUDI2C;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/accel/habanalabs/common/mmu/mmu.c b/drivers/accel/habanalabs/common/mmu/mmu.c
index b2145716c605..b654302a68fc 100644
--- a/drivers/accel/habanalabs/common/mmu/mmu.c
+++ b/drivers/accel/habanalabs/common/mmu/mmu.c
@@ -596,6 +596,7 @@ int hl_mmu_if_set_funcs(struct hl_device *hdev)
 		break;
 	case ASIC_GAUDI2:
 	case ASIC_GAUDI2B:
+	case ASIC_GAUDI2C:
 		/* MMUs in Gaudi2 are always host resident */
 		hl_mmu_v2_hr_set_funcs(hdev, &hdev->mmu_func[MMU_HR_PGT]);
 		break;
diff --git a/drivers/accel/habanalabs/common/sysfs.c b/drivers/accel/habanalabs/common/sysfs.c
index 01f89f029355..278606373055 100644
--- a/drivers/accel/habanalabs/common/sysfs.c
+++ b/drivers/accel/habanalabs/common/sysfs.c
@@ -251,6 +251,9 @@ static ssize_t device_type_show(struct device *dev,
 	case ASIC_GAUDI2B:
 		str = "GAUDI2B";
 		break;
+	case ASIC_GAUDI2C:
+		str = "GAUDI2C";
+		break;
 	default:
 		dev_err(hdev->dev, "Unrecognized ASIC type %d\n",
 				hdev->asic_type);
diff --git a/drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h b/drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h
index f5d497dc9bdc..4f951cada077 100644
--- a/drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h
+++ b/drivers/accel/habanalabs/include/hw_ip/pci/pci_general.h
@@ -25,6 +25,7 @@ enum hl_revision_id {
 	REV_ID_INVALID				= 0x00,
 	REV_ID_A				= 0x01,
 	REV_ID_B				= 0x02,
+	REV_ID_C				= 0x03
 };
 
 #endif /* INCLUDE_PCI_GENERAL_H_ */
-- 
2.43.0


