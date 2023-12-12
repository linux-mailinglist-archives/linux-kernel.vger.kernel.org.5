Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA30B80EA57
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346394AbjLLL0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346543AbjLLL0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:26:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16387B8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702380373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VCPhUza2WDSv0OPfffTIRcwZLYS7Z9nqJ6x5U/LS9Q=;
        b=bBWFVO8abE1MvoGAUmIw1tpkU4b+auH2Tz+G/5gbEN25GIK/O8Gz6GqDejs6+LD3Whq2Wm
        QRm6/JIxD18iwR8rbTwxdNUHgDaZjAtSSFRL4fadlnb4cqlXD4VsTvmOaPK2udke6YU35b
        X7LEKVR0I78CbSW1l3JNBa2/pfWu8bA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-h5mFfVEbO7K3u_TsudOJsw-1; Tue, 12 Dec 2023 06:26:11 -0500
X-MC-Unique: h5mFfVEbO7K3u_TsudOJsw-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1d1c249b3aso298223066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:26:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702380371; x=1702985171;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3VCPhUza2WDSv0OPfffTIRcwZLYS7Z9nqJ6x5U/LS9Q=;
        b=pAff2jhi5CXg2K/EbWq0wUemuKLe+bt1Rjza85u/0vLaHjs0K8v7yIr6okwtYLuAaW
         JNXZj5EjjV1WQw8QkHm6CGSEDQtyru+nAl72PVIZFvQq1tc5DMXmSB0seKiTU2xtyrHv
         ZZ4/FoUYzdyV9yyI3/6yhvllNygWzAFjQEJ6Fz35mFAnqjbfuxdoE4HdyMkMtvtgAoDa
         Oi4JK5SckeDx/Vr+eULRm3jBhXEEcCAY/q3+bkdFqRhKrSKBFfC3Bx9SxDDLLWdmC7xc
         sOqtqBPP0dkpRKiR+lPo2RBFj78pV5IgZH0NyG75NEwhSyZZ3+Q15P3unJSIgFc0Sean
         vhkg==
X-Gm-Message-State: AOJu0YwxPMgpPApS5+t65/waqoRXZv2UWADpmu7kKpNuOfu3woe7uyde
        JqIBqTa8NPNiQlwlUUrl6OrXXp9iNgbD+0zMEIu6H8DetBB6MxCmH7Vvm/aMnqWLVpgtymFmpOG
        YJK/vAc0l7AaKkjf/ankeNFS7
X-Received: by 2002:a17:907:8688:b0:a19:a19b:55eb with SMTP id qa8-20020a170907868800b00a19a19b55ebmr3739486ejc.123.1702380370797;
        Tue, 12 Dec 2023 03:26:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAky8UR7GX5tqJ0wl3aJCEUtp3YuSWksklCWQP+DbM0tyL1tcOWxOzYYJaJEyigKEG4GjJEQ==
X-Received: by 2002:a17:907:8688:b0:a19:a19b:55eb with SMTP id qa8-20020a170907868800b00a19a19b55ebmr3739481ejc.123.1702380370419;
        Tue, 12 Dec 2023 03:26:10 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a1d1b8a088esm6121282ejc.92.2023.12.12.03.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 03:26:09 -0800 (PST)
Date:   Tue, 12 Dec 2023 12:26:08 +0100
From:   Igor Mammedov <imammedo@redhat.com>
To:     Fiona Ebner <f.ebner@proxmox.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
        Thomas Lamprecht <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231212122608.1b4f75ce@imammedo.users.ipa.redhat.com>
In-Reply-To: <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
        <20231207232815.GA771837@bhelgaas>
        <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
        <20231211084604.25e209af@imammedo.users.ipa.redhat.com>
        <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023 14:52:42 +0100
Fiona Ebner <f.ebner@proxmox.com> wrote:

