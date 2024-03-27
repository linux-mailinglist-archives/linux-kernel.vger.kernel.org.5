Return-Path: <linux-kernel+bounces-121938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98DB88EFB3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB03B1C2BC31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7115358B;
	Wed, 27 Mar 2024 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Ga9h2/Ay"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B17153518
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569727; cv=none; b=uFmqws1PkyD3K358CFmHIbt/WVpE/XYYqpYpazuA7Inh7zLqBi66HD9ftz+LPgALu3G7zX6FCi1WiqBe8TiAHmedIx60sVyztS5CqVvI2IV55gU4BTzn8rPW5yRsm5/TBY2ZnI/OCs01r+whw03tCzgGzwHA9jAEwF1oBWeHuQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569727; c=relaxed/simple;
	bh=9cqIF+Bi5JTCjT1ojFORS3NgOriFIL4LCNqqaGMHGzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXz33Fm370ObR3q2JwdmOKP3y2ENKcsXTEzSeMiBOetiLK+i4GFV7xiWf48DE6xgka2qoovixvHS3c4U3jCKItqelK3qq88ynhjvWjEPwLcPtZ/LqXcLgWKMZ5OcejevvP1qAMPXkkFqL8JruthPw7MF1YlNxOOiBGiAkt4qEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Ga9h2/Ay; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0b889901bso2370695ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569726; x=1712174526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9egB7QSoDAHRW6tgRYqVd+NUTiSQfL/JcKX7OjtD5w=;
        b=Ga9h2/AysoHBXC7z7wljFYPrdG0LrwrjAYe6MrT/ZDEcbQCZ/WFc2OTWc9x83RGAIF
         tCz0nY6SMtBtxranarM93mAB/XRL9HlA6ufuFkaCBnM6aqO60mypo2A2lIjmKQPF8KXt
         x8kZrKz2fcEWAXV3QMZRzmnO9sk6xBkizoyb1O1MkYSQ6lzqwfYaaXpCKL0WTrrMoT84
         48VfuwTHVpbbvwhGZGi4SlIPv/iL8MpN6kWx2pIUrnrVHsdjSpAcYSL3eUsx3N4nwcId
         SiAojdTOPq+DSpgySv69L3NHQbIYTe7wbUJ6OFwSkgjxAJKaYmt+rM9GQiHUJIoo3ukf
         t7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569726; x=1712174526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9egB7QSoDAHRW6tgRYqVd+NUTiSQfL/JcKX7OjtD5w=;
        b=WGUBpu+d6nwDhk8j6KBsL3a4SKWFFWUSD6inT5JCYh1KCCxoiMlqtCT8tBaaYQpgBe
         c5nWXrUYjPeK1cz9naIMVz9yzv2NSHc/gJVr1/XLr8fcfM4fLS7cIkPlsLkrI2ml2TkM
         a9H87vbdciIHJoC9yPyGpZ/yhXj0cWlzYCRQgcE9l9e53Of/RpvVNhZe1NqcTgoZaHvZ
         kFwq8TjIA4xHir3e2tzBG5DvO6xCl7h6PyqEsqXZlgPbdaGEQkQGZvRKXAFPR9U94ZFT
         4JahsPwezKe1bvl0cANnCL1gQ+2hNPOlOXplgV8a9zxPhzb1dJsdR78sCeSdIEQXPfqZ
         NB1g==
X-Gm-Message-State: AOJu0YyjNGEEgfXXcsNYCs8Sx035Bnx0QcgG6f/xswfNJf/TV5VXceQE
	3jfv+NYoXvjFNAnEAEGDZvK4Qcgikk+ixCKupO/HFK1YKiBz1y6FIM9cEhpE4pQ=
X-Google-Smtp-Source: AGHT+IFGHdi74bAZSMUCS5nBpcP7LI5Cfqz6VZFaIDx36rlYRojmLVaB4TIyZga5IdN5tuwaxR1nKA==
X-Received: by 2002:a17:903:2b05:b0:1dc:a605:5435 with SMTP id mc5-20020a1709032b0500b001dca6055435mr854470plb.31.1711569725718;
        Wed, 27 Mar 2024 13:02:05 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:05 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH v3 05/14] arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Wed, 27 Mar 2024 13:00:36 -0700
Message-ID: <20240327200157.1097089-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that CC_FLAGS_FPU is exported and can be used anywhere in the source
tree, use it instead of duplicating the flags here.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - New patch for v2

 arch/arm64/lib/Makefile | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 29490be2546b..13e6a2829116 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -7,10 +7,8 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 
 ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
 obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
-CFLAGS_REMOVE_xor-neon.o	+= -mgeneral-regs-only
-CFLAGS_xor-neon.o		+= -ffreestanding
-# Enable <arm_neon.h>
-CFLAGS_xor-neon.o		+= -isystem $(shell $(CC) -print-file-name=include)
+CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_xor-neon.o	+= $(CC_FLAGS_NO_FPU)
 endif
 
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
-- 
2.43.1


