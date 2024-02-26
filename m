Return-Path: <linux-kernel+bounces-80708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B26E5866B86
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:57:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39331C2033F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9E1D553;
	Mon, 26 Feb 2024 07:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NkvaB7ep"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AE41CA91
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708934199; cv=none; b=tR7nKylSn8gQR+tZDEYtMNuUvfM5Wf/0YJwKynp5rPy53V2eOc7YBFYDUD+UAX2H6FaoAgT9dlr3gYKNHhjC1S2ogWxToQLPI/XRNzskeCqZuYoW5+skKCftqfW8HYFgBlPxef3q/+6WavrHi2yFQJnAr2dUo8siu+4KBtvEX3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708934199; c=relaxed/simple;
	bh=7XdcGmZNj1k6DExpdbc9NvMvOv0pQ+9MNUQsEGhjmcI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vqv+2jZu63WynS2CD617kLRiyEdhMRwdPNtUAmA4DjlfxCYxtao2SjaRe9dZvuN0xNE4Wgyeol2p1STU2v+bWWAQ91UTS6DbbF05YaN+34ubHUlPM3hq2IgVRmT7f6oEjIw9Cb/Ov60NUj64zGasP5RRKaTljx0Uj0bNzyMng2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NkvaB7ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11EBC433C7;
	Mon, 26 Feb 2024 07:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708934199;
	bh=7XdcGmZNj1k6DExpdbc9NvMvOv0pQ+9MNUQsEGhjmcI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NkvaB7epOzkGg6ZLIEVHY1/ogvmzwZ53OSJnnA5us7C7/hGmDO/maAtcAV5IDsStL
	 RosjIHdOEr5pTmoElxwwhA5DUpvcU+TmHFCXhQ5SBLeEJw1KK53DHxjHmqSD6yqOMM
	 aya2qsm64esw3l/zZlIXiUu+wwmOO332rZNhbnmkyVdmmbL571xHaKHJFyNo1b2xuE
	 gT/5JJm8Qy42JIIiGF7sw0K+DctEgILfWL3cOB017AoP+/KHxPyEM+ITOZtwMoe4l/
	 CWgEIGote6IkqOkO5EEhg+KqZQOyAKVvEBrr5LBsGeg/HlAhSEW0MzauGTY5bkPYpb
	 YV+/7iLXPW3+w==
From: Oded Gabbay <ogabbay@kernel.org>
To: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Carl Vanderlip <quic_carlv@quicinc.com>
Cc: Ohad Sharabi <osharabi@habana.ai>
Subject: [PATCH 2/3] accel/habanalabs/gaudi2: drop support for never released firmware
Date: Mon, 26 Feb 2024 09:56:25 +0200
Message-Id: <20240226075626.1222534-2-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226075626.1222534-1-ogabbay@kernel.org>
References: <20240226075626.1222534-1-ogabbay@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ohad Sharabi <osharabi@habana.ai>

Firmware files below 1.11 were never released to customers so no need
to support them externally.

Signed-off-by: Ohad Sharabi <osharabi@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 47 ++----------------------
 1 file changed, 3 insertions(+), 44 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 5be3432d29b3..c99edbf9f4ca 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -6314,26 +6314,6 @@ static void gaudi2_execute_hard_reset(struct hl_device *hdev)
 	WREG32(mmPSOC_RESET_CONF_SW_ALL_RST, 1);
 }
 
-static int gaudi2_get_soft_rst_done_indication(struct hl_device *hdev, u32 poll_timeout_us)
-{
-	int i, rc = 0;
-	u32 reg_val;
-
-	for (i = 0 ; i < GAUDI2_RESET_POLL_CNT ; i++)
-		rc = hl_poll_timeout(
-			hdev,
-			mmCPU_RST_STATUS_TO_HOST,
-			reg_val,
-			reg_val == CPU_RST_STATUS_SOFT_RST_DONE,
-			1000,
-			poll_timeout_us);
-
-	if (rc)
-		dev_err(hdev->dev, "Timeout while waiting for FW to complete soft reset (0x%x)\n",
-				reg_val);
-	return rc;
-}
-
 /**
  * gaudi2_execute_soft_reset - execute soft reset by driver/FW
  *
@@ -6346,23 +6326,8 @@ static int gaudi2_get_soft_rst_done_indication(struct hl_device *hdev, u32 poll_
 static int gaudi2_execute_soft_reset(struct hl_device *hdev, bool driver_performs_reset,
 						u32 poll_timeout_us)
 {
-	int rc;
-
-	if (!driver_performs_reset) {
-		if (hl_is_fw_sw_ver_below(hdev, 1, 10)) {
-			/* set SP to indicate reset request sent to FW */
-			WREG32(mmCPU_RST_STATUS_TO_HOST, CPU_RST_STATUS_NA);
-
-			WREG32(mmGIC_HOST_SOFT_RST_IRQ_POLL_REG,
-				gaudi2_irq_map_table[GAUDI2_EVENT_CPU_SOFT_RESET].cpu_id);
-
-			/* wait for f/w response */
-			rc = gaudi2_get_soft_rst_done_indication(hdev, poll_timeout_us);
-		} else {
-			rc = hl_fw_send_soft_reset(hdev);
-		}
-		return rc;
-	}
+	if (!driver_performs_reset)
+		return hl_fw_send_soft_reset(hdev);
 
 	/* Block access to engines, QMANs and SM during reset, these
 	 * RRs will be reconfigured after soft reset.
@@ -8165,13 +8130,7 @@ static void gaudi2_ack_module_razwi_event_handler(struct hl_device *hdev,
 		}
 
 		hbw_rtr_id = gaudi2_tpc_initiator_hbw_rtr_id[module_idx];
-
-		if (hl_is_fw_sw_ver_below(hdev, 1, 9) &&
-				!hdev->asic_prop.fw_security_enabled &&
-				((module_idx == 0) || (module_idx == 1)))
-			lbw_rtr_id = DCORE0_RTR0;
-		else
-			lbw_rtr_id = gaudi2_tpc_initiator_lbw_rtr_id[module_idx];
+		lbw_rtr_id = gaudi2_tpc_initiator_lbw_rtr_id[module_idx];
 		break;
 	case RAZWI_MME:
 		sprintf(initiator_name, "MME_%u", module_idx);
-- 
2.34.1


