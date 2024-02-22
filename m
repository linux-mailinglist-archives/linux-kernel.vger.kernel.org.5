Return-Path: <linux-kernel+bounces-76072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB9885F296
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FFC1F21F34
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83161BDC2;
	Thu, 22 Feb 2024 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jSGLSRSY"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524E4179A1
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708589590; cv=none; b=MsiYQ/MB7LeBRSVUuNFn58s/AufHZfMY7/sId3v095aDEwPY8SxsU6xJUJjp244ZKa1mNXmJjMIwza2Ox15uRyACmqOADFKqspQGSJY+Ep0GCwhFwej/uKIFakE4w9cB/JvVvattnOCJoWeu6Lbc1sM129DCZCYEe6igaFGfuWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708589590; c=relaxed/simple;
	bh=h9kgBQNw1Wr0BxDFXwRL5apSgNSUo0OVqXELAEBrD4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sp0KTE7a5kkK1eYFHNvCkq5Pl0fOJAPvgfAn7eMe9QMm0+71yj8SJqTCFCy3qiUR3IBEjFErw4CaBhyMoAqKCST2ElawCXu2BPfgTNKWKTzabUi5nnn3n04tM3n/UByMwNdEwzQhWWf5EASlhT7PuK9inlP95afsjk1gVxFn+S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jSGLSRSY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d944e8f367so60487045ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708589574; x=1709194374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OzNGUpNoXsKa0F+bV/ekx8aAYd7ltTcTmTe5buoxy74=;
        b=jSGLSRSYMtq/I7wf3V4GDaTRmW43zUf4D7Cx2YsYtVoPj5alOTbDjWdA77qXxjQsuX
         SpAX66uUuIa2MiwBFxqQfywI1PZEZIu+iy3l0kgTnTU6j8jHtTa1JpoL3IFVaLor5cEy
         SR8INtdM3dkxGBN/pkVVOEOczUZoKELOHD0SVngj3X1O7hZe/g2FB9wFAYzK8QWQybTr
         OqUj4/qQgnldOntl8Im2ZYJsvn5UKNKG4vZ7jWw4AdGDhpARWayia99vWLZkH0NGxuiy
         SH2Z5o6Md0wb6YPC84WDQHfcDB9zcSo0NWj027XjVv1HwDgPz+FKUh+UIPq7/Afos7Ad
         kZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708589574; x=1709194374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OzNGUpNoXsKa0F+bV/ekx8aAYd7ltTcTmTe5buoxy74=;
        b=lFLy89PS8oyl3nQVXHkceXKHQ8dJYQP7cAHNBujoWXTTz+vtUIvLcDfeX9SzYxquEq
         /0edur8rfgzGhBQMQo4/QSMEN5nhZk6FYOIcsBh6WuRVwB/oV+WXaHkvzyIVxdujHxCB
         3BRROksewIc4ZNAb73W/7uvDATCTAa1yeu+hqS7vMUKRfDLIuBzbTubnVFNxbwA8J/AK
         4pCwKDEsfeR8bner3X7bQ0O08C1IPF27PvGiNQ0J48lT9H+0z7ktuIMw8J8AY6LTUBDU
         gw2y8A5fQfIZbeq6fQ8CA73Cmu/gaEds1le/6kW0xM7fELHG3J9bXrC7L6I72uIvr+Zo
         MHXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXcdct+F/Ex5CCOCYuZ11lMexyDfoYE4G22B5wOn8dtaOIGgBByI6pBVNA31UnTmilEGFpCr7F+eWSMmK9xnJwXCFKOUpUGWHB0UI3
X-Gm-Message-State: AOJu0YzJLclAplJLig/kb0uPX3QzIDUwCIKwK9LJgIGBPZlTFglHCm60
	Q10ZmQgOV1IKYFYVjFbg2cw32zA3h6RYHVgySPBW1Rs69t1hxoMj75N5s/V1e1I=
X-Google-Smtp-Source: AGHT+IEz666lsZSApoJrluiCUnkDERHUYNU92etsFfiWP0DNhuFqgQPyMZWzIbTM8mytE5tfogyXLA==
X-Received: by 2002:a17:903:22c6:b0:1db:d42f:fde9 with SMTP id y6-20020a17090322c600b001dbd42ffde9mr16038641plg.41.1708589574353;
        Thu, 22 Feb 2024 00:12:54 -0800 (PST)
Received: from hsinchu15.internal.sifive.com (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id lf8-20020a170902fb4800b001db5ea825b2sm9412796plb.123.2024.02.22.00.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:12:53 -0800 (PST)
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
	zong.li@sifive.com,
	nylon.chen@sifive.com,
	nylon7717@gmail.com
Subject: [PATCH v9 3/3] pwm: sifive: Fix the error in the idempotent test within the pwm_apply_state_debug function
Date: Thu, 22 Feb 2024 16:12:31 +0800
Message-ID: <20240222081231.213406-4-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240222081231.213406-1-nylon.chen@sifive.com>
References: <20240222081231.213406-1-nylon.chen@sifive.com>
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

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index a586cfe4191b..bebcbebacccd 100644
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
2.43.0


