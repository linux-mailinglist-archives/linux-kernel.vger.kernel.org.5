Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B494794359
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243971AbjIFS4v convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Sep 2023 14:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242595AbjIFS4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:56:46 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EC2B2;
        Wed,  6 Sep 2023 11:56:42 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-57328758a72so20129eaf.1;
        Wed, 06 Sep 2023 11:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694026601; x=1694631401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H+p9MajhuuC+jQSjXUpPnxzX3BliCqyqGbtUZGaR1Og=;
        b=UAhbPQfD9Am/EiRuhD/yfOiuUO6v+B612Wm17qN+J0kom/RVFhUjNOlsSgYh4RfRQh
         69EZfgrKUUxQv88TV9rLJ/LEW/T2RfNV4k2A9nDmX/9C2/TgP4N4r6GCrVBkk9CWrLk/
         snzxU5QWaExNj3IqFkEZpN4GLo0ef8SqVlKEtuK3uf051ouNPCETrh8N81HJSFo3Q0YN
         ZyVOrKr2OFnwwkkAXHIDRiemeEzgSuGn4d94HOldKGU3EISZqGF6GJLznAdGO9T/OxH6
         n2hCIdPDz9JZFqQTuMf+ZWRWsulWZwX+EqWc01C3dUAUKxJnPIL+l1+dgsNOJgPRcUoQ
         eLVQ==
X-Gm-Message-State: AOJu0YykDDrjC9n7An1aV+avVkC82GPEr8Tr5HPVMkZETcnljuuDM64P
        DEGO/U5KFo85fDZe6x43Ga6quUm2U5a6GyMMuOc=
X-Google-Smtp-Source: AGHT+IEnTCXHTnvSxV/PuVIsLZoEDIiAjSX7hqopdPwCmtnVZhamzfE9sBGnob8UG/4mAPdGpT+nhxnTBJQ1uokqiMI=
X-Received: by 2002:a4a:cf17:0:b0:571:1906:47f0 with SMTP id
 l23-20020a4acf17000000b00571190647f0mr15728590oos.1.1694026600837; Wed, 06
 Sep 2023 11:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <6ce36e6e-726a-69f3-882c-0790d311eee1@redhat.com> <4c80cda2-82e4-4eb3-99c5-f2be3bfa96ed@amd.com>
 <fbd1369e-1738-3346-19ad-e291da491f12@redhat.com>
In-Reply-To: <fbd1369e-1738-3346-19ad-e291da491f12@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 6 Sep 2023 20:56:29 +0200
Message-ID: <CAJZ5v0gSUwysQChe1K7CZSZhMbD0m3S27HFe7HwXSdfrMoNq6Q@mail.gmail.com>
Subject: Re: [PATCH v16 0/3] Avoid PCIe D3 for AMD PCIe root ports
To:     Hans de Goede <hdegoede@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     bhelgaas@google.com, rafael@kernel.org, Shyam-sundar.S-k@amd.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
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

