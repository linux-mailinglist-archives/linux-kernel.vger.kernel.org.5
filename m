Return-Path: <linux-kernel+bounces-39455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69083D166
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81D341F24FA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A2964C;
	Fri, 26 Jan 2024 00:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mDIkrM2O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187ED633
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228237; cv=none; b=AVREzG25H23iaAPOMd5EtvJ/f6XdAy22Ozx7tHK2kXWzOX3sImgcy3bILWHpNfQZJK5Tntfc2AYnSMsMW/BobrUymlxe6SewKYs3hCMya8TzQ9xe1OtKTPEiaTkMGFAOK4GhyYtTKoiCpqHHEFnPn6jnkFp943phIs5UPOXaZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228237; c=relaxed/simple;
	bh=c9ljYoenDGEmtif0Sh3zVw2xBxc9WIhja97q3xx4h0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oglMJ5Bwws+6vtZeukkv+DkNbhy2h0TzK8Y0Gp9vkpnmTdUkAIgAH/iPGFnHZSfk5V/ZYXVxsxVVgisUEc9olcL0ZBOeyfHoybZOORQcPGi8c3okCiaqDi1NVrsWZ7kKZGkQX+uUvwkz7yybxE7bwlSlW3AfChk/v7FZz/IEY2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mDIkrM2O; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706228236; x=1737764236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c9ljYoenDGEmtif0Sh3zVw2xBxc9WIhja97q3xx4h0U=;
  b=mDIkrM2O4YVQvbzGgqi6dJB777jDHLDlBTyuBO5njFI4U9L66hgMuWHW
   AKB0ErM2KdGPT621MrHAjLD5lT20ZUvKP2kbFEIRnhnR2fsjggcP4k+GJ
   lKthFzZWLN8bZi1hzms/KfPzFwVA7Tv1sQYvNs9dhoWZMGdt5izvwPrMS
   QP/Vj7V767Fn+wifWoyqJNjxmdihEXcgBSIaQfoGFPeXmyYYrvnRrsysJ
   9nFWqFZaYuRy+lFgnnkgEHhzDvkaZBiRuaqDrP87wsuKhsLIA7nPD3nAs
   552oHD+MGTTXpCsT2gIXBhm6LFKt+26Z24SWyUFMkqGsQwnzZQv6htltv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="8994629"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8994629"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:17:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2448706"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 16:17:15 -0800
Date: Thu, 25 Jan 2024 16:18:40 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] sched/fair: remove unused parameters
Message-ID: <20240126001840.GA17682@ranerica-svr.sc.intel.com>
References: <20240117085715.2614671-1-alexs@kernel.org>
 <20240117085715.2614671-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117085715.2614671-2-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Jan 17, 2024 at 04:57:12PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> sds isn't used in function sched_asym(), so remove it to cleanup code.
> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Juri Lelli <juri.lelli@redhat.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>

FWIW, Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
 

