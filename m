Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1878136FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjLNQyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:54:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjLNQyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:54:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28CD9128
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702572846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMqA7655Z3p8MOMWi6x4CyiogFMNXMtt8stH7qzpZwU=;
        b=FYu5gmAgVyadl9THwJlKeO+Zr1sNuNT5mXpuj90RoLG/2mtZAZHoCgPVoiMDFeN8hOlw0N
        0SDAJoqw9F5msgM0/39Rak4r7+xzXUCKTONYxW5MD1eDInOvDZih1Z/JAKh74IaIlC99Sk
        sdglY6lF28jmZlXhir+EzsMeuxYBuZA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-p3Np9I8VMEKyluQtsQFSkA-1; Thu, 14 Dec 2023 11:54:02 -0500
X-MC-Unique: p3Np9I8VMEKyluQtsQFSkA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a1eb3f3dc2eso236343466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702572841; x=1703177641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMqA7655Z3p8MOMWi6x4CyiogFMNXMtt8stH7qzpZwU=;
        b=a4l8a5VN97i6XpLaFrnIRwDirvn7p9y5GCrrNl4GxWEmNqrhkeDavJ1Iq8ECot9qwh
         Mn5lIeBpbT/4pt4Hq8V5G2I+maeBKN74qgvbhfdmV20Kz6xViUxO43Kq+LEiDb/Tuj6V
         G1ACofOGZJlRsoSm/CysAjsUJsYb5qZHrWdznTHaxFoF+9aB8MYIbpZfRzt+SmSdtENm
         sYSmUJ2BHrr8OMvgfj04rNcSQl2RBpVc7s02Xif+8GrlkGcNOLZ3EpFXsUnLQko0cnlB
         c1GQhOeByQveJY0VW+osF8IVC5PaTez5Qb/6IbPqjgvBT6Lscfxa4bRNvfGFxiWQqRi2
         V+8Q==
X-Gm-Message-State: AOJu0Yzso6vb2epYQOu40JG53O3HobsSVViHmVmdEZdBU46CDC42/gX8
        p431Hn8CZJZtYc17tclLXyGCH5G7nINmddgr1Sk6Fpu+nplyAtcfw8MHjFIO8U3yBuuHLi2eMFd
        IWdU6h9LDy7+UIqnkMDHxv5EK
X-Received: by 2002:a17:907:72d6:b0:a1b:68e6:9d4c with SMTP id du22-20020a17090772d600b00a1b68e69d4cmr5493501ejc.71.1702572841655;
        Thu, 14 Dec 2023 08:54:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkqFrfc5jBUV2ddMjDS7NjtGh4X75LNMmDt+o23cAiZ+j+A+ROIBUzQ7WNqeOu4c4r3qRznA==
X-Received: by 2002:a17:907:72d6:b0:a1b:68e6:9d4c with SMTP id du22-20020a17090772d600b00a1b68e69d4cmr5493495ejc.71.1702572841330;
        Thu, 14 Dec 2023 08:54:01 -0800 (PST)
Received: from redhat.com ([2.52.132.243])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a1df88cc7c0sm9514218ejc.182.2023.12.14.08.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:54:00 -0800 (PST)
Date:   Thu, 14 Dec 2023 11:53:55 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Igor Mammedov <imammedo@redhat.com>,
        Fiona Ebner <f.ebner@proxmox.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Jonathan Woithe <jwoithe@just42.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] Revert "PCI: acpiphp: Reassign resources on bridge if
 necessary"
Message-ID: <20231214115156-mutt-send-email-mst@kernel.org>
References: <20231214165102.1093961-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214165102.1093961-1-helgaas@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 10:51:02AM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> This reverts commit 40613da52b13fb21c5566f10b287e0ca8c12c4e9 and the
> subsequent fix to it:
> 
>   cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
> 
> 40613da52b13 fixed a problem where hot-adding a device with large BARs
> failed if the bridge windows programmed by firmware were not large enough.
> 
> cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources()
> only for non-root bus") fixed a problem with 40613da52b13: an ACPI hot-add
> of a device on a PCI root bus (common in the virt world) or firmware
> sending ACPI Bus Check to non-existent Root Ports (e.g., on Dell Inspiron
> 7352/0W6WV0) caused a NULL pointer dereference and suspend/resume hangs.
> 
> Unfortunately the combination of 40613da52b13 and cc22522fd55e caused other
> problems:
> 
>   - Fiona reported that hot-add of SCSI disks in QEMU virtual machine fails
>     sometimes.
> 
>   - Dongli reported a similar problem with hot-add of SCSI disks.
> 
>   - Jonathan reported a console freeze during boot on bare metal due to an
>     error in radeon GPU initialization.
> 
> Revert both patches to avoid adding these problems.  This means we will
> again see the problems with hot-adding devices with large BARs and the NULL
> pointer dereferences and suspend/resume issues that 40613da52b13 and
> cc22522fd55e were intended to fix.
> 
> Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> Fixes: cc22522fd55e ("PCI: acpiphp: Use pci_assign_unassigned_bridge_resources() only for non-root bus")
> Reported-by: Fiona Ebner <f.ebner@proxmox.com>
> Closes: https://lore.kernel.org/r/9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com
> Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> Closes: https://lore.kernel.org/r/3c4a446a-b167-11b8-f36f-d3c1b49b42e9@oracle.com
> Reported-by: Jonathan Woithe <jwoithe@just42.net>
> Closes: https://lore.kernel.org/r/ZXpaNCLiDM+Kv38H@marvin.atrad.com.au
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: <stable@vger.kernel.org>
> Cc: Igor Mammedov <imammedo@redhat.com>


It's up to you whether to apply the revert - hopefully a fix can be
developed soon. The revert itself looks like it's done correctly so from
that POV:

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 601129772b2d..5b1f271c6034 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -512,15 +512,12 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  				if (pass && dev->subordinate) {
>  					check_hotplug_bridge(slot, dev);
>  					pcibios_resource_survey_bus(dev->subordinate);
> -					if (pci_is_root_bus(bus))
> -						__pci_bus_size_bridges(dev->subordinate, &add_list);
> +					__pci_bus_size_bridges(dev->subordinate,
> +							       &add_list);
>  				}
>  			}
>  		}
> -		if (pci_is_root_bus(bus))
> -			__pci_bus_assign_resources(bus, &add_list, NULL);
> -		else
> -			pci_assign_unassigned_bridge_resources(bus->self);
> +		__pci_bus_assign_resources(bus, &add_list, NULL);
>  	}
>  
>  	acpiphp_sanitize_bus(bus);
> -- 
> 2.34.1

