Return-Path: <linux-kernel+bounces-139331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5E08A017F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4195E287160
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71248181CEF;
	Wed, 10 Apr 2024 20:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct3uKmVM"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2880615EFAD;
	Wed, 10 Apr 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712782357; cv=none; b=CRczpN6byvm18JGWkQirAgS1ezfs3rrcx1P8ColYyx4ijRqhIS+gIVNh9f0nLKNz0NSnk8dxsENiEna55ZsWeosCSU+8RnKf5ruELXz0SDuE+dEiUM8ZhdlSEXdQEfElY9nMixNOoRIcIxlY5Km5jLJzafChMuf+iG6+CVhAORs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712782357; c=relaxed/simple;
	bh=LOH2uFOdtYg3Irj2bybDHrQvyp8PZBBdOjsOaPVQ+c0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSdVJXbIPVqF1O5oBpahUZycWgkrxRKMpvVAfzGEO2il5Lg4b9UTvdwDTsqr2yX7BazdSLcRDlS81wL0N2YkiXTDlR9moScAf7+677cjbafogXdX+0TqcidToagKTrmJWGd6nfHiEJ2V66/hiPe8wsnXk6ZL39JYcj8ZEGyI7Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct3uKmVM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3442f4e098bso134030f8f.1;
        Wed, 10 Apr 2024 13:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712782354; x=1713387154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAB7CSzfCNbcsG/QWe5zEEDp9vPAJdmTeslJpz9VGoQ=;
        b=Ct3uKmVM4VompcgmaSsAy1iw+IryeKIKZGKtPqIGoyDuQEXY5mphIYbBdW5r9NfXPk
         vmjZJ7bTG2+TjSVXF9KFVx/nPaTArWLCZ65XQoPeE7ymP3GlOtKMqvLv21SjJQp6JKGH
         6HD/1Vhao+1TR1t2hCECsiB6osbFVQlj1FpAIqMFOrlyJY9FuiBsucr9eVBv5IN0ey5L
         VjYZkzsAs2VUWtPBciXtEr5j3uPoyBos2lI2S91J0Si9XfyE39YYoej7/nh0XsL8hM1B
         9PGtFR0PLA70llOLXgZzE0OyIE4G1HYrcUkNdC0nAuetcD9/urtbWPnFgW2EHjWksKuq
         qT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712782354; x=1713387154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAB7CSzfCNbcsG/QWe5zEEDp9vPAJdmTeslJpz9VGoQ=;
        b=GdC31gNZEEyQhvjiLQ5O66itICmLEExbRbjzMWprXDgepx7Id2q7r2+ksfADtcK6fU
         e30QnYLeiGMTqwrm3/b+JaTIO6YhsKtrC6AyGcQA5cK3tSOUaO6dEd9yV+BggoOTzcXt
         jVvIC+YLGX9h4R6yXNv4jccSjTjqvmXUPZH6cUG1c02BKn0j5S4KI+sOkmSC7/YYKZvU
         Zrq/XLaRGSo4yMY2wLeE5AAmk306SQZSnfKwsIs4Nlep7I+F5cTfvr+Xo36X46M7eqy9
         yTTyFEoxfYm6xo1AakYBU7Ppk719hNou7SJDKlf27cpEcIwq9fqoENAeOswLdQNYmYOh
         YiDg==
X-Forwarded-Encrypted: i=1; AJvYcCX4mJ3jeeikypLAkJawg0EZtsQBwSWKfrroozHg5Codg9Ty8r45YeeqQXoxIMAVGliR6T2dDaum/Zi0ranmMxMO59i49NM64aGBfEPw5r8=
X-Gm-Message-State: AOJu0YzJ/kIFht+54VO82yN7V3VaZP9fegAYHaOA7VVBBbCEtHjX09Nj
	4fTNjCPV+0fx2HXueNa4o3aH/wmQbrycITQjpyt1qyUbvpL21uZoAd8xqw==
X-Google-Smtp-Source: AGHT+IHTHB3WYBhvJvgexVeAt59v3jWUk5M5VRPwVp2DIkmaL+4lDbNkanOWQuGwTGXlenLPEI6CAg==
X-Received: by 2002:adf:ebc6:0:b0:33e:d139:412c with SMTP id v6-20020adfebc6000000b0033ed139412cmr511385wrn.30.1712782353368;
        Wed, 10 Apr 2024 13:52:33 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id n14-20020a5d660e000000b003433a379a51sm74113wru.101.2024.04.10.13.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 13:52:32 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-openrisc@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] openrisc: Add support for more module relocations
Date: Wed, 10 Apr 2024 21:51:58 +0100
Message-ID: <20240410205201.1885032-1-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing modules in OpenRISC I found R_OR32_AHI16 (signed adjusted
high 16-bit) and R_OR32_SLO16 (split low 16-bit) relocations are used in
modules but not implemented yet.

This patch adds the relocations. Note, we use the old naming R_OR32_*
instead or the new naming R_OR1K_* to avoid change as this header is
exported as a user api.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/uapi/asm/elf.h |  2 ++
 arch/openrisc/kernel/module.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/openrisc/include/uapi/asm/elf.h b/arch/openrisc/include/uapi/asm/elf.h
index 6868f81c281e..0c882a388524 100644
--- a/arch/openrisc/include/uapi/asm/elf.h
+++ b/arch/openrisc/include/uapi/asm/elf.h
@@ -43,6 +43,8 @@
 #define R_OR32_JUMPTARG	6
 #define R_OR32_VTINHERIT 7
 #define R_OR32_VTENTRY	8
+#define R_OR32_AHI16	35
+#define R_OR32_SLO16	39
 
 typedef unsigned long elf_greg_t;
 
diff --git a/arch/openrisc/kernel/module.c b/arch/openrisc/kernel/module.c
index 532013f523ac..01bda5616114 100644
--- a/arch/openrisc/kernel/module.c
+++ b/arch/openrisc/kernel/module.c
@@ -55,6 +55,16 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			value |= *location & 0xfc000000;
 			*location = value;
 			break;
+		case R_OR32_AHI16:
+			/* Adjust the operand to match with a signed LO16.  */
+			value += 0x8000;
+			*((uint16_t *)location + 1) = value >> 16;
+			break;
+		case R_OR32_SLO16:
+			/* Split value lower 16-bits.  */
+			value = ((value & 0xf800) << 10) | (value & 0x7ff);
+			*location = (*location & ~0x3e007ff) | value;
+			break;
 		default:
 			pr_err("module %s: Unknown relocation: %u\n",
 			       me->name, ELF32_R_TYPE(rel[i].r_info));
-- 
2.44.0


