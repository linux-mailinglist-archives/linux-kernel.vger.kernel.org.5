Return-Path: <linux-kernel+bounces-87397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8347986D3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79021F239D8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A5013F42F;
	Thu, 29 Feb 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gBiAWwOP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD716134411
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237118; cv=none; b=Vt6quDWwGA+jXqRZDOrV2/yYJcmD5EMrCeI2/76GaCpX+E3ug1af8DopadcL19N/3Zrjb+ggKMl+E4Ny7k8xHudYP7t87Hv9LvJNkFCJvYqLIKKRWgQh26tqOcKYbxPhOYweo8qZuWm4f1aOi7EkUCQgF4+gAMdqBGk8GeLnsKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237118; c=relaxed/simple;
	bh=GPBU7VUmOGNfbCfSpI+/I9KjcOWVYR6ENoMmgzQ9rfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVYZByqXgObQi01Lz2fCvwkZLk3Q/FFjMu9WopDi0052cUv14uYb2nA6CNKxR3ZXdmJjXKqPFdX67v+gOJOHOQOPrHgcXbQkWcZ7phL3pxASZ4+2SQOHRlOqqF9AIAC7oy/3zQB3zYIX++tiedMddlGkUOwiLD6nUxlydse/+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gBiAWwOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9A7C43394;
	Thu, 29 Feb 2024 20:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709237118;
	bh=GPBU7VUmOGNfbCfSpI+/I9KjcOWVYR6ENoMmgzQ9rfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gBiAWwOPnSD1wFTbM0JjgLnKd83rAfKF96o8Pdld9x6Rj8p7KNvHuAmC3MCKofXXn
	 Wed0KKOSFtPCtwnGsRNvoJlxxAEB1DdkUZaJwnt6b5CkjH/pAmamf28FxxWScQ+E5Z
	 AtUFY+QZp41/2SO+bN2oI+dNbVERFBvl7JWbtrrs=
Date: Thu, 29 Feb 2024 21:05:15 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	cve@kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Message-ID: <2024022925-stadium-wrench-50c3@gregkh>
References: <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap>
 <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
 <2024022129-expiring-resurface-146c@gregkh>
 <288132ea-87cf-4b56-908e-2263b6c6b67f@redhat.com>
 <2024022236-stock-wielder-fcbc@gregkh>
 <7be9ad00-1432-4a19-a954-32fa0f24fecd@redhat.com>
 <2024022949-uncapped-crushing-e5f9@gregkh>
 <2024022918-deepen-composed-c680@gregkh>
 <CABgObfaH2BHK==ZgbeajH8SxAxM51=91idrvd4n4L7UNiNQkEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaH2BHK==ZgbeajH8SxAxM51=91idrvd4n4L7UNiNQkEw@mail.gmail.com>

On Thu, Feb 29, 2024 at 11:53:56AM +0100, Paolo Bonzini wrote:
> On Thu, Feb 29, 2024 at 7:05 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Feb 29, 2024 at 06:32:03AM +0100, Greg Kroah-Hartman wrote:
> > > On Thu, Feb 22, 2024 at 02:31:06PM +0100, Paolo Bonzini wrote:
> > > > So if the reply-to points to LKML + the subsystem mailing
> > > > list for the maintainers + a new ML for the security folks (and these three
> > > > are also CC'd on the announcements, at least the last two), that would be
> > > > nice to have.  I can work on patches to vulns.git, for example to integrate
> > > > with get_maintainer.pl, if you ack the idea.
> > >
> > > That might be a bit noisy, for some commits, but sure, I can see the
> > > value in being notified about a CVE for my subsystem.  If you have a
> > > specific 'get_maintainer.pl' command line invocation you think would be
> > > good, I can easily add it to the scripts.
> >
> > Would:
> >         --no-keywords --no-git --no-git-fallback --norolestats --nol
> >
> > be a good pattern to follow?
> 
> I would include lists as well. it would be nice to exclude
> reviewed-bys but that's not easy to do in get_maintainer.pI

That would hit lkml for everything, which is probably not a good idea :(

I think maintainers for now would be a good start, let me see about
adding that the next chance I get.

thanks,

greg k-h

