Return-Path: <linux-kernel+bounces-33043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF5D83639E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 402A31C2332D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECBB3D0C8;
	Mon, 22 Jan 2024 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="LZcacmy7"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED373A8FC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927375; cv=none; b=KJj1TQIt2+vLcoyyji35sOqG8oAJ1IlE6m5O5nfFLHgzlEkPgH3LlptA+IDgpReoN2P6yIg8jgP0DwmgOAJCskz9LZ+lRf+rXaqNjlw0Ken82++1j16qEDtV7WI8IB5v3I2axsuV/U77zrgjgs8eKzcxt/xJjq7BF1iUxxGdJKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927375; c=relaxed/simple;
	bh=/HB819CWl4exgAM4x006PP6pwpOtqG44H5UW5U3dNEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qiBzabl0A+lFysjUZc0BLBnp0v6bQtmdNybFkD1izmY9qBX7Li/spvLkkJuvPhyPiutdqWwmow2TZxQ/AB3rO5gIh86DkK7L55oA0u5wjGw8ZGVsoGwANjP0FdWy+j515bM0RrEimJ8zhFCwdKUqjioif6Oao3UhaT3KIHPy39A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=LZcacmy7; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33921b8988fso2730436f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705927372; x=1706532172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhF5NthBM2Es9ERveXoYfwPd/Rxqijhgw0U1wdCYWbU=;
        b=LZcacmy7w01LTQF6ui7k5qp0fGwlwl5Grol2p0UgAeOla6sc/iyC8/dliNEdG4kvb/
         /c7HeCwywnS38bxSxF9q1sKgE+3WzIdOfsyRpv3xIcWSO1X0l6AVUqBJtgpYItn8LIHu
         CSvEZ1KDwQyZWGDyY+ORI4CH4FrW4L0hk//R0WYqULcWFgEakD7uvjaujSdIGbckOds+
         rGba3Ty31Vx7+5uoAtnNEHbgDXkk4xQpU0ormtzWhUEAJB04XeFT0ThMu37IYeYpSgnv
         2qCxP5Yn+lBPiF+Mk81+wbqpoklykSP45Tmw1mU6/0/SNy3baXo0NO3qcOMpJeXRNrUo
         ndRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927372; x=1706532172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhF5NthBM2Es9ERveXoYfwPd/Rxqijhgw0U1wdCYWbU=;
        b=LKRho6fx/Cn0elrGdYjTOKkoVOe9YhZLUyYiF162AIvFAMQkLsAwZILDyeDsQXahcu
         o71rEvZM4SgottT+1/gJ9skcvzApzbZUvihhbIm+GZaM7TYNMHPN5yyEePW5ibSLhXgU
         7jEFoHOefrYpPWtddqM5jLHhRofHV01gLzF29UBg93hTICOwUzUtqIADGsdomamLmsPN
         JvubsP4Z2urezYaFlOeWUJFcoC7zeJGQgW65mz+YBMxSaTHYnqqJYfv/DQuJcPCMZ1zX
         ZNgJ82lpDWeAzwVoo7AIW4Q1iVKk1BZp8413xzEcrLlXbsrZp3bUMtAFHjsN5TQZZB0S
         wtxA==
X-Gm-Message-State: AOJu0YzIhtiVupxYhqtkOTO69Arjsaq/aeyGtX9z1Cv65h2WvEGsKmrm
	qT1cnLTAfxP2h9PaWUyOhveA2TCFHnKPTlPCh40EiVWJJtQvZbGREfLckmZBZYA=
X-Google-Smtp-Source: AGHT+IHetdjgfjLx+FUl/hYVY74FiBlnQC4qW30Vb86Cj/TzXcQH8909ffBu6LbW12K1CVDXPUBSxQ==
X-Received: by 2002:adf:e8c7:0:b0:337:5997:a4f0 with SMTP id k7-20020adfe8c7000000b003375997a4f0mr2179168wrn.9.1705927371693;
        Mon, 22 Jan 2024 04:42:51 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d5110000000b0033763a9ea2dsm4671771wrt.63.2024.01.22.04.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:42:51 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 2/4] genirq/irq_sim: remove unused field from struct irq_sim_irq_ctx
Date: Mon, 22 Jan 2024 13:42:41 +0100
Message-Id: <20240122124243.44002-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240122124243.44002-1-brgl@bgdev.pl>
References: <20240122124243.44002-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The irqnum field is unused. Remove it.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 kernel/irq/irq_sim.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index dd76323ea3fd..f5ebb3ba6f9a 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -19,7 +19,6 @@ struct irq_sim_work_ctx {
 };
 
 struct irq_sim_irq_ctx {
-	int			irqnum;
 	bool			enabled;
 	struct irq_sim_work_ctx	*work_ctx;
 };
-- 
2.40.1


