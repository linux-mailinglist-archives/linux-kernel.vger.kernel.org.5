Return-Path: <linux-kernel+bounces-124236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DFA891439
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F51B2395C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C0053392;
	Fri, 29 Mar 2024 07:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="EG0ST0Mz"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB4D40877
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697102; cv=none; b=hJWC5wJ5Du6x19T43kvTYVWqXq9R5RV15q1tuIpYnmd2XwN4eq+FxCoabfxOCt0CmvUAiCHdhfC3FVvlWlhS4M//jDo/1T93/rtaFbISClvuAi7HHMiRDfsfXrTQQ/QyzP6sOyLeEqxqB2Tks9+W1S2MW8MtNzr9qLumTBL4f0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697102; c=relaxed/simple;
	bh=dD+iV8uD7G5MpjHgE1LVjx/5PSgKP1NpMjf5jkr/+qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9w02LF/DEoe4misaSe/yGd/VlkQcABtMsjSn9wqCSpwJ7QJJVlEKKPc2yecLKULk4IemEpmQPGjOC1GfgBcVrOHT+NxSDBIxmghsyBhizdb+yyiAlt+4MSSn5rbQ7oPFj0XxfuPCWyzjNDDFxUMVhzCW9tFkDRtz+X2wIp06G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=EG0ST0Mz; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29dfad24f36so1351644a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697100; x=1712301900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzRar7ztYXEnRyKAelp48saozJM51jVm9Dh1Zr4pH8s=;
        b=EG0ST0MzUSqGXWbSEr4O8g/gowltE2/hVPIPCASKrGA0l0afnWGkRfC5kViba1VwzJ
         wpezGDlK+KuklUaNYQzNW7jt24ytT9h6/JaCR8MIGsXmRQUI20TQdGyWlH7/KkTvIkBM
         UqG2UbH2M0Jv/00Zq4eN1/30ooHPhi8yPZGYP4sPP8DisyhjmIuoOsZK/cnxdJPg+yoH
         O9QHa8OnlyzlAURSspe8ltqxGcjD9xJ7EMsSgiuHGoEv8BYjGSIB5xI/DtAnOEICZcOJ
         jmZuUJMuABz6oyMni4RR30iGGYhwx89LylETSTx/4oRaoMdvqW4uqV0UG1Aj6vWSaVRz
         DjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697100; x=1712301900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzRar7ztYXEnRyKAelp48saozJM51jVm9Dh1Zr4pH8s=;
        b=prCniioDsNXS5zrksurdhHvHDBxv3ryVgdwH/WMUNhd/PHP2U9VFHALe1WvGP+G5E4
         wkHhEAZgW5zo+dyuXSnVktvZ5lwT0S6PypUlDx/7jLQjOJJKa+cuOhJdKc/lQbi7AAjT
         Vfelay55W8qi4vxvEBfb2OgfUXnqrLE56awlWw1jQrx47pQ/6gM1mxUR8Pt1k5Q51XO3
         MlRBvrsN2TlJVIhcvfFq2+gQ1o+1vpFTreicaMS072fJZjDMPSh69KlIfk4CeLnDbZ7a
         fjexBzO11LUF9odC1/kVb0ISGSGs7mMinAOuJM6OVDlEskzlD12OfxIBSKm1x9HQXWWp
         jVRg==
X-Gm-Message-State: AOJu0YzOcAVO/cmkyGDwJbhz/5ocQFQBiJHAik+OVoKm3fc3tXqTJ3Yh
	LAc/4ALMj6GWEX7OfoFfuCBewP1AqccXoM1/T5XFQwL6TWLfFxd08Z2/oUBDhgk=
X-Google-Smtp-Source: AGHT+IEs8kBZu3dBChnRywCF22OnC9/Ej+znSx9gblpEFd+wsOZOeprciOlW3fwk28PpRrFgoWrM2Q==
X-Received: by 2002:a17:90a:d3c3:b0:29e:975:3500 with SMTP id d3-20020a17090ad3c300b0029e09753500mr1446912pjw.28.1711697100232;
        Fri, 29 Mar 2024 00:25:00 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:59 -0700 (PDT)
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
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 09/15] x86/fpu: Fix asm/fpu/types.h include guard
Date: Fri, 29 Mar 2024 00:18:24 -0700
Message-ID: <20240329072441.591471-10-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The include guard should match the filename, or it will conflict with
the newly-added asm/fpu.h.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v4:
 - New patch for v4

 arch/x86/include/asm/fpu/types.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/fpu/types.h b/arch/x86/include/asm/fpu/types.h
index ace9aa3b78a3..eb17f31b06d2 100644
--- a/arch/x86/include/asm/fpu/types.h
+++ b/arch/x86/include/asm/fpu/types.h
@@ -2,8 +2,8 @@
 /*
  * FPU data structures:
  */
-#ifndef _ASM_X86_FPU_H
-#define _ASM_X86_FPU_H
+#ifndef _ASM_X86_FPU_TYPES_H
+#define _ASM_X86_FPU_TYPES_H
 
 #include <asm/page_types.h>
 
@@ -596,4 +596,4 @@ struct fpu_state_config {
 /* FPU state configuration information */
 extern struct fpu_state_config fpu_kernel_cfg, fpu_user_cfg;
 
-#endif /* _ASM_X86_FPU_H */
+#endif /* _ASM_X86_FPU_TYPES_H */
-- 
2.44.0


