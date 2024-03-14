Return-Path: <linux-kernel+bounces-103350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE287BE69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB48EB2331D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C06FE01;
	Thu, 14 Mar 2024 14:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="CuBTd2bY"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023996F06E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710425191; cv=none; b=fR153wpCcdubz+MuUsqsP/wAEfyHhD+4om7SXkAFaS+AiSIuOYqcStvYPO0MyKXx3EWeYZkcGRIszdYCE87soD+T38JJjvwZXuLy7H3jA10A+JQVwMFbTHPk9ux/ZH7f+zJFLz8PS3PHpC5WaoahYa1Nl0avNUmBtPbcHocMDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710425191; c=relaxed/simple;
	bh=3RrxQwsPYe120Zt5iYWSs4Wx0/Yj8A3wGaxd24VEW2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CCCZGu+zsnhoAk9XRxaUOG8x7tPRidQN/fLBTXxaWoQYzOm5deS0gkyxslo1TsDcSX3mvA3fbAW3lnxojNLdP5utvuOsQvJynrzCo34Pfeu4B8GW0fhKy6oZwtUHHsu25vXXhWoKlPrqMlAF8OhScfGOhMkEaCDoWto2vh8Rr3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=CuBTd2bY; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33e972c8b67so262346f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 07:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1710425188; x=1711029988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8pQ1l+MVwXlBnQJuFCGfCMOAeHIFtVSkzqeu2rgt2U=;
        b=CuBTd2bYQdTmSH0P4JlXd5etfYQRDLd8FHpVyEcY4dL/LOP1uz1UayZLtnO75YR8k2
         KD+iohSsHrTaKP2ku7A0ul9XIzksuIwhL7NPYc9w41QxaD/Gpxmla3oslBSO5hC6HuBy
         22hvgz33kBVPGXaw6RfprsuBoOuk67PowJzZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710425188; x=1711029988;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P8pQ1l+MVwXlBnQJuFCGfCMOAeHIFtVSkzqeu2rgt2U=;
        b=LF7hdAtoXDHCW/LAfaaz45+6Bc5de4YvQyFlM/1lyUDHNzfI3vKqXljWPiN9yxo4rP
         Hx+Y7i0VWs1gh4AhNIszt2NTeaztpvriYsI4snMC8cWCZRIqlmN4tjuzj8mPLLCWQxLY
         hYG13HRIuMS30Od0isE+pOJIuNoN2rMHpXmbVkgNyzQr9vG7cBsssDGDLQLsj1gGYBwm
         Cc3+G1BXc2xrTxhgEzDnAY1k5WJ1VKvbPodExEu/Qk2I5FTDr6w7j2TFFDxaJgaGY3jf
         dgYqJhv3Gn1pAUZ8bvFigSoa/ot+mnLnB197Ohx86/E9Ou3vXhSE3mCoq50onf/faeZ9
         AAHw==
X-Forwarded-Encrypted: i=1; AJvYcCUobLReF9Si70+xEB8TJ4E0bQO9ZrfR6SxkfYyXBQ7eez+RtTenwTn3ubAel/RJI/vjgDLK1ZxYBKegnftoyUAKjlKdZ0k+X/c/sqwW
X-Gm-Message-State: AOJu0YwjbzLBCvhy3h8C9nEXGt/PZTtbs7hCSmzorE8rQan//oFhhdIH
	/2xnpAssMDwSxSSncISFvV1kq9bot94eLzII3DHHIwPW4NrLVyrDhHfDc30lFrA=
X-Google-Smtp-Source: AGHT+IExxoAOUpYvXMrjNM7aEFoJfpTDSDysmUmnKGih3LPpSITnQuFjpS56zA1GupHQLuuj8OHUoA==
X-Received: by 2002:a05:6000:4021:b0:33e:7077:4b57 with SMTP id cp33-20020a056000402100b0033e70774b57mr1890153wrb.1.1710425188089;
        Thu, 14 Mar 2024 07:06:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id du18-20020a0560000d5200b0033b7ce8b496sm806034wrb.108.2024.03.14.07.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:06:27 -0700 (PDT)
Date: Thu, 14 Mar 2024 15:06:25 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: John Ogness <john.ogness@linutronix.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Lukas Wunner <lukas@wunner.de>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC] drm/panic: Add drm panic locking
Message-ID: <ZfMEYZZN2fd9FeEi@phenom.ffwll.local>
Mail-Followup-To: John Ogness <john.ogness@linutronix.de>,
	DRI Development <dri-devel@lists.freedesktop.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Lukas Wunner <lukas@wunner.de>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>
References: <20240301100516.2516297-1-daniel.vetter@ffwll.ch>
 <20240301103903.2538083-1-daniel.vetter@ffwll.ch>
 <87o7bt6qpf.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7bt6qpf.fsf@jogness.linutronix.de>
X-Operating-System: Linux phenom 6.6.11-amd64 

On Tue, Mar 05, 2024 at 09:20:04AM +0106, John Ogness wrote:
> Hi Daniel,
> 
> Great to see this moving forward!
> 
> On 2024-03-01, Daniel Vetter <daniel.vetter@ffwll.ch> wrote:
> > But for the initial cut of a drm panic printing support I don't think
> > we need that, because the critical sections are extremely small and
> > only happen once per display refresh. So generally just 60 tiny locked
> > sections per second, which is nothing compared to a serial console
> > running a 115kbaud doing really slow mmio writes for each byte. So for
> > now the raw spintrylock in drm panic notifier callback should be good
> > enough.
> 
> Is there a reason you do not use the irqsave/irqrestore variants? By
> leaving interrupts enabled, there is the risk that a panic from any
> interrupt handler may block the drm panic handler.

tbh I simply did not consider that could be useful. but yeah if we're
unlucky and an interrupt happens in here and dies, the drm panic handler
cannot run. And this code is definitely not hot enough to matter, the
usual driver code for a plane flip does a few more irqsafe spinlocks on
top. One more doesn't add anything I think, and I guess if it does we'll
notice :-)

Also irqsave makes drm_panic_lock/unlock a bit more widely useful to
protect driver mmio access since then it also works from irq handlers.
Means we have to pass irqflags around, but that sounds acceptable. So very
much has my vote.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

