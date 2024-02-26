Return-Path: <linux-kernel+bounces-81817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A59867A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:46:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F89AB2BEFC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEAD12B159;
	Mon, 26 Feb 2024 15:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GEv905fr"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2D12B153
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708961757; cv=none; b=NPGqXcoYwB9aumtN9Hh+ZwIG6jQFSlbhsB1WO4YdhV5RkIGQiK7Gj7rGZPTFgAyrkbUVhuH3WoM+mGcigWyYGaEM6DIpRhRTOWmwvWvHI+V4RIqUzef0hHKRcKlVBJ508wSlwBjf2AG+AkljoHwXGKpqL8PccVWzfHBAJXGnV2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708961757; c=relaxed/simple;
	bh=DEFsTQYOxQB1RzK8jxBp8lvN1PzPps/TqPk/AWNcRnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fKL5iWeDMoPaFpZbVFJtI9GcM8JHYsngyMMtUdvmReqC9MwT5vmZV8Nrc/WX+0kpAUbwwzAdO8CLxzlWcD3igSEfra0QAddoCwOGmxPIZlAYIbQURfBlWJxIwoNZ1/KdDg3NdfC0L6woyB8tAyJkArTzPzx5TxphifCFxe3Y970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GEv905fr; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708961755; x=1740497755;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=DEFsTQYOxQB1RzK8jxBp8lvN1PzPps/TqPk/AWNcRnQ=;
  b=GEv905freVQyNS3OtTO3sWblzDzOpjUUiu1x0r/jLcUTQA44sAl+4DrY
   gO1/yM0B9YEvEC+U+LX76V0UHwjv4yRr0GPTC+cuMNYW0bJL/qsNikV8Z
   GYAJfhE46VmIiVCKv4hC6TF8DznMMGIib9AZTvkRdpB2+2tdKFxu1QXLa
   9rjYOWtBk/OR3nZHQMXcNIQBsPfHRWqlyaz4MwGBA+68AvhGxcXsb13vm
   SudWFqBjqOFTD49Thd4l7KeGVMfQHMA0aIQvujf0lLCn3w5xw0n5V+Lh5
   GS20wiCv+PHVhZ3INkum2mLw/Z7iqGf7YkFju+5gf49yESI4XFd4EweMl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3417046"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="3417046"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:35:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6579940"
Received: from hibeid-mobl.amr.corp.intel.com (HELO localhost) ([10.252.46.254])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 07:35:51 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Rodrigo
 Vivi
 <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org, Petr Mladek
 <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <senozhatsky@chromium.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/i915: Indicate which pipe failed the fastset
 check overall
In-Reply-To: <ZdyqAMfEfhyk6zm2@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240215164055.30585-1-ville.syrjala@linux.intel.com>
 <20240215164055.30585-2-ville.syrjala@linux.intel.com>
 <ZdfApN1h97GTfL1t@intel.com> <Zdj2ONs8BZ6959Xb@intel.com>
 <87bk83mfwp.fsf@intel.com> <ZdyqAMfEfhyk6zm2@smile.fi.intel.com>
Date: Mon, 26 Feb 2024 17:35:51 +0200
Message-ID: <878r37me5k.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Feb 2024, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wr=
ote:
> On Mon, Feb 26, 2024 at 04:57:58PM +0200, Jani Nikula wrote:
>> On Fri, 23 Feb 2024, Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.=
com> wrote:
>> > On Thu, Feb 22, 2024 at 04:46:12PM -0500, Rodrigo Vivi wrote:
>
> ...
>
>> > I think the proper solution would be to have actually
>> > sensible conversion specifiers in the format string.
>> > So instead of %<set of random characters> we'd have something
>> > more like %{drm_crtc} (or whatever color you want to throw
>> > on that particular bikeshed).
>>=20
>> Personally I suck at remembering even the standard printf conversion
>> specifiers, let alone all the kernel extensions. I basically have to
>> look them up every time. I'd really love some %{name} format for named
>> pointer things. And indeed preferrably without the %p. Just %{name}.
>
> It will become something like %{name[:subextensions]}, where subextensions
> is what we now have with different letters/numbers after %pX (X is a lett=
er
> which you proposed to have written as name AFAIU).

Thanks, I appreciate it, a lot!

But could you perhaps try to go with just clean %{name} only instead of
adding [:subextensions] right away, please?

I presume the suggestion comes from an implementation detail, and I
guess it would be handy to reuse the current implementation for
subextension.

For example, %pb -> %{bitmap} and %pbl -> %{bitmap:l}. But really I
think the better option would be for the latter to become, say,
%{bitmap-list}. The goal here is to make them easy to remember and
understand, without resorting to looking up the documentation!


BR,
Jani.

>
>> And then we could discuss adding support for drm specific things. I
>> guess one downside is that the functions to do this would have to be in
>> vsprintf.c instead of drm. Unless we add some code in drm for this
>> that's always built-in.

--=20
Jani Nikula, Intel

