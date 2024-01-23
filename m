Return-Path: <linux-kernel+bounces-35247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313F7838E89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63EC51C23513
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C945EE74;
	Tue, 23 Jan 2024 12:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjxEFgFE"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34B5DF1D;
	Tue, 23 Jan 2024 12:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706012942; cv=none; b=V9KnUrldA0le+P+xWBgwvxoodSBePKu38bD9S3/gD8MYY24BFVWVLrfN5fUpBSnkGXdrjui7y1J/Cl+3YOxOfPE4mka+U71UzOMAV3azXJTWDGz8S//+2i6kfAXnN1Bdx2pzZNCl/4bWBEkLrXbHb0ABcAPb4dd8FToLWpr6xQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706012942; c=relaxed/simple;
	bh=fa13xu/t9vD3MafwP+nS2cWhEeHXrK5C1PsxHCLZJHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5xx34fPumssO3KOC1fQhlusAiYTB2Qopw5J0P53qs8IIdPWy/Q6VkU71BxAfVC/cNBMgbuv5H24YcqDyfye8l92yE/Rw6cvB87ZAp5mU6RMKkdGsqKPrEmhzMdOFDQAojezhgysdGyb1uRFdY9bXtUlPo6zYN1SegDOKl9pTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjxEFgFE; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706012941; x=1737548941;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fa13xu/t9vD3MafwP+nS2cWhEeHXrK5C1PsxHCLZJHI=;
  b=ZjxEFgFEeQmd42aOsCYA7TW1xjHjMp6aPFTz71Nt0KvDksV5LikOERed
   0UDB06G/sF7H7XSwsIeWWiiFkzYFoQuHW+AdyOad/du9+H90h9+Zfcw/i
   wl0+InBEzbj8F4NdWqla3Rp54gZA+1+hr7A3CJNVof1wU9MXs2ZEqLaTP
   3Ff47BmEChijV0k5xcCTH9+flaLOHNH6XejdVVkyOjLQuvQrT+3ffOmOn
   b/DLk3lCTLzHrCI9LI+HTj5mscTsfLRFLdTbZaJPuE4p4vUvC7a5ohRs3
   RJNUcLNWDKcpTSc2cl2ZpZ5AM2h0fsu1Dg/HunFclSuzh2TI8eyKpN5D5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="432662304"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="432662304"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 04:28:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="786050302"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="786050302"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 23 Jan 2024 04:28:57 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id BCDE4483; Tue, 23 Jan 2024 13:34:19 +0200 (EET)
Date: Tue, 23 Jan 2024 13:34:19 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240123113419.GN2543524@black.fi.intel.com>
References: <7fce4c8c4345d283dbfadd3cea60fdc49f9ca087.1705007397.git.christophe.jaillet@wanadoo.fr>
 <20240122112922.GH2543524@black.fi.intel.com>
 <d11852b1-6d9c-4ced-83cb-96e753edd45d@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d11852b1-6d9c-4ced-83cb-96e753edd45d@wanadoo.fr>

On Mon, Jan 22, 2024 at 06:57:42PM +0100, Christophe JAILLET wrote:
> Le 22/01/2024 à 12:29, Mika Westerberg a écrit :
> > On Thu, Jan 11, 2024 at 10:10:21PM +0100, Christophe JAILLET wrote:
> > > ida_alloc() and ida_free() should be preferred to the deprecated
> > > ida_simple_get() and ida_simple_remove().
> > > 
> > > Note that the upper limit of ida_simple_get() is exclusive, but the one of
> > > ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added
> > > when needed.
> > 
> > Looks tood to me but wanted to check if you tested this on a real
> > hardware or you just build tested?
> > 
> > 
> 
> Hi,
> 
> It was compile tested only.
> 
> Transformation has been done with the help of the cocci script below.

Okay that's what I thought too. I ran some testing on a real hardware
and did not see any issues.

Applied to thunderbolt.git/next, thanks!

