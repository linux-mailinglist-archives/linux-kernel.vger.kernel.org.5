Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4CA7DF95A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377170AbjKBR7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345507AbjKBR6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:58:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797EA10DE
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:58:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da3dd6a72a7so1444654276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698947903; x=1699552703; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGESJj7au1uXJ8rgsZ7Z2SvkHL285HgbRjBBhgb6nnY=;
        b=J+CD5JInXbg2x05frrOkZwqLOYhF9KK9Jx8eWgEGvnJFgtUVK576cYF9cAuNQeNkDK
         jlCcooaAlZR4Jlz0PMe0J47QZ8FJq7nSxBtFUEEm+nHuxevxENK+d/J0l6pNHT9gt5Zo
         kXU3P4tDZYpWHjanA8SB99TGGF8bPbTSbBIr9584NcmCOKFB3SXoiH+J2ZXhTK1h7naa
         okFH+pmsYYjb32sviv87h7DARwy98ZenGMgl4NJKYhcIe6sLEe+rd9wgZxVZdHGq5hgI
         PBBkZ0o0t05pkERktEF+r9WYj77FUh3RZqVlo9gTs2cO00+ERKCBr/dhTqGrBLnykIJ1
         xiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698947903; x=1699552703;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGESJj7au1uXJ8rgsZ7Z2SvkHL285HgbRjBBhgb6nnY=;
        b=fCWSqWObfbH/WlS/LSHTy0biKwClQ8ycRX+Vle9XLkjlLrjJg9ngd0Yk4BuSNmh3YC
         mu3nFVogAD1SzUGnZtl6t5RLH/yTt8uqyT/aygj2pnptXNMHc7rTKamhM3MAI+I28MFE
         JcGe6t3S4k5QbpWfQpfLPLC2Th6Xaels7S5hOG8SBbZlIRkWMOVuBJDVRCblmHAYunm4
         BsufB/k0X98AmQd+pfAw3J/OJ1ATN7Hm2KxWWJzToOVQouY5Ong1Uv8DQhCyEScxz380
         zLjb9XWJM9Pvpuf5RRCBnlJufJrVQxMcrOtOSbQToU0ORAnhbH0i+hQTYHOyrXzZXNkf
         Q8ag==
X-Gm-Message-State: AOJu0YzIWkPqgWDdbHhJ5DUUPhPd46kupapHkoA/HwMGpk2IDDsEMlnJ
        06vRJBVBUQc/ZMQilG7895qgvkz0z7Q7
X-Google-Smtp-Source: AGHT+IErpT9V6TA5oY3EazOusVnIGLo3lQy4fUOSYc8uKrTiuq6W4VlJP3quotDnMeMnd+q3wawGdCOB1Oyg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:bb34:df9c:836c:afca])
 (user=irogers job=sendgmr) by 2002:a25:2083:0:b0:da0:c584:def4 with SMTP id
 g125-20020a252083000000b00da0c584def4mr359850ybg.1.1698947903463; Thu, 02 Nov
 2023 10:58:23 -0700 (PDT)
Date:   Thu,  2 Nov 2023 10:56:54 -0700
In-Reply-To: <20231102175735.2272696-1-irogers@google.com>
Message-Id: <20231102175735.2272696-13-irogers@google.com>
Mime-Version: 1.0
References: <20231102175735.2272696-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Subject: [PATCH v4 12/53] perf bpf: Don't synthesize BPF events when disabled
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
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
2.42.0.869.gea05f2083d-goog

