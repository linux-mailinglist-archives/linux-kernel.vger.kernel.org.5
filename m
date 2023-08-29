Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881D078C77F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236737AbjH2OZj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236952AbjH2OZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:25:28 -0400
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F8B8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:25:26 -0700 (PDT)
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5711d5dac14so1079154eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693319125; x=1693923925;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slVU9y0NIUcKqh+rvfytdKjvWokkjQBx++Ns5euVOJw=;
        b=a8ZGmamtuh8dxYrUC2y6gv0UZmyTpUgnHYfWZ6GRyihCspUFPwthnYO8O4Gu+peoeJ
         FEgwxp+dzihHcdN9xWWTx9FwHdyZqGlMBGALY9K0vNu2US0RDcAl+DLLbnw/Djy9M4UQ
         FMCNuu/382ZELWYaK/KXr70INcR5eFoiUIaywMOe/8ANHXtj7tBTEw01WPM/lR/u+qpJ
         TPjk/BhbOhTuglLT7DCW/ZJbJGvRjnco+JT1gL/J3yanZlZvMh6Vd4bCSUNLc/U2KM/Z
         E9Xv3UKs2PJM+lYk4Dnas75HewxZFgV74bD4y/u1xICEy2YVfp/JgTGzfKDP1dxbnJZx
         Z+Vg==
X-Gm-Message-State: AOJu0YzhpUiC7fY41vXKRg6AM6X/K1LlFVRW+e9VUX6LvkVNcgmS8qVi
        9rzs9tO/CBGBcAG1SdF8FPHl3PaJxx0u9HgxvwY=
X-Google-Smtp-Source: AGHT+IHcZezc7yobT1YMg3glSh/f3kmFE+K9JowqEnz36TjMF4/WF8EEw6ttct9RDz0rELaqC6kB7Pgth5aVK/MHWqo=
X-Received: by 2002:a4a:d137:0:b0:571:1906:47f0 with SMTP id
 n23-20020a4ad137000000b00571190647f0mr17186721oor.1.1693319125328; Tue, 29
 Aug 2023 07:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
 <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com> <CAJZ5v0hnNK4O_HyinvTp01YxXR7V4vzpMhf85yW9M2=52-O2Fg@mail.gmail.com>
 <60bea4fb-9044-76f1-fe2b-ddc35c526d5c@intel.com>
In-Reply-To: <60bea4fb-9044-76f1-fe2b-ddc35c526d5c@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 16:25:13 +0200
Message-ID: <CAJZ5v0hkNFof_Wy0FmPAizuOT9WPEEPW+R27UCgERhS1ZKjOBw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
To:     "Wilczynski, Michal" <michal.wilczynski@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        andriy.shevchenko@intel.com, artem.bityutskiy@linux.intel.com,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, lenb@kernel.org, jgross@suse.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
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

On Tue, Aug 29, 2023 at 4:21 PM Wilczynski, Michal
<michal.wilczynski@intel.com> wrote:
>
>
>
> On 8/29/2023 4:03 PM, Rafael J. Wysocki wrote:
> > On Tue, Aug 29, 2023 at 3:58 PM Wilczynski, Michal
> > <michal.wilczynski@intel.com> wrote:
> >>
> >>
> >> On 8/29/2023 3:54 PM, Rafael J. Wysocki wrote:
> >>> On Tue, Aug 29, 2023 at 3:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>>> On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
> >>>>> Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
> >>>>> introduced a workaround for MWAIT for a specific x86 system.
> >>>>>
> >>>>> Move the code outside of acpi_processor.c to acpi/x86/ directory for
> >>>>> consistency and rename the functions associated with it, so their names
> >>>>> start with "acpi_proc_quirk_" to make the goal obvious.
> >>>>>
> >>>>> No intentional functional impact.
> >>>>>
> >>>> Except for:
> >>>>
> >>>> ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
> >>>> acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
> >>>> ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
> >>>> processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'
> >>>>
> >>>> which breaks all ia64 builds.
> >>>>
> >>>> Time to retire that architecture yet ? No one but me seems to even
> >>>> build test it.
> >>> Including 0-day it seems.  This had been in linux-next for several weeks.
> >>>
> >>> Michal, can you have a look at this please?
> >> Hi,
> >> I'll take a look and get back to you with a fix,
> > Actually, if I'm not mistaken, the attached patch should be sufficient.
>
> Exactly, adding this empty stub will make sure there is no linker error, this function
> is relevant only for x86 anyway.
>
> If ia64 support for 0-day was turned off then I think it was rather recently, cause I've
> seen it working I think back in May.
>
> To be honest I'm not sure what is being done in such cases ? Will you send a fix to Linus
> directly, or should I prepare a patch and sent in on the list ??

I'll add a changelog to the fix, post it and merge it directly, so you
don't need to do anything (other than ACKing the fix if you will).
