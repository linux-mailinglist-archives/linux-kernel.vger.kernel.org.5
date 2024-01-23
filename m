Return-Path: <linux-kernel+bounces-36097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4420839B81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878A71C215F3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145847F5D;
	Tue, 23 Jan 2024 21:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aTh0YbBO"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8043FB09
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046874; cv=none; b=BXJzWlnig+afa0m+7Mg5RaxN1z05ELlePXb0GTJmOXIGEdNatTMidq0krCoxaEBIBCmSU4MOGLvSCbb8a30KP8bsVN/aUmAHbrjstk+SfTdKHO37xmlKrXTNKwJyX4jwGnp2QwyNZvAiYTutMeI9wiv6AZejYnox8Zdo28ZoGkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046874; c=relaxed/simple;
	bh=OyptoQZgrz1X8m1OAIxrZM7I+UrxAKsz3tc4tHk75g0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=We1Pl8XlkSH0/p0GkRHasZsEqk+2bI6kJPSNztDvIfKkqVr3XMegJJ0vKVXLAE7j6dFz4Mg5RJxeXg0CitSiP23pt66IcpqKY9QHH9MW0gY6P5JluMa3zfun6L+3BpykA0nEU869aaDZbgOEBchX/9xY904JtonQsTBYd7x8rlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aTh0YbBO; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dd82bfa998so892593b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706046872; x=1706651672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=16BHFWN5mZqDE+m/8++0MKdvvntMugYUqf/gfAr3/kk=;
        b=aTh0YbBOe5KdtcoJamLZVZjRKWh7HEVknl7PbdqPBghsOwTTm4pPofn1rAuQX5dknT
         dcbrvtIeir1jIK2hcr+Q47z6weUntBMmKytFsRYR3ZW1HVgd4uFJpSrYBnPCnR3zMams
         uqcj2jYCWePy27CdB0EHXxfL4mKhV8Jg9D9Pk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046872; x=1706651672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16BHFWN5mZqDE+m/8++0MKdvvntMugYUqf/gfAr3/kk=;
        b=GVJBHfBkXPzjdBble7SsoI6Qhob8L96BGNMjWvLt1bFlRxtrvl5GPW7LbOkbfItwTB
         xFI5eT9pX+KsiqRaiX9QgoAjUiFZBU59jr6xeQ9iEdfq7wjdK3oXtxSEfh0cwlQNe+US
         dJnJBPcVuThW+zfOtTaT59n8Wol5ICtKiog7+mvOMn+F4LMH6aM9SmY0gb6Gwr8NtiPY
         z7NnQDGAiYkxIiW1og7e9PUif0v3xSafWK3SXfr+1PKESZe7uAKIA9wuiIzj3hMPWMf1
         PROZosUeJsq9m5w1IBVYUXvj0XkC+5hmPl0GehQpQq1VU67dJUQ0PxRrfnsvJ5zhkled
         syKQ==
X-Gm-Message-State: AOJu0YyUjwdHJJaRbM7NCP9Gd4wZPv17cGq6RpqVN9tr+AHYyE/ejuBR
	zaZ+tzNl8Eolp1OqlGKR2oNq51EzR/ErEDjV7cV4MRkC1hwa6M0l4MJk3dLf4g==
X-Google-Smtp-Source: AGHT+IE8xK8v5OyPoVXhFhlYATfCJ5ikAR9uO9SWATCJ9F5lbjhJZjmG8W8l8y+KkO6ctC60W2qk1Q==
X-Received: by 2002:a05:6a20:6f9c:b0:19a:788a:1c6a with SMTP id gv28-20020a056a206f9c00b0019a788a1c6amr7906708pzb.79.1706046872539;
        Tue, 23 Jan 2024 13:54:32 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x34-20020a056a0018a200b006dd873f44e7sm371966pfh.115.2024.01.23.13.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:54:32 -0800 (PST)
Date: Tue, 23 Jan 2024 13:54:31 -0800
From: Kees Cook <keescook@chromium.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-hardening@vger.kernel.org, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/82] locking/atomic/x86: Silence intentional wrapping
 addition
Message-ID: <202401231353.7AEF98F625@keescook>
References: <20240122235208.work.748-kees@kernel.org>
 <20240123002814.1396804-10-keescook@chromium.org>
 <Za-GfqSFEA_4fUtA@FVFF77S0Q05N>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za-GfqSFEA_4fUtA@FVFF77S0Q05N>

On Tue, Jan 23, 2024 at 09:27:26AM +0000, Mark Rutland wrote:
> On Mon, Jan 22, 2024 at 04:26:45PM -0800, Kees Cook wrote:
> > Annotate atomic_add_return() to avoid signed overflow instrumentation.
> > It is expected to wrap around.
> > 
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Boqun Feng <boqun.feng@gmail.com>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: x86@kernel.org
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  arch/x86/include/asm/atomic.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/include/asm/atomic.h b/arch/x86/include/asm/atomic.h
> > index 55a55ec04350..4120cdd87da8 100644
> > --- a/arch/x86/include/asm/atomic.h
> > +++ b/arch/x86/include/asm/atomic.h
> > @@ -80,7 +80,7 @@ static __always_inline bool arch_atomic_add_negative(int i, atomic_t *v)
> >  }
> >  #define arch_atomic_add_negative arch_atomic_add_negative
> >  
> > -static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> > +static __always_inline __signed_wrap int arch_atomic_add_return(int i, atomic_t *v)
> >  {
> >  	return i + xadd(&v->counter, i);
> >  }
> 
> I think that here (and in the arm64 patch) it'd be better to use add_wrap() on
> the specific statement, i.e. have:
> 
> static __always_inline int arch_atomic_add_return(int i, atomic_t *v)
> {
> 	return add_wrap(i, xadd(&v->counter, i));
> }
> 
> ... since otherwise the annotation could applly to the '+' or something else
> (e.g. if the 'xadd() part is a special macro), and the annotation might
> unexpectedly hide things if we add other statements here in future.

Okay, sure, I can do that. I may have some header inclusion problems,
but I'll give it a shot.

-- 
Kees Cook

