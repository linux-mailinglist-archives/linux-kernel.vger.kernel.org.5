Return-Path: <linux-kernel+bounces-124232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0DB89142F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9464286657
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1B24AEED;
	Fri, 29 Mar 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="GcNjmIIh"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A27446B3
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697092; cv=none; b=hPbyL301P1Nbhm3GjWOMLp+eyd/u1gdP90xzMChm1y+K0BSRe5ETTOUxTnXu59BE92772W19kDWAhpQa8+DbuZg0P1N1QHHT4Lc9tLIrwJBznGoSJltiKdNz0+LvNg90CWY8JLQM6Nr1eyDwWRVmyw8i25JFkbLfA+tUFnparY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697092; c=relaxed/simple;
	bh=f1Ved49IBgBs8V4O2Ps9VgHa0Mf2aY/RBhmEBJyNCVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JN/CgMoQWV6r0KAs0ZwLFBAAdb8R622Qf28CKufbvRGe69hxiax5NNZ+2jYjA4V3tT+QaOLvf0PiBw1aj8B1eenYr5nGpz8quTmwmsWPvOOfR1vI+qdGcqcjYIrRxc7lb2h/4U2DkmXclYtGyOO66BpfckwveTAbzUW1hC4cOHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=GcNjmIIh; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so1028242a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697090; x=1712301890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RPRyZsExaX9jqH4yhl7xuz7hAOg3yG/uDoq2R6sqbZQ=;
        b=GcNjmIIhXlUXubcqQUtueXwpfOzIOsEh8R0gW7vxRLj+CM03LhSVVhOplsM/SEqYc8
         q+dNEbibyHEgIS6b53vjgoaTVLIWvT2awK1VKgWUi0HulBvsb2zXoPYsH2L6stpdvK0B
         f7vuHE+oqmUWvPMC2fvXyUHGBYkl0nJGvTy0qknF1vajC53w9Y1xnMA4G9LkWPt841an
         511pIyRJl8T2rGPtIH0l9iXJBzpqgz8cFlbZcbVO6i3w0LL6gmuIY4/GedVSwfZLmDW+
         e9u9riSWm5W0cTxyoGeRoSDBr+Ox7TnpNzq7nF/j5RxoNGM7bilJKsYRMag0+TPUYbdt
         aJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697090; x=1712301890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RPRyZsExaX9jqH4yhl7xuz7hAOg3yG/uDoq2R6sqbZQ=;
        b=omPK/mKMGiXOPmq3/iGUMrWy7LgEsGoR3UH1tXBX3iHpxdR54WFDxS2ZxH2MXAPz2X
         CSSaZsITctG9CXbMFMzN5Egxz42NuOvoZY+fT3aeVvommyPdvOvvVImuc0FZSdxiNM26
         l3/Z0nzWaxfq5vL8rxaYXxyh9V4wDNbywsylJ8Vu671Yt1WjMMzu2E98JR7wydKfRo0Z
         n9HR5J7DEIlV8X7+ebQpiEYP45/b05lqmGylBOne73SWPJuukSyZciXUagOpSwv1Ed1g
         z/bTlmIOEx2LdLH4gqOeDzSrc8rrq88TX/TsARXUkUEe0ZbLcuddy9syGRsFcNl1eQsA
         7f3w==
X-Gm-Message-State: AOJu0Yxl55CgCqFBp0RicbGapvoDIF47PkFByMp5b7LEFvtUS4f2C0wF
	gBUvz/okvcOZ6rx1gqf8o9I7lnAfV1poqvSk5wwSuk0z+Ys/sdZuHt28xZHu9v4=
X-Google-Smtp-Source: AGHT+IGTP4+TuVjePLHUufBWyrdagoR69ieuL91+Fm218jTRMOa2nDQVrtkL7zzrGfUrh4aL4xmRCg==
X-Received: by 2002:a05:6a20:2db:b0:1a3:71f7:df3d with SMTP id 27-20020a056a2002db00b001a371f7df3dmr1114388pzb.30.1711697089806;
        Fri, 29 Mar 2024 00:24:49 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:24:49 -0700 (PDT)
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
Subject: [PATCH v4 05/15] arm64: crypto: Use CC_FLAGS_FPU for NEON CFLAGS
Date: Fri, 29 Mar 2024 00:18:20 -0700
Message-ID: <20240329072441.591471-6-samuel.holland@sifive.com>
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
2.44.0


