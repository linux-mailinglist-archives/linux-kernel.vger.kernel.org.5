Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5FA97D5E25
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344594AbjJXW1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344494AbjJXW1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:27:24 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBFF1FDA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:52 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a909b4e079so58021657b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186291; x=1698791091; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XKH/5K4bvubvIr9pw7ZYc/Z4ET3hwQ4HW4s3RX+AQbw=;
        b=ti0BxZOqkKM1O8RMMAUyNmmZ2o8mbX3dMm8Vjr/jsi/SElnTLRGvvf7tm75ekFnwiP
         aTja6tBcUnRlTYdAa/U5yaTaroVUtJWEYClh9UtPf3AR59z5jFFreWEiQzusSQnVGRY3
         S3OLHaoUGOB4ZHSNhCYtNRDALBRJ6eGzSS4AWWWDf0TvXoUOCWwbmgX7ZsTzq0+S74/B
         Ahn6YidRiKy/TTgwUS9p/Cnai3YnI5tyiTz7S6UBux/y8JM1d2ch5KkkZPaseNvy7xx0
         ZeX0cs0pJ6lhq1L9FybhTefYg7fLVyVZG5gYtjm/N/lm4c306xGJDGGw6kvBGfSvO6uU
         Edbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186291; x=1698791091;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XKH/5K4bvubvIr9pw7ZYc/Z4ET3hwQ4HW4s3RX+AQbw=;
        b=GsSvgl859Tocmw8iUcGeeb563eKVSNDEryb6aP1gyEE3nLgkVCKuxjNVmxrzQNp6v6
         L7QAV3cU0GzHRrxOJ2pHPPe8hJiOUcsrUaaqpr5ZcKQLQSjT2TpwWXyKK6h88jsTq+6y
         JQxjObktZFdD8YbzqXiZrkKGYRrFXa/o51elgRpolmsoN7u9GcR6tJ6tkRlr7FRTozoc
         oIy+uCJ+xMU12wVdtAahPm2CxFDx8BevKbbk3k6UTfGhkNOLbB+Ub/WVz+QS+oi1C+Zg
         J4NfCLv0yHX+sZ53ts0cHj0Z5CIzYZsgY2XGo9faBS4K/rT2GE1MaZgRmq2KNuUi6gSw
         Us/g==
X-Gm-Message-State: AOJu0Yy3FvSPJuxcEktqqBxINR3ofjmaZAYPJImrMd3sCHrytW6VsB7D
        6G5xb6JL+xaZ3pU0NkOCh5HflXAIbTZh
X-Google-Smtp-Source: AGHT+IEA4x6jExeY58G0RliZSteprXCMSpH7tFe0ZHu9NiKL3F8kX6ZLzfPBEolCHwOezoixk0P4f6/+giGa
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a0d:eb92:0:b0:59b:ca80:919a with SMTP id
 u140-20020a0deb92000000b0059bca80919amr270216ywe.0.1698186291218; Tue, 24 Oct
 2023 15:24:51 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:20 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-18-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 17/50] tools api fs: Avoid reading whole file for a 1 byte bool
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
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Song Liu <song@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Yanteng Si <siyanteng@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
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

sysfs__read_bool used the first byte from a fully read file into a
string. It then looked at the first byte's value. Avoid doing this and
just read the first byte.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fs/fs.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/lib/api/fs/fs.c b/tools/lib/api/fs/fs.c
index 496812b5f1d2..4c35a689d1fc 100644
--- a/tools/lib/api/fs/fs.c
+++ b/tools/lib/api/fs/fs.c
@@ -447,15 +447,16 @@ int sysfs__read_str(const char *entry, char **buf, size_t *sizep)
 
 int sysfs__read_bool(const char *entry, bool *value)
 {
-	char *buf;
-	size_t size;
-	int ret;
+	struct io io;
+	char bf[16];
+	int ret = 0;
 
-	ret = sysfs__read_str(entry, &buf, &size);
-	if (ret < 0)
-		return ret;
+	io.fd = open(entry, O_RDONLY);
+	if (io.fd < 0)
+		return -errno;
 
-	switch (buf[0]) {
+	io__init(&io, io.fd, bf, sizeof(bf));
+	switch (io__get_char(&io)) {
 	case '1':
 	case 'y':
 	case 'Y':
@@ -469,8 +470,7 @@ int sysfs__read_bool(const char *entry, bool *value)
 	default:
 		ret = -1;
 	}
-
-	free(buf);
+	close(io.fd);
 
 	return ret;
 }
-- 
2.42.0.758.gaed0368e0e-goog

