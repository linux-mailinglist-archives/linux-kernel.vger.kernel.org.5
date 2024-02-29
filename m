Return-Path: <linux-kernel+bounces-86824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A94A86CB4D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:19:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163481F2214B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A1B1350E4;
	Thu, 29 Feb 2024 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vzPoyGF0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FE7CF15
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 14:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216319; cv=none; b=eTJwQtl6qEYM0ydJlz2T4Jh0QHwaieuWP6mWO4CMdr79eObKJcueSGRC1UCm+Q1RdJeNx768Pphf1BsAH2hDRYLpV3XHt9LpvnD1q96sEIxXJXO1BMHhBDyahoHu9W2z/DIpATZhfq9y46Zljj91DSMZMo26xL3PdiNSLmCLouI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216319; c=relaxed/simple;
	bh=Rlox7OXqkMisbgDe5RFseNq2dunfChpnYpDTHszFR7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXsGk30fk/wY9Katx02Fo2OVhHUz2ZJJNo2xnsugnUKjmOw+m0ZDigb8Goi2pganUvWjC1j0m8/aOZ0kySQsQLHlLf6aKXxepDNqczFkk/u6N8I64YINz62/90BDlYmA4z/ua3LmNw2EzZpbs6Y/TBR7COtI3cF3wO9CeunQUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vzPoyGF0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C9C4C433F1;
	Thu, 29 Feb 2024 14:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709216318;
	bh=Rlox7OXqkMisbgDe5RFseNq2dunfChpnYpDTHszFR7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vzPoyGF03RT31qtEJDLUkrCL84YkcNICWVIx/sn1ZCblb89EoAp8/1+LQm5gIkeCd
	 tvOyIjU3Obj8JO5+cCtPF//svIWGFInVooi9+GQgEgWbbJAOTAoTJsPotS6EzIg1n/
	 v5NAdSDk4iQObUy1mpyhC6Te2l1lN/y3o6p0Xn7U=
Date: Thu, 29 Feb 2024 15:18:36 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Kees Cook <keescook@chromium.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <2024022913-borrower-resource-ecc9@gregkh>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka>
 <2024022915-dissuade-grandson-ebd4@gregkh>
 <ZeBRZqJd5HAKaOfC@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeBRZqJd5HAKaOfC@tiehlicka>

On Thu, Feb 29, 2024 at 10:41:58AM +0100, Michal Hocko wrote:
> > > > This has been a long standing problem with communicating this
> > > > to engineering management in many organizations. They have pointed to
> > > > the relatively small number of CVEs and said, "just backport those
> > > > fixes", and trying to explain that it's is totally insufficient falls on
> > > > deaf ears.
> > > 
> > > I think it is fair to say/expect that every downstream is responsibile
> > > for the kernel they are distributing and that applies to vulnerabilities
> > > affecting those kernels. Forcing fixes by slapping CVE over them sounds
> > > just very dubious to me.
> > 
> > Not having CVEs assigned for things that can cause issues is dubious,
> > which is why we are doing this.  We can not determine use cases of our
> > code base, that is up to you as a distro to figure out, all we can do is
> > our best to call out "This might be something you want to take!" which
> > is what we are doing here.
> 
> You are missing my point I am afraid. Downstreams do not need CVE numbers
> to fish for useful fixes. Downstreams, however, would appreciate the call
> out serious security problems to treat them with higher priority because
> believe me it makes a huge difference to address an exploitable problem
> promptly rather than one that is affecting a misconfigured system which
> is by definition vulnerable. And while I am sympathetic with your "we
> cannot assume usecases" statement, I believe we can still tell a
> difference that some configurations simply make no sense from the
> security perspective.

The reason we became a CNA is NOT because we want to only call out "high
priority" issues, because obviously, we can not do that as we do not
know anyone's use case and we can not claim any specific user is higher
priority than another.

The reason we DID become a CNA was because there were entities out there
filing CVEs against invalid stuff AND causing problems for everyone,
including the kernel developers themselves, and making it impossible to
ever get anything revoked no matter how wrong they were.

As part of the requirement to be a CNA, we have to announce everything
that we think is a potential vulnerability, severity not be judged at
all as that is NOT part of the CVE project or program.  It is up to
others to judge the severity, not us, nor the CVE group themselves,
that's not what the ID is for.

So, because of this, we are now assigning CVE ids to everything that we
review that we think is a vulnerability AND everything that people
submit to us to have a CVE assigned to that they deem is a
vulnerability.  Many groups/people have already asked us for IDs and we
have only turned one down so far (the submitter agreed that it wasn't an
issue at all).

We also are required to go back through the GSD entries and create CVE
entries for them as well, which is why you are seeing these "older"
entries be created.  We have many thousands to go through of them, so
that will take us a while to catch up (next few months.)

Again, none of this has anything to do with "severity", it only is an
identifier that says "this fixes a vulnerability".

> > Why is that not a good thing?
> 
> Because the more dubious or outright bogus CVEs there are the less
> meaningful they will become.

That's not our problem or issue.  All we care about is properly tagging
things we see as fixes for vulnerabilities.  Other groups can judge the
"meaning of what a CVE is or not".

> Look, it seems there is a huge gap in our understanding of what the CVE
> is good for. I was really hopeful that the noise/signal ratio would be
> better with the new model but that doesn't seem to be the case so far. I
> was also hoped that the dispute process would be improved but judging
> from the discussion so far I have lost that hope as well.

It's better than the old process where you could NOT even dispute a CVE
and get it rejected at all, don't you think?  We've already rejected a
few, probably more than has ever been rejected for the kernel in the
past few years.

We are working this out as we go, if you can come up with ways to make
this easier for everyone involved, we are more than willing to work on
it.  But note, it's only been a week!  Give us a chance please.

And the signal/noise all depends on your use case.  Again, we can not
judge that.

> Please asked yourself again who is going to benefit from this. Stable
> users certainly not, because they are supposed to use the latest stable
> kernels so all the fixes (no matter of CVE), downstreams based on stable
> kernels will not benefit either because of the same reason. Downstreams
> which are not based on stable trees will not benefit either because of
> the low signal/noise ratio and will need to find a better way to find
> important and safe fixes. Probably the only winner will be those fancy
> CVE scanners which will have more to scan.

The overall community is going to benifit because more actual fixes will
be picked up by the distros that today are not picking them up.  It's
pretty trivial to get root on most of the "enterprise" kernels today,
and on many phones, because people are NOT picking the stable releases.
I do a presentation every year at a major phone company where I show how
easy it is to break their device just because they keep insisting that
they "know" what commits to take from the stable kernels.  They have
finally changed their minds and will be taking stable updates, and I
hope the enterprise kernels will as well.

But again, that's independent of the CVE process.  We have taken it over
because what was there was broken and abused by many bad actors.  And
again, we are now required to report as many issues as we notice, which
is what we are doing.  We will get some wrong over time, but overall, I
only see complaints about 2-3 when we have already issued:
	Number of assigned CVE ids, by year:
		2019:	   2
		2020:	  13
		2021:	 147
		2022:	   1
		2023:	  51
		2024:	  26
		Total:	 240
240 as of right now, and haven't really started the process of issuing
ids for the current stable tree (i.e. 6.7.x).

thanks,

greg k-h

