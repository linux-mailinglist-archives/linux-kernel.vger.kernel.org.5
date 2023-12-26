Return-Path: <linux-kernel+bounces-11287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998B981E412
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A2F01F22499
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DA8481C1;
	Tue, 26 Dec 2023 00:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ePUOnEs+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E485EE66;
	Tue, 26 Dec 2023 00:27:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C92C433C7;
	Tue, 26 Dec 2023 00:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550421;
	bh=ukR11FriRzmY6JEKSyqDo3gwccLi4fh4lFVsOTGff7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ePUOnEs+L4k1RGXNfv9pFfGA5/RTN3z09o+BixwKlbsltuBVB/+ZTjngbGAsllPu4
	 cRsVV1yrldhD0cmTIA/Dq8KshWJI/v4H4lQLyZUE/YaAPyKXXnqXkhYfSb85guz9v5
	 /omx6giGAz5zRCUuwuyQQfvfhZ+IeuB+PqrrxkziaCwF2xjCu2IfDcf+lyXRkUYVwm
	 Jjshy9EdmAPkfl41V8qcCVPAdsL94jTWP1ibICu35xHeR1hBXw+eQ2iJnNrdTrhyHd
	 t3kjjiz1kPTh6hW1OkhMwTlTW67pnq3uxqoLRyjVS/GkABAT59JZmfawwJvsMa92so
	 GqUEY9FANmnbA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 3/7] Input: i8042 - add nomux quirk for Acer P459-G2-M
Date: Mon, 25 Dec 2023 19:26:27 -0500
Message-ID: <20231226002649.7290-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002649.7290-1-sashal@kernel.org>
References: <20231226002649.7290-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.303
Content-Transfer-Encoding: 8bit

From: Esther Shimanovich <eshimanovich@chromium.org>

[ Upstream commit 335fe00319e030d481a54d5e0e68d50c5e672c0e ]

After the laptop lid is opened, and the device resumes from S3 deep
sleep, if the user presses a keyboard key while the screen is still black,
the mouse and keyboard become unusable.

Enabling this quirk prevents this behavior from occurring.

Signed-off-by: Esther Shimanovich <eshimanovich@chromium.org>
Link: https://lore.kernel.org/r/20231130195615.v2.1.Ibe78a9df97ecd18dc227a5cff67d3029631d9c11@changeid
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/i8042-x86ia64io.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 2d4df82d65afe..06d99931519bd 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -355,6 +355,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_DRITEK)
 	},
+	{
+		/* Acer TravelMate P459-G2-M */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate P459-G2-M"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_NOMUX)
+	},
 	{
 		/* Amoi M636/A737 */
 		.matches = {
-- 
2.43.0


