Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34A87ABDDD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjIWFfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjIWFfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:35:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AB61A7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59e79a36097so105018267b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447339; x=1696052139; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BGf8PiM0IiriMve24vBUlDxd/ZI4TAjoSgcit1w5zEk=;
        b=iC5lHGL7HASQPtSViakLGECJ4XhRQ8ewcJaAbS5zKRzlCABO3fqmMS3x7ZIWdcDVuF
         o2T23ncMGmaBR5wfmmKYVRTqXtHaf9+6MUjKaNsleoNR+DFXfizmkxys1fvdWRcpbk0t
         H6V8ku8IToq0tsZ39jqCQxxeCSujJu8sLaE3Q18Xk7CcBA6HaczAJzu+1w7ub0b9iBZN
         MMUsh2NhoAUdP+p9HWq6o9ugYpYG/Gw1ZwtUHZavk6/e+DJpVTVz38ctELel2uYjrq12
         nhBkehEL+B8Vy8uA7HDaa8NAkHi6pZmxI9cE0IZxUOOqK2JtrvXOGw0BCFFNyebZee80
         W2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447339; x=1696052139;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGf8PiM0IiriMve24vBUlDxd/ZI4TAjoSgcit1w5zEk=;
        b=fZP9xtZI5BQMXLn1XnKIr0AfGNy+U+tQgyAIaF6lwA35YK3PFZoP2BucjZeM763WrH
         YPqUIDbDHP77+PlcoQHdOr5aDPe2z/dsb7tHi+tNZ4cwl3cLV95AWH+Qkau/19qK7JL4
         k3TficUdZ/zGYOxJmYx0ALAhZKJ5fqWtVjiT+9Kx8zxIcaGd73xphbAEjJNU7mcaxaCW
         LjTe7AukWKYEudb+5GPrTKs4i2mQY4FLV8oo8GI6IQp4abRlEvEjfOqvS4UTKIfN+VKr
         4MNqf4yNsv/A42UBZ/w4ycOvpq0Ulw3xTfpk2KlaNaG/prn8l4pO8suGH2on3tcHVxQv
         nCpA==
X-Gm-Message-State: AOJu0YziocMq1cLMxebiJGcM/5yaX4xB/OGci3Tco2YVa5dCYtK3Dylz
        lEftCnTU7FkSZ+Jkxi1LbsH268bOZeRX
X-Google-Smtp-Source: AGHT+IER3/Ekga4CWFfnCnjgBf21uB1xN+LlgPp7pbLhX4QChejR7/30xnfk3VwuhyKCQmfs43pumojGijGw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:690c:707:b0:59f:4c14:ac5e with SMTP id
 bs7-20020a05690c070700b0059f4c14ac5emr28292ywb.2.1695447338979; Fri, 22 Sep
 2023 22:35:38 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:34:58 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-2-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 01/18] gen_compile_commands: Allow the line prefix to still
 be cmd_
From:   Ian Rogers <irogers@google.com>
To:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Yuan Can <yuancan@huawei.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Builds in tools still use the cmd_ prefix in .cmd files, so don't
require the saved part. Name the groups in the line pattern match so
that changing the regular expression is more robust and works with the
addition of a new match group.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 scripts/clang-tools/gen_compile_commands.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index a84cc5737c2c..b43f9149893c 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -19,7 +19,7 @@ _DEFAULT_OUTPUT = 'compile_commands.json'
 _DEFAULT_LOG_LEVEL = 'WARNING'
 
 _FILENAME_PATTERN = r'^\..*\.cmd$'
-_LINE_PATTERN = r'^savedcmd_[^ ]*\.o := (.* )([^ ]*\.[cS]) *(;|$)'
+_LINE_PATTERN = r'^(saved)?cmd_[^ ]*\.o := (?P<command_prefix>.* )(?P<file_path>[^ ]*\.[cS]) *(;|$)'
 _VALID_LOG_LEVELS = ['DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL']
 # The tools/ directory adopts a different build system, and produces .cmd
 # files in a different format. Do not support it.
@@ -213,8 +213,8 @@ def main():
                 result = line_matcher.match(f.readline())
                 if result:
                     try:
-                        entry = process_line(directory, result.group(1),
-                                             result.group(2))
+                        entry = process_line(directory, result.group('command_prefix'),
+                                             result.group('file_path'))
                         compile_commands.append(entry)
                     except ValueError as err:
                         logging.info('Could not add line from %s: %s',
-- 
2.42.0.515.g380fc7ccd1-goog

