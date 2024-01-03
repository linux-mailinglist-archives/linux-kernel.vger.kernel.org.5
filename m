Return-Path: <linux-kernel+bounces-15793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2E882331A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B473283D74
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 17:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6044E1C292;
	Wed,  3 Jan 2024 17:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/9VC7Qo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2491B1BDDD;
	Wed,  3 Jan 2024 17:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704302234; x=1735838234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ggtc85f/Hg7zg/WPPFQzdPYOy1NCfEfoDs0eYs09L9o=;
  b=X/9VC7QoKg2FTKaAHAPRJmWPxk3G+11pbPNI+YM/VlOhnJAgSkbArn84
   oFckMxjnCKQO7sCRlsgkrwRduGEKoITN8taI2HD5FhdpOpjkaq0RbDg0I
   SIbxfCwGTYnuBR5k9Qo+2nopHuRdcv908tizCC85kDDDDoxK9VFlOR0oA
   F6z60flwoqGiqepwqSe5PoxVtV8OjsVE2TMo7gygVeBK4BL1h9QUGwsGI
   VToDONvoWDSLxhU9glIjuE9MBGUD//DzzewJrs/zkx1b7foRkJcU1vmde
   NbD3x89ZXlN5KLrTpmr28C7n3PoPJPsdiQeFSW1SWkNT8R2gdCY2knDRG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="400847951"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="400847951"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 09:17:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="783563376"
X-IronPort-AV: E=Sophos;i="6.04,328,1695711600"; 
   d="scan'208";a="783563376"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jan 2024 09:17:10 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 8F370948; Wed,  3 Jan 2024 19:17:09 +0200 (EET)
Date: Wed, 3 Jan 2024 19:17:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20240103171709.GL2543524@black.fi.intel.com>
References: <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
 <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
 <20231221095307.GB2543524@black.fi.intel.com>
 <6308b3e6-d935-93cb-b05d-7c9790b091d4@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6308b3e6-d935-93cb-b05d-7c9790b091d4@amd.com>

On Wed, Jan 03, 2024 at 07:45:56PM +0530, Sanath S wrote:
> 
> On 12/21/2023 3:23 PM, Mika Westerberg wrote:
> > On Thu, Dec 21, 2023 at 03:01:50PM +0530, Sanath S wrote:
> > > > Sure. I'll check with these combinations.
> > > Can you name any docks that meets these requirements ? I'll try to get
> > > hold of it here and check.
> > Pretty much every Titan Ridge based dock. For instance Dell WD19TB.
> > 
> > I have some hardware here that I can use to try it out too.
> It seems that issue is seen on Dell WD19TB too. So this fix may have to
> extended to TBT3 as well ?

Hm, what issue? I thought this works accross all the supported devices
due to the DFP, no?

> I'll give it a try this week and share the observation.

Okay thanks!

> Any luck from your end ?

I did not have time to try it out yet unfortunately.

