Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032457BE9C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378227AbjJISjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378156AbjJISjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:39:31 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6500CA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:39:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a213b4d0efso73084397b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 11:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696876768; x=1697481568; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqO+Ua8t6nlwvlcHvKwWAEoEKjeWve4b13tLAZbDaS4=;
        b=TKxbdCDkBWdYhlDTIxIVylHp7xWFWu79iK2O8lraz+QDiWTJx6k3QpxaoGQYe5R260
         tpPX5YRHBNoLzTx9lxfzsvzwUgnUixUpG3YF2qJEh+f3W+upCMFj39WhJ1RFlhbqOdIE
         zv46yB5jOSK/FWrAIP0xI7qMdCrB4ZSVoT3nbBaOpLMAcdrtSdT0jL0loH98XA0aLhZr
         dtufYrU14jAAPjxsrLyBTcCiXb+YzC2NCauiChbTmXQrsb85qRMCpph6A2PcgVAraVVn
         OrxbsQEQRXqHNBTfBJUgL0GTbYGBPSVPi2Y7YtJmK7ZJ5MvFYRP3/q1E6AFfrfXkTO8Y
         00wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696876768; x=1697481568;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqO+Ua8t6nlwvlcHvKwWAEoEKjeWve4b13tLAZbDaS4=;
        b=CJXsUOPMLnOwtmbcZumSd3+MFSLggWxP5PrCQWfw7Ms0ejtXqra6KvOkm27JgMBSRE
         PLPbmD2T0Y44v1HTnjMWBR5g6cmGxQIta31CvONbxsNlTbD/5SyPBC/Nv66WGX9NxUdu
         Oovbk3wsuhMJkI+trnce0ArBoZJj4z+JlaGG6B415uJS4GEoc/EzZfIKRWfUVL6Zkpih
         StH9crgXmllcPMKyD747J2tKWG7Gocsc4lGUvVFz+kHfnFrzZlIUr2BIcoQ/QAnP8Pst
         u5OaGapEjGtT1d0GS35i/MWffbihtFuuy5fXPzcDDIHLWL7GYqPacXr6n26+Dt3LY8Kh
         RO/w==
X-Gm-Message-State: AOJu0YxY6xcKR5OQsJIRtLdcGiBr4s+rxxgPV5tiNnd0uO3vxYdv/xHM
        kqCwrw3WXuLHeAXweQmq/3B5sLpF/mFz
X-Google-Smtp-Source: AGHT+IE8rbiHTWNG1mYNALTAoi+/t0J7e5qpPykiWnCmQtpQDmBIpJJlxaAEE5cILLQqAZstEZU8apjPkO6F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:ac4a:9b94:7158:3f4e])
 (user=irogers job=sendgmr) by 2002:a81:bc03:0:b0:59b:c6bb:babb with SMTP id
 a3-20020a81bc03000000b0059bc6bbbabbmr297622ywi.6.1696876768652; Mon, 09 Oct
 2023 11:39:28 -0700 (PDT)
Date:   Mon,  9 Oct 2023 11:39:02 -0700
In-Reply-To: <20231009183920.200859-1-irogers@google.com>
Message-Id: <20231009183920.200859-2-irogers@google.com>
Mime-Version: 1.0
References: <20231009183920.200859-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v3 01/18] gen_compile_commands: Allow the line prefix to still
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
        Yang Jihong <yangjihong1@huawei.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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

