Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48547FE670
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:59:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjK3B7V convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Nov 2023 20:59:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3B7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:59:20 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579BA1B4;
        Wed, 29 Nov 2023 17:59:27 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d001e4cf7cso4424625ad.2;
        Wed, 29 Nov 2023 17:59:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701309567; x=1701914367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Scw2aCR9gSmd89SGL5dYIOKKFRpiyaWuC/eM4b4hck=;
        b=MxNOYNazkNTyd7cup6xbI4SVNx0K/VXzbeq91nYsoYSNEAZQQQ4DQ/u+Dq4dXLuaTL
         CJ94I2506SifKveg+Ak/HHUmIZaJBSEMN3sXB2V6l6viGnYA0au53X4ife5KB99N0mJT
         /Gw6ZlZOU1UFK4fi9aPITj5+ebhMKzL3fz6/qrwJI4XBvt7jD7fhnZrtPtioxqK9PkLr
         u0zwL7GYUJwZtQ7og8eBhNBj8NWI2KD06PO7viud2ZTEdXZnZdXj1NLbq8GWr5BxYxoG
         bp+dtxUlhtos8ivyKk86x0mnPGs0/jAp6xq0YKgvrG21BOs6v9ROWzFz5/WWdRP+B1gR
         KQDw==
X-Gm-Message-State: AOJu0YxH5kAufCabrXFrf7LVDM84gNYcThF7QJYYnEPMadodPgRa5dmt
        C1U9d1ZIX2JLjTKoZc93JD9AKal0floHDsyK1/4=
X-Google-Smtp-Source: AGHT+IFTqWqKOB2XJ49uuqo+U1YChwhrEKvy8rlyOR7UbtUVKneMenIwsRoA435NfayofWqJFE7KkrIb7VUr76OYDS0=
X-Received: by 2002:a17:90b:1b4b:b0:285:b1b8:e29c with SMTP id
 nv11-20020a17090b1b4b00b00285b1b8e29cmr15014619pjb.12.1701309566671; Wed, 29
 Nov 2023 17:59:26 -0800 (PST)
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-8-irogers@google.com>
In-Reply-To: <20231127220902.1315692-8-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 29 Nov 2023 17:59:15 -0800
Message-ID: <CAM9d7cjYGo0USDXfVSJ-gZXhs1waTyeat4S3eH7S+8L09VQZSw@mail.gmail.com>
Subject: Re: [PATCH v5 07/50] perf maps: Switch modules tree walk to io_dir__readdir
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
> Compared to glibc's opendir/readdir this lowers the max RSS of perf
> record by 1.8MB on a Debian machine.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
