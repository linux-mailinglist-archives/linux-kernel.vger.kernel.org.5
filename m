Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B3A7FF01E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjK3N2g convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Nov 2023 08:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjK3N2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:28:33 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3610D9;
        Thu, 30 Nov 2023 05:28:39 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3b89d4be037so157501b6e.0;
        Thu, 30 Nov 2023 05:28:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701350919; x=1701955719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UocFr9z4iBYyzRXWEBLNC0QmTk2pcl3A0aXeddwo3SQ=;
        b=VbZu3znvnO27Ks+92eHrYRlRgs3zUT7rCqpFp7K/vz0bK1FmUYgmqYqfuff1Q9THfU
         lXVuzcSaLYC/pQslvSzX9TLUOuVgyzXIhUozwsw65eY8TTqrccwSVgKIVXrhhRl8aBwO
         7xzZQdg9XKyv9+CAsb6WTAoF4TzDEfwfWDqrxH3vmQdRRMPwh/07UjKEYOzIudCl70fh
         dGd6GB3rQa+BuUH+LYJbugo8qm0hpHj8cUntTwnEHJkqIWi94WeU3ONliHcgy8n1m5sq
         x/WmVjbr74iFTnmarwP1za/UwnW2WqFBlDkFVuKKOkFnKm0RfJiqq9Y8dzbtbF3z5C4x
         tSbg==
X-Gm-Message-State: AOJu0YyDR4RCadRzgVEsKLn0qcYWdIWiQhxsWKOyVykIUutthvJ5OE2D
        PifZj0vARmiCCwvKPbbxEVpvB1dLTavDC+GnjW8=
X-Google-Smtp-Source: AGHT+IHbe+EuMC7tz0BG+NmkODy+LOXAd+jgG74MCtOA93Kp5766n5r0h8pso5WKmDjan7SbkpqpYsbsC5uxq0bs/qg=
X-Received: by 2002:a05:6808:2016:b0:3ae:5650:c6ae with SMTP id
 q22-20020a056808201600b003ae5650c6aemr2258178oiw.0.1701350919037; Thu, 30 Nov
 2023 05:28:39 -0800 (PST)
MIME-Version: 1.0
References: <5745568.DvuYhMxLoT@kreacher> <20231129085600.GQ1074920@black.fi.intel.com>
In-Reply-To: <20231129085600.GQ1074920@black.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 30 Nov 2023 14:28:27 +0100
Message-ID: <CAJZ5v0iRqUXeuKmC_+dAJtDBLWQ3x15n4gRH48y7MEaLoXF+UA@mail.gmail.com>
Subject: Re: [RFT][PATCH v1] ACPI: OSL: Use a threaded interrupt handler for SCI
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
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

Hi Mika,
Hi Mario,

On Wed, Nov 29, 2023 at 11:39 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Mon, Nov 27, 2023 at 08:57:43PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > In the current arrangement, all of the acpi_ev_sci_xrupt_handler() code
> > is run as an interrupt handler for the SCI, in interrupt context.  Among
> > other things, this causes it to run with local interrupts off which
> > can be problematic if many GPEs are enabled and they are located in the
> > I/O address space, for example (because in that case local interrupts
> > will be off for the duration of all of the GPE hardware accesses carried
> > out while handling an SCI combined and that may be quite a bit of time
> > in extreme scenarios).
> >
> > However, there is no particular reason why the code in question really
> > needs to run in interrupt context and in particular, it has no specific
> > reason to run with local interrupts off.  The only real requirement is
> > to prevent multiple instences of it from running in parallel with each
> > other, but that can be achieved regardless.
> >
> > For this reason, use request_threaded_irq() instead of request_irq() for
> > the ACPI SCI and pass IRQF_ONESHOT to it in flags to indicate that the
> > interrupt needs to be masked while its handling thread is running so as
> > to prevent it from re-triggering while it is being handled (and in
> > particular until the final handled/not handled outcome is determined).
> >
> > While at it, drop a redundant local variable from acpi_irq().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > The code inspection and (necessarily limited) testing carried out by me
> > are good indications that this should just always work, but there may
> > be still some really odd platform configurations I'm overlooking, so if
> > you have a way to give it a go, please do so.
>
> Tried this on ADL-S and ADL-P systems that I have here and both work
> just fine with the patch applied. I can see SCI interrupt count
> increases in /proc/interrupts as expected. Did a couple of s2idle cycles
> too, all good.
>
> Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Thanks for your replies and tags!

Given the lack of response from anyone else I'm going to move this
towards linux-next with 6.8 as the target.

Thank you!
