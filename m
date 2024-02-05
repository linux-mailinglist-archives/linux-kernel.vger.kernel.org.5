Return-Path: <linux-kernel+bounces-53975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D733D84A8A3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82DB21F2AE30
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960844F211;
	Mon,  5 Feb 2024 21:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTnWI9hQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D651AB81F
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707168303; cv=none; b=VdnU/OGyKJpmUbbMysSM615NAn7jZqSI95awixrp8sPBok0aJO70giVM9ejUpIx20bOqQQ36Z2cdKBE03PxFLvlDX3QhcLq0oKc43kPq90er0Wa8DhwkP3QlQnLIPOTHClM0IdLYnpIYH1q2618ockH6Q1UcnvzIP9a8JfDHn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707168303; c=relaxed/simple;
	bh=cLLUzHtVNa9Ni8zK+vujHDtOv0dDf+RtNRn2qD7fUzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGuY+/wnZVRjOH8seloXAu1YK65RBRmC905qqMwxrIhLjtI58AEaLKkzi5+g7GJzJSlOleoHHKaOr6cOFzAZbN9fNSIXTV27cwhCOL8x2wCz6NSOVqrbwbn2Fmd9Wc97vvC43iC/orKPIpvdf/G1IVL9gatpvKTbcWrlQT9xDE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTnWI9hQ; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707168302; x=1738704302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cLLUzHtVNa9Ni8zK+vujHDtOv0dDf+RtNRn2qD7fUzM=;
  b=CTnWI9hQUNTVt7DIE3n5TMOzOJkgPg+62knyrS61NZWyL65oY0MsGO+z
   eI8thS02icpgMimlmNQ03tj40ivbGmPpNr3ySEbWwHDK0n/lLV04t+vMK
   ZE5++PGtFRGkNGMWKmQXZzbllI0NauQmfsJZehmjGjJKHvgiJBRicpYo8
   YNTIxR3YsKyJcZXwW34UETekJqw3XXGVEsZiu4FdNEsgsoZZCHMPEuOPY
   EoVtK3zHcJ1caJsH8bHwJj5YjPRkBIOp1pW2XkjMPzWxa0D1lTfgncjWo
   aCM5fBAwwdVv/3BH2FU850+hRuPfa1oL0W/Qo8QHlzxRflPEMoOonuGCL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11347103"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11347103"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:25:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1100845"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 13:25:01 -0800
Date: Mon, 5 Feb 2024 13:26:20 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Valentin Schneider <vschneid@redhat.com>
Cc: alexs@kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
Subject: Re: [PATCH v3 2/4] sched/fair: remove unused parameters
Message-ID: <20240205212620.GA17461@ranerica-svr.sc.intel.com>
References: <20240201115447.522627-1-alexs@kernel.org>
 <20240201115447.522627-2-alexs@kernel.org>
 <xhsmh1q9vhrg3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xhsmh1q9vhrg3.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Fri, Feb 02, 2024 at 03:27:24PM +0100, Valentin Schneider wrote:
> On 01/02/24 19:54, alexs@kernel.org wrote:
> > From: Alex Shi <alexs@kernel.org>
> >
> > sds isn't used in function sched_asym(), so remove it to cleanup code.
> >
> > Signed-off-by: Alex Shi <alexs@kernel.org>
> > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> 
> AFAICT this is unsused as of:
>   c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")

Maybe a Fixes: c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")
is in order?

