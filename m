Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3403A80C24D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjLKHqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKHqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:46:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16288FE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702280771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kb2G5ThzzWRRNxoJx1wPYdWgMGJEMgQ7aW1sjvtsM5M=;
        b=hVX6TUpZ6Kxwg3eRxt/NhXboLqGMSuq7UrPyKzHHgtkMGjrlb2v/eaAg9V4Bws3Zic6L+c
        AnDrfebll42rWll6OLnwXq8eZNnMDqKEyhpnbgD6umKgJd6qfLODPZIgWtA5F2ahLsacE4
        XlUBcs+YJuyux7mpaAL950yhcDpPpKc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-ghplT5o6OxOG4D6IhAusvA-1; Mon, 11 Dec 2023 02:46:09 -0500
X-MC-Unique: ghplT5o6OxOG4D6IhAusvA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a2006e5e055so7258066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:46:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280767; x=1702885567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kb2G5ThzzWRRNxoJx1wPYdWgMGJEMgQ7aW1sjvtsM5M=;
        b=OOkL74r115xUN8J9A+VfDobmxWKS6fNthHiP0k2Kydt1Ing4GoIS2rq8PoTc0kV/9P
         0cR1jhF90yIBBFuLCqFCS7s3s9O7Gq704xv40H1qM7hYYYoYbGZTwuba2RxD/Q0pwZeH
         STb6OxJwH3EiCkbR6V7ioU1uYOKcgwh8llMJUrXOQyB5s544pWhkgResF7XfViAxaZsO
         ffzXOJeUHbwEcEG3i2sM9F+QnQfwZNaNX1XnAPfmIH1f7eQOlsKG6eVVGIUbtt/Dm6da
         PeiQ6+ZL6rVsAh33IuVJNDaf2q3I+qjlfwmf+RMtRx6d6wv5FYdXK4bX3Wz+SuYsnF9l
         Hknw==
X-Gm-Message-State: AOJu0Yw56V3RwImXYTEBJeIhu/ziKWKEBgUts7zesR1ZDxydTw3jWzHC
        Ud76TtnrMfrxsWV4BPJJme2/bxKosPf01yvDdaxMMEiIs5jUyLfmjgBoSoxdkN/7YUf/JQO0KYX
        UyO8axfProLFWCho5bYOTKy3guhjaOdP3
X-Received: by 2002:a17:907:7d8c:b0:a1d:932f:9096 with SMTP id oz12-20020a1709077d8c00b00a1d932f9096mr2714152ejc.37.1702280766711;
        Sun, 10 Dec 2023 23:46:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHiFLo2x3B0I+p84u5YoFV3gwWPB1BrQ6SIzI5rLIjw8yKVrVzX8mslJsav4Q55iGMfOk8npw==
X-Received: by 2002:a17:907:7d8c:b0:a1d:932f:9096 with SMTP id oz12-20020a1709077d8c00b00a1d932f9096mr2714144ejc.37.1702280766375;
        Sun, 10 Dec 2023 23:46:06 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id mj20-20020a170906af9400b00a1b73154eacsm4387489ejb.194.2023.12.10.23.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:46:05 -0800 (PST)
Date:   Mon, 11 Dec 2023 08:46:04 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Fiona Ebner <f.ebner@proxmox.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231211084604.25e209af@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
        <20231207232815.GA771837@bhelgaas>
        <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
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

