Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF3784FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 06:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjHWE0W convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 23 Aug 2023 00:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232348AbjHWE0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 00:26:20 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5C7E56;
        Tue, 22 Aug 2023 21:26:18 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-48d0eb04c8cso888923e0c.0;
        Tue, 22 Aug 2023 21:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692764777; x=1693369577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nE6DTLfN3ouIo27YNTlsSzc6zc01NPTEWUx80jUS8mk=;
        b=iKOkLQmyHLhL7TY7FiJrnfIETQhwca+/bPzrPldHu9VHDqjx/p8XYF6nRot/N/NQU8
         2Yds6P4qCc3BV/yFtWfKVkQOBYQzGElHuDINMZZN4eiUEPpFssqpt8h5h28ztaauGJb0
         ALpG/DhjmrkjanGh+hWY78r/jx+0PpXlhh9iKzI+KQ+8/Iko5zTznU2EBca0Mj2gdPR+
         VyAuph9bcq4b7MplSByTlOyUcVa92JWkyb1Da5yGRR5gjzL68ETTHRy/i9ynjhYRqaQC
         B2fRGSLOg2KLHWjzqBbVoZz8F3/HmYgaiquoGu3t9jA3Cs0otvMR9LPWyIYOCWFewbvg
         A7Fw==
X-Gm-Message-State: AOJu0YxMgSnIDwgX1P8W0Z7v3u3NsEKJdtu2Dn0ZnUMxCzmjLxHZp8Ol
        itE2A5iHGPGUlTd8EoFVPQS4vtygZWjKNfRRsE0=
X-Google-Smtp-Source: AGHT+IFO5xLcXF5NEqb9XiIxPrEIUso2679WWl2TFLuJB7mx3RgByBjshF1425w5r3W52E/2dq2JHixGHuQwqVElbQw=
X-Received: by 2002:a1f:c386:0:b0:48d:5f5:e201 with SMTP id
 t128-20020a1fc386000000b0048d05f5e201mr5510580vkf.15.1692764777198; Tue, 22
 Aug 2023 21:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230819093340.265817-1-leo.yan@linaro.org> <CAM9d7cj=ichFk4bVQSbyptqy9wo8GFm1Z1Q7QzfhMFLjewNF-Q@mail.gmail.com>
 <20230823023838.GF57731@leoy-huanghe.lan>
In-Reply-To: <20230823023838.GF57731@leoy-huanghe.lan>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Aug 2023 21:26:05 -0700
Message-ID: <CAM9d7cgaMyH=vSjVEOBjLzBWbZOricm6aHcP9hfLsTJ_gUEh3g@mail.gmail.com>
Subject: Re: [PATCH v6] Documentation: userspace-api: Document perf ring
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

On Tue, Aug 22, 2023 at 7:38 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> Hi Namhyung,
>
> On Tue, Aug 22, 2023 at 05:43:25PM -0700, Namhyung Kim wrote:
>
> [...]
>
> > > +2.3.2 Writing samples into buffer
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +Ring buffers are mapped as read-write mode or read-only mode, which is
> > > +used for a normal ring buffer and an overwritable ring buffer
> > > +respectively.
> > > +
> > > +The ring buffer in the read-write mode is mapped with the property
> > > +``PROT_READ | PROT_WRITE``.  With the write permission, the perf tool
> > > +updates the ``data_tail`` to indicate the data start position.  Combining
> > > +with the head pointer ``data_head``, which works as the end position of
> > > +the current data, the perf tool can easily know where read out the data
> > > +from.
> > > +
> > > +Alternatively, in the read-only mode, only the kernel keeps to update
> > > +the ``data_head`` while the user space cannot access the ``data_tail`` due
> > > +to the mapping property ``PROT_READ``.
> > > +
> > > +Why ring buffers are mapped with above two different modes?  Here the
> > > +write direction matters.  The forward writing starts to save data from
> > > +the beginning of the ring buffer and wrap around when overflow, which is
> > > +used with the read-write mode in the normal ring buffer.  When the
> > > +consumer doesn't keep up with the producer, it would lose some data, the
> > > +kernel keeps how many records it lost and generates the
> > > +``PERF_RECORD_LOST`` records in the next time when it finds a space in the
> > > +ring buffer.
> >
> > Thanks for the update.  It's unclear to me if all 4 combination of
> > (rw, ro) x (fwd, bwd) are possible (yes!).  The rw mode and back-
> > ward is also possible but just not used for perf tool.
>
> I can add a matrix for the combinations:
>
>   The combination is supported in perf tool:
>
>   ---+------------+-----------
>      |  Forward   | Backward
>   ---+------------+-----------
>   rw |  Yes       |   No
>   ---+------------+-----------
>   ro |  X         |   Yes
>   ---+------------+-----------
>
>   Yes: is supported
>   No: is not supported
>   X: is not feasible

I think they are all supported.  You can use rw mode with backward
direction but it's just not intuitive.  Also ro mode with forward direction
is working but there's a chance to miss the start position of the
previous event.

Thanks,
Namhyung


>
> > And I think the description below in this section shows kernel
> > internals too much.  Name of kernel functions and data structure
> > is not an API and can be changed any time.  You can describe
> > the logic without the names.
>
> Understand, I agree this will introduce maintenance efforts in later.
>
> I will refine the description and send a new patch.
>
> Thanks for reviewing!
>
> Leo
