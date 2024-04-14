Return-Path: <linux-kernel+bounces-144154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F498A4282
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B771C20E1D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4418D4DA05;
	Sun, 14 Apr 2024 13:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vqj2qWSM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD9541C75
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713100551; cv=none; b=kA0xbqePTBmvkcoiM95cvakeZqqm650FMw8i+rDxfaDBtB/4sZBWsVaZgRxJbEzegmZQ+t1jT72T20apbNKwkGrfrYZgem/zDZ9uTdP1edbRu5G2hipMnP/UL62LBrV95ch9CPbjTtIVff3NuSCZA6ykbrvT9SQ2Hs9GHGlVALs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713100551; c=relaxed/simple;
	bh=0bMBkVLvgH28xY4HJiaovhwUH00M0XGYRBP3F7xHy7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0X0XqOu0IheCCSdYSeQzEZ2miFYrBGSLUM5aYiQAdBXS4zmA2L6ZSq1ohO7qByZGvTjAwy07StSs8kGmT3ycgtITXeuzshYlSWnHpIPswKMi8HMjHgD4H6pluNi0UdQOQgys0N9WQ7ut8VeotxHTXzjZFjbxYkE49rlTo0CxWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vqj2qWSM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713100548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxsVSEM/ISCMQK7WTXJMVVvHAiJqTZKC50KXYMuKRIg=;
	b=Vqj2qWSMX7inFHPGpUx/fJXEJrMCWOB5mDhodYNp67+h0UB8BSLS6hFgRanpil5NFoLVrb
	qEbpi4iklVu1Xf4SpYVLt7Zqn9RsIztfonYZm4Lm/xIHyAK/XtcsiogcSquLspvpyR8VCM
	dO6sv5yF5vbtzqjAKNx+1STiLM2qxPc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-nAc8bXaqNeS0ZA58igKTLg-1; Sun, 14 Apr 2024 09:15:47 -0400
X-MC-Unique: nAc8bXaqNeS0ZA58igKTLg-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3684d716b9eso4532085ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713100546; x=1713705346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxsVSEM/ISCMQK7WTXJMVVvHAiJqTZKC50KXYMuKRIg=;
        b=HA0fCbLvHhMF2eu6MtNN6RAHGAawEdJfgW8fWAqvusVSCDBY0AZu2mHfkCc6G/Wudm
         0eksiVFc+HVkUmcUf974Wp772eL6R2HzpVWclQ+ygwQCAAKxXJKAfVFtYdbNMqu/UNLB
         hbgeemw0k4geV76QLLtvArhVzPY1H4K8u7gQ+ItaQL/geMRk5vYGsMmVleteFw3z7MH+
         8/tAslbxPmEUeIUqzRCl9YjY0iELFYA1GoRfX4rWIbRF6hOzIZg8gMtbOV2gCeJ7u4Pq
         bn6cKLStRLZY5usitdGqdoGWZQLtUZF2EfYxf0gIuZNjqMoGFC3PS5+6YxSpcLGZ/AvZ
         vgTg==
X-Forwarded-Encrypted: i=1; AJvYcCVzqqZPbYqnrCzd0UQYRNFmbGMTZ40R+Mm+Jw2xwSHXoHdMptWJ4aWTa3iIlywoiPGvosMwcw8pGzC/Qs0cA1gTBbPc2uRBpl4bPMa1
X-Gm-Message-State: AOJu0YzpJKSwRV/ybFfXFFFl/zcGy0+5o92c9wAiH+o9k0zn9L6tgPSJ
	wfvV3r4PFuCMibC03GMgtaJU6B9f1+efGpL9OezryLWRy5Glz70nZXfkDaJthYw45AI9Av8Gm7s
	FK44EPr2Xq8oYRRfw+snWGlYJ0qRrlgWdMX4TKFkuLWYQSEZMEFGPRlLaynI6G6zNINvclHWGTH
	ARB+WWQI4xOZ6Z1QWlj0RDLwtm2rKyD+PBr/Q/
X-Received: by 2002:a92:c006:0:b0:368:8d92:3262 with SMTP id q6-20020a92c006000000b003688d923262mr6507179ild.2.1713100546209;
        Sun, 14 Apr 2024 06:15:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHfCfuM8ItSMcRThrMGuKy7IWQL34kylDbIEss835twvGM4ein8hFI0+wZrivGJDJGhvKq9lSGaQtSik6eZXw=
