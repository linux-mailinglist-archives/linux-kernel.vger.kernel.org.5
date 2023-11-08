Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9A7E5EAE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjKHTbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:31:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjKHTbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:31:41 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902621FFC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:31:39 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cc329ce84cso3965ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 11:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699471899; x=1700076699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mtrwa9hSdXFnIf5b0zx44D7ENUS147rdOzljUhuQ8RA=;
        b=ZIx31Ga1yALA4HS5eQFrBqaVnzRnoaPzDqBGuLJ7AP8KETfLrpBTP7dBKW2YG2UxDO
         QwA/OwZKAtGKS9HakhAu99SjWIQ691RouteLWDBa/uE7V3cE00cpkNm+Z+R689WhBJ1e
         cvCCHh3+HiZpVctUtxfh6GhlogZpML946lT2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699471899; x=1700076699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtrwa9hSdXFnIf5b0zx44D7ENUS147rdOzljUhuQ8RA=;
        b=PdwFNAAU7AS8kty/Yzy7BhEgwGzwd5n2zca1CqPeW7YONEog+Uv2095gY8wZrIIrAw
         c0N7C5oIpSWhwuDr5yG03dIVetX76S50wz/FWtslrBkIWAmcASAUbtT4ebxY4bQFrP7u
         LgzUa8BCg9QzRQJg011kBeBmpG2VNL2BVg0kkY0HCG9Wbcam8NNjY1GxEOKyidO9HqWb
         X2rEDwz/M9+iZHwGrdDH02jmCt0reKEnpdYs2s8eXSZdhj+wwlZ8H8PcHi2aYPI/gMgc
         LxckFeYQNVkwjvu8SAJ3igWoyetCxzGz8SOqrvp6vRsvYFg9XSiVVCL28iJ1RhZnM0ac
         YqLw==
X-Gm-Message-State: AOJu0Yx6TOxLCABl9tVEFvLd0aga9gnHAQcfNKwgaVc4Hr7KnBkNEzWC
        QAtmQLyuoPgqMSfcbqQUqPpjXA==
X-Google-Smtp-Source: AGHT+IEVKfGQFeW4SR4Q6rpbh+y6ExnHCJACd1kkHnlHnKUApaRxUeZJeTTiNd/t9L2b2ZH0RdK89g==
X-Received: by 2002:a17:902:9b90:b0:1c3:3b5c:1fbf with SMTP id y16-20020a1709029b9000b001c33b5c1fbfmr2976900plp.10.1699471899041;
        Wed, 08 Nov 2023 11:31:39 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902b61500b001c9c97beb9csm2085456pls.71.2023.11.08.11.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 11:31:38 -0800 (PST)
Date:   Wed, 8 Nov 2023 11:31:37 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mateusz Guzik <mjguzik@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kees Cook <kees@kernel.org>, Josh Triplett <josh@joshtriplett.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202311081129.9E1EC8D34@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook>
 <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
 <202311071445.53E5D72C@keescook>
 <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
 <A7FFA44F-F7DD-477F-83A6-44AF71D6775E@kernel.org>
 <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHESNDTAAOGB3riYjU3tgHTXVLRdB7tknfVBem38yqkJEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 01:03:33AM +0100, Mateusz Guzik wrote:
> On 11/8/23, Kees Cook <kees@kernel.org> wrote:
> >
> >
> > On November 7, 2023 3:08:47 PM PST, Mateusz Guzik <mjguzik@gmail.com>
> > wrote:
> >>On 11/7/23, Kees Cook <keescook@chromium.org> wrote:
> >>> On Tue, Nov 07, 2023 at 10:23:16PM +0100, Mateusz Guzik wrote:
> >>>> If the patch which dodges second lookup still somehow appears slower a
> >>>> flamegraph or other profile would be nice. I can volunteer to take a
> >>>> look at what's going on provided above measurements will be done and
> >>>> show funkyness.
> >>>
> >>> When I looked at this last, it seemed like all the work done in
> >>> do_filp_open() (my patch, which moved the lookup earlier) was heavier
> >>> than the duplicate filename_lookup().
> >>>
> >>> What I didn't test was moving the sched_exec() before the mm creation,
> >>> which Peter confirmed shouldn't be a problem, but I think that might be
> >>> only a tiny benefit, if at all.
> >>>
> >>> If you can do some comparisons, that would be great; it always takes me
> >>> a fair bit of time to get set up for flame graph generation, etc. :)
> >>>
> >>
> >>So I spawned *one* process executing one statocally linked binary in a
> >>loop, test case from http://apollo.backplane.com/DFlyMisc/doexec.c .
> >>
> >>The profile is definitely not what I expected:
> >>   5.85%  [kernel]           [k] asm_exc_page_fault
> >>   5.84%  [kernel]           [k] __pv_queued_spin_lock_slowpath
> >>[snip]
> >>
> >>I'm going to have to recompile with lock profiling, meanwhile
> >>according to bpftrace
> >>(bpftrace -e 'kprobe:__pv_queued_spin_lock_slowpath { @[kstack()] =
> >> count(); }')
> >>top hits would be:
> >>
> >>@[
> >>    __pv_queued_spin_lock_slowpath+1
> >>    _raw_spin_lock+37
> >>    __schedule+192
> >>    schedule_idle+38
> >>    do_idle+366
> >>    cpu_startup_entry+38
> >>    start_secondary+282
> >>    secondary_startup_64_no_verify+381
> >>]: 181
> >>@[
> >>    __pv_queued_spin_lock_slowpath+1
> >>    _raw_spin_lock_irq+43
> >>    wait_for_completion+141
> >>    stop_one_cpu+127
> >>    sched_exec+165
> >
> > There's the suspicious sched_exec() I was talking about! :)
> >
> > I think it needs to be moved, and perhaps _later_ instead of earlier?
> > Hmm...
> >
> 
> I'm getting around 3.4k execs/s. However, if I "taskset -c 3
> ./static-doexec 1" the number goes up to about 9.5k and lock
> contention disappears from the profile. So off hand looks like the
> task is walking around the box when it perhaps could be avoided -- it
> is idle apart from running the test. Again this is going to require a
> serious look instead of ad hoc pokes.

Peter, is this something you can speak to? It seems like execve() forces
a change in running CPU. Is this really something we want to be doing?
Or is there some better way to keep it on the same CPU unless there is
contention?

-Kees

-- 
Kees Cook
