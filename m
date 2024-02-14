Return-Path: <linux-kernel+bounces-65149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EAD854897
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B33EB28B92
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DE218E0E;
	Wed, 14 Feb 2024 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qoitnz4U"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F5D1B593
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910821; cv=none; b=C3ap+XAmS7SYouiYtxiQknJO+m8U5lHMuj7bDw5i8izerEbJEYSf83dC3d1tz8vInPGUDesSt0Y1+KU6rHBo2WlyOuK+WnMZoLlf7IANWa8o0DQTcTlVZpWWIXnWqbRq0L2N+8S795gM1o/n1DXaApvejZppyY4cr6Yri405MPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910821; c=relaxed/simple;
	bh=x0tKh0h9jiEc+KxcZFZhTJt93jwtCYA79w+Ls4KWcgs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sshvIyc2vFsQQMKXKoaGG5pihuJDxsUqkbkxlpjKgtRBJCEFeBDsHQqI5egudrAkHO869jX964sNL8gvTAtD6jXTUcsquTwGU5sb4tamNa1/3b8kZ22SBMzszlgHXlHUUFDnXJlBNXC0WAjiPlMLx1c4EGJXCVe42Ft5NgWzip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qoitnz4U; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707910818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VD63rmegeHIhLLGV64EOuqcCVX11XoTApOW/sI3SuGY=;
	b=Qoitnz4UP5hNcUavGMoMUemm8tfGEtUwTIwDldz/MawdEPqsfElc6milVX9Vr4uJ14t5tu
	jKyQlLzs5K/6MKFBpoQ4t/hExWMfhd73fjpBMPN5++7KvNey8dGfCiyo1Tt4y/Lt082eIj
	7LG0CurF9nAeOF+L0NJyiPfBKt9jvCQ=
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
Subject: [PATCH v1 1/4] perf build: Remove unused CONFIG_PERF_REGS
Date: Wed, 14 Feb 2024 19:39:44 +0800
Message-Id: <20240214113947.240957-2-leo.yan@linux.dev>
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

CONFIG_PERF_REGS is not used, remove it.

Signed-off-by: Leo Yan <leo.yan@linux.dev>
---
 tools/perf/Makefile.config | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index aa55850fbc21..8b740c668ab7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -105,10 +105,6 @@ ifeq ($(ARCH),mips)
   LIBUNWIND_LIBS = -lunwind -lunwind-mips
 endif
 
-ifeq ($(NO_PERF_REGS),0)
-  $(call detected,CONFIG_PERF_REGS)
-endif
-
 # So far there's only x86 and arm libdw unwind support merged in perf.
 # Disable it on all other architectures in case libdw unwind
 # support is detected in system. Add supported architectures
-- 
2.34.1


