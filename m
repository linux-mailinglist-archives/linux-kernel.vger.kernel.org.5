Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482A57C7680
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 21:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442066AbjJLTOv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 15:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344140AbjJLTOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 15:14:49 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79FBB7;
        Thu, 12 Oct 2023 12:14:48 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1e99a55a9c0so112543fac.1;
        Thu, 12 Oct 2023 12:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697138088; x=1697742888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LT61jJcy+T9cpr72bcE+s5GrJr0v/YeWRBlC23o1xQY=;
        b=LYnmW11vs1HDEVFvOuJBZcxDmVs0ALRa41xcbK35mbcVw/9QxoTGxeKFFn4SfIqz8q
         XGK0erE6Jb6Oyj7/ocJ3rwpNnzmRpFWx+cuklAxpX47MixA8QxTX5uSgrozVD58nqF+p
         qNV9xNy2FEhXeKPzE3iBc7tlPrpPojDodKezFHcgH7SL/xBaGteRszPVU1UjWtOjVmUV
         IDKnaMQcFnUhgyRIHLhk200b8JGBmNIrTF8ekJO0KfCGMJNHwtPQ9ifIjWpVBbdTs9J/
         HFVYNFZ6kq8eA/MzBlvs9JwbTiH/PyUiKYQzK/nFG8NZ9RuHrIFPxXBppwh0nsZ1HYuB
         9YcA==
X-Gm-Message-State: AOJu0Yzk4KdXAgCR7rtmTqyt0tHV66p8c+a9bwZ4x6LrMk7vIcioNg2b
        bOIOAq2s33DYefApxYgsKwruBZP4aDYsaHKgVpY=
X-Google-Smtp-Source: AGHT+IESIkFVO5Up/TkYa/+tM7AY+UGJHT3nhd/+b3txSN1DY3R8aMvvSFfjlYy6pBo8B+al3AoaxIGVM4qGAjcfGCY=
X-Received: by 2002:a05:6820:390:b0:57c:6e35:251e with SMTP id
 r16-20020a056820039000b0057c6e35251emr23868576ooj.1.1697138084151; Thu, 12
 Oct 2023 12:14:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <20231009190538.2488792-1-srinivas.pandruvada@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 Oct 2023 21:14:33 +0200
Message-ID: <CAJZ5v0jH9ZYxvK6MxXXb-RggzwtPie9dhpfmUBduyc2P9rczEg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] thermal: processor_thermal: Power floor status
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 9:06 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Support power floor notifications for Meteor Lake processors.
>
> The first three changes is to prepare for power floor status and others
> add support for power floor.
>
> v2
> - Use common define for offset
> - Fix potential race during clearing of interrupt with workload hint
> - Address comment for v1 for
> thermal: int340x: processor_thermal: Support power floor notifications
>
> Srinivas Pandruvada (7):
>   thermal: int340x: processor_thermal: Move interrupt status MMIO offset
>     to common header
>   thermal: int340x: processor_thermal: Common function to clear SOC
>     interrupt
>   thermal: int340x: processor_thermal: Set feature mask before
>     proc_thermal_add
>   thermal: int340x: processor_thermal: Support power floor notifications
>   thermal: int340x: processor_thermal: Handle power floor interrupts
>   thermal: int340x: processor_thermal: Enable power floor support
>   selftests/thermel/intel: Add test to read power floor status
>
>  .../driver-api/thermal/intel_dptf.rst         |   8 ++
>  .../thermal/intel/int340x_thermal/Makefile    |   1 +
>  .../processor_thermal_device.c                |  68 +++++++++-
>  .../processor_thermal_device.h                |  11 ++
>  .../processor_thermal_device_pci.c            |  43 ++++--
>  .../processor_thermal_power_floor.c           | 126 ++++++++++++++++++
>  .../processor_thermal_wt_hint.c               |   3 -
>  tools/testing/selftests/Makefile              |   1 +
>  .../thermal/intel/power_floor/Makefile        |  12 ++
>  .../intel/power_floor/power_floor_test.c      | 108 +++++++++++++++
>  10 files changed, 365 insertions(+), 16 deletions(-)
>  create mode 100644 drivers/thermal/intel/int340x_thermal/processor_thermal_power_floor.c
>  create mode 100644 tools/testing/selftests/thermal/intel/power_floor/Makefile
>  create mode 100644 tools/testing/selftests/thermal/intel/power_floor/power_floor_test.c
>
> --

Whole series queued up as 6.7 material.

I've edited a couple of changelogs to clarify them a bit and changed
the documentation of the new sysfs attributes somewhat, so they don't
talk about RAPL directly, because I think that the key point here is
that if the power floor is signaled, the configuration of the system
needs to be changed in order to reduce power below the current level.
