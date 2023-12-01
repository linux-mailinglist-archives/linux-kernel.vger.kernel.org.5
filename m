Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E88208017C9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjLAXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjLAXck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:32:40 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBEF1B3
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 15:32:45 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso1785a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 15:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701473564; x=1702078364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV5uhcImpYZYLCdUkoeP3r7sBoYZjOiiQKMRj55t5hc=;
        b=WGFooB6BSrh84UqezzkZ23T8tDq+GUOM9cIRIU5AguO1dDjIYmHGwqQNQbGm0Wh9u/
         GfCYQjC7u1oisTNzu8oUbH+s7bjEIdVf8otp6ffkfeJQz7s5QH5IaBcH4cfHpbMsMyt5
         lHBaLNZzEZL7Y0LOSLOa6n0NkzM85XFBrkuOwEltR6P4+Fvzuvm8dV/7ie/2CSlHs9Mm
         XLs5ToNfaQDYTbFKcTVKA0fPoCWBpV4tHCt8aLshdxaR+LhbgZU7NSnPvvpdhVwwQvOq
         J6kTHuSdL1y9Yx+7II9IV4giwK2a9R16g+ZplJCLN5/B8oAWbcj41tuenZtwsbPZPvv2
         CgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701473564; x=1702078364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV5uhcImpYZYLCdUkoeP3r7sBoYZjOiiQKMRj55t5hc=;
        b=wxd7+Sthbm35dcRmhIwi9oI8+JDN4m5i4bAilLgn9vEZZ3DWksjHZ+vYgOseJWfec2
         MWjeGYrhbLeLHE1gQ+uXKCDh2CHlK/9RAubNX3RMIIKLZ2d0wHrclvGdceEigfB6zO4H
         9ge0LrKnaH7MsXDZzyNlwUv6yoXgompDXJN7TZbwF9DWH3c3Z6kvp3mXHLfKr2sujFDf
         68XpIdT9Z+Np7JEqIe6J4TJU18j4pFTKYAQclC8I5TDddq7CX5vXVXHVFIW8K/ypizsN
         DwNywV6uI4QXGqSquNPkUzxpNygMFm6CX2HzMgFRvQH6YRZdWSYywzlnYq5MP0fQxPXY
         xTfg==
X-Gm-Message-State: AOJu0Yxl4e/yY2jHp05vx7ezcKiZUUItlx4I4QaHr0XpuBBQdSVL5WwQ
        ry1j/PpWW/35hqgf8VhSOM3g4w8O8MrNSAkTshsP7qoWC/sZNmLsafgZAw==
X-Google-Smtp-Source: AGHT+IHmPguEghSIYXqCsBQPQ2ZN/jm+K8ZgKbasQmFx9q4vfElB7Hw4oobr2dwU7UEE1KN+/nfIILKzHx7LZzLl3ng=
X-Received: by 2002:a50:9514:0:b0:544:e2b8:ba6a with SMTP id
 u20-20020a509514000000b00544e2b8ba6amr193332eda.3.1701473563773; Fri, 01 Dec
 2023 15:32:43 -0800 (PST)
MIME-Version: 1.0
References: <169953729188.3135.6804572126118798018.tip-bot2@tip-bot2>
 <20231122221947.781812-1-jsperbeck@google.com> <1e565bb08ebdd03897580a5905d1d2de01e15add.camel@intel.com>
 <904ce2b870b8a7f34114f93adc7c8170420869d1.camel@intel.com>
