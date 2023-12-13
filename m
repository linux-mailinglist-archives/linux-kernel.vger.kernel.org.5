Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2625811D36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379118AbjLMSq1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 13:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbjLMSqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:46:25 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE83DD0;
        Wed, 13 Dec 2023 10:46:30 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9db2f1ddfso1100933a34.0;
        Wed, 13 Dec 2023 10:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493190; x=1703097990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eqe4Mh3qR58kwRD8SpcpKlRGfJ7NRdTpc3KPCByCcM4=;
        b=PU925o7+mPwLStQbjQSKkq2sR+OtxwHto5CDmNUjIDzJb0MLdMrvc4o1VCUOvbIcWa
         uSehxvM3cz7wFkT7LFYw51KfewON2xScOdinnQefWRrLUgNQt/ZQyVepRRXglAVdd6H6
         uWmLHp7EphJqHy0Klzez7Zo07z0Tk0BMFtnepb5J+edf4Vr9v/+y4zQLZgy0/ZaZXT4A
         bqJcGgzVy4P50t/w3+QRMzo88lF6s/lnEs/bBWseTtMMywIcMsyQNTRjp2ljkns9svFO
         MwBuOAXPFS9snFv7jMxl0cjx+0ZqI0OEgP0tW53RYqjgKJ7v6WqwrtvjhSSEg+D/v7Qm
         b/jA==
X-Gm-Message-State: AOJu0Yxlt8ezSeK/ZRJTRNU8aG3WgIh7CgBeVQb07+GxunX4sK8U5/xa
        4KLtPxsa+UoiVIwZT29sDGS5NsEWI3qR5FpdPaA=
X-Google-Smtp-Source: AGHT+IGU8FPJkW9jgsuuJcY9YfNkpue7mAJKpZYttJycAVz8Nh9LhTV5zHtMszZAi3NZPOmPuy0VR7UUkJBLWKXWE/w=
X-Received: by 2002:a05:6870:f6aa:b0:1e9:8ab9:11ca with SMTP id
 el42-20020a056870f6aa00b001e98ab911camr14648275oab.3.1702493190158; Wed, 13
 Dec 2023 10:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20231213182656.6165-1-mario.limonciello@amd.com>
 <20231213182656.6165-3-mario.limonciello@amd.com> <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
 <766d621c-695d-4ae7-87cf-690cb8d066df@amd.com>
In-Reply-To: <766d621c-695d-4ae7-87cf-690cb8d066df@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 19:46:19 +0100
Message-ID: <CAJZ5v0i95EeS40pzkBH=jgB1wbMP6SNO_s=pNZ8FPOtcMywgAA@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at shutdown
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpearson-lenovo@squebb.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 7:42 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/13/2023 12:38, Rafael J. Wysocki wrote:
> > On Wed, Dec 13, 2023 at 7:27 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> When a system is being powered off it's important that PCIe ports
> >> have been put into D3cold as there is no other software to turn
> >> off the devices at S5.
> >>
> >> If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
> >> power resources may be left enabled and devices may consume excess
> >> power.
> >
> > Isn't that a platform firmware issue?
> >
> > It is the responsibility of the platform firmware to properly put the
> > platform into S5, including power removal from devices that are not
> > armed for power-on.
>
> The specific issues that triggered this series were tied to the PCIe
> ports for dGPUs.  There is a GPIO that is toggled by _ON or _OFF.
>
> Windows calls _OFF as part of S5..

I see.

> >
> >> Cc: mpearson-lenovo@squebb.ca
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/pci/pcie/portdrv.c | 11 ++++++++---
> >>   1 file changed, 8 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> >> index 14a4b89a3b83..08238680c481 100644
> >> --- a/drivers/pci/pcie/portdrv.c
> >> +++ b/drivers/pci/pcie/portdrv.c
> >> @@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
> >>   static void pcie_portdrv_shutdown(struct pci_dev *dev)
> >>   {
> >>          if (pci_bridge_d3_possible(dev)) {
> >> -               pm_runtime_forbid(&dev->dev);
> >> -               pm_runtime_get_noresume(&dev->dev);
> >> -               pm_runtime_dont_use_autosuspend(&dev->dev);
> >> +               /* whole hierarchy goes into a low power state for S5 */
> >> +               if (system_state == SYSTEM_POWER_OFF) {
> >> +                       pci_set_power_state(dev, PCI_D3cold);
> >> +               } else {
> >> +                       pm_runtime_forbid(&dev->dev);
> >> +                       pm_runtime_get_noresume(&dev->dev);
> >> +                       pm_runtime_dont_use_autosuspend(&dev->dev);
> >> +               }
> >>          }
> >
> > Wouldn't it be better to remove power from the port after running the
> > code below?
> >
>
> Yes; I think you're right.  I'll do some more testing with this.
>
> >>          pcie_port_device_remove(dev);
> >> --

IIRC, to do this all properly, you'd need to rework the shutdown path
to look like the hibernation power-off one.  Or even use the latter
for shutdown?

There was no reason to do that till now, so it has not been done, but
it looks like you have one.
