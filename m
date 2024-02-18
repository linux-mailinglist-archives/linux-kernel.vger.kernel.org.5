Return-Path: <linux-kernel+bounces-70308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6774E8595E2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79ACC1C214C2
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A87011CAF;
	Sun, 18 Feb 2024 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TAhcGFc2"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3FEAEB
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708247091; cv=none; b=EgscWihPm/CjmKOXvICO2BxXMTlHQcZqJAyvlYdnrFXRQvtqxKVvCKrfnOVxXXF0yGEKCEXcAkQfBV4EtBmheEOjO6GGbXeUPKYPXQxRMhu1MKUvYJlyqMighPkPPXmAoonzK8Jkwf0RZugYLiKTJbYRXEw6s6XUfY6Dm7JcBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708247091; c=relaxed/simple;
	bh=gsfp648GSeu4GSSGGmUz6uwvgJjtHhBRQ1HuetedarU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkI+tlhroqORXwtEWkGY2qMFAF+tYdorRO9V6xde9kq/rm4foIYp89l+XrVhafLg/RK0x6yCdkAcU3Np7K37IoHW58CpKpcHzPkIE72WOJn91HxGZemYghTZx1GgFUMNLsp2fWAfhvPXkAiT1gh8YODvDo/6ACW5jD3SA/gLMVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TAhcGFc2; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1d944e8f367so29578595ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 01:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708247089; x=1708851889; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+PSGviE7P+pWKcxbR82hBe0e7HZtwlv0NsdYte+C5Ww=;
        b=TAhcGFc2D+xw4WANX79tqHrNVyJ1xT70hoVNMELKMJFfbftr0gGCaun5vsCqqpWcDv
         tLwpHYldPgkhpfKrqNsJ6QLPTHf16LEncrKuM6t3MNOYNPqCcom5AbGcE+FXjYM93MAl
         zK0DUY7Rrmm7X5YWkHj5ZDwPbJuzoWGKTh8cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708247089; x=1708851889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+PSGviE7P+pWKcxbR82hBe0e7HZtwlv0NsdYte+C5Ww=;
        b=ZSHH/VZy7WGaqkpxHLwlJij49WVK7FkwaCFV7G1z2wUkyRD1SuifHt39ijP5/m88Uz
         cyWAUWG4dyJI3Wm4cFKllFwtKbHBQkg3Fpg1ngzZl+dMIPdugfM3Gg2NWEw1o648WhVt
         /iAjZeh/CGM4enP8pHk1/X0Qwu+S1QXp8Ygsl1y16zrTSpqGiEfUf+YUi3xChznKFDWP
         0ap57VW7jlG7BgOsSN/U0m5nbbuMQsnOtd8ASSVkTnKtp4JqAs7nFGe+7L5eCnd90zig
         f7wRv38QABBiOFNx+xPWwdcIjyaD0PXNG2LKiWsl9mo8oKhq7JuIJhh1dhJnbRgfT67G
         lRJA==
X-Forwarded-Encrypted: i=1; AJvYcCUYaxHaeeEYjVALJ9SzH8qqxoJue1qwH1wf47uAZvULKOdELSH9NiLzkyUP6AtYK1KKAQQ8QDc2MUvTCzsC1gOwOZd7DJQMVhP9b/FD
X-Gm-Message-State: AOJu0Yw95a4dNKhZbJe4FCsStReIG8cvD7Qiwui6xnqP6Zj0jRjgJ1OV
	YgQczPFkP20EYeIhTODX5EGNU0kqJAOA3QgmEYSIRTzXmTqr1BFif1uKZHOJ5w==
X-Google-Smtp-Source: AGHT+IE8Ghl8NWV5BRDjTffg6tAQE1Fy/8QmYMG3CMSvf0PFWMiDr/5Kpsv3BwMiRgjuLIrzy52Cbw==
X-Received: by 2002:a17:902:778c:b0:1da:2bd6:a450 with SMTP id o12-20020a170902778c00b001da2bd6a450mr8279022pll.32.1708247089287;
        Sun, 18 Feb 2024 01:04:49 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v13-20020a170902f0cd00b001d8d1a2e5f2sm2435675pla.216.2024.02.18.01.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 01:04:48 -0800 (PST)
Date: Sun, 18 Feb 2024 01:04:48 -0800
From: Kees Cook <keescook@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Guixiong Wei <guixiongwei@gmail.com>, linux-hardening@vger.kernel.org,
	Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Guixiong Wei <weiguixiong@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC] kernel/ksysfs.c: restrict /sys/kernel/notes to root
 access
