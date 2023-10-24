Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF907D5E2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 00:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344478AbjJXW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 18:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344552AbjJXW3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 18:29:49 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D45D212E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a45e7e0f9so5775538276.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698186302; x=1698791102; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4cZX6FOP9Id6EVCdgsB1n601UiMDcX5xk8Ugm2UBQtA=;
        b=fqBwKDGOCT1JJF7Lj2boSkxpXCAnWxWXKUp8yd2xS3Fp0JFaquGdgMoicOfUwGuZDF
         H9K2FonFDUfPK9KHTBVqNSdRI5J9P/CEwWPO7qIhgfiC8e3OwPmla0U1dfiuuqfgq7ZO
         AE7BOhQdTTRK3YWK7TP8n/fq3518AsRJbk0TkhIidO7DNQ6b+BWJ+ZGrSePdW9bP4EB+
         1IrP29DhWSYktDWy5W8GtMGbDl4aKUPCIzHQQf378nGjo4OPuMWjFvZswvWiU5QEclte
         l/NGR7w4DGiSd72L1Hjl3IK5q76J9lMt3RV299d1aTqdLH56OASadjHKANAqmG/BM9Os
         buUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698186302; x=1698791102;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4cZX6FOP9Id6EVCdgsB1n601UiMDcX5xk8Ugm2UBQtA=;
        b=iB/pm3m0bYUOSofhOikSYlU0t0PynQU5Kx2rW3IMq6CM7e1r5ASOVFk21BZ4xSs9QP
         xz6XqqdaY8/r5pFr0hLu5YLLbXj/q68gCSQOZBD3nkiAwbJlocVWmK1blJT9e4xsAdvZ
         eSsSPdcPqO5B6qR4CZjtBS27iSWiAGscYOI+DkKa48fetQGgNY2Z57piLNPfY5VvVpxJ
         H6wiTAqDTfj8wRNNxq3fDRNBeVxQPRvT1sxpzAv/sEZ8Ug6rPV12YTfiUebnTSpga9c8
         jywmhvoZorpUMM/egUCh+DSjm1ypdi85lmYvZb7XkXbbrNZwbFt027XcpaXmGkqxYa1T
         KQOA==
X-Gm-Message-State: AOJu0YzU/6TPswhqO0lHgB81ssaNB0Cqs6yHxTxfazm6nSyX1YDRQzL/
        dcidkSVkTa+/Jn4Ifs922hDDMLWRm9GZ
X-Google-Smtp-Source: AGHT+IHiIg80UVxgn0ef1Q3+qtdWTTMqNK+8ZeTE8lM3zV2hmbAB53JCAibS99Jw+IqLwWJ58AoCFbXoW1Ou
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:93d2:18cc:4d63:45ba])
 (user=irogers job=sendgmr) by 2002:a25:ad49:0:b0:d81:582b:4661 with SMTP id
 l9-20020a25ad49000000b00d81582b4661mr259838ybe.8.1698186302403; Tue, 24 Oct
 2023 15:25:02 -0700 (PDT)
Date:   Tue, 24 Oct 2023 15:23:25 -0700
In-Reply-To: <20231024222353.3024098-1-irogers@google.com>
Message-Id: <20231024222353.3024098-23-irogers@google.com>
Mime-Version: 1.0
References: <20231024222353.3024098-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v3 22/50] perf bpf: Don't synthesize BPF events when disabled
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

If BPF sideband events are disabled on the command line, don't
synthesize BPF events too.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 38fcf3ba5749..830711cae30d 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -386,6 +386,9 @@ int perf_event__synthesize_bpf_events(struct perf_session *session,
 	int err;
 	int fd;
 
+	if (opts->no_bpf_event)
+		return 0;
+
 	event = malloc(sizeof(event->bpf) + KSYM_NAME_LEN + machine->id_hdr_size);
 	if (!event)
 		return -1;
-- 
2.42.0.758.gaed0368e0e-goog

