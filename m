Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A697BAF2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjJEXLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjJEXJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:09:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6BAD64
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:09:16 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f8134eb83so23048647b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 16:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696547356; x=1697152156; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GouG30KZVQtjqm6aov/swqA2g+y6OD5o5DKI6J9/hJA=;
        b=ydKxjYHy/+r3MmEk1WKAXHGcGhUSlEALRujuV8fZXUzyYkUXoOTRuBRx+QeQJOckMG
         mTTeVxR4gzbBXAFF/ZCKAdHtEDPYWVjnH47SF6EI4wBrS0AeIjO1edL5VuF7YVShxj1/
         o1fPhwUZCGOwfpzzWfLhaPF/at1IaPpxaW2g16ov4RYNrD1tBOo87BlHk13QaePpej2R
         JNYTaiBKhgIIeq4tLwCB0dE8FUovG8CFyl4kuxpw/90QasEoywvBmBvfL5Vdg1cIAgDv
         E7zx2AVYT9JUnvSUjlvZYFnC93WS2+RFDKr6CFoWAEYXLhZJna5l6JxzzborXQN+12+b
         pGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696547356; x=1697152156;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GouG30KZVQtjqm6aov/swqA2g+y6OD5o5DKI6J9/hJA=;
        b=SQfzp316+3U6p0DTgyCTZo90Dy+Uza/iUt7MptV7DD+ozuT+mS/HacXbTij+PHCL7y
         E+vm/unyrElW3RrdsHFUr7lBcrPaaS7oPgNTwiR7VN1e/lFLcy5HPhgKSea1Cqs888MM
         tscGU7G8IGkpYJvCfZPY/my9k5jk4Xg+GsmNmrPYeo9wFq4T46BFhvL4dHyjdNOEeCiT
         SU0j2U3KUVGsLaedVOx3RyifGBQ97sIUVFYZMTNyJLKvjf54L1vMipbgniigLsESKYSq
         lt/RzD8QXixeDEigUJnTXWBwyBoSbrx9aoyMyuxYq55lsWe9AHJvaVBg5NiNHJObvpLp
         LOfQ==
X-Gm-Message-State: AOJu0YyTv1lXN1fVDVeiBnWD2h34dwZ9kj0o1aYh2T8RwDTaCi5fBamb
        vYQQ/yegDl2LwPrs0hWVYTKpMJPzc8UU
X-Google-Smtp-Source: AGHT+IGONU+OowDDx8a+TbL/FH+ObTrGvfI1GY50R5S+RVIAsaEN1VZNRoea3AVWMrrmFuuADHtm0K7HKpil
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7449:56a1:2b14:305b])
 (user=irogers job=sendgmr) by 2002:a81:430c:0:b0:576:8cb6:62a9 with SMTP id
 q12-20020a81430c000000b005768cb662a9mr115006ywa.6.1696547355929; Thu, 05 Oct
 2023 16:09:15 -0700 (PDT)
Date:   Thu,  5 Oct 2023 16:08:41 -0700
In-Reply-To: <20231005230851.3666908-1-irogers@google.com>
Message-Id: <20231005230851.3666908-9-irogers@google.com>
Mime-Version: 1.0
References: <20231005230851.3666908-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Subject: [PATCH v2 08/18] perf jitdump: Avoid memory leak
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

jit_repipe_unwinding_info is called in a loop by jit_process_dump,
avoid leaking unwinding_data by free-ing before overwriting. Error
detected by clang-tidy.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/jitdump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 6b2b96c16ccd..1f657ef8975f 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -675,6 +675,7 @@ jit_repipe_unwinding_info(struct jit_buf_desc *jd, union jr_entry *jr)
 	jd->eh_frame_hdr_size = jr->unwinding.eh_frame_hdr_size;
 	jd->unwinding_size = jr->unwinding.unwinding_size;
 	jd->unwinding_mapped_size = jr->unwinding.mapped_size;
+	free(jd->unwinding_data);
 	jd->unwinding_data = unwinding_data;
 
 	return 0;
-- 
2.42.0.609.gbb76f46606-goog

