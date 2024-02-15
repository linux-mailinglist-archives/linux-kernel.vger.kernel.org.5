Return-Path: <linux-kernel+bounces-67386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2FE856B07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2267FB2B558
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B931369A1;
	Thu, 15 Feb 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0EBncya"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA8136659;
	Thu, 15 Feb 2024 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017476; cv=none; b=XwWo1+DZW86qe33pX5qgizyiNu0jP5lQ0oZB0LEUA3Ob6JGqREfe+gb46ENRAzjBipq75ZsCOkkOVuhgmrCTAt0JDf+pBfwjHcJOLjGXE3f8mtDbhiCygNtZV94X0lBvs/vkqvOpVpXJGnMBgb80C4s50XX3l2sIWD5wpjf/ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017476; c=relaxed/simple;
	bh=eFdJHcujAkNakHE9cboLrLydtuz4OsYv+UTx701ru4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q8f3lf1sZtcnqJ5f5x/sD+a9t89nOL7ILCFlbSb25AfXsKqk0AtAPIcxQ2WdQKTHe66Qu6BLzWpRQgDbOSDjWKVWbP4w+ens0xHvJc9QFfwXtyi93hk2UdsMLIccjLlcws5Lm8FwvIwOghPbhQbZ4FnDT9apHxGqPZfq9tQ9pMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0EBncya; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51187830d6dso1340345e87.3;
        Thu, 15 Feb 2024 09:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017473; x=1708622273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaEbk0wqkJrGhQpGNqYgT1jXkOwl5keUz4UPTBa9rB0=;
        b=a0EBncya+Mb5Ju/G75yymiTprr0j1f/yzhsXiAI+NFeo4QjVtioXb5qSH/f3BoDE+p
         6bM51BG5IdYXtfQrtjKnPdfm39T581DAUt1UySOc6pRW1dsViJxueeZtbltg/3xTV8gh
         1oG7TA9AA81/geIgfq8L9YCWiIqxYQTBUhu34FUC3KArBAV6cqcN57epCzskA45HQ8L2
         We9l6S4oRNGkCk3srBN/VmdS/T7pUKi5s4rYj8qgXt0rZtTf5hrr2cbHQ/T7/U8LsOXb
         GTz7it5ggjhWYvbnSuP2NCcLaNGWAOuTnISz4ZkanS+FgT4Xm5rWTb2EZ7RT5AnyXnHg
         yVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017473; x=1708622273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaEbk0wqkJrGhQpGNqYgT1jXkOwl5keUz4UPTBa9rB0=;
        b=plbjCFxbEbpdmHIHiqkIMbnoV+bvGvjICdPc8lUQpRsAVTFGEyOfDzUD3TPvpur+GG
         eERxHGpxf4rWYgF5ZN2mv3Ouy9cmgsnbM4fE5jT8z8mqfzFAvt4fiWIXHlv0v9wqQr61
         PwF2H0edP8B61lVhXWIQ/3doyOH7mOM2V50rccScO64Y7R6nUFAU6GISDBdBUy/8o8nm
         FDrlKYXnCUVwpkTOZMiyS84LCnTrlQR6q3QcMpRDfdPf6EVm7NYZci7qK2jFx85ayjqB
         DP9XR55TYuWWymN5BkOOO7S6uQm2leUdF77YYclu1aF5gNCjGxlg55vNl50FIuCi7KDc
         86xQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRY1xF37tyTAHkTc+iAH2sDJrRgrJY7uMlDwGZyX63zIpXD1RO/10/iKmJfno8HCCS9XkVswxsBUdCEt3oCIdyTr74T1sQ34NAYag8ZHo2KXEhxhsYhimoxJ8xRsVtcxw++LJO8QOXXKcRtjGrTt33puC3iFmBBzFuJOQUalooZZmJ/CgJaA==
