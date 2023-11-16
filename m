Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816477EE331
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344652AbjKPOpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjKPOpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:45:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E68130
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:45:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700145931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SvB9iGs9vD1rRk7cd40qT87db5HVxelOOnL3if3kxBw=;
        b=XsP0MUr48hvJMqaopJkmpBUVWaP4+4pcwIeiiUs+uaDh1xBMXUiXOfK8hZJY6PRIztaXGg
        LJHAbyDS5e2DdHuK6llihDI1sesAtcb5ke6NTGu5KdmY4sAbD9wJWm9zai8/L/1gGQO7U1
        dylDCisC153tiRZTTysLvJkvsdhoLBI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-r9EpGFd-MUK_I6xzkaYdeA-1; Thu,
 16 Nov 2023 09:45:28 -0500
X-MC-Unique: r9EpGFd-MUK_I6xzkaYdeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F7213806100;
        Thu, 16 Nov 2023 14:45:27 +0000 (UTC)
Received: from localhost (unknown [10.72.112.11])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A18F1C060AE;
        Thu, 16 Nov 2023 14:45:26 +0000 (UTC)
Date:   Thu, 16 Nov 2023 22:45:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>, kexec@lists.infradead.org,
        linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 00/14] x86/tdx: Add kexec support
Message-ID: <ZVYrA+Ks0DGFo/0p@MiWiFi-R3L-srv>
References: <20231115120044.8034-1-kirill.shutemov@linux.intel.com>
 <ZVYGx1EwzjXbTEyX@MiWiFi-R3L-srv>
 <20231116125612.daxettqcapled7ac@box.shutemov.name>
 <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVYkdI74X8acDtTq@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 at 10:17pm, Baoquan He wrote:
> On 11/16/23 at 03:56pm, Kirill A. Shutemov wrote:
> > On Thu, Nov 16, 2023 at 08:10:47PM +0800, Baoquan He wrote:
> > > On 11/15/23 at 03:00pm, Kirill A. Shutemov wrote:
> > > > The patchset adds bits and pieces to get kexec (and crashkernel) work on
> > > > TDX guest.
> > > 
> > > I finally got a machine of intel-eaglestream-spr as host and built a
> > > tdx guest to give it a shot, the kexec reboot is working very well,
> > > while kdump kernel always failed to boot up. I only built kernel and
> > > installed it on tdx guest.
> > > ------------------------------------------
> > > [    1.422500] Run /init as init process
> > > [    1.423073] Failed to execute /init (error -2)
> > > [    1.423759] Run /sbin/init as init process
> > > [    1.424370] Run /etc/init as init process
> > > [    1.424969] Run /bin/init as init process
> > > [    1.425588] Run /bin/sh as init process
> > > [    1.426150] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
> > > [    1.428122] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.7.0-rc1-00014-gbdba31ba3cec #3
> > > [    1.429232] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS unknown 2/2/2022
> > > [    1.430328] Call Trace:
> > > [    1.430717]  <TASK>
> > > [    1.431041]  dump_stack_lvl+0x33/0x50
> > > [    1.431581]  panic+0x324/0x340
> > > [    1.432037]  ? __pfx_kernel_init+0x10/0x10
> > > [    1.432629]  kernel_init+0x174/0x1c0
> > > [    1.433149]  ret_from_fork+0x2d/0x50
> > > [    1.433690]  ? __pfx_kernel_init+0x10/0x10
> > > [    1.434277]  ret_from_fork_asm+0x1b/0x30
> > > [    1.434850]  </TASK>
> > > [    1.435345] Kernel Offset: disabled
> > > [    1.439216] Rebooting in 10 seconds..
> > > qemu-kvm: cpus are not resettable, terminating
> > 
> > Could you shared your kernel config and details about your setup (qemu
> > command, kernel command line, ...)?
> 
> We followed tdx-tools README to setup the environment and built host and
> guest kernel, qemu command is as below. I copied the
> tdx-tools/build/rhel-9/intel-mvp-tdx-kernel/tdx-base.config to the
> latest upstream linxu kernel then execute 'make olddefconfig'. Because
> your patchset can't be applied to the stable kernel with the 731
> patches.
> 
> cd /home/root/tdx-tools
> ./start-qemu.sh -i /home/root/guest_tdx.qcow2 -b grub

This is the qemu command when execute above line of command, just for
your reference if you happen to not take this way.

[root@intel-eaglestream-spr-03 tdx-tools]# ./start-qemu.sh -i /home/root/guest_tdx.qcow2 -b grub
WARN: Using HVC console for grub, could not accept key input in grub menu
=========================================
Guest Image       : /home/root/guest_tdx.qcow2
Kernel binary     : 
OVMF              : /usr/share/qemu/OVMF.fd
VM Type           : td
CPUS              : 1
Boot type         : grub
Monitor port      : 9001
Enable vsock      : false
Enable debug      : false
Console           : HVC
=========================================
Remapping CTRL-C to CTRL-]
Launch VM:
/usr/libexec/qemu-kvm -accel kvm -name process=tdxvm,debug-threads=on -m 2G -vga none -monitor pty -no-hpet -nodefaults -drive file=/home/root/guest_tdx.qcow2,if=virtio,format=qcow2 -monitor telnet:127.0.0.1:9001,server,nowait -bios /usr/share/qemu/OVMF.fd -object tdx-guest,sept-ve-disable=on,id=tdx -object memory-backend-memfd-private,id=ram1,size=2G -cpu host,-kvm-steal-time,pmu=off -machine q35,kernel_irqchip=split,confidential-guest-support=tdx,memory-backend=ram1 -device virtio-net-pci,netdev=mynet0 -netdev user,id=mynet0,net=10.0.2.0/24,dhcpstart=10.0.2.15,hostfwd=tcp::10026-:22 -smp 1 -chardev stdio,id=mux,mux=on,logfile=/home/root/tdx-tools/vm_log_2023-11-16T0658.log -device virtio-serial,romfile= -device virtconsole,chardev=mux -monitor chardev:mux -serial chardev:mux -nographic
char device redirected to /dev/pts/1 (label compat_monitor0)

