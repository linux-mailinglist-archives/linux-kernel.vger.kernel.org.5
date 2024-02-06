Return-Path: <linux-kernel+bounces-54439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 576E584AF40
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1515A284A9B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C5A12AADF;
	Tue,  6 Feb 2024 07:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AiidtGBs"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0950412A15B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205930; cv=none; b=IN9E/n+temv9/xpQEvgnaBFt3cbyYpfaq0AcohjbwwSfDO572FJTjNUzEwMd37uIdjrBOE3p/BqZ5tUdErf89H9mc+TimfLtmbDqextlN/gikNAvURlbyL0klM/YB+0IFYtBRas9uAr+7T3C/4Q8YvIh4xbBZ7iig0v0WK5HH/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205930; c=relaxed/simple;
	bh=akjpDdwtIyoD1uIaPN7w8Pv+xKXWfTjc8macEXk7Atc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JagzhpzKRHddiXfIhoX1AKmfghIt6NYERjd/2vQuvcfuLRJnRNuxPQ83T81d1VRyV2RjCZWk0jKHXSSUnZsEPVu1I/GNWKSRXdNP6dE6ipobtZFYdn4rq/KVRhi/v5oEzeGNApu7wbUhAGOg9KCjoL+SvHC5ABEPSnmi1BvYeek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AiidtGBs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40efcb37373so4686625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707205927; x=1707810727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mzvigf2PQ+mn73kQfz5blaJKcbcBkovCXGS/Q9PyNyg=;
        b=AiidtGBsq9pEPyQ3ITaghgou7JHIGXJ5RsZCAuMlwS+lrO1KopLMiJhffVYiNOfMD5
         s/06swWOkRvbS972h3lM7ebrJTX3dS0jOnu01Gmuw5cyNW2K+F9OT9tVROichgkEbP1/
         JyunytLZ+trv+YJ/lNQ9GBv+3hvmFIav+E2mTYV5QGENKQDZnM9IV6zlWeqj9ap6rUID
         gTrMYePVrKAnmyOfdE88YKjdCxjBTPHtDfphR4JeCmVTKVrXQX2HYPoMtLlqZKOjovCO
         dmHEDTiQUMmy3pjec8jZXp1EyhX9OTzSZ5wzbzH3Q2grLqwJVQE6ya785Fkg6ZWlcTp3
         oLcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205927; x=1707810727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mzvigf2PQ+mn73kQfz5blaJKcbcBkovCXGS/Q9PyNyg=;
        b=uF2MKsyVqUSsO7KH4yhVFOgxOs5BpuTDdiUzCPF5TRii3f9S1PvrDUZcfzGYqt+dt8
         A7HX7HCQcan72ZN126bIRHuwRJ3Ew5IVKwbxzWcvAqTXYR8uLOnra6wpD71+PifEa+73
         wxhtBalslNv7CvyJDDE9Kt18DflgV1MhFzkhA5loczLkVA73m+ikSbLV80nkflAjxepP
         ZMQHp8altTExGQksN4a+iKMUs2DVQODxljl0yKVXsrn9N1+zOTPEsOSARBn6evqP7wS3
         E7ee8xa/NyJ+HndXqpZQ+da8aJGcHZ/2vJum/4XPJRsTN+3RPLj6oDAFg0oBWkVxcOA6
         gZug==
X-Gm-Message-State: AOJu0YwXq7ql4ucr1Z5Zlv0g8LNmt0ApQKZQUDt7qe6Ei5xyIi4Q5Wnf
	s9EUTw2SOYKz3TYFnD0JQkp5adRR3nKFhAJlUalf0P5Zq2C6UbGo6ZUdulg94C/JsdX9ZnhzFpQ
	Q
X-Google-Smtp-Source: AGHT+IFFsTWXeT0lLAHR5vO711bXlBsIWAk4Lfj5wpYLHDAijE3PKJWSCseZKr6i2POKquYGLzPsOA==
X-Received: by 2002:a05:600c:1390:b0:40e:a569:3555 with SMTP id u16-20020a05600c139000b0040ea5693555mr1526799wmf.35.1707205927176;
        Mon, 05 Feb 2024 23:52:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKs75+Ee86KfuDf50VytpfGApvjqYh6WuMhD9JSl5i8ZjQztETsn5A76SExy35z/BC8FjmP2Q3IkLfWHAbf4g/PzjU1iZpeOcOgd0KMglZxPFkLs6xy7iSh/7qcRR1dHoq3lSuJA9EOa9ywotoc4vAPl+VdiFUzs0I1rFNbpeneRKUg/uPAQu4f6kGERTbpnP0HrOhvAWj/0hPDO1Of8J0mcvd6DPy1I730XjD4sn2oKDiO+ha4zx3F2j0jxCWogAqUPUkB63oQnsCdmwnAgDZy28Wgz+k8vnmWPLu2V/keUh4WTVB7UJsk5RQbLx7Tk9JN1lyTnrFzMPen6o7iXVNrgZpNSLjxukXVXgYD4OuT9vm3qL0ld0v/45c03YwG1BrSEHQiy0Sy858+P9IND6a54stNbWp7quwWByK7E25HXkUB/JRdnCbkXvKVe/46pvcdML/rIO01UNF4qEuQKByWuocwQFVwgPjAoGupoSDzDiEJEkvTePY6iRPQTb5P8Ie3d4Mx2Apew==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b0040fbad272f6sm1106843wms.46.2024.02.05.23.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:52:06 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 1/9] watchdog: rzg2l_wdt: Restrict the driver to ARCH_RZG2L and ARCH_R9A09G011
Date: Tue,  6 Feb 2024 09:51:41 +0200
Message-Id: <20240206075149.864996-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206075149.864996-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240206075149.864996-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The rzg2l_wdt driver is used only by ARCH_RZG2L and ARCH_R9A09G011
micro-architectures of Renesas. Thus, limit it's usage only to these.

Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none; this patch is introduced in v4

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7d22051b15a2..f6cb63a0d889 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -910,7 +910,7 @@ config RENESAS_RZN1WDT
 
 config RENESAS_RZG2LWDT
 	tristate "Renesas RZ/G2L WDT Watchdog"
-	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
-- 
2.39.2


