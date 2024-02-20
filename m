Return-Path: <linux-kernel+bounces-73298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B796785C099
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E66B238FF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D550678B4F;
	Tue, 20 Feb 2024 16:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0/+twyz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE24763F5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708444913; cv=none; b=PghzN4xrcge/n8DekTAZK5bLbo8PskgE82e9UY5WAI7MNLVteJ2MWhnsOpElLNaYKyGxE3C3xAk35+Yn6weAkk4GREM5TpeAD3DB+UWowkMFi2X9oYrj/EunOb3f69nUATumTO/wVFPDTBrxK+i2dyp8eGKtYFbnDdJWjLa+zyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708444913; c=relaxed/simple;
	bh=dHWXGoGBTObOk/WAuzAnyoCNfUYgNLUuXRrgDNQ7GTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qXKbc8aqriPGDGsug8R89SGKLv/4mkpwqUDnlxtITnPAz3VxUABhlX1EQWxqQ50/uUYKN8lQwrJPr9G/DXrjHz1v6USOzNt1476jSky4ZRgDTtUR9Quj8WWCjmkTP37nDh0D7ICYP0g7WBkCBpEOGLjG0MoiPLMHBqfwhuGPyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0/+twyz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA02C433F1;
	Tue, 20 Feb 2024 16:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708444912;
	bh=dHWXGoGBTObOk/WAuzAnyoCNfUYgNLUuXRrgDNQ7GTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0/+twyzExWcJln7e8nqnj4Qwj7gKD8rlVn0iwdE5lterrxdcp3nWcd8nLhGv7atb
	 7LhHxbKrJdENnx7QrUzslmqWwsOWsaXGzyNSBryZMpftNBY2EAkX5Kg2/bQ7J11alx
	 Hx7Kut4NI1NrLuharIEXLh1GstMx1l2UIi6X2rXGnBr/uvn4r4gEiNrXmUw8m0pJBe
	 iZFfg8KmJGiQVOfwiEA6SRUP4q/gTRfge4y1GCCk2T9LpSLY0qPRtoj4rfZ9BDZp1+
	 cNL+GfiC63MrThFwIM7bzoIqafDCkQdEL3ukSaZM9vvw403Uj50CNeBjaWDCGAqSlB
	 24Tagzffm1wzA==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 12/13] accel/habanalabs: keep explicit size of reserved memory for FW
Date: Tue, 20 Feb 2024 18:01:28 +0200
Message-Id: <20240220160129.909714-12-ogabbay@kernel.org>
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

The reserved memory for FW is currently saved in an ASIC property in
units of MB, just like the value that comes from FW.
Except the fact that it is not clear from the property's name, it means
also that a calculation to actual size is required everywhere that it is
used.
Modify the property to hold the size in bytes.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/firmware_if.c | 2 +-
 drivers/accel/habanalabs/common/habanalabs.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/firmware_if.c b/drivers/accel/habanalabs/common/firmware_if.c
index 4246162b6807..348418643709 100644
--- a/drivers/accel/habanalabs/common/firmware_if.c
+++ b/drivers/accel/habanalabs/common/firmware_if.c
@@ -2749,7 +2749,7 @@ static int hl_fw_dynamic_init_cpu(struct hl_device *hdev,
 
 	if (hdev->asic_prop.support_dynamic_resereved_fw_size)
 		hdev->asic_prop.reserved_fw_mem_size =
-				le32_to_cpu(fw_loader->dynamic_loader.comm_desc.rsvd_mem_size_mb);
+			le32_to_cpu(fw_loader->dynamic_loader.comm_desc.rsvd_mem_size_mb) * SZ_1M;
 
 	if (!(hdev->fw_components & FW_TYPE_BOOT_CPU)) {
 		struct lkd_fw_binning_info *binning_info;
diff --git a/drivers/accel/habanalabs/common/habanalabs.h b/drivers/accel/habanalabs/common/habanalabs.h
index 40107a4eba93..55495861f432 100644
--- a/drivers/accel/habanalabs/common/habanalabs.h
+++ b/drivers/accel/habanalabs/common/habanalabs.h
@@ -650,7 +650,7 @@ struct hl_hints_range {
  * @glbl_err_max_cause_num: global err max cause number.
  * @hbw_flush_reg: register to read to generate HBW flush. value of 0 means HBW flush is
  *                 not supported.
- * @reserved_fw_mem_size: size in MB of dram memory reserved for FW.
+ * @reserved_fw_mem_size: size of dram memory reserved for FW.
  * @collective_first_sob: first sync object available for collective use
  * @collective_first_mon: first monitor available for collective use
  * @sync_stream_first_sob: first sync object available for sync stream use
-- 
2.34.1


