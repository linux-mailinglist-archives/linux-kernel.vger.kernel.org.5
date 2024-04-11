Return-Path: <linux-kernel+bounces-140256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D958A1058
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C29F28A74A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDF214AD1E;
	Thu, 11 Apr 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mBXpP9aX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E03763A2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831554; cv=none; b=o/BzVBD8yHQ0L9wpk7zQit4+j2rKzS2DEizXpKaTLsUicKo3NhAl0QDkwrEpKZCx8qJ8k5TQ3cqm3N8brTBrFVuDiR5HvAkO1YfbqRDpE6BdA1M1K4c+Y0vbC3R6Bjy1FK/7m8YZMdT38T9o8e5YxdBaUJa5tK4zBEwvPGLQs0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831554; c=relaxed/simple;
	bh=HawZNmng9KXbtihT8cuza2yA1mBwUbPhsT7bqD+fH3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo6dCgT/JJUkXPESGYxFO8Mcl8CWAHdGeFkjZJ9oqr6MQTXBPzs560zCd1vhXTPdwbSzhocvI+pS8ZuOCIvEbvqovJAQwy88nKsNs4CgdL5kXO25x8EWa2gGWfRvH7Mh3VD47/lKYEFhQuoDqC6FTO8h/NPOySOZl/qKrViJXAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mBXpP9aX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712831553; x=1744367553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HawZNmng9KXbtihT8cuza2yA1mBwUbPhsT7bqD+fH3M=;
  b=mBXpP9aXr/lCopsc27HBF3lELdKJXZ9UrUAa00Uh/tE+Ifol3NqYTDg5
   SGZLrmtrYFJeuCDdug2KeZoAqEfniNR5fZshcvHPeFRbKpE3WAZu+/SWQ
   5jkKKMwbDq23HAl/XXa9cPeasgD23bMBfvGsEUtkWhiNh3oNtlxQy00Js
   SKDSEeBqolv2mKBD0HUC31Bmm+B7sYCnIJtYmlDd8GxJiZS7pvoE2uG3t
   hQW7lkzHF7sNZ55bnv4URM64OdXxllcAee4/37mx+ARbAIRkry3JEh4Od
   eHAZJPZZG+Oad/+AWdyiQJp4CZUOFy45IlYj7U6zQ88+cYDZi9Q7ySTfF
   A==;
X-CSE-ConnectionGUID: DKX4bRGRTM+AgARVRRaElQ==
X-CSE-MsgGUID: ji9OGwF1QKeMSrFgPH91zw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8453484"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8453484"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:32:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915459755"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915459755"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:32:30 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rurjI-00000003K32-3BSP;
	Thu, 11 Apr 2024 13:32:28 +0300
Date: Thu, 11 Apr 2024 13:32:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] auxdisplay: charlcd: Add missing
 MODULE_DESCRIPTION()
Message-ID: <Zhe8PK9lca3GBUDN@smile.fi.intel.com>
References: <20240409161523.935384-1-andriy.shevchenko@linux.intel.com>
 <20240409161523.935384-2-andriy.shevchenko@linux.intel.com>
 <CAMuHMdUeh0T0Y=zizZLx9oB44qwCgGmNdvGa3Bx4xZGOz6BLDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUeh0T0Y=zizZLx9oB44qwCgGmNdvGa3Bx4xZGOz6BLDw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 09:31:32AM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 9, 2024 at 6:15 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > The modpost script is not happy
> >
> >   WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/auxdisplay/charlcd.o
> >
> > because there is a missing module description.
> >
> > Add it to the module.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



