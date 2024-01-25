Return-Path: <linux-kernel+bounces-38282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685E683BD7C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 176BF285D57
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3C71BDD9;
	Thu, 25 Jan 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E7YPlVBx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971FE1BC46;
	Thu, 25 Jan 2024 09:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175407; cv=none; b=JWJgnp4F39aJM+cKDpr3On0R9bMw5VN2B/1c/RHY2asW2iTVb8po+kcBY2C8C7PXb3CaKkM/nkvtj2/rVrtw4uUUsZ2/E4nBg2d/A+dSYyE77pUZk8IAR/SODQ2+o06DWCbrkli5SvBZM2oEdk1bhUElYkwpsBMpgE3jD2/k8cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175407; c=relaxed/simple;
	bh=5IdCGjxog+NAv/y7J+sZhb8XlMuQAvpB+GisSh4S9x8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n1xPQ8fni/n+yKeKUIpZ9ONEVOCdYG7ScsHV0k/z26QWgG2glUBg8sHLyzxkHixjEVXl2QCgiu0zAQNsr2T2WGlTtEX7lcP/3xz+Bz2/igBep11KqaFY5WFTlox7293wEUUztzxQDuYsQVRtTAa9eKnxPyQNdYb+ikJlBONJcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E7YPlVBx; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706175405; x=1737711405;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5IdCGjxog+NAv/y7J+sZhb8XlMuQAvpB+GisSh4S9x8=;
  b=E7YPlVBx8zXrhMw6ObNedND5t3fgAfpL9zLncRJy+6OyXRrlT0GIGfE3
   fMqjrh0EZ/5codKBWOs9qCjtVe+ja3HjRC1C7VuUt/zVSNm6WVBsnBmuh
   ozFGNid3Qvb1Jj8NhzJnQz0ZR2TleyZ6BIi2R6TYmjDt4U12qhCOtai2V
   1r6WiGEDNlSkfA70MsZ7diTsETAAf2+UL/yw4EGwMOcE2Ej6AA6sudyW2
   A3b8HDPxTt6S4QPpouS4E2qAG3wFrEqLJPdo9NyRLz/5wv696pyWsFeFS
   fDU1PDjxnAAPHe9QUPUEAGaKXkKiWT6OlSD77IQt1OKgkDOR300s5M5bw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8767135"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8767135"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2303503"
Received: from cyrillet-mobl.ger.corp.intel.com (HELO localhost) ([10.252.58.252])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 01:36:42 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Thorsten Leemhuis <linux@leemhuis.info>, Linux kernel regressions list
 <regressions@lists.linux.dev>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: More detailed text about bisecting Linux kernel regression --
 request for comments and help
In-Reply-To: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <c763e15e-e82e-49f8-a540-d211d18768a3@leemhuis.info>
Date: Thu, 25 Jan 2024 11:36:38 +0200
Message-ID: <87fryllpp5.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, 24 Jan 2024, Thorsten Leemhuis <linux@leemhuis.info> wrote:
> Hi! Find below a WIP text on bisecting Linux kernel regressions I plan
> to submit for inclusion in the Linux kernel documentation in a month or
> two. I could do so now, but chose to write this mail instead, as the
> text would really benefit from a few people actually testing the given
> instructions. Hence if you notice somebody that faces a regression that
> needs bisecting, consider poiting them them to this text, asking them to
> play through this and provide feedback to me.
>
> Ideally point users to the following rendered version:
> https://www.leemhuis.info/files/misc/How%20to%20bisect%20a%20Linux%20kernel%20regression%20%e2%80%94%20The%20Linux%20Kernel%20documentation.html
>
>
> It is (a) a lot easier to read (b) has no odd or broken line breaks,
> like the text below has a few (sorry!) (c) is updated when I improve
> something.
>
> Anyone who might be willing to provide feedback can do so in a reply
> here

Hi Thorsten, first of all, thanks for doing this. I think it'll be good
to have a document on kernel bisection to point people at.

The one thing I find problematic is the use of shallow clones by default
and, well, the use of git in ways that I myself can't figure out without
resorting to the man pages. I think it's a lot of dark corners of git
that's overwhelming and really unrelated to the bisection itself.

If I point people at that, and they have problems, I'm just going to
tell them to:

  git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
  cd linux
  git remote add stable git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
  git fetch stable

And I can tell them to 'git checkout v<GOOD>' and 'git checkout v<BAD>'
and proceed from there.

To me, that's the TL;DR. And then you can have a section on "what if I
really can't do full clones" and various options to save bandwidth.

> Downloading the sources using a full git clone
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> If downloading and storing a lot of data (~4,4 Gigabyte as of early
> 2023) is nothing that bothers you, instead of a shallow clone perform a
> full git clone instead. You then will avoid the specialties mentioned
> above and will have all versions and individual commits at hand at any
> time::
>
>   curl -L \
>
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/clone.bundle
> \
>     -o linux-stable.git.bundle
>   git clone linux-stable.git.bundle ~/linux/
>   rm linux-stable.git.bundle
>   cd ~/linux/
>   git remote set-url origin \
>     https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
>   git fetch origin
>   git checkout --detach origin/master

I mean seriously, even the full clone instructions use curl, without
rationale. Why?


BR,
Jani.


-- 
Jani Nikula, Intel

