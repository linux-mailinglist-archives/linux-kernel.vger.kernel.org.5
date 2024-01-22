Return-Path: <linux-kernel+bounces-32924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53DE836202
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86B81C21AC8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A530241203;
	Mon, 22 Jan 2024 11:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ep/lV8e6"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1F040C12;
	Mon, 22 Jan 2024 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922968; cv=none; b=rlGiFUcOwHEzVZoW6YnuD1sIziDgv4sIJRkqRPovo1Nztp7DsMMZ2EHbPIxm3JOAxOvfxEwu0ivWFnbKKHsmgyO9QtwS0hr7ICUz9dhcIPUj65gueIF8F3R8ndRM/Y5a+/is/Pjczc5UT6GH1UaDS8nNQLr0Es1ZJJUfj05g2ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922968; c=relaxed/simple;
	bh=zczYGq/mA49LVGnYY1sC5slAUBCyibjNUhl/7Ir7/Kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s64uJ1bYLOQdCcwBVUFqx452uGvYtgQzAXdPgwvRW+XhU7HjKRNwlj/i9/KXiGtNHgC57s2xwrGSXXuAYRaywdIOGscbppCBtFKSCStMndo8Vuw2vHv6TyGVXvNEbZ6A2izXHcEihY7Pg8xLyLIQl/HC3PSPyvv2Ug6AjZmbd8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ep/lV8e6; arc=none smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705922966; x=1737458966;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zczYGq/mA49LVGnYY1sC5slAUBCyibjNUhl/7Ir7/Kg=;
  b=Ep/lV8e60DB0U9U8G1YkvDL1byvZFqjDFWgwUzRDN8qwYb39j+qaxXRp
   8SN8BnIlPn8EcXI7HULeik7dBHWGfVpepdCNZ17lGaHNEiPtP8gBK938a
   eGBg0MJIyydFYmtr0dTWBbiWabPv8ceyouOjiiqVVBDUGNeU7IzcYE1gS
   YPhSI/6YFHOPXIqM9TfEM3qXkEa0VWL1LzvXx1lGkzKnVIWf3o2cyvEVj
   kfpdbTWmr+QxgEvjU2WEmZ7yKa+tNYVvzktpSFQHx7A77LCJQaqMR6UFB
   k6pzi8ZETLrUkPgd+Xw18f/4h2kwOIPop8/3QHyrTLhP4yYuejXdOhaxv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="398335862"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="398335862"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:29:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="928963490"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="928963490"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2024 03:29:23 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 6521024D; Mon, 22 Jan 2024 13:29:22 +0200 (EET)
Date: Mon, 22 Jan 2024 13:29:22 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Remove usage of the deprecated
 ida_simple_xx() API
Message-ID: <20240122112922.GH2543524@black.fi.intel.com>
References: <7fce4c8c4345d283dbfadd3cea60fdc49f9ca087.1705007397.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7fce4c8c4345d283dbfadd3cea60fdc49f9ca087.1705007397.git.christophe.jaillet@wanadoo.fr>

On Thu, Jan 11, 2024 at 10:10:21PM +0100, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range()/ida_alloc_max() is inclusive. So a -1 has been added
> when needed.

Looks tood to me but wanted to check if you tested this on a real
hardware or you just build tested?

