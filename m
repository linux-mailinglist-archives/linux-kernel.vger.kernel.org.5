Return-Path: <linux-kernel+bounces-33286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A47CA8367F9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75AB1C22ADD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B105C5EC;
	Mon, 22 Jan 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf7BUyYQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1854D5C5E1;
	Mon, 22 Jan 2024 15:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935615; cv=none; b=WXvaCfuFo2+b+q4iSUwLqIQKOammjMuznflS2n95e7BafcFr2eQMF5r8zTQbOiL4fSLA+lT4cjP0UA4KM9IeIbQ0ltOSgBQSFMScQXgwUmMCfV7OuOBne8D68m3GF0KDrLu7xBzop9syX/XDJ76M0utd0Y+WcgLC43jQSBWzOkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935615; c=relaxed/simple;
	bh=kOnajDdCG2w3ab9S/kUTAjC7AbVcgzSsg+UPepbB180=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/iLw25yHWY/nc6UsxEnDdB+pAGIhfJByTU8Tdzlj7B/W+2fL10TMwkwUvgk+78z9bmvpFATP5+fC/zLdt36fIjHpg+HSROkJlUgO5Jn49jZduaLSmtP1/VWn9Z4T2e6yB3W+FW97CYgA5GArM/LeZcjlgOzuDkOGhBMhK4JJcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qf7BUyYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A926BC433A6;
	Mon, 22 Jan 2024 15:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935614;
	bh=kOnajDdCG2w3ab9S/kUTAjC7AbVcgzSsg+UPepbB180=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qf7BUyYQSGN1m6VY2a+cl+8vRwUWtQwOkFKNotZwoV4QDesbOkJer0q32tiRWRn1S
	 xn5CU11Z2I8arMw2uDfzJRgGcfJl2W5Q1uPp7SkAbq8uczey5Z+8wA8z4/mJRdUB+R
	 BDAwSy+LwU7+4rsO7dn48oA9T4ntevkDYFOpgYhRMK+U83V7MrQq6PgH3A1+n9H1zO
	 KnLRw9liFkMaxHQT8L8iOsbQBm2lBGtOZbfulxCquEpfaTjnxlt/toHG1THnpLb5Fy
	 GzCA+OOO0smBBfxAm1N5mEm2ksYx+UherJerk30N6gnykn/H6PvSTr3se61Ha0twxs
	 RcIbp7pdm1NJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Farah Kassabri <fkassabri@habana.ai>,
	Oded Gabbay <ogabbay@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ttayar@habana.ai,
	stanislaw.gruszka@linux.intel.com,
	kelbaz@habana.ai,
	dhirschfeld@habana.ai,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 64/88] accel/habanalabs: fix EQ heartbeat mechanism
Date: Mon, 22 Jan 2024 09:51:37 -0500
Message-ID: <20240122145608.990137-64-sashal@kernel.org>
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

From: Farah Kassabri <fkassabri@habana.ai>

[ Upstream commit d1958dce5ab6a3e089c60cf474e8c9b7e96e70ad ]

Stop rescheduling another heartbeat check when EQ heartbeat check fails
as it generates confusing logs in dmesg that the heartbeat fails.

Signed-off-by: Farah Kassabri <fkassabri@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index 9e461c03e705..9290d4374551 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1044,18 +1044,19 @@ static bool is_pci_link_healthy(struct hl_device *hdev)
 	return (vendor_id == PCI_VENDOR_ID_HABANALABS);
 }
 
-static void hl_device_eq_heartbeat(struct hl_device *hdev)
+static int hl_device_eq_heartbeat_check(struct hl_device *hdev)
 {
-	u64 event_mask = HL_NOTIFIER_EVENT_DEVICE_RESET | HL_NOTIFIER_EVENT_DEVICE_UNAVAILABLE;
 	struct asic_fixed_properties *prop = &hdev->asic_prop;
 
 	if (!prop->cpucp_info.eq_health_check_supported)
-		return;
+		return 0;
 
 	if (hdev->eq_heartbeat_received)
 		hdev->eq_heartbeat_received = false;
 	else
-		hl_device_cond_reset(hdev, HL_DRV_RESET_HARD, event_mask);
+		return -EIO;
+
+	return 0;
 }
 
 static void hl_device_heartbeat(struct work_struct *work)
@@ -1072,10 +1073,9 @@ static void hl_device_heartbeat(struct work_struct *work)
 	/*
 	 * For EQ health check need to check if driver received the heartbeat eq event
 	 * in order to validate the eq is working.
+	 * Only if both the EQ is healthy and we managed to send the next heartbeat reschedule.
 	 */
-	hl_device_eq_heartbeat(hdev);
-
-	if (!hdev->asic_funcs->send_heartbeat(hdev))
+	if ((!hl_device_eq_heartbeat_check(hdev)) && (!hdev->asic_funcs->send_heartbeat(hdev)))
 		goto reschedule;
 
 	if (hl_device_operational(hdev, NULL))
-- 
2.43.0


