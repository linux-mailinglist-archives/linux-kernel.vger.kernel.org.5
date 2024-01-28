Return-Path: <linux-kernel+bounces-41727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB8883F70C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 507891F2A112
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FE05FBBE;
	Sun, 28 Jan 2024 16:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nD2j3t/h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FC5FF1E;
	Sun, 28 Jan 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458407; cv=none; b=gRiyM8t8FHsB3XR06b2E3E6AFUgLXUmjY6ggW9XPtrFlTb7eRQWgZkcZeKo7XBP+Ys4naHFniYLZvlxhICg88z2QhgWHfKx/rgyNIjaiM1MqX//PKatHPV3vpUi7ODxb9bT6fLxmYiY85Lpsz3YlMzHKRh2aWzOQvMkcy5Hf2Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458407; c=relaxed/simple;
	bh=AycIwpK2yMO7Vvpf618sJt21YVoamaKKuBGs2z9jzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NgR9UXjJZf2Wbg10VKc8le/HsczGmMnYV96pYRsL4CMqxMoRz3GrLuG5DyHYNsIhEAer5LGvvMiATZGsS5BbOF8xi/kVbLFq2hQZqt6gEs4zwQhYFBXlkzEisW5jcLeOUlMJqeAsIjuGX/oumUaJGa97Zx4Oa7y3T2XDr25+KsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nD2j3t/h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF53C433C7;
	Sun, 28 Jan 2024 16:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458406;
	bh=AycIwpK2yMO7Vvpf618sJt21YVoamaKKuBGs2z9jzRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nD2j3t/hQIp1oS8kM/HBJUcCy8WybrY/T5tTTD7MFuswCHpH6JEIWIGi/iiMRDHXl
	 7/7zfp4r2cs0wvxK063lvONOmz6opNvr6ARrl1pRZ0VQr1m3l4Lz68Alco3Zv5Wnmy
	 mZwqe/6tC6qAOAV5jJQKQa8bQb9GcbPXAKUklYvYCLgsAkTHkaPQuMr/G0GJYsKKeu
	 CicrFcNUWeVL/V1quBjCQ6697hg9n63MHW1wAtyIxD/hKQJA/AiXPDhEJP7/AbWSzt
	 broKgdbodWXg5PNBGK1ou9p3csB9OIHfiRDIC35O0uCyZBeIFlfw8yDGDfbP9ABsWM
	 RgblzrvqmOKuA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stanley_chang@realtek.com,
	ricardo.canuelo@collabora.com,
	johan+linaro@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/31] usb: hub: Replace hardcoded quirk value with BIT() macro
Date: Sun, 28 Jan 2024 11:12:36 -0500
Message-ID: <20240128161315.201999-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161315.201999-1-sashal@kernel.org>
References: <20240128161315.201999-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.14
Content-Transfer-Encoding: 8bit

From: Hardik Gajjar <hgajjar@de.adit-jv.com>

[ Upstream commit 6666ea93d2c422ebeb8039d11e642552da682070 ]

This patch replaces the hardcoded quirk value in the macro with
BIT().

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20231205181829.127353-1-hgajjar@de.adit-jv.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/hub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index dfc30cebd4c4..f5abfba68e69 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -47,8 +47,8 @@
 #define USB_VENDOR_TEXAS_INSTRUMENTS		0x0451
 #define USB_PRODUCT_TUSB8041_USB3		0x8140
 #define USB_PRODUCT_TUSB8041_USB2		0x8142
-#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	0x01
-#define HUB_QUIRK_DISABLE_AUTOSUSPEND		0x02
+#define HUB_QUIRK_CHECK_PORT_AUTOSUSPEND	BIT(0)
+#define HUB_QUIRK_DISABLE_AUTOSUSPEND		BIT(1)
 
 #define USB_TP_TRANSMISSION_DELAY	40	/* ns */
 #define USB_TP_TRANSMISSION_DELAY_MAX	65535	/* ns */
-- 
2.43.0


