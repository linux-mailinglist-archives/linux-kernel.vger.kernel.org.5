Return-Path: <linux-kernel+bounces-41827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E31883F824
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EACB1F214EF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F89C148303;
	Sun, 28 Jan 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXuKfRI2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E81482EF;
	Sun, 28 Jan 2024 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458629; cv=none; b=qVtZTYmDza/oytyymj1sV4rNA5SvPjp8o4SUFaJiDIQl8RoQochbTlJQwk7bJ0I0zTZ2niUzcI82xvqRj9eVzgeJDYqoE1JPgjVszgLu/Js6q5X1dk+3BKLLn8hfIH9GTTATv2uL0V8uSrFP60hzozk4EybLMvnppeEGIlI1hv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458629; c=relaxed/simple;
	bh=m+5SGRiKVRAnD3Dq4o3vfwDfR1NpzBeYLYBBvw678sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hbyfs7wDPblG7h/ruyivdP4nSYgUm1iw2YVGsw40z/NKb+2EtYjVuWVk347t1ozo0CPqQZk0WR+Ssg8uTpnTFRi1bPYXNH4/5M32Mz/VtUaownF4L1FX2vlAI0zcxNfXKDqzWmvgQ7kjfe+OjQxW8E5XEQT4CxU80NI3NRlJlPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXuKfRI2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE994C433F1;
	Sun, 28 Jan 2024 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458629;
	bh=m+5SGRiKVRAnD3Dq4o3vfwDfR1NpzBeYLYBBvw678sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXuKfRI2YqMTmqLyviWctYu4zw6wnf3zzJ0M79rPlN1uYNqnrI1uPBFVZPwhzEGz4
	 foZlCb5ZlsDz/iBpYWB7zf9OgMnavEYY0HW81bHp0U53KL8o4qJXuV+5czbW7ScYMB
	 uB8GT8vRpv3cWosgcO/zxYfkZJPRic2sHeVhGo1+g27CpDrPlSvFqPpMLQnwxLM/Yd
	 lYxslQxz7/LBAC9Vi+7FiKCbSbOJDpAojBlDuL6cjBt2kJtfSbiBSalMOHAmnieIYy
	 o95MmAUI78HSyDArTM3iNgxFc2iBPWhp/lZy+jCrQfN54qpCqN96w5B82gBdHWedop
	 Smchz1Wm3imSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	ricardo.canuelo@collabora.com,
	royluo@google.com,
	heikki.krogerus@linux.intel.com,
	stanley_chang@realtek.com,
	johan+linaro@kernel.org,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 2/8] usb: hub: Replace hardcoded quirk value with BIT() macro
Date: Sun, 28 Jan 2024 11:16:53 -0500
Message-ID: <20240128161704.205756-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161704.205756-1-sashal@kernel.org>
References: <20240128161704.205756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index 898df2e43945..b4e970ad1f79 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -43,8 +43,8 @@
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