> Am 11.12.23 um 08:46 schrieb Igor Mammedov:
> > On Fri, 8 Dec 2023 16:47:23 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> >> On Thu, 7 Dec 2023 17:28:15 -0600
> >> Bjorn Helgaas <helgaas@kernel.org> wrote:
> >>  
> >>>
> >>> What's the actual symptom that this is broken?  All these log
> >>> fragments show the exact same assignments for BARs 0, 1, 4 and for the
> >>> bridge windows.
> >>>  
> 
> The disk never shows up in /dev
> 
> >>> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
> >>> bridge leading to it?
> >>>
> >>> Can you put the complete dmesg logs somewhere?  There's a lot of
> >>> context missing here.
> >>>  
> 
> Is this still necessary with Igor being able to reproduce the issue?

it's not necessary, but it would help to find out what's going wrong faster.
Otherwise we would need to fallback to debugging over email.
Are you willing to help with testing/providing debug logs to track down
the cause?.

Though debug over email would be slow, so our best option is to revert
offending patches until the cause if found/fixed.

> >>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> >>> work reliably?  If we have to revert something, reverting one would be
> >>> better than reverting both.    
> >>  
> 
> Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
> 40613da52b13f so I can't revert just 40613da52b13f).

With UEFI setup, it still works for me fine with current master.

Kernel 6.7.0-rc5-00014-g26aff849438c on an x86_64 (ttyS0)

ibm-p8-kvm-03-guest-02 login: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
pci 0000:01:02.0: BAR 4: assigned [mem 0x380000004000-0x380000007fff 64bit pref]
pci 0000:01:02.0: BAR 1: assigned [mem 0xc1001000-0xc1001fff]
pci 0000:01:02.0: BAR 0: assigned [io  0xc040-0xc07f]
pci 0000:00:05.0: PCI bridge to [bus 01]
pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:05.0:   bridge window [mem 0xc1000000-0xc11fffff]
pci 0000:00:05.0:   bridge window [mem 0x380000000000-0x3807ffffffff 64bit pref]
virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
scsi host3: Virtio SCSI HBA
pci 0000:00:05.0: PCI bridge to [bus 01]
pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
pci 0000:00:05.0:   bridge window [mem 0xc1000000-0xc11fffff]
pci 0000:00:05.0:   bridge window [mem 0x380000000000-0x3807ffffffff 64bit pref]
scsi 3:0:0:0: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
sd 3:0:0:0: Power-on or device reset occurred
sd 3:0:0:0: Attached scsi generic sg2 type 0
sd 3:0:0:0: LUN assignments on this target have changed. The Linux SCSI layer does not automatically remap LUN assignments.
sd 3:0:0:0: [sdb] 5190784 512-byte logical blocks: (2.66 GB/2.47 GiB)
sd 3:0:0:0: [sdb] Write Protect is off
sd 3:0:0:0: [sdb] Mode Sense: 63 00 00 08
sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
GPT:Primary header thinks Alt. header is not at the end of the disk.
GPT:5190099 != 5190783
GPT:Alternate GPT header not at the end of the disk.
GPT:5190099 != 5190783
GPT: Use GNU Parted to correct GPT errors.
 sdb: sdb1 sdb2
sd 3:0:0:0: [sdb] Attached SCSI disk

it still doesn't work with Fedora's 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel.
However it's necessary to have -smp 4 for it to break,
with -smp 1 it works fine as well.

 
> > Fiona,
> > 
> > Does it help if you use q35 machine with '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off' option?
> >   
> 
> Yes, it does :)
> 
> I added the following to my QEMU commandline (first line, because there
> wouldn't be a "pci.0" otherwise):
> 
> > -device 'pci-bridge,id=pci.0,chassis_nr=4' \
> > -machine 'q35' \
> > -global 'ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off' \  
> 
> and while it takes a few seconds, the disk does show up successfully:

delay is normal for SHPC

> 
> Best Regards,
> Fiona
> 

