Return-Path: <linux-kernel+bounces-87297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC9186D262
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3A7DB247B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AC040847;
	Thu, 29 Feb 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AWAYiH/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F370A5F
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231546; cv=none; b=PITQ/K7YvbmBVc5T/FOTQsWBgUVHBWQO/NFQDg6RmrkRxbhP7nyUG7XbGd4CsLGqA+fRd5+ONidV5AlPqSGBMphgQnvzvzt2QWiP2z6Ni1Y/0EOkOeRJzeDYDvy+m6oTOh6h6sPoERW+kHUM1FPMY85Rsh2s4sXMkGD2dB16ML4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231546; c=relaxed/simple;
	bh=I7vjq8D0UgYUMe8/HQRvVmc5kyQ5OOYyCXZ9U4I/8D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhhwZHEtKWg0mnsiC1OYL8M0xRtQTVcKgwYp6DB/NuOqr0H8mp2/wEPfkhdvywgrApBM7sARibpNj9GcyB/4m045vAXnGp1Jfxc7GjFg64y0cu1pKIxI+vcmI47weWVjv/H981dCrtBpv2ZBqDOTMkxYIMUMqD/O/ALt34dy9+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AWAYiH/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A12F4C433C7;
	Thu, 29 Feb 2024 18:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709231546;
	bh=I7vjq8D0UgYUMe8/HQRvVmc5kyQ5OOYyCXZ9U4I/8D8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWAYiH/PQut2skLZ8XCRAr0I8uT5bjx3jRmddyxIHLc/PFwHBB6X6wau+NBzxcBFq
	 8HJuxggmFKxG/bKP/oIvY5EA0IMAjtgjdpcodJvqxHtD8LkBxcpV5GrzdK7UA6OVvD
	 bdG8EZIEZCieJIF+7bJt9PXFPeuHAgFwhdZ8owZE=
Date: Thu, 29 Feb 2024 19:32:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Michal Hocko <mhocko@suse.com>,
	Kees Cook <keescook@chromium.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <2024022905-pester-emphatic-9ff0@gregkh>
References: <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka>
 <2024022915-dissuade-grandson-ebd4@gregkh>
 <ZeBRZqJd5HAKaOfC@tiehlicka>
 <2024022913-borrower-resource-ecc9@gregkh>
 <nycvar.YFH.7.76.2402291605370.4159@cbobk.fhfr.pm>
 <ZeCsKGwU96sKi_S_@sashalap>
 <nycvar.YFH.7.76.2402291754020.13421@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2402291824020.13421@cbobk.fhfr.pm>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.2402291824020.13421@cbobk.fhfr.pm>

On Thu, Feb 29, 2024 at 06:36:08PM +0100, Jiri Kosina wrote:
> On Thu, 29 Feb 2024, Jiri Kosina wrote:
> 
> > - you pointed to a fix for UAF in BPF, which definitely is a good fix to 
> >   have, I don't even dispute that CVE is justified in this particular 
> >   case. What I haven't yet seen though how this connects to in my view 
> >   rather serious 'trivial to get root' statement
> 
> To elaborate on this a little bit more -- I completely agree that this fix 
> is completely in-line with what Kees is, in my view, quite nicely 
> describing at [1]. You pointed to a weakness (for which a fix *is* in our 
> queue), sure.
> 
> But I see a HUGE leap from "fixes a weakness" to bold, aggressive and in 
> my view exaggerating statements a-la "I am able to trivially pwn any 
> kernel which is not -stable".

{sigh}

I do not mean _any_ enterprise kernel, I said "most", some I did not
find any problems with at all that I could tell.  This was true the last
time I did this exercise about 9 or so months ago for a presentation,
and hey, it might have changed since then, I sure hope so for everyone's
sake.

Sorry, I will NOT say what distros I did, or did not, find vunerable.
That's not my place to say here in public for obvious reasons, but I'm
more than willing to discuss it over drinks in-person anytime.

thanks,

greg k-h

