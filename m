Return-Path: <linux-kernel+bounces-32919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F628361EE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA811C265F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFC43B282;
	Mon, 22 Jan 2024 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HkKmEawu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D203B1AC;
	Mon, 22 Jan 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922834; cv=none; b=NnwI9+pSRd+3z9D13vdayAltWD2DUhJBEwMAC8X2gDHNwPZEPnqwsALtSOH2HORpNwlWXtLE6EG7pKz6C64mpwmJDo9kCaHvk7EBgebaB/UvxmPfCQni6gnnzhh2Pwr2OLKUdd9qyvrWdSfr/5bJ7g8IpjB6t1tz7uUKdCEqawU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922834; c=relaxed/simple;
	bh=R2Uy9J91czH4bYRlAIUq9XE55rq4rDwm81b227GSnVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXZm3RRLI08li+zvSDDG6/MDMPcqaU8Olj32bExUkKFlQ2AXJCmEPkzvHAzLdxYRPaHvhxVNW4RBmyd5uL/3J9oKK3c/phkHoFei82f7YPhsYEvP13lXnks96TtKCQRgs6W2SWFMZNQoYt/xfMejbXYb3H+AFCoFScSrt/6wIT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HkKmEawu; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705922833; x=1737458833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R2Uy9J91czH4bYRlAIUq9XE55rq4rDwm81b227GSnVs=;
  b=HkKmEawudyjusBqT90RjLSgQjuD42j6T09Gn7QynH1/d+Owjmw8Z2a01
   ZU88BVZmHYsJ32HNlt09gx43z5cAtyNoeu0imLM8ehJoAhfXAEvLinQHU
   STVFYFUDAn4yhBzgc78iwvpGX3Gs6PKnE4EPD8C07juC8hB+p9I3fm6wt
   PFn88sNC7x6ghlymyvQwIQQxH1iuRdjRYBrpJideNooyKx4654E1IuWtC
   +GeXIUCEdQX7R4VuCWdZgKpw/9wF8tf0et9GNb5YU1yhWGNzX/XFOOVMv
   6L9CN3OiOEHkl7swlDZ/Ksn+ylPX61/pFpdLTdgMC3I7NKMVIV24A2nG6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="8569607"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="8569607"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="819661979"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="819661979"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 22 Jan 2024 03:27:07 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0B3F724D; Mon, 22 Jan 2024 13:27:05 +0200 (EET)
Date: Mon, 22 Jan 2024 13:27:05 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <Sanath.S@amd.com>
Cc: mario.limonciello@amd.com, andreas.noever@gmail.com,
	michael.jamet@intel.com, YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v3 0/4] Add support for downstream port reset(DPR)
Message-ID: <20240122112705.GG2543524@black.fi.intel.com>
References: <20240106165723.3377789-1-Sanath.S@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240106165723.3377789-1-Sanath.S@amd.com>

On Sat, Jan 06, 2024 at 10:27:19PM +0530, Sanath S wrote:
> Tunnels created by boot firmware results in incorrect PCI resource
> allocation, which results in failure of extending daisy chain.
> This series aims to resolve inconsistent tunnels or paths created
> by boot firmware.
> 
> Before:
>            +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
>            |                               \-04.0-[07]--
> After:
>            +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
>            |                               \-04.0-[07-62]-- 
> 
> This series also aligns with windows behaviour of performing a teardown
> of tunnels and resetting the downstream ports using DPR during the init
> sequence.
> 
> Changes since V3:
>  - Remove discover_tunnel() api before resetting DPR.
>  - Add lane and protocol adapters reset in tb_switch_reset()
>  - Addition of tb_lc_reset_port() for TBT1, TBT2 and TBT3 routers.
>  - Addition of tb_path_deactivate_hop() api to help suppport path
>    reset of given hop index.
>  - Addition on new patch to store and indicate host router reset 
>    status of USB4 v2
> 
> Changes since V2:
>  - Perform DPR only for USB4 routers.
>  - Update kernel-doc and return value to -EOPNOTSUPP.
>  - Limit delay range to 10-15ms.
> 
> Sanath S (4):
>   thunderbolt: Introduce usb4_port_reset() and tb_lc_reset_port()
>   thunderbolt: Extend tb_switch_reset() to support lane and protocol
>     adapter reset
>   thunderbolt: Store host router reset status in nhi_probe()
>   thunderbolt: Teardown tunnels and reset downstream ports created by
>     boot firmware

All applied to thunderbolt.git/next, thanks! I did some tweaking to the
code and the changelogs. Please check and make sure your test cases
still pass.

These have been in our internal validation for a while and no issues
have been reported so far.

