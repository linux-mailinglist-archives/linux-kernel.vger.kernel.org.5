Return-Path: <linux-kernel+bounces-11197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6606381E313
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA2BC1F21D97
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C256C4A32;
	Tue, 26 Dec 2023 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDIFpYMH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160FB4A29;
	Tue, 26 Dec 2023 00:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8FFC433CB;
	Tue, 26 Dec 2023 00:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550035;
	bh=QwPX4kub7NQguI48RHq4McY0gZpYyHXuCG1dcoHcwo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDIFpYMHSJM113k7R+8/F8S1WJhi8XzI0F4uDzSVWB/w3pOXud+7vnolytSP/HplO
	 +5MiFhtjBpOVBTIcMy/TWkbjUgxai+XE+FFkTLcA8Svh3HJEx+Q6oF0ZWtDP/p+81A
	 gsgyLvEToSdoAjtswtRRoOKoalNqGrpurS9jqb4znYMS5V+x+TDmBOQ3AuyJLOIgac
	 rUAJCDqTHFRT8N4NktpF12krwo8c1Ye99khirdRowe0dIw/Gk6fVMgSOHy1Jff7/5L
	 2Lk7KrByGSAXHqMqfccUCChgxLu3eHk8P76/HxwsowQGFBy4x1QsTKqSJ4ng3nVMQk
	 O/qjxoGQoKQTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	wse@tuxedocomputers.com,
	hdegoede@redhat.com,
	szfabian@bluemarch.art,
	jdenose@chromium.org,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/39] Input: i8042 - add nomux quirk for Acer P459-G2-M
Date: Mon, 25 Dec 2023 19:18:54 -0500
Message-ID: <20231226002021.4776-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
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
index 9c39553d30fa2..b585b1dab870e 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -360,6 +360,14 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
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


