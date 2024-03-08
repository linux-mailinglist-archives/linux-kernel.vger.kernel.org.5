Return-Path: <linux-kernel+bounces-96810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC9D8761BA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F8B1F23260
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104C53E04;
	Fri,  8 Mar 2024 10:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bC6vPrdY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE54524CC
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892951; cv=none; b=Z2COBZ2HU97GRVpESI9tjQ/nphLKQJV3F0pfzf2mZN2PxCzd4+/birQFuA0pZunBQS3wlH/JogN1jdsLndEqT8P3d8CISOtbhuVvH4+cDXvg1c/ELrukI0x+dNfoBbrz+91NCgmG8LM71zHp1DAmFT1LCykt+nGB4rVNhUf9yDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892951; c=relaxed/simple;
	bh=/T3m4QWWKnojpDRse7oTDsHedmgeTChFsQxwYONYmdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEJ+tZfFz/Xn6g4adDP6jY5pgcEuJdyeG+EaIunIFPrVmbSRNREWHM2zRuMKyAl/7/LwJPJMA84M/OfrC3GxFC3EReIqGniFkgAHqLMFQuMpzDwOcaM/QSC2rw7XJXZxZHVQC/eLnoEC7XFZZqo77TqzUW8f91OW0hm6Hd3wSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bC6vPrdY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4131804e695so2667375e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 02:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709892948; x=1710497748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkWIEP8Vs49nsbPdzrQIK9TK4ZdODxcASQPH+B1cdbc=;
        b=bC6vPrdYh+3ZPsK5IvgNeawnoBCy3dRt6Am/0tLTxeyavrtHgo3G/eqgPlYefPvg+8
         w9AZoO4Srxdb57wIkw01Nc7pcPTnKsyX5oO0cU2SZWs/WF09MoxjSyamDDa+oIE3XrsG
         lKeSZKsO2krD5RDvIb4Mg3+PiSkF8ky12MYexmQzUZ7AKlIz0m8ppHSSgT6go20Yz0Ta
         4etW+aOZcvjHvxOPUsdk+ODXXQrRnDDpR9zYIMImPzu6WctLjb/eGv+S5ZI3B6kJcKbo
         Y7qv96kGo+Wn8MQDpdsFXfXv7XtRHbQX3tYZOkcWxymU4snjggLQta8PFADpzBaL2Z9l
         eANQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892948; x=1710497748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tkWIEP8Vs49nsbPdzrQIK9TK4ZdODxcASQPH+B1cdbc=;
        b=bjT89Ph1hECL1XkbkGBjr0BouuM34EeAaZ8TUnwlCePUpW3N7lb0s/If44f5C+KNxL
         7Eyn2yXoXxinEVlSpFqPYZDk35CDZSr4YW15sV4IxMt9QKZ3F11UQzucCI88lNLHQLKW
         pyYY5nAKSQEhE4OMzSGUZVsfTmfv/fPpxIW3Xyyvm5AzYbXtKiZ3MPkzGizu+cS5EAr7
         aSpVPZtnXHIcWQ7MI4iMgsC1RYN7iRPFyNs95UjMitHV7qyxkHhJyOL1pEG8fBzkLtVb
         m4kEf0XapDsImVW++FksnotqsmvpOX41clyqTUpp+UvfbswFOyq14+rshWPEsDgAxh9W
         8VbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtA7+QHpXMM/EVwUEjHCbFp+ZOJg9z7MIsruRepYSIotxurExvmaFDrcv40GFfmCuLWoF2RHC2+vnLFytfzOIV1w4/rZmLNRBOJtLT
X-Gm-Message-State: AOJu0YzQXS4yMncuwnadwgSqOZo8vFf1O0aGwQxqY1rjUnHq9/9JGw7J
	ArdJ64zTVHnkm/WXmyMCnHWwM3DDE5VJMOCrKi29ugJTM4c91Ig8
X-Google-Smtp-Source: AGHT+IFiRbGHzK/nhjPjT2BNXZTbeZpjRgO/jBYcZtw5KGfY9LY3nxvL1QEOTtOfKYY9ZcfJDu3O6Q==
X-Received: by 2002:a05:600c:3591:b0:412:e0f7:ef52 with SMTP id p17-20020a05600c359100b00412e0f7ef52mr4031397wmq.19.1709892947991;
        Fri, 08 Mar 2024 02:15:47 -0800 (PST)
Received: from gmail.com (1F2EF3E5.nat.pool.telekom.hu. [31.46.243.229])
        by smtp.gmail.com with ESMTPSA id iv20-20020a05600c549400b0041313d4c852sm3162899wmb.19.2024.03.08.02.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 02:15:47 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 8 Mar 2024 11:15:45 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/9] sched/balancing: Update run_rebalance_domains()
 comments
Message-ID: <ZerlUU4kAv580rLh@gmail.com>
References: <20240304094831.3639338-1-mingo@kernel.org>
 <20240304094831.3639338-7-mingo@kernel.org>
 <xhsmhbk7tdkac.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
 <CAKfTPtCNnTVFdf85sRdJxPhdNZxc8qKcnHL3sznjg-KBVn8Bew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCNnTVFdf85sRdJxPhdNZxc8qKcnHL3sznjg-KBVn8Bew@mail.gmail.com>


* Vincent Guittot <vincent.guittot@linaro.org> wrote:

> > """
> > The run_rebalance_domains() softirq handler is triggered via SCHED_SOFTIRQ
> > from two places:
> >
> > - directly from trigger_load_balance() in scheduler_tick(), for periodic
> >   load balance
> >
> > - indirectly from kick_ilb() (invoked down the scheduler_tick() too), which
> >   issues an SMP cross-call to nohz_csd_func() which will itself raise the
> >   softirq, for NOHZ idle balancing.
> 
> I'm not sure that we should provide too many details of the path as
> this might change in the future. What about the below ?
> 
>  - directly from the local scheduler_tick() for periodic load balance
> 
> - indirectly from a remote scheduler_tick() for NOHZ idle balancing
> through the SMP cross-call nohz_csd_func()

Okay - I updated it to:

  /*
   * This softirq handler is triggered via SCHED_SOFTIRQ from two places:
   *
   * - directly from the local scheduler_tick() for periodic load balancing
   *
   * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
   *   through the SMP cross-call nohz_csd_func()
   */
  static __latent_entropy void run_rebalance_domains(struct softirq_action *h)

Does this work with everyone?

Thanks,

	Ingo

