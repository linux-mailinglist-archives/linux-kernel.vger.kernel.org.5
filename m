Return-Path: <linux-kernel+bounces-113568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E188855D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 839D728449A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47571C7B7D;
	Sun, 24 Mar 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV66PGzw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D874BF8;
	Sun, 24 Mar 2024 22:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320371; cv=none; b=Yrw0hQm59GjqVvkPzf9zeuz8DG0OyLbSoldsZn6cVnTajG8QdLKiQ1OL7AkZ9GsERi7feLMo+Z8iRZa0Qt9w07CnKXVYY4wUJQAUnO7btO0uhczHZacrsa6OkkrOtIOSBjLqPw0bEpCoWQ1W9IAVqb2fLQ0ln/HxZHBpmB4hrAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320371; c=relaxed/simple;
	bh=8YgqKNKZyUSZjDdrHhJMO9EHAqBgGxw1LKtKahZn3Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYJucBiEsKt6z7gVG6BsAXcVEozbPcq8R4DcbI47e5JVW9sLG6FZXeg4Bz8T2JqIen8WfWsDjrmPPl/7KvmUI1Z8f3lQj/I4CL/aETCfgA6rmFwW9rCjnmHX0Eq3yQqgaUSwzi5qOUvjs34ZfIsIN73gwhqMqt5x5YYNXviimd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV66PGzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EAAC43399;
	Sun, 24 Mar 2024 22:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320370;
	bh=8YgqKNKZyUSZjDdrHhJMO9EHAqBgGxw1LKtKahZn3Q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oV66PGzw6D0sTcZ3viKi/cYu3sYc+6OF/S98NqMTBzjqleL8deV+4GlTKnif/1wi/
	 zq6sOiMzoe+RAKwXOr4BZRtEcCjnbjX7r+ajk9ST2pXCOiDcm8J2hvEXLfr3LXzL/i
	 gwV2jPiKDRapmckQV4FCyJjSOifvWEg+AS6XI7MK5qNr09qTfmdNvSswljDic0CViq
	 +88AEx7VMa7NxBlshZuRpkVwrZkHE1RjBe5IrHumEpA2Fma4xNpn/IoxR/8Q4P0a+k
	 /sufgFQIInEWeh/thu1It1D46aQeUt2Nm+CmqhoHFxbtuEAogxPeHik/ME1l6UEScQ
	 GRmf4+p0gxLUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Feng Liu <feliu@nvidia.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 677/715] virtio: uapi: Drop __packed attribute in linux/virtio_pci.h
Date: Sun, 24 Mar 2024 18:34:16 -0400
Message-ID: <20240324223455.1342824-678-sashal@kernel.org>
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

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit ec6ecb844d14d38b7dae8beb74e3d65db9c7b3e6 ]

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
Message-Id: <20240125232039.913606-1-suzuki.poulose@arm.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/virtio_pci.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/virtio_pci.h b/include/uapi/linux/virtio_pci.h
index ef3810dee7efa..a8208492e8227 100644
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
2.43.0


