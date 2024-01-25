Return-Path: <linux-kernel+bounces-38596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4082D83C2DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E461F28F6E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EB44F5E9;
	Thu, 25 Jan 2024 12:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jRYeAJoB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86A145035;
	Thu, 25 Jan 2024 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187256; cv=none; b=L0be1l5HNsgy97F/zIeg/ohA4jG0VZ+45MwhgO/M2HWBt9Fg0mP8FTut54cfeARN0bWh654IF3o9XLbEzbpzwCtbJGBXb9GKHQ7pj7zs38dfAFoX5t7+GEiSTWYjhaQv9j7qtkVoRLOfjYIGXiNdH8rM4w16m1054Qe/ysQ5C84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187256; c=relaxed/simple;
	bh=aDy+zxrBvLGBTnY5ULjZGxPIAzRHjhbDUT0L0vBGqd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TuHGDkWeel9Q+zSuumbRPxcyM1VQOZPo5jkPt2tT86H00FZZ2Kj94+5fhyhsCcwaLc/MCLeB+GRK5qRQYewwCjLO3+DTRDlxLbdoXsF+2dIQWvvkbA7793269ftgcHny3BaFdYV1JLUuVDEW1+cM+ORvS06JZQGbfWinVJNWyTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jRYeAJoB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706187254; x=1737723254;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=aDy+zxrBvLGBTnY5ULjZGxPIAzRHjhbDUT0L0vBGqd8=;
  b=jRYeAJoB7cpi+bhu61jCCApbXxTaDzoK4CS1BkR7woahFwpT7zF3qA8d
   UUc/3ZAw7+Q70fhbGRM5tp8YMauoUNldNMrtlb+WZrcq/hP8CJr5regbF
   Mq3pwydpLshH4frRxxtcCMGc2lJjHnI+KmGgPRJLpy630lObfhf/F8gWt
   RpMUWDgPe6iGZHhx6PDFl+LNsVL0vFUQD//zRJS3x1yQ9YrHyKnzM+m9H
   Cc3mtRKUO3xNZsNLE/Cf24jujnC9uEWaCO+8ag/uVsL4KMm6yFNLmN0Vv
   pJBst6y9K4IQeiV9Dk8rSTmBKTP5nzVoAkmutfDCr+nkKdj9eemzha48L
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15684163"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15684163"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="959846151"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="959846151"
Received: from unknown (HELO localhost) ([10.237.66.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 04:54:09 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thorsten Leemhuis <linux@leemhuis.info>, Linux kernel regressions list
 <regressions@lists.linux.dev>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: More detailed text about bisecting Linux kernel regression --
 request for comments and help
In-Reply-To: <5cfc34c7-8298-4639-bb81-8b95392279ba@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
 <87fryllpp5.fsf@intel.com>
 <5cfc34c7-8298-4639-bb81-8b95392279ba@leemhuis.info>
Date: Thu, 25 Jan 2024 14:54:06 +0200
Message-ID: <874jf1lgk1.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 25 Jan 2024, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> On 25.01.24 10:36, Jani Nikula wrote:
>> The one thing I find problematic is the use of shallow clones by default
>
> FWIW, some of what is in that text is a result of similar discussion
> that happened when
> Documentation/admin-guide/quickly-build-trimmed-linux.rst was submitted
> about a year ago, which also uses shallow clones by default.
>
> Further a quick reminder, as it's easy to forget: most of us live in
> areas where downloading a lot of data is not something that bothers us
> or will take a lot of time. But it is different for some people that
> will need this document.

I'm not suggesting to ignore or forget the people for whom full clones
might be slow or costly. I'm suggesting to first describe the basic
principles in as simple ways as possible, and then expand on pitfalls
and corner cases in separate sections.

I think even the simplest and most basic kernel bisect can be
intimidating for anyone doing it for the first time - and that's the
target audience here - so I'd like to not scare people with all the
difficulties with shallow clones right off the bat. Lure them in first!
;)

Also not suggesting to throw out all the things you've written, just to
structure it different.

>> and, well, the use of git in ways that I myself can't figure out without
>> resorting to the man pages. I think it's a lot of dark corners of git
>> that's overwhelming and really unrelated to the bisection itself.
>> 
>> If I point people at that, and they have problems, I'm just going to
>> tell them to:
>> 
>>   git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>   cd linux
>>   git remote add stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
>>   git fetch stable
>
> This could be simplified, as linux-stable.git includes mainline, it's
> just sometimes a few hours behind.

It's perhaps a personal preference more than anything to have origin
always point at Linus' tree, and all the other repos as additional
remotes. Then I can ask people to add remotes e.g. for drm subsystem to
try out new stuff. YMMV.

>> And I can tell them to 'git checkout v<GOOD>' and 'git checkout v<BAD>'
>> and proceed from there.
>> 
>> To me, that's the TL;DR.
>
> FWIW, I earlier today considered changing this myself. But then I
> noticed the bundle clone instructions (more on that below) are complex
> as well. :-/
>
> Hmmm. Maybe switching to "do a full clone of linus' repo (without using
> bundles) and just telling users to add the stable branches they might
> need" by default would be a good middle ground for this document. Guess
> then I'd switch quickly-build-trimmed-linux.rst over myself.
>
>> And then you can have a section on "what if I
>> really can't do full clones" and various options to save bandwidth.
>> 
>>> Downloading the sources using a full git clone
>>> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> If downloading and storing a lot of data (~4,4 Gigabyte as of early
>>> 2023) is nothing that bothers you, instead of a shallow clone perform a
>>> full git clone instead. You then will avoid the specialties mentioned
>>> above and will have all versions and individual commits at hand at any
>>> time::
>>>
>>>   curl -L \
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle
>>> \
>>>     -o linux-stable.git.bundle
>>>   git clone linux-stable.git.bundle ~/linux/
>>>   rm linux-stable.git.bundle
>>>   cd ~/linux/
>>>   git remote set-url origin \
>>>     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>>>   git fetch origin
>>>   git checkout --detach origin/master
>> 
>> I mean seriously, even the full clone instructions use curl, without
>> rationale. Why?
>
> That was the result of the discussion back then, can't remember all the
> details and all the places where that happened. Part of it was reducing
> the server load, but that IIRC is mainly a concern for CI systems and
> something this document can ignore. Unstable internet connection might
> have been the main reason -- in combination with the redirection thing
> kernel.org does, which *IIRC* prevents us from using "git clone
> --bundle-uri=".

Perhaps server load should not be a consideration in *this* particular
case?

To me, all of this is just saying "git is difficult", and that's kind of
the wrong message here. :/


BR,
Jani.



-- 
Jani Nikula, Intel

