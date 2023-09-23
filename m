Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6B07ABDE9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjIWFgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjIWFgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:36:01 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D9CC7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e78032ef9so54065147b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447350; x=1696052150; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/AfDeYd3y4U8gp4T1+0CLrDpr9vwqimMAiCox+i0+u8=;
        b=Hn3VBRTiMJEEBkI6gwTaSqQTAD7HGnv4E8RQCSUkonv6Wpnfi1vjgTaAW6uoAQeAwx
         7263ONpjq795I8fZFMhSeZBCwpB9owiYfrWyHIiLIY/feIPcVB9rMqGhbl3Vc4VYc7Rm
         DNTiamzYd454hl0FqI4a8vp6hc85d9eBjYKpcjGfBz74U4hAYMoiY98fxeZZ4/vbThGH
         8PYqAr7bFnGktPi75mKyuUtmrEyyiMyuhg0MhE+JSyYoJfByQh7V0nv8oGvxXeHubo1E
         10H9A1sMzCjHb733vIxDNbmZxXlM1AoIulRLEKc0MwYh4EoIXnUAkPZGuv7XK2qeijVH
         AUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447350; x=1696052150;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AfDeYd3y4U8gp4T1+0CLrDpr9vwqimMAiCox+i0+u8=;
        b=Gy/zyX4NdQatuqggipjN6pIJQkOuNm0cNEGrmQatYwDN4B89iutJUqyiYAjIp6YDt0
         KcoJTGdgZcK3l3RAbgrg8pF14O3ni48mckZC96umx70ZR9fiL56RtbXvhpfPKpScPqPj
         Hwh9DwldlkvYeqSUtq22FLN1xKmJ7N/kreqa2pVobrjYfWddp3MnRvJ3XX3LmYAWWVVW
         ECdkZYARXW+FUjWAsAkKI06utyjfj8GoTsL8aOSnQMUHgJN0OHBDzhLH20oqX3rXl/DS
         M684VCQrIM3FU9/xDZHgmLX345r2TXQkbyhXB2bHk+xBrj2ZQZqZ+GLcLVECOt3YGAqe
         xdQQ==
X-Gm-Message-State: AOJu0YwhELMLKKsUVb4Mg3eJ2m3yr721+iDpNTZJN7Bhnl13sP9GCz5r
        n1aoFnLXKGBjisdgnpfGZO19/uUI4b6A
X-Google-Smtp-Source: AGHT+IFEnjvrFYTzzkb1dI9/2klEiZwWev3gToYu5hzr8ovZWNcWhYoEwlz8DIZQ9Lino1g7YG2kJaYO8amj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:690c:72c:b0:59b:d33b:5ddc with SMTP id
 bt12-20020a05690c072c00b0059bd33b5ddcmr20810ywb.4.1695447350168; Fri, 22 Sep
 2023 22:35:50 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:03 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-7-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 06/18] perf buildid-cache: Fix use of uninitialized value
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

The buildid filename is first determined and then from this the
buildid read. If getting the filename fails then the buildid will be
used for a later memcmp uninitialized. Detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-buildid-cache.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index cd381693658b..e2a40f1d9225 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -277,8 +277,10 @@ static bool dso__missing_buildid_cache(struct dso *dso, int parm __maybe_unused)
 	char filename[PATH_MAX];
 	struct build_id bid;
 
-	if (dso__build_id_filename(dso, filename, sizeof(filename), false) &&
-	    filename__read_build_id(filename, &bid) == -1) {
+	if (!dso__build_id_filename(dso, filename, sizeof(filename), false))
+		return true;
+
+	if (filename__read_build_id(filename, &bid) == -1) {
 		if (errno == ENOENT)
 			return false;
 
-- 
2.42.0.515.g380fc7ccd1-goog

