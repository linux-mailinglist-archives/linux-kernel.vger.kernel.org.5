Return-Path: <linux-kernel+bounces-26695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8E882E547
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36280281BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132251B979;
	Tue, 16 Jan 2024 00:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGFot6Gs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8A725639;
	Tue, 16 Jan 2024 00:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6E6C433C7;
	Tue, 16 Jan 2024 00:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364120;
	bh=xAoHXO3uWQRqVS8UjR6OCBZxDObvScfNeQWR1SyE+x8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGFot6GsRMYpsm11C+gVKzAc2P+QAFD31K7tQyo64kR+JU6QtYHoRYZvSxSyltEU3
	 IBEzeR5kr4fdCeRxVhHCtoTWXYviFqj7Ua6NZhtLcX+Gf/2b4o+mvHSdBSDT7BnYnC
	 gY+zaEnBo07Nv8k1DTq9YKIYt4RhnYGd/FplecYxN1CmBkPp24jlEEBQ+QUWggrS1Q
	 f0XQFJ229qcylXhRIfqemYRPGym2Lmg5Sa1Et1OP0b0VCgmOQosujyGXlnhwROjLYK
	 plbew1WaIc7Ap4QugjZ7uVOf99hY6KjXg7HN/BkATQw2xUGyAEVosnHuvohjiPoHus
	 wLeqe2Ru72NPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuluo Qiu <qyl27@outlook.com>,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/7] ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop
Date: Mon, 15 Jan 2024 19:15:09 -0500
Message-ID: <20240116001514.214199-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001514.214199-1-sashal@kernel.org>
References: <20240116001514.214199-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Yuluo Qiu <qyl27@outlook.com>

[ Upstream commit 143176a46bdd3bfbe9ba2462bf94458e80d65ebf ]

The Colorful X15 AT 23 ACPI video-bus device report spurious
ACPI_VIDEO_NOTIFY_CYCLE events resulting in spurious KEY_SWITCHVIDEOMODE
events being reported to userspace (and causing trouble there) when
an external screen plugged in.

Add a quirk setting the report_key_events mask to
REPORT_BRIGHTNESS_KEY_EVENTS so that the ACPI_VIDEO_NOTIFY_CYCLE
events will be ignored, while still reporting brightness up/down
hotkey-presses to userspace normally.

Signed-off-by: Yuluo Qiu <qyl27@outlook.com>
Co-developed-by: Celeste Liu <CoelacanthusHex@gmail.com>
Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/acpi_video.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
index bf18efd49a25..d86a1a45b688 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -568,6 +568,15 @@ static const struct dmi_system_id video_dmi_table[] = {
 		DMI_MATCH(DMI_PRODUCT_NAME, "Vostro 3350"),
 		},
 	},
+	{
+	 .callback = video_set_report_key_events,
+	 .driver_data = (void *)((uintptr_t)REPORT_BRIGHTNESS_KEY_EVENTS),
+	 .ident = "COLORFUL X15 AT 23",
+	 .matches = {
+		DMI_MATCH(DMI_SYS_VENDOR, "COLORFUL"),
+		DMI_MATCH(DMI_PRODUCT_NAME, "X15 AT 23"),
+		},
+	},
 	/*
 	 * Some machines change the brightness themselves when a brightness
 	 * hotkey gets pressed, despite us telling them not to. In this case
-- 
2.43.0


