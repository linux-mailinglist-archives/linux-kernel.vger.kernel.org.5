Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A5778C683
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236473AbjH2NzF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 29 Aug 2023 09:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbjH2Nyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:54:32 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4B9BD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:54:29 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-573128cd77dso645023eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693317269; x=1693922069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Hqp5g8vcCPM7sTxDxg2xv+zoph4aaW7wr9kh3juDcU=;
        b=Rzl9k1jaxEMlZTylv1RAtmCWHJXu/2wPvkeCq6wO4GBy3Ylufg7bOvxqMS+JetLTfa
         aoPQOnTskDtL6B8vNpYvk5n8WvShFzrUMDuucdv49z5j0fT7dN80BTB8mERSiSDuv9rT
         gu3aTd28uuTbf4wUnUmqVYCk2ZS8Co99ZUsF3g0KTSr6F1vXnEN2a3n6+Xm7dA+X0NuB
         qpC5ooa+NomwyMA7wb4qw83b0QFmkDXfQbkqf4lDQG0EEDekweZKgLbY2x/B8huh+MQa
         vVgol0RR0ltMuodEwHLtAcGg/Ky09ixiYZfE27klkquSx6EXnWKyDufcLLbnzPkyGwiA
         LNYQ==
X-Gm-Message-State: AOJu0YypZN2Spv20/pDSZPHG4kit2xQ6ln6c5F2zeNevdKdhhlCGnDQT
        javefjr6NsdNv7qmPA7unzlldQR3k8upbDocVtaOeqba
X-Google-Smtp-Source: AGHT+IHZ34rKCf0cjfGK4NnMByhXn99fQMCRnhBDnrDBsSCKWhcUSkm71B96oaHZKTTRXBaK2GnNAeH3aVP/lyc4Q8s=
X-Received: by 2002:a4a:da10:0:b0:56e:6532:467a with SMTP id
 e16-20020a4ada10000000b0056e6532467amr26577258oou.1.1693317269222; Tue, 29
 Aug 2023 06:54:29 -0700 (PDT)
MIME-Version: 1.0
References: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
In-Reply-To: <c7a05a44-c0be-46c2-a21d-b242524d482b@roeck-us.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 29 Aug 2023 15:54:18 +0200
Message-ID: <CAJZ5v0jASjc_RYp-SN5KMGJXDv8xbMOqJscLF3wG8rdE2_KJGw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor: Move MWAIT quirk out of acpi_processor.c
To:     Guenter Roeck <linux@roeck-us.net>,
        Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     rafael@kernel.org, andriy.shevchenko@intel.com,
        artem.bityutskiy@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, lenb@kernel.org,
        jgross@suse.com, linux-kernel@vger.kernel.org, x86@kernel.org,
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

On Tue, Aug 29, 2023 at 3:44 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Jul 10, 2023 at 05:03:29PM +0300, Michal Wilczynski wrote:
> > Commit 2a2a64714d9c ("ACPI: Disable MWAIT via DMI on broken Compal board")
> > introduced a workaround for MWAIT for a specific x86 system.
> >
> > Move the code outside of acpi_processor.c to acpi/x86/ directory for
> > consistency and rename the functions associated with it, so their names
> > start with "acpi_proc_quirk_" to make the goal obvious.
> >
> > No intentional functional impact.
> >
>
> Except for:
>
> ia64-linux-ld: drivers/acpi/acpi_processor.o: in function `acpi_early_processor_control_setup':
> acpi_processor.c:(.init.text+0x712): undefined reference to `acpi_proc_quirk_mwait_check'
> ia64-linux-ld: drivers/acpi/processor_pdc.o: in function `acpi_early_processor_set_pdc':
> processor_pdc.c:(.init.text+0x72): undefined reference to `acpi_proc_quirk_mwait_check'
>
> which breaks all ia64 builds.
>
> Time to retire that architecture yet ? No one but me seems to even
> build test it.

Including 0-day it seems.  This had been in linux-next for several weeks.

Michal, can you have a look at this please?
