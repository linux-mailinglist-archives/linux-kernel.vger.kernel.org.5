Return-Path: <linux-kernel+bounces-43706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50113841814
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:05:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D49DE284C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9462EAF7;
	Tue, 30 Jan 2024 01:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VH4+r4ue"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62422083;
	Tue, 30 Jan 2024 01:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576711; cv=none; b=lEEmkChvp1jzYvwdewTr6IBm90yJNdtatJ3HMo4b/exwWMLg/gEZSBMTn5GvzlBSvSzs74vE18x8C6J9TN+LqQtzaKEBhpF+r9TSBRslSDb1kY5p4oPmxjZxZFxSc0/vsaQMwdK9L7cBrLuMZiSjQBTTV491yuky7Z4zBctvW5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576711; c=relaxed/simple;
	bh=bG7LWMMzQOA4pnHxVE9T5M/eEsZhCIbhOeGSUfM/lKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AriK6cdD46Orq3gb67r0OVY/qqCQL30fkliXZa2RHSvzZw357OJAgu3H5TxLge2UJMfpcUtnWrMGBe5CoKI5aYD2C+X7LinDc7uIqs5L5YZ1LqPOBZd0fmc/5dHuDkA1iomFgUDlEAIL6IwEolTLPpWlSg5TiCfFKF5CnVtdNu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VH4+r4ue; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706576711; x=1738112711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bG7LWMMzQOA4pnHxVE9T5M/eEsZhCIbhOeGSUfM/lKE=;
  b=VH4+r4ue2ZMNASQsQOoTk+/pQDt2Bd3s05csty7MZCeZAy6dTUA0aRci
   2ZWhMBf5shCzBiIvmiSkxnzwxq2xA6REZP/b6DrwMmuMPeep/mRjub3cc
   x0BUqU0NwW9nJeTG51QnKr8NN8CKoMAvMKPBHklqfGX+znWZWeIfbCjL6
   lnnc7bjVfea3Ac6llpgcEnd+oQ6w8YtTZAPFtSHX5GAiDalaTpPxQiiM/
   qLNAirP7XOUksGl+vaye8NRThXZfdDzgfxqjDTPL2JOu+3LW1yKM3vsFt
   UPQSnTt+QazJAnQPKSqdoh2aerUO/716RRAS9MLLzRxdxgYEOKc0dyx9O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3006761"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="3006761"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 17:05:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="29719504"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 17:05:09 -0800
Date: Mon, 29 Jan 2024 17:05:08 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shaopeng Tan <tan.shaopeng@fujitsu.com>,
	James Morse <james.morse@arm.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Babu Moger <babu.moger@amd.com>,
	Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH v14 0/8] Add support for Sub-NUMA cluster (SNC) systems
Message-ID: <ZbhLRDvZrxBZDv2j@agluck-desk3>
References: <20231204185357.120501-1-tony.luck@intel.com>
 <20240126223837.21835-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126223837.21835-1-tony.luck@intel.com>

I've been wondering whether the SNC patches were creating way too much
infrastructure that isn't generally useful. Specifically the capability
for a reactrl resource to have different scope for monitoring and
control functions.

That seems like a very strange thing.

History here is that Intel CMT, MBM and L3 CAT features arrived in
quick succession, closely followed by MBA and then L2 CAT. At the time
it made sense for the "L3" resource to cover all of CMT, MBM and L3 CAT.

That became slightly odd when MBA (another L3 scoped resource) was
added. It was given its own "struct rdt_resource". AMD later added
SMBA as yet another L3-scoped resource with its own "struct resource".

I wondered how the SNC series would look if I went back to an approach
from one of the earlier versions. In that one I created a new resource
for SNC monitoring that was NODE scoped. And then made all the CMT and
MBM code switch over to using that one when SNC was enabled. That was
a bit hacky, and I moved from there to the dual domain lists per
resource.

I just tried out an approach the split the RDT_RESOURCE_L3 resource
into separate resources, one for control, one for monitoring.

It makes the code much simpler:

 8 files changed, 235 insertions(+), 30 deletions(-) [1]

vs.

 9 files changed, 629 insertions(+), 282 deletions(-)


Tradeoffs:

The complex series (posted as v14) cleanly split the "rdt_domain"
structure into two. So it no longer carried all the fields needed
for both control and monitor, even though only one set was ever
used. But the cost was a lot of code churn that may never be useful
for anything other than SNC.

On non-SNC systems the new series produces separate linked lists
of domains for L3 control & monitor, even though the lists are the
same, and the domain structures still carry all fields for both
control and monitor functions.

Question: Does anyone think that single domain with different scope for
control and monitor is inherently more useful than two separate domains?


While I get this sorted out, maybe Boris should take James next set
of MPAM patches as they are, instead of on top of the complex SNC
series.

-Tony

[1] I'll post this set just as soon as I can get time on and SNC machine
to make sure they actually work.

