Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C453A7C656E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 08:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377467AbjJLGYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377428AbjJLGYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 02:24:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC34C9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:09 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab7a8b736so808961276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 23:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697091848; x=1697696648; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e5eVmSUwSJxksG4NuITaTSZqNGvqcD7jLZAKoPJCuWU=;
        b=y5oLkfN06TgWXS3T+DIqI41033RTHqlG50bSK7V7VQbAhwhGGcSjc4qAwqKygliEMw
         Dzh/xEbTTErZN4BVS3Pbn0pku5E1Apc/bqPd6Ijh7VRRFgk3TbWeg64L30Wc1WorAbDI
         YG3JeTkPUZUCwugaaFoloZaSE8CctvzKlONXqM6TlgyEdq0KhiT+M4srskMsnAlW5Lt8
         /KhwYKQQyxkmrKvpGXmEqd1ntx5trZWSpnYKse13WRT+Ojt93O7egD7ZW47xYOAYtqCv
         28251R+c3r7BXlB9v+5AgoBC9rpcEwCudlwhbgLlNKT8+UqnTLAEyDDeYiOAAEBZuw0Y
         03CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697091848; x=1697696648;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5eVmSUwSJxksG4NuITaTSZqNGvqcD7jLZAKoPJCuWU=;
        b=d3uPvUkYcR7EfabbNWR4ViVz+sJDd0REGb8rvAtFE8cadvKZIEVg+uH9vEWeSA5PNn
         Nri8T+5Q5JKt2KeE1+dHa2InoNTTxnJyaGTHJ7bIyQIWthruZSHmwaQgeIjO//MgEfY3
         yKeeIFAQQmbwYunJ1B6qO2VoKaCW9sbW8JiuFp5yniO4V0z730s7JnRYjLOfQFvgi/vV
         GqlyOGSa8RJJ6cdGcrTa5a5HkmpgjcNmzTJW9eYslvKfhrbI4fPpPmXQeytVhUDNmQwm
         NU1pqBLh+hOUmIVxeDTyZZje2rfcJoTfHOG2mrcfKDQcZrYmvMwk6ZCXIN+VnLZlMhmw
         IsBg==
X-Gm-Message-State: AOJu0YzkaMTy5O+PGCQRVad/iTK8QVpuzEIUtqE/R9jw5yEzvfeSpoGo
        3XO2i+QHQ1FqLgPeciqRRBNnmcLYGj53
X-Google-Smtp-Source: AGHT+IFmqFq4/wm5EgdUd3x0JEaVUvH+YjHVcBVN3IPYbimtzwGlyFiTzZuU2AziiY+gjwegOfUSdr2DJPxE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7be5:14d2:880b:c5c9])
 (user=irogers job=sendgmr) by 2002:a25:bccb:0:b0:d9a:61ca:7c7a with SMTP id
 l11-20020a25bccb000000b00d9a61ca7c7amr138294ybm.11.1697091848675; Wed, 11 Oct
 2023 23:24:08 -0700 (PDT)
Date:   Wed, 11 Oct 2023 23:23:48 -0700
In-Reply-To: <20231012062359.1616786-1-irogers@google.com>
Message-Id: <20231012062359.1616786-3-irogers@google.com>
Mime-Version: 1.0
References: <20231012062359.1616786-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 02/13] libperf rc_check: Make implicit enabling work for GCC
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
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Artem Savkov <asavkov@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
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

Make the implicit REFCOUNT_CHECKING robust to when building with GCC.

Fixes: 9be6ab181b7b ("libperf rc_check: Enable implicitly with sanitizers")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/rc_check.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/include/internal/rc_check.h b/tools/lib/perf/include/internal/rc_check.h
index d5d771ccdc7b..e88a6d8a0b0f 100644
--- a/tools/lib/perf/include/internal/rc_check.h
+++ b/tools/lib/perf/include/internal/rc_check.h
@@ -9,8 +9,12 @@
  * Enable reference count checking implicitly with leak checking, which is
  * integrated into address sanitizer.
  */
-#if defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
+#if defined(__SANITIZE_ADDRESS__) || defined(LEAK_SANITIZER) || defined(ADDRESS_SANITIZER)
 #define REFCNT_CHECKING 1
+#elif defined(__has_feature)
+#if __has_feature(address_sanitizer) || __has_feature(leak_sanitizer)
+#define REFCNT_CHECKING 1
+#endif
 #endif
 
 /*
-- 
2.42.0.609.gbb76f46606-goog

