Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A443978F227
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 19:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346979AbjHaRsw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Aug 2023 13:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345842AbjHaRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 13:48:51 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA776E76;
        Thu, 31 Aug 2023 10:48:42 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7927f241772so40234939f.1;
        Thu, 31 Aug 2023 10:48:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693504122; x=1694108922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aiQh0/psGoXqeYgus+Db46IktFjNj34WKa6B13MkAk=;
        b=C6tLquyAXMDVOdnHPUyqVn+iYVSWGlmZA+QoD0lno2vnRHOEyWodvpAKTimPmOl3r/
         UN2hjfsEeO0sV3kPmcVFTnzzg9brHpky4zHIFKHQkQZHHY/AhfwCjUmKZRNUpByuhuxq
         2GHkYupyr6Djby2hnSLQx2HX8Hp82Og7zHhWwGdxaZPVSYldGSvJcdQjWxY6dm+0Ylpz
         5+1fIthwX803f6IOKA88dv3X8EGixIL31DC3XUZHU1oRPPYNseF3h5SZXISieVZyqCHg
         RB5RHNGF+v8kymaPKMfyaWRFQxkCHggXym/W3KpXVz5b8w3oL15trsh4gNUCJ0/sFEF+
         8E9Q==
X-Gm-Message-State: AOJu0Yzdh3t1D7eQVYKJONJtfI6sbRBnd+/EpIwvJhD9NAvvoDLg0Sd9
        2leqtu5HHVgdo5UhWUzCSD4ngk3h7GRBOJHeiJA=
X-Google-Smtp-Source: AGHT+IGATg8vwkN8sqpmK3oCH1Wz3TccBZl98PRaz90L+g2Q+qMmE75R/d0vgf3ofoHprcLRbIN5sLws1i1h8VUMuqY=
X-Received: by 2002:a6b:7a01:0:b0:785:ca70:46a2 with SMTP id
 h1-20020a6b7a01000000b00785ca7046a2mr6339311iom.4.1693504121921; Thu, 31 Aug
 2023 10:48:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230826070921.75956-1-leo.yan@linaro.org>
In-Reply-To: <20230826070921.75956-1-leo.yan@linaro.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 31 Aug 2023 10:48:30 -0700
Message-ID: <CAM9d7cjs5RG1D8DLEmCOTrm=TLEF9CYUvaYem7Z_T85fE-PBRg@mail.gmail.com>
Subject: Re: [PATCH v7] Documentation: userspace-api: Document perf ring
 buffer mechanism
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

Thanks for your work on this!

On Sat, Aug 26, 2023 at 12:09 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> In the Linux perf tool, the ring buffer serves not only as a medium for
> transferring PMU event data but also as a vital mechanism for hardware
> tracing using technologies like Intel PT and Arm CoreSight, etc.
>
> Consequently, the ring buffer mechanism plays a crucial role by ensuring
> high throughput for data transfer between the kernel and user space
> while avoiding excessive overhead caused by the ring buffer itself.
>
> This commit documents the ring buffer mechanism in detail.  It explains
> the implementation of both the regular ring buffer and the AUX ring
> buffer.  Additionally, it covers how these ring buffers support various
> tracing modes and explains the synchronization with memory barriers.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

[SNIP]
> +.. _writing_samples_into_buffer:
> +
> +2.3.2 Writing samples into buffer
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Ring buffers are mapped in either read-write mode or read-only mode to
> +the user space.
> +
> +The ring buffer in the read-write mode is mapped with the property
> +``PROT_READ | PROT_WRITE``.  With the write permission, the perf tool
> +updates the ``data_tail`` to indicate the data start position.  Combining
> +with the head pointer ``data_head``, which works as the end position of
> +the current data, the perf tool can easily know where read out the data
> +from.
> +
> +Alternatively, in the read-only mode, only the kernel keeps to update
> +the ``data_head`` while the user space cannot access the ``data_tail`` due
> +to the mapping property ``PROT_READ``.
> +
> +In addition to the mapping modes, the write direction also matters. The
> +perf tool supports two write directions: forward and backward.  As a

s/perf tool/Linux kernel/

> +result, the matrix below shows the combinations between the mapping
> +modes and write directions.
> +
> +.. list-table::
> +   :widths: 1 1 1
> +   :header-rows: 1
> +
> +   * - Mapping mode
> +     - Forward
> +     - Backward
> +   * - read-write
> +     - Normal ring buffer
> +     - Not supported
> +   * - read-only
> +     - Not supported
> +     - Overwritable ring buffer

