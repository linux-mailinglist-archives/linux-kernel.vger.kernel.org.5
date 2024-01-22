Return-Path: <linux-kernel+bounces-33042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A752583639D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C5CC297A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158AA3CF78;
	Mon, 22 Jan 2024 12:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DRinTAZ3"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EC73A8FA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927374; cv=none; b=OIPz/rK3tYtDetGWmPPPTD8f/Gf60WhKjTbz7b1Ty4oGV6bC3pDSmE8C9O21wQ2a/S4p2W0bC4OiyOWNYUMpOTSZJ/1VVAwHfhCdUO8gnLWjK/2ogn2p7p8DN12HVTduBQpm7ohO0BdqYitKu4xWc18MJLoksitHkRqxsytH+BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927374; c=relaxed/simple;
	bh=qQusp98fDKL6XEvrEMTBwUXyqLgUpEHAm5Bh8eE7yXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CklYkLozK0bqvzrqGtMfe9eYjNogXVfZCS26mJJDMa6sAmLdXBji72480kZQm/yZoithybMq/JITsPA6kEfr02MBWM397AnLee/bfPakkph+ceQAta+8kIXzU7+yuzJ+LuUhaIhekLKd1kdTJTYK7b0KoRFYEls2xY9gF5//rRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DRinTAZ3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-336c9acec03so2735684f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705927371; x=1706532171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ckRu1igyABT1yYhLwRfuP0jDinbnZSUDI6tIkabXps=;
        b=DRinTAZ3xgOHKEbGgqhYJWvKQGMkhGJ4shMjR9jixxJ6wHeT3fvP+NQ7fFFEX4xvgm
         s6GZGLzaqQbvJMwGsMMyzBMcx51wsAfUvDew2GvVgjmGtcJlwlYCFhjm4DYxhXi2zBkK
         Zwpb/rVOnd9AUt4mGrj8MeU0Heb0GTPqph6xQ6eRBWcPzrTDi//8Dazknyi4PzJN4mle
         a6AinRoVkiEjQFtFnliRhY9EmVfHHcXb0FUM6ksEr8LKk17AhKTg3GizMJ6jsW3U6mRA
         0w9NB7IGdzS41UutL7rpjia8BX9EFrLU721IWQ4mblLVWWo60FiJa83Pe+yAZNa6aW05
         MrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927371; x=1706532171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ckRu1igyABT1yYhLwRfuP0jDinbnZSUDI6tIkabXps=;
        b=shuqlc0zxH3LQWMsQCmwrNwDrlzfDENRzez6wAPUXGIZzsZK8CCGhDToylRMPBEl5M
         +fQJAWlrf536CG3AdYlod3ZFoIJ3rCOrfNUw5UaTvVW2uKgdrR3IlTG7rWlqJjOsc4+a
         Z20FMJ2h5EK0niGq3vKBbyA5qF3IOwWXTUuYK10fv5ZtEdwXLcMTHRc5J6NGclt3duiC
         Ey0cVj/NlaRWPx/3xma6EtOeYPnwneeOWGVaTIpF2e8Oc0qM5VsQ3zsruGZtjJcsE6u1
         ahcUns8lWmSc0qAbFPDyFss9Anfz3eAbzkXtLMhwqFtb5V6WzsrlFic6PtQvgyQRHIC9
         4oSg==
X-Gm-Message-State: AOJu0YxWVCXbGQNmToao6Vg/BNcr/X4Qixr1/Z5fqPYbFCdXKUP6+Sc/
	t/VB7UR1fAYz8vQc/heRNnwszm4TLIXINiY10W01D6hLKsQ6OyGIQaXSfYPFnG0=
X-Google-Smtp-Source: AGHT+IHq/0RLosd/FyFjcYflErcXHe9D/2h7BZNC8le4JLun+bCTbAADVzuruPdOyXA2CdEbBWQ3qw==
X-Received: by 2002:a5d:46c8:0:b0:337:beb7:26fa with SMTP id g8-20020a5d46c8000000b00337beb726famr2082884wrs.87.1705927370832;
        Mon, 22 Jan 2024 04:42:50 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:92a0:6172:d229:1898])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d5110000000b0033763a9ea2dsm4671771wrt.63.2024.01.22.04.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:42:50 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 1/4] bitmap: define a cleanup function for bitmaps
Date: Mon, 22 Jan 2024 13:42:40 +0100
Message-Id: <20240122124243.44002-2-brgl@bgdev.pl>
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

Add support for autopointers for bitmaps allocated with bitmap_alloc()
et al.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 99451431e4d6..df24c8fb1009 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -6,6 +6,7 @@
 
 #include <linux/align.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/errno.h>
 #include <linux/find.h>
 #include <linux/limits.h>
@@ -127,6 +128,8 @@ unsigned long *bitmap_alloc_node(unsigned int nbits, gfp_t flags, int node);
 unsigned long *bitmap_zalloc_node(unsigned int nbits, gfp_t flags, int node);
 void bitmap_free(const unsigned long *bitmap);
 
+DEFINE_FREE(bitmap, unsigned long *, if (_T) bitmap_free(_T))
+
 /* Managed variants of the above. */
 unsigned long *devm_bitmap_alloc(struct device *dev,
 				 unsigned int nbits, gfp_t flags);
-- 
2.40.1


