Return-Path: <linux-kernel+bounces-87093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8023786CF72
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC8CDB2CDFE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C6A200B7;
	Thu, 29 Feb 2024 16:33:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B843416063D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224387; cv=none; b=b2Y7EqWIzkFlEfiMcULajV2FqaYY9UfHGR0yyvInD7Dq12jC+fjx+dax2853Zi19PeQkLDwKutCyERzWXs4K7bPx1MWB2sdPsoI+gC5Mp5GnyXWQ7eDEW6oyVxL7xJjCmH+j1pTwy1bSJPVnaHe+DKM+Schizh8ieLyWg/ONEp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224387; c=relaxed/simple;
	bh=sePhUcPjkcFqzWnN7R/fomNhNX1xSNAJjz1E157zh24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pdLbX5jgTHN9+9qSj1URysvlsV05ablJ2K60BW7BvoJ6tGICSC9MgYJ5N4kXMbVSfeYZpsSn5t/a4jEx+1IQ4n4w05ClmTmyxkq9wsYLBEC2PDIQedIu5/ypvSEEXrPxjsHb0M1RdyLqMMd93Upzz+eI8xzszzAFlUdcpfheyw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA4B21FB;
	Thu, 29 Feb 2024 08:33:42 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A11FE3F6C4;
	Thu, 29 Feb 2024 08:33:02 -0800 (PST)
From: Suzuki K Poulose <suzuki.poulose@arm.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Feng Liu <feliu@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RESEND PATCH v2] virtio: uapi: Drop __packed attribute in linux/virtio_pci.h:
Date: Thu, 29 Feb 2024 16:32:54 +0000
Message-Id: <20240229163254.236017-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 92792ac752aa ("virtio-pci: Introduce admin command sending function")
added "__packed" structures to UAPI header linux/virtio_pci.h. This triggers
build failures in the consumer userspace applications without proper "definition"
of __packed (e.g., kvmtool build fails).

Moreover, the structures are already packed well, and doesn't need explicit
packing, similar to the rest of the structures in all virtio_* headers. Remove
the __packed attribute.

Fixes: 92792ac752aa ("virtio-pci: Introduce admin command sending function")
Cc: Feng Liu <feliu@nvidia.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Yishai Hadas <yishaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since v1:
  - Fix description for the "Fixes" tag format
  - Collect Tags from Jean-Philippe and Michael
 ---
 include/uapi/linux/virtio_pci.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index ef3810dee7ef..a8208492e822 100644
--- a/include/uapi/linux/virtio_pci.h
+++ b/include/uapi/linux/virtio_pci.h
@@ -240,7 +240,7 @@ struct virtio_pci_cfg_cap {
 #define VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ		0x5
 #define VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO		0x6
 
-struct __packed virtio_admin_cmd_hdr {
+struct virtio_admin_cmd_hdr {
 	__le16 opcode;
 	/*
 	 * 1 - SR-IOV
@@ -252,20 +252,20 @@ struct __packed virtio_admin_cmd_hdr {
 	__le64 group_member_id;
 };
 
-struct __packed virtio_admin_cmd_status {
+struct virtio_admin_cmd_status {
 	__le16 status;
 	__le16 status_qualifier;
 	/* Unused, reserved for future extensions. */
 	__u8 reserved2[4];
 };
 
-struct __packed virtio_admin_cmd_legacy_wr_data {
+struct virtio_admin_cmd_legacy_wr_data {
 	__u8 offset; /* Starting offset of the register(s) to write. */
 	__u8 reserved[7];
 	__u8 registers[];
 };
 
-struct __packed virtio_admin_cmd_legacy_rd_data {
+struct virtio_admin_cmd_legacy_rd_data {
 	__u8 offset; /* Starting offset of the register(s) to read. */
 };
 
@@ -275,7 +275,7 @@ struct __packed virtio_admin_cmd_legacy_rd_data {
 
 #define VIRTIO_ADMIN_CMD_MAX_NOTIFY_INFO 4
 
-struct __packed virtio_admin_cmd_notify_info_data {
+struct virtio_admin_cmd_notify_info_data {
 	__u8 flags; /* 0 = end of list, 1 = owner device, 2 = member device */
 	__u8 bar; /* BAR of the member or the owner device */
 	__u8 padding[6];
-- 
2.34.1


