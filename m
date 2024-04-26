Return-Path: <linux-kernel+bounces-159473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC18B2F05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8B4E1C2262B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93078C62;
	Fri, 26 Apr 2024 03:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n0/t/b22"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E778C66
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714102565; cv=none; b=KogthuyGHKCG638TA1bH5McWPmED2f5dxmpZA0ZqyFctCkhd/g7KWh1HpvREasnOEEnj/seg3PWNj+fgRjJk5xHZQImZWTfdEaifMwRSgtnayW1MquKD1kNe8nXIirwRcmihTbOzgiukrQ+Fn0ccFhuKJWlvIkFRMPNPQTQClg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714102565; c=relaxed/simple;
	bh=Fisk//vwkHKDONtGyDN9Tu18w9nNBcCShAzfkk5gOR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dOcR1KsvZOUwBbsIQTnGQHSq/b5et5N23m7ktJngg1VYPfgZE2717BXnmU72rgDazb9YOgZ4SvBk246juZ1ZB888l9rj14ahU//7jES7mZKfFdvRJP7P+uvy2g+8W4I8bA8NC6Ly1eEzG5vwcEI0668f7S4hVnp5kb3MxUziIfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n0/t/b22; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 25 Apr 2024 23:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714102560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lq3jgwFI2eK/AqWBdtP6e/tZJSaoaYtrwOh2KTK58ww=;
	b=n0/t/b22wNfnfb8kn3HKpoqJIT2HgbpGFQFvB0fPF5W1kCMBBJh/oioE9zEBOOKEY8ENDH
	BdbxgZ0l0epQSInQ0e8AS1RzHYvqUj6cKIWbiuN3qRQMtywrBwNCZtkYINLR9HIKUnCiM+
	JMsj2hnyJlzxPQuPWIP59dlq5gTlCLI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <lztkbmwlx5h4more5pfvgfi7y4qj676hfemndmyipaslg2i4ui@cqnkmnoj46lp>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
 <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
 <sxcyj2gif2avyx2disz62sfe3hot24w4rtszgl2dtqadegtnek@xjkozdbd6yzp>
 <202404251740.81F21E54@keescook>
 <qzi5ss4h4ou6yfbzadoamqocvvzviuh3eeefpv5qfkcvrrejfo@qptmu2y6u7qj>
 <ZisetKVI2Lnzucm9@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZisetKVI2Lnzucm9@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 26, 2024 at 04:25:40AM +0100, Matthew Wilcox wrote:
> On Thu, Apr 25, 2024 at 08:58:34PM -0400, Kent Overstreet wrote:
> > On Thu, Apr 25, 2024 at 05:43:33PM -0700, Kees Cook wrote:
> > > All this said, I'm still not excited about any of these files living
> > > in /proc at all -- we were supposed to use /sys for this kind of thing,
> > > but its interface wasn't great for this kind of more "free-form" data,
> > > and debugfs isn't good for production interfaces. /proc really should
> > > only have pid information -- we end up exposing these top-level files to
> > > every mount namespace with a /proc mount. :( But that's a yet-to-be-solved
> > > problem...
> > 
> > It really wouldn't be that hard to relax the 4k file limit in sysfs.
> 
> It's a lot harder to relax the GregKH opposition to multiple values per
> file in sysfs.

Which makes no sense for columnar data.