On Wed, Sep 6, 2023 at 2:24 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Mario,
>
> On 9/5/23 14:45, Mario Limonciello wrote:
> > On 9/5/2023 05:13, Hans de Goede wrote:
> >> Hi Mario,
> >>
> >> On 8/29/23 19:12, Mario Limonciello wrote:
> >>> D3 on PCIe root ports isn't used on Windows systems in Modern Standby.
> >>> This series adjusts the amd-pmc driver to choose the same strategy
> >>> for Rembrandt and Phoenix platforms in Linux with s2idle.
> >>>
> >>> LPS0 constraints are the basis for it; which if they are added for
> >>> Windows would also apply for Linux as well.
> >>>
> >>> This version doesn't incorporate a callback, as it's pending feedback
> >>> from Bjorn if that approach is amenable.
> >>>
> >>> NOTE:
> >>> This series relies upon changes that are both in linux-pm.git and
> >>> platform-x86.git. So it won't be able to apply to either maintainer's
> >>> tree until later.
> >>>
> >>> Mario Limonciello (3):
> >>>    ACPI: x86: s2idle: Export symbol for fetching constraints for module
> >>>      use
> >>>    platform/x86/amd: pmc: Adjust workarounds to be part of a switch/case
> >>>    platform/x86/amd: pmc: Don't let PCIe root ports go into D3
> >>
> >> Thank you for the new version.
> >>
> >> I understand you wanted to get this new approach "out there" but
> >> this does not address my remarks on v15:
> >>
> >> https://lore.kernel.org/platform-driver-x86/53d26a63-64f3-e736-99f5-32bf4b5ba31d@redhat.com/
> >>
> >
> > Right; I called out in the cover letter this is pending feedback from Bjorn.
> >
> >> Bjorn, I suggest to allow platform code to register a callback
> >> to influence pci_bridge_d3_possible() results there. Can you
> >> take a look at this and let us know what you think of this
> >> suggestion ?
> >>
> >> Looking at this problem again and rereading the commit message
> >> of "platform/x86/amd: pmc: Don't let PCIe root ports go into D3"
> >>
> >> I see that the problem is that the PCIe root ports to which
> >> the USB controllers connect should not be allowed to go
> >> into D3 when an USB child of them is configured to wakeup
> >> the system.
> >>
> >> It seems to me that given that problem description,
> >> we should not be directly messing with the bridge_d3
> >> setting at all.
> >>
> >> Instead the XHCI code should have an AMD specific quirk
> >> where it either unconditionally calls pci_d3cold_disable()
> >> on the XHCI PCIe device; or it could even try to be smart
> >> and call pci_d3cold_enable() / pci_d3cold_disable()
> >> from its (runtime)suspend handler depending on if any
> >> USB child is configured as a system wakeup source.
> >>
> >> Note that it is safe to repeatedly call pci_d3cold_enable()
> >> / _disable() there is no need to balance the calls.
> >>
> >
> > It's only the PCIe root port that is used for XHCI tunneling that has this issue.  This specific problem is NOT for the root port of "any" AMD XHCI controllers.  There is no problem with any of the XHCI controllers
> > going into D3hot.
>
> "XHCI tunneling" is an unfamiliar term for me. Are we talking about a XHCI controller inside a USB4/thunderbold dock here which is connected to the laptop over PCIe tunneling over thunderbolt ?
>
> Or do you mean the XHCI controller inside the laptop which is connected to a USB4/thunderbolt capable Type-C port which is used when that port is in USB3/USB2 mode ?
>
> As long as the XHCI controller is inside the laptop (and not in the dock), presumably you can identify it by say a set of PCI device-ids of the "tunneling" XHCI controllers on affected AMD platforms. So you could then still call pci_d3cold_disable() from the XHCI driver on only those controllers.
>
> Note I'm not saying this is the best solution. I'm just trying to understand what you mean with " the PCIe root port that is used for XHCI tunneling" .
>
> I also see that Rafael has said elsewhere in the thread that he needs to think a bit about how to best handle this ...

Yes, I have, and that's because of the realization that the
requirements may differ depending on whether or not there is a device
(USB or other) enabled to wake up the system from sleep under the Root
Port in question.

Essentially, the problem is that wakeup doesn't work and the
investigation led to the Root Port's power state when suspended, but
that power state only appears to be too deep for the wakeup to work
and not in general.

IIUC, the port can be safely programmed into D3hot and then back to D0
and that works as long as there are no wakeup devices under it (Mario,
please correct me if that's not the case).

Now, when a USB device on the bus segment under the port is configured
for system wakeup, it needs to be able to trigger a wake interrupt
when the system is in the sleep state.  That wake interrupt is not
generated by the USB wakeup device itself, but by the USB controller
handling it.  The USB controller is a PCIe device, so in order to
generate a wake interrupt it needs the link to its parent port to be
up unless it is capable of generating PMEs from D3cold (which only is
the case when it is connected to a separate wake power source and that
is indicated by setting the corresponding bit in its PM Capabilities
Register).  If that is not the case, and its parent port is programmed
into D3hot, that may cause the link between them to go down and so the
wake interrupt cannot be generated.  This means that the port which is
generally allowed to go into D3hot (because why not), may not be
allowed to do so if system wakeup devices are present under it and
that appears to be the missing piece to me.
