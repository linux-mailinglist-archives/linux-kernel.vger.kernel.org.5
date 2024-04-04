Return-Path: <linux-kernel+bounces-131771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8887A898BA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B4991C228AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5667812AAE0;
	Thu,  4 Apr 2024 15:54:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA6127B4E;
	Thu,  4 Apr 2024 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712246085; cv=none; b=gau/fovjZvAcuAezaZec8HMIHdsaLfHp8R0X1v8gAKDxiLax2/2Olw8i1aTau89h8k/AP7dqheAxUqRLBPi1o7KzCBObuhcGL2ECUFr1j85jL7QqWbXUENjYatEZA6Y1SEq6X5lEaPQs9ywpZ/2aBwQZaFQDcs0ZOsv/ZyJLGUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712246085; c=relaxed/simple;
	bh=vVqfrXHIS3zQ2r9jD4TTb/uaoB1pGIFMhsCJ78419QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRVAp4X/3VW/p1/FVY55X4RE6VngQ9A39B4UezQDLFbZzRThYSR5STf5yibpu2jOnjuSAHcLFEMnsQ1iwJz6tQ50hLAaj9Ol/Cw/HqqlJkRUbf5SneJrJhSRSR0GyqVdDbkAmKR2nvfKuYMTgek+hfvL7U01jYw38OOziLK+7DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: wf3n6rFvRK23wXryI0XFPA==
X-CSE-MsgGUID: 0WS6nmNQStWXn7Gva3iVFQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="7777708"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="7777708"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:54:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="915222155"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="915222155"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:54:40 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rsPQE-00000001VJZ-2LJQ;
	Thu, 04 Apr 2024 18:54:38 +0300
Date: Thu, 4 Apr 2024 18:54:38 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: Re: [PATCH v1 0/3] serial: Do not count XON/XOFF in the statistics
Message-ID: <Zg7NPnpFXkQWJ-Ks@smile.fi.intel.com>
References: <20240403144722.860258-1-andriy.shevchenko@linux.intel.com>
 <Zg3VHs-LVxHFdi8V@surfacebook.localdomain>
 <573aac92-9c9b-427b-a76f-3c0b7c3b6ce6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573aac92-9c9b-427b-a76f-3c0b7c3b6ce6@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 04, 2024 at 07:16:55AM +0200, Jiri Slaby wrote:
> On 04. 04. 24, 0:15, Andy Shevchenko wrote:
> > Wed, Apr 03, 2024 at 05:46:14PM +0300, Andy Shevchenko kirjoitti:
> > > Some drivers count XON/XOFF in the Tx statistics, some do not.
> > > I actually a bit uncertain, but I _think_ the correct way is not
> > > to count them, hence this series.
> > 
> > Okay, it seems there are much more drivers doing that. Perhaps we need
> > to add that to the rest in this case (i.o.w. invert the series from removal
> > to addition)?
> 
> Interesting, perhaps cut & paste?
> 
> XON and XOFF are overhead IMO. So should not be counted. When they are, they
> mangle statistics as in transmitted (real) bytes per second.
> 
> How are they handled on the RX side?

It took me a while.

All serial drivers accept everything and those that care, update statics for
anything they receive. This is because of layering. The Rx XON/XOFF seems
(note I am completely unfamiliar with mysterious ways of TTY layers) to be
handled on TTY level by n_tty_receive_char_flow_ctrl(), i.o.w. we may not
skip counting it easily.

Now the question is, shall we count the control characters on output or not?
Whatever decision we made, we should document (if not yet) and align drivers
accordingly.

Another Q is what do books / other OS / projects usually do with them
WRT statistics?

If we count everything on a wire, then we must count them, otherwise
it depends on how we treat them.

P.S.
This series as is should be abandoned. But we may continue discussing topic
under this cover letter.

-- 
With Best Regards,
Andy Shevchenko



