Return-Path: <linux-kernel+bounces-141339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B648A1CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0A281F21849
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA48154841;
	Thu, 11 Apr 2024 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lafti7e/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C74145C04;
	Thu, 11 Apr 2024 16:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712853774; cv=none; b=JTEXmBy6ZutVqwyIivieowMOycGSNbcCxNOGNPJu5RTTJERt4kMj1J/9FCpnOHNiUxHWb18hM/znbNbz+NC2AcJpQbuR1ayGqfuXOXx0Ik9OwUVT4fhNXTeIEMjFwHymyAsQPOFVZbofBUNwpyYbVMUjF0kFvLY7LdNHSvO81hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712853774; c=relaxed/simple;
	bh=26LrPj6LUqcNmylvYhxYr/fcjUEgvPsI3PRufXdXs90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bhe/p7R460wTd32V0GXqz9qWZCgV2OYmWujCuIvTyCyx9Q5XQcO9KaE1YuiUCycaSfllovrMnC5Q3BL+zKGcdRSmo4rAyKJxN9Cqho2nUpoDg9ZKSFmZ7OrEvMqH/XiXueMT7ERnIbEm9ZTK7gGym19U3R4Ok4EqlJpbBvx9OT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lafti7e/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-416c4767b07so548545e9.0;
        Thu, 11 Apr 2024 09:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712853770; x=1713458570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I/kZba/eZof5I7oj6voMjU9Ljlm5m0ug+oOrZQT5kw=;
        b=lafti7e/shOGZWJgXa2DtOoN27kZ2OcQF73qvbEO50RDP+2draf5id2/kaEI0u/9Mc
         ZphwpAdHGnNbl45gnRCg90h2Xy4u1+k41xRh5cMc70s+R1P0BhyI3Wjf2BQ63QKq9mft
         qfos9Pndd7Y3pTlula/Zz4p/h/OZq5vy0dwQadNq6EjilN8858y+uvneHIssKbFnHiQ9
         kOyim/FfWhVp6VvXU86PWw1p1XQz2kvje6cDP7QRE15iX3vjfCBxBN9Hg6a5krCiurNG
         uIjDSXntHTxzOWnwa4kBidfgxRV/oBxLWdgr8dbEBGCBSW3lKC9bVmPivOiOKQ6onvqN
         HdmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712853770; x=1713458570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I/kZba/eZof5I7oj6voMjU9Ljlm5m0ug+oOrZQT5kw=;
        b=BzfrlKwJWAl5b98U63Q1Xu5QdwkiV4zEWoFlzKJ4eUx3EtptE0ZvE/9Fot5xwUbedH
         9GZec1nisooKiqX4cIsS1oOulzUVnH3fOp8RxG62aNwn6YUT4jre91HofKPnJfHdv26e
         LDJfucnUnul63MJGbIJoIGvkFZMYcjJ57DweYVVrLLW0d4qA5WNn3dlQ/r2qXWUcoS26
         m1IgP38zpbOouuDiKIcsFjCMu/LbJO7OcfDt11vqrvKwAGd/HcHfO6bbab/PQ3p9fZkf
         8gSmLHymXDUSfk8/2GIVUrgdK6zg9vXL8Cs7mxYiHOmhjOTAmtS8uR2QDWWQIYpH4N14
         mYHQ==
X-Gm-Message-State: AOJu0Yyy4BZ/SCDgX1RECy4JYciAZT2r6h0nJdfXUnxqUQ1od/kS/ouI
	bfteBIZcib/jsaHLaHnz7UwI2LedU1PY5/siQZK/E5yb07G6E3w+LaEarg==
X-Google-Smtp-Source: AGHT+IEaWmPJXXfZ9p+0M5IfDFkfmjGp+xfzxESQfhvmLoMbC9tFCWL1bugJU8jkLZtjkN44p/gBpg==
X-Received: by 2002:a05:600c:3849:b0:416:b671:30cd with SMTP id s9-20020a05600c384900b00416b67130cdmr196532wmr.36.1712853769713;
        Thu, 11 Apr 2024 09:42:49 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05600c3c9900b004162d06768bsm6060760wmb.21.2024.04.11.09.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 09:42:49 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux OpenRISC <linux-openrisc@vger.kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	linux-mm@kvack.org
Subject: [PATCH v2 1/2] openrisc: Define openrisc relocation types
Date: Thu, 11 Apr 2024 17:42:31 +0100
Message-ID: <20240411164234.1997000-2-shorne@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411164234.1997000-1-shorne@gmail.com>
References: <20240411164234.1997000-1-shorne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This defines the current OpenRISC relocation types using the current
R_OR1K_* naming conventions.

The old R_OR32_* definitions are left for backwards compatibility.
Note, the R_OR32_VTENTRY and R_OR32_VTINHERIT macros were defined with
the wrong values the have always been 7 and 8 respectively, not 8 and 7.
They are not used for module loading and I have updated them to use the
correct values.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/uapi/asm/elf.h | 75 ++++++++++++++++++++++++----
 arch/openrisc/kernel/module.c        |  8 +--
 2 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/arch/openrisc/include/uapi/asm/elf.h b/arch/openrisc/include/uapi/asm/elf.h
