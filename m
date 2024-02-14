Return-Path: <linux-kernel+bounces-65152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DFA85489C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29825B2277C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798E61A286;
	Wed, 14 Feb 2024 11:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vg3hlHC9"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B791BDC4
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910843; cv=none; b=g5Rwz6cUqJcbYKvgd7galuM9+3cKZdSM5j3lZFUJi1s2OYBpHDxit81D5FfQzK76de7nq3X5iFuk4auY0mjtuzt659nbFJRoJlVSnAH2hchrzVf8GuBbORncvaYj6MMcqi1ZKJhOQArT+OIleox7hTdL0e9FC0URHqVm52Ps8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910843; c=relaxed/simple;
	bh=msK7Neyo95sifG/SfnjBvM2eXJ30OW6/HO1CpcE+9n4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gxBd6/FG8M+L/doh98ETb8z56YwDJoTv5W9NRVkIXUWMtkc/JEwFuddTjGBOSgcw3e/P08tUHglI3vOnvcNW6nZYGZSlmPqyN7B8IVZP1Y6KR1/efSOJj6TH+OcFtrnktPLy2wxfukZ5Mk92U93f25V7vtxur0Ypf9LpwgqXqBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vg3hlHC9; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707910840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ceIPkkMA3m3CUBnXP3Si9TKYLZlh1ovGGEt5qyffvMM=;
	b=Vg3hlHC9ifATj2zwM4zqt65oYEOYkZjfvbjqdT7Vp7OLdAAhGPY8detKJ1ebR0CveIPXFl
	hPFbjlGoQ7ZhrUFFq6IWLcmgfTnjG4PuMg9WVQrJMe+jxmkeYjwVG/8+Hk5i9PRfmBeMR4
	kiAH5tHAI0XeIRT9JImIt+/xV7SeY5g=
From: Leo Yan <leo.yan@linux.dev>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ming Wang <wangming01@loongson.cn>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Leo Yan <leo.yan@linux.dev>
Subject: [PATCH v1 4/4] perf build: Cleanup perf register configuration
Date: Wed, 14 Feb 2024 19:39:47 +0800
Message-Id: <20240214113947.240957-5-leo.yan@linux.dev>
In-Reply-To: <20240214113947.240957-1-leo.yan@linux.dev>
References: <20240214113947.240957-1-leo.yan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The target is to allow the tool to always enable the perf register
feature for native parsing and cross parsing, and current code doesn't
depend on the macro 'HAVE_PERF_REGS_SUPPORT'.

This patch remove the variable 'NO_PERF_REGS' and the defined macro
'HAVE_PERF_REGS_SUPPORT' from the Makefile.

Signed-off-by: Leo Yan <leo.yan@linux.dev>
---
 tools/perf/Makefile.config | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 8b740c668ab7..7de7111c0226 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -28,8 +28,6 @@ include $(srctree)/tools/scripts/Makefile.arch
 
 $(call detected_var,SRCARCH)
 
-NO_PERF_REGS := 1
-
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
@@ -50,7 +48,6 @@ endif
 
 # Additional ARCH settings for ppc
 ifeq ($(SRCARCH),powerpc)
-  NO_PERF_REGS := 0
   CFLAGS += -I$(OUTPUT)arch/powerpc/include/generated
   LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
 endif
@@ -66,41 +63,27 @@ ifeq ($(SRCARCH),x86)
   else
     LIBUNWIND_LIBS = -lunwind-x86 -llzma -lunwind
   endif
-  NO_PERF_REGS := 0
 endif
 
 ifeq ($(SRCARCH),arm)
-  NO_PERF_REGS := 0
   LIBUNWIND_LIBS = -lunwind -lunwind-arm
 endif
 
 ifeq ($(SRCARCH),arm64)
-  NO_PERF_REGS := 0
   CFLAGS += -I$(OUTPUT)arch/arm64/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-aarch64
 endif
 
 ifeq ($(SRCARCH),loongarch)
-  NO_PERF_REGS := 0
   CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
 endif
 
-ifeq ($(SRCARCH),riscv)
-  NO_PERF_REGS := 0
-endif
-
-ifeq ($(SRCARCH),csky)
-  NO_PERF_REGS := 0
-endif
-
 ifeq ($(ARCH),s390)
-  NO_PERF_REGS := 0
   CFLAGS += -fPIC -I$(OUTPUT)arch/s390/include/generated
 endif
 
 ifeq ($(ARCH),mips)
-  NO_PERF_REGS := 0
   CFLAGS += -I$(OUTPUT)arch/mips/include/generated
   LIBUNWIND_LIBS = -lunwind -lunwind-mips
 endif
@@ -161,10 +144,6 @@ endif
 FEATURE_CHECK_CFLAGS-libopencsd := $(LIBOPENCSD_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libopencsd := $(LIBOPENCSD_LDFLAGS) $(OPENCSDLIBS)
 
-ifeq ($(NO_PERF_REGS),0)
-  CFLAGS += -DHAVE_PERF_REGS_SUPPORT
-endif
-
 # for linking with debug library, run like:
 # make DEBUG=1 LIBDW_DIR=/opt/libdw/
 ifdef LIBDW_DIR
-- 
2.34.1


