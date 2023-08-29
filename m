Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A4678C839
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbjH2PCt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237196AbjH2PCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:02:42 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D4D7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:02:39 -0700 (PDT)
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-573128cd77dso655121eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693321359; x=1693926159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tg11HWGAMJyZ5xNwqiXTPMFRwTAyQHacInf9vI4DNow=;
        b=T8xk0m9QhSzEiCF/BjDjmFe5jAPgJXsIgPeapm3A3WfVEbB8fBzwVJaB5AJvB9dh3k
         7hdqNqaanO44hy6Wc7cZl0gF+z7tX7ouWOYwHtQasGYN2ZvthjSqZX2seaGhFkqMni2I
         +ima3UXCLuq8bfpPW/0+DWdKSIUfyAeSds7aaPQFxbKc4+QfG5cI7D6TC0gGW2LokCwY
         L3x9tT7zlE9XkC12As5keg2CWZRuiqrfhA/XKJm615MCDaqz/Jgc6GbL7ijvtgaLMFSa
         zbBBI7uBZYyhBcM8wOrv9SHqO27NNnsPZTInhnTDXs8OwLQqUkh/C8QsRCVVEhynyyCd
         k/8w==
X-Gm-Message-State: AOJu0YzcxXWhYPv32z1+YFvWMJ2dqoVSwFykniIaejjBZUKOtC40qTbg
        VOaiTIJ9fEFVoSr7UkWH0YBDuckrcTyWxVNzPK4=
X-Google-Smtp-Source: AGHT+IF4+SHtfK77EnfVwgu40smU3Uoa6dA0aToOqCPXX/B1e7mHEzeVhB4l/DRr3Ia07AnK8a0FKcWL7wb4NFeeiaI=
X-Received: by 2002:a4a:e741:0:b0:56e:94ed:c098 with SMTP id
 n1-20020a4ae741000000b0056e94edc098mr28837171oov.0.1693321358973; Tue, 29 Aug
 2023 08:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
 <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
 <3fd2e62d-0aa9-1098-3eb3-ed45460a3580@intel.com> <CAJZ5v0hnNK4O_HyinvTp01YxXR7V4vzpMhf85yW9M2=52-O2Fg@mail.gmail.com>
 <60bea4fb-9044-76f1-fe2b-ddc35c526d5c@intel.com> <CAJZ5v0hkNFof_Wy0FmPAizuOT9WPEEPW+R27UCgERhS1ZKjOBw@mail.gmail.com>
 <6a50e2c7-a73b-ff02-3e36-e7477ea7dc4d@intel.com> <24860c20-0e08-46d6-8016-5cbbb97b4550@roeck-us.net>
In-Reply-To: <24860c20-0e08-46d6-8016-5cbbb97b4550@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 17:02:27 +0200
Message-ID: <CAJZ5v0ihBuCbojjOCV-kW-Gjo_nCP6EvpALwKUoyX36wypyiog@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Wilczynski, Michal" <michal.wilczynski@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Tue, Aug 29, 2023 at 4:53 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Aug 29, 2023 at 04:38:33PM +0200, Wilczynski, Michal wrote:
> >
> [ ... ]
> > For the fix:
> > Acked-by: Michal Wilczynski <michal.wilczynski@intel.com>
> >
>
> Or just drop it. From Ard Biesheuvel's e-mail sent to 0-day:

Yeah.

>     > Hello all,
>     >
>     > The Linux community is currently in the process of deprecating the
>     > Itanium IA-64 architecture, which no longer has a maintainer or any
>     > actual users.
>     >
>     > We aim to remove it entirely from the Linux tree before the end of the
>     > year, but one of the first steps is to stop build testing it - there
>     > is really no point any longer in spending any cycles on this, and it
>     > is definitely undesirable to inform developers by email if their
>     > changes result in any build issues on IA-64.
>     >
>     > So please remove IA64 from the set of architectures that are build
>     > tested by LKP.
>
> This is from the 0-day commit log disabling ia64 build tests. I have now
> disabled ia64 in my build tests as well.
>
> Sorry for the noise.

No worries, thanks!
