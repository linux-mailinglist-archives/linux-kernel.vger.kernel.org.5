Return-Path: <linux-kernel+bounces-59893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 522BC84FD02
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2932867A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECCF84A42;
	Fri,  9 Feb 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIx2O0BX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5097F496;
	Fri,  9 Feb 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507598; cv=none; b=ERXZp+jqKoMJArZrpyX3fwPL5tRTqmg7aA3LP3+ECVewxThGI5XVNSMTXKpPlwDfgpGEzzvhsKCiblx0xeTHmk3paFJpqPYc9EkchHvvQC7KTj0yWgPGoYz/FVbJ8VNG41MSOqZyZga7SNtVrCzUDCav+EmpvZ65URjaRVO//IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507598; c=relaxed/simple;
	bh=p50ceEzr8fqyzxu4AYepp96pYziEc9mrmHTAdFEP5TY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8z00J/wvi7qpH9CVdou6oRoVJvEzpSWsq/ztCoxqBpbH/TqDr/9vYQtyTbbLJPH0RpQyLebtIB/IN+wnMQzm4D0U475iyEePCJ5cekvJ9p8pmU4NMb4j8kl3GtwJR1E39jIs4Gg7b6Gz6tr1tjT25VRGpGC3TKq0Z8t7yOgOwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIx2O0BX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707507596; x=1739043596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=p50ceEzr8fqyzxu4AYepp96pYziEc9mrmHTAdFEP5TY=;
  b=jIx2O0BXNkciG2GxUjN8SgYF2iMv5eaJIAXYe/t25cEIjfu1iCUXeuqB
   nJPrc00/BYpIG0HhMt4vOvAVTzjCvkgdtQ9wh+iYJ/7bLn5gZjPvrG4F+
   qqo6d2cAjQEh9h9v/ztJ6G8yCY6tfpj/K2jrmGtaJY4barXuZUdxZgbgF
   3L/Viw3MxR5MWKAX67NoWEWnJtdNrDUsw4P+UkQfq9XsvwWK6YkL5t7TA
   3uSvxsuW7aFO3Logj18aJRnLTHX0GrsmT+D1vt0FMw75oCDYpDxDZBxkc
   FX6Z4EO8udvTo1u+HdVzUgGmTkKAzaYla2hwOqC5igs02My0PJcvmScBy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5341077"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5341077"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:39:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="910802533"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910802533"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:39:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYWiz-00000003GSs-2G2A;
	Fri, 09 Feb 2024 21:39:49 +0200
Date: Fri, 9 Feb 2024 21:39:49 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, jthies@google.com, pmalani@chromium.org,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] usb: typec: ucsi: Limit read size on v1.2
Message-ID: <ZcZ_he1jYx8w57mK@smile.fi.intel.com>
References: <20240209060353.6613-1-abhishekpandit@chromium.org>
 <20240208220230.v4.1.Iacf5570a66b82b73ef03daa6557e2fc0db10266a@changeid>
 <ZcY2kVlUn7SJ5pW8@smile.fi.intel.com>
 <CANFp7mW0F_zyaKJg0LusT6Cp4h0_8Z4jq+R1GUGtpyZrv99iVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANFp7mW0F_zyaKJg0LusT6Cp4h0_8Z4jq+R1GUGtpyZrv99iVw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 09, 2024 at 10:01:07AM -0800, Abhishek Pandit-Subedi wrote:
> On Fri, Feb 9, 2024 at 6:28 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 08, 2024 at 10:02:38PM -0800, Abhishek Pandit-Subedi wrote:

..

> > > +     if (ucsi->version <= UCSI_VERSION_1_2)
> > > +             buf_size = min_t(size_t, 16, buf_size);
> >
> > Please, avoid using min_t(). Here the clamp() can be used.
> I think this is likely the 4th time I've been tripped up by an
> undocumented practice in this patch series. <linux/minmax.h> says
> nothing about avoiding min_t -- why prefer clamp()?

While in this case it will work correctly, the size_t is unsigned type and 16
is signed, while buf_size is unknown in this context. It means if buf_size is
signed, the min_t gives wrong result. clamp() is better choice.

See also, e.g., https://lore.kernel.org/all/20231004064220.31452-1-biju.das.jz@bp.renesas.com/.

> Please add the
> recommendation here
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/minmax.h#n10)
> and I am more than happy to change it after.

It's not my recommendation :-)

https://lore.kernel.org/all/CAHk-=whwEAc22wm8h9FESPB5X+P4bLDgv0erBQMa1buTNQW7tA@mail.gmail.com/

Feel free to submit a patch.

..

> > Shouldn't magic number be defined?
> The comment right above this line documents the number.
> As this is the only use right now, I don't see a need to make it a
> macro/constant yet.

OK.

-- 
With Best Regards,
Andy Shevchenko



