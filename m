Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D07787DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 04:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242284AbjHYCkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 22:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbjHYCkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D781AD
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-58cb845f2f2so6930717b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 19:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931239; x=1693536039;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nEmDxZXfqmiXij1P26PReriZNwm7Tzx0wPywITAyVZs=;
        b=0X4KsFbq6USzQWLK6dPK1VNHuT9qZ+6GnaNMLUTmFZL9XI5UK5j4OZhgw9gK4InZRb
         kKS8+Eu64Phorz6npOSiBkB0rdM17BaYM7yjh0Z0203v9TJ3n5m155de8klBCzUoh1qS
         DVybSs9v7pnVwF8qqaKXuD6n6BnWKTG/A/eJFRpmFlXZgSZx4uB9SxxAKn7HCl0s9FQS
         3tyVb7DRO9MojxBY5WcOnOEHBtI7+uC63kASOKS8zXpI6IdUtcUw0E/Fm3T2FI38/lg4
         xtceYZqS0Jw+LvOrNxpqcPEsRAwy6tD1pttwBM/aVoNlFOlyfZOlk+Ci4jcmKvHk4zQt
         +D5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931239; x=1693536039;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nEmDxZXfqmiXij1P26PReriZNwm7Tzx0wPywITAyVZs=;
        b=CMP7bq48iQ3qbGqZ0w/uT5GiGS0r3nnl8wGf8GLGWm7fP5ifMPwVY4wKoQYXhLgZPt
         TAKT9v9mAn2Bo/HY0jBzLFk4X36j+wTokQFhrmw1D5theYqhr+KeYfSA2ZlgfGzFodPZ
         dFYjn8YQi+elun5CXPer053xI4dJ2FyCtYgCXPmNQm5SuXbZt8BRiz8PixdG2r7le33z
         dpz/ifaV/5SauQ3ORMGIyBKq9TioK6k2P73L8ysWxksJoKG9LnlLXxG4B3n9cf1hnExo
         DbXGu7ZHw3ABh2UFs3NHfC3gbHy95cn5J94Mc/revdEBfaGiOmxaYUIVKuat57+hOPm5
         zbSg==
X-Gm-Message-State: AOJu0YxHU5GkgW9d92v2QD3GsADDUplQ1HHgwWOXU0Ix7wq8BzKMDP2X
        A7Eoj8qulNINXrr/OSY9CMWA7GMSX01l
X-Google-Smtp-Source: AGHT+IFgEMlpncts413bII2U21Eeh/C12lVb7PU6bgessDFhUJEFalAJ7Hcxnx0KkdzL9w9raMJUEdJo8+6b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a81:ae27:0:b0:584:41b7:30e7 with SMTP id
 m39-20020a81ae27000000b0058441b730e7mr317527ywh.0.1692931239309; Thu, 24 Aug
 2023 19:40:39 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:40:01 -0700
In-Reply-To: <20230825024002.801955-1-irogers@google.com>
Message-Id: <20230825024002.801955-6-irogers@google.com>
Mime-Version: 1.0
References: <20230825024002.801955-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 5/6] perf build-id: Simplify build_id_cache__cachedir
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
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

Initialize realname to NULL, rather than name. This avoids a cast and
as realpath is either NULL or an allocated string, free can be called
unconditionally.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/build-id.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 36728222a5b4..03c64b85383b 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -560,7 +560,7 @@ char *build_id_cache__cachedir(const char *sbuild_id, const char *name,
 			       struct nsinfo *nsi, bool is_kallsyms,
 			       bool is_vdso)
 {
-	char *realname = (char *)name, *filename;
+	char *realname = NULL, *filename;
 	bool slash = is_kallsyms || is_vdso;
 
 	if (!slash)
@@ -571,9 +571,7 @@ char *build_id_cache__cachedir(const char *sbuild_id, const char *name,
 		     sbuild_id ? "/" : "", sbuild_id ?: "") < 0)
 		filename = NULL;
 
-	if (!slash)
-		free(realname);
-
+	free(realname);
 	return filename;
 }
 
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