Message-ID: <202402180028.6DB512C50@keescook>
References: <20240218073501.54555-1-guixiongwei@gmail.com>
 <2024021825-skiing-trustee-a56a@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024021825-skiing-trustee-a56a@gregkh>

On Sun, Feb 18, 2024 at 08:47:03AM +0100, Greg KH wrote:
> On Sun, Feb 18, 2024 at 03:35:01PM +0800, Guixiong Wei wrote:
> > From: Guixiong Wei <weiguixiong@bytedance.com>
> > 
> > Restrict non-privileged user access to /sys/kernel/notes to
> > avoid security attack.
> > 
> > The non-privileged users have read access to notes. The notes
> > expose the load address of startup_xen. This address could be
> > used to bypass KASLR.
> 
> How can it be used to bypass it?
> 
> KASLR is, for local users, pretty much not an issue, as that's not what
> it protects from, only remote ones.
> 
> > For example, the startup_xen is built at 0xffffffff82465180 and
> > commit_creds is built at 0xffffffff810ad570 which could read from
> > the /boot/System.map. And the loaded address of startup_xen is
> > 0xffffffffbc265180 which read from /sys/kernel/notes. So the loaded
> > address of commit_creds is 0xffffffffbc265180 - (0xffffffff82465180
> >  - 0xffffffff810ad570) = 0xffffffffbaead570.
> 
> I've cc: the hardening list on this, I'm sure the developers there have
> opinions about this.

Oh eww, why is Xen spewing addresses into the notes section? (This must
be how it finds its entry point? But that would be before relocations
happen...)

But yes, I can confirm that relocations are done against the .notes
section at boot, so the addresses exposed in .notes is an immediate
KASLR offset exposure.

In /sys/kernel/notes (are there any tools to read this? I wrote my own...)

	type: 1
	name: Xen
	desc: 0xb4a711c0 0xffffffff

which matches a privileged read of /proc/kallsysms:

	ffffffffb4a711c0 T startup_xen

(and the hypercall_page too)

There are all coming from arch/x86/xen/xen-head.S:

        ELFNOTE(Xen, XEN_ELFNOTE_GUEST_OS,       .asciz "linux")
        ELFNOTE(Xen, XEN_ELFNOTE_GUEST_VERSION,  .asciz "2.6")
        ELFNOTE(Xen, XEN_ELFNOTE_XEN_VERSION,    .asciz "xen-3.0")
#ifdef CONFIG_XEN_PV
        ELFNOTE(Xen, XEN_ELFNOTE_VIRT_BASE,      _ASM_PTR __START_KERNEL_map)
        /* Map the p2m table to a 512GB-aligned user address. */
        ELFNOTE(Xen, XEN_ELFNOTE_INIT_P2M,       .quad (PUD_SIZE * PTRS_PER_PUD))
        ELFNOTE(Xen, XEN_ELFNOTE_ENTRY,          _ASM_PTR startup_xen)
..

Introduced in commit 5ead97c84fa7 ("xen: Core Xen implementation")

Exposed in commit da1a679cde9b ("Add /sys/kernel/notes")

Amazingly these both went in on the same release (v2.6.23, 2007). This
has been exposed for longer than KASLR has been upstream. :P

> 
> > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > ---
> >  kernel/ksysfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
> > index b1292a57c2a5..09bc0730239b 100644
> > --- a/kernel/ksysfs.c
> > +++ b/kernel/ksysfs.c
> > @@ -199,7 +199,7 @@ static ssize_t notes_read(struct file *filp, struct kobject *kobj,
> >  static struct bin_attribute notes_attr __ro_after_init  = {
> >  	.attr = {
> >  		.name = "notes",
> > -		.mode = S_IRUGO,
> > +		.mode = S_IRUSR,
> >  	},
> >  	.read = &notes_read,
> >  };

Yes please.

Reviewed-by: Kees Cook <keescook@chromium.org>

I wonder if we should also remove relocations that are aimed at the
notes section for good measure? If that had already been true, this
would have just given the same info as System.map.

> 
> No objection from me, but what userspace tool requires access to this
> file today?  Will it break if permissions are changed on it?
> 
> And what about the module notes files?  If you change one, shouldn't you
> change all?

Luckily all of _those_ contain what I'd expect: the Linux and
GNU.build-id notes, which are harmless. But if we're going to suddenly
have things appearing in here, let's make those root-only too.

-Kees

-- 
Kees Cook

