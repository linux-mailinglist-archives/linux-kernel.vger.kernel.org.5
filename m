Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC70F811CD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjLMSjw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 13:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjLMSjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:39:48 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B02114;
        Wed, 13 Dec 2023 10:39:54 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-203223f3299so44920fac.0;
        Wed, 13 Dec 2023 10:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492794; x=1703097594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m+/AL0R3+aA7WOxQr9yHHYdULaoe12ig01cSaDeUGDc=;
        b=IUvOWKBLzc9adzCGq3yvDaD17koxl9bHLd0GAIZemaL36hqeFZrmtWof0Y9nEWKp5B
         iUv8rA4VbOxMyZIDjfJgw/wbNjFjtxXzl+Uh5cNQad7Ya5ow3l5PJ9N0Q0D2HpbQ6O63
         oSKfhdtoRE0ozGJRHW34ZZiMbE0u06ekc6Wsw6LBCKZ06Y0Q57bQEm2DHtbntOEYBCpm
         lPfliH4Kuz7Grw6L9ORe5COF0QuQ7cP04QGArRiVs2uaNzKUFmcMMdFDKV1tRPbaIExS
         Bu0c9w2TvJg7c+baUlAtvU0M01F5GeepUAqMKt6SmcW+IuyPwTTPoPCNPdtrciThd4Gq
         Gkng==
X-Gm-Message-State: AOJu0YwOZqu2TV+E2ytOYDKNpM0jLzhvCJ1H8iLOmfLty68OcoGVwVt1
        tmJX6iAOrSggMkK/h1ToicGEkwBkX4W5F+qjPUXuAMhr
X-Google-Smtp-Source: AGHT+IFNZW9AKxuCJch1eTxTfiEHdcy4y6jtGxcFPvT8BDR51E7N/mJ5WPOgEv9SIzxNGcWZxMIHFU4b7HF+Wvjfdyw=
X-Received: by 2002:a05:6871:7589:b0:1fa:db26:78a6 with SMTP id
 nz9-20020a056871758900b001fadb2678a6mr16005887oac.1.1702492793859; Wed, 13
 Dec 2023 10:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20231213182656.6165-1-mario.limonciello@amd.com>
 <20231213182656.6165-2-mario.limonciello@amd.com> <CAJZ5v0g0j2fpaHUdvxAkfo-3bRp=GRrKOgespUnz_BqX6timOw@mail.gmail.com>
 <d03fd5a4-4f22-45e3-94b1-7ba735ea196f@amd.com>
In-Reply-To: <d03fd5a4-4f22-45e3-94b1-7ba735ea196f@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 19:39:43 +0100
Message-ID: <CAJZ5v0jMNiYVb6Zv2BHTQs64sHxbn42kyJFyXHn2QwAMV+02ww@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: Avoid runtime resuming devices if system is
 shutting down
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

On Wed, Dec 13, 2023 at 7:33 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> On 12/13/2023 12:31, Rafael J. Wysocki wrote:
> > On Wed, Dec 13, 2023 at 7:27 PM Mario Limonciello
> > <mario.limonciello@amd.com> wrote:
> >>
> >> When the system is going to S5 resuming devices is unnecessary at
> >> best and may cause problems for power consumption at S5 at worst.
> >>
> >> Check the target `system_state` in the pci driver shutdown() callback
> >> and skip the runtime resume step if the system is being powered off.
> >>
> >> Cc: mpearson-lenovo@squebb.ca
> >> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> >> ---
> >>   drivers/pci/pci-driver.c | 4 +++-
> >>   1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> >> index 51ec9e7e784f..5a6f7a786952 100644
> >> --- a/drivers/pci/pci-driver.c
> >> +++ b/drivers/pci/pci-driver.c
> >> @@ -507,7 +507,9 @@ static void pci_device_shutdown(struct device *dev)
> >>          struct pci_dev *pci_dev = to_pci_dev(dev);
> >>          struct pci_driver *drv = pci_dev->driver;
> >>
> >> -       pm_runtime_resume(dev);
> >> +       /* If system will go to S5, don't wake up PCI devices for shutdown */
> >> +       if (system_state != SYSTEM_POWER_OFF)
> >> +               pm_runtime_resume(dev);
> >
> > What's the guarantee that the driver's shutdown callback will not
> > access MMIO regions of a runtime-suspended device?
>
> This is something that may need to be audited.
>
> I have an expectation that drivers will runtime resume a device before
> they try to access it.

But they don't need to do it, because the core does it right now,
which is my point.
