Return-Path: <linux-kernel+bounces-81227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ADC867247
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6499C28CB0E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FC0A2376A;
	Mon, 26 Feb 2024 10:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3OdbtUg"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6201CD1A;
	Mon, 26 Feb 2024 10:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708944875; cv=none; b=GRht3uwCzrcyJcyyT9PuY+1nkKXS2Kh3odADHW/FydOv7x2ei4KprO7ffMe0oDlwizaLJtnPBFTq8yJH5CdJQAEWEG2oBvKEAeoMggGgMPU0tyrmZgwM+1DyXRzIdKvhojkJ2KmeUthMcUnw6raIA8Cm0bOXshUm2/Gu+zu+DgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708944875; c=relaxed/simple;
	bh=UEyFZtlmbEFsxxE3dYm/WsIXOQgVd7MY92XcjEi7gfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pciu1fF54yo1yJ0I0uA6IIQ8weKv7fa447b0aiRODC7X9RhmGfXEXjztOKk3NGSOJFP7tH0m9xcNw5lWIO7a/ZCSpIDM73nahRprOrrrboi1PBCc6GwPxZbfNoWL+lsg0w4zaV70ueVSUc8tG+xRhVJfLiC/HPKNy4eb0yv69+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3OdbtUg; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d275e63590so33974761fa.2;
        Mon, 26 Feb 2024 02:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708944872; x=1709549672; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4x/fx2FWKopaj90n/fZEYnFZHtx6vndtcet4O9jVerY=;
        b=h3OdbtUgB7cYsnKso8eKu7ueKRlvHE5d7HEdvFgOOcc956/mO/n5A2K9fIJS3gXAMV
         wxA9D7yJWyF32JIyjI93dp22zqbzs/pHzoXn32pqmKJijqH8XX4JWtkvmK5H4XQEJfsM
         v3GQ/ZInkqsUfTzmfbMnERgY2xptuGvh8ET0B9cmH4cm3TG6/2IKvwNLqmOFgZrqwE34
         fUBLj1A++0guGupCyQZ41ggLEd8lyLJsWTtGDOHh21ZyQTK/eBD4HN9zhoz/ms8/5P2E
         Qb+MpyYzftEf+hfom7PhNPyvywPl/I2PsktFINx8AbFq63mx0s57bLDQQveQZjANgruL
         wZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708944872; x=1709549672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4x/fx2FWKopaj90n/fZEYnFZHtx6vndtcet4O9jVerY=;
        b=bd/o5zRYpsMmtTtveut3j4HU1TCox77wcmRPfJHl35hTBLf2BRh/x7W2swa/mKCMWx
         wf/tPIit9X1jgzi/qOwk4pj4jnZ5uIrFFUG6BJ3YcflKXS51XW1EYXidVKOg73pSxMhO
         3hDgSMHIKSpBv1xe1iY9e48JcJVWAQ4NDMEvQLZdKTRpFPuknRopSOiTfZruyhvNHIi5
         Jq5Hjs6J6Ynb+JZBbZBY7CVnebFLoYdY8HUAgOtTJfo5fa+Q7BNq6rqA4eH9s+fFGfZ8
         ahmURVx8kp6WwgMhXEtvfRMWl4gmVOlJ2d9wLeOcIx9bDXwBohMPLwrS+H/7a4HCbrcc
         YMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKF3pZzBlJnx+rj2EKjuwF0e3JartK/8WO5nLE5FZ+6+NQOyuUvuKoHBqCuqeJhnK8zGYPVlWVRX30Q5Q44+ENgx79ziEx1AzC+vg05GA0uQhpYgtyHqnLyC5a8fyBKUnZEgKrS4aVZg==
X-Gm-Message-State: AOJu0YycsGVOgJ+Thya1b0ob4oISQql+ohGbiOqBz2Kicf0amcJkhOKi
	Zb5cEbbeToHCXezqZY7jg7sL3qobUijo3jBS3ip2o2Ss4Nb6Mbh1
