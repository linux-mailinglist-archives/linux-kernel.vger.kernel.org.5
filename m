Return-Path: <linux-kernel+bounces-159392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085DB8B2E15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E16285971
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C1EA35;
	Fri, 26 Apr 2024 00:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lmoNTEBG"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3593D1877
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714091946; cv=none; b=u6J07T4cgWW8rANvyNKUReS9ydMyyStvS2jyKrudzxUqLd8AZVqiFUXcRNCzXLYY35uPnMULPtylkKNTDpmSRH8dkxRFC/c2cBXZ6TkEjf7CDjSCahnFrarmbm8/zgNaxtQ8V7yjtgFbDvOdd9G9wSuQl7vs0zexr6cfODxXPSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714091946; c=relaxed/simple;
	bh=UF1k0DTTPn6TCUwLWPXgU3B/ht2pbAkBF2vPrCFb+B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAjcq4l6R2GuGrF18Bx1d+a/MeBmVHDC8jWI/5QcRCDME7aI8NKOlGhMt9DFIntv71HdFZQAua3Di6NHSxg/Huv4ct5tWRDt3IjS5eHJy1KU3RDViSfy3PcTq7U1hwsojlXtZMjYDwNMCPpwk68CwXV2DUM0jxaKZUTx136CTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lmoNTEBG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e5aa82d1f6so18083025ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 17:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714091944; x=1714696744; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyeyYlhjNPdHyGDZj5zbPNqhK8/HMAhLyRxOSloh5f8=;
        b=lmoNTEBGqb6LCTSXsjc1lHsqmcUdiKVoo1KrSnRNCJNkspz9ER5uKRg4dLGE5ANeRS
         GjH0tO4AusXIU+cmftf5WhUy893YFRTQzLcLGhYnLueNHJ9dgo72kMHjh/Pb7v28Vkis
         /9AodkSd7V9G3n9+UZt1B34ZfbjA1QGo0EDoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714091944; x=1714696744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyeyYlhjNPdHyGDZj5zbPNqhK8/HMAhLyRxOSloh5f8=;
        b=Tc2kvsQcWgolXidUjKAC3NVJmMTH2/a0g8Iv3pTFOpR5anbHZv18JPW7TLh7E3SvuY
         dPyOtCrZnMas5MPkD2M+f/IMrEqSn7NNceTt4nSXeoa5TY+AjQl48WZQJ5s/fIVLJMRV
         VqUKcaIuVyvQIXywx8YgWj4FkAG+2hdk9l0Yzo0ILpoxY0pg8hHBCRcLjHc/puLk10rK
         jHE4VnfoAT0xvdV1CUiK32KZYbabhWCMO2GsSLNwAVyaJTR2vSu2Unnr+p+u++c4zWMe
         VutE3fO+QVkN3IrRCCCamy14RlXDuEAWE3VGq0Fqpx1XNrZ/i3pcPi/3FE2XlCvVu5PS
         0kQA==
X-Forwarded-Encrypted: i=1; AJvYcCWE9u8aa7G0QwCq3EHnIVOhW7QVFJj5aYxLLVTHMgtpGg3EX8DuCkZaXB4Djbu9vxk/vYtMwH0+bQllI+EQe3QYguYosMmvCTfBGbGn
X-Gm-Message-State: AOJu0YzMjpx5d+XNrJkj6WOH0uam3kmVS9WcTh5SfygjNxYBj9tfpvy+
	2e/V2H0o6COJJtQsSkS1fUvkAh8jegScIh2dYCklK+mUDEayEObfj8ReR4lUEg==
X-Google-Smtp-Source: AGHT+IHuwl3OPPsxNPOtPIxd0SB/ZhDzhbACRb6zBx3eCM0TcAvrfsdWZfXQSNhR2MSNDgZIHy8YNw==
X-Received: by 2002:a17:903:32c7:b0:1e8:682b:7f67 with SMTP id i7-20020a17090332c700b001e8682b7f67mr1960481plr.29.1714091944586;
        Thu, 25 Apr 2024 17:39:04 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w17-20020a170902d11100b001e42f215f33sm14397208plw.85.2024.04.25.17.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 17:39:03 -0700 (PDT)
Date: Thu, 25 Apr 2024 17:39:03 -0700
From: Kees Cook <keescook@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <202404251724.47A3F5ADF@keescook>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
 <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>

On Thu, Apr 25, 2024 at 04:47:18PM -0700, Andrew Morton wrote:
> On Thu, 25 Apr 2024 15:42:30 -0700 Kees Cook <keescook@chromium.org> wrote:
> 
> > > The concern about leaking image layout could be addressed by sorting the
> > > output before returning to userspace.
> > 
> > It's trivial to change permissions from the default 0400 at boot time.
> > It can even have groups and ownership changed, etc. This is why we have
> > per-mount-namespace /proc instances:
> > 
> > # chgrp sysmonitor /proc/allocinfo
> > # chmod 0440 /proc/allocinfo
> > 
> > Poof, instant role-based access control. :)
> 
> Conversely, the paranoid could set it to 0400 at boot also.
> 
> > I'm just trying to make the _default_ safe.
> 
> Agree with this.
> 
> Semi-seriously, how about we set the permissions to 0000 and force
> distributors/users to make a decision.

That seems an overly unfriendly default, but I guess if you wanted it as
a Kconfig setting? Just seems easiest to make distros that enable alloc
profiling safe by default but trivially available to root, and specialized
monitoring systems can do whatever they want with their /proc file ACLs.

This is kind of how all of this stuff works. There's nothing unique to
/proc/allocinfo. We do the same for slabinfo, vmallocinfo, timer_list,
etc. And I think it's totally reasonable to have paranoid defaults,
give the kind of outrageous stuff attackers have figured out how to reverse
engineer. Take for example "we can bypass SLUB randomization for the slab
from which struct file is allocated [by examining the /proc/$pid/fdinfo/
file contents]" Jann Horn demonstrated[1].

-Kees

[1] https://googleprojectzero.blogspot.com/2021/10/how-simple-linux-kernel-memory.html

-- 
Kees Cook

