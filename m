Return-Path: <linux-kernel+bounces-36190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4F6839D4A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576891C24F65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4575473F;
	Tue, 23 Jan 2024 23:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3MhngyQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346DD3B78E;
	Tue, 23 Jan 2024 23:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706052795; cv=none; b=mo4Q6+9boZTqK8uNA6pEihvpNHeBmGZYvyZDLFn9NwjF65IPSw2/xQoY1AdKeAGN/rCXVBcStpCoQrUHAhvBxMYu/g6IXcIXyh0GVGwRhNPU1RuLryzdVM51gRfS3ohnGHZ0tPuWCs/nu0WlJotR+AuCjs7VXO83NIQnxWOGiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706052795; c=relaxed/simple;
	bh=QGNoOHkwOGudSjTTpE/RdtDWUSLVrM6Fux/IWb+zhHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W/6pR3L3gH2+fmiDAs/elkcIeafA4l4ojTwgqZYQJhr4WCMLTba6XAzuVOqf7QlGpLOF896CFemOBOBHAOIWgiLxZqfcvmPI4LQovlI9rxrocKLeVMOV2+CDo2kLXn4ZoCqdNLhp/5D/ZPrqIuVLWGi+Fo2m0lCZPtcjma4Y+Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3MhngyQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AFAC433C7;
	Tue, 23 Jan 2024 23:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706052794;
	bh=QGNoOHkwOGudSjTTpE/RdtDWUSLVrM6Fux/IWb+zhHM=;
	h=From:Date:Subject:To:Cc:From;
	b=I3MhngyQQwiO+HC4n3VfkmRV26qY3hc8196Rl80VsXzQSixMKZRNcljsOQuC859Pt
	 GtxxpSbvMhY0kWmqSRyhXBMqAPNRQGmlXtB9gs7SmTdba7VGsjUdeeAeMxVMu0/4Gl
	 M69jk/jX/A0zXUXLdj6otuJq+2wXlwYZ2uY33QXB+djCAVLW0vmSqNzTAeu2wCYd3Q
	 0rCxV5EHOCbgXGmxXbmY6jqiTZrxPVxWX+72yDJA0FxDVvVtpoxOU/0B4MtYkv2CYt
	 dN39Ryh+HKhdgVGrAa4dpXktn7cQwArrt8kjeCK3pKHqC9YNQMftRWrhYwedS2aI5k
	 3a8jZgdrGxdjQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Jan 2024 23:33:07 +0000
Subject: [PATCH v3] thermal/drivers/sun8i: Don't fail probe due to zone
 registration failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240123-thermal-sun8i-registration-v3-1-3e5771b1bbdd@kernel.org>
X-B4-Tracking: v=1; b=H4sIALJMsGUC/43NwQ6CMAwG4FchOzuzbgroyfcwHsYosIjDdLhoC
 O9u4WK8GE/N3/z9OomI5DGKYzYJwuSjHwIHs8mE62xoUfqas9BKG1VAKccO6WZ7GR+h9JKw9XE
 kO/KZrBtjweTO2cYKBu6EjX+u+PnCuePqQK/1V4Jl+xebQIJ0h30FlSqU2anTFSlgvx2oFYub9
 Mc6gP5pabZUUXATeOTllzXP8xuVCXwkEQEAAA==
To: Vasily Khoruzhick <anarsoul@gmail.com>, 
 Yangtao Li <tiny.windzz@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>
Cc: Hugh Dickins <hughd@google.com>, linux-pm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3046; i=broonie@kernel.org;
 h=from:subject:message-id; bh=QGNoOHkwOGudSjTTpE/RdtDWUSLVrM6Fux/IWb+zhHM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlsEy2pfbbtfAa2AvPeU5FJK+lig+Fng09Sfcm5
 fgY1u17UcGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZbBMtgAKCRAk1otyXVSH
 0GL2B/9T8OMF5ewkEdFH2AXiJaGPuFFxbdo8n+2gHijdVsbwin12SeH0pZR5zYV9jEb1kQjkm2t
 GM7TFXxYNHmje9ZuQqtUF45nzMMShij0BdAxyiU1PfpM5gNycOam1hPpkVCmRA+53swpLJCl8aP
 U48gmUmQ4BdbS+ZxiqvtcJTrOhItl02NwSu49BcWYhQDswW5vKKG3ZdJ/P2YbgDO/DpLbBW3W+R
 KfG16WMDw6xjYADDD/xoTW3SiHmPppok0DFzb2KurnnH4BKJYKDLMXDK61SZfuduz8Mx80Rv2xR
 qCfHX2hD13u2e2GQRWiRpB1oAgxZgSNwVEm5KnnzgpAvMqtf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently the sun8i thermal driver will fail to probe if any of the
thermal zones it is registering fails to register with the thermal core.
Since we currently do not define any trip points for the GPU thermal
zones on at least A64 or H5 this means that we have no thermal support
on these platforms:

[    1.698703] thermal_sys: Failed to find 'trips' node
[    1.698707] thermal_sys: Failed to find trip points for thermal-sensor id=1

even though the main CPU thermal zone on both SoCs is fully configured.
This does not seem ideal, while we may not be able to use all the zones
it seems better to have those zones which are usable be operational.
Instead just carry on registering zones if we get any non-deferral
error, allowing use of those zones which are usable.

This means that we also need to update the interrupt handler to not
attempt to notify the core for events on zones which we have not
registered, I didn't see an ability to mask individual interrupts and
I would expect that interrupts would still be indicated in the ISR even
if they were masked.

Reviewed-by: Vasily Khoruzhick <anarsoul@gmail.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
Changes in v3:
- Rebase onto v6.8-rc1.
- Link to v2: https://lore.kernel.org/r/20230912-thermal-sun8i-registration-v2-1-077230107768@kernel.org

Changes in v2:
- Rebase onto v6.6-rc1.
- Link to v1: https://lore.kernel.org/r/20230718-thermal-sun8i-registration-v1-1-c95b1b070340@kernel.org
---
 drivers/thermal/sun8i_thermal.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 6a8e386dbc8d..c2a8ae7f8f2f 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -188,6 +188,9 @@ static irqreturn_t sun8i_irq_thread(int irq, void *data)
 	int i;
 
 	for_each_set_bit(i, &irq_bitmap, tmdev->chip->sensor_num) {
+		/* We allow some zones to not register. */
+		if (IS_ERR(tmdev->sensor[i].tzd))
+			continue;
 		thermal_zone_device_update(tmdev->sensor[i].tzd,
 					   THERMAL_EVENT_UNSPECIFIED);
 	}
@@ -465,8 +468,17 @@ static int sun8i_ths_register(struct ths_device *tmdev)
 						      i,
 						      &tmdev->sensor[i],
 						      &ths_ops);
-		if (IS_ERR(tmdev->sensor[i].tzd))
-			return PTR_ERR(tmdev->sensor[i].tzd);
+
+		/*
+		 * If an individual zone fails to register for reasons
+		 * other than probe deferral (eg, a bad DT) then carry
+		 * on, other zones might register successfully.
+		 */
+		if (IS_ERR(tmdev->sensor[i].tzd)) {
+			if (PTR_ERR(tmdev->sensor[i].tzd) == -EPROBE_DEFER)
+				return PTR_ERR(tmdev->sensor[i].tzd);
+			continue;
+		}
 
 		devm_thermal_add_hwmon_sysfs(tmdev->dev, tmdev->sensor[i].tzd);
 	}

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20230718-thermal-sun8i-registration-df3a136ccafa

Best regards,
-- 
Mark Brown <broonie@kernel.org>


