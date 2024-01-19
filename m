Return-Path: <linux-kernel+bounces-31628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C8F833177
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 00:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2137F1C2242D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 23:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E85B59147;
	Fri, 19 Jan 2024 23:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9Mey18p"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10B1E484;
	Fri, 19 Jan 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705706795; cv=none; b=rzlDXcJdjtajPgI3TN428+muxp1jC0tRsvG7CLkBB5pN7FAaTBdASY02YWuIuxVagoiIwTsJCtF8fp39Du1d0JvV6So9bOHaEpYSa3UkvSsgIBJ5DUARbye9edjfQwbdFBjIE1oVwGJoceljBga4ox6uFJy8+KMgH6f4qXXYxuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705706795; c=relaxed/simple;
	bh=/b7XbxIYbAPBG+nwiZX8T1zbq6IDXVnJIcZiWY7bUEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ajb7lK8IZsIHkAKzKbRCBaiSywvMuoXF9aiSCwlhfqm0/YkLiBlYfBnqLSc2ifkYKSR9efEUBA8MPeCwyYOd0Se9ZC54bjKmczPGXyaikw+1J2yQwZhJFDb/qQtg7n3rcqBQL26eAVSAeR7fZ7Ys/eb64z8/nMJdK7YHgNE4YGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9Mey18p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so13535235e9.1;
        Fri, 19 Jan 2024 15:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705706792; x=1706311592; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wZK+516K0XpuaX6YHVhJjzhdI9/8JfrLsvg1F0YHkg=;
        b=m9Mey18pW+OJnEWftyltag+ZBF5dZaKjvcQlMwJeIrtb8rrs1ExJB62TxsHfRZaYkk
         8Bhrx3DYhy91CLZ/EGyAhaoXd6mclUvhdsSWgE3oErLVEMDkdu2QzvNPpo36l9B1x+d9
         O78feCZxUzS8g3BkHmBtBl4BcN0l78sYAOY1RMi+jVJykCcuAwlutxven7yYl69BsQyN
         A76DYMNGZwcUxzYqH1oCunYsOGJqKJKiM/EhDIZJco5DuFaTxDC2bvJv4rsMk/3h0Uzn
         TjUfwbVrG6xKcIGgSnmVeh/oCX0o7ORRmT9teLZugy7NbOez2vR5yKS+Ef7oiO/Rv8vp
         zQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705706792; x=1706311592;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wZK+516K0XpuaX6YHVhJjzhdI9/8JfrLsvg1F0YHkg=;
        b=ldK43NepEJPnwoIx253I63JIpLUBg4unkKc2uOEq1so2S+GMKxSaZ9JOIzhEcndHOC
         lUNlZSH2MZl94yAdxCryeiaBzuOq8OGBlMTeCm8g78w1oxY7uZS9R8cBdWELJr1O6TFl
         6Yp8iqvQxko8oo+U/hmrp3z6/0tkOut9BBsdWpm2ZJZOV+g8eNSSTzzPCZ/mYx0jpjAh
         iBkmzSqJMrtAQpiKar/TV6WT/8yEK6UrwdapUfgTLkhNRdGY7+J3gpv0Z0Qv+yk+Dmja
         zvQ0NsiMQHeLBGKa4+Y4FApMbe4anD634XmBA8S+6IxoyDstHL6g4ol7AFmqE/BZAJd9
         pHNg==
X-Gm-Message-State: AOJu0Yyfl5dv+IX1mvNyN/+/yRhrXASkaS/k341DXSRRfvX3sJhMzRSu
	l5+v2ER6t5w/3THH0t1o8sENwPRYxY77bleDrfBsdWSKUpmbinLL
X-Google-Smtp-Source: AGHT+IHMKimO5Hsr9aIwhnd/9SE4aiPdxps8Eal5zD6k7O6Y+UUxyI7VM85mlOtZgV9WPD8Rgbmv2w==
X-Received: by 2002:a05:600c:4fd3:b0:40e:5581:511a with SMTP id o19-20020a05600c4fd300b0040e5581511amr304286wmq.2.1705706791884;
        Fri, 19 Jan 2024 15:26:31 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id n4-20020adffe04000000b00339272c885csm360875wrr.87.2024.01.19.15.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 15:26:31 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Pavel Machek <pavel@ucw.cz>,
	Lee Jones <lee@kernel.org>,
	linux-leds@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] leds: aw200xx: make read-only array coeff_table static const
Date: Fri, 19 Jan 2024 23:26:30 +0000
Message-Id: <20240119232630.2752239-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Don't populate the read-only array coeff_table on the stack at
run time, instead make it static const.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/leds/leds-aw200xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
index f584a7f98fc5..6c8c9f2c19e3 100644
--- a/drivers/leds/leds-aw200xx.c
+++ b/drivers/leds/leds-aw200xx.c
@@ -282,7 +282,7 @@ static int aw200xx_set_imax(const struct aw200xx *const chip,
 			    u32 led_imax_uA)
 {
 	u32 g_imax_uA = aw200xx_imax_to_global(chip, led_imax_uA);
-	u32 coeff_table[] = {1, 2, 3, 4, 6, 8, 12, 16};
+	static const u32 coeff_table[] = {1, 2, 3, 4, 6, 8, 12, 16};
 	u32 gccr_imax = UINT_MAX;
 	u32 cur_imax = 0;
 	int i;
-- 
2.39.2


