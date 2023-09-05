Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B169792FD5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242312AbjIEUVp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 16:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbjIEUVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:21:45 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3675CC;
        Tue,  5 Sep 2023 13:21:38 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5711d5dac14so691528eaf.0;
        Tue, 05 Sep 2023 13:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693945298; x=1694550098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gqmUDO2TVzPYAnNQVahrjzI0bVUxc1RvWHpjYvgFhjI=;
        b=guTnggz4CJWrCcc/2lWfqP61U0I6fs9HTHB/LYgyUdgC/DGm2iCFt/OTKq0iAgjlYk
         arnk0Y1xtkqCLQXc27iAnNPBOmE4jDu8iAPVYDcM2qo6v2R1ki/K23PPtjWPUahgqcZ1
         z0zfaNlj96MSU0fx8C70VFoJvjskb7M17yLQIQBi8ak1tsdR0UbivyAGNyghu8PiUig5
         8FuX7eBi2aC5cXpXURKK6bCKwTk6eGQRj6lWlJmq0hLUadkS/feoBULJMD0psyBIHBWp
         MywjVeMUA3CQ3NoZol94WvX1Wk3C8VeQJo3monXWGKiynhEX2uMYP1lu+BnoGnLGQSdH
         TMdA==
X-Gm-Message-State: AOJu0Ywg00EyERbtB7RPBPkAlm2ucrf8knpltiPi4CCyHmS+HbFKkrZW
        8fQrBtIv2CIz2fAZXIFV3TQvJPOQlmzrdX56VmY=
X-Google-Smtp-Source: AGHT+IF+rVWTTtREO43KaXIUg4yrMf2Rqt/lXRG7d75/4KbLqE0xzo29kqTQemqewyg7UZEZ0Bs76jRlTcDqrHolj1w=
X-Received: by 2002:a4a:de43:0:b0:573:2a32:6567 with SMTP id
 z3-20020a4ade43000000b005732a326567mr11610639oot.0.1693945297813; Tue, 05 Sep
 2023 13:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230829171212.156688-1-mario.limonciello@amd.com>
 <20230829171212.156688-4-mario.limonciello@amd.com> <ceda84a0-e5cd-f6dc-3e3c-52e85fda8318@amd.com>
 <ead0bc03-2008-96d8-c313-5dc4a9e63479@redhat.com> <f1c65b21-88cb-4ba3-8380-0d2d3fb42c8d@amd.com>
In-Reply-To: <f1c65b21-88cb-4ba3-8380-0d2d3fb42c8d@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Sep 2023 22:21:26 +0200
Message-ID: <CAJZ5v0iqn=Pj1k4=u5Mb9PyYeB471Efob5rUiEBchbUrJeL=rg@mail.gmail.com>
Subject: Re: [PATCH v16 3/3] platform/x86/amd: pmc: Don't let PCIe root ports
 go into D3
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Iain Lane <iain@orangesquash.org.uk>, rafael@kernel.org
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

On Tue, Sep 5, 2023 at 9:57 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 9/5/2023 05:15, Hans de Goede wrote:
> > Hi Shyam,
> >
> > On 9/5/23 12:08, Shyam Sundar S K wrote:
> >>
> >>
> >> On 8/29/2023 10:42 PM, Mario Limonciello wrote:
> >>> commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >>> changed pci_bridge_d3_possible() so that any vendor's PCIe ports
> >>> from modern machines (>=2015) are allowed to be put into D3.
> >>>
> >>> Iain reports that USB devices can't be used to wake a Lenovo Z13
> >>> from suspend. This is because the PCIe root port has been put
> >>> into D3 and AMD's platform can't handle USB devices waking from
> >>> a hardware sleep state in this case.
> >>>
> >>> This problem only occurs on Linux, and only when the AMD PMC driver
> >>> is utilized to put the device into a hardware sleep state. Comparing
> >>> the behavior on Windows and Linux, Windows doesn't put the root ports
> >>> into D3.
> >>>
> >>> A variety of approaches were discussed to change PCI core to handle this
> >>> case generically but no consensus was reached. To limit the scope of
> >>> effect only to the affected machines introduce a workaround into the
> >>> amd-pmc driver to only apply to the PCI root ports in affected machines
> >>> when going into hardware sleep.
> >>>
> >>> Link: https://lore.kernel.org/linux-pci/20230818193932.27187-1-mario.limonciello@amd.com/
> >>> Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
> >>> Reported-by: Iain Lane <iain@orangesquash.org.uk>
> >>> Closes: https://forums.lenovo.com/t5/Ubuntu/Z13-can-t-resume-from-suspend-with-external-USB-keyboard/m-p/5217121
> >>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >>
> >> See if this change can be moved to pmc-quirks.c, besides that change
> >> looks good to me. Thank you.
> >>
> >> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> >
> > Thank you for the review.
> >
> > I also just replied to this series (to the cover-letter)
> > with an alternative approach based on making the
> > XHCI driver call pci_d3cold_disable() on the XHCI
> > PCIe-device on affected AMD chipsets.
> >
> > That seems like a cleaner approach to me. I wonder
> > if you have any remarks about that approach ?
> >
>
> I was thinking more about Hans' comments to the cover letter as well as
> Shyam's comments to move it into pmc-quirks.c.
>
> Perhaps it would better be conveying what's going on by having a
> dedicated step that amd-pmc calls pci_choose_state() for each PCIe
> device and checks the value against the constraints.  If "any" of them
> are mismatched it could emit a message.  This is a little bit of
> duplication though because drivers/acpi/x86/s2idle.c already also emits
> a similar message for some devices when pm_debug_messages is enabled.
>
> Then the special case would be for PCIe root ports that are mismatched
> the driver overrides it.  If this logic change is wouldn't make sense
> for it to be moved into pmc-quirks.c.
>
> I don't think using pci_d3cold_disable() / pci_d3cold_enable() is
> correct though.  If PCI core stays the same it should still be setting
> pdev->bridge_d3 to zero.  The problem isn't with D3cold on the PCIe RP
> at s2didle, it's with D3hot.

Well, it's not even that.

If there were no devices expected to wake up the system from sleep
under the given Root Port, it might very well go into D3hot IIUC, so
the wakeup capability seems to be the key property here.

I need to think a bit more about this.
