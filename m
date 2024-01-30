Return-Path: <linux-kernel+bounces-45229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F2F842D62
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28EE2886B0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED00E69D36;
	Tue, 30 Jan 2024 19:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bjkoG727"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2471B43
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644519; cv=none; b=nugFCBSrLM5UYs8KyKzkJGxqpXQAuUgmEKuDSCeziHh+JqYwUrzQSLQ5sDkVdl8GDMZfQambiMeZM/6/2om8c4qrXEDJEHovafkOL+mQOoYC255zVNijDIEuG6ReYctuB4RqjOhrAHYkWvBSp/5am1zAAnGvI4ixJuSi6xhnm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644519; c=relaxed/simple;
	bh=OA8oLBHPhrSLnbd9ATKoXbq8wijgvN4ewjiP+nXyvgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QB9uuG4KcLK5gxtWqKiuxPdVazpj+/kMP0W60XdLHT1ra9tnlq+rYvPZH5tvmEbuga8MfGBvKPpAfvfFS9GJY44135ZM+/QmYPazI+IsbogQxd+VcKeJ+7cP7Z61+tIFRcAqyZs34kczyBHS3A0G3D5Ywc5Mx8Uba0RZbKBJ+sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bjkoG727; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51031ae95a1so4330801e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706644515; x=1707249315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xsmhAB/FHTmzTTzdgfdlCEbbVq9kW3x2bQ5xRcrAAgg=;
        b=bjkoG7275PYmR7+I7XK8q/E7PjhP1Eo2FOi8tCCR5h2douRJ0Uf/DoG5f4ZO+uSvWS
         vowDFwErsETbQ3xEMunAnj0WEtLJtcJoHePpNlbcWUQ8c+kO2X9EVJmtfu4BM4SKFV8i
         Afu6jnY5l7VzI/h4TvrdyGyiPZ57aY1E4eBb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644515; x=1707249315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xsmhAB/FHTmzTTzdgfdlCEbbVq9kW3x2bQ5xRcrAAgg=;
        b=jNh37a231IWvrTQyRk1BL+SSfY4tHRjjCgNPwpW4+cN1lUGx9Wc2W8l/rNdehe7vPu
         jyDDjEUI1/uiRGaA6QEMDKGAQLFLSranxZGQjYtBeojpxsiKvuX2gQpIrb4nzHCcO7kY
         6xypTQv3dtBPOJmzaw3L65fWIGGi+/fZb2mVug/o4awpwdwKjYHnof/xZGHZ4dPaPYQy
         SbSplFoZQhVpboWeQ23/VXwNbcjJSqNE3T5z6BfLLfYJSZLrJ2S8wrj6BoFmd0yCfWmb
         joXQehPnPPy6nk2xlTKrSLgw+y7OzwUKORquXkVcK6eDgiVCctYO1Cr+G20PpFX842Zn
         K5Mw==
X-Gm-Message-State: AOJu0Yz0kkB8jEkOyzlTR2qc9EysUoQuZ5YoenIrYZ4M1PfgWvL42gXC
	xJ/odoxyU6yB5XA+i/oBOk0O91CapnB05lJT76sn7ONwtg0YBYG8ZvlLDLeeBcirTUSI5uZb/3n
	ua9cQWw==
X-Google-Smtp-Source: AGHT+IGFoz4DjU5LQ5FkvqcsL3EJWb0eZemjDCDqR/2XcwSoHbY4vGRamfOSIGZwwglrWW1GOJysew==
X-Received: by 2002:a05:6512:b83:b0:511:1790:e3dd with SMTP id b3-20020a0565120b8300b005111790e3ddmr3431627lfv.54.1706644515409;
        Tue, 30 Jan 2024 11:55:15 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k3-20020a192d03000000b00510158a1345sm1603213lfj.60.2024.01.30.11.55.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 11:55:14 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cf4a22e10dso51443191fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:55:14 -0800 (PST)
