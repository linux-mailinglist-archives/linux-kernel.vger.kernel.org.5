Return-Path: <linux-kernel+bounces-159461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526828B2EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1758B28402D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 03:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CB3763F2;
	Fri, 26 Apr 2024 03:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fPLNukjc"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5D82BAE2;
	Fri, 26 Apr 2024 03:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714101949; cv=none; b=OGKQFQWLQV3omE139f569PU4cqvwZ1JSrIlBavzTtf0jxI2OvVMwYFYawF8M1CszCUz1pVQ8bgKYZ86QFkJCq8Ulr2a7JP87pkwDqSUkrfWJxXJVFgZO44do4jeYBT2nAoOFXXpgyYh59hEIAHkYFMbegSamIMA/Xn0Qp43vWpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714101949; c=relaxed/simple;
	bh=7OgY3E4OhSB7qgee85Fgr8Gin0wCc0ruVkh618+fd2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zi7SdkjwUWESgh/Ax5PebyejRYS+/4PptgnRu2rY4i4IMTtLBLXOyEcDnoAQSodvBqBLHS3GmeijCxMb6M4PSK/ztN/D1WDj+rVfilotr17juV8VJPoTk+Ou1Ttf2oTeBfsWNfC6/2zmYhMstFAKJ7CTN7NYTQjRuQGYuutQ10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fPLNukjc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=C7BGuFax2sLW1Ikgo6D4h4Axnj+rfKZZEdQqdqRze5Y=; b=fPLNukjc5FsxCc70iHDy4iKbYu
	qUXxEUOVlz5cmhqdpUUaoH7msVoRMATiKpcaEniAdqHIqEmEv4O25Piq6Na4zW9oHP4dJgoCEBNm5
	h/zgiXWli/nRJQ6kR4VQg9yX6EVZaBOvg/7uZI2Sw9YWCidSA71hc4XDrrINPkl1XA1NTXrAeoI54
	rAAxHaee1UY5h4r1kbxEyZgSeNfVw3NjsC1UnAybUGFoeExyQ/iZKNWHvfeKsf+yUx7qVFELtvtv0
	TqrlwZ1UkKAalxlBZFGnuiAbFbDTpvNnKpUQTHeR/icMuTerpH+wBinj9w4QLmhyWjD+sy1Fvfb6p
	A3XRtMMw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0CDU-00000004NaV-0r81;
	Fri, 26 Apr 2024 03:25:40 +0000
Date: Fri, 26 Apr 2024 04:25:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Message-ID: <ZisetKVI2Lnzucm9@casper.infradead.org>
References: <20240425200844.work.184-kees@kernel.org>
 <w6nbxvxt3itugrvtcvnayj5ducoxifwbffd7qh6vcastw77mse@2ugphwusgttz>
 <ZirCbPR1XwX2WJSX@casper.infradead.org>
 <64cngpnwyav4odustofs6hgsh7htpc5nu23tx4lb3vxaltmqf2@sxn63f2gg4gu>
 <202404251532.F8860056AE@keescook>
 <20240425164718.e8e187dd0c5b0a87371d8316@linux-foundation.org>
 <sxcyj2gif2avyx2disz62sfe3hot24w4rtszgl2dtqadegtnek@xjkozdbd6yzp>
 <202404251740.81F21E54@keescook>
 <qzi5ss4h4ou6yfbzadoamqocvvzviuh3eeefpv5qfkcvrrejfo@qptmu2y6u7qj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qzi5ss4h4ou6yfbzadoamqocvvzviuh3eeefpv5qfkcvrrejfo@qptmu2y6u7qj>

On Thu, Apr 25, 2024 at 08:58:34PM -0400, Kent Overstreet wrote:
> On Thu, Apr 25, 2024 at 05:43:33PM -0700, Kees Cook wrote:
> > All this said, I'm still not excited about any of these files living
> > in /proc at all -- we were supposed to use /sys for this kind of thing,
> > but its interface wasn't great for this kind of more "free-form" data,
> > and debugfs isn't good for production interfaces. /proc really should
> > only have pid information -- we end up exposing these top-level files to
> > every mount namespace with a /proc mount. :( But that's a yet-to-be-solved
> > problem...
> 
> It really wouldn't be that hard to relax the 4k file limit in sysfs.

It's a lot harder to relax the GregKH opposition to multiple values per
file in sysfs.

