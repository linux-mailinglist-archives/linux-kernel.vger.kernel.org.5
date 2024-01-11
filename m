Return-Path: <linux-kernel+bounces-24096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644A582B6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DF1A287301
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0662A58200;
	Thu, 11 Jan 2024 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmtR5rry"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6F5811C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 21:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705009234; x=1736545234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P8QIKWKyzneFO38LCkd0vx1/9c4bZLeHMfLW6KO/QR4=;
  b=QmtR5rryzB0gX8NvOr1Un+PDl1O/L0j1e6TcdZViHRcNsCrcQIHoY8oq
   u7bEhEJN3vEVt4wEZ5W+aWgClR2cke1tC2cr4n6Y/L/p9O68SggkGN6s+
   l+M76XdM/98JrkEaW6Qa97Av/K4F1a0UAyxxTraNjQU/O35NWGS9MLkPp
   byGMUW83FcaqSvnht7/LHh0ekqmS8y8byvHaQklcMnyVduMQg5794OcDh
   XxcWavHxjrY/XNkhl3swP75TjL6TSaQiRqWwX7/kerxuKAbcPiBTz0CkN
   Ke63gSpQDBQHQAnoIEblI8ni/7Q9qxzQh4/QB6eiJuns0C+2t/8HPL9Rh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="398686089"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="398686089"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 13:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="17172987"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 13:40:33 -0800
Date: Thu, 11 Jan 2024 13:40:32 -0800
From: Tony Luck <tony.luck@intel.com>
To: Peter Newman <peternewman@google.com>
Cc: Amit Singh Tomar <amitsinght@marvell.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"fenghua.yu@intel.com" <fenghua.yu@intel.com>,
	"james.morse@arm.com" <james.morse@arm.com>,
	George Cherian <gcherian@marvell.com>,
	"robh@kernel.org" <robh@kernel.org>
Subject: Re: [EXT] Re: [RFC 00/12] ARM: MPAM: add support for priority
 partitioning control
Message-ID: <ZaBgUOQ3iWs3hLrb@agluck-desk3>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
 <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
 <MW4PR18MB5084D5EEBC450BD66E8063E3C61FA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <6114c8d0-97a1-be54-3e43-30348be38683@intel.com>
 <MW4PR18MB50847032F3ACFDBDBCA6D57AC61CA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <be51596e-2e62-2fb9-4176-b0b2a2abb1d3@intel.com>
 <MW4PR18MB5084EB7DBE4985D981FE84F2C61DA@MW4PR18MB5084.namprd18.prod.outlook.com>
 <CALPaoCgjFKtTtgrh2UwEsX0DsVnmRF2+8LS4CUdSLjMPmLVgMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCgjFKtTtgrh2UwEsX0DsVnmRF2+8LS4CUdSLjMPmLVgMA@mail.gmail.com>

On Thu, Jan 11, 2024 at 12:56:34PM -0800, Peter Newman wrote:
> Hi Amit,
> 
> On Thu, Aug 24, 2023 at 1:52 AM Amit Singh Tomar <amitsinght@marvell.com> wrote:
> 
> > 2) Second approach that we discussed internally is to have schemata for CPOR, and PPART separated by new line as mentioned/suggested by Peter, But it may require to tweak
> >    the ARM MPAM device driver a bit. It was kind of toss-up between 2nd and 3nd approach :), and we went with the 3rd one.
> >
> >    L3:0=XXXX
> >    L3:0=PPART=X

I'm not sure having multiple lines for the same resource makes anything
clearer.  I preferred one of the earlier proposals like this one:

	L3:0=XXXX,PPART=X,CCAP=X;1=YYYY,CCAP=Y

This makes the schemata file self enumerate which optional capabilities
are present for each L3 instance (in the above example the second
instance doesn't support PPART, but does support CCAP).

Writes to the schemata file already accept partial information, so
the resctrl schemata_write() function should be coded to allow any of:

Just update CCAP for L3 instance 1":
	# echo "L3:1=CCAP=Z" > schemata

Update mask and CCAP for instance 0:
	# echo "L3:0=ABCD,CCAP=Q" > schemata

Update PPART on all instances:
	# echo "L3:0=PPART=M;1=PPART=N" > schemata

Legacy app that only comprehends partioning updates instance 1:
	# echo "L3:1=FFFF" > schemata

-Tony

