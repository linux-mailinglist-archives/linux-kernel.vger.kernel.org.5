Return-Path: <linux-kernel+bounces-101157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A0387A339
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54F36281DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF35B14AAE;
	Wed, 13 Mar 2024 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYxCpeNC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6D819452
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313847; cv=none; b=RSGbZ4rDQdPllEx64XsmxTWGh79bNZVaUyrmvqgY+7WNUTE5xybp1iY1D4F9n19rbyQaiUSkfwWBQmPScwLK82A5Z1KhGDb0NO9vhOCvQSdbXeNB+xHaMj3EjWQOGqCeqUDv5DMm2CkA0dLZ4wkUki8n+C1pWj1QuyHbg2VTHy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313847; c=relaxed/simple;
	bh=+LBIvHeK5jJ+fU/XIdQzzX0EaneiQXp+HeWNZtrVw9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5LOXjJ4JFrTzmQZFUGMA0qtWHFyCzes48sV6s380fJupvEpV2Z+XAV5Gymyv1qe5gArOS5hAB9LU1UmlRZNlpCQGTSZFX2gRBzy/JqnZoXuKMWZ9xZMvxKJDI7kEge8TKWNFpcfFNiJ8659ejSFDqkPfv/rtcz9bEjD48caznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYxCpeNC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710313844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z9m0flQIeLqxyKbiwOgkeWggQ2qsLzO5+Pi+cvXBRIU=;
	b=YYxCpeNC+et3QqkJeLYd/BeQfUomEpZl87+/3DurX/xonXezoTwSvPNhZgwmvJ4YMhh79P
	7YY4aLQaeN79ub3AqO36p/BSrSQRZC/6OeBfiEl07OJLY6eJFiWghL0sPBaEzTnWKApfkY
	+dQ/eYdP3fEp+9ubwFEZWlOnOnpTKiE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-A_LvjSnQPMGNLRwzgYbMmA-1; Wed, 13 Mar 2024 03:10:38 -0400
X-MC-Unique: A_LvjSnQPMGNLRwzgYbMmA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAF9585A58C;
	Wed, 13 Mar 2024 07:10:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B65A2022C1E;
	Wed, 13 Mar 2024 07:10:36 +0000 (UTC)
Date: Wed, 13 Mar 2024 15:10:34 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
	joe@perches.com, nathan@kernel.org, conor@kernel.org
Subject: Re: kexec verbose dumps with 6.8 [was: [PATCH v4 1/7] kexec_file:
 add kexec_file flag to control debug printing]
Message-ID: <ZfFRaoOIgQQY46zD@MiWiFi-R3L-srv>
References: <20231213055747.61826-1-bhe@redhat.com>
 <20231213055747.61826-2-bhe@redhat.com>
 <4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org>
 <ZfD37AlznCXJ6P54@MiWiFi-R3L-srv>
 <2f8b1b2d-0abb-43f0-8665-0855928f017c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f8b1b2d-0abb-43f0-8665-0855928f017c@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 03/13/24 at 06:58am, Jiri Slaby wrote:
