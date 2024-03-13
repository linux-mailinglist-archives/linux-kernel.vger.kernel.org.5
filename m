Return-Path: <linux-kernel+bounces-100972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466E87A047
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C2951F22298
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073C8C1E;
	Wed, 13 Mar 2024 00:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC9BYsAs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF58CB660
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710290935; cv=none; b=Jtv0Q+42jhpqQFP7hluLuG4p7yYx7Oa+4oizMuId4DhvuTx2RoFeGjD35AH/VqJETPi7DaTga0/ck7X+i4et5cJtA1Ytfndrj16JgvXw570j/ffgpynGaKqxps58XUL9mlA6465QDvi+3OzmDki+cRZ5LZnTAdNlBr84Eijt0u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710290935; c=relaxed/simple;
	bh=pucfo0bfwTccJkVOhojWyorX6XQpl7QfTU1NID00m8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsZ7GgcZqPBg7uDIP0aBwuc7QO5aCMc8k3fwBzbo6LFzR+57ADFLCgTWaCXaEeYgRegZLUfDt7V6RT1JypLO80AyEi3oENO9mcH+ofVHYD7kOC2nnItomM/8+GRiwGVH17QFD3+g5GP9ojbeHWs8x8QHUODsMNFFidsD8TA0HAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC9BYsAs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710290931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/I7rfb7fSwv9EVlLwLZyE6cq/I2crR3JWNIky7ODFU=;
	b=PC9BYsAsDLiDvs1nBmqlFUuek5Fy0A7qVJJZu8I1qKIC9usQxxk2X4YUDT6fLgXXsvYH9U
	e/rdNtC0qocAtEIFCXxde79tN+yKq61dlWbrpxUzUVS2mE4mWZS+epGuY6gHyAsEJU3CmJ
	JfvHvMEcxsU4WzNgRO6en9CBEFi5f6Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-Tx39TiVcPDK1NGuCqWNU_g-1; Tue, 12 Mar 2024 20:48:48 -0400
X-MC-Unique: Tx39TiVcPDK1NGuCqWNU_g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CAF58800262;
	Wed, 13 Mar 2024 00:48:47 +0000 (UTC)
Received: from localhost (unknown [10.72.116.13])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 24F7510E47;
	Wed, 13 Mar 2024 00:48:46 +0000 (UTC)
Date: Wed, 13 Mar 2024 08:48:44 +0800
From: Baoquan He <bhe@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org, akpm@linux-foundation.org,
	joe@perches.com, nathan@kernel.org, conor@kernel.org
Subject: Re: kexec verbose dumps with 6.8 [was: [PATCH v4 1/7] kexec_file:
 add kexec_file flag to control debug printing]
Message-ID: <ZfD37AlznCXJ6P54@MiWiFi-R3L-srv>
References: <20231213055747.61826-1-bhe@redhat.com>
 <20231213055747.61826-2-bhe@redhat.com>
 <4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Hi Jiri,

On 03/12/24 at 10:58am, Jiri Slaby wrote:
> On 13. 12. 23, 6:57, Baoquan He wrote:
 ... snip...
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> ...
> > @@ -500,6 +500,13 @@ static inline int crash_hotplug_memory_support(void) { return 0; }
> >   static inline unsigned int crash_get_elfcorehdr_size(void) { return 0; }
> >   #endif
> > +extern bool kexec_file_dbg_print;
> > +
> > +#define kexec_dprintk(fmt, ...)					\
> > +	printk("%s" fmt,					\
> > +	       kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,	\
> > +	       ##__VA_ARGS__)
> 
> This means you dump it _always_. Only with different levels.

It dumped always too with pr_debug() before, I just add a switch to
control it's pr_info() or pr_debug().

> 
> And without any prefix whatsoever, so people see bloat like this in their
> log now:
> [  +0.000001] 0000000000001000-000000000009ffff (1)
> [  +0.000002] 000000007f96d000-000000007f97efff (3)
> [  +0.000002] 0000000000800000-0000000000807fff (4)
> [  +0.000001] 000000000080b000-000000000080bfff (4)
> [  +0.000002] 0000000000810000-00000000008fffff (4)
> [  +0.000001] 000000007f97f000-000000007f9fefff (4)
> [  +0.000001] 000000007ff00000-000000007fffffff (4)
> [  +0.000002] 0000000000000000-0000000000000fff (2)

On which arch are you seeing this? There should be one line above these
range printing to tell what they are, like:

E820 memmap:
0000000000000000-000000000009a3ff (1)
000000000009a400-000000000009ffff (2)
00000000000e0000-00000000000fffff (2)
0000000000100000-000000006ff83fff (1)
000000006ff84000-000000007ac50fff (2)

> 
> without actually knowing what that is.
> 
> There should be nothing logged if that is not asked for and especially if
> kexec load went fine, right?

Right. Before this patch, those pr_debug() were already there. You need
enable them to print out like add '#define DEBUG' in *.c file, or enable
the dynamic debugging of the file or function. With this patch applied,
you only need specify '-d' when you execute kexec command with
kexec_file load interface, like:

kexec -s -l -d /boot/vmlinuz-xxxx.img --initrd xxx.img --reuse-cmdline

For kexec_file load, it is not logging if not specifying '-d', unless
you take way to make pr_debug() work in that file.

> 
> Can this be redesigned, please?

Sure, after making clear what's going on with this, I will try.

> 
> Actually what was wrong on the pr_debug()s? Can you simply turn them on from
> the kernel when -d is passed to kexec instead of all this?

Joe suggested this during v1 reviewing:
https://lore.kernel.org/all/1e7863ec4e4ab10b84fd0e64f30f8464d2e484a3.camel@perches.com/T/#u

> 
> ...
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -52,6 +52,8 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
> >   /* Flag to indicate we are going to kexec a new kernel */
> >   bool kexec_in_progress = false;
> > +bool kexec_file_dbg_print;
> 
> Ugh, and a global flag for this?

Yeah, kexec_file_dbg_print records if '-d' is specified when 'kexec'
command executed. Anything wrong with the global flag?

Thanks
Baoquan