X-Gm-Message-State: AOJu0YyzQyCYKzSA+dk2kOHUqVLM1CppO4E3/B5qJ/enHioeyrIzqehq
	A2mG4bLmxB0fW8o/J3LDsRiPpbfR/geBS3BRF4jZwb14USvLtNys
X-Google-Smtp-Source: AGHT+IFMr1H/s0vZe8v58QQjJIManCwLDRihaLF2e2KpUTKr2bawlYNng6CXmVKXbAWB0AJ7Q2D2ug==
X-Received: by 2002:a05:6512:1152:b0:511:7ebe:b160 with SMTP id m18-20020a056512115200b005117ebeb160mr2239460lfg.45.1708017472483;
        Thu, 15 Feb 2024 09:17:52 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id p17-20020a19f011000000b005118f61ffb3sm309458lfc.233.2024.02.15.09.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:17:52 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	Stephen Rothwell <sfr@rothwell.id.au>,
	linux-mips@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] mips: cm: Add __mips_cm_l2sync_phys_base prototype declaration
Date: Thu, 15 Feb 2024 20:17:26 +0300
Message-ID: <20240215171740.14550-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215171740.14550-1-fancer.lancer@gmail.com>
References: <20240215171740.14550-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The __mips_cm_l2sync_phys_base() and mips_cm_l2sync_phys_base() couple was
introduced in commit 9f98f3dd0c51 ("MIPS: Add generic CM probe & access
code") where the former method was a weak implementation of the later
function. Such design pattern permitted to re-define the original method
and use the weak implementation in the new function. A similar approach
was introduced in the framework of another arch-specific programmable
interface: mips_cm_phys_base() and __mips_cm_phys_base(). The only
difference is that the underscored method of the later couple was declared
in the "asm/mips-cm.h" header file, but it wasn't done for the CM L2-sync
methods in the subject. Due to the missing the global function declaration
the "missing prototype" warning was spotted in the framework of the commit
9a2036724cd6 ("mips: mark local function static if possible") and fixed
just be re-qualifying the weak method as static. Doing that broke what was
originally implied by having the weak implementation globally defined. Fix
that by dropping the static qualifier and adding the
__mips_cm_l2sync_phys_base() prototype declared in the "asm/mips-cm.h"
header file.

Fixes: 9a2036724cd6 ("mips: mark local function static if possible")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Note seeing there is no user of the pattern described above we can convert
it to having just weakly defined methods. Let me know if that would be a
better alternative.
---
 arch/mips/include/asm/mips-cm.h | 14 ++++++++++++++
 arch/mips/kernel/mips-cm.c      |  2 +-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b1..1f143dfad7a2 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -33,6 +33,20 @@ extern void __iomem *mips_cm_l2sync_base;
  */
 extern phys_addr_t __mips_cm_phys_base(void);
 
+/**
+ * __mips_cm_l2sync_phys_base - retrieve the physical base address of the CM
+ *                              L2-sync region
+ *
+ * This function returns the physical base address of the Coherence Manager
+ * L2-cache only region. It provides a default implementation which reads the
+ * CMGCRL2OnlySyncBase register where available or returns a 4K region just
+ * behind the CM GCR base address. It may be overridden by platforms which
+ * determine this address in a different way by defining a function with the
+ * same prototype except for the name mips_cm_l2sync_phys_base (without
+ * underscores).
+ */
+extern phys_addr_t __mips_cm_l2sync_phys_base(void);
+
 /*
  * mips_cm_is64 - determine CM register width
  *
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 84b3affb9de8..3f00788b0871 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -201,7 +201,7 @@ phys_addr_t __mips_cm_phys_base(void)
 phys_addr_t mips_cm_phys_base(void)
 	__attribute__((weak, alias("__mips_cm_phys_base")));
 
-static phys_addr_t __mips_cm_l2sync_phys_base(void)
+phys_addr_t __mips_cm_l2sync_phys_base(void)
 {
 	u32 base_reg;
 
-- 
2.43.0


