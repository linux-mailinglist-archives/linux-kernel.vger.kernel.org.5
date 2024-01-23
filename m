Return-Path: <linux-kernel+bounces-34765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4B183874C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C05C28D993
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A123153E2F;
	Tue, 23 Jan 2024 06:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Gx07QkKR"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FDD53E21
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 06:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705990689; cv=none; b=hhpX3PbvV6jMp6I3cMLLTB9pdSuK9YpCjY8azIx9VPQW29Swdl4TcjMspeU5c/wfwva6EFXfAEUNvv6AESUJ23tqnswGIDSpc5iJL84munufHBeQc3EJiasYE+USvTsYvo0KRzyj0l6M6ih/7eHxdaiEDzrhpZ3NFS+ogjAZq8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705990689; c=relaxed/simple;
	bh=apn60oQs5B60ozKkNhLxgpW/v7Nd7OMtzE1ceBaZjWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qgHyG7aNPOPBoqCuJWqVQ32T8C8Uns9Jojvaigr5Z1VzPoG0pJxvMLMYjHjqdD6Y8/GZc6JXjCCCAcaxSONXObREY6kmq5SFZOS3z0gGL64fuS1KPrIeiu1ZQDkhDVShyNuMgWnnsHRTNJ0C2G57HiarjnpNonp1BKRlVJtV0Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Gx07QkKR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d71c844811so17514675ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705990687; x=1706595487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYo9wXWOZdh4xBQbuTEOxrcqZQMwofEU/9c/S0MDuwU=;
        b=Gx07QkKRumLLwy5aHCC5hu1QhH/Ct1ZNLcLPaXeEoTR3twwFffROiEiTfYnfVI87dr
         T379wkWKJyIClB5ZpyCL9hzI6sgT+liIEb2NEEpfWcJLLSXCxLnFNCzxzP676dGCp6IB
         2JXfkPJr8cGcc46nub3Pd4GXWp+pRzTMXpuaNiEiOGpkiGjA/bgpBMHRyZK6KmxdQMBn
         gZh2DnItigv6aGbDELZiE8qtb66JPz87u9me2M2l/KGsHNkOusknS2hy7V3NHDMu0txj
         OLBVTfVRkVcbkmLZ7olgHK0E60oP/eX3bT3pT2LGB6SW4FhmF2FyF/XulI/VojHoFtPl
         vgCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705990687; x=1706595487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nYo9wXWOZdh4xBQbuTEOxrcqZQMwofEU/9c/S0MDuwU=;
        b=BsCevPqdXaweRSFHak7IzcoUM0J3IWRkiUw9HDp1PIm7jYYUODv/2qQFkQ3+5wCdBP
         892KWnRGD6GghQyeJgWh59+/o629njuQC+YlQMg+FfFdZeTvrqfSfoZ7tyVmXKyr9sTy
         yR8NULmhrhL/bfAntVeuQ5AvFf5N6ZRHQNqF+2UzTmB5XLXNdIclWG2g+v8almGGpYB0
         jnd+1iclnjeo0YFx5X3uj2OIF6j+uK4nRhgu8AShGce0+SPXvUPksfg9upMqwPF52JKt
         eWcuO+ZK374nD2ZN1e8stFtv9GzNgazkB/oiz/wfhY7XX5WDvoClF6Kytyaf4akqim1j
         tqIA==
X-Gm-Message-State: AOJu0YxPAzWq2xV5xYCyR3IIwBjkaQoAqrZcW1+C/Zy0HbossAdHVfBE
	d+ZY0ziqtN4xU8ydD55zNfTDzITZPC16geB8l1ROJ2If1Guma+pdHoSJlE9dJfk=
X-Google-Smtp-Source: AGHT+IFlNaztc63RI2VKYB9Y8YhdR8gD5UHFIk3F8bWliL75YvC4TOWoaqQeAhmdUbkd+zXMJ9ZT6w==
X-Received: by 2002:a17:902:7897:b0:1d5:78db:4293 with SMTP id q23-20020a170902789700b001d578db4293mr3043550pll.29.1705990686972;
        Mon, 22 Jan 2024 22:18:06 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902b08700b001d733c88646sm4425376plr.216.2024.01.22.22.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 22:18:06 -0800 (PST)
From: Nylon Chen <nylon.chen@sifive.com>
To: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	conor@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de
Cc: vincent.chen@sifive.com,
	zong.li@sifve.com,
	nylon.chen@sifive.com,
	nylon7717@gmail.com
Subject: [PATCH v7 3/3] pwm: sifive: Fix the error in the idempotent test within the pwm_apply_state_debug function
Date: Tue, 23 Jan 2024 14:17:48 +0800
Message-ID: <20240123061748.8844-4-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240123061748.8844-1-nylon.chen@sifive.com>
References: <20240123061748.8844-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Round the result to the nearest whole number. This ensures that
real_period is always a reasonable integer that is not lower than the
actual value.

e.g.
$ echo 110 > /sys/devices/platform/led-controller-1/leds/d12/brightness
$ .apply is not idempotent (ena=1 pol=0 1739692/4032985) -> (ena=1 pol=0 1739630/4032985)

Co-developed-by: Zong Li <zong.li@sifve.com>
Signed-off-by: Zong Li <zong.li@sifve.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index b07c8598bb21..7cf7a76cdb44 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -101,7 +101,7 @@ static void pwm_sifive_update_clock(struct pwm_sifive_ddata *ddata,
 
 	/* As scale <= 15 the shift operation cannot overflow. */
 	num = (unsigned long long)NSEC_PER_SEC << (PWM_SIFIVE_CMPWIDTH + scale);
-	ddata->real_period = div64_ul(num, rate);
+	ddata->real_period = DIV_ROUND_UP_ULL(num, rate);
 	dev_dbg(ddata->chip.dev,
 		"New real_period = %u ns\n", ddata->real_period);
 }
-- 
2.42.0


