Return-Path: <linux-kernel+bounces-11270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C2281E3E3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34675282EB7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112946444;
	Tue, 26 Dec 2023 00:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGmT/e8M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118DD46420;
	Tue, 26 Dec 2023 00:25:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464D8C433C8;
	Tue, 26 Dec 2023 00:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550336;
	bh=AQAKHcwMoVZDDNyVuMRYIUdwwzMaNURX+67A622xNxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGmT/e8MyUCcXAhaOSyP3izoEFpDFYsbWVqDr5a/4mkKeqcBIu5tmwOdTrNAJr3bX
	 /UFKf6NF7qPmp0MH6G0HJHO8tAUq2Y8bXlVURzPMfB8zT3qSGg9AmPpEIGsUvoxAK1
	 N613D2C/ypunj85m9+GZSYRDEsNkfcuG1Cah5rgUvoPk1mGFwncQG2Hbvp4VYwOyXv
	 1Bw/MfkGsJl7T3Lwups2Keg6aW8dd58IywszBdCh3WyiYG458vfPG47yOE2EOUu+1H
	 HSfQruSE11SUk7UOWo2NSVtZNwIenLjc9jeHne3ZqIBDMptGzAutMYBN4HNhcNdO1T
	 QT8gHfVTxl/ag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	wse@tuxedocomputers.com,
	hdegoede@redhat.com,
	jdenose@chromium.org,
	mkorpershoek@baylibre.com,
	szfabian@bluemarch.art,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 3/9] Input: i8042 - add nomux quirk for Acer P459-G2-M
Date: Mon, 25 Dec 2023 19:24:47 -0500
Message-ID: <20231226002526.6605-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002526.6605-1-sashal@kernel.org>
References: <20231226002526.6605-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.205
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
 drivers/input/serio/i8042-acpipnpio.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 09528c0a8a34e..124ab98ea43a4 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -351,6 +351,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
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


