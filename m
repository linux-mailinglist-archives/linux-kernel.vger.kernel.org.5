Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95EA7ABDF4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 07:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjIWFgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 01:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjIWFgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 01:36:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA70CE4C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d81503de9c9so4338520276.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 22:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695447355; x=1696052155; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dlidEJ2kQokrDb8kn7wfdV/NkutdZ64KLuYSK3l+lfk=;
        b=0iMrAGF0iOdCZx3w6KXurMJEXCIoPDZGq69PwP02WL5MmrSjrz9RV9ifnvBRQrySBN
         3s1ezMBtlL5uYOGNUgG+F+Slr4TlXeRP6ugGJNUMMU1LPEMFAzgdtz5O/bo0dNUII1Ut
         FYvR9RCoPTwlKblLCNiki8ekoTXLTAAzQ0XRgQJlXXqP2JHDcG+1pCOh0ji+1hxH2LL8
         CYxc61y8sywDXnQWnEpzydu0DmjBihnVeySWZrX0zMrd1p1Fr1hKpLz39lYzFwRaPsDO
         qisb5CIP6cRg6FvxDArH3c1/IeS/OHLu+tegN5uTUYzfXehB5lqtK30tj0FqVTVvWQVn
         KO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695447355; x=1696052155;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlidEJ2kQokrDb8kn7wfdV/NkutdZ64KLuYSK3l+lfk=;
        b=gXwXBjRoYLgthOueRGfQpAwSzTgG84QhErOv/paszTNQVRzr09dbalNGkYVrpeMpTR
         p3YQTcmexegG554Rr/g6AxXbovuBOHVP5yaZvjeCt8+qPiysLrKxy6I17adq3IT793HC
         ntuBVS3sewelAjGCOfFwfQnhqyNqlvHxcf0TS+L5kzlwC1CMI7X1QFKOIPyABOdZ1ec0
         TXYjUJ5NCq/4GLrcT1JI9DwQGCKIX8/iHgC9ClKVWaYcZFraNZa011NKhFMfM6uoRzG4
         p2QTKU8PeyRxXK9b4cR3N359vgTA31r237z6OX5DlRxOluY/C3fndsKogVAeQvgEq63y
         6CmA==
X-Gm-Message-State: AOJu0YzoPVQhsLJaim5IMf2DqM6J0Ige4PKPZz1/lZaQe/o7ANm+/9i5
        05VJbtYckxwuOB0/br+GlKvza22oRAGi
X-Google-Smtp-Source: AGHT+IE5O/1uW/OzbQMR5RN6Xnw5h1anx/RzV4ErZJvmavBS84pg85VIDix3s20OM15IyOeG9FkrtyFxdmAF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a376:2908:1c75:ff78])
 (user=irogers job=sendgmr) by 2002:a05:6902:161c:b0:d0e:e780:81b3 with SMTP
 id bw28-20020a056902161c00b00d0ee78081b3mr12406ybb.2.1695447354781; Fri, 22
 Sep 2023 22:35:54 -0700 (PDT)
Date:   Fri, 22 Sep 2023 22:35:05 -0700
In-Reply-To: <20230923053515.535607-1-irogers@google.com>
Message-Id: <20230923053515.535607-9-irogers@google.com>
Mime-Version: 1.0
References: <20230923053515.535607-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Subject: [PATCH v1 08/18] perf jitdump: Avoid memory leak
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
2.42.0.515.g380fc7ccd1-goog

