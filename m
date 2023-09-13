Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F81479F161
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbjIMSuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjIMSuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:50:05 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9F610DF
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:50:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58fc448ee4fso1538797b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 11:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694631000; x=1695235800; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qPAgyrXwVifCgs8YcSIJJHY71Xaauw3uUQtmqIC6VZw=;
        b=VC/aUfJSLUD322l8VLNpCyQBoOLkyS/EaUegtC7OA5mGf6zxDGSl/T+jsdBFcXH5UP
         8MueJJnfn/JizBtldwcYxCKzV2JGRQ3vR4q3cUP7TYTQ2YB9DTxLOEX29i8iwOdFc8Gt
         Z57uzqrcRP+Qey81gBp33dFPP2+N0xBZXL1Xe/SpsZp4mOxTEBuBT1OjCQ/26CWnZqp+
         CYg/wGPkzRobbYm9q8ayw6vEG+fA+lcn2T99xuOk08YP8YQBMcSYZfuV1vd9SKMgG1EX
         Ro9YEA+ym66bCKTL4eu80Jvro0rzpbCZByWqWYdyvcVKfrbr57DPCtQyU/ZQn2qebi2J
         RJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694631000; x=1695235800;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qPAgyrXwVifCgs8YcSIJJHY71Xaauw3uUQtmqIC6VZw=;
        b=l/xb9u/E3rgYfl+2aWSx+v7fRf88XeI31b40DAQdrL3OkaI0RW5vxnTKGxga23EfFR
         PB8SKtpIaFO0yMY7DjlM3/y08dTeH58j1JGgPmQxEfqjuBunxLVkG5BQWAQneupLTtlC
         T6Z0OvWAKXCO5dpv/LOluvPDgr3lL1oC6gM0KpWZI0QCDS7RUav+t/DdZx2mW9ykJiJ6
         0TgWmWn4fX7452NaPDaM8S0byqK3wsxkxXQY8MUMWe3E0hN92G4ckYzQGAohZTDMMhTn
         /dRDSNfmhhpaKs1p6IpsckSX26Vs3EKmh2uyG6Sl+qtbrj0d1yT8eGlobaP1vaj1RWYh
         5yoQ==
X-Gm-Message-State: AOJu0YyWS9zz/bKt/uEBf/1qgjlctV2vqF6LZ1AIigOmCU3bx4WEov9w
        UbMYLT2yv9AusZDPxRyqJn7TKiewFSJk
X-Google-Smtp-Source: AGHT+IGsHx+kaHfl63g3U+7aSP4ap1F2ajOv98JBdUwuZaW3YgiloBSxM9+4YpOZlykSC2AeodbWFKOxMdI7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f3b:42d0:4853:6022])
 (user=irogers job=sendgmr) by 2002:a25:6c03:0:b0:d80:2916:c3eb with SMTP id
 h3-20020a256c03000000b00d802916c3ebmr72569ybc.12.1694631000618; Wed, 13 Sep
 2023 11:50:00 -0700 (PDT)
Date:   Wed, 13 Sep 2023 11:49:57 -0700
Message-Id: <20230913184957.230076-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Subject: [PATCH v1] perf trace: Avoid compile error wrt redefining bool
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
        Leo Yan <leo.yan@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make part of an existing TODO conditional to avoid the following build
error:
```
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:26:14: error: cannot combine with previous 'char' declaration specifier
   26 | typedef char bool;
      |              ^
include/stdbool.h:20:14: note: expanded from macro 'bool'
   20 | #define bool _Bool
      |              ^
tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c:26:1: error: typedef requires a name [-Werror,-Wmissing-declarations]
   26 | typedef char bool;
      | ^~~~~~~~~~~~~~~~~
2 errors generated.
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 90ce22f9c1a9..939ec769bf4a 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -23,7 +23,9 @@
 #define MAX_CPUS  4096
 
 // FIXME: These should come from system headers
+#ifndef bool
 typedef char bool;
+#endif
 typedef int pid_t;
 typedef long long int __s64;
 typedef __s64 time64_t;
-- 
2.42.0.283.g2d96d420d3-goog

