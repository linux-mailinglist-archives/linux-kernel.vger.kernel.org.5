Return-Path: <linux-kernel+bounces-41804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016EB83F7E3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1C01F21006
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D4A4EB5E;
	Sun, 28 Jan 2024 16:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIbNIYvb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F351F13D4FD;
	Sun, 28 Jan 2024 16:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458573; cv=none; b=bgDySlC0f2WtJk00u8yxtZtN1tKMDl3CwJt6b0EKmWMSkkbrwidNhz9S9hZgdDYnP5dZwKqZfErlPEachfxmTDMH84gnr6Vod9W++ZzY2Q2ixVnImgKwEGnCYyQkrj9jS1Y0kvc8E4YsGocoiXTNlHXfSLzAz9PcdPGdzdwBP3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458573; c=relaxed/simple;
	bh=RtH5f512ZvkltpShoqUQZiNiynEumxz2zXoaH6/mkEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSP1/NgUKMKFhRRUfDmmQ5MiNHeg5Qc8SM/RUNVguDjxV9xBGJqq9OmVQyEzmYUk7x1EA+qvUfy9WMRO0PrHJ1xGikuSwu1UnVj33n+ZK6QAPdgvqB+MD3a6FLrgQsZVhKNlbsK0r5TV2VXwVSyrf3a2y7WWih8B7t4bTeVzJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIbNIYvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AB1AC433F1;
	Sun, 28 Jan 2024 16:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458572;
	bh=RtH5f512ZvkltpShoqUQZiNiynEumxz2zXoaH6/mkEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIbNIYvbnaC62+pedvFjX6nR5sILJ56nQDNUJiIWDFLNWN/a2COt3gV81yYpcb9O5
	 aMZgO3bOIAxZ+fVcoqfb5uvbYzJZiaqCgb7StY5ujFwBrHpSGxc4QPbOl4es07sZSQ
	 EJO3y3NNwkj9m3ZAALy2kDiO8z5dP4I89q5RPAkGkIUfNF8CAc7L/dKump8Yisx2wW
	 10BCaZy7cllcnR/EM4Z1l6tigcxc0UVsXXm/+OiHKgqshwOW73OMb6SCMy7CaeXJO4
	 5u0L1KyqksWvJ0kvXOJKJq3Hw60HzQIlH+xsQcPJMd3ib4qnVFqmy0jeS7sTpnP9Tw
	 T2UPEmwEjtqxA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hardik Gajjar <hgajjar@de.adit-jv.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	stanley_chang@realtek.com,
	royluo@google.com,
	heikki.krogerus@linux.intel.com,
	johan+linaro@kernel.org,
	ricardo.canuelo@collabora.com,
	linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 03/13] usb: hub: Replace hardcoded quirk value with BIT() macro
Date: Sun, 28 Jan 2024 11:15:49 -0500
Message-ID: <20240128161606.205221-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161606.205221-1-sashal@kernel.org>
References: <20240128161606.205221-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 331f41c6cc75..a3a7dd7d3326 100644
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