In the kernel's point of view, they are supported.  It's just perf tool
not using them.  So I think we should say "Not used".

> +
> +The normal ring buffer uses the read-write mapping with forward writing.
> +It starts to save data from the beginning of the ring buffer and wrap
> +around when overflow, which is used with the read-write mode in the
> +normal ring buffer.  When the consumer doesn't keep up with the
> +producer, it would lose some data, the kernel keeps how many records it
> +lost and generates the ``PERF_RECORD_LOST`` records in the next time
> +when it finds a space in the ring buffer.
> +
> +On the other hand, the overwritable ring buffer uses the backward
> +writing with the read-only mode.  It saves the data from the end of the
> +ring buffer and the ``data_head`` keeps the position of current data,
> +the perf always knows where it starts to read and until the end of the
> +ring buffer, thus it don't need the ``data_tail``.  In this mode, it
> +will not generate the ``PERF_RECORD_LOST`` records.
> +
> +When a sample is taken and saved into the ring buffer, the kernel
> +prepares sample fields based on the sample type; then it prepares the
> +info for writing ring buffer which is stored in the structure
> +``perf_output_handle``.  In the end, the kernel outputs the sample into
> +the ring buffer and updates the head pointer in the user page so the
> +perf tool can see the latest value.
> +
> +The structure ``perf_output_handle`` serves as a temporary context for
> +tracking the information related to the buffer.  The advantages of it is
> +that it enables concurrent writing to the buffer by different events.
> +For example, a software event and a hardware PMU event both are enabled
> +for profiling, two instances of ``perf_output_handle`` serve as separate
> +contexts for the software event and the hardware event respectively.
> +This allows each event to reserve its own memory space for populating
> +the record data.
> +

[SNIP]
> +
> +3. The mechanism of AUX ring buffer
> +===================================
> +
> +In this chapter, we will explain the implementation of the AUX ring
> +buffer.  In the first part it will discuss the connection between the
> +AUX ring buffer and the regular ring buffer, then the second part will
> +examine how the AUX ring buffer co-works with the regular ring buffer,
> +as well as the additional features introduced by the AUX ring buffer for
> +the sampling mechanism.
> +
> +3.1 The relationship between AUX and regular ring buffers
> +---------------------------------------------------------
> +
> +Generally, the AUX ring buffer is an auxiliary for the regular ring
> +buffer.  The regular ring buffer is primarily used to store the event
> +samples and every event format complies with the definition in the
> +union ``perf_event``; the AUX ring buffer is for recording the hardware
> +trace data and the trace data format is hardware IP dependent.
> +
> +The general use and advantage of the AUX ring buffer is that it is
> +written directly by hardware rather than by the kernel.  For example,
> +regular profile samples that write to the regular ring buffer cause an
> +interrupt.  Tracing execution requires a high number of samples and
> +using interrupts would be overwhelming for the regular ring buffer
> +mechanism.  Having an AUX buffer allows for a region of memory more
> +decoupled from the kernel and written to directly by hardware tracing.
> +
> +The AUX ring buffer reuses the same algorithm with the regular ring
> +buffer for the buffer management.  The control structure
> +``perf_event_mmap_page`` extends the new fields ``aux_head`` and ``aux_tail``
> +for the head and tail pointers of the AUX ring buffer.
> +
> +During the initialisation phase, besides the mmap()-ed regular ring
> +buffer, the perf tool invokes a second syscall in the

second mmap syscall

> +``auxtrace_mmap__mmap()`` function for the mmap of the AUX buffer;

with non-zero file offset.

> +``rb_alloc_aux()`` in the kernel allocates pages correspondingly, these
> +pages will be deferred to map into VMA when handling the page fault,
> +which is the same lazy mechanism with the regular ring buffer.
> +
> +AUX events and AUX trace data are two different things.  Let's see an
> +example::
> +
> +        perf record -a -e cycles -e cs_etm/@tmc_etr0/ -- sleep 2
> +
> +The above command enables two events: one is the event *cycles* from PMU
> +and another is the AUX event *cs_etm* from Arm CoreSight, both are saved
> +into the regular ring buffer while the CoreSight's AUX trace data is
> +stored in the AUX ring buffer.
> +
> +As a result, we can see the regular ring buffer and the AUX ring buffer
> +are allocated in pairs.  The perf in default mode allocates the regular
> +ring buffer and the AUX ring buffer per CPU-wise, which is the same as
> +the system wide mode, however, the default mode records samples only for
> +the profiled program, whereas the latter mode profiles for all programs
> +in the system.  For per-thread mode, the perf tool allocates only one
> +regular ring buffer and one AUX ring buffer for the whole session.  For
> +the per-CPU mode, the perf allocates two kinds of ring buffers for CPUs
> +specified by the option ``-C``.