index 6868f81c281e..441e343f8268 100644
--- a/arch/openrisc/include/uapi/asm/elf.h
+++ b/arch/openrisc/include/uapi/asm/elf.h
@@ -34,15 +34,72 @@
 #include <asm/ptrace.h>
 
 /* The OR1K relocation types... not all relevant for module loader */
-#define R_OR32_NONE	0
-#define R_OR32_32	1
-#define R_OR32_16	2
-#define R_OR32_8	3
-#define R_OR32_CONST	4
-#define R_OR32_CONSTH	5
-#define R_OR32_JUMPTARG	6
-#define R_OR32_VTINHERIT 7
-#define R_OR32_VTENTRY	8
+#define R_OR1K_NONE		0
+#define R_OR1K_32		1
+#define R_OR1K_16		2
+#define R_OR1K_8		3
+#define R_OR1K_LO_16_IN_INSN	4
+#define R_OR1K_HI_16_IN_INSN	5
+#define R_OR1K_INSN_REL_26	6
+#define R_OR1K_GNU_VTENTRY	7
+#define R_OR1K_GNU_VTINHERIT	8
+#define R_OR1K_32_PCREL		9
+#define R_OR1K_16_PCREL		10
+#define R_OR1K_8_PCREL		11
+#define R_OR1K_GOTPC_HI16	12
+#define R_OR1K_GOTPC_LO16	13
+#define R_OR1K_GOT16		14
+#define R_OR1K_PLT26		15
+#define R_OR1K_GOTOFF_HI16	16
+#define R_OR1K_GOTOFF_LO16	17
+#define R_OR1K_COPY		18
+#define R_OR1K_GLOB_DAT		19
+#define R_OR1K_JMP_SLOT		20
+#define R_OR1K_RELATIVE		21
+#define R_OR1K_TLS_GD_HI16	22
+#define R_OR1K_TLS_GD_LO16	23
+#define R_OR1K_TLS_LDM_HI16	24
+#define R_OR1K_TLS_LDM_LO16	25
+#define R_OR1K_TLS_LDO_HI16	26
+#define R_OR1K_TLS_LDO_LO16	27
+#define R_OR1K_TLS_IE_HI16	28
+#define R_OR1K_TLS_IE_LO16	29
+#define R_OR1K_TLS_LE_HI16	30
+#define R_OR1K_TLS_LE_LO16	31
+#define R_OR1K_TLS_TPOFF	32
+#define R_OR1K_TLS_DTPOFF	33
+#define R_OR1K_TLS_DTPMOD	34
+#define R_OR1K_AHI16		35
+#define R_OR1K_GOTOFF_AHI16	36
+#define R_OR1K_TLS_IE_AHI16	37
+#define R_OR1K_TLS_LE_AHI16	38
+#define R_OR1K_SLO16		39
+#define R_OR1K_GOTOFF_SLO16	40
+#define R_OR1K_TLS_LE_SLO16	41
+#define R_OR1K_PCREL_PG21	42
+#define R_OR1K_GOT_PG21		43
+#define R_OR1K_TLS_GD_PG21	44
+#define R_OR1K_TLS_LDM_PG21	45
+#define R_OR1K_TLS_IE_PG21	46
+#define R_OR1K_LO13		47
+#define R_OR1K_GOT_LO13		48
+#define R_OR1K_TLS_GD_LO13	49
+#define R_OR1K_TLS_LDM_LO13	50
+#define R_OR1K_TLS_IE_LO13	51
+#define R_OR1K_SLO13		52
+#define R_OR1K_PLTA26		53
+#define R_OR1K_GOT_AHI16	54
+
+/* Old relocation names */
+#define R_OR32_NONE	R_OR1K_NONE
+#define R_OR32_32	R_OR1K_32
+#define R_OR32_16	R_OR1K_16
+#define R_OR32_8	R_OR1K_8
+#define R_OR32_CONST	R_OR1K_LO_16_IN_INSN
+#define R_OR32_CONSTH	R_OR1K_HI_16_IN_INSN
+#define R_OR32_JUMPTARG	R_OR1K_INSN_REL_26
+#define R_OR32_VTENTRY	R_OR1K_GNU_VTENTRY
+#define R_OR32_VTINHERIT R_OR1K_GNU_VTINHERIT
 
 typedef unsigned long elf_greg_t;
 
diff --git a/arch/openrisc/kernel/module.c b/arch/openrisc/kernel/module.c
index 532013f523ac..292f0afe27b9 100644
--- a/arch/openrisc/kernel/module.c
+++ b/arch/openrisc/kernel/module.c
@@ -39,16 +39,16 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 		value = sym->st_value + rel[i].r_addend;
 
 		switch (ELF32_R_TYPE(rel[i].r_info)) {
-		case R_OR32_32:
+		case R_OR1K_32:
 			*location = value;
 			break;
-		case R_OR32_CONST:
+		case R_OR1K_LO_16_IN_INSN:
 			*((uint16_t *)location + 1) = value;
 			break;
-		case R_OR32_CONSTH:
+		case R_OR1K_HI_16_IN_INSN:
 			*((uint16_t *)location + 1) = value >> 16;
 			break;
-		case R_OR32_JUMPTARG:
+		case R_OR1K_INSN_REL_26:
 			value -= (uint32_t)location;
 			value >>= 2;
 			value &= 0x03ffffff;
-- 
2.44.0


