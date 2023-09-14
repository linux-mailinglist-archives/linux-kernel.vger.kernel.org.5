Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5D47A0FB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjINVUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjINVUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:20:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB38B2707
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:20:04 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7e8bb74b59so1767809276.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726403; x=1695331203; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Br6oKi7mTFdhI/sS2Gl2xU7/jDtLT7KyY4n04DEal0=;
        b=YVMLB5OGWEbXMj2TypGxwScFqF5SMACUyZnerRqGrtVj2YnifhAtnPO747YqC1AbU2
         gDPOo6EGZlP3jauDQZBRIyN2jJGZyEwjO6nXomc5jAhgti+4fK7zA4DN3N5ck1nkrg3d
         kcNlltAmxDdIXXujV/p5gOTe0DVFmJmqoIH7cS8baMVfWAPa+fLTp0FrjAAF+7Qa2lm9
         4zQoEqTR5zcmmedQ4ayTUyXq47N32yzNCvj3kSwrA70wCTWGaNNLBBnI4OLMlf3K1XwS
         Gt8gR+nafWpkHYphWxNN9J60gzeIKppYC3j/zT0mkWFyTkSpsT9L8m0We8czhGR5HC8R
         mIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726403; x=1695331203;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Br6oKi7mTFdhI/sS2Gl2xU7/jDtLT7KyY4n04DEal0=;
        b=S9lNC5BGTEKN/kZu2QAe4iPETUvBagPa6fhorHy15oHXmcqBylyezrWhhGxxOK2FIF
         SCaAVahP5/sym5GvOJ/Vp3vmTwPRUAwIG0MvMM5OLVNS/TNgP2Y/ZV07tklf3WV+GaHl
         hp0xlWClXgAehZurRibauZ6l5pTO0IY5SR+S3Z+ws5LFnXiriiXn8S8c3aqprQglWCN7
         +UuRG+vmWGi6NNreEGyK8mKEBpClAwmTfP9zDmX4A6+GRvn1PACMb70RfBzVgs4flNXm
         84Xx0H4JQs2Ry6771TMEF1RfqRtMJulqXdKGk7SgkyezeqXkspIKQCQyzjtGmC0ftZew
         xyFA==
X-Gm-Message-State: AOJu0YxkNIwQMPe/AG2sYWLbTOpQmTjgJ0+lTu0u+VlAhge4sN1P9Gzl
        nsHphYUHIpV1rhUV24ahr/HAYQYa677t
X-Google-Smtp-Source: AGHT+IHs5wkR+KiaL7EtqQCQpiLyI7h1XQQLsqyWJg8cBDHl64BZ691Sqo/oENqg9GTO1CpzGy0/AIzlBRLZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a25:aa83:0:b0:d77:984e:c770 with SMTP id
 t3-20020a25aa83000000b00d77984ec770mr152103ybi.5.1694726403757; Thu, 14 Sep
 2023 14:20:03 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:19:46 -0700
In-Reply-To: <20230914211948.814999-1-irogers@google.com>
Message-Id: <20230914211948.814999-4-irogers@google.com>
Mime-Version: 1.0
References: <20230914211948.814999-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 3/5] perf test: Update build test for changed BPF skeleton defaults
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Patrice Duroux <patrice.duroux@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a target name and set BUILD_BPF_SKEL to 0 rather than 1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/make | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index ea4c341f5af1..a3a0f2a8bba0 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -70,8 +70,8 @@ make_python_perf_so := $(python_perf_so)
 make_debug          := DEBUG=1
 make_nondistro      := BUILD_NONDISTRO=1
 make_extra_tests    := EXTRA_TESTS=1
-make_bpf_skel       := BUILD_BPF_SKEL=1
-make_gen_vmlinux_h  := BUILD_BPF_SKEL=1 GEN_VMLINUX_H=1
+make_no_bpf_skel    := BUILD_BPF_SKEL=0
+make_gen_vmlinux_h  := GEN_VMLINUX_H=1
 make_no_libperl     := NO_LIBPERL=1
 make_no_libpython   := NO_LIBPYTHON=1
 make_no_scripts     := NO_LIBPYTHON=1 NO_LIBPERL=1
@@ -138,7 +138,7 @@ endif
 run += make_python_perf_so
 run += make_debug
 run += make_nondistro
-run += make_build_bpf_skel
+run += make_no_bpf_skel
 run += make_gen_vmlinux_h
 run += make_no_libperl
 run += make_no_libpython
-- 
2.42.0.459.ge4e396fd5e-goog

