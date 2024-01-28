Return-Path: <linux-kernel+bounces-41787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4780283F7B3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBFCD1F26F5C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B1E12C52B;
	Sun, 28 Jan 2024 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxX3GrGu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0A312BF3D;
	Sun, 28 Jan 2024 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458534; cv=none; b=TwC55JaHtZtxhCKSewjHF1+8FYhg3Elf4wjfFzdTTwpiLqYvwBpBek0bbEAKO2a140W6EB/yCJEuDJ9lr66Zm3zmQ7Q3P1V9Ao+HZrGF79+8QHEA8g8ZmSDyCJtIamMcLSyCsCV8cZ9ckWoR+dF2GAyco5pSGDjnVYd7xwLw5qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458534; c=relaxed/simple;
	bh=Ga3r2pehzvuQxDNs3v56KKF2wQ3tJ8ibqRmuVKIy8LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=luTg3xtcRm6EurHETsyp0KdQZnF70yjGVhk2hhUD3Vik+hfFmb258H3jZZ+y2mv6egZTgSatwFaHAtAgg+sv/uQmPbRJYRRCYaa/MptYBapmxgHFcJjkY8StCXfZek57NVOvz3MZuOKW6SX8W8vPRmFvcyRrwxiWEuGAHPe3i2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxX3GrGu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DCAC433F1;
	Sun, 28 Jan 2024 16:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458534;
	bh=Ga3r2pehzvuQxDNs3v56KKF2wQ3tJ8ibqRmuVKIy8LE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QxX3GrGuR/ltTk50OV2szldB7RC/ENOQijuKUe+Kh0HEJg4cgZWlNCOKNMozhAU/N
	 pExqF78uG3+CqtqooUzP9TE+hWe+43JEdeTZShervPkv2v2epCXR3Ak/eN4KUt84r3
	 MJRj6MxViLpXmFNylo8p4pkHXSRq7aE2qtbKCIUfgt3dwi28r03JhgTqS+YghHc179
	 ESPEY3DFgBQ/clTVPPh9E30PAmwlbC6F57csdkoKRXdqvP4XZ+i5sYYUX+UfHJmQJo
	 g0h1welWe0cTz1WMtRAlDIVE2+fYOKbVwSlSOmQBugCS7VulURLOpnKCqVjkpJbyrt
	 SaYsmvgU9m4IA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	heikki.krogerus@linux.intel.com,
	royluo@google.com,
	ricardo.canuelo@collabora.com,
	johan+linaro@kernel.org,
	stanley_chang@realtek.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/19] usb: hub: Replace hardcoded quirk value with BIT() macro
Date: Sun, 28 Jan 2024 11:15:02 -0500
Message-ID: <20240128161524.204182-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161524.204182-1-sashal@kernel.org>
References: <20240128161524.204182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 4bed41ca6b0f..46fdccd10c23 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -46,8 +46,8 @@
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


