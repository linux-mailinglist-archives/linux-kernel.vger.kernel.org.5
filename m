Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C59810E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235261AbjLMKHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235245AbjLMKHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:07:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B775BA4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702462055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YdSkfSCIDP93EM+mxv9M+W9x4jK0YGjz6e+tBs7DUUU=;
        b=MJrFESsmgsStJEVeQGRSzw7jSqJQqakgDZoantISfiynw2zw0mbrN+96N/bb5freDVH7vw
        /rgAGd4tnm8dL73Lr9XoqCpKSFExQSRtDYDgJ6x6T/HDFX7p/L5h8tRKvCdd1odmkUxiVO
        t0cc3VsTZmt2bXpBE9MqrULdvlbDfF0=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-YRdPC44IOpKpBtEIZCAt8Q-1; Wed, 13 Dec 2023 05:07:33 -0500
X-MC-Unique: YRdPC44IOpKpBtEIZCAt8Q-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-50bf00775ecso6556950e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 02:07:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702462052; x=1703066852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdSkfSCIDP93EM+mxv9M+W9x4jK0YGjz6e+tBs7DUUU=;
        b=P76wslrW8yyiTYA6ywpVV+7F29Admz1mXZno6tev+M5sx+bQOBRwFdU2Zf0e1Lu3hv
         apc0KpI7v3oRhKGH0o9m3LtzaLOyOxgwX1EDu4H4k5kaNEf5+DS89of465+5TLAnqjue
         KA4nZCUrdT4LVGkqRZRpiK1+1mshzG28oJotpmEsvTzm11wqB3UrTPkI5/tDzV8PFGbz
         iH1oC9uDXwdxdRR3iVyzpQIXPlVhhDAhYMC/BtH3V0XIYfj5Q8iEcujE0t4HfKERsbCH
         Oo1ezdEL3sG9bNcvFSjDsNpYuNX8jdpm6qGOOuf0RGbOIl68Ll7HNZ0KwuGgWuyrL8M+
         TlFw==
X-Gm-Message-State: AOJu0Yz/B4JyFhMkfXrV/l/G3wvVIRJoMzfwq8rx2bCDuCkm3cFCMmPB
        daIJ0Zlos/DWi3goLjNi2W9EcMLePdwYlyQGqGsNK0ww1+IG0GcQLm7752L/6iQyhqgEZQJxiX9
        YA9MxzIlHjEnOuRXZ83xVmoNZ
X-Received: by 2002:a05:6512:104d:b0:50b:f380:5fad with SMTP id c13-20020a056512104d00b0050bf3805fadmr4913037lfb.87.1702462052209;
        Wed, 13 Dec 2023 02:07:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkYdiiq48AtFlXavTGhK5TgEnQUjes08MTe0tzKUxfAO2LnnNyQQT8kV1vdp+a/90HJ+pTfA==
X-Received: by 2002:a05:6512:104d:b0:50b:f380:5fad with SMTP id c13-20020a056512104d00b0050bf3805fadmr4913025lfb.87.1702462051861;
        Wed, 13 Dec 2023 02:07:31 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5-20020ac25f45000000b0050bf06c8098sm1590674lfz.116.2023.12.13.02.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:07:31 -0800 (PST)
Date:   Wed, 13 Dec 2023 11:07:29 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Fiona Ebner <f.ebner@proxmox.com>
Cc:     linux-kernel@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        mst@redhat.com, rafael@kernel.org, lenb@kernel.org,
        bhelgaas@google.com, mika.westerberg@linux.intel.com,
        boris.ostrovsky@oracle.com, joe.jin@oracle.com,
        stable@vger.kernel.org, Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: [RFC 1/2] PCI: acpiphp: enable slot only if it hasn't been
 enabled already
Message-ID: <20231213110729.3845f530@imammedo.users.ipa.redhat.com>
In-Reply-To: <501c1078-ef45-4469-87f8-32525d6f2608@proxmox.com>
References: <20231213003614.1648343-1-imammedo@redhat.com>
        <20231213003614.1648343-2-imammedo@redhat.com>
        <501c1078-ef45-4469-87f8-32525d6f2608@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 10:47:27 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 13.12.23 um 01:36 schrieb Igor Mammedov:
> > When SCSI_SCAN_ASYNC is enabled (either via config or via cmd line),
> > adding device to bus and enabling it will kick in async host scan
> > 
> >  scsi_scan_host+0x21/0x1f0
> >  virtscsi_probe+0x2dd/0x350
> >  ..
> >  driver_probe_device+0x19/0x80
> >  ...
> >  driver_probe_device+0x19/0x80
> >  pci_bus_add_device+0x53/0x80
> >  pci_bus_add_devices+0x2b/0x70
> >  ...
> > 
> > which will schedule a job for async scan. That however breaks
> > if there are more than one SCSI host behind bridge, since
> > acpiphp_check_bridge() will walk over all slots and try to
> > enable each of them regardless of whether they were already
> > enabled.
> > As result the bridge might be reconfigured several times
> > and trigger following sequence:
> > 
> >   [cpu 0] acpiphp_check_bridge()
> >   [cpu 0]   enable_slot(a)
> >   [cpu 0]     configure bridge
> >   [cpu 0]     pci_bus_add_devices() -> scsi_scan_host(a1)
> >   [cpu 0]   enable_slot(b)
> >   ...
> >   [cpu 1] do_scsi_scan_host(a1) <- async jib scheduled for slot a
> >   ...
> >   [cpu 0]     configure bridge <- temporaly disables bridge
> > 
> > and cause do_scsi_scan_host() failure.
> > The same race affects SHPC (but it manages to avoid hitting the race due to
> > 1sec delay when enabling slot).
> > To cover case of single device hotplug (at a time) do not attempt to
> > enable slot that have already been enabled.
> > 
> > Fixes: 40613da52b13 ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > Reported-by: Dongli Zhang <dongli.zhang@oracle.com>
> > Reported-by: iona Ebner <f.ebner@proxmox.com>  
> 
> Missing an F here ;)

Sorry for copypaste mistake, I'll fix it up on the next submission.

> 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>  
> 
> Thank you! Works for me:
> 
> Tested-by: Fiona Ebner <f.ebner@proxmox.com>
> 

