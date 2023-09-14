Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0077A0FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 23:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjINVUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 17:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjINVUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 17:20:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAE026BE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:19:57 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58c9d29588aso18785667b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694726397; x=1695331197; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gyCa8y2D4tfagLdEhZkffRRlznGd/QDpuIxcjKD4E/c=;
        b=ULpz5Oo6VSuE8V0wxV+/CzBqWNORlkgya7siYPEDDVTpgoSW2zSIUaCIjVseg27xgh
         bNjZ5GX4ED6wx0gosbObdjzy/fb59mevqy343lBYpSc6yqbfcegDmfbcYKibcJovHLZ1
         tjBQo6YNPuKNTG08+2DfrZbsT+zgeazub8uOYn/xRdUEzghEcp9pOI40GjFPiaktP01Y
         qWGxCnefPBne7FXi6sdBXmswWzNGWNy7Wl8ngZcNXPv6JUMi9UtE0zEDWYlXFWVaUHeb
         oYkMoXW6FiOCPxlyadX1Pq0AK/WAFIME79OF3nLnZYJKktMSVXkaC6whwCw4cSAULCVW
         PHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694726397; x=1695331197;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gyCa8y2D4tfagLdEhZkffRRlznGd/QDpuIxcjKD4E/c=;
        b=CIkqFLW/RgMHsDYtX9DatWyWggaOyKAbySyxbQhFSPBbJLwpmYcjXJJ9VPB9GKWVtx
         6EtgOtu/IDVPYYXlcgTS6h5c8WM22xmxs+0aJ2v5wB6A/0JEjCXLjpalgIl00DtjBA/v
         5SqG4dB8SOwWd9XxDIOr7dED0z8lfcf6yTCLE+wRJPJ4S0sqZIVzGoSQe9eG6AvLV/8U
         Jd+EB8W4OIjKiqSpqJ6MxoZSUunf49RNnNuZpAFLrkzSfzUGBruau/kjO37uDlOd3D1x
         qp8KBzQycmyO1Zi2iPSBae9DMMJ9Z+ZbR8/7KJ1lncbIySfuoG75QowXLeCpWPBvfDuL
         VXAg==
X-Gm-Message-State: AOJu0Yx0Jce+wHkKMXsNv9I3YQvPJqDKkChW3CdsKr1stC8GIfTXQAPT
        7avlZKpkb5qbOX9+9V0AjiEsnjUTM+Pe
X-Google-Smtp-Source: AGHT+IFICCNKx7p+w3Fwj7ubun2Y+fAPBczDWbh5iaJborCvmiUiAZpQehTzmuFkOiLw/9n5Yvv+V5nsTa3o
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5357:1d03:3084:aacb])
 (user=irogers job=sendgmr) by 2002:a05:690c:a8a:b0:59b:c6bb:babb with SMTP id
 ci10-20020a05690c0a8a00b0059bc6bbbabbmr148679ywb.6.1694726397030; Thu, 14 Sep
 2023 14:19:57 -0700 (PDT)
Date:   Thu, 14 Sep 2023 14:19:43 -0700
Message-Id: <20230914211948.814999-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
Subject: [PATCH v1 0/5] Enable BPF skeletons by default
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

Enable BPF skeletons by default but warn don't fail if they can't be
supported. This was the intended behavior for Linux 6.4 but it caused
an issue captured in this thread:
https://lore.kernel.org/lkml/20230503211801.897735-1-acme@kernel.org/

This issue isn't repeated here as the previous issue related to
generating vmlinux.h, which is no longer performed by default as a
checked-in vmlinux.h is used instead.

Unlike with those changes, the BUILD_BPF_SKEL is kept and setting it
to 0 disables BPF skeletons. Also, rather than fail the build due to a
missed dependency, dependencies are checked and BPF skeletons disabled
if they aren't present.

Some related commits:
b7a2d774c9c5 perf build: Add ability to build with a generated vmlinux.h
a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
a2af0f6b8ef7 perf build: Add system include paths to BPF builds
5be6cecda080 perf bpf skels: Make vmlinux.h use bpf.h and perf_event.h in source directory
9a2d5178b9d5 Revert "perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL"
a887466562b4 perf bpf skels: Stop using vmlinux.h generated from BTF, use subset of used structs + CO-RE
1d7966547e11 perf build: Add warning for when vmlinux.h generation fails
a980755beb5a perf build: Make BUILD_BPF_SKEL default, rename to NO_BPF_SKEL

Ian Rogers (5):
  perf version: Add status of bpf skeletons
  perf build: Default BUILD_BPF_SKEL, warn/disable for missing deps
  perf test: Update build test for changed BPF skeleton defaults
  perf test: Ensure EXTRA_TESTS is covered in build test
  perf test: Detect off-cpu support from build options

 tools/perf/Makefile.config              | 78 ++++++++++++++++---------
 tools/perf/Makefile.perf                |  8 +--
 tools/perf/builtin-version.c            |  1 +
 tools/perf/tests/make                   |  7 ++-
 tools/perf/tests/shell/record_offcpu.sh |  2 +-
 5 files changed, 59 insertions(+), 37 deletions(-)

-- 
2.42.0.459.ge4e396fd5e-goog

