Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D027FE845
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjK3EXF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 23:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjK3EXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:23:03 -0500
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A61210C6;
        Wed, 29 Nov 2023 20:23:10 -0800 (PST)
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6cd8ce7bf7fso567964b3a.0;
        Wed, 29 Nov 2023 20:23:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701318190; x=1701922990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Ru0HoM8F5gEi5lsp4Ae2vkSPRXvivIWKegDRC3hurM=;
        b=kLBfYqeZNz7bD6sjXU00r7eq75oRVmWXsNwYVxd4aEQEgeTMGcNEZTbwpPPTW7RJWg
         kb7qh8s/mEZTZ/9FeownuaQ4U7z51vuQeD6eQoxN6TtgkF6e273eVhcbvpcuQN6y+bFo
         L+7Np577fPitVjQZTRNQmLUkd1ZWeG6F/UcQMNYlxRs0bU0R1BSSAS60GDTixmPYl+8h
         T7JqzvqEp19ctX2LrAOGMg+U2FdNNC9E7W53Qag1A4VWpZJn6CawHQ4A8ob6LUpwuQgv
         1r6e29HNlVaSpbEzHylI12lMob9B2m508+gzrkXM45QeQ33oK5qSCvYYNcV0BmFufAij
         uphw==
X-Gm-Message-State: AOJu0YylKpoYvt+BR51pqqwk2VgomdA0SNWgWiaJj9oolN69Cycvq1Gc
        fFlGXVU6QXr20EGD8i4Poe5BnolvNH2KqFlyBA0=
X-Google-Smtp-Source: AGHT+IE/BzFn89+JfyXo3c/BrBjQxaM+/JBIP+KTvzSqLxPmTlHW4UbUyKFvcCia698ym4wopcRqmg+rKv3xmQI0rZc=
X-Received: by 2002:a05:6a20:54a8:b0:18c:3511:665f with SMTP id
 i40-20020a056a2054a800b0018c3511665fmr19591250pzk.51.1701318189821; Wed, 29
 Nov 2023 20:23:09 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-12-irogers@google.com>
In-Reply-To: <20231127220902.1315692-12-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 20:22:58 -0800
Message-ID: <CAM9d7ciHHWLseUx92hoMWk5+E4+MdDwWELjjJ5uTSGb+yiP1Vw@mail.gmail.com>
Subject: Re: [PATCH v5 11/50] perf events: Remove scandir in thread synthesis
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
> This avoids scanddir reading the directory into memory that's
> allocated and instead allocates on the stack.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
