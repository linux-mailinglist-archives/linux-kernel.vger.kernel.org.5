Return-Path: <linux-kernel+bounces-86310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A648E86C3C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495911F21114
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4EA50263;
	Thu, 29 Feb 2024 08:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fhH+vCXz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC950243
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195731; cv=none; b=FtQ/w5iH/mjk3e2bcd5MWXPl6Rj5ILsnucvaF+H2VUfZG0PHwl3U8Mmrh9zH54HMzF5b3lP2S+QoRyKmq4HPZgYHsM1z6Xp+Q54ZS9Ppuxq/MXuNuzqoWqUIJ9Y9cZdwFujI/qtuvsP9msH64a76TEgeLSUb32QuKAHguoZdt6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195731; c=relaxed/simple;
	bh=fA1mNcf8ZmdJIOze7Z8GLbKIyNJJo7AAfgYikEFLClQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kcXN8VTsYe+H587mIrEkw895OoHWWzpoEmgNb0HB3skDWjT4wgyZFs8LlXsaVGJRADhw6pANQWb2Sl5f0M+aBslG1m8l8u0oA/lf9WtNwS8+hcIIJ5VfFIm8Q9J1BpF+11L6w0P/3QDubEE/M07HN9kwLK/GNLXWRFJ0RatvmhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fhH+vCXz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63A9C43390;
	Thu, 29 Feb 2024 08:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709195731;
	bh=fA1mNcf8ZmdJIOze7Z8GLbKIyNJJo7AAfgYikEFLClQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fhH+vCXzbecbs+j3oZM1ubuJfKRIeZMX/7Xo8YwHFfGd8u/b/19JUiroRkWHP3TMO
	 StSxvanXRGK8WCUs2u/a9qyE1p9s+U3fDpYEyxj1HcLUJFsyNEA65k4NN08beO8YSn
	 bwNO9tqeSklYgAnlnPCgWm4RPWrn5epItXiAb+2g=
Date: Thu, 29 Feb 2024 09:35:28 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Kees Cook <keescook@chromium.org>, cve@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-52451: powerpc/pseries/memhp: Fix access beyond end of
 drmem array
Message-ID: <2024022915-dissuade-grandson-ebd4@gregkh>
References: <2024022257-CVE-2023-52451-7bdb@gregkh>
 <Zdylmz28rZ-mCeiN@tiehlicka>
 <2024022639-wronged-grafted-6777@gregkh>
 <ZdytVTOgfvKBBvtn@tiehlicka>
 <202402271029.FD67395@keescook>
 <Zd8hPpP_6q_o8uQW@tiehlicka>
 <202402280906.D6D5590DB@keescook>
 <ZeA-281OudkWBhd_@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeA-281OudkWBhd_@tiehlicka>

On Thu, Feb 29, 2024 at 09:22:51AM +0100, Michal Hocko wrote:
> On Wed 28-02-24 09:12:15, Kees Cook wrote:
> > On Wed, Feb 28, 2024 at 01:04:14PM +0100, Michal Hocko wrote:
> > > On Tue 27-02-24 10:35:40, Kees Cook wrote:
> > > > On Mon, Feb 26, 2024 at 04:25:09PM +0100, Michal Hocko wrote:
> > > [...]
> > > > > Does that mean that any potentially incorrect input provided by an admin is
> > > > > considered CVE now?
> > > > 
> > > > Yes. Have you seen what USER_NS does? There isn't a way to know how
> > > > deployments are using Linux, and this is clearly a "weakness" as defined
> > > > by CVE. It is better to be over zealous than miss things.
> > > 
> > > If we are over zealous to the point when almost any fix is marked CVE
> > > then the special marking simply stops making any sense IMHO.
> > 
> > Perhaps, but the volume of fixes is high, and I think it's better to
> > over estimate than under estimate -- the work needed to actually
> > evaluate all these changes is huge: it's better to take everything from
> > -stable.
> 
> This is simply not feasible for many downstream kernels and reasons have
> been discussed many times.

How does taking 10 patches differ from taking 200 patches?  Your
testing/infrastructure issues should be the same, right?

And really, if you have the crazy requirement of "All CVEs must be
applied" then perhaps that needs to be revisited?  You are dictating
your business's processes to an external entity, is that wise?  And if
it is wise, why are you not able to handle it today?  Making it simpler
for you to consume these entries seems to be a better decision.  With
the changes we have made, you should be able to automatically determine
if you are affected or not, which is something that you did NOT have
before, so this might just be able to be automated, right?

> > This has been a long standing problem with communicating this
> > to engineering management in many organizations. They have pointed to
> > the relatively small number of CVEs and said, "just backport those
> > fixes", and trying to explain that it's is totally insufficient falls on
> > deaf ears.
> 
> I think it is fair to say/expect that every downstream is responsibile
> for the kernel they are distributing and that applies to vulnerabilities
> affecting those kernels. Forcing fixes by slapping CVE over them sounds
> just very dubious to me.

Not having CVEs assigned for things that can cause issues is dubious,
which is why we are doing this.  We can not determine use cases of our
code base, that is up to you as a distro to figure out, all we can do is
our best to call out "This might be something you want to take!" which
is what we are doing here.

Remember, we KNOW that people have been scraping our commit logs for
these types of things and using them in attacks for years.  At least
this way we are giving you a machine-parsable feed that gives you the
opportunity to make your kernels more secure than they previously were.

Why is that not a good thing?

thanks,

greg k-h

