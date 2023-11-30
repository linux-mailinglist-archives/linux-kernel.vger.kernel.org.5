Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346E47FE61A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbjK3Bgh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 20:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3Bgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:36:35 -0500
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0FA1A3;
        Wed, 29 Nov 2023 17:36:42 -0800 (PST)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2855b566683so1308749a91.1;
        Wed, 29 Nov 2023 17:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701308202; x=1701913002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8Oujw9Wuea/rLA/FjXFwS/JqnACIhUyo3AE9Vp7Fp0=;
        b=quep10pAqKXRwAtzIGV8/Y4BZrXi3EnhrJuw4AXSqOYkasFoHH8ajyxBZE/82tGnoq
         PfOFLXBJl9dtJnMInVqpvfc1sLosEysIWBSX1/Ibw+3oZYTbwNvAt773DE6NA2XkYJkr
         aHU6inj9rW+GswttrtqGQk4/5oiSmFzMLAA9xiJhnMk23C9Ka0WNGlPqHsto1w5jqsLs
         Jrz+RNcN1DDTRsHATkRZLjBeJ1B0tjkG1AVXUFSL+H6T+ijdLfw+a7OyIeJcP6ym1wKb
         fyPkC2NnMuWS7PT5sbWqIuRuCGOsNtlnCHuXxQmSkmnKUYf+V13/1SA9omT80+7ixoXT
         AaxQ==
X-Gm-Message-State: AOJu0Yz7BDrsbP+5Dx8sQa/FqrIfhRgCBqN0IdtxZOadFUR8FgSYwjUi
        mv9oyOgqBRRUwGMavjDdw42ZjaTyQkmW+rFBVoI=
X-Google-Smtp-Source: AGHT+IGmBilxx7ubLW+U28vwEfq8129RPjWdJyK6scOuINLWU3ZnciHvQAwFWNhhA4mrVdDgkXToefdQuzINYdOQkWY=
X-Received: by 2002:a17:90b:1d09:b0:281:d84:a97e with SMTP id
 on9-20020a17090b1d0900b002810d84a97emr29201239pjb.2.1701308201546; Wed, 29
 Nov 2023 17:36:41 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-5-irogers@google.com>
In-Reply-To: <20231127220902.1315692-5-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 17:36:30 -0800
Message-ID: <CAM9d7cgMwBX2F5gVNB0OqNunbGLXniXqgcAve29P7f5C-i+BhQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/50] tools api fs: Switch filename__read_str to use io.h
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
>
> filename__read_str has its own string reading code that allocates
> memory before reading into it. The memory allocated is sized at BUFSIZ
> that is 8kb. Most strings are short and so most of this 8kb is
> wasted.
>
> Refactor io__getline, as io__getdelim, so that the newline character
> can be configurable and ignored in the case of filename__read_str.
>
> Code like build_caches_for_cpu in perf's header.c will read many
> strings and hold them in a data structure, in this case multiple
> strings per cache level per CPU. Using io.h's io__getline avoids the
> wasted memory as strings are temporarily read into a buffer on the
> stack before being copied to a buffer that grows 128 bytes at a time
> and is never sized larger than the string.
>
> For a 16 hyperthread system the memory consumption of "perf record
> true" is reduced by 180kb, primarily through saving memory when
> reading the cache information.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
