Return-Path: <linux-kernel+bounces-84453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA186A6EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6B011F2A658
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2A1D6AA;
	Wed, 28 Feb 2024 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pirmd25V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AE71CD13
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 02:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088862; cv=none; b=u2llqJbMzbn6ktv8n0zF3TX7uGhRKIGmxVE5gggx9WvyFNz1rpzbnlgIvCaaXOXt+uMumSzQzJSKg88636pZaBL6KBUeP6JaX2jXVml2JEtc/eW4c8UflRN1fWaI7QHBW5ZVtYlAJti57eFlX6H6s9egtw+G/dzMfjBbYif/AfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088862; c=relaxed/simple;
	bh=nnF6Shl1G+eq8ay8WzAy8V439bQkW16xKmvGKio1KvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mlsj3MTnT9V6Wr1e5I/uMWKG/RJj9JHMQB0bH4Bt1oWkHxYA6dRD2xO8pYdLYzvozvTxE0NEx9s+aPJjS7VReTQ1WYZTJJIg92S5CPkympEFtxs9jr8zwxtfy9mTc+vqdJDGDlH+PlLQDhFeBh7TAoTe7kDfXXz1MbkeYYmdL5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pirmd25V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709088859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KFDcoUQa/a5vEgujpfE76YKoGoEcnkH0gIk3WiSZGAc=;
	b=Pirmd25VLBGz/LdJ4s6iKzaLSwK1XQY4gxR2jYTxaZ+EQq2SqarSejjy67LEwfUhtRAr6m
	LDTBMH8f9a8iQqDHJAx5wZMe9NPCnTZ9QlSjrsom49B738haycnw3pemyxPM7OIpcqBUOj
	X1EUt1fBhqe8nClBGj4jFucYEjyjkzQ=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-MzqWbdxDPSmtYscOGUNAZg-1; Tue, 27 Feb 2024 21:54:17 -0500
X-MC-Unique: MzqWbdxDPSmtYscOGUNAZg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c769ed7d46so124770739f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 18:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709088857; x=1709693657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KFDcoUQa/a5vEgujpfE76YKoGoEcnkH0gIk3WiSZGAc=;
        b=tUOuHANJXyM+k3sGA+Cx3SZWy1JW6wfamTl7pu8rkDyEHlwWuWOC8o4XVV45h7W1VR
         optgrCaT+leq/rjnjI3le3L3rQINtR6lAdkNA9kdot3hykXlr315YNzO2FHYZrMmKZRB
         YJEPJ3EMA3J5422gsCmEk2R/9I204B2IY/WGYUZJzFSR0MP1VgO2PkcIKaWHShmcLzps
         Wb6CHTuIqq1hep+N/HwPSYUO76kFp0UwEdJF2kQxHmoNnalQL5MvuV48glFiO/qNgMZd
         BXgDvDRcFllSp+RWw4Zgj2vb2O60H1GBTcVMUo7H3TDO5ba9D8k/A5n3zGOkSN226FZx
         ddBw==
X-Forwarded-Encrypted: i=1; AJvYcCUQTCocP3flVevCBYBe2kXLVqJOum6L2TVU/hoHJARNIVIC2g3L7Am+GEPEVvVZHZkRi9oTjt9sRrAgU9LwoJJ8MHsoFBZsJjRIe5Wp
X-Gm-Message-State: AOJu0YxWkXVOTPBmwa0A+hMz99NrfVUU6dUYGTq13PC6qMFSwNZJReXs
	sWey9dydsfFk4RB5RsguPkN0qvGtWixJPm0cFawbdx87sSnK8tPBxanBEtMkMDmMZGEhqDugT1/
	GfROEMx/gGYgfT0VqyjRbiuV3vqXepW1w2DwmH80FK4zLKmA4KtmsC2BBRBdV9PNeMjo+7Tntlo
	B6OK76WPwobVAjFV82GTypma1ukTSIwKN3U5EO
X-Received: by 2002:a05:6e02:1ca8:b0:365:4e45:63ee with SMTP id x8-20020a056e021ca800b003654e4563eemr11082380ill.1.1709088856803;
        Tue, 27 Feb 2024 18:54:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECTa+AffGk+pRAvw1YV6u3iDusp0tGAfD4njQLie6u65cr5cs2h8iux6vaJ/Y/Yo+TKIV3hV1Sea7a03euzag=
X-Received: by 2002:a05:6e02:1ca8:b0:365:4e45:63ee with SMTP id
 x8-20020a056e021ca800b003654e4563eemr11082362ill.1.1709088856537; Tue, 27 Feb
 2024 18:54:16 -0800 (PST)
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
 <CALu+AoR-VFHCK_7LHiJ3z_Vk1B=sFS90iAyCs9qmSmf2+XORLw@mail.gmail.com>
In-Reply-To: <CALu+AoR-VFHCK_7LHiJ3z_Vk1B=sFS90iAyCs9qmSmf2+XORLw@mail.gmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Wed, 28 Feb 2024 10:54:22 +0800
Message-ID: <CALu+AoSZkq1kz-xjvHkkuJ3C71d0SM5ibEJurdgmkZqZvNp2dQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86/coco: Add a new CC attribute to unify cache flush
 during kexec
To: Borislav Petkov <bp@alien8.de>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, "Huang, Kai" <kai.huang@intel.com>, 
	"Gao, Chao" <chao.gao@intel.com>, "Hansen, Dave" <dave.hansen@intel.com>, 
	"luto@kernel.org" <luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com" <hpa@zytor.com>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "bhe@redhat.com" <bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 18:41, Dave Young <dyoung@redhat.com> wrote:
>
> On Wed, 21 Feb 2024 at 17:33, Borislav Petkov <bp@alien8.de> wrote:
> >
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
>
> It should be a kexec reboot failure describe in below thread:
> https://lore.kernel.org/lkml/20180117072123.GA1866@dhcp-128-65.nay.redhat.com/
>
> >
> > If so, can you try the below diff ontop of latest tip/master to see if
> > those issues would reappear?
>
> It was reproduced on an old laptop (Thinkpad t440s or t480s, I can not
> remember), but I have replaced them with a new different one.  I tried
> the latest tip-master with the if condition commented out, kexec
> reboot works fine.
>
> Let me try to find an old laptop to see if I can do more tests, will
> get back later next week.

Update: tested on an old laptop as well,  I did not find any problems
with unconditional native_wbinvd(), kexec and kdump works fine.

>
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
> >          * Test the CPUID bit directly because the machine might've cleared
> >          * X86_FEATURE_SME due to cmdline options.
> >          */
> > -       if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
> > -               native_wbinvd();
> > +       native_wbinvd();
> >
> >         /*
> >          * This brings a cache line back and dirties it, but
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
> >


