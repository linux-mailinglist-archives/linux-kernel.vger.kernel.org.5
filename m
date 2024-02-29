Return-Path: <linux-kernel+bounces-86137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2068786C03F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 06:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72E9DB24F9F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 05:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06203A267;
	Thu, 29 Feb 2024 05:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Qsc9mKaA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246A23A1BF
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709184727; cv=none; b=o70QSXQPqSlfhBWlNnYjiOvNYVnCQm4N/lxbIZIw7K6KRYsoOpaHOzAEdcQKz9SpUsmHLFHt7x2Kf3/QR2PC3ctaYU7uw5M6eDS8Hgs494TNADBpJCoKWmZLxdMSptwbKOzp6wUBFmtr/0LDM0m+Bc+9S9zFL01xo9W7yaZNtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709184727; c=relaxed/simple;
	bh=Gz6cyj5IxxyD9H9LT1YWjsonRagDA8CrCUTcK3stBxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NenKMEPnBx+1ZLc/ONkZDTtIFl9WnOKmEPFCm/onQbcMlc2HhpztF8LRgHAHxHj5QAUNUyAKlUG7zENr3gJ0U0D3bxqQ1LGgTeHghs5r6io/7TEojYJvgzC5mByEya984+oVicNbaZ9aELjvABAzSw/6I+u7io25F6nBb777N4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Qsc9mKaA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2F4C433C7;
	Thu, 29 Feb 2024 05:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709184726;
	bh=Gz6cyj5IxxyD9H9LT1YWjsonRagDA8CrCUTcK3stBxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qsc9mKaAxJayIK4XM6LUY4Ns4dVOP8NjdPtFZK/qNdmUG85RxJ+7QkeCiswx7g3Df
	 iv5b6a5zZbT74yP10LL9XsJQ1OX3S0o3A891T2/WMlYdasifpE0OCmy7FpLHvr1F6v
	 tltGV/emaRYLxQ4oH7tkQ3IjXxCsgQVS8xKNQUw8=
Date: Thu, 29 Feb 2024 06:32:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	cve@kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Message-ID: <2024022949-uncapped-crushing-e5f9@gregkh>
References: <ZdX2LcAWR6wyvYC5@sashalap>
 <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap>
 <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap>
 <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
 <2024022129-expiring-resurface-146c@gregkh>
 <288132ea-87cf-4b56-908e-2263b6c6b67f@redhat.com>
 <2024022236-stock-wielder-fcbc@gregkh>
 <7be9ad00-1432-4a19-a954-32fa0f24fecd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7be9ad00-1432-4a19-a954-32fa0f24fecd@redhat.com>

Sorry for the delay in response, been a busy week...

On Thu, Feb 22, 2024 at 02:31:06PM +0100, Paolo Bonzini wrote:
> > > Perhaps since there's no archive for cve@kernel.org, there should be a
> > > public discussion mailing list (e.g. linux-cve@vger) that maintainers can
> > > reply to?  The private cve@kernel.org alias would then be just for the
> > > request of embargoed CVEs.
> > 
> > What's wrong with lkml for discussion?  I'll add a "reply-to" to point
> > there as well so that it will properly redirect if you respond to a
> > message sent to the -announce list.
> 
> Well, LKML is not the most searchable archive and subscribing to it puts
> measurable stress on the kernel.org servers (mostly due to gmail
> shenanigans, but still).

lore is a great search tool for lkml, and you can subscribe to feeds
from it very easily.

> Plus (relatively) fine grained mailing lists are really cheap to subscribe
> to lore/NNTP.

Lore picks out stuff from lkml just as easily.

> So if the reply-to points to LKML + the subsystem mailing
> list for the maintainers + a new ML for the security folks (and these three
> are also CC'd on the announcements, at least the last two), that would be
> nice to have.  I can work on patches to vulns.git, for example to integrate
> with get_maintainer.pl, if you ack the idea.

That might be a bit noisy, for some commits, but sure, I can see the
value in being notified about a CVE for my subsystem.  If you have a
specific 'get_maintainer.pl' command line invocation you think would be
good, I can easily add it to the scripts.

> The linux-cve@ mailing list would also be a natural place to send patches to
> vulns.git.

Proliferation of mailing lists are a pain, I'd like to resist that for
now if possible.  Just use lkml and cc: cve@kernel.org if you want to
send us patches.

> > > * is there a limit on embargo length similar to security@kernel.org
> > 
> > We have no embargos here, you should NOT be emailing this alias about
> > any unfixed security things, the document explicitly states this.
> 
> Wait that's not what the docs say:
> 
> +If anyone wishes to
> +have a CVE assigned before an issue is resolved with a commit, please
> +contact the kernel CVE assignment team at <cve@kernel.org> to get an
> +identifier assigned from their batch of reserved identifiers.

The document also says:
	If you feel you have found an unfixed security issue, please
	follow the :doc:`normal Linux kernel security bug reporting
	process<../process/security-bugs>`.

So _IFF_ you have an unfixed security issue that security@k.o knows
about, and you MUST have a CVE id at this point in time (i.e. because it
needs to be referenced somewhere), then you can email cve@k.o to get
one, but the number of times I forsee that being the case based on the
security@k.o workload is going to be very small.

So we can take those on a case-by-case basis please, that's not going to
be a normal occurrence.

> So it's just that it's a lot of new work.  So far the only thing for which I
> can say "this sucks" is having one CVE per commit in a multi-patch fix.
> That's somewhat ingrained in the operation of the bippy script, but not
> unfixable (and BTW I wouldn't mind rewriting bippy in Python, but that's a
> different story).

Yes, the "multi-patch" issue is going to be real, and we will handle it
when it happens.  The current scripts don't handle that well, but they
DO allow us to hand-write entries, which is probably what is going to
happen for those types of rare issues.

And yes, bippy in Python would be nice, but my python skills are bad
(and you didn't want me writing it in perl), so I went with what I could
do in the amount of time I had to get it up and running.

> > I've already had soo many threads from the "Red Hat product security
> > team" including flow charts and other fun things to last me quite a
> > while already, and that's just in the past few days.
> 
> Lol yeah I've seen some of those too (but only this morning---I'm not
> writing on their behalf, in case that was unclear).

I met with someone from Red Hat earlier this week and hopefully most of
this will be resolved soon, I'm waiting to hear back from them for the
issues we discussed.

thanks,

greg k-h

