Return-Path: <linux-kernel+bounces-159331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF898B2D37
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DB91F21D89
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6DA15573C;
	Thu, 25 Apr 2024 22:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jgnOyFgs"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13F3EA9B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 22:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714084954; cv=none; b=TcJgaDt6Ax1cxwHap/LWwPILsCKzStRf9DOqp60uM/hgO8XtimFsTfdb8H1nj0EVjHcEW5FwdeNNRU95c8G+RICMbgZqZCRcAA1zTEAbOtitEFoPh0TtqCz5NgTO4IY7rZTVJRxX+WwAv1b1MD7NyuV3SK2NqJsEWpuny2wdIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714084954; c=relaxed/simple;
	bh=9T//zdrVT2iC9sOT7glYkzNaiJH5cSL6j4l+XgJxSAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5ZiylVrIhxkCm8lERZPkWkY5egR/lC7CLeWlxJQzsgkvJvQ0unIvA2i1dMZKCqUWmQemW2klhf/RSHYErADONbV56VEmBk3HSc+RZRZNCsRmbc/g/enaQFXWBo3CYGITwsl7TSTLYWBz/g4NXQoX3V5xnOCI9L8FKW2kSTq17g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jgnOyFgs; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2a4b457769eso1313639a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714084952; x=1714689752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XQMgEUshXi0n6VyMw97AYUenmOeWDaHW3E9fbmg8+bo=;
        b=jgnOyFgsUPn5I+rh5olPuIruOLXL4kHp0WHC96sW0KkJ9IFARKk0ABaNPBjprHBUOj
         b9gCOFUYD3Soelx6j3i3jijw3xzNkDIz/NLXtQkC0T3D6mEfGdtv9KLZ3DajaAZX01Xe
         14WssIXvPDQNZIiR5NhHTay3r5DmSnMokWjA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714084952; x=1714689752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XQMgEUshXi0n6VyMw97AYUenmOeWDaHW3E9fbmg8+bo=;
        b=TR8HnVwTXWXs6KYqTW+qNUIA7JHSeQdR3I4FVVrOgA4IlZql/TlQ6m5HFTwS4ukL8P
         qRqW1lwZ17S2490rTT/5p8kKjw1JBU83GET8mhvJBE073CQ1zKKGiY4wLc3H8h/KBvYw
         9sXqFgU+j6RhKbSehHq+p5m9M0/Vz9F02A58LkDNViG1AvGuXOPcJfRpklzUeYTKT6FF
         oeDAigImhMZ87CzgVuKEe1ol8WpQjQLHNTP6kxBSsF0Qo7R8PqJFYb/KknJaJauH9IRo
         oxifKoT6h4UixMvWnqTlSei+fzqspR8WwbA9wsPQ0TDbMHBd0GLVb8K0d66a2AdWwlAp
         GIyw==
X-Forwarded-Encrypted: i=1; AJvYcCUnGdH4bhRDhPZGTAVpSRaV9YFKx/7KyMyEVmUCWE1j3IGMhjH/xb0W3lKOYx56u0V39ZifRsyqpeyeVdjLoATxm5gbqOVaeb+G6z8R
X-Gm-Message-State: AOJu0YznaFGfvy9QpIKBNnsb1z/0LyT1Qhn+d5oWJp+6Cdb+Sghiu/7L
	MODKeBiU4n7LlHUHTHcEHGf06YOtGrgzGgoW5c0FU4WLMGmOl8M0dbWMYDUafQ==
X-Google-Smtp-Source: AGHT+IGiOwEiR2ZvU3hCBIL/uaLOVZwKzUQaJqt9cMHM0i4zfElGPrIWI4AiHuO056FHOxcHNtXevQ==
X-Received: by 2002:a17:90b:4f8f:b0:2ae:b8df:89e7 with SMTP id qe15-20020a17090b4f8f00b002aeb8df89e7mr1054767pjb.38.1714084951948;
        Thu, 25 Apr 2024 15:42:31 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x16-20020a17090a531000b002a537abb536sm15111032pjh.57.2024.04.25.15.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 15:42:31 -0700 (PDT)
Date: Thu, 25 Apr 2024 15:42:30 -0700
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthew Wilcox <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <202404251532.F8860056AE@keescook>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>

On Thu, Apr 25, 2024 at 05:04:47PM -0400, Kent Overstreet wrote:
> On Thu, Apr 25, 2024 at 09:51:56PM +0100, Matthew Wilcox wrote:
> > On Thu, Apr 25, 2024 at 04:45:51PM -0400, Kent Overstreet wrote:
> > > On Thu, Apr 25, 2024 at 01:08:50PM -0700, Kees Cook wrote:
> > > > The /proc/allocinfo file exposes a tremendous about of information about
> > > > kernel build details, memory allocations (obviously), and potentially
> > > > even image layout (due to ordering). As this is intended to be consumed
> > > > by system owners (like /proc/slabinfo), use the same file permissions as
> > > > there: 0400.
> > > 
> > > Err...
> > > 
> > > The side effect of locking down more and more reporting interfaces is
> > > that programs that consume those interfaces now have to run as root.
> > 
> > sudo cat /proc/allocinfo | analyse-that-fie
> 
> Even that is still an annoyance, but I'm thinking more about a future
> daemon to collect this every n seconds - that really shouldn't need to
> be root.

Open it once and rewind? But regardless, see the end about changing
ownership/perms/etc.

> And the "lock everything down" approach really feels like paranoia gone
> too far - what's next, /proc/cpuinfo? Do we really want to go the
> Windows approach of UAC pop ups for everything? I'd rather be going the
> opposite direction, of making it as easy as possible for users to see
> what's going on with their machine.

Not unless there's something in /proc/cpuinfo that can't be extracted
in other methods. :) Anyway, you're offering a slippery-slope argument,
I just want to avoid new interfaces from having needlessly permissive
default access permissions.

I expect this to be enabled by default in distros, etc, so I'd like
to make sure it's not giving attackers more information than they
had before. Even reporting how much has been allocated at a specific
location means an attacker ends up with extremely accurate information
when attempting heap grooming, etc. Even the low granularity of slabinfo
is sufficient to improve attacks. (Which is why it's 0400 by default too.)

> Instead, why not a sysctl, like we already have for perf?

perf is a whole other beast, including syscalls, etc.

> The concern about leaking image layout could be addressed by sorting the
> output before returning to userspace.

It's trivial to change permissions from the default 0400 at boot time.
It can even have groups and ownership changed, etc. This is why we have
per-mount-namespace /proc instances:

# chgrp sysmonitor /proc/allocinfo
# chmod 0440 /proc/allocinfo

Poof, instant role-based access control. :)

I'm just trying to make the _default_ safe.

-- 
Kees Cook

