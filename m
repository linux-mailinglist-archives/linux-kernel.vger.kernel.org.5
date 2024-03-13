Return-Path: <linux-kernel+bounces-101189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A16987A3CE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C45E1C2161F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586111B814;
	Wed, 13 Mar 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8jSqfZa"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AEF17589
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710316755; cv=none; b=Er0dE7MnUCX43gGJPmxvHSkicMMmiR328tjfr4kxEFPOkn6WsiQ7tPleKPK0to8/4xsMhqMVFVnGNff40HtvTJTUgR4vRbi2dB1z7KV0DsSnsmc12p1uQjfl2bD/AUv4C1ZKIRO+kJog9QLea8UOyWToDnzV/Z9pGuCkeab275w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710316755; c=relaxed/simple;
	bh=5EKNsvHVcpLfe38673V9v/i6xog89qCKvXxKXsLsi1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=JfzOqr5IMRxl6/WueEKK4OB/LdYFwC6UC9ENLLmA2P7sFlBRIiT2LK3mvHCoLSlw57lvc0lkc3fuSFL2UDWP7MvK/CNQOYoGmIzq6Tn6wUPFSnKOyDLiN9QoIqh6+Fhg1Vhrq8HqJr+GCZenWZ7SynEyFoxBWAhKzOVPia7nZMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8jSqfZa; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so5688955a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710316752; x=1710921552; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gvr0OywRqfXlY8J8P6TNVybbliGURKEupVKvqRMCnx0=;
        b=a8jSqfZaixpbH5KxI6Z4Jo2AHPdUeWB4Sgqm8gvEQhzDQgzlC5H/1M7RC62oEtQI4i
         VAsY45HKlp3qFEK7/x7IFOJ0Z4yu3WWyQuQfzsKlUbiGxv/LWZ68DxH9Op7urQdI7yfS
         mLS51mb8uYABgjjYhVpiF8seSXLMMuwZnsk29GVHOPMStNeqlFMeIZCuZvQ72lr0QCE6
         d8/xsWE4oG3cHJjD/Xi+4BBaE+TBxfxEzM3pLT2esCvHyfH5uGnuL8OJV47IDCTay/hC
         auL2QCtd3xz7oHOfzjUeafXdE/LkhCeplaGnXxNNxz07P/DWykFvesGnu4soyDL8xWIJ
         XqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710316752; x=1710921552;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvr0OywRqfXlY8J8P6TNVybbliGURKEupVKvqRMCnx0=;
        b=P9AUoKe6is3XcDP8FsBBc5Xm+UPxYGbUbYvwPNz9j8d1k0elrjKcPlhOq+R8dOCgbo
         d9g8U5dSXnL1H1Qk91G3rmpvqlI4cO23bIDn0qKP5iEqyi/t3Rj/nXOfjSUrusD6LTtt
         YE5qfyVExzYEzbcM1qSXx9Jj3sYp/7AfY1c9ju+irH/SLwvQbwFBOWxqsLDbAaCUyOPo
         VFOthfXWVoXBNpVAGj4MXv4DCyAdjeh2RHtJyKQQ4Rc7EHR4jKqVCXkCDIklfArH9KN9
         AaTkcP/H95vIecI+wJmhvSm/Z02HCnCQyEyvs728CiKhuQOcijSpP2EL3WmUvtRucmf7
         MdpA==
X-Forwarded-Encrypted: i=1; AJvYcCUrl1Mm6NoRIBwtsSLTO/+5JticlPAH6lLHOaiQwF7kw0+Nlib0sJaDkXKbebaZYlRiXCGmeQz9npb7t16do9SdG3avlhlNmCAE5WH8
X-Gm-Message-State: AOJu0Yyg7WbsbRl//QZHuqQEVNIcA/QlaskPYD68+5Van6ZxYJuQF+H9
	uwZcgGfh5HhsgiuRbbTB1n8suPVY75fXWe6n0ZKlnAQJM+I/a8cQ
X-Google-Smtp-Source: AGHT+IGGPGs/rU+JEecIR5qdQtkiY1iwvNiaohvrYnd7OyeCWe8dWNXV5knp2zHQaPYwdoseqlHCpg==
X-Received: by 2002:a17:906:1150:b0:a46:4851:b8cb with SMTP id i16-20020a170906115000b00a464851b8cbmr1506147eja.15.1710316752093;
        Wed, 13 Mar 2024 00:59:12 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id la18-20020a170907781200b00a43e8e76825sm4677315ejc.149.2024.03.13.00.59.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Mar 2024 00:59:11 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH 2/4] x86/boot: replace __PHYSICAL_START with LOAD_PHYSICAL_ADDR
Date: Wed, 13 Mar 2024 07:58:37 +0000
Message-Id: <20240313075839.8321-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20240313075839.8321-1-richard.weiyang@gmail.com>
References: <20240313075839.8321-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Both __PHYSICAL_START and LOAD_PHYSICAL_ADDR are defined to get aligned
CONFIG_PHYSICAL_START, so we can replace __PHYSICAL_START with
LOAD_PHYSICAL_ADDR. And then remove the definition of __PHYSICAL_START,
which is only used to define __START_KERNEL.

Since <asm/boot.h> includes <asm/pgtable_types.h>, which includes
<asm/page_types.h>, it is fine to move definition from <asm/boot.h> to
<asm/page_types.h>.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 arch/x86/include/asm/boot.h       | 5 -----
 arch/x86/include/asm/page_types.h | 8 +++++---
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/boot.h b/arch/x86/include/asm/boot.h
index a38cc0afc90a..12cbc57d0128 100644
--- a/arch/x86/include/asm/boot.h
+++ b/arch/x86/include/asm/boot.h
@@ -6,11 +6,6 @@
 #include <asm/pgtable_types.h>
 #include <uapi/asm/boot.h>
 
-/* Physical address where kernel should be loaded. */
-#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
-				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
-				& ~(CONFIG_PHYSICAL_ALIGN - 1))
-
 /* Minimum kernel alignment, as a power of two */
 #ifdef CONFIG_X86_64
 # define MIN_KERNEL_ALIGN_LG2	PMD_SHIFT
diff --git a/arch/x86/include/asm/page_types.h b/arch/x86/include/asm/page_types.h
index 86bd4311daf8..acc1620fd121 100644
--- a/arch/x86/include/asm/page_types.h
+++ b/arch/x86/include/asm/page_types.h
@@ -31,10 +31,12 @@
 
 #define VM_DATA_DEFAULT_FLAGS	VM_DATA_FLAGS_TSK_EXEC
 
-#define __PHYSICAL_START	ALIGN(CONFIG_PHYSICAL_START, \
-				      CONFIG_PHYSICAL_ALIGN)
+/* Physical address where kernel should be loaded. */
+#define LOAD_PHYSICAL_ADDR ((CONFIG_PHYSICAL_START \
+				+ (CONFIG_PHYSICAL_ALIGN - 1)) \
+				& ~(CONFIG_PHYSICAL_ALIGN - 1))
 
-#define __START_KERNEL		(__START_KERNEL_map + __PHYSICAL_START)
+#define __START_KERNEL		(__START_KERNEL_map + LOAD_PHYSICAL_ADDR)
 
 #ifdef CONFIG_X86_64
 #include <asm/page_64_types.h>
-- 
2.34.1


