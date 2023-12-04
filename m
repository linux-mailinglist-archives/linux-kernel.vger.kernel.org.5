Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BFE80359D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344709AbjLDNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjLDNzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:55:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE14102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701698116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rCxNlPEfvmUt+dMkGMRxhZZEToiC2OpKW9nSyl2Siw=;
        b=GFn7JYTj9jGRieSVH6e6JH9H0TskyUg5JPkO3qgZZ4dU+J0uyMFlxfTgkeBdkrIRiaP377
        xL6SBYkoqDOOd8hnzrubofzkyFkekpkSYmwaOyEzobKYslfVt/f1Yao2ALrCR/RD+KXJ1v
        H5zjrUIq8us+W9xB3b2sF2eyPAP8Qlg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-3d1nwySfOlCHuBiI49DetQ-1; Mon, 04 Dec 2023 08:55:14 -0500
X-MC-Unique: 3d1nwySfOlCHuBiI49DetQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-542fe446d45so3352495a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 05:55:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701698113; x=1702302913;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rCxNlPEfvmUt+dMkGMRxhZZEToiC2OpKW9nSyl2Siw=;
        b=IeTm66N5lRlvRp64JMdaBhHc3lFsOaVwcaoNBW7tLnWP3gYyIHKmiYtTFKEln36R4D
         5unDgFb0qb1KMu1MqHxOme1CgVaOyYYxISPeFo5WIlGZXcfUgmCQKQ/stc86LQwmalft
         3w8S9LlR3lPHIP7317208uVYDt6tj8M90ceMJLINwmnCUTox+lgWKGPvziV0ToL9N9aL
         0fMSA+f1nhYoXFVyMKV9zCmOIgGmlnLdwmlI2SmpIuhVcgvHuh3SvyOVtVq1fmMF0AFZ
         OUxnFlpI+inGWY6vRjGODaTjKkNflpkZ+10JOO7BbB3NAyn46naBsT7mlb2gbvFKHLXi
         ZkxA==
X-Gm-Message-State: AOJu0YzhKPxmAnHXp3VDlGWhu7eT1SYQFRO9lZdGGu/Z+n642n+7E4Pv
        Gpao00EnpZxVaRY1iMZWSk8YKJTXRjaUMOftDkrzGfcpFKL7FOitrOo0gwP73ewNO/R00btr9Qa
        q3BrMkbVcyiSiEfhGQToQ9bcY
X-Received: by 2002:aa7:d514:0:b0:54c:4837:81e8 with SMTP id y20-20020aa7d514000000b0054c483781e8mr3221063edq.57.1701698113028;
        Mon, 04 Dec 2023 05:55:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGabjburkJuTgfJ3hPXztgek6vxi3EPusJdg8wu+vTwhqQVSAQljlDnjfVuDmSA7enr2HRuCw==
X-Received: by 2002:aa7:d514:0:b0:54c:4837:81e8 with SMTP id y20-20020aa7d514000000b0054c483781e8mr3221059edq.57.1701698112851;
        Mon, 04 Dec 2023 05:55:12 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id g2-20020a056402320200b0054ca3697e2csm2146885eda.25.2023.12.04.05.55.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 05:55:12 -0800 (PST)
Message-ID: <c3f7a2ba-d356-4afa-bcd2-cd10e086cb2c@redhat.com>
Date:   Mon, 4 Dec 2023 14:55:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V6 00/20] intel_pmc: Add telemetry API to read counters
Content-Language: en-US
To:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com, rajvi.jingar@linux.intel.com
References: <20231129222132.2331261-1-david.e.box@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20231129222132.2331261-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/29/23 23:21, David E. Box wrote:
> On newer Intel silicon, more IP counters are being added in Intel Platform
> Monitoring Technology (PMT) telemetry spaces hosted in MMIO.  There is a
> need for the intel_pmc_core driver and other drivers to access PMT hosted
> telemetry in the kernel using an API. This patchset adds driver APIs to
> allow registering and reading telemetry entries. It makes changes to the
> intel_pmc_core driver to use these interfaces to access the low power mode
> counters that are now exclusively available from PMT.
> 
> David E. Box (15):
>   platform/x86/intel/vsec: Fix xa_alloc memory leak
>   platform/x86/intel/vsec: Remove unnecessary return
>   platform/x86/intel/vsec: Move structures to header
>   platform/x86/intel/vsec: remove platform_info from vsec device
>     structure
>   platform/x86/intel/vsec: Use cleanup.h
>   platform/x86/intel/vsec: Assign auxdev parent by argument
>   platform/x86/intel/vsec: Add base address field
>   platform/x86/intel/pmt: Add header to struct intel_pmt_entry
>   platform/x86/intel/pmt: telemetry: Export API to read telemetry
>   platform/x86/intel/pmc: Allow pmc_core_ssram_init to fail
>   platform/x86/intel/pmc: Cleanup SSRAM discovery
>   platform/x86/intel/pmc/mtl: Use return value from
>     pmc_core_ssram_init()
>   platform/x86/intel/pmc: Find and register PMC telemetry entries
>   platform/x86/intel/pmc: Add debug attribute for Die C6 counter
>   platform/x86/intel/pmc: Show Die C6 counter on Meteor Lake
> 
> Gayatri Kammela (1):
>   platform/x86/intel/vsec: Add intel_vsec_register
> 
> Rajvi Jingar (1):
>   platform/x86/intel/pmc: Display LPM requirements for multiple PMCs
> 
> Xi Pardee (3):
>   platform/x86:intel/pmc: Call pmc_get_low_power_modes from platform
>     init
>   platform/x86/intel/pmc: Retrieve LPM information using Intel PMT
>   platform/x86/intel/pmc: Read low power mode requirements for MTL-M and
>     MTL-P

Thank you for your patch-series, I've applied the series to my
review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans



> 
>  drivers/platform/x86/intel/pmc/Kconfig      |   1 +
>  drivers/platform/x86/intel/pmc/adl.c        |   2 +
>  drivers/platform/x86/intel/pmc/cnp.c        |   2 +
>  drivers/platform/x86/intel/pmc/core.c       | 185 +++++++++-----
>  drivers/platform/x86/intel/pmc/core.h       |  10 +-
>  drivers/platform/x86/intel/pmc/core_ssram.c | 265 +++++++++++++++++---
>  drivers/platform/x86/intel/pmc/icl.c        |  10 +-
>  drivers/platform/x86/intel/pmc/mtl.c        |  87 ++++++-
>  drivers/platform/x86/intel/pmc/spt.c        |  10 +-
>  drivers/platform/x86/intel/pmc/tgl.c        |   1 +
>  drivers/platform/x86/intel/pmt/class.c      |  43 +++-
>  drivers/platform/x86/intel/pmt/class.h      |  30 ++-
>  drivers/platform/x86/intel/pmt/crashlog.c   |   2 +-
>  drivers/platform/x86/intel/pmt/telemetry.c  | 193 +++++++++++++-
>  drivers/platform/x86/intel/pmt/telemetry.h  | 126 ++++++++++
>  drivers/platform/x86/intel/vsec.c           | 131 +++++-----
>  drivers/platform/x86/intel/vsec.h           |  45 +++-
>  17 files changed, 939 insertions(+), 204 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/pmt/telemetry.h
> 
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86

