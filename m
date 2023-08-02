Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6A476D47E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbjHBRAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjHBRAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:00:47 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F71C1727
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:00:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686b91c2744so5762b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690995644; x=1691600444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5+B58DisRU++lxI3dkapfCb6I7OQQyQFFvkAi8ErqZg=;
        b=J8neAeGkf2CoJWJpyIKd5TnxQVyY7xmetW4rQZzJHaLb7TgOo4EGM4DuN9OX6MLu07
         8Ef1lP6aKJcjqZ4xUsltwBvf4s+s1GuiOaeOj0TKs8GyZpZZVi7rKXJqfw/rwL9JoZSp
         D4P7qcYHIvFcAq+ntANaLHg9d2QjMUpeozZaHeP9vpzB63QP1w4N1WOj/45nKiH+OS3q
         8jpixFtvzsrqBQGW3/3RsLiJ/27o/YTLpdNUjGArcIIrILNTrVAbsfjHPiY6vUDy+M0H
         G0YxXiSL5lCpfj5o5YJfHD2veUBCJpASZxTpnr+u6hjt6apxNotBacoT9IkyLnqVa0oy
         xw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690995644; x=1691600444;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5+B58DisRU++lxI3dkapfCb6I7OQQyQFFvkAi8ErqZg=;
        b=QfipOcdXgs4i/QWwC0oYB+iRvZYPB1b23zFYh9IBNDo40XbnNIjkBoC5gsrCKXMQ5Y
         NR4qkUUyBZjUKDkHxslhuDDRU8ORC1TARFTcGXk+Y46hoX2r8hxkWFFtlPqbmRe2x3Dw
         fyI0eFFUrL1aKVMylCegPGhCw/4zJc57AbB3UddH7fL+nohxMb/d0IxCIVx+boontcJD
         QxJ0wl307GKwNsO0rEWHtMkFW0ELmW1LIkC7gZR9yKfsfycjwopiDgdoQMJ8obvzcQVu
         bkm51pNjnkILptYGHdw0pd+3uFOTCpBmwtS4bBBVh690Q93rGx7GnFcOZGU9ZlvfHiBQ
         kfUA==
X-Gm-Message-State: ABy/qLYNHgfPWU/+5xjEK7GSaRMcnulATCqY5v2x2BlCJxf39lG5kWiM
        lkvxfJyZIwvBHKcllAVBdsE83A==
X-Google-Smtp-Source: APBJJlFNw2OnXf+1E1CcAO22Ccs1bxf6zgnYi8l0Tv5CSNRNipIMtTq0pXKBfXQ8uIoCkG0uniyksw==
X-Received: by 2002:a05:6a20:8f07:b0:13e:c5a3:97f with SMTP id b7-20020a056a208f0700b0013ec5a3097fmr4160743pzk.42.1690995644422;
        Wed, 02 Aug 2023 10:00:44 -0700 (PDT)
Received: from leoy-huanghe.lan ([156.59.39.102])
        by smtp.gmail.com with ESMTPSA id p12-20020aa7860c000000b006873770cbc6sm5897110pfn.50.2023.08.02.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 10:00:43 -0700 (PDT)
Date:   Thu, 3 Aug 2023 01:00:38 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1] perf doc: Document ring buffer mechanism
Message-ID: <20230802170038.GA1306442@leoy-huanghe.lan>
References: <20230715035343.46737-1-leo.yan@linaro.org>
 <CAP-5=fVmBVA5XGac8BZks6UnjGaMv8bx_PhC6_YrWC2TGjw-Fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVmBVA5XGac8BZks6UnjGaMv8bx_PhC6_YrWC2TGjw-Fg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Mon, Jul 17, 2023 at 02:27:11PM -0700, Ian Rogers wrote:

[...]

> > Thanks Ian's suggestion for upstreaming this documentation into Linux
> > source code tree at the Jan of this year, also thanks my son Rowan for
> > correcting me some grammer errors in this summer holiday.  Finally I
> > heavily refactored this documentation and I think it's ready for
> > reviewing.
> 
> This is awesome, thanks Leo for taking the time to do this! I've done
> some readability nits

Thanks a lot for review, Ian.

I agreed with most of your comments.  Blow I just keep the comments for
further discussion or give supplements, otherwise, I remove the rest
comments and will reflect them in my new patch.

[...]

