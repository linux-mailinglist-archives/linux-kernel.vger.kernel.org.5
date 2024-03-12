Return-Path: <linux-kernel+bounces-100446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7DD8797AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04F8E1F2169F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EB27C6D6;
	Tue, 12 Mar 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h7H0+sAP"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904C27BB08
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257700; cv=none; b=IrvXlFz94B4Eyp1fyzj6UZHlDrRVM7Q3z1798kK54K3undLoEyIGd4bM2DLxJNggT3wNk/Pk2BuP7ph2wkgONzwNhBO6mG3w4IrS074WFKyVai8oydpHNsjIZ9VMzgvFQRYvwhHbArEtiSvXWIn5HN2+z4p8ErIIxcqlhV4ojjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257700; c=relaxed/simple;
	bh=pGUcJmWXTyukCSFUwFhKmbOeTOCsHmo7jhwLVc+Cn1Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uPbmzUhwkV6ZwRoIOIwFbsVduy2RWW/t1ZMsePsn367thKf2ThV1jt4nfAJ3DfQ4CgP2iDKounu68w9gev6EBbltNBR5tjzdcovAMsCyPXUPALtm6Xqo0C0wtv+HrHx0/0x6Jd35mLBZWb0nuPKxG8YKUFHpO3ZPB963uCaY8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h7H0+sAP; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a20c33f07so53493567b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710257697; x=1710862497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KzR+McFxR/OTQhr4rH9hfsDERCQOrw3TFBf8AroZgQI=;
        b=h7H0+sAPdWkwtaf1rBloG8YY2RYJePQDHUw+/Ln416MjI0ZhiykkdVpzpWTY8ujAzc
         9LA8u9JJzxo/oRG3BoR8XHkKH7Iw/9SXJ2MMkBDqumw8hPd+y70aMbN5nuTsrTYgA3jR
         +X2iBksEUh8XwDcOFWzX08BsFDDORQ6w9YB7vjioJ1HRJ9GkopDNwmJBnnfQMqKudcS8
         n29CXBxhvv9uK/x2XkIQHXMaGkLVv/b721j21xavCM1pm0ISx81A0lDGDhRAIAXx8N1y
         ybY8NsAkv4iOrDmmwCI4RhsG00NqqVndrwP/pHEPMNrWdnk8UdkPn4O4RcFWONzCapGA
         3FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257697; x=1710862497;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzR+McFxR/OTQhr4rH9hfsDERCQOrw3TFBf8AroZgQI=;
        b=v+vyrnoFETvphXA9h3tLrW3uhWYajoOYo80eFkvH68/VOXcFklQEBZTlimLS5dGy/5
         2Var0E2SQDzPFC5yxqeNlFWf1nNCT+qy1gLeGQ41GG53o09dqaz6gTMSiUzcqiZho8DJ
         Bi0DDlhpnzlkE3uSlIgnXCpHpGVl7AcK3pE9FRmnv31PdAsTPZumqVLr5bAi5H3OyPhp
         Ps4AvJCTU43xFZwFJ0UW8UUSpBbfztb8zcLdiRBj01XaQ8kGxMRmmBRVCiw4CCgfSz5A
         dh2qUK19vRkdFXCOoBrCEOrrqspBgufw9IsTa1A4JhyOOPPUd3S33lQV9ebQjP5AGkao
         9M5w==
X-Forwarded-Encrypted: i=1; AJvYcCU9U8tibnqU5PSoTbSa2DuUe0UAYW6wN4rfdPJhz5Ee2Asx77qdZibhtRTI95C+vnT5RY0S/0k52Urm1ub+bfBG1NEXLYwuMuFyXMLQ
X-Gm-Message-State: AOJu0YxLNVApp/k9P2RHfDj+nNHOZ1tbKPLMHrK7YUKG9UQ3Y3MWxk78
	Y0HWACbIB7hbfNYkr2dGEPSd3y6ZDGP4Y/l9E1+1RJr/CHCV9zzKpnpzwRwEqASIv6T2s2viwbj
	O22en56g6qmTjElpizw==
X-Google-Smtp-Source: AGHT+IGl5KiWLmiWgIlSDFPn08YN7J4pt2F+TALRpg5GfylVc4h+AleiTegFVKsV3qZe49owjtCjrvUMMLzVVAZO
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:98a:b0:dc9:5ef8:2b2d with SMTP
 id bv10-20020a056902098a00b00dc95ef82b2dmr2524948ybb.4.1710257697643; Tue, 12
 Mar 2024 08:34:57 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:34:55 +0000
In-Reply-To: <3a56vovcqy7ju5og76nqlekfruq42i56wmp4oek3jgkffvzjby@q5guufebkpzr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240312035951.3535980-1-yosryahmed@google.com>
 <20240312035951.3535980-2-yosryahmed@google.com> <3a56vovcqy7ju5og76nqlekfruq42i56wmp4oek3jgkffvzjby@q5guufebkpzr>
Message-ID: <ZfB2HyzkWzaAQHYo@google.com>
Subject: Re: [PATCH 2/3] x86/mm: Fix LAM inconsistency during context switch
From: Yosry Ahmed <yosryahmed@google.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 12, 2024 at 02:35:46PM +0200, Kirill A. Shutemov wrote:
> On Tue, Mar 12, 2024 at 03:59:50AM +0000, Yosry Ahmed wrote:
> > diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
> > index 76e91fc68c5f3..748d2b3bdb985 100644
> > --- a/arch/x86/kernel/process_64.c
> > +++ b/arch/x86/kernel/process_64.c
> > @@ -753,10 +753,12 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
> >  static void enable_lam_func(void *__mm)
> >  {
> >  	struct mm_struct *mm = __mm;
> > +	unsigned long lam = mm_lam_cr3_mask(mm);
> > +	u64 untag_mask = mm_untag_mask(mm);
> >  
> 
> Maybe push these mm dereferences inside the if block below?
> I am not sure if compiler can re-order operations past this_cpu_read().

I am not sure either, so I will push them inside. Better safe than
sorry. Will send a v2 shortly, thanks for the reviews!

> 
> >  	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
> > -		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
> > -		set_tlbstate_lam_mode(mm);
> > +		write_cr3(__read_cr3() | lam);
> > +		cpu_tlbstate_update_lam(lam, untag_mask);
> >  	}
> >  }
> >  
> 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

