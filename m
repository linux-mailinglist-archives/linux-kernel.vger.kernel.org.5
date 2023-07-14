Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D08753FAB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 18:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjGNQNg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Jul 2023 12:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235274AbjGNQNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 12:13:21 -0400
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5856F3C3B;
        Fri, 14 Jul 2023 09:13:03 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-94ea38c90ccso57670766b.1;
        Fri, 14 Jul 2023 09:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689351182; x=1691943182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1n7SFN/ZrkwTRk+lgceZM38JBM9Mc+IqCkgdfg3+FQw=;
        b=WrHMd1H6UsYO9Cxvhjo5V3ohKtQz8cEZW4g8xd8H2tvFEFy2rRrrJuqqts4/UYeyES
         RRSD6wBbMcmx/QKOBzn69wyCRmGCPJjTZqmbWF98NoXvxRa1WLsoWQ4vbBMiaQVAy8iv
         evfjW3EFUOrOqJ7g+mYU3A9Ckt0zOoggXQKEzrgDkWqqahisPVk126XG1qA/LNUhNKiV
         jD9e6yTl7sD/GV2mH9MyA0cToJzpc31RNJ9Sfz4AWibh1fPU2drCBhLYhYSe487gyNx2
         ibHmyDTdHqu7GbIY4/Srhnto1GsHt+YJftYgbjrLt/cnJV1JBQAVL5Fo65f9HAMp5jqh
         tr7A==
X-Gm-Message-State: ABy/qLbIpQ837qqV/5j4RIqe7Osd+t8uZjYw1yOiUEKzdTH5T/FlWOzp
        +DTqJl8CHVh5G89Cq6wN0quH+nN1YgiyjhVMfdffCLx2RY8=
X-Google-Smtp-Source: APBJJlHMjcbGxm04SzeLPZkZCBouTjny73Xfr/5XFL6oFh2Ha37n60cTMaJw/yWwh6/ggoAZ9iBMAe7/pEEuD2BToTI=
X-Received: by 2002:a17:906:738c:b0:993:eed1:8f0 with SMTP id
 f12-20020a170906738c00b00993eed108f0mr3908293ejl.3.1689351181615; Fri, 14 Jul
 2023 09:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230710140337.1434060-1-michal.wilczynski@intel.com>
In-Reply-To: <20230710140337.1434060-1-michal.wilczynski@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jul 2023 18:12:50 +0200
Message-ID: <CAJZ5v0iZbX+pV7y=ioYA+OCN=09Ujmjri-JEhYdvUd9VB1BWgg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Prefer using _OSC method over deprecated _PDC
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     linux-acpi@vger.kernel.org, rafael@kernel.org,
        andriy.shevchenko@intel.com, artem.bityutskiy@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, lenb@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:06 PM Michal Wilczynski
<michal.wilczynski@intel.com> wrote:
>
> ACPI 3.0 introduced a new Operating System Capabilities _OSC control
> method. This method is similar to _PDC, which was marked as deprecated
> in ACPI 3.0.
>
> Prefer using _OSC method over deprecated _PDC in the acpi_bus_init(). In
> case of the failure of the _OSC, try using _PDC as a fallback.
>
> Testing done:
> Tested on physical server with BIOS implementing _OSC methods. In this
> case acpi_processor_osc() was executed for each CPU core. acpi_run_osc()
> returned success indicating that _OSC method succeeded.
>
> Tested on qemu VM to check whether the code would work on a SeaBios (the
> default for qemu, doesn't support _OSC methods, or _PDC). This way I was
> able to see how code behaves in case BIOS doesn't implement _OSC. In
> that case the function
> acpi_run_osc() returned failure, which propagated all the way up to
> acpi_early_processor_osc(). The logic responsible for triggering _PDC
> execution was triggered correctly.
>
> Tested this using debug messages with printk.
>
> v4:
>  - move setting processor capabilities bits into arch code
>  - move workaround for mwait to acpi/x86 directory
>  - rename ACPI_PDC* constants to more generic ACPI_PROC_CAP*
>  - introduce new function acpi_early_processor_control_setup()
>
> v3:
>  - split into more commits to make review easier
>  - changed "_UID" to METHOD_NAME_UID
>  - changed hard-coded constant to ACPI_PDC_COLLAB_PROC_PERF
>  - added Suggested-by tags
>  - fixed style issues
>  - fixed whitespaces
>  - refactored code
> v2:
>  - fixed compilation issues on ia64 and arm
>
> Michal Wilczynski (9):
>   acpi: Move mwait quirk out of acpi_processor.c
>   acpi: Move processor_physically_present() to acpi_processor.c
>   acpi: Refactor arch_acpi_set_pdc_bits()
>   acpi: Rename ACPI_PDC constants
>   acpi: Clear C_C2C3_FFH and C_C1_FFH in arch_acpi_set_proc_cap_bits()
>   acpi: Move setting CAP_SMP_T_SWCOORD to arch_acpi_set_proc_cap_bits()
>   acpi: Introduce acpi_processor_osc()
>   acpi: Use _OSC method to convey processor OSPM capabilities
>   acpi: Remove acpi_hwp_native_thermal_lvt_osc()

I have made a number of changes to the patches (edited subjects,
rewrote changelogs, fixed up whitespace in a few places, changed the
return value of acpi_early_processor_osc() to bool and made it static
etc.) and tentatively queued them up for 6.6.  Please see the
bleeding-edge branch of linux-pm.git.

I have made sure that the series will still compile at least on
x86-64, but testing it again would be appreciated.

Thanks!
