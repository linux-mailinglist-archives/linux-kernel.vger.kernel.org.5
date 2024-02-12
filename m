Return-Path: <linux-kernel+bounces-62451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930D68520E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2355B230B6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C754D131;
	Mon, 12 Feb 2024 22:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eap62WKl"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AF9481D7;
	Mon, 12 Feb 2024 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707775516; cv=none; b=l2iLXM4u0P6R8IrQffxInmtrErWRGTmN2TG8fTQ85mGhUy5moQS0WgY23jxXud04Em9ke4lqaIztx9S8VCuJPhSV+nPnyD+0GhoGt6ys2ROiH3lITdQ699foj0i4NJvGjNbakRnYf/rm8oy0Vs6hHo3jFZrkTgdMlKMan6ibeHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707775516; c=relaxed/simple;
	bh=2RLRDPhu3sgf3BDJLN3IMc0/kUDRPZfmsdCW2qjmaAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZA95dFsaqQVaE7SP88KvRe6IvD42RFzCRHA1IGZ8aG+9bKOKcJArAYvmwyBs6hixJyUQOUmWRFM/bUeOd4bu5p5PVgD0EwHRPDQLI8r3HFYFYPFr4qKwLN6m+RULofnrSyGxoT9VCK9hWYGTsdUDbBpSpuU70bUWO0zq7XN3Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eap62WKl; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707775515; x=1739311515;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2RLRDPhu3sgf3BDJLN3IMc0/kUDRPZfmsdCW2qjmaAE=;
  b=eap62WKlW15MTim66z3vB3XdRvDBZx6xyn8UkgzeZbd6lg7pKeqOwIWR
   8g0ke+8PTmOxBT7SVt44LtVLXeZqXkBzSEMmJcaa2/mJ47VZbYOksr4Vc
   xHpA4uqThk6k5YfQzHnmdElPDwCaq8imucKBC6Bvhu8+b6gih3mze6xpl
   NJfxtS/vWi8CkRqi/h9Ha2nP26C4+fH0ltVEzZR516ATxTWCFnbIzGcz+
   t5OZ6eG8EK3rFjglamzPRSnw5Ryj1qPDsrbM/NIIwR4kcr64t+sHDxPC8
   /DpypXQJkRbLq8tgVipZq2ovlVt8F3CQOCl46rfg51tavd3W0KixAQz/4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1897542"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="1897542"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 14:05:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="25902072"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 14:05:11 -0800
Date: Mon, 12 Feb 2024 14:05:10 -0800
From: Tony Luck <tony.luck@intel.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: "babu.moger@amd.com" <babu.moger@amd.com>,
	"Yu, Fenghua" <fenghua.yu@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Drew Fustini <dfustini@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Message-ID: <ZcqWFr8fX9G0hoJU@agluck-desk3>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <642f81da-669b-4057-8b97-2894dd57842b@intel.com>
 <SJ1PR11MB6083036DC25D4FA55B02589AFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <16a63923-2fd2-4d44-a8a3-32d8d6eeee9e@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a63923-2fd2-4d44-a8a3-32d8d6eeee9e@intel.com>

On Mon, Feb 12, 2024 at 01:43:56PM -0800, Reinette Chatre wrote:
> Hi Tony,
> 
> On 2/12/2024 11:57 AM, Luck, Tony wrote:
> >>> To be honest, I like this series more than the previous series. I always
> >>> thought RDT_RESOURCE_L3_MON should have been a separate resource by itself.
> >>
> >> Would you prefer that your "Reviewed-by" tag be removed from the
> >> previous series?
> > 
> > I'm thinking that I could continue splitting things and break "struct rdt_resource" into
> > separate "ctrl" and "mon" structures. Then we'd have a clean split from top to bottom.
> 
> It is not obvious what you mean with "continue splitting things". Are you
> speaking about "continue splitting from v14" or "continue splitting from v15-RFC"?

I'm speaking of some future potential changes. Not proposing to
do this now.

> I think that any solution needs to consider what makes sense for resctrl
> as a whole instead of how to support SNC with smallest patch possible.

I am officially abandoning my v15-RFC patches. I wasn't clear enough in
my e-mail earlier today.

https://lore.kernel.org/all/SJ1PR11MB608378D1304224D9E8A9016FFC482@SJ1PR11MB6083.namprd11.prod.outlook.com/
> 
> There should not be any changes that makes resctrl harder to understand
> and maintain, as exemplified by confusion introduced by a simple thing as
> resource name choice [1].
> 
> > 
> > Doing that would get rid of the rdt_resources_all[] array. Replacing with individual
> > rdt_hw_ctrl_resource and rdt_hw_mon_resource declarations for each feature.
> >
> > Features found on a system would be added to a list of ctrl or list of mon resources.
> 
> Could you please elaborate what is architecturally wrong with v14 and how this
> new proposal addresses that?

There is nothing architecturally wrong with v14. I thought it was more
complex than it needed to be. You have convinced me that my v15-RFC
series, while simpler, is not a reasonable path for long-term resctrl
maintainability.
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/ZcZyqs5hnQqZ5ZV0@agluck-desk3/

-Tony

