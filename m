Return-Path: <linux-kernel+bounces-17533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8481824EF0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 007A31C22707
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68AA71C687;
	Fri,  5 Jan 2024 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kp2USlvH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBFD20306;
	Fri,  5 Jan 2024 07:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704438494; x=1735974494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k7NPKkHLDmwR2N923yR5n3HVkP/jGh71yLZZpIHTuqI=;
  b=Kp2USlvHGJK0W+xXcJlXx8uZuBIXp4A+iEP0SWhQF4XmMKeSTsZu08wb
   1mU9S6uurcY1vct97GNVEKc303wH9qpI9Nr3X/v4pCeKvjW4IoD8dfoH/
   XJTq51IYt3f0lpqmRmsZ0T/1wqAZ/8fzCWD/c6kXOZxU8yuu3S9rZs8Zx
   m04H9ToMlms/txifsTc41Zcc8ksjj9GP2kcujKsmrXoKZ8TiSDPkXbMWY
   89IXpVEbcexnBzUHnRWJoAYsiaIat3MjuVFvq1MwXcJv/zAm9EDkWgFhl
   1owcSt5Ye3pOrpudBNrXbiMjGMcDc/6SGsVtvZcNU8ma+0q3K8UkjHUQH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="396333881"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="396333881"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 23:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1027683361"
X-IronPort-AV: E=Sophos;i="6.04,333,1695711600"; 
   d="scan'208";a="1027683361"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2024 23:08:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 0E54129B; Fri,  5 Jan 2024 09:08:09 +0200 (EET)
Date: Fri, 5 Jan 2024 09:08:09 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Sanath S <sanaths2@amd.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	YehezkelShB@gmail.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset
 downstream ports created by boot firmware
Message-ID: <20240105070809.GN2543524@black.fi.intel.com>
References: <20231219122634.GJ1074920@black.fi.intel.com>
 <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
 <20231219180424.GL1074920@black.fi.intel.com>
 <20231220125857.GA2543524@black.fi.intel.com>
 <5bfaa405-b15e-36ef-a4e0-04b93dd983b1@amd.com>
 <257c694f-5aa2-c29b-891d-3a1f480dd4a1@amd.com>
 <20231221095307.GB2543524@black.fi.intel.com>
 <6308b3e6-d935-93cb-b05d-7c9790b091d4@amd.com>
 <20240103171709.GL2543524@black.fi.intel.com>
 <39fc8ce8-baab-bf53-d177-1034dfc81be9@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39fc8ce8-baab-bf53-d177-1034dfc81be9@amd.com>

On Thu, Jan 04, 2024 at 07:20:05PM +0530, Sanath S wrote:
> 
> On 1/3/2024 10:47 PM, Mika Westerberg wrote:
> > On Wed, Jan 03, 2024 at 07:45:56PM +0530, Sanath S wrote:
> > > On 12/21/2023 3:23 PM, Mika Westerberg wrote:
> > > > On Thu, Dec 21, 2023 at 03:01:50PM +0530, Sanath S wrote:
> > > > > > Sure. I'll check with these combinations.
> > > > > Can you name any docks that meets these requirements ? I'll try to get
> > > > > hold of it here and check.
> > > > Pretty much every Titan Ridge based dock. For instance Dell WD19TB.
> > > > 
> > > > I have some hardware here that I can use to try it out too.
> > > It seems that issue is seen on Dell WD19TB too. So this fix may have to
> > > extended to TBT3 as well ?
> > Hm, what issue? I thought this works accross all the supported devices
> > due to the DFP, no?
> > 
> > > I'll give it a try this week and share the observation.
> Got my hands on Dell WD19TB. And it works!
> 
> Here is lspci -t output with and without fix
> 
> without fix:
>            +-03.1-[04-62]----00.0-[05-07]--+-02.0-[06]----00.0
>            |                               \-04.0-[07]--
> With fix:
>            +-03.1-[04-62]----00.0-[05-62]--+-02.0-[06]----00.0
>            |                               \-04.0-[07-62]--
> 
> I'll send out v3 with with splitting into 2/3 patches(Will see how it looks
> good).

Okay and you checked also that with the WD19TB (and its integrated xHCI)
there are no additional boot delays because of the reset?

> Any other comments, we can take it on v3.

Sure.