On Fri, 8 Dec 2023 16:47:23 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> On Thu, 7 Dec 2023 17:28:15 -0600
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Wed, Nov 29, 2023 at 04:22:41PM +0100, Fiona Ebner wrote:  
> > > Hi,
> > > it seems that hot-plugging SCSI disks for QEMU virtual machines booting
> > > with UEFI and with guest kernels >= 6.5 might be broken. It's not
> > > consistently broken, hinting there might be a race somewhere.
> > > 
> > > Reverting the following two commits seems to make it work reliably again:
> > > 
> > > cc22522fd55e2 ("PCI: acpiphp: Use
> > > pci_assign_unassigned_bridge_resources() only for non-root bus")
> > > 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary"
> > > 
> > > Of course, they might only expose some pre-existing issue, but this is
> > > my best lead. See below for some logs and details about an affected
> > > virtual machine. Happy to provide more information and to debug/test
> > > further.
> > > ...    
> >   
> > > I've attached some logs for guest using kernel 6.7.0-rc3 where hotplug
> > > works rarely and guest using kernel 6.7.0-rc3 with the previously
> > > mentioned commits reverted where hotplug works reliably:
> > > 
> > > 6.7.0-rc3:
> > >     
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> > > > Nov 29 15:12:02 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > > > Nov 29 15:12:02 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > > Nov 29 15:12:02 hotplug kernel: scsi host3: Virtio SCSI HBA
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > > Nov 29 15:12:02 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]     
> > 
> > What's the actual symptom that this is broken?  All these log
> > fragments show the exact same assignments for BARs 0, 1, 4 and for the
> > bridge windows.
> > 
> > I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
> > bridge leading to it?
> > 
> > Can you put the complete dmesg logs somewhere?  There's a lot of
> > context missing here.
> > 
> > Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> > work reliably?  If we have to revert something, reverting one would be
> > better than reverting both.  
> 
> here is simplified reproducer:
> ./qemu-system-x86_64 -enable-kvm -m 4G -smp 4 -cpu host                        \
>     /dev/lvmpool/fedora-rawhide                                                \
>     -device pci-bridge,id=pci.3,chassis_nr=3,bus=pci.0,addr=0x5                \
>     -device virtio-scsi-pci,id=virtioscsi0,bus=pci.3,addr=0x1                  \
>     -blockdev raw,file.driver=file,file.filename=Fedora-Server-dvd-x86_64-Rawhide-20231127.n.0.iso,node-name=drive-scsi1 \
>     -monitor stdio -serial file:/tmp/console_log
> 
> then once booted at monitor prompt:
> 
> (qemu) device_add virtio-scsi-pci,bus=pci.3,addr=2,id=virtioscsi1
> (qemu) device_add scsi-hd,id=scsi1,drive=drive-scsi1,bus=virtioscsi1.0
> 
> with distro shipped 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel
> hotplugged HBA is visible but a disk hotplugged into it is not (like Fiona has reported).
> 
> Problem happens when hotpluged virtio-scsi-pci is the 2nd HBA on the same bridge,
> an attempt to rescan HBA (any on the bridge) causes guest hang.
> 
> 
> However with the same 0f5cc96c367f commit, upstream kernel (without initrd and some minimal config):
> 
>  -kernel ./linux-2.6/arch/x86_64/boot/bzImage -append 'root=/dev/sda3 console=ttyS0 console=tty0'
> 
> works as expected (aka disk is visible after hotplug)
> 
> [   75.636170] pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> [   75.636178] pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> [   75.637193] pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> [   75.638441] pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> [   75.647035] pci 0000:01:02.0: BAR 4: assigned [mem 0x380800004000-0x380800007fff 64bit pref]
> [   75.649461] pci 0000:01:02.0: BAR 1: assigned [mem 0xfe801000-0xfe801fff]
> [   75.650793] pci 0000:01:02.0: BAR 0: assigned [io  0xc040-0xc07f]
> [   75.652109] pci 0000:00:05.0: PCI bridge to [bus 01]
> [   75.653181] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
> [   75.656971] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> [   75.659970] pci 0000:00:05.0:   bridge window [mem 0x380800000000-0x380fffffffff 64bit pref]
> [   75.664990] virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> [   75.695505] scsi host3: Virtio SCSI HBA
> [   75.698099] pci 0000:00:05.0: PCI bridge to [bus 01]
> [   75.735840] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
> [   75.740361] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> [   75.744088] pci 0000:00:05.0:   bridge window [mem 0x380800000000-0x380fffffffff 64bit pref]
> 
> 
> So, I'm still looking at where/why it goes wrong

I've narrowed it down to ACPI PCI hotpug, (i.e. it works fine with SHPC and Fedora's kernel).
Though I still can't reproduce with upstream kernel (even with Fedora config (mod=yes)).
So far I was testing Seabios variant, next thing to try is UEFI setup (perhaps upstream will fail there)

Fiona,

Does it help if you use q35 machine with '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off' option?

> 
> > Bjorn
> >   
> > > Reboot
> > >     
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> > > > Nov 29 15:12:52 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > > > Nov 29 15:12:52 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > > Nov 29 15:12:52 hotplug kernel: scsi host3: Virtio SCSI HBA
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > > Nov 29 15:12:52 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]    
> > > 
> > > RebootThe one time it did work. Note that the line with "QEMU HARDDISK"
> > > comes after all lines with "bridge window":
> > >     
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> > > > Nov 29 15:13:51 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > > > Nov 29 15:13:51 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > > Nov 29 15:13:51 hotplug kernel: scsi host3: Virtio SCSI HBA
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> > > > Nov 29 15:13:51 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: Attached scsi generic sg1 type 0
> > > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> > > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> > > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> > > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> > > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk
> > > > Nov 29 15:14:08 hotplug systemd[1]: systemd-fsckd.service: Deactivated successfully.    
> > > 
> > > 6.7.0-rc3 with the following reverted:
> > > cc22522fd55e2 ("PCI: acpiphp: Use
> > > pci_assign_unassigned_bridge_resources() only for non-root bus")
> > > 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary")
> > >     
> > > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> > > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> > > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > > > Nov 29 15:15:37 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > > > Nov 29 15:15:37 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > > Nov 29 15:15:37 hotplug kernel: scsi host3: Virtio SCSI HBA
> > > > Nov 29 15:15:37 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: Attached scsi generic sg1 type 0
> > > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> > > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> > > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> > > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> > > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk
> > > > Nov 29 15:15:38 hotplug systemd[1]: systemd-fsckd.service: Deactivated successfully.    
> > >     
> >   
> 

