Return-Path: <linux-kernel+bounces-156418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC678B029A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CA5285764
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FFE8158A2C;
	Wed, 24 Apr 2024 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZqdOihi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1393C157A7C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941647; cv=none; b=O6uQFLPKtckqqelyHYwyTOunIw+VbE+km1k6CyARQw1Ue7g8vKVsHx+nDbuZgN2uuJf02iwIx8wbzscD9KBnKFfpFBnvCJ+vs6WLi6t6F9YK2QiIzoLzuUjNuc55/jRDQyoRTdJa6exegffou/hkzkl1cSeSwhXBTA51lYINbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941647; c=relaxed/simple;
	bh=p7Qf/Wv2gRIQXdGwm+8FyGDK8jF8gAk1WduxuCaLuAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=chPmZGqvp5BYGLfSmkhO/gUH2Wyi8RBMFcME2xpfcppVjf7zZBpFvdEBLWVCjwQagrayMLzj8Jx0gwU+05nFjmLHIyNDhvFSkNhywe8O8ZdGSqmm1BnOmc+q36tfVhkDddefWS5xtWc1fgrJ6O/scHTKwTq7yqKQJd4GcUwOiV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JZqdOihi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713941645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oCFCbOFCL4zzLvTeJtHwSPF85SA+R3VeJ49a5BsSC8o=;
	b=JZqdOihi5ZO2FI4GHs0iB+nczAIRfugc288ZpkF4j8Y8PLqBKvCLxo0p4vJ/BCDBI3smNw
	a6OOpb9BIXRvSy5MSq0vXUdpK0RG1lrcnVe21DIr0sO41p6e6lcHMUriBJ6nQu+zdwuwFg
	kKFRhhf0zvuXGUhSzgLJtCkW4456O+g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Lb7JrbX_OaKHTGL8L_60Jw-1; Wed, 24 Apr 2024 02:54:01 -0400
X-MC-Unique: Lb7JrbX_OaKHTGL8L_60Jw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BD0D804C61;
	Wed, 24 Apr 2024 06:54:01 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.73])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8E6FAC01595;
	Wed, 24 Apr 2024 06:53:55 +0000 (UTC)
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
Subject: [PATCH v7 6/6] platform: x86-android-tablets: others: Set the LED trigger to charging_orange_full_green for Xiaomi pad2
Date: Wed, 24 Apr 2024 14:52:12 +0800
Message-ID: <20240424065212.263784-7-hpa@redhat.com>
In-Reply-To: <20240424065212.263784-1-hpa@redhat.com>
References: <20240424065212.263784-1-hpa@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Set the default trigger to bq27520-0-charging-orange-full-green. The LED
will show orange when the battery is charging. The LED will show green
when the battery status is full.

Signed-off-by: Kate Hsuan <hpa@redhat.com>
---
 drivers/platform/x86/x86-android-tablets/other.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/x86-android-tablets/other.c b/drivers/platform/x86/x86-android-tablets/other.c
index c77d56454f2d..52032a874b7f 100644
--- a/drivers/platform/x86/x86-android-tablets/other.c
+++ b/drivers/platform/x86/x86-android-tablets/other.c
@@ -610,7 +610,7 @@ static const struct property_entry ktd2026_rgb_led_props[] = {
 	PROPERTY_ENTRY_U32("reg", 0),
 	PROPERTY_ENTRY_U32("color", LED_COLOR_ID_RGB),
 	PROPERTY_ENTRY_STRING("function", "indicator"),
-	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging"),
+	PROPERTY_ENTRY_STRING("linux,default-trigger", "bq27520-0-charging-orange-full-green"),
 	{ }
 };
 
-- 
2.44.0


