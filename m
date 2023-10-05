Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B797BAF2C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjJEXLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJEXJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:13 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854101B8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:09 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a213b4d0efso21308197b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547349; x=1697152149; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i2XqQMJ0GkpZoKYBOeb+AHUkFWOwFAfTNDekNOfqFv8=;
        b=dhDVCBX40y5B0cotpbQmfRlDiY983Jxw+B+ksE2VxDNGQrDNqQHwCSamlheGdTV0i4
         t0s+PAmnL/e+aU4zdEJLoS0St61Qc8CCAojtb7DPsl5Uk+AqtWsO26z8S1nPinspNIF2
         p4LqZDQcb5Cw7aEQnMnKgI/PODEyW1zxCZjVP355JrJF2W/aFOnTczx1uuK8jjtDTb/J
         u6BQF/8SA+GNQ0e8o+dTAk43PYDL2iBV84Llj1Dxd8vwxqWMmjWjA8jJrRbv3A6QK+3z
         b5uKJFJ4x9cHMYOyH//EsRPdrJ3WiYcBV/NeNOAC+9q5nAs1GNc8feFXgCMUOL3ICuqz
         cGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547349; x=1697152149;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i2XqQMJ0GkpZoKYBOeb+AHUkFWOwFAfTNDekNOfqFv8=;
        b=TP8hLXihiowg0yR4GtavfACnh4Ke+IMX9dn5NiiIlU8ArtgvQFk7inEOpQV5lV8lJe
         V/dBMC9UtEtqGCY/fK5ZR9PY4jXFNIcnsuJMaow7jdy8a9UhGGvSoaIbY7yFdVILjAsB
         L/KU3Q/za37b0wJaCPQhP14Ula9xdJAZDRbItm21f00NcmkszLnKj53I/web51QMkH0x
         wvMg4S+eZ9QE1xSSI00YxSdQBqAd8PtoLCKJ8bnQZootiwrQC9tPtNU9qjPMGuHboDVh
         KkLIKrrq+vjoB1EFuprwKNW2CmXeMazTbU5oSlGmR+dG2lWNLz34T7izWG/SJ/wnL2fg
         p3BQ==
X-Gm-Message-State: AOJu0YzDWEjo1SvMfvXi4XmWF1rJjtGa02s3qFY6omY3Dw/baY7j4uh3
        JtLGMjqIaXAQajX9QI1iiViZ+lHdglPt
X-Google-Smtp-Source: AGHT+IGfGlEcR5cafu/s4l0RQy8FE4MK3zRFkQ6Zp8BoRNaDEtxn5kvn9B3Xn4doaEJk2RCpa1Y7G/TCwC7Y
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:a9c4:0:b0:59b:eace:d467 with SMTP id
 g187-20020a81a9c4000000b0059beaced467mr116956ywh.3.1696547348754; Thu, 05 Oct
 2023 16:09:08 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:38 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-6-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 05/18] perf bench uprobe: Fix potential use of memory after free
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
        James Clark <james.clark@arm.com>, llvm@lists.linux.dev,
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

Found by clang-tidy:
```
bench/uprobe.c:98:3: warning: Use of memory after it is freed [clang-analyzer-unix.Malloc]
                bench_uprobe_bpf__destroy(skel);
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/bench/uprobe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/bench/uprobe.c b/tools/perf/bench/uprobe.c
index 914c0817fe8a..5c71fdc419dd 100644
--- a/tools/perf/bench/uprobe.c
+++ b/tools/perf/bench/uprobe.c
@@ -89,6 +89,7 @@ static int bench_uprobe__setup_bpf_skel(enum bench_uprobe bench)
 	return err;
 cleanup:
 	bench_uprobe_bpf__destroy(skel);
+	skel = NULL;
 	return err;
 }
 
-- 
2.42.0.609.gbb76f46606-goog

