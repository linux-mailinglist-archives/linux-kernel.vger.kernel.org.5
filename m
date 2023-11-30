Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75717FE838
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344459AbjK3ERW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 23:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjK3ERV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:17:21 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31B4D5C;
        Wed, 29 Nov 2023 20:17:27 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-285abb82925so538847a91.3;
        Wed, 29 Nov 2023 20:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701317847; x=1701922647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u3cq8FTSpv7C38uDQTMDW9F009UvP5iBZjjRKd8DHB8=;
        b=YGJegXT6GiQxmoBH8sS/XPp1axV0x5bPNssOvDFtyGbAATwwUwRtFHIScHpzXgxlO6
         OWWtS5ZT5HW68Y2XxcFeKXniH6/cUSjT2oPUawMlMGBvz2Idlxwa4o3NB7yeD3+lfaCj
         5zcmyP204fCfBJ6pVR1beJ0KD6O6UKw96ss5ASsvUEwkHbrzI0+fAYGtlM8vFyiLYI8k
         Zbujl4g2yCR29E+ZB5Iz467zqZJjje0K1uVi6hJTTONJ34FnjKaX0g5raksUjuR+2fz6
         oauB1gHnjpU+bc9KKtkf59UIKKW3nOOvp3BsgUJJoCTGUfsZypH8XctSOMmDs+Q4VRUt
         wzYw==
X-Gm-Message-State: AOJu0Yx+JVrST4xOjHibgcmLReiEJnlAk6+XHnqLimXVQil180bToKw0
        r3QKLILqEc+DG8GZfAaRzh4TXMrj5nKpfnmbcBw=
X-Google-Smtp-Source: AGHT+IF97srqpkw0k2/pzJL6e6S3Suh0Vq/E2N5CrXt2Wry0qz+a0HYkx1L+vhfzQ1Y60zRH8OwC/EH7AiOnbY78a6s=
X-Received: by 2002:a17:90b:38d2:b0:285:b99a:a92d with SMTP id
 nn18-20020a17090b38d200b00285b99aa92dmr14982377pjb.32.1701317847219; Wed, 29
 Nov 2023 20:17:27 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-11-irogers@google.com>
In-Reply-To: <20231127220902.1315692-11-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 20:17:15 -0800
Message-ID: <CAM9d7cjtpbjv-Em9E7bDOnO=jFYL_HjH+S_2wKkTgrkA8YUL4g@mail.gmail.com>
Subject: Re: [PATCH v5 10/50] perf header: Switch mem topology to io_dir__readdir
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
> Switch memory_node__read and build_mem_topology from opendir/readdir
> to io_dir__readdir, with smaller stack allocations. Reduces peak
> memory consumption of perf record by 10kb.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
