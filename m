Return-Path: <linux-kernel+bounces-4884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E10BF81834B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730D21F24C68
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1308112B7D;
	Tue, 19 Dec 2023 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYaQ6wNM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE23012B71
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702974402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=td3C4F14eqefor6PZNRVtU0ftiPg4SDbdyzMDoGzJzM=;
	b=DYaQ6wNMHcbJ+MoD8n2CQ3AGK1oWCXW9CbUR2GgT0TXferx74enmGr0+IxUqHSbqMQP0bM
	5hgZesj8IRh58fAGXuTFsduX4U5rDtROV/VkZ1kASw2EhBCMd8c3NsQCSPWK/yyJvcfpyU
	Zvr2goWUjJ+fo822rUq64HoQFOZKPmY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-3xfZhagFNXmOmrFsiCoxtA-1; Tue, 19 Dec 2023 03:26:35 -0500
X-MC-Unique: 3xfZhagFNXmOmrFsiCoxtA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8EDC185A78A;
	Tue, 19 Dec 2023 08:26:34 +0000 (UTC)
Received: from localhost (unknown [10.72.116.38])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AFAB73C27;
	Tue, 19 Dec 2023 08:26:33 +0000 (UTC)
Date: Tue, 19 Dec 2023 16:26:30 +0800
From: "bhe@redhat.com" <bhe@redhat.com>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"maz@kernel.org" <maz@kernel.org>,
	"tony.luck@intel.com" <tony.luck@intel.com>,
	"sre@kernel.org" <sre@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"arnd@arndb.de" <arnd@arndb.de>, "wens@csie.org" <wens@csie.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?iso-8859-1?Q?Sch=F6nherr=2C_Jan_H=2E?= <jschoenh@amazon.de>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"orsonzhai@gmail.com" <orsonzhai@gmail.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"samuel@sholland.org" <samuel@sholland.org>,
	"pavel@ucw.cz" <pavel@ucw.cz>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>
Subject: Re: [PATCH] kexec: do syscore_shutdown() in kernel_kexec
Message-ID: <ZYFTtubWqPb/n8tc@MiWiFi-R3L-srv>
References: <20231213064004.2419447-1-jgowans@amazon.com>
 <ZYEafpms++a3a8ch@MiWiFi-R3L-srv>
 <9ffa2c4d3e808feb2afa6f02f4afabf1cd674516.camel@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ffa2c4d3e808feb2afa6f02f4afabf1cd674516.camel@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

On 12/19/23 at 07:41am, Gowans, James wrote:
> On Tue, 2023-12-19 at 12:22 +0800, Baoquan He wrote:
> > Add Andrew to CC as Andrew helps to pick kexec/kdump patches.
> 
> Ah, thanks, I didn't realise that Andrew pulls in the kexec patches.
> > 
> > On 12/13/23 at 08:40am, James Gowans wrote:
> > ......
> > > This has been tested by doing a kexec on x86_64 and aarch64.
> > 
> > Hi James,
> > 
> > Thanks for this great patch. My colleagues have opened bug in rhel to
> > track this and try to veryfy this patch. However, they can't reproduce
> > the issue this patch is fixing. Could you tell more about where and how
> > to reproduce so that we can be aware of it better? Thanks in advance.
> 
> Sure! The TL;DR is: run a VMX (Intel x86) KVM VM on Linux v6.4+ and do a
> kexec while the  KVM VM is still running. Before this patch the system
> will triple fault.

Thanks a lot for these details, I will forward this to our QE to try.

> 
> In more detail:
> Run a bare metal host on a modern Intel CPU with VMX support. The kernel
> I was using was 6.7.0-rc5+.
> You can totally do this with a QEMU "host" as well, btw, that's how I
> did the debugging and attached GDB to it to figure out what was up.
> 
> If you want a virtual "host" launch with:
> 
> -cpu host -M q35,kernel-irqchip=split,accel=kvm -enable-kvm
> 
> Launch a KVM guest VM, eg:
> 
> qemu-system-x86_64 \
>   -enable-kvm \
>   -cdrom alpine-virt-3.19.0-x86_64.iso \
>   -nodefaults -nographic -M q35 \
>   -serial mon:stdio
> 
> While the guest VM is *still running* do a kexec on the host, eg:
> 
> kexec -l --reuse-cmdline --initrd=config-6.7.0-rc5+ vmlinuz-6.7.0-rc5+ && \
>   kexec -e
> 
> The kexec can be to anything, but I generally just kexec to the same
> kernel/ramdisk as is currently running. Ie: same-version kexec.
> 
> Before this patch the kexec will get stuck, after this the kexec will go
> smoothly and the system will end up in the new kernel in a few seconds.
> 
> I hope those steps are clear and you can repro this?
> 
> BTW, the reason that it's important for the KVM VM to still be running
> when the host does the kexec is because KVM internally maintains a usage
> counter and will disable virtualisation once all VMs have been
> terminated, via:
> 
> __fput(kvm_fd)
>   kvm_vm_release
>     kvm_destroy_vm
>       hardware_disable_all
>         hardware_disable_all_nolock
>           kvm_usage_count--;
>           if (!kvm_usage_count)
>             on_each_cpu(hardware_disable_nolock, NULL, 1);
> 
> So if all KVM fds are closed then kexec will work because VMXE is
> cleared on all CPUs when the last VM is destroyed. If the KVM fds are
> still open (ie: QEMU process still exists) then the issue manifests.  It
> sounds nasty to do a kexec while QEMU processes are still around but
> this is a perfectly normal flow for live update:
> 1. Pause and Serialise VM state
> 2. kexec
> 3. deserialise and resume VMs.
> In that flow there's no need to actually kill the QEMU process, as long
> as the VM is *paused* and has been serialised we can happily kexec.
> 
> JG
> 


