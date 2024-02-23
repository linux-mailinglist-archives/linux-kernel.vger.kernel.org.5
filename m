Return-Path: <linux-kernel+bounces-77706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807C7860941
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBD41C2381E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E51C8DE;
	Fri, 23 Feb 2024 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbrNLO90"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A990BE7D
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 03:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708658026; cv=none; b=PYr5I0xNVnGxCSOXI7V0ZMYQ0Bz4cvq8X7g685i2JWw+ZTYSyVNgXPSP5jlu3lE+ltwd3H0eoxOSvOwG59BiDyXHl/FIcWVY0LJ3QGFKPARDiGq/jRkSWDaevqXkE8MPDfmH8+qW5Il5q4XDnBKX0Lj0e9ll2x0M9wqpEQtUBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708658026; c=relaxed/simple;
	bh=3zkkEbAJlKLNP+UaFJFqnfBoNMZMEvXA6R5x3BVLYTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ln/s6guAwJpbWBMcGTT/CNW31hQLBcFuyGZztJQMD4cgJvwSYhhUkwtIh65v29vqG4+/iZuB7YXmsXu4IdssDPqvYcD7YjIJxXsb+X08Rz7u4UulZjWa58RaGVOV0zw3+OjrX7MW6IBWc7gTuuODw3rmkSDQt7hwHQF0sjq1LpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbrNLO90; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708658023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pAKJzqMYQqro/eDf8dVWLxpbZKJNEMaB2NraCmbEvw=;
	b=PbrNLO90KNJLAkP7/hVDSsnMPD/vTUhk7QL/SIv9qcddEZQWV8C9DeDr34X20USIRwqgoG
	TtdUAIIwXbcjRzjQbYqMzRRKSr2rzm2wW0wYjNN3DbLsfd5QL6pATwYV2HPFsokx1KoSWe
	nJaHCWkXgnLPRSs+QfzySkgqdOLGxeM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-s5Jb8DDWNEW8m1letIY-lg-1; Thu, 22 Feb 2024 22:13:42 -0500
X-MC-Unique: s5Jb8DDWNEW8m1letIY-lg-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3651eecf80dso764165ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 19:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708658021; x=1709262821;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pAKJzqMYQqro/eDf8dVWLxpbZKJNEMaB2NraCmbEvw=;
        b=sy8mEwpPbI3GkrcJYZ3n5xQ/9bS3LrEME/4SOo0U7yncErAvqJEwoFPkr3gXGg5Fh6
         EEFKa7hCcC2NZJCWQvlDgIeFC8mGP873XMFStmQikjoSk/4i71sH3Jxdewn/tzoDaani
         eP/u4WxaswVFPTyTJn3EL5xa3yK00ov980ebIz791L3ZQZpDMTj6ZUxmsSQRsv3cKsFJ
         heRHpd1PFL2sYu3Bg3VnjrmxcbGIINrwfT3B5iahm4/Ck+H85nc7h/hh7FFXZmo85x++
         ogcrG2JgkqdkBmYMknG00DpMmJ1OCUFTVYFumQelww+SArKMdCsHEQRrgXGj0YU6umW/
         aLvg==
X-Forwarded-Encrypted: i=1; AJvYcCXsDVgEJ9sh4ydrWBsrFcrzQ49SJbGBEp4oe0ySbh5N4u6yZUAyMaYWid6DZwuiosDCDTGgN/UTu1Dy2zTqEv9DrkldJ0qyhfHDfkCK
X-Gm-Message-State: AOJu0YwZcULMZiEz1cuzncLyfp1Eni8ULPYx+Rksueqj7pTa1aLv8KIS
	nsLbOOi/a3ja9TUSAuOQfNJp1EAqEmxn9J2GOC1o9niUwqdrNMUR+yJcYc7RklWKgZONrso/xBi
	xKu3lCOO0DSIN5n8y3kbOzB5SMTGnj2K2A98CsNLigSEz7qmT2O/8vWTkFQHYPOoixGcmO8+pvx
	yMum0w1/jlShyOyC6KWk28UBzycFETP97zge2S
