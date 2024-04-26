Return-Path: <linux-kernel+bounces-159402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C018B2E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A48811C21DBE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873D5EDB;
	Fri, 26 Apr 2024 00:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MIYMK39u"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99A6620
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714093122; cv=none; b=YPvKOcteouurJdPZuDw1hO7u4eMA6NsJ6AnUSKONwaDvzMLIXkisUo6zl6UldRHlSuLEih2TA+nDYjvECaRmOfbwTvkQDDXXnOiu6FTKVIKahhxyTx30ARlpWpl+/MCjiTdLdkgZCmofD0DIFFTRDkHA1opPVk/AJaHBjpf4AzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714093122; c=relaxed/simple;
	bh=lvobPQOIiNfw0n12EkvEBH57AhWUFxbFDYcvxGJw4Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gOydVosqQDTqJMLW7/yIZUp7k3nv43g12AYMsh8gYEVYENiyJc+kHFIs6E05C0YbscQ9iTDSm13UYw6IDWzyEMkPIDbCCATwWr+3OZRktM4Vd2ZLfEOYxQfmRhT6iIKFznNUpvtgeO3QrcXU1kthxC84pB5vsfE/+x7k9VchOvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MIYMK39u; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 20:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714093118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pW2nVZcsWCTaWzRE1USWg5C8N+QQoR9xikgyDPIEVfg=;
	b=MIYMK39u8yqpjVgHB3ze+cLWiWdTjBb7/6od4z7JDRizvyBKuLEo9FWHdzw1M9O9DGD7Vc
	YQZTYCuXdgW7U3efY7Eb43U+WsAe7thXCkRpi21BS2IcQbM306ApwpLrgYjNUqVkZhPg6e
	ClBbl9sDKx/xOj87h6WiPC+Y7Hvb21M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <qzi5ss4h4ou6yfbzadoamqocvvzviuh3eeefpv5qfkcvrrejfo@qptmu2y6u7qj>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
 <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
 <sxcyj2gif2avyx2disz62sfe3hot24w4rtszgl2dtqadegtnek@xjkozdbd6yzp>
 <202404251740.81F21E54@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404251740.81F21E54@keescook>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 25, 2024 at 05:43:33PM -0700, Kees Cook wrote:
> On Thu, Apr 25, 2024 at 08:27:05PM -0400, Kent Overstreet wrote:
> > On Thu, Apr 25, 2024 at 04:47:18PM -0700, Andrew Morton wrote:
> > > On Thu, 25 Apr 2024 15:42:30 -0700 Kees Cook <keescook@chromium.org> wrote:
> > > 
> > > > > The concern about leaking image layout could be addressed by sorting the
> > > > > output before returning to userspace.
> > > > 
> > > > It's trivial to change permissions from the default 0400 at boot time.
> > > > It can even have groups and ownership changed, etc. This is why we have
> > > > per-mount-namespace /proc instances:
> > > > 
> > > > # chgrp sysmonitor /proc/allocinfo
> > > > # chmod 0440 /proc/allocinfo
> > > > 
> > > > Poof, instant role-based access control. :)
> > > 
> > > Conversely, the paranoid could set it to 0400 at boot also.
> > > 
> > > > I'm just trying to make the _default_ safe.
> > > 
> > > Agree with this.
> > > 
> > > Semi-seriously, how about we set the permissions to 0000 and force
> > > distributors/users to make a decision.
> > 
> > I'm ok with 0400 for now since it's consistent with slabinfo, but I'd
> > really like to see a sysctl for debug info paranoia. We shouldn't be
> > leaving this to the distros; we're the ones with the expertise to say
> > what would be covered by that sysctl.
> 
> We've not had great luck with sysctls (see userns sysctl discussions)
> since they don't provide sufficient granularity.
> 
> All this said, I'm still not excited about any of these files living
> in /proc at all -- we were supposed to use /sys for this kind of thing,
> but its interface wasn't great for this kind of more "free-form" data,
> and debugfs isn't good for production interfaces. /proc really should
> only have pid information -- we end up exposing these top-level files to
> every mount namespace with a /proc mount. :( But that's a yet-to-be-solved
> problem...

It really wouldn't be that hard to relax the 4k file limit in sysfs.