X-Received: by 2002:a92:c006:0:b0:368:8d92:3262 with SMTP id
 q6-20020a92c006000000b003688d923262mr6507171ild.2.1713100545915; Sun, 14 Apr
 2024 06:15:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409042238.1240462-1-bhe@redhat.com> <CALu+AoRB=kK00ecpboSJxpNqP+ERZaUrS+h-oo+uaXLoYPYT_Q@mail.gmail.com>
 <ZhtFUT3Xmab3CqoI@MiWiFi-R3L-srv>
In-Reply-To: <ZhtFUT3Xmab3CqoI@MiWiFi-R3L-srv>
From: Dave Young <dyoung@redhat.com>
Date: Sun, 14 Apr 2024 21:16:02 +0800
Message-ID: <CALu+AoQXKR4P2G02kyLYiALGU+EoqWVYVAtv5rfD2Ce1hAbszQ@mail.gmail.com>
Subject: Re: [PATCH v2] kexec: fix the unexpected kexec_dprintk() macro
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, jirislaby@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Apr 2024 at 10:54, Baoquan He <bhe@redhat.com> wrote:
>
> Hi Dave,
>
> On 04/12/24 at 03:28pm, Dave Young wrote:
> > On Tue, 9 Apr 2024 at 12:23, Baoquan He <bhe@redhat.com> wrote:
> > >
> > > Jiri reported that the current kexec_dprintk() always prints out
> > > debugging message whenever kexec/kdmmp loading is triggered. That is
> > > not wanted. The debugging message is supposed to be printed out when
> > > 'kexec -s -d' is specified for kexec/kdump loading.
> > >
> > > After investigating, the reason is the current kexec_dprintk() takes
> > > printk(KERN_INFO) or printk(KERN_DEBUG) depending on whether '-d' is
> > > specified. However, distros usually have defaulg log level like below:
> > >
> > >  [~]# cat /proc/sys/kernel/printk
> > >  7       4      1       7
> > >
> > > So, even though '-d' is not specified, printk(KERN_DEBUG) also always
> > > prints out. I thought printk(KERN_DEBUG) is equal to pr_debug(), it's
> > > not.
> > >
> > > Fix it by changing to use pr_info() instead which are expected to work.
> >
> > Could you also update the kernel/crash_core.c and
> > kernel/crash_reserve.c to include the filename prefix?
> > #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> When I added pr_fmt() to kernel/crash_reserve.c and tested code, the
> printed boot log about crashkernel reservation is changed as below:
>
> [  +0.000000] crash_reserve: crashkernel reserved: 0x000000007d000000 - 0x0000000095000000 (384 MB)
>
> When I looked around, I noticed all other lines around don't have the
> module name printed out. Seems it's not appropriate to add one for
> crashkernel alone. And the kexec_dprintk() doesn't exist in
> kernel/crash_reserve.c. Furthermore, the kexec_dprintk() is added to
> enable debugging printing for kexec_file_load when loading kexec/kdump
> kernel. This crashkernel reservation may not be related. Combinbed these
> all, I would suggest not adding pr_fmt() for kernel/crash_reserve.c for
> now, let's add pr_fmt() for kernel/crash_core.c, what do you think?

Hi Baoquan,  I'm fine with it.

But adding pr_fmt is always good as all the pr_* will have a prefix
instead of manually add "crashkernel:" in every pr_warn etc.  There
are indeed a few without any prefix in this file though.  But it can
be done separately, not necessary to be done here together with the
debug print though.

Thanks
Dave

>
> >
> > >
> > > Fixes: cbc2fe9d9cb2 ("kexec_file: add kexec_file flag to control debug printing")
> > > Signed-off-by: Baoquan He <bhe@redhat.com>
> > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > Closes: https://lore.kernel.org/all/4c775fca-5def-4a2d-8437-7130b02722a2@kernel.org
> > > ---
> > > v1->v2:
> > > - Change to use pr_info() only when "kexec -s -d" is specified. With
> > >   this change, those debugging message for "kexec -c -d" of kexec_load
> > >   will be missed. We'll see if we need add them for kexec_load too, if
> > >   someone explicitly requests it.
> > >
> > >  include/linux/kexec.h | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index 060835bb82d5..f31bd304df45 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -461,10 +461,8 @@ static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) {
> > >
> > >  extern bool kexec_file_dbg_print;
> > >
> > > -#define kexec_dprintk(fmt, ...)                                        \
> > > -       printk("%s" fmt,                                        \
> > > -              kexec_file_dbg_print ? KERN_INFO : KERN_DEBUG,   \
> > > -              ##__VA_ARGS__)
> > > +#define kexec_dprintk(fmt, arg...) \
> > > +        do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> > >
> > >  #else /* !CONFIG_KEXEC_CORE */
> > >  struct pt_regs;
> > > --
> > > 2.41.0
> > >
> > >
> >
>