X-Received: by 2002:a05:6e02:1aaf:b0:363:cec2:e344 with SMTP id l15-20020a056e021aaf00b00363cec2e344mr870190ilv.2.1708658021339;
        Thu, 22 Feb 2024 19:13:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9Y8JCNXscGRPt3OW4iI6+5q1xtY+ubgTDk/wHyv49Z26XfBHk6aPHzxYet+4FzB6UTcxB1fypYFRNYA0D0xs=
X-Received: by 2002:a05:6e02:1aaf:b0:363:cec2:e344 with SMTP id
 l15-20020a056e021aaf00b00363cec2e344mr870181ilv.2.1708658021065; Thu, 22 Feb
 2024 19:13:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706698706.git.kai.huang@intel.com> <cd88e97e53c502f0a457d6a82a31d9e8e0f9fca7.1706698706.git.kai.huang@intel.com>
 <20240219161611.GBZdN-y6DO-cspaZrf@fat_crate.local> <9164b0e3-f520-4aab-8b80-520131f0e4db@amd.com>
 <20240219203222.GIZdO61ucfq4bFxRT0@fat_crate.local> <283877fd-78c7-4322-bbce-ba6420d56765@amd.com>
 <20240220142812.GBZdS2_HJEA50F8RZD@fat_crate.local> <28a494ca-3173-4072-921c-6c5f5b257e79@amd.com>
 <ec58908ac8bc7d953d4c00825217615918436721.camel@intel.com>
 <24844584-8031-4b58-ba5c-f85ef2f4c718@amd.com> <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
 <f01b2ad1fe239444148bded21ae4df64e3f267f2.camel@intel.com>
In-Reply-To: <f01b2ad1fe239444148bded21ae4df64e3f267f2.camel@intel.com>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 23 Feb 2024 11:13:44 +0800
Message-ID: <CALu+AoQKmeixJdkO07t7BtttN7v3RM4_aBKi642bQ3fTBbSAVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
To: "Huang, Kai" <kai.huang@intel.com>
Cc: "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "bp@alien8.de" <bp@alien8.de>, 
	"Gao, Chao" <chao.gao@intel.com>, "luto@kernel.org" <luto@kernel.org>, 
	"Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com" <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, 22 Feb 2024 at 19:50, Huang, Kai <kai.huang@intel.com> wrote:
>
> On Wed, 2024-02-21 at 10:28 +0100, Borislav Petkov wrote:
> > On Tue, Feb 20, 2024 at 04:30:13PM -0600, Tom Lendacky wrote:
> > > I believe the issues were that different Intel systems would hang or reset
> > > and it was bisected to that commit that added the WBINVD. It was a while
> > > ago, but I remember that they were similar to what the 1f5e7eb7868e commit
> > > ended up fixing, which was debugged because sometimes the WBINVD was still
> > > occasionally issued resulting in the following patch
> > >
> > >   9b040453d444 ("x86/smp: Dont access non-existing CPUID leaf")
> > >
> > > It just means that if we go to an unconditional WBINVD, then we need to be
> > > careful.
> >
> > Let's try it.
> >
> > Dave, do you remember what issues
> >
> >   f23d74f6c66c ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")
> >
> > fixed?
> >
> > If so, can you try the below diff ontop of latest tip/master to see if
> > those issues would reappear?
> >
> > Thx.
> >
> > ---
> >
> > diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> > index ab49ade31b0d..ec4dcc9f70ca 100644
> > --- a/arch/x86/kernel/process.c
> > +++ b/arch/x86/kernel/process.c
> > @@ -824,8 +824,7 @@ void __noreturn stop_this_cpu(void *dummy)
> >        * Test the CPUID bit directly because the machine might've cleared
> >        * X86_FEATURE_SME due to cmdline options.
> >        */
> > -     if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
> > -             native_wbinvd();
> > +     native_wbinvd();
> >
> >       /*
> >        * This brings a cache line back and dirties it, but
> >
>
> I really appreciate if Dave can help here.
>
> I will also reach out to see whether there's anyone in Intel met this before.

I forgot the details now,  let me recall and try the patches if possible.

Thanks
Dave


