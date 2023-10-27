Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA847DA135
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 21:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjJ0TSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 15:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0TSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 15:18:04 -0400
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4A918A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 12:17:17 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7789577b53fso173300385a.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 12:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698434237; x=1699039037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJT7fPV2gPr266dgHb6wRFTeUO0bh/e9lQXSKG8KwCw=;
        b=LFlAfun5UgJAojMfE0PU+biHuMKM3aIpckGDKT0H2QFhePwZTtzf1qHCUZwzgOeagC
         np9zN3x1v1X/4lOBVjXnuhU5nSkDRTMOb/E1IADH1BFEfdWt+kCEBeLnOLW+wiIcCjlf
         zMH6OTMSmFgPgSWA+XXUt/mQ1gW6nOcHhuxyTihwRsWnEN8wj6viL0bAowgsuQqv1qNH
         upk8OmtQj5BSRiJiqbQ3LLCbYPGx0x8Y4ao6XyiZRO4wTcyHlx/BN10IZ6beVqY7Bq7l
         yJ2DIg4Ms38yCqPV6vDbXzVtpQy2xoKQee5xXtilFnvqDSPLTohSj5BBYf3KlWQo8jYH
         1PlA==
X-Gm-Message-State: AOJu0YylynKkAH6Zpfqc513Bq1FJQAZxZd3hQA+T6dEnPIcyFflKWXZx
        ixJ9dtx6rvNRzNcAowGB626q
X-Google-Smtp-Source: AGHT+IGLmN8n1FQeybzaJrhM20MOqQA9u1RvtdEKFrTtEQePlgVuP5hPnD3wvPLymT3W9A53TRS8SA==
X-Received: by 2002:a05:620a:4514:b0:775:7d81:f8bb with SMTP id t20-20020a05620a451400b007757d81f8bbmr4690750qkp.11.1698434237078;
        Fri, 27 Oct 2023 12:17:17 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id l21-20020a05620a28d500b007743446efd1sm806006qkp.35.2023.10.27.12.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 12:17:16 -0700 (PDT)
Date:   Fri, 27 Oct 2023 15:17:15 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Christian Loehle <christian.loehle@arm.com>
Cc:     dm-devel@lists.linux.dev, agk@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: dm: delay: use kthread instead of timers and wq
Message-ID: <ZTwMu5uHcKnShoKU@redhat.com>
References: <7aab63e2-b133-49ec-ab8b-36ebec685de2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aab63e2-b133-49ec-ab8b-36ebec685de2@arm.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20 2023 at  7:46P -0400,
Christian Loehle <christian.loehle@arm.com> wrote:

> The current design of timers and wq to realize the delays
> is insufficient especially for delays below ~50ms.
> The design is enhanced with a kthread to flush the expired delays,
> trading some CPU time (in some cases) for better delay accuracy and
> delays closer to what the user requested for smaller delays.
> The new design is chosen as long as all the delays are below 50ms.
> 
> Since bios can't be completed in interrupt context using a kthread
> is probably the most reasonable way to approach this.
> 
> Testing with
> echo "0 2097152 zero" | dmsetup create dm-zeros
> for i in $(seq 0 20);
> do
>   echo "0 2097152 delay /dev/mapper/dm-zeros 0 $i" | dmsetup create dm-delay-${i}ms;
> done
> 
> Some performance numbers for comparison
> beaglebone black (single core) CONFIG_HZ_1000=y:
> fio --name=1msread --rw=randread --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-1ms
> Theoretical maximum: 1000 IOPS
> Previous: 250 IOPS
> Kthread: 500 IOPS
> fio --name=10msread --rw=randread --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms
> Theoretical maximum: 100 IOPS
> Previous: 45 IOPS
> Kthread: 50 IOPS
> fio --name=1mswrite --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-1ms
> Theoretical maximum: 1000 IOPS
> Previous: 498 IOPS
> Kthread: 1000 IOPS
> fio --name=10mswrite --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms
> Theoretical maximum: 100 IOPS
> Previous: 90 IOPS
> Kthread: 100 IOPS
> fio --name=10mswriteasync --rw=randwrite --direct=1 --bs=4k --runtime=60 --time_based --filename=/dev/mapper/dm-delay-10ms --numjobs=32 --iodepth=64 --ioengine=libaio --group_reporting
> Previous: 13.3k IOPS
> Kthread: 13.3k IOPS
> (This one is just to prove the new design isn't impacting throughput,
> not really about delays)
> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
> v2:
> 	- Keep the timer wq and delay design for longer delays
> 	- Address the rest of Mike's minor comments


Hi,

I've picked this up.  But I fixed various issues along the way.

Please see the staged commit here:
https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.7&id=c1fce71d29b2a48fd6788f9555561fda0f0c1863

Issues ranged from whitespace, to removing needless forward
declaration, to removing stray changes (restoring 'continue;' in
flush_delayed_bios), actually using a bool for bool params, fixed
missing mutex_init, and use max() rather than opencode comparisons in
the ctr.  I might be forgetting some other code change. ;)

I also tweaked the commit header for whitespace (line wrapping, etc).

Thanks,
Mike
