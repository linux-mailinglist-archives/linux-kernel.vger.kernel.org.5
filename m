Return-Path: <linux-kernel+bounces-140248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69468A101E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A246A288D82
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53945149E07;
	Thu, 11 Apr 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeZkfApH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41631474CD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831431; cv=none; b=nWBENAwUfGPut3dVanEDm1tGfJLTotJAKuZbXPqZ28nRSxlVsxXGD+v2YmaUeSrMWo7FMQ4xLlfC1ZzQ1A6aRKyIeh4XqBh8l+HN95qEZP3hCRFMsd6JFS57gjeKaq4+uhcxXhVvsDrgg7yP+4DchhnRRI88URuC4rkksZky2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831431; c=relaxed/simple;
	bh=bk91gh7CRciNDNeIjh1iY7VNBKKVxM7c4sByv4PBnmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMeBkfXQFKbOaVMwSxIuA5KbEY4SBmGvt8Tn7jpeY5DC5kVcbIRBgsxRIylvLDgBXrchMDF50RZ+hIQaQeYig8R8AmOax2W0w8TkYKordzXqlVMrRtJucS595fc4ew0wGVii3IS2AAcqtvH68KYJm22hPNUHDTHSc+tSFOMZWRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeZkfApH; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712831430; x=1744367430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bk91gh7CRciNDNeIjh1iY7VNBKKVxM7c4sByv4PBnmM=;
  b=UeZkfApHqin02VoT23WzWV0xaxfVsDPpVQiUeS/tVxlJ3dMz9huCKlQQ
   HMbgDzhBs5QLPpm5p87BxIR2OpfUEwVZBZLwBsTKoW3kMZzJliAisQj2Z
   nUlfQVkXWmbq+fUwkrWW42csCAunPbS+hWk54+I4HdHFX3qS9+Ew9SUbn
   RsQcWdc+f9I50IkLBYk00K6LaXv4XGMe+zsKGohYFqCl0cpxZzoVPc4x2
   DSYNonMH7j9mnE0R82DPt5kdY8SsK949kB/qZJcfPEuR3BAbuz2qY32Ar
   bktNB41q/n9eO2DHJMcsKlw95SfoguQqKUOaeNyEu9cTBvwpLHnfH/TTe
   g==;
X-CSE-ConnectionGUID: SvNfysA0RdyumwuDAwrPFg==
X-CSE-MsgGUID: d2jicpYJQheBI/zWWDxzGQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8453283"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8453283"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:30:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915459714"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915459714"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:30:27 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rurhJ-00000003K0X-0Ldr;
	Thu, 11 Apr 2024 13:30:25 +0300
Date: Thu, 11 Apr 2024 13:30:24 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] auxdisplay: charlcd: Provide a forward declaration
Message-ID: <Zhe7wK-OhvHtGTHH@smile.fi.intel.com>
References: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
 <20240409161523.935384-3-andriy.shevchenko@linux.intel.com>
 <CAMuHMdX_n4kifH6F20tt-umtL3rY9zb6=XmgrnXvuOJSibhrEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX_n4kifH6F20tt-umtL3rY9zb6=XmgrnXvuOJSibhrEQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 09:30:31AM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 9, 2024 at 6:15 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > While there is no compilation error, strictly speaking compiler
> > should know about used types beforehand. Provide a forward decoration
> 
> declaration

Thanks, I updated locally. Please, see my answer below.

> > for struct charlcd_ops before using it in struct charlcd.

..

> > +struct charlcd_ops;
> > +
> >  struct charlcd {
> >         const struct charlcd_ops *ops;
> 
> No forward declaration is needed at this point, as ops is a _pointer_ to
> the structure.

The same way as in all other cases. We may drop all of them, but strictly
speaking (as I mentioned in the commit message) this is a good practice.

I.o.w. a forward declaration of custom data types is used for _pointers_.

> >         const unsigned char *char_conv; /* Optional */

-- 
With Best Regards,
Andy Shevchenko