Considering -a option, it can be "ring buffers for selected CPUs".

> +
> +The below figure demonstrates the buffers' layout in the system wide
> +mode; if there are any activities on one CPU, the AUX event samples and
> +the hardware trace data will be recorded into the dedicated buffers for
> +the CPU.
> +
> +::
> +
> +              T1                      T2                 T1
> +            +----+              +-----------+          +----+
> +    CPU0    |xxxx|              |xxxxxxxxxxx|          |xxxx|
> +            +----+--------------+-----------+----------+----+-------->
> +              |                       |                  |
> +              v                       v                  v
> +            +-----------------------------------------------------+
> +            |                  Ring buffer 0                      |
> +            +-----------------------------------------------------+
> +              |                       |                  |
> +              v                       v                  v
> +            +-----------------------------------------------------+
> +            |               AUX Ring buffer 0                     |
> +            +-----------------------------------------------------+
> +
> +                   T1
> +                 +-----+
> +    CPU1         |xxxxx|
> +            -----+-----+--------------------------------------------->
> +                    |
> +                    v
> +            +-----------------------------------------------------+
> +            |                  Ring buffer 1                      |
> +            +-----------------------------------------------------+
> +                    |
> +                    v
> +            +-----------------------------------------------------+
> +            |               AUX Ring buffer 1                     |
> +            +-----------------------------------------------------+
> +
> +                                        T1              T3
> +                                      +----+        +-------+
> +    CPU2                              |xxxx|        |xxxxxxx|
> +            --------------------------+----+--------+-------+-------->
> +                                        |               |
> +                                        v               v
> +            +-----------------------------------------------------+
> +            |                  Ring buffer 2                      |
> +            +-----------------------------------------------------+
> +                                        |               |
> +                                        v               v
> +            +-----------------------------------------------------+
> +            |               AUX Ring buffer 2                     |
> +            +-----------------------------------------------------+
> +
> +                              T1
> +                       +--------------+
> +    CPU3               |xxxxxxxxxxxxxx|
> +            -----------+--------------+------------------------------>
> +                              |
> +                              v
> +            +-----------------------------------------------------+
> +            |                  Ring buffer 3                      |
> +            +-----------------------------------------------------+
> +                              |
> +                              v
> +            +-----------------------------------------------------+
> +            |               AUX Ring buffer 3                     |
> +            +-----------------------------------------------------+
> +
> +            T1: Thread 1; T2: Thread 2; T3: Thread 3
> +            x: Thread is in running state
> +
> +                Figure 8. AUX ring buffer for system wide mode
> +
> +3.2 AUX events
> +--------------
> +
> +Similar to ``perf_output_begin()`` and ``perf_output_end()``'s working for the
> +regular ring buffer, ``perf_aux_output_begin()`` and ``perf_aux_output_end()``
> +serve for the AUX ring buffer for processing the hardware trace data.
> +The structure ``perf_output_handle`` is used as a context to track the AUX
> +buffer’s info.

I feel like this section contains kernel implementation details.
Please focus on the user-visible aspect.

