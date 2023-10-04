Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3037B8EBC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243819AbjJDV1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243788AbjJDV1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:27:53 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E65DC1;
        Wed,  4 Oct 2023 14:27:49 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c723f1c80fso1811765ad.1;
        Wed, 04 Oct 2023 14:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696454869; x=1697059669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2N0dnBiYnsoWAV6PUavYyqmB/GEUEgsbsYCRyDLs984=;
        b=F9QAgDQ+YBHOQAIkFjb5ke/mI83TkTD1aUcj6CsRvmf5quAJBkDOjumTO22MU86YDJ
         Sw/O1UfC8Q0QdGsGcWLwvEfu3+ybjgNdY6gW6/GiXDETzQo0QSJnSj9cfEbWVy4lX+kc
         ge7rRklhawrPxfPZAbEpjOSszrN3TFA6aIaIRmR3TA0+GURLDzIsM2sxs1AnURC9lGjx
         dcLxpV7xF3/WYRUZvwXEQ+3TRdVJo+mpdL4+MEYVC8FMA2FZ1bsnl49ocquobyv/LBuF
         dBkADiq+NckacweF7YnpMJKvsyRE8mFkJ3T/CHGWWoqNCEyqAkrWukx1a8qkp31DNsEz
         vnSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696454869; x=1697059669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2N0dnBiYnsoWAV6PUavYyqmB/GEUEgsbsYCRyDLs984=;
        b=A9Vq+cYaq8/i91kGzVnFboveapXCD7DoH7aNfBl5/7O5+ECmkxucD4tAYeYP3b5lDh
         +GOAfhIoKYgy93BCbC8hSPtc4BQ6IgtxsGEiieQOfX2nvgMQEUzuHe6c+DPAv2LrzF+m
         L4usw32f3kznHAdjs4MjK45OxufjjT4OtxdGZsr8gFYHtlCLixJZZkeK1HglHJDRwsJC
         GOtsbpfUtXud9IYjOuDvk9Ea7A4DC9qUbe2tG6c+jl3ES/6tLbORzmsKymA/WK0T5GwZ
         /fsr2pN8sqJFRZkrBBZcsrZyLXNFjIwqi2ye5YBtZwu4L0rq4UUiD1fRkTbVc5O8bmxE
         Mryg==
X-Gm-Message-State: AOJu0YzljvK+wm25FWW+xhZPsT/bHEHGks+ZTRzWlMydS3NUf2ni0wuQ
        QWAW8+OTpR1HWPiogIxFdJGE5C/X5Uc=
X-Google-Smtp-Source: AGHT+IF3BtfMNn02t6De0PlA0h5eBp2FTJTlZSbCnNH8hWqc4yP7+Msjw8BStX7tdXdUvQNZ9tmWqA==
X-Received: by 2002:a17:903:2451:b0:1c8:7364:a3ab with SMTP id l17-20020a170903245100b001c87364a3abmr3758446pls.17.1696454869037;
        Wed, 04 Oct 2023 14:27:49 -0700 (PDT)
Received: from google.com ([2620:15c:2c0:5:2489:7e4:8212:9753])
        by smtp.gmail.com with ESMTPSA id l4-20020a17090270c400b001c619fbd5fbsm4023plt.298.2023.10.04.14.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Oct 2023 14:27:48 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
Date:   Wed, 4 Oct 2023 14:27:46 -0700
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/core: Introduce cpuctx->cgrp_ctx_list
Message-ID: <ZR3Y0sqMJICfJuDF@google.com>
References: <20231004040844.797044-1-namhyung@kernel.org>
 <ZR0TtjhGT+Em+/ti@gmail.com>
 <CAM9d7cjvs_CYZH6rGdujSQ8d+MBa616t95dr9oAFs-Nzr_XUOQ@mail.gmail.com>
 <ZR2H+WtRexpOffTw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZR2H+WtRexpOffTw@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 05:42:49PM +0200, Ingo Molnar wrote:
> 
> * Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Maybe I can add an option to perf bench sched to place
> > senders and receivers in different cgroups.
> 
> That would certainly be useful to measure cgroups overhead.

Sent out the change:

  https://lore.kernel.org/all/20231004204741.985422-1-namhyung@kernel.org/

With that, the numbers became stable. :)

Before)

  $ taskset -c 0 ./perf bench sched pipe -l 10000 -G AAA,BBB
  # Running 'sched/pipe' benchmark:
  # Executed 10000 pipe operations between two processes
  
       Total time: 0.901 [sec]
  
        90.128700 usecs/op
            11095 ops/sec


After)

  $ taskset -c 0 ./perf bench sched pipe -l 10000 -G AAA,BBB
  # Running 'sched/pipe' benchmark:
  # Executed 10000 pipe operations between two processes
  
       Total time: 0.065 [sec]
  
         6.560100 usecs/op
           152436 ops/sec


Thanks,
Namhyung

