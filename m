Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEF801818
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441903AbjLAXuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235259AbjLAXui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:50:38 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A44FD50
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:50:45 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5c87663a873so39464807b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701474644; x=1702079444; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1mumLSgmv33VvcRWr1T4zCbxKl06nV2/FpT8+bbjZvo=;
        b=fVev5DUbr+bp757gk6NGZOC5GGW4F+iJnQM1qTyULolhbBS3fWk5FfZwfWwhv7Rk3u
         KnC0yFZ07Y71dN0z4Y9tsz1qj2nV+A8sOswBWhsNfXnQI6GEZIo+NjDEUlD5en04Mhhg
         w8AsCJ3xRY4Pa+89Xu0vHioP250JYIBk7nbRmdsX+LOWvfiDoQ4ySz/MLIyRenu/Q9fV
         cfBo/tnp1PYd5VOsn70J8xawg5HxMlrwi18Dd/mbXtoAoT1Qb4o0ivgmOwbd0QFF7BB2
         GL51rKQB+mJ044Agai7QNp8Evr+j5ZVKJ1jKVsRegYj9Om9EwVul01ftypk0PVdTwILn
         yxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701474644; x=1702079444;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1mumLSgmv33VvcRWr1T4zCbxKl06nV2/FpT8+bbjZvo=;
        b=CfP1BmDuoLDt4T+hqgsgkpJY6AM3SH288CU4Un3tQYvjxCDuBHek+R0YhV33E1BhKu
         Tw6rFoj+k5z+aBoZmkZfjvwDmVKAy3/BvWLBn8zrY7w3z2iKCFolqOSAhiTe3n7hMW4F
         Zijtq+N4REDmcov9UmmETK5iH2SlM5A34qKCG+RxHD5f19ZiADQW1J1FXVBnawe8dp9m
         T+ifcdGFSTgakxBesJ2zNk0FRMUg3sSjhTcLf2dxMeRYcbyGIHdO9T4OeIu/KwLC2Frj
         3P+jI6+tavJ+uboWkdqWSz1CsyAxgJYtx5jIftObe0l1z6dB7UKWPrjJuVuK9dUj6HmS
         GYLw==
X-Gm-Message-State: AOJu0YyeTTsZ2a+qzJl59gkSxaOY+al9hhXcth/g2II91cXWRvnO8G+U
        EK+4dDGP4B6HSH46EoEiUvsSMbIMLRML
X-Google-Smtp-Source: AGHT+IGWRlInLywjlQJmaHodIvzIlFUD3Gt7blh1cNR88fx8scsrg22BeeHPNTZ+X7DF2opsxPQDN/rgdj2g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:df3:224b:7b7f:efc5])
 (user=irogers job=sendgmr) by 2002:a05:690c:2849:b0:5d4:1b2d:f43f with SMTP
 id ed9-20020a05690c284900b005d41b2df43fmr125134ywb.6.1701474644325; Fri, 01
 Dec 2023 15:50:44 -0800 (PST)
Date:   Fri,  1 Dec 2023 15:50:25 -0800
In-Reply-To: <20231201235031.475293-1-irogers@google.com>
Message-Id: <20231201235031.475293-3-irogers@google.com>
Mime-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH v1 3/9] perf tests: Avoid fork in perf_has_symbol test
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
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

perf test -vv Symbols is used to indentify symbols within the perf
binary. Add the -F flag so that the test command doesn't fork the test
before running. This removes a little overhead.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_has_symbol.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/perf_has_symbol.sh b/tools/perf/tests/shell/lib/perf_has_symbol.sh
index 5d59c32ae3e7..561c93b75d77 100644
--- a/tools/perf/tests/shell/lib/perf_has_symbol.sh
+++ b/tools/perf/tests/shell/lib/perf_has_symbol.sh
@@ -3,7 +3,7 @@
 
 perf_has_symbol()
 {
-	if perf test -vv "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
+	if perf test -vv -F "Symbols" 2>&1 | grep "[[:space:]]$1$"; then
 		echo "perf does have symbol '$1'"
 		return 0
 	fi
-- 
2.43.0.rc2.451.g8631bc7472-goog

