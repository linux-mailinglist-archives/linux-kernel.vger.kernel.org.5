Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF303811287
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379141AbjLMNIJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 08:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379083AbjLMNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:08:08 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AF3B2;
        Wed, 13 Dec 2023 05:08:11 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59158202d22so58389eaf.0;
        Wed, 13 Dec 2023 05:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702472890; x=1703077690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfzhlsnoq9Ysoezun43pMBPmJAkFvJFC0eB1jMYm89g=;
        b=LLSJ6rosSw0zGs1doQW5MzW1mS2bWTmK+S29GsQkQNM+ma2nfzKcj/UaaACJoRA5pk
         4nrkPN+Xp2/NXZk4UoOcO36Eq95buwJWC6qlmI8zZSApH4ftqx2pHYkVUvCe0DF8VOVV
         +HOWZp7/kgunTBIntjL7Ngh7O0xPqruUx4Zjw0LojUUJTe3zsosTLdeVlDsakrmiXl2t
         P2Ds+qwXH816LRDucarCJyfATuYMc0EU1ovclGcAew009zUeLQdoK9i0amrbencM2pZ4
         58NYDIegCsDoVw1HS5YARNE0aFYfYzc3VVj8aEtp4fVlf5qnmt7EuwZk2RR7x+Dj3VYK
         2vgw==
X-Gm-Message-State: AOJu0Yyaywyq6fLLDllCRHOVFiHKjkWaTU7BYP1iRlCp5n8QLmvMx+Uq
        E4/1SiSJ/x7w84JbFe/FICVcF5RKjPEVl6J/PxA=
X-Google-Smtp-Source: AGHT+IEksZOaTrdaIJm4lcb85oyK5X2mMVWwsxlOxVmkTgEU6wD3nKcf13Ky+z3N80hZuRCQiIgW0WBLZWxvZNYNM94=
X-Received: by 2002:a05:6871:892:b0:203:1727:c6b with SMTP id
 r18-20020a056871089200b0020317270c6bmr2841209oaq.5.1702472890600; Wed, 13 Dec
 2023 05:08:10 -0800 (PST)
MIME-Version: 1.0
References: <20231213003614.1648343-1-imammedo@redhat.com> <20231213003614.1648343-3-imammedo@redhat.com>
In-Reply-To: <20231213003614.1648343-3-imammedo@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Dec 2023 14:07:59 +0100
Message-ID: <CAJZ5v0gowV0WJd8pjwrDyHSJPvwgkCXYu9bDG7HHfcyzkSSY6w@mail.gmail.com>
Subject: Re: [RFC 2/2] PCI: acpiphp: slowdown hotplug if hotplugging multiple
 devices at a time
To:     Igor Mammedov <imammedo@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, mika.westerberg@linux.intel.com,
        boris.ostrovsky@oracle.com, joe.jin@oracle.com,
        stable@vger.kernel.org, Fiona Ebner <f.ebner@proxmox.com>,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 1:36 AM Igor Mammedov <imammedo@redhat.com> wrote:
>
> previous commit ("PCI: acpiphp: enable slot only if it hasn't been enabled already"
> introduced a workaround to avoid a race between SCSI_SCAN_ASYNC job and
> bridge reconfiguration in case of single HBA hotplug.
> However in virt environment it's possible to pause machine hotplug several
> HBAs and let machine run. That can hit the same race when 2nd hotplugged
> HBA will start re-configuring bridge.
> Do the same thing as SHPC and throttle down hotplug of 2nd and up
> devices within single hotplug event.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 6b11609927d6..30bca2086b24 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -37,6 +37,7 @@
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> +#include <linux/delay.h>
>
>  #include "../pci.h"
>  #include "acpiphp.h"
> @@ -700,6 +701,7 @@ static void trim_stale_devices(struct pci_dev *dev)
>  static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>  {
>         struct acpiphp_slot *slot;
> +        int nr_hp_slots = 0;
>
>         /* Bail out if the bridge is going away. */
>         if (bridge->is_going_away)
> @@ -723,6 +725,10 @@ static void acpiphp_check_bridge(struct acpiphp_bridge *bridge)
>
>                         /* configure all functions */
>                         if (slot->flags != SLOT_ENABLED) {
> +                               if (nr_hp_slots)
> +                                       msleep(1000);

Why is 1000 considered the most suitable number here?  Any chance to
define a symbol for it?

And won't this affect the cases when the race in question is not a concern?

Also, adding arbitrary timeouts is not the most robust way of
addressing race conditions IMV.  Wouldn't it be better to add some
proper synchronization between the pieces of code that can race with
each other?

> +
> +                                ++nr_hp_slots;
>                                 enable_slot(slot, true);
>                         }
>                 } else {
> --
