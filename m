Return-Path: <linux-kernel+bounces-22364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96296829CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253BEB2676B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995744BA9D;
	Wed, 10 Jan 2024 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YW3tl2eZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AB74BA92;
	Wed, 10 Jan 2024 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704897201; x=1736433201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Rrdonx8W2fa1hkTCE3CDen74TpIbVz/aorEdzlKbOIA=;
  b=YW3tl2eZEul0FKbCvz1xPbIlwT2KaRSMWuyE0EfFeces/3t9bcMT7ZSy
   xSOaEahSoa3bVRu1YFjOee8B0MYuFm3O59qv9JIO9m4mIeT7y+RlN8g9+
   MS9CtVH6v5MkDr2Re+QJzHMRDmC2MgjQYIeEe1vpbxT/WRxF0iQG7CErs
   +wxKTdV8bo3mNN/lC+4BDIKr1GdVvRmKJAbd+L3oK2/ogWw1m7VxxVGdS
   zVhXFoD2TG35baXElusJVqjXgnfj4LpKlUH2G1pCftP2jfT+iXmHzYJ4n
   S06K8sZexso71KtHqRTOGPP5FPkqpg0ZIom9NqnJOK4HpHhONYw5Fo1GM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="397392846"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="397392846"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 06:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10948"; a="905557268"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="905557268"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2024 06:32:04 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 70B6F2BE; Wed, 10 Jan 2024 16:32:03 +0200 (EET)
Date: Wed, 10 Jan 2024 16:32:03 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20240110143203.GP2543524@black.fi.intel.com>
References: <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
 <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
 <20231221095307.GB2543524@black.fi.intel.com>
 <6308b3e6-d935-93cb-b05d-7c9790b091d4@amd.com>
 <20240103171709.GL2543524@black.fi.intel.com>
 <39fc8ce8-baab-bf53-d177-1034dfc81be9@amd.com>
 <20240105070809.GN2543524@black.fi.intel.com>
 <ff6243f8-4487-2290-1d31-93acbedb27da@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ff6243f8-4487-2290-1d31-93acbedb27da@amd.com>

On Mon, Jan 08, 2024 at 10:26:13AM +0530, Sanath S wrote:
> 
> On 1/5/2024 12:38 PM, Mika Westerberg wrote:
> > On Thu, Jan 04, 2024 at 07:20:05PM +0530, Sanath S wrote:
> > > On 1/3/2024 10:47 PM, Mika Westerberg wrote:
> > > > On Wed, Jan 03, 2024 at 07:45:56PM +0530, Sanath S wrote:
> > > > > On 12/21/2023 3:23 PM, Mika Westerberg wrote:
> > > > > > On Thu, Dec 21, 2023 at 03:01:50PM +0530, Sanath S wrote:
> > > > > > > > Sure. I'll check with these combinations.
> > > > > > > Can you name any docks that meets these requirements ? I'll try to get
> > > > > > > hold of it here and check.
> > > > > > Pretty much every Titan Ridge based dock. For instance Dell WD19TB.
> > > > > > 
> > > > > > I have some hardware here that I can use to try it out too.
> > > > > It seems that issue is seen on Dell WD19TB too. So this fix may have to
> > > > > extended to TBT3 as well ?
> > > > Hm, what issue? I thought this works accross all the supported devices
> > > > due to the DFP, no?
> > > > 
> > > > > I'll give it a try this week and share the observation.
> > > Got my hands on Dell WD19TB. And it works!
> > > 
> > > Here is lspci -t output with and without fix
> > > 
> > > without fix:
> > >             +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
> > >             |                               \-04.0-[07]--
> > > With fix:
> > >             +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
> > >             |                               \-04.0-[07-62]--
> > > 
> > > I'll send out v3 with with splitting into 2/3 patches(Will see how it looks
> > > good).
> > Okay and you checked also that with the WD19TB (and its integrated xHCI)
> > there are no additional boot delays because of the reset?
> I did not observe any delays. As now we are not doing any discover as well
> before resetting.

Okay thanks!

