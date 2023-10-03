Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C867B5FAE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 06:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjJCEIV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 00:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjJCEIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 00:08:19 -0400
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EBABB;
        Mon,  2 Oct 2023 21:08:17 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7ab8696d047so227128241.1;
        Mon, 02 Oct 2023 21:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306096; x=1696910896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sVF5dM/rD7LrEJ/cCejTv0aLhKjQq20c8kLgg4F7Lyc=;
        b=ZEDcwIn3bsATz4z6y65NQvBNdmzvX8LWfrP6NiCuxyDbVfcJsbU6ONntB0MmGi2nmJ
         YjYxUR5ziiqyDLNSSeX7Yc0H3SLF/CyB7l876Exho8UKHZWCLt9mB3emKHNzrB8PH8KO
         mfcBiaV5EeS3tYNuc/fa4u9gfjf5RHj/Gm5/lyufhN467MJJr3OVUTtJckTVZYv9Q2Kz
         P68WW8Lgn+2v8APrDirixNAheVAU0u2Zst5Ap/m1SaqY3WMzAb0h/28UrallAfNE93KB
         E/iaeF5je8Qc5GDrzoZdZmigapbd2sLuqDkMgA5poXcd95aJqcN7AwsK4TOAGfCVbzS8
         3cPQ==
X-Gm-Message-State: AOJu0YwswbECQeDRXJ1ZhF4IvN3+jpJX2FwerLpuZqp/Gar/JiJINQUz
        QyEejs+ii1hSUBSzKncYRHSjy+TBglZeTCCrTvMWeNrF
X-Google-Smtp-Source: AGHT+IF3E/i3i9D9ywq9im0ZC5Eg+bu/jlvkAsmHW0QM7gZBVjjrCtSpzOB7r5P7ik2CvXhXSW94GKqR3DqwwvZ+BGY=
X-Received: by 2002:a1f:de43:0:b0:49a:7a5b:dab2 with SMTP id
 v64-20020a1fde43000000b0049a7a5bdab2mr10173027vkg.16.1696306096177; Mon, 02
 Oct 2023 21:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230928071605.17624-1-adrian.hunter@intel.com> <CAM9d7ch5yZZU_bY=d+5wkvQDJKCuctabBu3AMuyp4UYRO0upYA@mail.gmail.com>
In-Reply-To: <CAM9d7ch5yZZU_bY=d+5wkvQDJKCuctabBu3AMuyp4UYRO0upYA@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 2 Oct 2023 21:08:04 -0700
Message-ID: <CAM9d7cix+H0dddFJ-cy-+pf_SXy4prrGywDc6rj9-iCxpOm_gw@mail.gmail.com>
Subject: Re: [PATCH] perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_code()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:40 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Adrian,
>
> On Thu, Sep 28, 2023 at 12:16 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > Stop calling addr_location__exit() when addr_location__init() was not
> > called.
> >
> > Fixes: 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied this and the test code to perf-tools, thanks!
