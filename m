Return-Path: <linux-kernel+bounces-143743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD80B8A3CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E90C028270C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C11D4437F;
	Sat, 13 Apr 2024 13:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IfT4UYcK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E222EE4
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 13:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713016676; cv=none; b=qsQvnnHI1fbFbBnqBtyMQjtL2nlZwXQylZIC7LvL3si0SuPtASeQAZi9w7ALaQc6ia3T/oHVZuu0shVC9O/4C6qtADVa+S/cwhumaNGPuN6hYGrCRq7VZMic56QGnKMYfdhRJKQOgVPbZBKR28kBaMiwQVl/rd3xTvyS8jqCkfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713016676; c=relaxed/simple;
	bh=WfOLbSVW8JuAN6pofRznUzf4//UOoZnjeXSDc4Mw7P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uT6E3mTFa4dew0j9W6YZG19IXrDNOtNfNt+0ZMkdR3aEGL5EJ2zboITifL5JfyQRa/bzfK9qcQm6f8PtPt6yUkIdPpWmMKBb9UJm3v/waM0PfdWAIclpS+J2q3GpWPKUC5Bh/Q9kYSkNiys4PCfcZYntfiZuRIumV5eLzit+H/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IfT4UYcK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713016673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=04YHOvgyKxIV8EOiQdBH6Pt5NZfGj8+5tbMEaegT57A=;
	b=IfT4UYcKoLX8l1cR9wxfhp7Mtceln/M4qtdZQ903rRgWu6ycceRemroT5KPZWGpitVHemZ
	2Y8OJceYTzWpyrMIDjS7t8zBYEqHDjEX7dAKsN2HI8XpraMjuF6Xq6lK+rspOtTKOOeSrn
	bNT55e+wMZeX63wIeZk0JuMQ5wd9Vh0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-Fal3lT3hP5Gg4KFIdjp1WQ-1; Sat, 13 Apr 2024 09:57:49 -0400
X-MC-Unique: Fal3lT3hP5Gg4KFIdjp1WQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E7B6881E60;
	Sat, 13 Apr 2024 13:57:49 +0000 (UTC)
Received: from localhost (unknown [10.72.116.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A5E6E1C06701;
	Sat, 13 Apr 2024 13:57:47 +0000 (UTC)
Date: Sat, 13 Apr 2024 21:57:40 +0800
From: Baoquan He <bhe@redhat.com>
To: Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, jirislaby@kernel.org
Subject: Re: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
Message-ID: <ZhqPVHLzB1Hx2zFo@MiWiFi-R3L-srv>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

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

OK, thanks for testing and spotting this. 

When I tested this patch, I only did test kexec reboot functionality.
So the line of printing in kernel/crash_core.c is missed. While there
seems to be no kexec_dprintk() in kernel/crash_reserve.c. Anyway,
adding pr_fmt() is a good idea for debug printing in that file. I will
post a standalone patch to add these.

> 
> Otherwise:
> Reviewed-by: Dave Young <dyoung@redhat.com>

Thanks again.

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


