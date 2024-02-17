Return-Path: <linux-kernel+bounces-69830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D5AA858F38
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 13:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CE4283820
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029696A031;
	Sat, 17 Feb 2024 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="rN5ApcSB";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="GiIaKHOb"
Received: from mailrelay2-1.pub.mailoutpod3-cph3.one.com (mailrelay2-1.pub.mailoutpod3-cph3.one.com [46.30.211.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F106A013
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 12:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708171242; cv=none; b=UZJMUFpBRc4z2rxtjTOLQ9OopM2WCNYS9SmkbELC6p4AJDL+OXtK7jyOiWsUsTKk48JmQvWOHsvzlCmg/Lq5GxOjpX7Tt5yG7iMXzJKgeovdb2u+fcGa1wIO5kzCWYTNR8DeqnSJiVxTJMYIrCuGyGcZYzj2VUpxvS+Wqi9M3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708171242; c=relaxed/simple;
	bh=WG1z83UKpdJV+VV7pjmtz1f6jWLNZux3gAGLTorgXpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euyrLQUA0f1SRTPM1XbRuwD06gGiFkEGquF6JjbruT9FvT3zz6tzNTwosejss4nNh1AhhxR/wbzdgkvN6zib1MGo2rQISVB+2TfiMpPz+LtuhDYmVFKaw8gi5tNhRkj01HTzskj940icu/YlDVsBZAUgwzHdwF4l8fNmv1xCjAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=rN5ApcSB; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=GiIaKHOb; arc=none smtp.client-ip=46.30.211.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=s8NBM6Yqo1gTI6vq9QpVDRtoet1whN/tjqnSSJZJzHM=;
	b=rN5ApcSBnK+CskdQo37NDW3+7WtTo/WYPbcp2SmArSAYErNvCgXAjJIJZAEOdFc4QPihhuM2Kt0E/
	 zabmz6EdgL3t/i5S8rEL4n+DO+FZ1FvGIMFYIqqU20v9QCNsuOoAFs6/of2pl3NunYKCUEoU3xqWbs
	 7QShR9tVNbQSknHjSWir3uSumoQOSf7C7FCkfExt+dHY2Cm5m+nD9KexIWSliQeMOvlsCGqRIEegn0
	 4Yr+kT4E1vKT22fgTTuW4Umy9JtRlAlSuY0Er5JNZ8o31pmoR6NUzOWE1C2xiH4lNG3h7qVoYMoWhn
	 J2jjkFFTFPVigiIBwjJ7NKsn7g4IcuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=s8NBM6Yqo1gTI6vq9QpVDRtoet1whN/tjqnSSJZJzHM=;
	b=GiIaKHObvA0d5L31U76EfSviff6iTllpFtubh+MHM3A8ElYXJxKfv5DKoEjMgZwzMl8jaX2QXDx87
	 ejjrFY8Cg==
X-HalOne-ID: ff4b2dc2-cd8b-11ee-9ac3-657348328a86
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay2.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id ff4b2dc2-cd8b-11ee-9ac3-657348328a86;
	Sat, 17 Feb 2024 11:59:28 +0000 (UTC)
Date: Sat, 17 Feb 2024 12:59:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>, Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 17/27] sparc32: Drop run-time patching of ASI instructions
Message-ID: <20240217115926.GA1564615@ravnborg.org>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <20231219-sam-sparc32-sunset-v3-v1-17-64bb44b598c5@ravnborg.org>
 <d1a616f1-0fd2-4af0-8b89-e0d0a8842a6d@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1a616f1-0fd2-4af0-8b89-e0d0a8842a6d@gaisler.com>

Hi Andreas,

> > diff --git a/arch/sparc/include/asm/winmacro.h b/arch/sparc/include/asm/winmacro.h
> > index b6e911f5d93c..c496b04cdfaf 100644
> > --- a/arch/sparc/include/asm/winmacro.h
> > +++ b/arch/sparc/include/asm/winmacro.h
> > @@ -108,18 +108,11 @@
> >  661:	rd	%tbr, %idreg;				\
> >  	srl	%idreg, 10, %idreg;			\
> >  	and	%idreg, 0xc, %idreg;			\
> 
> These three lines, including the label, should also be removed as they
> are not for LEON. Additionally, I think it would be best to split out
> removing the cpuid instruction fixups to one patch and the MMU ASI
> instruction fixups to another patch.

Nice catch!
I will fix this and split up in two patches in v2.
It will take some days before I have v2 ready, and I will base it on top
of your for-next branch in the sparc.git tree.

	Sam

> 
> > -	.section	.cpuid_patch, "ax";		\
> > -	/* Instruction location. */			\
> > -	.word		661b;				\
> > -	/* SUN4D implementation. */			\
> > -	lda	 [%g0] ASI_M_VIKING_TMP1, %idreg;	\
> > -	sll	 %idreg, 2, %idreg;			\
> > -	nop;						\
> > -	/* LEON implementation. */			\
> > +							\
> >  	rd 	%asr17, %idreg;				\
> >  	srl	%idreg, 0x1c, %idreg;			\
> >  	sll	%idreg, 0x02, %idreg;			\
> > -	.previous;					\
> > +							\
> >  	sethi    %hi(current_set), %dest_reg; 		\
> >  	or       %dest_reg, %lo(current_set), %dest_reg;\
> >  	ld       [%idreg + %dest_reg], %dest_reg;
> > diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
> > index 0f2417ee3f95..9cf8f87e8c42 100644
> > --- a/arch/sparc/kernel/entry.S
> > +++ b/arch/sparc/kernel/entry.S
> 
> The hard_smp_processor_id function also needs to be reduced to just the
> LEON code. With the patching removed, SMP otherwise breaks with CPUs
> other than CPU 0 getting stuck.
> 
> Thanks,
> Andreas

