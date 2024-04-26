Return-Path: <linux-kernel+bounces-160081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8568B38D1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8983E1C23479
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2F91482E2;
	Fri, 26 Apr 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AyuzjRfb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C434B13E88A;
	Fri, 26 Apr 2024 13:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714139305; cv=none; b=Rtmdvu/G8R/QwruTZSYPAVSliVeLfB7qLuKt+qbSPXTVWoc0/dm90gVxKYX94laUPO0F7hnEmlOOk6cr8DmuSdGuXJznMy4iSDJbkneJThRHl69iqRaT0JntFpHvn2xX716XwSp6/TqA0x/l+J647w1T25Ju0t18y/+so4uBfls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714139305; c=relaxed/simple;
	bh=CVt098XMcqJuxlB7KCSTMK5GOkDwkqvnGsfBrELUvl0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MoUu1byV09ZT/CEDQK3W1VGqyjwStqehwIOG+N6E3JgOnydtD6pEq4HyH3sWmoeXfMjlHJsW1hGzuAB2yVyarVQVB5JU0IL9NkJsVgDcXGKSoFzrz/Z/Xnx77SOtw1K+cvyK9bBgdmKPxy17ydMv1c15RCsPsi4KDJHzIcLW7Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AyuzjRfb; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714139304; x=1745675304;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CVt098XMcqJuxlB7KCSTMK5GOkDwkqvnGsfBrELUvl0=;
  b=AyuzjRfbd+JFevnYDN9bnddZnbsK/+2ij2RGJH3ajiU5uwkjK2hhX4Ub
   s6WVoM0qqhA/eLy8UPZFpzFH/qUqGJQYCQ41v7NrKM6YnO8jNTzomDp3A
   b1mbTyy8mttwdPnTfha7Q9NHtV5iGM7S2mN6KRc3AiBL+002Lw/tm7Im0
   U2E8j28c0+7WAzCUIIK2FL1psv2zQUWGjj0BzWVa65XLMgC+qMVd14v2y
   /oVj1onL8O4J43ypuIgc/lgmRfCnFgncW2lO8L4zsT1EjaJjPmbNVdnrx
   2d6/f8xsu8YU0js6oucdCgHo53IHXi6JYeorhoJPeOJOgruJI0ihr3p7O
   A==;
X-CSE-ConnectionGUID: ret8E2JXShitcXHCr6J3cA==
X-CSE-MsgGUID: g7R29V6mS7GLRAE3nbdzLA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="10036352"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="10036352"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:48:23 -0700
X-CSE-ConnectionGUID: MzaPGJQ2Q9OOJ4tRj/Or5g==
X-CSE-MsgGUID: e1tdIDEzTDaQPwDE7HIG+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="25923680"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.43])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 06:48:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Apr 2024 16:48:17 +0300 (EEST)
To: LuMingYin <lumingyindetect@126.com>
cc: LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jirislaby@kernel.or
Subject: Re: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
In-Reply-To: <20240426133959.1294012-1-lumingyindetect@126.com>
Message-ID: <ffcdb008-9a66-530c-1463-3cbe3a324684@linux.intel.com>
References: <20240426133959.1294012-1-lumingyindetect@126.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 26 Apr 2024, lumingyindetect@126.com wrote:

> From: LuMingYin <lumingyindetect@126.com>
> 
> The return statements at line 347 and line 351 in the lpss8250_probe() function result in a memory leak of the variable pdev.
> Add a label named free_irq_vectors in the lpss8250_probe() function to release the memory area pointed to by pdev.
> Modify the two return statements mentioned above to jump to the label "free_irq_vectors" instead.

Also, this is not a 100m sprint. Please leave time for people to comment 
on your previous submission before sending the next version out.

People are from different timezones and have other things to look too 
besides your patch so they might not be happy if they find 4 versions of 
your patch in their inbox before even having time to look at the first 
one.

-- 
 i.


