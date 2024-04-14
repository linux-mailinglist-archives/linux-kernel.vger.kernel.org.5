Return-Path: <linux-kernel+bounces-143945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A00F8A3FF5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 04:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66261B21ADC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E884018054;
	Sun, 14 Apr 2024 02:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rl6yz7pL"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B5817BB7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713063264; cv=none; b=hUZTofHQ/gMUaNYfRths/MbhqKV9mvGxfNV1RfMt1WZ+Q7lYxxfbRrKAkHcWCXYKl+C8v1nMyxJ/XYQX+bs04wsLHtatTCV7iwTh7V9tCDdWZeB1tE6tItDA/zrMO3wQ+Ys39fk2Yxs9rHo+StjihBC6XOe0pCP6WOfOcNn5R1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713063264; c=relaxed/simple;
	bh=aIBjNNw2Keu9G7UDv6iOj4TLO0fqBpBoO4nzVGHm7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JRnswzdSzYcozMvkdWWp85ZzapjpxmkJlab22R8jIGprEoCKjGTGkJmf1yXOB05X95O+XjzMGKILsvTKTRZ8W9u+wRmYoOfNP1rtIomAXigLbCze6J53+5lRRG1dJc3/pKnN2prqUoRaD8RdFbCsmkSclBsdfOAqzHciWNMUozI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rl6yz7pL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713063260;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OhLPL+Z8mhdNe67IKMsqNtqhIqypjsxI4KpmPg+trm4=;
	b=Rl6yz7pLX2ATCUcleAHpEKsJWanGW1QPbrPw1ZznghaxbdpABZY06uCWf0VInpJb/WdGgS
	aAJ8+Yhavt5p+InygWmQfIefh1NxWnRwrcZoqdLqfPH23sNq2gGgpTMCpn2Tz+DSsRa3iQ
	eUlhUNP4p0wPRwqwdXecGcSpnUhmOC0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631-mzn0Pu1aNfCwCNMoXmM7hA-1; Sat,
 13 Apr 2024 22:54:18 -0400
X-MC-Unique: mzn0Pu1aNfCwCNMoXmM7hA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F0141C05AB5;
	Sun, 14 Apr 2024 02:54:17 +0000 (UTC)
Received: from localhost (unknown [10.72.116.11])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA896492BC8;
	Sun, 14 Apr 2024 02:54:16 +0000 (UTC)
Date: Sun, 14 Apr 2024 10:54:09 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, jirislaby@kernel.org
Subject: Re: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
Message-ID: <ZhtFUT3Xmab3CqoI@MiWiFi-R3L-srv>
References: <20240409042238.1240462-1-bhe@redhat.com>
 <CALu+AoRB=kK00ecpboSJxpNqP+ERZaUrS+h-oo+uaXLoYPYT_Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALu+AoRB=kK00ecpboSJxpNqP+ERZaUrS+h-oo+uaXLoYPYT_Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hi Dave,

On 04/12/24 at 03:28pm, Dave Young wrote:
> On Tue, 9 Apr 2024 at 12:23, Baoquan He <bhe@redhat.com> wrote:
> >
> > Jiri reported that the current kexec_dprintk() always prints out
> > debugging message whenever kexec/kdmmp loading is triggered. That is
> > not wanted. The debugging message is supposed to be printed out when
> > 'kexec -s -d' is specified for kexec/kdump loading.
> >
> > After investigating, the reason is the current kexec_dprintk() takes
> > printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> > specified. However, distros usually have defaulg log level like below:
> >
> >  [~]# cat /proc/sys/kernel/printk
> >  7       4      1       7
> >
> > So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> > prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> > not.
> >
> > Fix it by changing to use pr_info() instead which are expected to work.
> 
> Could you also update the kernel/crash_core.c and
> kernel/crash_reserve.c to include the filename prefix?
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

When I added pr_fmt() to kernel/crash_reserve.c and tested code, the
printed boot log about crashkernel reservation is changed as below:

[  +0.000000] crash_reserve: crashkernel reserved: 0x000000007d000000 - 0x0000000095000000 (384 MB)

When I looked around, I noticed all other lines around don't have the
module name printed out. Seems it's not appropriate to add one for
crashkernel alone. And the kexec_dprintk() doesn't exist in
kernel/crash_reserve.c. Furthermore, the kexec_dprintk() is added to
enable debugging printing for kexec_file_load when loading kexec/kdump
kernel. This crashkernel reservation may not be related. Combinbed these
all, I would suggest not adding pr_fmt() for kernel/crash_reserve.c for
now, let's add pr_fmt() for kernel/crash_core.c, what do you think?

> 
> >
> > Fixes: cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control debug printing")
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
> > ---
> > v1->v2:
> > - Change to use pr_info() only when "kexec -s -d" is specified. With
> >   this change, those debugging message for "kexec -c -d" of kexec_load
> >   will be missed. We'll see if we need add them for kexec_load too, if
> >   someone explicitly requests it.
> >
> >  include/linux/kexec.h | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index 060835bb82d5..f31bd304df45 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -461,10 +461,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
> >
> >  extern bool kexec_file_dbg_print;
> >
> > -#define kexec_dprintk(fmt, ...)                                        \
> > -       printk("%s" fmt,                                        \
> > -              kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,   \
> > -              ##__VA_ARGS__)
> > +#define kexec_dprintk(fmt, arg...) \
> > +        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> >
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > --
> > 2.41.0
> >
> >
> 