> Hi,
> 
> 
> On 13. 03. 24, 1:48, Baoquan He wrote:
> > Hi Jiri,
> > 
> > On 03/12/24 at 10:58am, Jiri Slaby wrote:
> > > On 13. 12. 23, 6:57, Baoquan He wrote:
> >   ... snip...
> > > > --- a/include/linux/kexec.h
> > > > +++ b/include/linux/kexec.h
> > > ...
> > > > @@ -500,6 +500,13 @@ static inline int crash_hotplug_memory_support(void) { return 0; }
> > > >    static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
> > > >    #endif
> > > > +extern bool kexec_file_dbg_print;
> > > > +
> > > > +#define kexec_dprintk(fmt, ...)					\
> > > > +	printk("%s" fmt,					\
> > > > +	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
> > > > +	       ##__VA_ARGS__)
> > > 
> > > This means you dump it _always_. Only with different levels.
> > 
> > It dumped always too with pr_debug() before, I just add a switch to
> > control it's pr_info() or pr_debug().
> 
> Not really, see below.
> 
> > > 
> > > And without any prefix whatsoever, so people see bloat like this in their
> > > log now:
> > > [  +0.000001] 0000000000001000-000000000009ffff (1)
> > > [  +0.000002] 000000007f96d000-000000007f97efff (3)
> > > [  +0.000002] 0000000000800000-0000000000807fff (4)
> > > [  +0.000001] 000000000080b000-000000000080bfff (4)
> > > [  +0.000002] 0000000000810000-00000000008fffff (4)
> > > [  +0.000001] 000000007f97f000-000000007f9fefff (4)
> > > [  +0.000001] 000000007ff00000-000000007fffffff (4)
> > > [  +0.000002] 0000000000000000-0000000000000fff (2)
> > 
> > On which arch are you seeing this? There should be one line above these
> > range printing to tell what they are, like:
> > 
> > E820 memmap:
> 
> Ah this is there too. It's a lot of output, so I took it out of context,
> apparently.
> 
> > 0000000000000000-000000000009a3ff (1)
> > 000000000009a400-000000000009ffff (2)
> > 00000000000e0000-00000000000fffff (2)
> > 0000000000100000-000000006ff83fff (1)
> > 000000006ff84000-000000007ac50fff (2)
> 
> It should all be prefixed like kdump: or kexec: in any way.

I can reproduce it now on fedora. OK, I will add kexec or something
similar to prefix. Thanks.

> 
> > > without actually knowing what that is.
> > > 
> > > There should be nothing logged if that is not asked for and especially if
> > > kexec load went fine, right?
> > 
> > Right. Before this patch, those pr_debug() were already there. You need
> > enable them to print out like add '#define DEBUG' in *.c file, or enable
> > the dynamic debugging of the file or function.
> 
> I think it's perfectly fine for DEBUG builds to print this out. And many
> (all major?) distros use dyndbg, so it used to print nothing by default.
> 
> > With this patch applied,
> > you only need specify '-d' when you execute kexec command with
> > kexec_file load interface, like:
> > 
> > kexec -s -l -d /boot/vmlinuz-xxxx.img --initrd xxx.img --reuse-cmdline
> 
> Perhaps our (SUSE) tooling passes -d? But I am seeing this every time I
> boot.
> 
> No, it does not seem so:
> load.sh[915]: Starting kdump kernel load; kexec cmdline: /sbin/kexec -p
> /var/lib/kdump/kernel --append=" loglevel=7 console=tty0 console=ttyS0
> video=1920x1080,1024x768,800x600 oops=panic
> lsm=lockdown,capability,integrity,selinux sysrq=yes reset_devices
> acpi_no_memhotplug cgroup_disable=memory nokaslr numa=off irqpoll nr_cpus=1
> root=kdump rootflags=bind rd.udev.children-max=8 disable_cpu_apicid=0
> panic=1" --initrd=/var/lib/kdump/initrd  -a
> 
> > For kexec_file load, it is not logging if not specifying '-d', unless
> > you take way to make pr_debug() work in that file.
> 
> So is -d detection malfunctioning under some circumstances?
> 
> > > Can this be redesigned, please?
> > 
> > Sure, after making clear what's going on with this, I will try.
> > 
> > > 
> > > Actually what was wrong on the pr_debug()s? Can you simply turn them on from
> > > the kernel when -d is passed to kexec instead of all this?
> > 
> > Joe suggested this during v1 reviewing:
> > https://lore.kernel.org/all/1e7863ec4e4ab10b84fd0e64f30f8464d2e484a3.camel@perches.com/T/#u
> > 
> > > 
> > > ...
> > > > --- a/kernel/kexec_core.c
> > > > +++ b/kernel/kexec_core.c
> > > > @@ -52,6 +52,8 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
> > > >    /* Flag to indicate we are going to kexec a new kernel */
> > > >    bool kexec_in_progress = false;
> > > > +bool kexec_file_dbg_print;
> > > 
> > > Ugh, and a global flag for this?
> > 
> > Yeah, kexec_file_dbg_print records if '-d' is specified when 'kexec'
> > command executed. Anything wrong with the global flag?
> 
> Global variables are frowned upon. To cite coding style: unless you
> **really** need them. Here, it looks like you do not.

I see your point, will consider and change. Thanks again.


