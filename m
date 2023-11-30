Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD04C7FE66B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjK3BuG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 20:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjK3BuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:50:02 -0500
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE7C10DB;
        Wed, 29 Nov 2023 17:50:01 -0800 (PST)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6cdde2aeb64so424605b3a.2;
        Wed, 29 Nov 2023 17:50:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701309000; x=1701913800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJ1p2+ISWRL6Js+YhCiI0715c5Y3azFj2GwPodT3Wto=;
        b=SGROZ8nevUWPztdDVQaRtjIg674a+M5vBA+12nwuEtkrPszMXdaLJ9lfnKfUi4EaO1
         it8EnKpfJCuo1t+qZPkLguq6A9kthQat9+JVGqwFNKRTalxyEkJBDERwgaTUpBNvdZiW
         +0uNXxuGy7Sps1jIl4xnRvMKaTp/7oLAmNc1AWz3hj3vfPKG2I3H34B3NdrwGBdXVg/v
         zmzLgRnrURMTqaC2B99UAjQpsXa+bkYYGwglUBqvRFvKU0BF26nPuQwUBeAYsOyTooaq
         gT4A/W7uMIyXI+mkw/zeK6Hx0l0jMkivNdJWDMMoJtbwjDLsgYBj3hjZZ68aTRiMlnNp
         kVvg==
X-Gm-Message-State: AOJu0YzlHhO+MS7zBKV+x5ImS9tuGqBF6ju2OT5IXGZduQcJZwva6H13
        i0hKNtDninIVh3hzajDZdqYxTSjYHINMpXMV/eY=
X-Google-Smtp-Source: AGHT+IE55/JJiB5fPNHVAw2uUqmDUlC6s9lgSp+ZZAVtpRvjYzw3lCKucPLV4W1GCbOVlU92JIzMXh9of2ulZeah7hM=
X-Received: by 2002:a05:6a21:3392:b0:18c:ba47:74ea with SMTP id
 yy18-20020a056a21339200b0018cba4774eamr10946235pzb.31.1701309000571; Wed, 29
 Nov 2023 17:50:00 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-7-irogers@google.com>
In-Reply-To: <20231127220902.1315692-7-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 17:49:49 -0800
Message-ID: <CAM9d7ci20GuVga9XBBOx_GXZsiPEFsqAvAYiz42Tgvc6ygSP9w@mail.gmail.com>
Subject: Re: [PATCH v5 06/50] tools lib api: Add io_dir an allocation free
 readdir alternative
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
>
> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
