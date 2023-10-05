Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC86C7BAF2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjJEXL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjJEXJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:07 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA7101
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:08:59 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d91c3b26c9eso1393561276.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547339; x=1697152139; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqO+Ua8t6nlwvlcHvKwWAEoEKjeWve4b13tLAZbDaS4=;
        b=y5CYrievUQqJddtm3FSnpLLnBc+12ItcewcwLI5BSIKVZzmjLaw15oYNWXpEWPbNqb
         1OefV/32exp7kzbcvh/ylAzZOem/GHN4NmQJFBrCj9G/8HpCSIg47vQmFPAvoHdywjs0
         Nyp/ErrLPeDmjiMGSbz84EsLRTXTRIi2EjFeii0BnkdQdsjIg2QQuRLIBU0t1jg6HYL+
         W5bMIZQgdNkCzYCDO368NZi2JVFt/4DE5HBCJqin4pqQKERZobffIam+Ye84BmjWhW7P
         d4obCpAKPWnhbkyuXhNAWdG7Mouh3ZvS1OnxqxTxZ2tbbgkAZUf19UK2qrGAhhbk42rw
         8BVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547339; x=1697152139;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqO+Ua8t6nlwvlcHvKwWAEoEKjeWve4b13tLAZbDaS4=;
        b=QemquBRWP3WSuJp6I6HqL82bs7xkkPeabNvC0zpJDXsSikAAIGA51P3D2rmxrVLzXB
         A/KojhNs8Sae5EINQPOkzT+JceXxIArgszbuL6zHL/BgJZAIIaJ9AO7hs1hLsTxWoXd/
         y08Cp6+m8vTt/IWCj6rzlIrpeTA6hrzQ8Vm8CUiydq6zfp3S4hW3U85ob/T9c6Mr+Ecn
         e+7BisnrzaYrZ6saMZBYiYdjMPz2qFlWMS45B5dPAIxyDYWNTk+EMr7fXBYVaH6UOmCz
         kVJhnxJwGuboQsLWqXEznbLwToRaZI/O6D9zGVS/IpmxzvCTXmxo/hh6uK0O8Tg9dtdB
         M/tA==
X-Gm-Message-State: AOJu0YzFJa/CVFJ3BZGUULR7oOgEkjE3wEdntLg4Uq7tiH+vB6t4KpJb
        730pQcgiPbfNJxP6Tux/YJ2/5hr8jBPB
X-Google-Smtp-Source: AGHT+IG3kHmRqHWDft5tWM1zuYzngpqzvq67zhBHl4j2X94Z3ybhq4yxBzMt9WFB8IAAUgdjbeChJkU/HvMR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a25:868d:0:b0:d81:57ba:4d7a with SMTP id
 z13-20020a25868d000000b00d8157ba4d7amr80931ybk.6.1696547339163; Thu, 05 Oct
 2023 16:08:59 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:34 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-2-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 01/18] gen_compile_commands: Allow the line prefix to still
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
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
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
2.42.0.609.gbb76f46606-goog

