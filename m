Return-Path: <linux-kernel+bounces-78168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1D8860FC0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCC11F21B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A488D76C62;
	Fri, 23 Feb 2024 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzknDrzM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676417E76C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708684872; cv=none; b=GvkHk4sBEuimY/mcJ90V15YSHqnMYOEG7GpFCDPceBKBbzWa6kLcqGwmwMHZ0sVAKx/119g2Po4byjJWI2ideX+w1jV2D+cLuFLPfiz7N3kfpafgu5NHAEvVEslRCnNcfNRqEIi1j9cSiiDSKdksEQM2vuljQ1wq9CmcUzwD/n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708684872; c=relaxed/simple;
	bh=Icm7F4lmP/Jc27F0+RY2e/dunKVD/r47YwAi7jH7tFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqhwHDVPuXj1BbhP2LNnVHcd5qp+QW7dfedczsddCzvaOnFMs+uEgl1k14CQwUOo4FzsdIEOIVwmxaXsprutrbG+MClIITuGaWl/qiJ7pcza+FLwoPVJc0ZghFwtCjEDDRjZIJ+Rda41nyfQrUBSFr7SYdGNoyH5wE+j7GiluZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OzknDrzM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708684870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IbJVCZsqW2HLU74a8q+3Nkog0H8W+yswj5MrZokKo1A=;
	b=OzknDrzMAV5f5QKjOTR7SiDHmqYGkkj2e8WyonlxK9RsqXoBswoUb6TGXCnGyW7CFuotL2
	W43RAX72i6A++yTx11Cqlq3DfXxGhjnSirqTSlHx+PBsQ/J9FBqPTqDfUzwp/+MXzICPJi
	a9YE5DG5qjKrAtmwd8gRkOgRTvwY4NA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-nFTNake8MOi8FZQ13nnEIw-1; Fri, 23 Feb 2024 05:41:08 -0500
X-MC-Unique: nFTNake8MOi8FZQ13nnEIw-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c79d2f8623so5646339f.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 02:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708684868; x=1709289668;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IbJVCZsqW2HLU74a8q+3Nkog0H8W+yswj5MrZokKo1A=;
        b=KFfg4gnBU22ofeBWC85UpwvRZstzhKic0/W/hgTv82xyBr/DdbwxOmhXnnvD0cR6Qm
         T1HDRnls9d0SdkTanHM09N1HBY3golaIxdTocTx+4CNIkEmPCN7oRhoH63qTaVop2+lO
         2/yOFpdMmTTSGX4MLb6R1bak28FoRINBQTA1nkOyTPJ3iz9eZYa1ng2xyLNm0BRHSg+y
         Z9LnZcWI6aFrKmsYAe3niOb6C1S4hs7/BVMMHyIzxxFnCaVRQZD6838aqWfbYkbtZ8nW
         Ng8yM8frhpXvDoOpdq9NjWNx7VTSeFev10SQyx9RKBYCuSajbpmFom8P2y77IbFiZjK2
         OFWg==
X-Forwarded-Encrypted: i=1; AJvYcCVAC7smuOW2pkT+bJSAfdBSTAYYrx8+bdoTby1gSFB1w13YLXwnKb+HFnhTITpMKu83I1foekOpJen4WnJqRek0JBVPkey36fH7l10u
X-Gm-Message-State: AOJu0YzvH6f57E1Mh1GSbhyV4RLjwmVhp5ErT/Eafv/vwSMCSDSWfgOl
	mmmvL0P7ZgX2rJB2rnatxZiTtJY9/Ti9gCuUIBIrs6X/P68mohpJlcjE8UDxy6Tg9W2Yfd7INkY
	LjIfy/mLfRXx6hvQWM5s5Zef+BC0NaLAaPo+rrNnuE+hUqghUQIz62Nsl272Hudps4ac2IEahQu
	AxITRj1pKXQSopeO1G6NN/FhUpLIunQtbPxQqi
X-Received: by 2002:a05:6e02:18cb:b0:365:2bd4:2f74 with SMTP id s11-20020a056e0218cb00b003652bd42f74mr1516092ilu.0.1708684867724;
        Fri, 23 Feb 2024 02:41:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+7AgseULCeRT+ASGfz8HwBTlsJFQ+GOOs05RUrz9aF8TI35YQIZufH4KccLxP6RVuEg5XHergCFMHSXv/eNc=
X-Received: by 2002:a05:6e02:18cb:b0:365:2bd4:2f74 with SMTP id
 s11-20020a056e0218cb00b003652bd42f74mr1516067ilu.0.1708684867339; Fri, 23 Feb
 2024 02:41:07 -0800 (PST)
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
In-Reply-To: <20240221092856.GAZdXCWGJL7c9KLewv@fat_crate.local>
From: Dave Young <dyoung@redhat.com>
Date: Fri, 23 Feb 2024 18:41:12 +0800
Message-ID: <CALu+AoR-VFHCK_7LHiJ3z_Vk1B=sFS90iAyCs9qmSmf2+XORLw@mail.gmail.com>
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

On Wed, 21 Feb 2024 at 17:33, Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, Feb 20, 2024 at 04:30:13PM -0600, Tom Lendacky wrote:
> > I believe the issues were that different Intel systems would hang or reset
> > and it was bisected to that commit that added the WBINVD. It was a while
> > ago, but I remember that they were similar to what the 1f5e7eb7868e commit
> > ended up fixing, which was debugged because sometimes the WBINVD was still
> > occasionally issued resulting in the following patch
> >
> >   9b040453d444 ("x86/smp: Dont access non-existing CPUID leaf")
> >
> > It just means that if we go to an unconditional WBINVD, then we need to be
> > careful.
>
> Let's try it.
>
> Dave, do you remember what issues
>
>   f23d74f6c66c ("x86/mm: Rework wbinvd, hlt operation in stop_this_cpu()")
>
> fixed?

It should be a kexec reboot failure describe in below thread:
https://lore.kernel.org/lkml/20180117072123.GA1866@dhcp-128-65.nay.redhat.com/

>
> If so, can you try the below diff ontop of latest tip/master to see if
> those issues would reappear?

It was reproduced on an old laptop (Thinkpad t440s or t480s, I can not
remember), but I have replaced them with a new different one.  I tried
the latest tip-master with the if condition commented out, kexec
reboot works fine.

Let me try to find an old laptop to see if I can do more tests, will
get back later next week.

>
> Thx.
>
> ---
>
> diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
> index ab49ade31b0d..ec4dcc9f70ca 100644
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -824,8 +824,7 @@ void __noreturn stop_this_cpu(void *dummy)
>          * Test the CPUID bit directly because the machine might've cleared
>          * X86_FEATURE_SME due to cmdline options.
>          */
> -       if (c->extended_cpuid_level >= 0x8000001f && (cpuid_eax(0x8000001f) & BIT(0)))
> -               native_wbinvd();
> +       native_wbinvd();
>
>         /*
>          * This brings a cache line back and dirties it, but
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
>


