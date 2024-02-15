Return-Path: <linux-kernel+bounces-66908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2283E856374
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B25191F26954
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D4F12E1D5;
	Thu, 15 Feb 2024 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jk5EEVfh"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD71512D74E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000894; cv=none; b=aUFnJjYmeuVPaY6kfYz80OREFPkf6SAppn7bfhHHcRWusvZrDb4fIWi7aXk2ZQbl+g9AEoX9N3n3wPas9wWXTwtl2jn8MZZ7fyy9PTUNEhbvwv/SrAoM9qv4H94SJzJGFjKuiIBA8fg1WCf1zmgLmgJhWwhDg7DJ+UssPVlH5GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000894; c=relaxed/simple;
	bh=gHnyFq4f1pDYyCf0BWfNJKuDKgh/PzyoaOwfFn6k2Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjmUCTTzALWDk4ZfD76z9AWEzgJjmDxlllZpHZCfup6N75eZ3NvJZqR8EHCh0iy1zSzlQPvwp6i5G4R8YID3CZlestvSxfuKEP42L6KmKgROTKJDh0NXfFEgQQ/WABV/tNuqWyHYxMKrgFLvKO2pveP7H3cnmGaNN/Jn4W1T7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jk5EEVfh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41211097adcso4981995e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708000890; x=1708605690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfSE0heYPzlfo04ucdVX3fOnYjllc+qDYIJqJxlkX8U=;
        b=jk5EEVfhjoVO2j4mPq4QK7/ydyYUzQiUiVGl4rF982HSBW3uv+BFU/JOx3c0HOBHIb
         kg19ZhqTBctVmBbV73BV6qwmhQIdnXV1ZiwrBAfpWe7al+O9ck+lNk5tOahDHRukAv2N
         WAHuepMhHyh6v3g0t/M3pqdljCEcfK4PelDlWPlHVfVL/QKUATDfHlvoGGhrqJwDlHZW
         h0q//NptmR6fZ8alb0Udsw4zWVr2gR+jdY2SYLdNgVBE5kkjfTLdbi1sXP9MhPnpuy71
         yHEbPNcLoUGCvGIA9P6AHt3hx1nfB8H65vwvlUoJ60/vVw/7M+AnCFD8faPOEp2bBAU9
         P/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000890; x=1708605690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfSE0heYPzlfo04ucdVX3fOnYjllc+qDYIJqJxlkX8U=;
        b=IUj5vHz6n3py6q5AZvhFnKScJLovJYA4z33Z2PXY1LJvZ+FXZPfUVgSJkPqF+dVY9A
         j/5nzh84c+FA0xiIl9QnCKS361PMiZc+u7VEkQ0jxuzw550T0Ny2NlE7f2n00+04qaYV
         iZUPcvVjhP/Q09lHyaLpc4CWur8D2wM4+zNjrTtV17hOjl2wYpQhthhihfJkC1UQlJQw
         YO4Byq7KmjogtinlkJgNys+xK0GqabgK7ytmUSdK1pJ7srHV7fKV1TiXKdpuUn6JLxuH
         /VkZBmihy18+KJCiQOiGYWyFFnf3EVQnrTVJAoXPC7KL8SB+ZRa/0D+a40hpegHC8ejS
         vfqA==
X-Forwarded-Encrypted: i=1; AJvYcCWXgo6EdqydeYrXGgPWNXNCPsDkzXe4vmF8XwsQX4ngkyUBkp/gO8AkShSG7j/F+qLs9vZnfs5BO6VKSfcBDgUeLzzAKJxBtTDR9vPq
X-Gm-Message-State: AOJu0YxNfGNsurK2By8qQduAB2jsIfDTLVQvhaLEhNeqqCJHaE0fbrow
	qHAIqKUII/7WAjlJ/20lQj9ZO9cQ4B90kcDfbNasJu0Gef/ehxbPwYk45zw4OmI=
X-Google-Smtp-Source: AGHT+IGikOwkuOPFBTsMbTZdEAAonvNOhcu6PDAwcbmJos4zHQ93Q6qK8wgIe3B2ezllABgdj7icJQ==
X-Received: by 2002:a05:600c:43c3:b0:40f:dd4a:11f5 with SMTP id f3-20020a05600c43c300b0040fdd4a11f5mr1497192wmn.34.1708000889857;
        Thu, 15 Feb 2024 04:41:29 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id n16-20020a5d51d0000000b0033cefb84b16sm1674931wrv.52.2024.02.15.04.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:41:28 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: geert+renesas@glider.be,
	linus.walleij@linaro.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 1/2] pinctrl: renesas: Select CONFIG_IRQ_DOMAIN_HIERARCHY for pinctrl-rzg2l
Date: Thu, 15 Feb 2024 14:41:11 +0200
Message-Id: <20240215124112.2259103-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215124112.2259103-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240215124112.2259103-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The pinctrl-rzg2l driver uses APIs that are defined only if
CONFIG_IRQ_DOMAIN_HIERARCHY=y (irq_chip_*_parent() APIs). On the ARCH_RZG2L
CONFIG_IRQ_DOMAIN_HIERARCHY is selected anyway, e.g., by the
CONFIG_ARM_GIC_V3. Even so, make it explicit at the driver level for a
clearer view of the dependencies.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- this patch is introduced in v2

 drivers/pinctrl/renesas/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/Kconfig b/drivers/pinctrl/renesas/Kconfig
index c8d519ca53eb..a1e57939e54b 100644
--- a/drivers/pinctrl/renesas/Kconfig
+++ b/drivers/pinctrl/renesas/Kconfig
@@ -190,6 +190,7 @@ config PINCTRL_RZG2L
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GENERIC_PINCONF
+	select IRQ_DOMAIN_HIERARCHY
 	help
 	  This selects GPIO and pinctrl driver for Renesas RZ/{G2L,G2UL,V2L}
 	  platforms.
-- 
2.39.2


