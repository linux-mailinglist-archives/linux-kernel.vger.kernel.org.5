Return-Path: <linux-kernel+bounces-58955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BD184EF22
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 03:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A21F25A6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 02:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00F5D4C6D;
	Fri,  9 Feb 2024 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IIBWUBrS"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA164A24
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 02:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707447573; cv=none; b=IZPaQy9v2Kmk5rqTaUcfrPw4kN9/cINtc09cKwgOpnJF3OJrlSnqnCUOazIEmYMWw52Yds3a1Zlyec7NYSAocP+0wqYpfZz2OC9b2rjogwH+jNmNenlR42OlnsRIQwy907BEXfzvtqlhHrwJQIb7/q/2vHnAm5omdefqMbSHu/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707447573; c=relaxed/simple;
	bh=PTVvWQ7Ht9Slv9xMxIk/jSv15ZL89NIpuRtDUZ3FhUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Muo8sWvN/F7d5VMiPQpIGkV/h33v/5bc01pcy78GmRdsCXUXUmOr9ZMGntIOEqJ1bY1ZLWNIenPz12ztm9XX+lc93Xqw95sCjRnQ3KSLa0WkBZ/AMB8gvtKUjpsuWG3lrCSerfbc0fgUNkNHPVk2AT1Zlh+52VAZIhjsDc+3ypI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IIBWUBrS; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707447571; x=1738983571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PTVvWQ7Ht9Slv9xMxIk/jSv15ZL89NIpuRtDUZ3FhUw=;
  b=IIBWUBrSfnUVOibYP6rMdrgKMmUvNXGHwydOWDdbKY+sTS/+0nMJiUtB
   EXa0tGgtDlX7X9IOBJLnC2OO7FaxHJFJMBShSML5Vv0RzVTE8MvXWuIb1
   ezAT1c7li/x9d4vP4oBlVoCbSV+56Agpiuetjm11duDc5ARbPyAcMaU53
   MWM+LLSKVXD30O7JmhuHhihnOQ6ppSA8LHsmwG/xFg+jeCSx11pZWT9hg
   IwDCpKjLTPt9tus86qImCYGV2cd0SCzzimUJOfkmKLZDOv3xUA8bdakqH
   iV24pJRjkNoB5Ch54+9WqM0fcjSUi94QvrBY3Il89BSv6iT1Zm8+hjY5N
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="395787011"
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="395787011"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:59:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,255,1701158400"; 
   d="scan'208";a="6460503"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 18:59:28 -0800
Date: Thu, 8 Feb 2024 19:00:46 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Barry Song <song.bao.hua@hisilicon.com>,
	Miaohe Lin <linmiaohe@huawei.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v4 5/5] sched: rename SD_SHARE_PKG_RESOURCES to
 SD_SHARE_LLC
Message-ID: <20240209030046.GB10494@ranerica-svr.sc.intel.com>
References: <20240207034704.935774-4-alexs@kernel.org>
 <20240207035840.936676-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207035840.936676-1-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Wed, Feb 07, 2024 at 11:58:40AM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> SD_CLUSTER shares the CPU resources like llc tags or l2 cache, that's
> easy confuse with SD_SHARE_PKG_RESOURCES. So let's specifical point
> what the latter shares: LLC. That would reduce some confusing.
> 
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>

FWIW, Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>

