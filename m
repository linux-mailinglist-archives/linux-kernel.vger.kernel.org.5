Return-Path: <linux-kernel+bounces-161770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F418B50F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035421F220AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5DC107B2;
	Mon, 29 Apr 2024 06:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMiLs4QB"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80313FEA;
	Mon, 29 Apr 2024 06:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370842; cv=none; b=ORUS77MaFiYvnyeM0msYI3NNbD4b0TmUChdtukPVzifdL51R+p1sl4U72RCNMMfl8PwlX7lq5A7Ehplx3+QodmCx+lfzcx+bD3mMGyqbnbF+KyekizZlI5CSxYhKqXRnbgDfPGEmpJUtoYIrj/19quh8HJLkn1/oy3e7mw7MLNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370842; c=relaxed/simple;
	bh=joF5/wjl9ipS7kB9gvjwJ7rSwQULfKl5HQhL4zla8cI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DpbItIHURLhKtWEWX3XTpJ19dBb9VuOQegtQgTUrFoSgiiWgUDdCMv5XDk0MP7bK97KORKPoaiRPpfJnBpXBD6DBze0NZJHQ+C/zUVkeW7XqFHzZdPoAQzIVmVVB/lVOmHLrKXGNEa+ckrMzcYqOjrXreDGhcuM4zkkO7iPufRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMiLs4QB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e3c9300c65so33098825ad.0;
        Sun, 28 Apr 2024 23:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714370840; x=1714975640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TK0AmsxIvpdv+Eeo133AhkPR4FnsmSNMo4dv18n8nCg=;
        b=OMiLs4QBErLZ3hT54aBrZRIn6A2EPfs1NlIG06nApoLGY3DCpaZX0PrgceXsD+5MIc
         zChVZFdZbSkOtZH2OUuMDkz+kD5SJ7WiNhuw8mPfp3vds2PAd4elqYN9Naam6MsNnBB5
         qbqKJ8iv45LhyBgcAd1PEjc+fCuXAfPqidDxFeRiSI3nKGuQcfP4A22J9Gmaqmx1nNO9
         1cSO3ZY8ZLAkPrJmCsgAaCg+5I9mMELo1I5BELyqoWZlb+SWiE+Gu5DVZOwK5gOgyfsR
         dczdHqE2R2Kul0kCaQrLimoRfCKLLv+vZGcFukzYr8xx810/ZNQYRZ4sBtVqqBB9cZJb
         9JbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714370840; x=1714975640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TK0AmsxIvpdv+Eeo133AhkPR4FnsmSNMo4dv18n8nCg=;
        b=DilOMUcI2GcBFx+7+Vmo+gucSEZDjsAJDCvr7PIkAAKDDt4BynJhwybyKgd2aW9F/S
         MCK4TEXkT5GkxSbGAHntT09QbBWAyivWXJsWvRqjmoa0u1F4nUbRO2Dnj7hgI4JhZ2qs
         jIwg2OWhm3lN7JMLE/GKb47eKn0OKQvCK3aUoRJdnYT7fiAj7QJGgEGZwtRptn4aU79S
         fml6/IdPCMQFP2UAX0UvQRS3irfcdhm33JO/ydR02Hcco2zwXA9OPbcOXO3Hbq7w8K8T
         qOlCcK6b/+wszLqr34Jr+6FxM3rDsfBZRL7vTa+iLpvJVTxRIH0WD5vuDELjfp2kHpTh
         2TWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCja8wesgr+Y4EyL4LiVbH6dB8iUsnoPnOOl5zHwlJ1hq1+3Vsi6Bhu4C8LzDruLzXte370vB1GUTP5MS6jHq2Gdxe56akhkx6RHb7
X-Gm-Message-State: AOJu0YzVtjXg2KfdLWZADMouWau0/Iq3E+wwctFt9UhefV6rjM1UTX0d
	hZUE/Yat4Zz+FoVMYQFiYAspYky5NaK9fM18yvBusV6LtlWICAHb
X-Google-Smtp-Source: AGHT+IE7SJ/emkRX24/TfIxKkSLU5FziCF+b+tSBwh3UhlpSrf0dkAFv6oWkEXPc9LFx4HHDk2g7tQ==
X-Received: by 2002:a17:902:784f:b0:1e9:9fdb:567d with SMTP id e15-20020a170902784f00b001e99fdb567dmr8597220pln.68.1714370839787;
        Sun, 28 Apr 2024 23:07:19 -0700 (PDT)
Received: from localhost.localdomain ([1.200.153.166])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902820600b001e43df03096sm19402915pln.30.2024.04.28.23.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 23:07:19 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: KWLIU@nuvoton.com,
	JJLIU0@nuvoton.com,
	linus.walleij@linaro.org,
	jim.t90615@gmail.com,
	brgl@bgdev.pl
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Subject: [PATCH v2] gpio: nuvoton: Fix sgpio irq handle error
Date: Mon, 29 Apr 2024 14:06:42 +0800
Message-Id: <20240429060642.2920266-1-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User use gpiomon to monitor input pin ,if triger the system will call trace and rcu stall.

The irq_handler uses generic_handle_domain_irq, so there is need to remove irq_find_mapping.

Fixes: c4f8457d17ce ("gpio: nuvoton: Add Nuvoton NPCM sgpio driver")
Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>
---
Changes for v2:
   - add more description
---
 drivers/gpio/gpio-npcm-sgpio.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpio/gpio-npcm-sgpio.c b/drivers/gpio/gpio-npcm-sgpio.c
index d31788b43abc..136838c25756 100644
--- a/drivers/gpio/gpio-npcm-sgpio.c
+++ b/drivers/gpio/gpio-npcm-sgpio.c
@@ -443,11 +443,9 @@ static void npcm_sgpio_irq_handler(struct irq_desc *desc)
 		const struct npcm_sgpio_bank *bank = &npcm_sgpio_banks[i];
 
 		reg = ioread8(bank_reg(gpio, bank, EVENT_STS));
-		for_each_set_bit(j, &reg, 8) {
-			girq = irq_find_mapping(gc->irq.domain,
-						i * 8 + gpio->nout_sgpio + j);
-			generic_handle_domain_irq(gc->irq.domain, girq);
-		}
+		for_each_set_bit(j, &reg, 8)
+			generic_handle_domain_irq(gc->irq.domain,
+						  i * 8 + gpio->nout_sgpio + j);
 	}
 
 	chained_irq_exit(ic, desc);
-- 
2.25.1


