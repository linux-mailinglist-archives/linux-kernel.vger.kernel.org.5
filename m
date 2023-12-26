Return-Path: <linux-kernel+bounces-11249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D5C81E3A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40341B21D53
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480695822A;
	Tue, 26 Dec 2023 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBgm14/S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE858133;
	Tue, 26 Dec 2023 00:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054C9C433CA;
	Tue, 26 Dec 2023 00:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550224;
	bh=vWWQ/06/whYjLJPzmO983aSmC1U1YHdTkrppvtZTT3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eBgm14/Sl7yv9CqtmotJsxTcNbUU8Ls0huxV7QzOwEvawuzWcXJfeteTDfAdEocYL
	 2wpaMLCCr9TRb4ZLUqs/yMzy98D6UC70lEKWWA38hIZw5RfEfKT4JZbAxbtp7Q4JE9
	 OsoOCd0QYGrO8bewEt1yAgiWZmSfIQxnEpqIGJAbjlZcEL46CDYP3XvVcTQQEPuKPQ
	 teeezlZUNccKPoYec3utBi1qbrGMIbYoMMo/AL+Tn6vW1wFCyG9INkIWAD0ICQyz/r
	 JZJ9IPw2gMEWtq3jA6trLxtuXJfAK0tyHFxDmBHJ5Tn/DB+bzQDNjrk60LSuuJ7H76
	 bE1AtYt5eoEAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Sam Lantinga <slouken@libsdl.org>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>,
	djogorchock@gmail.com,
	jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 17/24] HID: nintendo: Prevent divide-by-zero on code
Date: Mon, 25 Dec 2023 19:22:10 -0500
Message-ID: <20231226002255.5730-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002255.5730-1-sashal@kernel.org>
References: <20231226002255.5730-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.69
Content-Transfer-Encoding: 8bit

From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>

[ Upstream commit 6eb04ca8c52e3f8c8ea7102ade81d642eee87f4a ]

It was reported [0] that adding a generic joycon to the system caused
a kernel crash on Steam Deck, with the below panic spew:

divide error: 0000 [#1] PREEMPT SMP NOPTI
[...]
Hardware name: Valve Jupiter/Jupiter, BIOS F7A0119 10/24/2023
RIP: 0010:nintendo_hid_event+0x340/0xcc1 [hid_nintendo]
[...]
Call Trace:
 [...]
 ? exc_divide_error+0x38/0x50
 ? nintendo_hid_event+0x340/0xcc1 [hid_nintendo]
 ? asm_exc_divide_error+0x1a/0x20
 ? nintendo_hid_event+0x307/0xcc1 [hid_nintendo]
 hid_input_report+0x143/0x160
 hidp_session_run+0x1ce/0x700 [hidp]

Since it's a divide-by-0 error, by tracking the code for potential
denominator issues, we've spotted 2 places in which this could happen;
so let's guard against the possibility and log in the kernel if the
condition happens. This is specially useful since some data that
fills some denominators are read from the joycon HW in some cases,
increasing the potential for flaws.

[0] https://github.com/ValveSoftware/SteamOS/issues/1070

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
Tested-by: Sam Lantinga <slouken@libsdl.org>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-nintendo.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 907c9b574e3b3..df07e3ae0ffb4 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -859,14 +859,27 @@ static int joycon_request_calibration(struct joycon_ctlr *ctlr)
  */
 static void joycon_calc_imu_cal_divisors(struct joycon_ctlr *ctlr)
 {
-	int i;
+	int i, divz = 0;
 
 	for (i = 0; i < 3; i++) {
 		ctlr->imu_cal_accel_divisor[i] = ctlr->accel_cal.scale[i] -
 						ctlr->accel_cal.offset[i];
 		ctlr->imu_cal_gyro_divisor[i] = ctlr->gyro_cal.scale[i] -
 						ctlr->gyro_cal.offset[i];
+
+		if (ctlr->imu_cal_accel_divisor[i] == 0) {
+			ctlr->imu_cal_accel_divisor[i] = 1;
+			divz++;
+		}
+
+		if (ctlr->imu_cal_gyro_divisor[i] == 0) {
+			ctlr->imu_cal_gyro_divisor[i] = 1;
+			divz++;
+		}
 	}
+
+	if (divz)
+		hid_warn(ctlr->hdev, "inaccurate IMU divisors (%d)\n", divz);
 }
 
 static const s16 DFLT_ACCEL_OFFSET /*= 0*/;
@@ -1095,16 +1108,16 @@ static void joycon_parse_imu_report(struct joycon_ctlr *ctlr,
 		    JC_IMU_SAMPLES_PER_DELTA_AVG) {
 			ctlr->imu_avg_delta_ms = ctlr->imu_delta_samples_sum /
 						 ctlr->imu_delta_samples_count;
-			/* don't ever want divide by zero shenanigans */
-			if (ctlr->imu_avg_delta_ms == 0) {
-				ctlr->imu_avg_delta_ms = 1;
-				hid_warn(ctlr->hdev,
-					 "calculated avg imu delta of 0\n");
-			}
 			ctlr->imu_delta_samples_count = 0;
 			ctlr->imu_delta_samples_sum = 0;
 		}
 
+		/* don't ever want divide by zero shenanigans */
+		if (ctlr->imu_avg_delta_ms == 0) {
+			ctlr->imu_avg_delta_ms = 1;
+			hid_warn(ctlr->hdev, "calculated avg imu delta of 0\n");
+		}
+
 		/* useful for debugging IMU sample rate */
 		hid_dbg(ctlr->hdev,
 			"imu_report: ms=%u last_ms=%u delta=%u avg_delta=%u\n",
-- 
2.43.0