X-Received: by 2002:a2e:9b09:0:b0:2d0:5dc4:4e30 with SMTP id
 u9-20020a2e9b09000000b002d05dc44e30mr1808081lji.21.1706644513633; Tue, 30 Jan
 2024 11:55:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202401291043.e62e89dc-oliver.sang@intel.com> <CAHk-=wghx8Abyx_jcSrCDuNj96SuWS0NvNMhfU8VjFGg9bgm_g@mail.gmail.com>
 <CAHk-=whb91PWEaEJpRGsuWaQpYZGj98ji8HC2vvHD4xb_TqhJw@mail.gmail.com>
 <CAHk-=wgp7UkG31=cCcbSdhMv6-vBJ=orktUOUdiLzw4tQ4gDLg@mail.gmail.com>
 <20240129152600.7587d1aa@gandalf.local.home> <CAHk-=wghobf5qCqNUsafkQzNAZBJiS0=7CRjNXNChpoAvTbvUw@mail.gmail.com>
 <20240129172200.1725f01b@gandalf.local.home> <CAHk-=wjV6+U1FQ8wzQ5ASmqGgby+GZ6wpdh0NrJgA43mc+TEwA@mail.gmail.com>
 <CAHk-=wgOxTeTi02C=kOXsHzuD6XCrV0L1zk1XP9t+a4Wx--xvA@mail.gmail.com>
 <20240129174950.5a17a86c@gandalf.local.home> <CAHk-=wjbzw3=nwR5zGH9jqXgB8jj03wxWfdFDn=oAVCoymQQJg@mail.gmail.com>
 <20240129193549.265f32c8@gandalf.local.home> <CAHk-=whRxcmjvGNBKi9_x59cAedh8SO8wsNDNrEQbAQfM5A8CQ@mail.gmail.com>
 <CAHk-=wh97AkwaOkXoBgf0z8EP88ePffLnTcmmQXcY+AhFaFrnA@mail.gmail.com>
 <20240130132319.022817e8@gandalf.local.home> <CAHk-=wiGb2aDbtq2+mYv6C=pYRKmo_iOu9feL9o52iRT8cuh6Q@mail.gmail.com>
 <20240130143734.31b9b3f1@gandalf.local.home>
In-Reply-To: <20240130143734.31b9b3f1@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 11:54:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
Message-ID: <CAHk-=whMJgqu2v1_Uopg5NBschGFa_BK1Ct=s7ehwnzPpPi6nQ@mail.gmail.com>
Subject: Re: [linus:master] [eventfs] 852e46e239: BUG:unable_to_handle_page_fault_for_address
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 11:37, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Do you want me to put this in my urgent branch and mark them for stable,
> and then send them for 6.8?

Hmm. I think the only one that fixes a _reported_ bug is that [PTCH
2/6]. And it turns out that while 'ti->private' really is entirely
uninitialized (and I still think it's the cause of the kernel test
robot report that started this thread), the ti->flags field _is_
initialized to zero in tracefs_alloc_inode().

So even in that [PATCH 2/6], these parts:

  -     ti->flags |= TRACEFS_EVENT_INODE;
  +     ti->flags = TRACEFS_EVENT_INODE;

aren't strictly needed (but aren't wrong either).

The 'make sure to initialize ti->private before exposing the dentry'
part *definitely* needs to be part of 6.8, though. That has an
outstanding actually triggered bug report on it.

I do think that tracefs_alloc_inode() should also initialize
ti->private to NULL, but while that would fix the oops that the test
robot reported, it wouldn't fix the data-race on any ti->private
accesses.

So that "ti->private = ei" needs to be done before the d_instantiate()
(that later became a d_add()) regardless. But not having random fields
left uninitialized for future subtle bugs would be a good idea too.

Anyway.

If you do run the full tracefs tests on the whole series, and there
are no other major problems, I'll happily take it all for 6.8. And
yes, even mark it for stable. I think the other bugs are much harder
to hit, but I do think they exist. And code deletion is always good.

So give it the full test attention, and *if* it all still looks good
and there are no new subtle issues that crop up, let's just put this
saga behind us asap.

               Linus

