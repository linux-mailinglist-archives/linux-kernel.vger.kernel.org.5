Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A555B7ABDFA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjIWFhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbjIWFgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:36:36 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 102111721
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:36:10 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d852a6749baso4571138276.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447368; x=1696052168; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3pdNCB2LsormKDmRgRav6emuDoIUkf2JUNU+RA747k=;
        b=w9HGH3d1H4ueLvkTYf/V9zbKX8Yc6tSYtDN5zllmhvEKeshrQTVkvtl/b7xy+XuVNa
         EJCvipKcLdQkPyDrotUG0VTu1ggww/WhaQipU9ZZZ8Bz/EV9+D2iZW+6jReCjjnbvx9f
         UA0ocNNVEnxrHnOyE9w/BOVyR6+1BNAtmLFIFOvUX+9Qm3g+EyoEhl6xBnvzR369qaxL
         FHm5ahOwiFYaBAn83VQGLZDqsKTmPwgKFd4sfxQK88SedFMU+g03ND7S2fvbHqSBuzNx
         GnrH54bhndTuHF0X2zlooC/fb63utPwq6EPUXgeanq/bi104A4q4bobpPQkgwMYWxeX0
         0goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447368; x=1696052168;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U3pdNCB2LsormKDmRgRav6emuDoIUkf2JUNU+RA747k=;
        b=vy70BErao9YKYQHm9KQyN9y3gYfGHF0Uj2AzvntwBTlbley7l7pKqW3Yns3Kp+WAzT
         7j8vNywmLBR5+8Kw+fQXFWc3/1l27aQZvsa1cyVdYhlpni5d+dTHWzROS8SQt+9dt+Q3
         xkZsuEWEotFgeEqRgNVrpQ/PncqOrwePY2V5NPJ8fY4hq0IGLveecdGiIAbLevNgG6sO
         fm5eFXhZlaE+cIZbusP4otpOm705+UM0qnkN2gZTXu9yU7L1C42v5IJPu6hGEM27o7wp
         WlAbKGh7qaJsdvnvsYhai0cOz2LQIv3U2Kiu8glSYM+gT8iL8eCCPbgI+9QFrZVbLK/e
         lrwQ==
X-Gm-Message-State: AOJu0YzAJngWiZ+nuPHzaYDrTlkpcdO3WvlN9DmLmVoREajvco6dPqNV
        jIJaTburFQF5jKwO35T8A2PL8eIt1i+F
X-Google-Smtp-Source: AGHT+IHCnNmAl4FHX9SRP9LKagjgjeFuwIZsOgArdKHwnwaZmzbMv4PHYCjxCbJouwmMwwuksIiI1+0lADIr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a25:238d:0:b0:d78:3c2e:b186 with SMTP id
 j135-20020a25238d000000b00d783c2eb186mr10894ybj.5.1695447368466; Fri, 22 Sep
 2023 22:36:08 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:11 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-15-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 14/18] perf parse-events: Fix unlikely memory leak when
 cloning terms
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing free on an error path as detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c56e07bd7dd6..23c027cf20ae 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2549,8 +2549,10 @@ int parse_events_term__clone(struct parse_events_term **new,
 		return new_term(new, &temp, /*str=*/NULL, term->val.num);
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		zfree(&temp.config);
 		return -ENOMEM;
+	}
 	return new_term(new, &temp, str, /*num=*/0);
 }
 
-- 
2.42.0.515.g380fc7ccd1-goog

