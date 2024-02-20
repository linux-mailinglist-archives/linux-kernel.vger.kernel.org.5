Return-Path: <linux-kernel+bounces-73297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C65D385C097
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671CA1F230AB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D46E762C5;
	Tue, 20 Feb 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IMrd7a2C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8037868C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444911; cv=none; b=f/tKpkpNdIHuafZddTwUqls01YxF1CcplgUunOggB91HB/4WXvatGcLaUcd6H+KehQnzBXlciAOZeG+VIaTMx2IIp/WZfwcg0cgPGgQGeGMKB9Z+0JwTQBTI8C1jN4jNwNaimVkn/niPYKvoZN8MutBBgiP9Rp+i1U2UNu0CgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444911; c=relaxed/simple;
	bh=44dNPX1QRWIKEvrmT4TESwsMGo7YKSXCzR8a2nqFsrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oPbF0tQWLq5sg45BMAM4HZneb9eNA34ukZsR2UZNPMQmzs9drZmNPYEyVep94nztJZCx1yqtbH/OzyHnn27yQnk3BQSZpNvLBNlcqMkRv+2UswaT2/xmqypReny/8kNkuAW1bGvxjY2sjqTSAkBLzMhN8Vc2eu8GtUiyqmvT/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IMrd7a2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB45CC43390;
	Tue, 20 Feb 2024 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444911;
	bh=44dNPX1QRWIKEvrmT4TESwsMGo7YKSXCzR8a2nqFsrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IMrd7a2CYIAsatUv6FpiZelNhClQi9yHEABu8j1IDoPB+IEuu7P05oW07T2kCYx6R
	 j4xPZVlaJLJ5VWQjQrpes+PuU3Mq5KlN0XQ9cflVoCNkiG3KCjdaJqU/bEc6nK1hnS
	 NwcULjs6NF9TRt53ztqt7sPdFEHjDaja0H0iRuezk+8EmS0P5N8WjR6hcvpOMvbTIp
	 Xw79n+wckSgThz9A2qFNjinGVaF2lNNGUKyYNOwfxNPYbdauoaKNKq+jGkeuRQ93vw
	 CPLUJeOKDioFhRBnlrGxMLQisMe4of9VxOB8muC6CCtuVB5vacEeQeNkloGBr+Mx2V
	 CyyNZYlZAopUQ==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 11/13] accel/habanalabs: handle reserved memory request when working with full FW
Date: Tue, 20 Feb 2024 18:01:27 +0200
Message-Id: <20240220160129.909714-11-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220160129.909714-1-ogabbay@kernel.org>
References: <20240220160129.909714-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tomer Tayar <ttayar@habana.ai>

Currently the reserved memory request from FW is handled when running
with preboot only, but this request is relevant also when running with
full FW.
Modify to always handle this reservation request.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/firmware_if.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index a3df7cf162d8..4246162b6807 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -2743,18 +2743,20 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 		hdev->reset_info.curr_reset_cause = HL_RESET_CAUSE_UNKNOWN;
 	}
 
+	rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader, sizeof(struct lkd_msg_comms));
+	if (rc)
+		goto protocol_err;
+
+	if (hdev->asic_prop.support_dynamic_resereved_fw_size)
+		hdev->asic_prop.reserved_fw_mem_size =
+				le32_to_cpu(fw_loader->dynamic_loader.comm_desc.rsvd_mem_size_mb);
+
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU)) {
 		struct lkd_fw_binning_info *binning_info;
 
-		rc = hl_fw_dynamic_request_descriptor(hdev, fw_loader,
-							sizeof(struct lkd_msg_comms));
-		if (rc)
-			goto protocol_err;
-
 		/* read preboot version */
 		rc = hl_fw_dynamic_read_device_fw_version(hdev, FW_COMP_PREBOOT,
 				fw_loader->dynamic_loader.comm_desc.cur_fw_ver);
-
 		if (rc)
 			return rc;
 
@@ -2781,11 +2783,6 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 				hdev->decoder_binning, hdev->rotator_binning);
 		}
 
-		if (hdev->asic_prop.support_dynamic_resereved_fw_size) {
-			hdev->asic_prop.reserved_fw_mem_size =
-				le32_to_cpu(fw_loader->dynamic_loader.comm_desc.rsvd_mem_size_mb);
-		}
-
 		return 0;
 	}
 
-- 
2.34.1


