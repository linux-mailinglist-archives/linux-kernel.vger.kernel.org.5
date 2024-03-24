Return-Path: <linux-kernel+bounces-112722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 601E3887D60
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 16:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E231F21259
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF5A18EAF;
	Sun, 24 Mar 2024 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPJEilN6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9E518624
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711292570; cv=none; b=qEYmEQKg3ZimApkeYYyDaVPCY+PK2KZL+8kPP924gV4S/HGopmjCDShnb+otE4D3znYjO/vTcoi1ZqYfRhE8rJrgEaKYVpgLgfR+WSt8xCu8S8jU6gDE3c45ssf21PnXzAY4VPMCtgGuIvgkqfNBmPBDf36/lRJo9qiq17oL71k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711292570; c=relaxed/simple;
	bh=iSR4eVTv9vBjTyoy0u2zQ1BJB3q/2JhCssOVrTNtf8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdwrIuULKdvl8sfKNlqPQ7AuNCVgzHOkA0JqqXFlohrIMkkCV0M70JymBsU3FvdH/1JT2DFgKJEou/Q79IyuPHcRCALCp/aNutpxgjHMs1orNlLl4NHQ1wd2DFlYclVNrdoewY3t9yc9tUEiC7Io/4QtlN1jFFSSBvURIu1onU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPJEilN6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711292568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y5liH5XREjRdtzIi3oVOZVrr4OfiHuxXZ9yg0sczK48=;
	b=KPJEilN6xmQEbzlXjLPQwlpLQYFjOEppaAbxW3/qpyOHiUWMFwNWkz58QQ6int153gLFqg
	xgYJGjmmXhfoYxD6CQSLQYZhDjbFPRqKg376jDteXAwxaNUX/FuThAzvJX/bbH+nFrCXHa
	8/Ql/cZNG5woBViL54gYayTONydjj5c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-uNinFOgkNkGnMUXaPTkbPQ-1; Sun, 24 Mar 2024 11:02:45 -0400
X-MC-Unique: uNinFOgkNkGnMUXaPTkbPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86BD980F7E3;
	Sun, 24 Mar 2024 15:02:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E9B2E40C6DAE;
	Sun, 24 Mar 2024 15:02:38 +0000 (UTC)
From: Kate Hsuan <hpa@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org
Cc: Kate Hsuan <hpa@redhat.com>
Subject: [PATCH v5 RESEND 6/6] platform: x86-android-tablets: others: Set the LED trigger to charging_red_full_green for Xiaomi pad2
Date: Sun, 24 Mar 2024 23:01:07 +0800
Message-ID: <20240324150107.976025-7-hpa@redhat.com>
In-Reply-To: <20240324150107.976025-1-hpa@redhat.com>
References: <20240324150107.976025-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Set the default trigger to bq27520-0-charging-red-full-green. The LED
will show red when the battery is charging. The LED will show green
when the battery status is full.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/other.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index 1012a158f7b7..eccfea7b01c0 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -610,7 +610,7 @@ static const struct property_entry ktd2026_rgb_led_props[] = {
 	PROPERTY_ENTRY_U32("reg", 0),
 	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RGB),
 	PROPERTY_ENTRY_STRING("function", "indicator"),
-	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging-red-full-green"),
 	{ }
 };
 
-- 
2.44.0


