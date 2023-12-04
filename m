Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A678042E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 00:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjLDXxI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 18:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjLDXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 18:53:06 -0500
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79BFBF0;
        Mon,  4 Dec 2023 15:53:13 -0800 (PST)
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2864f8131d0so3017401a91.0;
        Mon, 04 Dec 2023 15:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733993; x=1702338793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/+TtyliQf0EH2X32bYncLIjV/Lziv4VdH2jyUgvKbtA=;
        b=muN0S+46MxlE8oZaQaF2mNns8pFFSx0quCu7r7B3u59oy6x6fw3HDUGyM9RNvB7ts9
         Mjt0eTdPyytU7dG8mfW24g/SkJZTFs0Qdmf2gQoY2+zphdbOUTVjuNae+3rOfTW0OMIY
         oMzU1mWFdGYGQ5KdsVPtKi/AZemotWrQSloQmJo7ml8fbD4+KMOl3ZqEmcKaYHaEH1Oo
         JmwemVqOKUb93cSfxOVCZfYNbsSySHDtYqLilZAREGMIZd2cD3Iz1TqLROjUhhvOmvru
         P5lUPVPt8SRCSnhjtJC+r4gI5Ru1+tKRFQNkHXFCtM/BQBy9uV3PueP76GbrzPYq+ab6
         XtiQ==
X-Gm-Message-State: AOJu0YyFgfVLJzFzeK1yhLfn89ieMtaLoVUfCWjTe0BC5HRUTkyVFeUS
        /DM/AqHUq3Wp3SW13qlUJVf7mbsdULMzRVuwHpA=
X-Google-Smtp-Source: AGHT+IFi0d9fVZLScA4+LDMHAo3ms30akmo3jA/YNGuZSOvjWnJjVAusWjRuqCy0lSNvEzDCdOiMfnb8IPHp3bvubjA=
X-Received: by 2002:a17:90b:4a8c:b0:286:4579:a67c with SMTP id
 lp12-20020a17090b4a8c00b002864579a67cmr346504pjb.15.1701733992858; Mon, 04
 Dec 2023 15:53:12 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-18-irogers@google.com>
In-Reply-To: <20231127220902.1315692-18-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 15:53:01 -0800
Message-ID: <CAM9d7chtB-ULP2jA1KG2MiXL2FcT+ZVeO103LCkW-oTxcafWNQ@mail.gmail.com>
Subject: Re: [PATCH v5 17/50] perf debug: Expose debug file
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

On Mon, Nov 27, 2023 at 2:10 PM Ian Rogers <irogers@google.com> wrote:
>
> Some dumping call backs need to be passed a FILE*. Expose debug file
> via an accessor API for a consistent way to do this. Catch the
> unlikely failure of it not being set. Switch two cases where stderr
> was being used instead of debug_file.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