> +
> +``perf_aux_output_begin()`` initializes the structure perf_output_handle.
> +It fetches the AUX head pointer and assigns to ``perf_output_handle::head``,
> +afterwards, the low level driver uses ``perf_output_handle::head`` as the
> +start address for storing hardware trace data.
> +
> +Once the hardware trace data is stored into the AUX ring buffer, the PMU
> +driver will stop hardware tracing by calling the ``pmu::stop()`` callback.
> +Similar to the regular ring buffer, the AUX ring buffer needs to apply
> +the memory synchronization mechanism as discussed in the section
> +:ref:`memory_synchronization`.  Since the AUX ring buffer is managed by the
> +PMU driver, the barrier (B), which is a writing barrier to ensure the trace
> +data is externally visible prior to updating the head pointer, is asked
> +to be implemented in the PMU driver.
> +
> +Then ``pmu::stop()`` can safely call the ``perf_aux_output_end()`` function to
> +finish two things:
> +
> +- It fills an event ``PERF_RECORD_AUX`` into the regular ring buffer, this
> +  event delivers the information of the start address and data size for a
> +  chunk of hardware trace data has been stored into the AUX ring buffer;
> +
> +- Since the hardware trace driver has stored new trace data into the AUX
> +  ring buffer, the argument *size* indicates how many bytes have been
> +  consumed by the hardware tracing, thus ``perf_aux_output_end()`` updates the
> +  header pointer ``perf_buffer::aux_head`` to reflect the latest buffer usage.
> +
> +At the end, the PMU driver will restart hardware tracing.  During this
> +temporary suspending period, it will lose hardware trace data, which
> +will introduce a discontinuity during decoding phase.
> +
> +The event ``PERF_RECORD_AUX`` presents an AUX event which is handled in the
> +kernel, but it lacks the information for saving the AUX trace data in
> +the perf file.  When the perf tool copies the trace data from AUX ring
> +buffer to the perf data file, it synthesizes a ``PERF_RECORD_AUXTRACE``

I think you should mention that AUXTRACE record is not a kernel ABI.
It's defined by perf tool to describe which portion of data in the AUX
ring buffer is saved.

Thanks,
Namhyung


> +event which includes the offest and size of the AUX trace data in the
> +perf file.  Afterwards, the perf tool reads out the AUX trace data from
> +the perf file based on the ``PERF_RECORD_AUXTRACE`` events, and the
> +``PERF_RECORD_AUX`` event is used to decode a chunk of data by correlating
> +with time order.
> +
> +3.3 Snapshot mode
> +-----------------
> +
> +Perf supports snapshot mode for AUX ring buffer, in this mode, users
> +only record AUX trace data at a specific time point which users are
> +interested in.  E.g. below gives an example of how to take snapshots
> +with 1 second interval with Arm CoreSight::
> +
> +  perf record -e cs_etm/@tmc_etr0/u -S -a program &
> +  PERFPID=$!
> +  while true; do
> +      kill -USR2 $PERFPID
> +      sleep 1
> +  done
> +
> +The main flow for snapshot mode is:
> +
> +- Before a snapshot is taken, the AUX ring buffer acts in free run mode.
> +  During free run mode the perf doesn't record any of the AUX events and
> +  trace data;
> +
> +- Once the perf tool receives the *USR2* signal, it triggers the callback
> +  function ``auxtrace_record::snapshot_start()`` to deactivate hardware
> +  tracing.  The kernel driver then populates the AUX ring buffer with the
> +  hardware trace data, and the event ``PERF_RECORD_AUX`` is stored in the
> +  regular ring buffer;
> +
> +- Then perf tool takes a snapshot, ``record__read_auxtrace_snapshot()``
> +  reads out the hardware trace data from the AUX ring buffer and saves it
> +  into perf data file;
> +
> +- After the snapshot is finished, ``auxtrace_record::snapshot_finish()``
> +  restarts the PMU event for AUX tracing.
> +
> +The perf only accesses the head pointer ``perf_event_mmap_page::aux_head``
> +in snapshot mode and doesn’t touch tail pointer ``aux_tail``, this is
> +because the AUX ring buffer can overflow in free run mode, the tail
> +pointer is useless in this case.  Alternatively, the callback
> +``auxtrace_record::find_snapshot()`` is introduced for making the decision
> +of whether the AUX ring buffer has been wrapped around or not, at the
> +end it fixes up the AUX buffer's head which are used to calculate the
> +trace data size.
> +
> +As we know, the buffers' deployment can be per-thread mode, per-CPU
> +mode, or system wide mode, and the snapshot can be applied to any of
> +these modes.  Below is an example of taking snapshot with system wide
> +mode.
> +
> +::
> +
> +                                         Snapshot is taken
> +                                                 |
> +                                                 v
> +                        +------------------------+
> +                        |  AUX Ring buffer 0     | <- aux_head
> +                        +------------------------+
> +                                                 v
> +                +--------------------------------+
> +                |          AUX Ring buffer 1     | <- aux_head
> +                +--------------------------------+
> +                                                 v
> +    +--------------------------------------------+
> +    |                      AUX Ring buffer 2     | <- aux_head
> +    +--------------------------------------------+
> +                                                 v
> +         +---------------------------------------+
> +         |                 AUX Ring buffer 3     | <- aux_head
> +         +---------------------------------------+
> +
> +                Figure 9. Snapshot with system wide mode
> --
> 2.34.1
>
