Return-Path: <linux-kernel+bounces-26669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0E882E4F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4656C283A86
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8A20DC1;
	Tue, 16 Jan 2024 00:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7+C4CUO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAD020B1D;
	Tue, 16 Jan 2024 00:14:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E9BC43399;
	Tue, 16 Jan 2024 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364065;
	bh=et3LSNCJwHmxGPzaGdt9JmZT+NymC84nR52YdS8T0WM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7+C4CUOPbmh/zWxv2aml5LOI4v0TkLlnckv74kJpoBGkCdn856ul+IYGti4cemIn
	 hMG7Zs6qEk1apKPhgDQh2UeT0MkGXBUknQo/NmVKX5gIb60tmva1g36f8GAfEZM9cj
	 k0ogvihVSnWNykKJQ3h8GWxzYxwE0XjZw/Z+udcqMI7N0K0Mpgmf49EF1yWMwH0jvT
	 rNm7spb1YWAC7ZuTB0W6v0ouwpvaDZrFnVy/WOQlSYJQzxG23rzEP4PL6a4ZBm/C+0
	 q41b82gCYDLl40SDrJi1wgVc7cKcjGhydrD+Uk6zsAyYUBUS8RP9GsRERIkXhN+EPV
	 RfAuRgqgrjabA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yuluo Qiu <qyl27@outlook.com>,
	Celeste Liu <CoelacanthusHex@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	rafael@kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 4/9] ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop
Date: Mon, 15 Jan 2024 19:14:09 -0500
Message-ID: <20240116001418.213635-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001418.213635-1-sashal@kernel.org>
References: <20240116001418.213635-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
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
index ed318485eb19..4a35fa3c6c97 100644
--- a/drivers/acpi/acpi_video.c
+++ b/drivers/acpi/acpi_video.c
@@ -513,6 +513,15 @@ static const struct dmi_system_id video_dmi_table[] = {
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


