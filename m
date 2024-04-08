Return-Path: <linux-kernel+bounces-135850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4E889CC0A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39511F22D16
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C6F147C64;
	Mon,  8 Apr 2024 18:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mS70M4kA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80254146D4C;
	Mon,  8 Apr 2024 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712602525; cv=none; b=eKRLcc0QVrQS6bXKNhQDb2+dm6VoaaepIiT3rCF0wWQxENK9I0dkL3oiS/1F5Np3iLrr+UxugGz3ODxAw4erCeHNusPDfm9e4ITlQP3ig0M2ONSpFL049kOj2mRGjAfb4suwl1Jos2olWk8Y3eokn02v5t4LnaXNXYCkIyZNPpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712602525; c=relaxed/simple;
	bh=cWyaFlEddClc55CiM7T9Ily/NaD1dyUwXHboki/L7wQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVupBefR/FeahqPScqXjZ/x+ZuoOIUNsa05+kFrBHB8QxhvVfcwZenZas0Srp8hNY2xn594Ua3oIbLYWr+R73B//7FzevT1WyuQpDbby86Hh8BOEf3HnIneI+DA7jaQuhMpdc6eKz58ve2OTbFlXjMMFTMyrBZQBYbvjC4eYMXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mS70M4kA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C899CC43609;
	Mon,  8 Apr 2024 18:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712602525;
	bh=cWyaFlEddClc55CiM7T9Ily/NaD1dyUwXHboki/L7wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mS70M4kALtjgUm0oz5Ph+ht+c3IiMWnPnpqJyTchMdUufdoKFAjKLA5L2QF8e1Gue
	 lrjCh2T/uHr87bgsLz+1G6RD9K9xn8dKWkAt5/Ye7Edbhign8IG77pbo3S/Cnq+LBt
	 V5bfV2zoEsjnvKcemAKVvoVhqjPwzQb4oTkmiAB1jrsDW/AZjJxoMDsvPb7YagzqPV
	 v6Hw4Q1lmpcJWeXyib9vdyVooxByMZu/G/nSShMbT4YCIwL1DIKtnTFmjcCz44S+uI
	 uXEJpIPg7TPmx+1hKeQ//E+er2iHPVM1EsYVFjGqX997puAhfx7s7TriUF6JFoHKuz
	 NcTBhg+xVhegQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: [PATCH 6/9] tools/include: Sync x86 asm/irq_vectors.h with the kernel sources
Date: Mon,  8 Apr 2024 11:55:17 -0700
Message-ID: <20240408185520.1550865-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240408185520.1550865-1-namhyung@kernel.org>
References: <20240408185520.1550865-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To pick up the changes from:

  0cbca1bf44a0 ("x86: irq: unconditionally define KVM interrupt vectors")

This should address these tools/perf build warnings:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/irq_vectors.h arch/x86/include/asm/irq_vectors.h

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/arch/x86/include/asm/irq_vectors.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/arch/x86/include/asm/irq_vectors.h b/tools/arch/x86/include/asm/irq_vectors.h
index 3f73ac3ed3a0..d18bfb238f66 100644
--- a/tools/arch/x86/include/asm/irq_vectors.h
+++ b/tools/arch/x86/include/asm/irq_vectors.h
@@ -84,11 +84,9 @@
 #define HYPERVISOR_CALLBACK_VECTOR	0xf3
 
 /* Vector for KVM to deliver posted interrupt IPI */
-#if IS_ENABLED(CONFIG_KVM)
 #define POSTED_INTR_VECTOR		0xf2
 #define POSTED_INTR_WAKEUP_VECTOR	0xf1
 #define POSTED_INTR_NESTED_VECTOR	0xf0
-#endif
 
 #define MANAGED_IRQ_SHUTDOWN_VECTOR	0xef
 
-- 
2.44.0.478.gd926399ef9-goog