> > +Perf uses the same way to manage its ring buffer.  In implementation
> > +there have two actors: a page contains a control structure and ring
> > +buffer; the page containing the control structure is named as "user
> > +page", the user page and the ring buffer are mapped into user space
> > +with the continuous virtual address, since the user page and the ring
> > +buffer are consecutive, from the control structure pointer it's
> > +easily to know the ring buffer address.
> 
> nit: Perhaps reword a little as:
> Perf uses the same way to manage its ring buffer. In the
> implementation there are two key data structures held together in a
> set of consecutive pages, the control structure and then the ring
> buffer itself. The page with the control structure in is known as the
> "user page". Being held in continuous virtual addresses simplifies
> locating the ring buffer address, it is in the pages after the page
> with the user page.
> 
> Off-topic: seems wasteful to allocate a full page for this.

Arm CPUs support not only 4KiB page size, but also support 16KiB/64KiB
page size, it does waste a bit memory for using a page for control
structure.  But given the control structure need to be mapped to user
space in page size unit, seems here have no room to optimize it.

[...]

> > +        user page                          ring buffer
> > +  +---------+---------+   +---------------------------------------+
> > +  |data_head|data_tail|...|   |   |***|***|***|***|***|   |   |   |
> > +  +---------+---------+   +---------------------------------------+
> > +      `          `--------------^                   ^
> > +       `--------------------------------------------|
> > +
> > +            * : the data is filled by the writer.
> > +           Figure 2: Perf ring buffer
> > +
> > +When using 'perf record' tool, we can specify the ring buffer size with
> 
> nit: s/using/using the/
> 
> > +option '-m' or '--mmap-pages=', finally the size will be rounded up to
> 
> nit: s/finally the size/the given size/
> 
> > +power of two with page unit.  Though the kernel allocates at once for
> 
> nit: s/power of two with page unit/a power of two that is a multiple
> of a page size/
> 
> Off-topic-ish: Perhaps it is worth motivating why the page size must
> be a power of 2. I'm guessing it is because this means that when
> moving the pointers/indices they can be masked to cause wrapping,
> rather than using division/modulus.

Correct.  The comments in kernel/events/core.c verifies this guessing:

"If we have rb pages ensure they're a power-of-two number, so we
can do bitmasks instead of modulo."

> Fwiw, I think this could also be
> solved with a comparison, and the performance overhead could be
> insignificant compared to the memory savings.

I am not sure if a comparison is sufficient.  As you said, if the page
number is not a power-of-two number, and page index increases
monotonically, we need to compute modulus to get the offset.

Agreed with you, we can consider to remove the limitaion of the page
number must be power-of-two for memory saving and check what's the
performance penalty.

> > +all memory pages, it's deferred to map the pages to VMA area until
> > +the perf tool accesses the buffer from the user space.  In other words,
> > +at the first time accesses the buffer's page from user space in the perf
> > +tool, a data abort exception for page fault is taken and the kernel
> > +uses this occasion to map the page into process VMA, thus the perf tool
> > +can continue to access the page after returning from exception.
> 
> nit: s/exception/the exception/
> 
> Off topic: Should the perf tool use something like the MAP_POPULATE
> flag to reduce page faults, given the pages were allocated already in
> the kernel? Tweaking tools/lib/perf/mmap.c to do this and running
> "time perf record -a sleep 1" shows the minor page fault count going
> from 7700 to 9700, so it seems like a bad idea.

Hmm ... I got the opposite result, by observing page fault counting, I
can see the improvement with adding the MAP_POPULATE flag.

Before adding MAP_POPULATE flag:

  # ./perf stat -- ./perf record -a sleep 1

    5,359      page-faults                      #    2.409 K/sec
    5,353      page-faults                      #    2.415 K/sec
    5,353      page-faults                      #    2.425 K/sec

  # ./perf stat -- ./perf record -e cs_etm/@tmc_etr0/ -a sleep 1

    2,122      page-faults                      #    2.038 K/sec
    2,121      page-faults                      #    2.001 K/sec
    2,121      page-faults                      #    2.015 K/sec

After adding MAP_POPULATE flag:

  # ./perf stat -- ./perf record -a sleep 1

    5,004      page-faults                      #    2.260 K/sec
    5,002      page-faults                      #    2.253 K/sec
    5,003      page-faults                      #    2.239 K/sec

  # ./perf stat -- ./perf record -e cs_etm/@tmc_etr0/ -a sleep 1

    1,082      page-faults                      #  856.589 /sec
    1,082      page-faults                      #    1.002 K/sec
    1,080      page-faults                      #    1.013 K/sec

[...]

> > +System wide mode
> > +
> > +By default if without specifying mode, or explicitly using option '–a'
> > +or '––all–cpus', perf collects samples on all CPUs in the system wide
> > +mode.
> > +
> > +In this mode, every CPU has its own ring buffer; all threads are
> > +monitored during the running state and the samples are recorded into the
> 
> This doesn't cover the case of:
> $ perf record benchmark
> Where there will be a ring buffer on every CPU but events/sampling
> will only be enabled for benchmark's threads, ie not all threads.

Correct.  I wrongly thought it's the system-wide mode when don't
specify option '-a', will add a 'default mode' to address above case.

[...]

> > When a sample is recorded into the ring buffer, the kernel event
> > +core layer will wake up the perf process to read samples from the ring
> > +buffer.
> 
> It isn't always necessary to wake the perf tool process. There is a
> little bit more detail on different polling modes in the
> perf_event_open man page in the section on "Overflow handling":
> https://github.com/mkerrisk/man-pages/blob/master/man2/perf_event_open.2#L3062

Exactly, perf ring buffer uses watermark as threshold, and only when
cross the threshold the kernel notifies the user space.  I confirmed
this in the function __perf_output_begin().

So will rephrase as:

"When a sample is recorded into the ring buffer, and the number of
samples crossing the threshold, the kernel event core layer will wake up
the perf process to read samples from the ring buffer."

> > +
> > +                     Perf
> > +                     / | Read samples
> > +           Polling  /  `--------------|               Ring buffer
> > +                   v                  v    ;-------------------v
> > +  +----------------+     +---------+---------+   +-------------------+
> > +  |Event wait queue|     |data_head|data_tail|   |***|***|   |   |***|
> > +  +----------------+     +---------+---------+   +-------------------+
> > +           ^                  ^ `----------------------^
> > +           | Wake up tasks    | Store samples
> > +        +-----------------------------+
> > +       |  Kernel event core layer    |
> > +        +-----------------------------+
> > +
> > +            * : the data is filled by the writer.
> > +           Figure 6: Writing and reading the ring buffer
> > +
> > +Because multiple events might share the same ring buffer for recording
> > +samples, when any event sample is stored into the ring buffer, the
> > +kernel event core layer iterates every event associated to the ring
> > +buffer and wake up tasks on the wait queue of the events.  This is
> > +fulfilled by the kernel function ring_buffer_wakeup().
> 
> I'm not sure about the use of "event" here. If you do:
> $ perf stat -e "cycles,instructions"
> Then cycles and instructions will each have a ring buffer, I'm not
> sure it is possible to get them to share a ring buffer. I think here
> you may be referring to side band events, like mmap2.

Seems to me, this is incorrect.  Since 'perf stat' only read counters
(via the kernel function perf_read()), it doesn't allocate ring buffer
at all for events.  By using GDB, I can confirm the function
perf_mmap__mmap() is never called for 'perf stat' command.

Just clarify, 'perf stat' still mmap the 'user page' for control
structure and for timer counter accessing, but this is not the same
thing with ring buffer.

[...]

> > +In Linux kernel, the event core layer uses the structure perf_buffer to
> > +track the buffer’s latest header, and it keeps the information for
> > +buffer pages.  The structure perf_buffer manages ring buffer during its
> > +life cycle, it is allocated once the ring buffer is created and released
> > +when the ring buffer is destroyed.
> > +
> > +It’s possible for multiple events to write buffer concurrently.  For
> > +instance, a software event and a hardware PMU event both are enabled for
> > +profiling, when the software event is in the middle of sampling, the
> > +hardware event maybe be overflow and its interrupt is triggered in this
> > +case.  This leads to the race condition for updating perf_buffer::head.
> > +In __perf_output_begin(), Linux kernel uses compare-and-swap atomicity
> > +local_cmpxchg() to implement the lockless algorithm for protecting
> > +perf_buffer::head.
> 
> In the case of:
> $ perf record -e "instructions,faults"
> faults is a software event but it won't share the ring buffer with
> instructions. I think the atomicity exists for the side band events.

I verified on my Arm64 board and confirmed that hardware events
(instructions, cycles) share the same ring buffer with software event
(faults).  Below is the captured log (truncated for more readable):

  ...
  => __perf_sw_event
  => do_page_fault
  => do_translation_fault
  ...
  ls-884     [003] ...2.   253.737217: perf_output_begin_forward: __perf_output_begin: rb=00000000720bac97 page=0 offset=1688 addr=0000000019392296 size=2408
  
  ...
  => __perf_event_overflow
  => perf_event_overflow
  => armv8pmu_handle_irq
  ...
  ls-884     [003] d.h1.   253.737247: perf_output_begin_forward: __perf_output_begin: rb=00000000720bac97 page=0 offset=1736 addr=000000009e259b5a size=2360

We can see for both software event and Armv8 PMU event, both use the
same rb pointer (0x00000000720bac9), which means the software and
hardware events store samples into the same ring buffer.  Thus the
above description is valid.

P.s. maybe the side band events are not a relevant topic, but I can
see the side band events have dedicated ring buffer.

Thanks,
Leo
