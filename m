Return-Path: <linux-kernel+bounces-67388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3B856AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629C71C22A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908DD1369AD;
	Thu, 15 Feb 2024 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdHbLKkV"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F0D137C21;
	Thu, 15 Feb 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017479; cv=none; b=iKvOyKJhHMsPN4F8hURG/g1y7d+mdfl8kQhckW7er2473RUifQ4fPYkM/7ZFNK0E7RdDx+qynLQWQctOKXzpTCDjrgeTa9xH1BEprq9gj+FqF6+c22JJsBkg9tSFxF98IYZheHkqOc1s2fuqnUBKgGMF83js999PYgOoJ/LNJ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017479; c=relaxed/simple;
	bh=1cFvs/yZBROdCDOH3bBEZnxHv6CCc4ReMbEKdtps5dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cmtsy79BJny1qA9OLvoagb+G4INxkl3dQSxKRz+axKZK6QcR5H3PaboOtpsBWspijSuh0O4X5juOciHbDrWWdQu8Fz2uhDY6piiEik5UF/tfhzRVtDKPg7c/V7w5zW6wFRyje5UQ7Qqz/rfZPRnQoTURWEV/vHYHw2CeGLyY7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cdHbLKkV; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51197ca63f5so1467199e87.1;
        Thu, 15 Feb 2024 09:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017476; x=1708622276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j2TlmYMB0WpVBSNLXRrWkXu6rdw2V73xcSAet+Oj5o=;
        b=cdHbLKkV60acE+19IiFy6KnaIRrjj+Es8gqarIXrQuQB8jyKWvxLvBo9oy2GdrxUZI
         UJYXkQNNs289L2mW31E09UgkZ+BCZu0dkVDh743Z5M3zHX4ZjI+8MTU/LGmOy9LkCt8i
         cR7GufIysw8PT+cL41jxZaNot2cG4lQLg0zsqV1adqEJHKaq2RcVsDoS4STl02n6+xo1
         Z4CxSFAh3M3KZ5iJ+6QM91zfupk+CWVP/3oUzFIQHaVIZ1bGHmGHbBSfupEa1SjrhXZu
         ax5w5lE/3NyOg7r4rFUaeM/5+hzA371JNMLLfTqnWg9YlobprR1fRHxUYYmJVto7ZpSF
         v4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017476; x=1708622276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0j2TlmYMB0WpVBSNLXRrWkXu6rdw2V73xcSAet+Oj5o=;
        b=W3ILaWQ0dPRYq8Bb7pKYieXpN+CedIC5+TCgZdAIwHZUXP4KDGwy8S04h0rSzG0PcL
         2GaGvsTY8rNQZ0F9Jrl6NHkGEXXCEbLRbXvQyYaXEatSlxInyQNgWEALSlaWQOav8crw
         pToSdAk0PH7eoG/pw8lAZFtgPoiEoxjjgL0C8JI75j37afFvV16QWZzkZY8qCfZPkzWG
         1RnVb1wwrZnpgIOc24iJPd+oQbpX11L4ngxTTpEp/u7t2qf0Odq7jMYUDg/pE/laYovy
         FCiqaOmN0y0UgyFL8a1RssNETnM/5h2Q0UmZsxI8nIHpXfAXrzEyMGCwKj9asntGvzyR
         6DxA==
X-Forwarded-Encrypted: i=1; AJvYcCUTiKE0EmHCsnQORF/SRC7VjmtQlHnsLKmKutzSsJdeh8Che8CTvZqZBPj1Q1ZJQAwiDFvUfmxYa/kq2i/4JrnNtEeYOlp89i8EqTCL7i7zldYXBfDU+m+mPi9j7eK/1i0c7cZWQTvQRpimMkmd77wvRpcHbUB0qPbnueyWo7j+UbXY1nRkcQ==
X-Gm-Message-State: AOJu0YyAXKI4oYLvwASG0AT4rvtg3BsE2gQ66uQuZL33EGLjHvCY9csk
	goOdFRuEY3/0k0vWoKd8GHGpn8rqpAiTtGQLaSBGOAkvcIwHHwHz
X-Google-Smtp-Source: AGHT+IGoO+RXYgHQLbgqjhVJRXkBUTgbP71wwTsa/RJMwTYGWhGWzBPYoo3JwDsgzbTfrBBCB0fJsg==
X-Received: by 2002:ac2:51aa:0:b0:511:69bf:d1f7 with SMTP id f10-20020ac251aa000000b0051169bfd1f7mr2089806lfk.50.1708017476028;
        Thu, 15 Feb 2024 09:17:56 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651234c700b00511503f9ac5sm308277lfr.231.2024.02.15.09.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:17:55 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] mips: zboot: Fix "no previous prototype" build warning
Date: Thu, 15 Feb 2024 20:17:28 +0300
Message-ID: <20240215171740.14550-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215171740.14550-1-fancer.lancer@gmail.com>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Without having the putc() prototype forwardly declared the next
build-warning is printed:

arch/mips/boot/compressed/uart-prom.c:6:6: warning: no previous prototype for ‘putc’ [-Wmissing-prototypes]
..

Fix that by adding the "decompress.h" header file with the putc() function
declaration to the source files which have the method redefined.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/boot/compressed/uart-16550.c   | 2 ++
 arch/mips/boot/compressed/uart-alchemy.c | 2 ++
 arch/mips/boot/compressed/uart-prom.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index 09dcd2c561d9..db618e72a0c4 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -8,6 +8,8 @@
 
 #include <asm/addrspace.h>
 
+#include "decompress.h"
+
 #if defined(CONFIG_MACH_LOONGSON64) || defined(CONFIG_MIPS_MALTA)
 #define UART_BASE 0x1fd003f8
 #define PORT(offset) (CKSEG1ADDR(UART_BASE) + (offset))
diff --git a/arch/mips/boot/compressed/uart-alchemy.c b/arch/mips/boot/compressed/uart-alchemy.c
index 8ec63011e7dc..003967c084b3 100644
--- a/arch/mips/boot/compressed/uart-alchemy.c
+++ b/arch/mips/boot/compressed/uart-alchemy.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/mach-au1x00/au1000.h>
 
+#include "decompress.h"
+
 void putc(char c)
 {
 	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
diff --git a/arch/mips/boot/compressed/uart-prom.c b/arch/mips/boot/compressed/uart-prom.c
index a8a0a32e05d1..5fa3b9945333 100644
--- a/arch/mips/boot/compressed/uart-prom.c
+++ b/arch/mips/boot/compressed/uart-prom.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/setup.h>
 
+#include "decompress.h"
+
 void putc(char c)
 {
 	prom_putchar(c);
-- 
2.43.0


