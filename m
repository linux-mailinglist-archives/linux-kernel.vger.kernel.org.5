Return-Path: <linux-kernel+bounces-119550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9DD88CA59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8E51C656C5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A173757FA;
	Tue, 26 Mar 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+sTbZwO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEEF12E75;
	Tue, 26 Mar 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472845; cv=none; b=pe5MOYKRnmX9KFgic1isgK/ohElLOOhSRgB0CiFJy+oCIRNxnfrGv+0dx6AFECHg7IWDIaPeF4h/8u6YdH3Iq1USuc2Ba4qkrV/IFYV0eM21XQ7cfY1FKnvsj+tiFGtIPXCr5if8e1IN8WGmi6xlVzd1nvGl7Abb6Oj7/4QbUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472845; c=relaxed/simple;
	bh=ORw11zggvPK3vCivrl1I+TdOEO2ouRBSNRl8iFMjGKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=os+sPrUBfI+kyLWpzIx/YoFJT3N67E4c+5AsXhQsAi8gSyRgmiJ3slsh9OqD1hR0zVom8FoYMda0cmo+/nDP30x5tr6xX/TSEW0hLzi6HP2vrulGWORorn3yPvL7g7QIP6G9HnCsIMqyme2MfbwmYZ2W1AUjMXjlKTbKbRlgdK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+sTbZwO; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711472844; x=1743008844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ORw11zggvPK3vCivrl1I+TdOEO2ouRBSNRl8iFMjGKU=;
  b=R+sTbZwObdNMy3zwe3v94XtttbornPlnINKIizSQINfIOdp+QLd772Mp
   K4ZyNoZGut+LoA0+aG9WVfGVnGkKi7htfeQT2vjKED/E347FBLT0wJmI5
   6XliK+JMTNQGoEmoqdv8WkCftXFmB7kXapepmsjRUfLghRzexYDhIx9nv
   H24jnbVjCJAAAMmOFxHmhcHNxHylKIGWl7RAYbqN3NdG7+jbuxoAkFLDh
   3p66B4TG2NLVb7P2aizJTJ02MQxoeITmceSLgro90IdeZE4teEEXzVoLb
   n1iDOkYUmPF4M/rRl2Pa4KUvhZfp2WeV/GQHjIqCLJATaa9BRy7DrgFSB
   g==;
X-CSE-ConnectionGUID: kk/lkYmSQ3+leceaLXlVqA==
X-CSE-MsgGUID: k8pEtSI/TQ21738NARFfuw==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24026961"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="24026961"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:07:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914885454"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914885454"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 10:07:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpAGd-0000000GOcv-0gSV;
	Tue, 26 Mar 2024 19:07:19 +0200
Date: Tue, 26 Mar 2024 19:07:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v2 1/1] ASoC: soc-jack: Get rid of legacy GPIO support
Message-ID: <ZgMAxuNXQDHjUKrr@smile.fi.intel.com>
References: <20240325143654.3305498-1-andriy.shevchenko@linux.intel.com>
 <ZgGvev-Wh7SkYnI7@smile.fi.intel.com>
 <ZgL_N1aMQiju3yaI@smile.fi.intel.com>
 <986726af-ce6b-45a5-b173-f5fb041e9849@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986726af-ce6b-45a5-b173-f5fb041e9849@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 05:02:39PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 07:00:39PM +0200, Andy Shevchenko wrote:
> 
> > Okay, since the fix-patch had been applied, this one now is clean to go.
> > Do I need to resend or any other work needs to be done?
> 
> Please resend.  If I've told you a patch failed to build it's gone from
> my queue, I don't keep track of anything like that.

Noted, will resend soon.

-- 
With Best Regards,
Andy Shevchenko