X-Google-Smtp-Source: AGHT+IET3jn8SGamOI83sQx2S5Qikz6HN/N4f1bViRfQGelC3yBVMlSVQWkmR9jmbm5sPPYCJauBuQ==
X-Received: by 2002:a2e:9ccf:0:b0:2d2:8bdb:4aea with SMTP id g15-20020a2e9ccf000000b002d28bdb4aeamr1219045ljj.5.1708944872241;
        Mon, 26 Feb 2024 02:54:32 -0800 (PST)
Received: from localhost ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b18-20020a2e4952000000b002d244bb2f99sm802946ljd.62.2024.02.26.02.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 02:54:31 -0800 (PST)
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mips: cm: Convert __mips_cm_l2sync_phys_base() to weak function
Date: Mon, 26 Feb 2024 13:54:21 +0300
Message-ID: <20240226105427.7191-2-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226105427.7191-1-fancer.lancer@gmail.com>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
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
and to use the weak implementation in the new function. A similar approach
was introduced in the framework of another arch-specific programmable
interface: mips_cm_phys_base() and __mips_cm_phys_base(). The only
difference is that the underscored method of the later couple was declared
in the "asm/mips-cm.h" header file, but it wasn't done for the CM L2-sync
methods in the subject. Due to the missing global function declaration
the "missing prototype" warning was spotted in the framework of the commit
9a2036724cd6 ("mips: mark local function static if possible") and fixed
just be re-qualifying the weak method as static. Doing that broke what was
originally implied by having the weak implementation globally defined.

Let's fix the broken CM2 L2-sync arch-interface by dropping the static
qualifier and, seeing the implemented pattern hasn't been used for over 10
years but will be required soon (see the link for the discussion around
it), converting it to a single weakly defined method:
mips_cm_l2sync_phys_base().

Fixes: 9a2036724cd6 ("mips: mark local function static if possible")
Link: https://lore.kernel.org/linux-mips/20240215171740.14550-3-fancer.lancer@gmail.com
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- Convert the underscored method to a single weakly defined function.
---
 arch/mips/include/asm/mips-cm.h | 13 +++++++++++++
 arch/mips/kernel/mips-cm.c      |  5 +----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/mips-cm.h b/arch/mips/include/asm/mips-cm.h
index 23c67c0871b1..6cc79296c8ef 100644
--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -33,6 +33,19 @@ extern void __iomem *mips_cm_l2sync_base;
  */
 extern phys_addr_t __mips_cm_phys_base(void);
 
+/**
+ * mips_cm_l2sync_phys_base - retrieve the physical base address of the CM
+ *                            L2-sync region
+ *
+ * This function returns the physical base address of the Coherence Manager
+ * L2-cache only region. It provides a default implementation which reads the
+ * CMGCRL2OnlySyncBase register where available or returns a 4K region just
+ * behind the CM GCR base address. It may be overridden by platforms which
+ * determine this address in a different way by defining a function with the
+ * same prototype.
+ */
+extern phys_addr_t mips_cm_l2sync_phys_base(void);
+
 /*
  * mips_cm_is64 - determine CM register width
  *
diff --git a/arch/mips/kernel/mips-cm.c b/arch/mips/kernel/mips-cm.c
index 84b3affb9de8..268ac0b811e3 100644
--- a/arch/mips/kernel/mips-cm.c
+++ b/arch/mips/kernel/mips-cm.c
@@ -201,7 +201,7 @@ phys_addr_t __mips_cm_phys_base(void)
 phys_addr_t mips_cm_phys_base(void)
 	__attribute__((weak, alias("__mips_cm_phys_base")));
 
-static phys_addr_t __mips_cm_l2sync_phys_base(void)
+phys_addr_t __weak mips_cm_l2sync_phys_base(void)
 {
 	u32 base_reg;
 
@@ -217,9 +217,6 @@ static phys_addr_t __mips_cm_l2sync_phys_base(void)
 	return mips_cm_phys_base() + MIPS_CM_GCR_SIZE;
 }
 
-phys_addr_t mips_cm_l2sync_phys_base(void)
-	__attribute__((weak, alias("__mips_cm_l2sync_phys_base")));
-
 static void mips_cm_probe_l2sync(void)
 {
 	unsigned major_rev;
-- 
2.43.0


