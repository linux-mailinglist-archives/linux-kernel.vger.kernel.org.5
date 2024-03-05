Return-Path: <linux-kernel+bounces-92695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D840B872473
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D257A1F24BFF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87BCC8CE;
	Tue,  5 Mar 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gbhhivSC"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5AA8F58
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656612; cv=none; b=XioaHBkXHpwpKlrnPCxPImnMh1YmUVX3FqyNAPG5KyKrGS+S4hqWm1+ZLyXpDYjsXxf3I52TyEpvaQWgWLDSWCFc0iLWsRHXYx1XyTwQB5tbDZgp49A55D9fPoRBC6iUBu28zjBIt0PJoX+HyRaEXrQSh/ypr4D+U0/1OBhbO/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656612; c=relaxed/simple;
	bh=skdid8rQ4xd9PkZPQyKNIOYz4OeOwi8ESlxyTh1j/DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rlguu712BzVRe8Ve9BhHt5/BVezVln+qttrVG6Hx5citkNvm20N/DE5rRx3MopZz4HCY5JIfRmEqTibsU0G8OLoQRT1ete7F5dck5OEEWckxFiQRPbu2DSMVXWnjxaBjC0xDxEEHVxsZmenWQtrPTUZWk+HqJ652fdBbyMrTIMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gbhhivSC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709656610; x=1741192610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=skdid8rQ4xd9PkZPQyKNIOYz4OeOwi8ESlxyTh1j/DU=;
  b=gbhhivSCMR0x/0Oa1rbdp8hM50feEvtgazW3l6gknFbs/4vrN3fExOXV
   I75EZ09XvR8hv2Tn5/zqFjXeA7b++SJllL5qII16NwgBWaXyhjwkKOpNE
   CchYSsLCJapZKzWF2mv1By65MYTBgsPk35udcgMVO9nimWHxlmSgIN8Fp
   hncifklI3VROm9swf3JTn0SHOPdrTYC3ETdZ9wWB1C06RNR/roOz+eIOy
   Dz/yZnbsQ1z7LtQqii256V8dmXdXeQBQ6Fpti+TW/uCW6nspLEY3keQAP
   SstDU75MdUxq5JVYckmAV7Y3RXn3qXgmjh+FtaQU4QHRigNGwowfzpPX/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4082277"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4082277"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914144720"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="914144720"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:36:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhXmV-0000000A29n-06Xy;
	Tue, 05 Mar 2024 18:36:43 +0200
Date: Tue, 5 Mar 2024 18:36:42 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v1 1/1] x86/rtc: Remove unused intel-mid.h
Message-ID: <ZedKGoPoTgWfOVNO@smile.fi.intel.com>
References: <20240305161024.1364098-1-andriy.shevchenko@linux.intel.com>
 <14750023-e5fb-45f7-9c28-9510ce5a5994@intel.com>
 <ZedI9vCoCf9KtHcr@smile.fi.intel.com>
 <0c7c00c0-3b4a-41b3-8664-9ea6ee7e0814@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c7c00c0-3b4a-41b3-8664-9ea6ee7e0814@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 05, 2024 at 08:34:59AM -0800, Dave Hansen wrote:
> On 3/5/24 08:31, Andy Shevchenko wrote:
> >> Any chance you'd like to look a _bit_ more widely and just clean up all
> >> of the unnecessary intel-mid.h #includes that are scattered around?
> > All relative patches just have been sent. They are independent, hence sent
> > separately. Please, apply, what you can, if there is no objection.

> Ahh, thanks for the context.  Any chance you could share that up front
> next time? ;)

Hmm... I'm not sure how. If it's a cover letter, then it requires a series,
which seems an overkill, commenting on a single patch sounds a bit weird to
me.

> I'll stick this in the x86 queue.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