In-Reply-To: <904ce2b870b8a7f34114f93adc7c8170420869d1.camel@intel.com>
From:   John Sperbeck <jsperbeck@google.com>
Date:   Fri, 1 Dec 2023 15:32:31 -0800
Message-ID: <CAFNjLiWK-h_OSP8Q9JyoLfsoDXo=ih27AFbVVXqzzwNkPVQKTg@mail.gmail.com>
Subject: Re: [tip: x86/urgent] x86/acpi: Ignore invalid x2APIC entries
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "tip-bot2@linutronix.de" <tip-bot2@linutronix.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 1, 2023 at 12:32=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Thu, 2023-11-23 at 20:50 +0800, Exchange Online wrote:
> > Hi, John,
> >
> > Thanks for catching this issue.
> >
> > On Wed, 2023-11-22 at 22:19 +0000, John Sperbeck wrote:
> > > I have a platform with both LOCAL_APIC and LOCAL_X2APIC entries for
> > > each CPU.  However, the ids for the LOCAL_APIC entries are all
> > > invalid ids of 255, so they have always been skipped in
> > > acpi_parse_lapic()
> > > by this code from f3bf1dbe64b6 ("x86/acpi: Prevent LAPIC id 0xff
> > > from
> > > being
> > > accounted"):
> > >
> > >     /* Ignore invalid ID */
> > >     if (processor->id =3D=3D 0xff)
> > >             return 0;
> > >
> > > With the change in this thread, the return value of 0 means that
> > > the
> > > 'count' variable in acpi_parse_entries_array() is incremented.  The
> > > positive return value means that 'has_lapic_cpus' is set, even
> > > though
> > > no entries were actually matched.
> >
> > So in acpi_parse_madt_lapic_entries, without this patch,
> > madt_proc[0].count is a positive value on this platform, right?
> >
> > This sounds like a potential issue because the following checks to
> > fall
> > back to MPS mode can also break. (If all LOCAL_APIC entries have
> > apic_id 0xff and all LOCAL_X2APIC entries have apic_id 0xffffffff)
> >
> > >   Then, when the MADT is iterated
> > > with acpi_parse_x2apic(), the x2apic entries with ids less than 255
> > > are skipped and most of my CPUs aren't recognized.
> > >
> > > I think the original version of this change was okay for this case
> > > in
> > > https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/
> >
> > Yeah.
> >
> > But if we want to fix the potential issue above, we need to do
> > something more.
> >
> > Say we can still use acpi_table_parse_entries_array() and convert
> > acpi_parse_lapic()/acpi_parse_x2apic() to
> > acpi_subtable_proc.handler_arg and save the real valid entries via
> > the
> > parameter.
> >
> > or can we just use num_processors & disabled_cpus to check if there
> > is
> > any CPU probed when parsing LOCAL_APIC/LOCAL_X2APIC entires?
> >
>
> Hi, John,
>
> As a quick fix, I'm not going to fix the "potential issue" describes
> above because we have not seen a real problem caused by this yet.
>
> Can you please try the below patch to confirm if the problem is gone on
> your system?
> This patch falls back to the previous way as sent at
> https://lore.kernel.org/lkml/87pm4bp54z.ffs@tglx/T/
>
> thanks,
> rui
>
> From bdb45e241b4fea8a12b958e490979e96b064e43d Mon Sep 17 00:00:00 2001
> From: Zhang Rui <rui.zhang@intel.com>
> Date: Fri, 1 Dec 2023 15:06:34 +0800
> Subject: [PATCH] x86/acpi: Do strict X2APIC ID check only when an enabled=
 CPU
>  is enumerated via LAPIC
>
> Commit 8e9c42d776d6 ("x86/acpi: Ignore invalid x2APIC entries") does
> strict X2APIC ID check if LAPIC contains valid CPUs by checking the
> acpi_table_parse_madt() return value.
>
> This is wrong because acpi_table_parse_madt() return value only
> represents the number of legal entries parsed. For example, LAPIC entry
> with LAPIC ID 0xff is counted as a legal entry, but it doesn't describe
> a valid CPU.
>
> This causes issues on a system which has 0xff LAPIC ID in all LAPIC
> entries. Because the code does strict X2APIC IDs check and ignores most
> of the CPUs in X2APIC entries.
>
> Fix the problem by doing strict X2APIC ID check less aggressively, say
> only when an enabled CPU is enumerated via LAPIC.
>
> Fixes: 8e9c42d776d6 ("x86/acpi: Ignore invalid x2APIC entries")
> Link: https://lore.kernel.org/all/20231122221947.781812-1-jsperbeck@googl=
e.com/
> Reported-by: John Sperbeck <jsperbeck@google.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  arch/x86/kernel/acpi/boot.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index 1a0dd80d81ac..8cc566ce486a 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -266,6 +266,7 @@ static int __init
>  acpi_parse_lapic(union acpi_subtable_headers * header, const unsigned lo=
ng end)
>  {
>         struct acpi_madt_local_apic *processor =3D NULL;
> +       int cpu;
>
>         processor =3D (struct acpi_madt_local_apic *)header;
>
> @@ -289,9 +290,13 @@ acpi_parse_lapic(union acpi_subtable_headers * heade=
r, const unsigned long end)
>          * to not preallocating memory for all NR_CPUS
>          * when we use CPU hotplug.
>          */
> -       acpi_register_lapic(processor->id,      /* APIC ID */
> -                           processor->processor_id, /* ACPI ID */
> -                           processor->lapic_flags & ACPI_MADT_ENABLED);
> +       cpu =3D acpi_register_lapic(processor->id,        /* APIC ID */
> +                                 processor->processor_id, /* ACPI ID */
> +                                 processor->lapic_flags & ACPI_MADT_ENAB=
LED);
> +
> +       /* Do strict X2APIC ID check only when an enabled CPU is enumerat=
ed via LAPIC */
> +       if (cpu >=3D 0 )
> +               has_lapic_cpus =3D true;
>
>         return 0;
>  }
> @@ -1134,7 +1139,6 @@ static int __init acpi_parse_madt_lapic_entries(voi=
d)
>         if (!count) {
>                 count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_APIC=
,
>                                         acpi_parse_lapic, MAX_LOCAL_APIC)=
;
> -               has_lapic_cpus =3D count > 0;
>                 x2count =3D acpi_table_parse_madt(ACPI_MADT_TYPE_LOCAL_X2=
APIC,
>                                         acpi_parse_x2apic, MAX_LOCAL_APIC=
);
>         }
> --
> 2.34.1
>

Yes, with that patch, the problem is gone on my system.  All of the
CPUs are recognized and active.

Before the patch (only one CPU active):

    # cat /proc/cpuinfo | grep '^processor' | wc -l
    1

With the patch (all CPUs active):

    oxco8:~# cat /proc/cpuinfo | grep '^processor' | wc -l
    112
