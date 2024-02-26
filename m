Return-Path: <linux-kernel+bounces-81917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB07867C25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9005D1C23FFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CCD12B166;
	Mon, 26 Feb 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hkGnIYJp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF669604A7
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708965323; cv=none; b=NzUoWOb1oVCyH4CDFJ/vX6i9F5wiPzD1CHpJy4BAUxKurTYDT7Ubv0djdfIXuPITOythl4w8ID+gVOqfZaFGsMn5efnm/VPYllWGmDigCi+6BLkT8cGMTlxljMzvcqziuM/CU4GBs9f10OQKXMZ9Gqi2txQbRff1WNdxBxRZ9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708965323; c=relaxed/simple;
	bh=bNDcDNc34X+9faRpf39NJUZgLUHAm/B0I0qitkCJ95A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOJVXLJ4NrHbgkpRwJhIz5qkRCCoCkWeLWplCkpfFVVh3LUuheQLQTUujMbiSenRWOuU5aQVCH7KOvtQDkUrFCv9f7fvsrg/OVugWjBDZAj6jc3hEAudCbkIO9qC1k6hmIz1R5yR/knafoYvAyM5fdRV9Y+ZfbHUEFlIVi7QjEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hkGnIYJp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708965322; x=1740501322;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bNDcDNc34X+9faRpf39NJUZgLUHAm/B0I0qitkCJ95A=;
  b=hkGnIYJpaiggquvdwX+A4v0vgh5OgX1mdT7PTD2cmaihHp9ImuJc6vTx
   ClCUwaYAY3VJyyphWhka1KVwltMCvjkBd8H6iI+PyC3y7+JJ7Ht4+ExfD
   rBtwS2g5UHnqaR4bX8hWtHZTdmeQaGSWFsL/8SwymmQzM0K4kNJ7Kaw5Y
   5lYv6jv5jx08t/rw4HqwF+70ulv5eoJ3ONJnll038WgS/vdW0I80emuhG
   zV4uzeDLOfWQU3KBkK+Fgi4Ntx4jop9w5Dam8G0OxEhOmHnnriY8whraH
   HpNVQxardv0nimdF/qjUi2WV+YgvBW2iTmERd73Th39yooOL2Cdm54L04
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="20805975"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="20805975"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:35:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="827770449"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="827770449"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 26 Feb 2024 08:35:16 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 26 Feb 2024 18:35:16 +0200
Date: Mon, 26 Feb 2024 18:35:16 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-gfx@lists.freedesktop.org, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/i915: Indicate which pipe failed the fastset
 check overall
Message-ID: <Zdy9xNwuwLFO4zKj@intel.com>
References: <20240215164055.30585-1-ville.syrjala@linux.intel.com>
 <20240215164055.30585-2-ville.syrjala@linux.intel.com>
 <ZdfApN1h97GTfL1t@intel.com>
 <Zdj2ONs8BZ6959Xb@intel.com>
 <87bk83mfwp.fsf@intel.com>
 <ZdyqAMfEfhyk6zm2@smile.fi.intel.com>
 <878r37me5k.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r37me5k.fsf@intel.com>
X-Patchwork-Hint: comment

On Mon, Feb 26, 2024 at 05:35:51PM +0200, Jani Nikula wrote:
> On Mon, 26 Feb 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 26, 2024 at 04:57:58PM +0200, Jani Nikula wrote:
> >> On Fri, 23 Feb 2024, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> >> > On Thu, Feb 22, 2024 at 04:46:12PM -0500, Rodrigo Vivi wrote:
> >
> > ...
> >
> >> > I think the proper solution would be to have actually
> >> > sensible conversion specifiers in the format string.
> >> > So instead of %<set of random characters> we'd have something
> >> > more like %{drm_crtc} (or whatever color you want to throw
> >> > on that particular bikeshed).
> >> 
> >> Personally I suck at remembering even the standard printf conversion
> >> specifiers, let alone all the kernel extensions. I basically have to
> >> look them up every time. I'd really love some %{name} format for named
> >> pointer things. And indeed preferrably without the %p. Just %{name}.
> >
> > It will become something like %{name[:subextensions]}, where subextensions
> > is what we now have with different letters/numbers after %pX (X is a letter
> > which you proposed to have written as name AFAIU).
> 
> Thanks, I appreciate it, a lot!
> 
> But could you perhaps try to go with just clean %{name} only instead of
> adding [:subextensions] right away, please?
> 
> I presume the suggestion comes from an implementation detail, and I
> guess it would be handy to reuse the current implementation for
> subextension.
> 
> For example, %pb -> %{bitmap} and %pbl -> %{bitmap:l}. But really I
> think the better option would be for the latter to become, say,
> %{bitmap-list}. The goal here is to make them easy to remember and
> understand, without resorting to looking up the documentation!

I was also wondering if we should have some kind of namespace
thing in there. Eg. instead of %{drm_crtc} it could be something
like %{drm:crtc}. Then it would be clear which subsystem (when that
makes sense) "owns" that particular format. But I suppose using
the C foo_ namespacing rule would also work since it should already
be a thing for exported symbols anyway.

-- 
Ville Syrjälä
Intel

