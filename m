Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A974B7ABDE0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjIWFfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIWFfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:35:48 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C9419E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:42 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59eea906b40so54359047b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447341; x=1696052141; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sj6/NNUjZTKqDNZk1SrzqO39OG4waux/cevEfWDj9So=;
        b=wSpeEJoSnHeeMN/OFwKHmaYyMl0EnOFrXzlHb3EexqQjsrgk+ntB6zqLJVyy1P6y1t
         xUIo1eypAU0SCGR4oR3lV8pR+amWiDzQVtKOR2zXLhzK06beWvQWINcss6NmycJl9QLB
         EK00okbOTreMXq6AYeyTksE0I2Z+69ReD6+OInI56nzueVgl5LgYw32UjRIVLFoQwxk8
         scCN9+En+dqVgu3sFy+8kFoLHmkS45hWZvic4XDzC43T0oFAE6rAIX8StsT+MEayVW9V
         Ka+uEUDci2p/Fcuyv5qF+KWugxNc4K9Q7k+5nc8wzoD/ra+UMQyxidwvT4OMXh0AUkYj
         I9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447341; x=1696052141;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj6/NNUjZTKqDNZk1SrzqO39OG4waux/cevEfWDj9So=;
        b=YR2norMGdTEjT9Qwbrj/b3nsblh6QT3P8Ax01pwFXwBBmyr96SQQCccyUvoX0DT7xy
         cxk6pCGIRbPI9JvY0v+qXtVXmu63B+EUo78gkvCP6A+YI+YHGyEhVgEg/l+eNDuUZowW
         o2sneQo/A4430a1FFk1fT1u0JKobJlmRg+lObCb7oGUYQdUukj3Kl0xblVKO0CZMyh+9
         1HwRHsBPNHxOYR1+ULxwPvt/inrdTa3d39MvcoduiBqJdNxCP5hmUhS8rSWSfY3NtkHO
         W6Bof4VB3ALCXHB3CdQBiLCfLZ0IB/hb9DBJCfsiS/eBELt6csoNOLT6yY0gOGwOwfOX
         KN9w==
X-Gm-Message-State: AOJu0YxDOKjYrqrCCwc0dde7BQJE65OZ3VTbt9uMVzstHMaixqLQPtLE
        1R9/4DHjdcmCKtxLEbEj4OtNH9hfHbVN
X-Google-Smtp-Source: AGHT+IHbSzioQSTamsrTSTL4Bee/g9Pe12Cn5Z+M9ExBNqmPozrvsrmeb06sIAWOJ+A4bl9QoEI2702248Yo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a81:eb0d:0:b0:59b:ec33:ec6d with SMTP id
 n13-20020a81eb0d000000b0059bec33ec6dmr21490ywm.5.1695447341257; Fri, 22 Sep
 2023 22:35:41 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:34:59 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-3-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 02/18] gen_compile_commands: Sort output compile commands
 by file name
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the output more stable and deterministic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 scripts/clang-tools/gen_compile_commands.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/clang-tools/gen_compile_commands.py b/scripts/clang-tools/gen_compile_commands.py
index b43f9149893c..180952fb91c1 100755
--- a/scripts/clang-tools/gen_compile_commands.py
+++ b/scripts/clang-tools/gen_compile_commands.py
@@ -221,7 +221,7 @@ def main():
                                      cmdfile, err)
 
     with open(output, 'wt') as f:
-        json.dump(compile_commands, f, indent=2, sort_keys=True)
+        json.dump(sorted(compile_commands, key=lambda x: x["file"]), f, indent=2, sort_keys=True)
 
 
 if __name__ == '__main__':
-- 
2.42.0.515.g380fc7ccd1-goog

