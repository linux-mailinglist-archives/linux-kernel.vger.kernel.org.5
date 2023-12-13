Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E599E811CC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjLMSiZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 13:38:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjLMSiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:38:20 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B12EB;
        Wed, 13 Dec 2023 10:38:26 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3b8652c0bd2so597302b6e.1;
        Wed, 13 Dec 2023 10:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492705; x=1703097505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0e9RjRusvtUVL36p2n3yW7GJ2o7hpTev/itTbWI7rc=;
        b=I+144M8ftMJAreRe6xPQdj8vySNi6X+sVzPXn/7rfWVT3Uqaqqc3p/so2G6F1PcJGL
         coXDHRWDq8Q9j6jdkpe3mk7MyrKhVPWB5CQTOVDxetL+1z7VvRffHUbMupj6iB5OTjZe
         PoCFKBHEauATKOLo2+EW4ads35M65l87tOEZ49UREEoo8YnGSCAAlFiMYw26X1gy1FF4
         xMc1wNyy3v5gsoiPXHj3+CGAGuhAT+FUL0b9QdW3TF1OQCdcSTgFUcS8Fk2PetN7XSrj
         nN3khOc8/ZMD5hfS8faPi+wLLNzLNL7kMSsydRIU3XmXxjsnHvi7XGaKlaQFb0zKV77I
         RrfA==
X-Gm-Message-State: AOJu0YwZ8PXGmkN0TVH316Dsc3+yQW8E9sckAgx8xPhDi6l0ymNiQy4C
        T74oy57enJe6CXqyLxBEgsVHwyYez26ltbEnNkqy/eFS
X-Google-Smtp-Source: AGHT+IHZKVn3E0ZO3joLhJTb7yWJ8MSomiP1GSk6a/ctZVcvYzFC2WbOfEHp3TQd+tiK5vgLIEir+LilwP7Rt6ratOc=
X-Received: by 2002:a05:6870:1484:b0:1fa:f0ee:ba9c with SMTP id
 k4-20020a056870148400b001faf0eeba9cmr16236627oab.2.1702492705309; Wed, 13 Dec
 2023 10:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20231213182656.6165-1-mario.limonciello@amd.com> <20231213182656.6165-3-mario.limonciello@amd.com>
In-Reply-To: <20231213182656.6165-3-mario.limonciello@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 19:38:14 +0100
Message-ID: <CAJZ5v0gDjwEpx-WNSY0=qchoSGxizsD3XM7Bgq=i0xufBm=Cag@mail.gmail.com>
Subject: Re: [PATCH 2/2] PCI/portdrv: Place PCIe port hierarchy into D3cold at shutdown
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpearson-lenovo@squebb.ca
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

On Wed, Dec 13, 2023 at 7:27 PM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> When a system is being powered off it's important that PCIe ports
> have been put into D3cold as there is no other software to turn
> off the devices at S5.
>
> If PCIe ports are left in D0 then any GPIOs toggled by the ACPI
> power resources may be left enabled and devices may consume excess
> power.

Isn't that a platform firmware issue?

It is the responsibility of the platform firmware to properly put the
platform into S5, including power removal from devices that are not
armed for power-on.

> Cc: mpearson-lenovo@squebb.ca
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/pcie/portdrv.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index 14a4b89a3b83..08238680c481 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -734,9 +734,14 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  static void pcie_portdrv_shutdown(struct pci_dev *dev)
>  {
>         if (pci_bridge_d3_possible(dev)) {
> -               pm_runtime_forbid(&dev->dev);
> -               pm_runtime_get_noresume(&dev->dev);
> -               pm_runtime_dont_use_autosuspend(&dev->dev);
> +               /* whole hierarchy goes into a low power state for S5 */
> +               if (system_state == SYSTEM_POWER_OFF) {
> +                       pci_set_power_state(dev, PCI_D3cold);
> +               } else {
> +                       pm_runtime_forbid(&dev->dev);
> +                       pm_runtime_get_noresume(&dev->dev);
> +                       pm_runtime_dont_use_autosuspend(&dev->dev);
> +               }
>         }

Wouldn't it be better to remove power from the port after running the
code below?

>         pcie_port_device_remove(dev);
> --
