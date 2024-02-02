Return-Path: <linux-kernel+bounces-50718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EE1847D40
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C990DB27327
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5BE12C806;
	Fri,  2 Feb 2024 23:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RelY/ddO"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A063C12C804
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917272; cv=none; b=K46E2CU15AbA75BGkrgimYRMsHpREROu1FZAQ5rI0GmUcNpU+yBdieN65VIz14YMV/7DULeRC+Jm4SYM5PXJVmskaPvgb6oBf6mn3dLEApJi1xbkIuBvX47k8EsaPg5fAIx+GLdk775xcs+2Pf5r8MIn26B2ldqPv8xtBEMX6UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917272; c=relaxed/simple;
	bh=MMnuh1Oc8aQIK4NgPRT+2TknlqEUkEHoJeYCwVzCcjI=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YJkYlm0p5acSBHqg5zREAM+0QiLTVDGVgT9rCrJgYRuiUA2F0ueJQcfQNNx+nivk9U7CRkBO8UpWNjnY9F5q/7oaqFPusZwL5BKJmg6+gMkRZtxRXUWVGi82IslIz+2Rr5mmKhlZRQGEiqpN0XQPDXvgE2kjfgp6RWydZ+HT3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RelY/ddO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5ee22efe5eeso45171947b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917269; x=1707522069; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CGn7q3AR6sBJnuW0w7X+aFdd8u9EK+5apJ+BcUW3hYQ=;
        b=RelY/ddOhKc1+BmeSxPyTBj+bqIGPOtpzXzfuW+1LK++0ycq4is/vC5KhNDldKi4SW
         MBNk7bzIv1GsR8vj/a0/k5IrQLl7nK5BkgnkbwEx7lI4jVtJWiPC70uj0A1LFsS+TThm
         tUd43kdOtxmYGLDldWDKqwu5vROtwM/T+gBik3pyPaLvOZLWoOc0JNaWA7RiXY8EZndY
         lUyxTR5aLOYgq5JPmD+INa/VVA508/0wB1mwl83WiO5IVddC+wPJNOeWnTrehfEj8ktl
         jp9xAp8/btUWmk09/vn1nso/03+LIrM6CSX6gvhqwNzkTftuN+WMZGw1g5I4dEbgAAHd
         gkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917269; x=1707522069;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGn7q3AR6sBJnuW0w7X+aFdd8u9EK+5apJ+BcUW3hYQ=;
        b=Zntb3C7TJsLNQNjJBeCax6Q3ArZ+7AQRBIuSh8G8eS6JwKID0Gw2wA+LgpdaTv1JN9
         tok1G4YsWS8Sb5bRKlZm9clIZLaSUWtGSclQZzU8Cy/NOg7tx63W2MM6mB+5X9mNKmrs
         EB5y9JV35yLDFfT0kR061p823qT9Erl3HYaATt8NSWoovnHYsx2jJCHrNsMJd2NBsgca
         t14Edrytp/wS7n3xnFw2UR2uSHF1LEABB4lWU1vM2fx77Tjjz9+7J7HXr5p5x8T0xCIq
         ymwtIJfaoqG5cE9HW6ZBSTiQEY8ugqKWBIWoYRjX/IIr8J8vt9I8YGIojCe8m26Ac2s2
         BIcQ==
X-Gm-Message-State: AOJu0Yys06ia9UnbxFgua/jJLX2jY72M1l4N13rTPLQrLnQBoi4MXIeh
	hmsNFJXPoGIxZ8z+3LLAt4B0uSR6CmbGg82ifmpKsadsT81DtYXPbu0e9AwY4+kfO4zct+ofE1J
	L29qvAw==
X-Google-Smtp-Source: AGHT+IHylMNHjoaYXoYqqOOZFoFT4X3A3hWj7pDcXfX2BSwpZDbVFcOqv6wqndJbEhdaoK213X6R34ETA+tx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b0d:b0:dc6:ee66:da6b with SMTP
 id eh13-20020a0569021b0d00b00dc6ee66da6bmr100341ybb.7.1706917269595; Fri, 02
 Feb 2024 15:41:09 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:49 -0800
Message-Id: <20240202234057.2085863-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 0/8] Clean up libperf cpumap's empty function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Rename and clean up the use of libperf CPU map functions particularly
focussing on perf_cpu_map__empty that may return true for maps
containing CPUs but also with an "any CPU"/dummy value.

perf_cpu_map__nr is also troubling in that iterating an empty CPU map
will yield the "any CPU"/dummy value. Reduce the appearance of some
calls to this by using the perf_cpu_map__for_each_cpu macro.

v3: Address handling of "any" is arm-spe/cs-etm patch.
v2: 6 patches were merged by Arnaldo. New patch added ensure empty
    maps are allocated as NULL (suggested by James Clark). Hopefully a
    fix to "perf arm-spe/cs-etm: Directly iterate CPU maps".

Ian Rogers (8):
  libperf cpumap: Add any, empty and min helpers
  libperf cpumap: Ensure empty cpumap is NULL from alloc
  perf arm-spe/cs-etm: Directly iterate CPU maps
  perf intel-pt/intel-bts: Switch perf_cpu_map__has_any_cpu_or_is_empty
    use
  perf cpumap: Clean up use of perf_cpu_map__has_any_cpu_or_is_empty
  perf arm64 header: Remove unnecessary CPU map get and put
  perf stat: Remove duplicate cpus_map_matched function
  perf cpumap: Use perf_cpu_map__for_each_cpu when possible

 tools/lib/perf/cpumap.c                       |  33 ++++-
 tools/lib/perf/include/perf/cpumap.h          |  16 +++
 tools/lib/perf/libperf.map                    |   4 +
 tools/perf/arch/arm/util/cs-etm.c             | 114 ++++++++----------
 tools/perf/arch/arm64/util/arm-spe.c          |   4 +-
 tools/perf/arch/arm64/util/header.c           |  13 +-
 tools/perf/arch/x86/util/intel-bts.c          |   4 +-
 tools/perf/arch/x86/util/intel-pt.c           |  10 +-
 tools/perf/builtin-c2c.c                      |   6 +-
 tools/perf/builtin-stat.c                     |  31 +----
 tools/perf/tests/bitmap.c                     |  13 +-
 tools/perf/tests/topology.c                   |  46 +++----
 tools/perf/util/auxtrace.c                    |   4 +-
 tools/perf/util/bpf_kwork.c                   |  16 +--
 tools/perf/util/bpf_kwork_top.c               |  12 +-
 tools/perf/util/cpumap.c                      |  12 +-
 tools/perf/util/record.c                      |   2 +-
 .../scripting-engines/trace-event-python.c    |  12 +-
 tools/perf/util/session.c                     |   5 +-
 tools/perf/util/stat.c                        |   2 +-
 tools/perf/util/svghelper.c                   |  20 ++-
 21 files changed, 192 insertions(+), 187 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


