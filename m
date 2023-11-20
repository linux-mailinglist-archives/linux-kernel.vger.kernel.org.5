Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFFE7F20C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjKTW7e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Nov 2023 17:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKTW7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:59:33 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D8B7A2;
        Mon, 20 Nov 2023 14:59:30 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1e9c9d181d6so3036125fac.0;
        Mon, 20 Nov 2023 14:59:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700521169; x=1701125969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4dZP1CpgWwT6/Z66YkAUxS5DUl+N3kpH1NW1HsPopb8=;
        b=Qt38cGYsWK6Ew6N3ZLimPQFW2CewaJQACJzy/crNcX/3QaB7ULmSdXCSfVW+9QQOmw
         ioiNHmhyMuRswX0Dyd6DOeP9ZE0aSNo466T6+fPppQl0564k7Y4ZWHI1TgONTF3ukhIu
         mUUgdWPvH2BDix4PP289QBQLadk+btViSs/k3E+ta/7TTcjOM/0en7Sbk5xifGvnHeDn
         ThxdKbaWSyPFQ8jnCRrGERN/Tedf8BZbDlhFyWGwvvZdHbRAa/hcH/seLrwZ3XmzkjkX
         f+BcOI+6ws335nPFmB2OGrTlhKnz7aIOH3+OUdLZqivZX96VM4L7AeHOqhQIQllbw3tG
         z9Fg==
X-Gm-Message-State: AOJu0YzF2NhsTrx6RkWf+ceVUIa3XDkUw2OC6aLImA2f+XzjhmdQT3fy
        spGvWQ/H2otjvjB2sr8Q26ZK0uACfwSu8TW5vPYKPEBH
X-Google-Smtp-Source: AGHT+IHZYCmSiVsMg5RbPK+Qqi6FabJEEst4pGayAdFMvCMlMPSl41S5C6Rsr+aONbxNaWOHXLfjcLa0zaKOrFGjPBs=
X-Received: by 2002:a05:6871:22c7:b0:1f9:4afd:e3c9 with SMTP id
 se7-20020a05687122c700b001f94afde3c9mr3570756oab.1.1700521169416; Mon, 20 Nov
 2023 14:59:29 -0800 (PST)
MIME-Version: 1.0
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com> <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com> <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
 <1a1338d0.6b3a.18bd3c09056.Coremail.00107082@163.com> <CAM9d7cgjCKynoTC0L53pEXnCWHF7AZ8Gr2a0xQnes7L24KVNsA@mail.gmail.com>
 <489ecb9e.28cc.18bd650affa.Coremail.00107082@163.com> <CAM9d7cg-tudzG4iPMHs5L-zYMe-WhyzZXN9eOtkoapS1n7t8AA@mail.gmail.com>
 <1da1b7f.564.18be01bd6ce.Coremail.00107082@163.com>
In-Reply-To: <1da1b7f.564.18be01bd6ce.Coremail.00107082@163.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 20 Nov 2023 14:59:18 -0800
Message-ID: <CAM9d7chFQ1L0h0av7ziXU4ja_j1FMRgwd-CHULnOB5YuH9yo2w@mail.gmail.com>
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed for
 aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
To:     David Wang <00107082@163.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Nov 17, 2023 at 5:48 PM David Wang <00107082@163.com> wrote:
>
>
> At 2023-11-18 05:11:02, "Namhyung Kim" <namhyung@kernel.org> wrote:
> >On Wed, Nov 15, 2023 at 8:09 PM David Wang <00107082@163.com> wrote:
> >>
>
> >>
> >>
> >> From the data I collected, I think two problem could be observed for f06cc667f79909e9175460b167c277b7c64d3df0
> >> 1. sample missing.
> >> 2. sample unstable, total sample count drift a lot between tests.
> >
> >Hmm.. so the fio process was running in the background during
> >the profiling, right?  But I'm not sure how you measured the same
> >amount of time.  Probably you need to run this (for 10 seconds):
> >
> >  sudo perf record -a -G mytest -- sleep 10
> >
> >And I guess you don't run the perf command in the target cgroup
> >which is good.
> >
>
> Yes  profiling process was not in the target cgroup.
> I use  fio with `fio --randrepeat=1 --ioengine=libaio --direct=1 --name=test  --bs=4k --iodepth=64 --size=1G --readwrite=randrw  --runtime=600 --numjobs=4 --time_based=1` which would run 600 seconds.
> There would be drifts in the profiling report between runs,  from those small  samples of test data I collected, maybe not enough to make a firm conclusion,  I feel when the commit is reverted, the expectation for total sample count is higher and the standard deviation is smaller.
>
> >And is there any chance if it's improved because of the change?
> >Are the numbers in 6.7 better or worse?
> >
> I have no idea whether the change of expected total sample count a bug or a fix,  but,  the observed result that total sample count drift a lot (bigger standard deviation), I think ,  is a bad thing.

Right.  Can you run perf stat to measure the number of context
switches and cgroup switches, then?

  sudo perf stat -a -e context-switches,cgroup-switches -- sleep 10

Thanks,
Namhyung
