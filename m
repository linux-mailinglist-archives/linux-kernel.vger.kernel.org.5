Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF725808B27
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjLGOz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:55:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbjLGOzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:55:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB701AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 06:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701960947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tz6X+bifKo7AdaGetM0WimZ3DgQEAXtIAzsWo7qdtOo=;
        b=cP8F50TJrcWNT4Yt49TEXroAwvYOeC5avlf6Ysv/iCnfpMNufj+zciNSHiEnSmyA5ZjmiR
        dDk22abrzF8J1kOB6/5tO/EL+/eRPdZqvqZKos7H3DsMzyFAyW/t7maYqjRo/c+7Z8rpcU
        MQdUI9sW6tbuDMptR8MOcZsGHER/zWE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-qJx2lqYlOqqC5CV3-CNYXA-1; Thu, 07 Dec 2023 09:55:45 -0500
X-MC-Unique: qJx2lqYlOqqC5CV3-CNYXA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40c193fca81so9292045e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 06:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701960944; x=1702565744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tz6X+bifKo7AdaGetM0WimZ3DgQEAXtIAzsWo7qdtOo=;
        b=khyjGY6qpPjNvHCJQqDVppbNpQ1VdYnCUWaSUdDUqoZyEb7JG7Oyk1v9b3GrHhmhY5
         EZZQUF+EBEwyLNRHYHkyirT8r6fP6+k+oF8iqJpz0GnB/ITujSw6C90OCT+AIvmsTw64
         FsClH8zJydydrmSolkOiTKlbZSIu7vQSOn1SgkGwRdhruyUYlrpVxiMzN+I6AZmWul7c
         Ay6gx0zUmPbTF/nUWzZ+KI9Zne5heRcrVArog+4JLSUN7qN9+mOmV3KkMiDfg4EuaKfv
         aSSWeu7O+cw+n4biQorIzp0qbmw3VSz/+tGg0Qm/Wr5ACMlnsT+KDmCrVUsSmn+dcy4b
         xTxw==
X-Gm-Message-State: AOJu0YxxUhcSAECU/kHgBcASMNtnrHGoJOEYrLRoP+vdww44kw/ooAcl
        SxKoW46h1KBb1trupmWpOWPdXNXNmD+m2phfRXVD6seqvA/8i8Sf1fUKPMQWIQsNRZLowUUJs2F
        ps5DfHQeGcF4VOJPz4GXsQw7O
X-Received: by 2002:a05:600c:198b:b0:40b:5e21:dd34 with SMTP id t11-20020a05600c198b00b0040b5e21dd34mr2068548wmq.98.1701960943988;
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqPu0jtkLU9hMN3uH/bMY5VhR71AQ+5SLWqCAxzRD+0Q/xUOdmx8munOvaO4iPnv+olLoNZQ==
X-Received: by 2002:a05:600c:198b:b0:40b:5e21:dd34 with SMTP id t11-20020a05600c198b00b0040b5e21dd34mr2068529wmq.98.1701960943567;
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906208300b00a1e04f24df1sm918499ejq.223.2023.12.07.06.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 06:55:43 -0800 (PST)
Date:   Thu, 7 Dec 2023 15:55:41 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Fiona Ebner <f.ebner@proxmox.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231207155541.735e0055@imammedo.users.ipa.redhat.com>
In-Reply-To: <4dbc72ba-8edb-4ff5-b95d-b601189e4415@proxmox.com>
References: <20231130231802.GA498017@bhelgaas>
        <4dbc72ba-8edb-4ff5-b95d-b601189e4415@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2023 10:24:41 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 01.12.23 um 00:18 schrieb Bjorn Helgaas:
> > On Wed, Nov 29, 2023 at 04:22:41PM +0100, Fiona Ebner wrote:  
> >> Hi,
> >> it seems that hot-plugging SCSI disks for QEMU virtual machines booting
> >> with UEFI and with guest kernels >= 6.5 might be broken. It's not
> >> consistently broken, hinting there might be a race somewhere.
> >>
> >> Reverting the following two commits seems to make it work reliably again:
> >>
> >> cc22522fd55e2 ("PCI: acpiphp: Use
> >> pci_assign_unassigned_bridge_resources() only for non-root bus")
> >> 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary"
> >>
> >> Of course, they might only expose some pre-existing issue, but this is
> >> my best lead. See below for some logs and details about an affected
> >> virtual machine. Happy to provide more information and to debug/test
> >> further.  
> > 
> > Shoot.  Thanks very much for the report and your debugging.  I'm
> > hoping Igor will chime in with some ideas.
> > 
> > Both of those commits appeard in v6.5 and fixed legit issues, so I
> > hate to revert them, but this does appear to be a regression.
> > 
> > #regzbot introduced: cc22522fd55e2 ^
> > #regzbot introduced: 40613da52b13f ^
> >   
> >> Host kernel: 6.5.11-4-pve which is based on the one from Ubuntu
> >> Guest kernel: 6.7.0-rc3 and 6.7.0-rc3 with above commits reverted
> >> QEMU version: v8.1.0 built from source
> >> EDK2 version: submodule in the QEMU v8.1 repository: edk2-stable202302
> >>  
> 
> I should mention that I haven't run into the issue when booting the VM
> with SeaBIOS yet.
> 
> Log for 6.7.0-rc3 + SeaBIOS (bundled with QEMU 8.1):
> 
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xfd404000-0xfd407fff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xfe801000-0xfe801fff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > Dec 01 10:08:08 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > Dec 01 10:08:08 hotplug kernel: scsi host3: Virtio SCSI HBA
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> > Dec 01 10:08:08 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
> > Dec 01 10:08:08 hotplug kernel: scsi 3:0:0:1: Attached scsi generic sg1 type 0
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk  
> 
> Interestingly, the line with "QEMU HARDDISK" does not come after all
> lines with "bridge window" like was the case for the one time it did
> work with UEFI. So maybe that was just a red herring.

I've just seen this,
let me try to reproduce and see what can be done with it.

> 
> Best Regards,
> Fiona
> 

