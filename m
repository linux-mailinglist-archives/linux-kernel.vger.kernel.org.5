Return-Path: <linux-kernel+bounces-56763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F75F84CECA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B631F24209
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E697D811EF;
	Wed,  7 Feb 2024 16:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0lXzm6w"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7CD8120B
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707322901; cv=none; b=LI31ar55AykRjw57K7EgD47u0Iw8Yv1u/PkmVfi0y7Z/Ck1gUkNkKhGy2CEk2rDjoDRg+kCn7jTTFn7PO4IPzfW6BGelmcIL94P88G/cm3UhNDCz/vYzEx32nipahFj6j08F8wVEIWqP3jVjeXqK/uktoJBkd6gDpTx6pD+AnyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707322901; c=relaxed/simple;
	bh=Ham27Lju8X30G/Pi7G2NB/yVZZfjl/5xdSUO56dUsNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTr7K/hUJNYQ2szj5wCAuheFzBG0H8vXjyPhDDWAHJ3smn65tHTds+wPBTVS+T2CtnluzaF8lwwM6BGuXYiaPVWTK1j1MRiGTUN11Q9B7FnbBHrLNWwv5NUR/Q0KgNRm+RpGOjV8TjgcaSh/1vLMMmLbj4wd6YUkwvEedsEUF+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U0lXzm6w; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707322900; x=1738858900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ham27Lju8X30G/Pi7G2NB/yVZZfjl/5xdSUO56dUsNk=;
  b=U0lXzm6wYsI3tNX7Q9jxYKMir8ujFDznBHjE0aiLLbWHr5DmAeQeFzBQ
   DIG/7/Kgg/bJpehZOJ8X0AqIGo8bWRydVndNF9ntFusbttYWNlEdxX9lb
   gzTM4KWBj1zUXbEPvnp1KRxBTlobxAKIjJ6gx3A1VmrKJkRRpXSZLwNdW
   nr0V8NSdl8eX9tGr7s8NgBcbVm9mmfLlEPBJv1N49vWWbjBBQYhLBELcC
   RQdCRr9SjwYbzLlcjiO+idctD1JRi+/UDeOt3G/1gS7Tbk7nU84eKBRia
   7fsfbl2KcztZRxpaUImaHopeBUaUBTiUtX1TyQxT1xou5vQQbUOrgk0cM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="4887758"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="4887758"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:21:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="38817515"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 08:21:37 -0800
Date: Wed, 7 Feb 2024 08:22:55 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, yangyicong@hisilicon.com
Subject: Re: [PATCH v4 2/4] sched/fair: remove unused parameters
Message-ID: <20240207162255.GB21939@ranerica-svr.sc.intel.com>
References: <20240207034704.935774-1-alexs@kernel.org>
 <20240207034704.935774-2-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207034704.935774-2-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Feb 07, 2024 at 11:47:02AM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>

A few nits:

subject: s/remove/Remove/

> 
> sds isn't used in function sched_asym(), so remove it to cleanup code.

The argument sds is not used in function sched_asym(). Remove it.

> 
> Fixes: c9ca07886aaa ("sched/fair: Do not even the number of busy CPUs via asym_packing")
> Signed-off-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

With that, my tag stands, FWIW.

