Return-Path: <linux-kernel+bounces-47457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC9844E37
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E22E9B23CB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A7B7139F;
	Thu,  1 Feb 2024 00:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RBQyejXR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7118520E4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 00:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706748867; cv=none; b=Lxf5WTUs3XYtSZLNpR4j2m2igW5KCHT3qk28HbOhaEaI6zYmqqK7yiFMl6YS6rSmEt4lsvijEnEdStvTuvRIsIHKIfO4cxmRfDjoJfPX0YiakKuTAR56cNS4elYMAcYNNcTXlTS1mZWMBIO4N1B5132s3jcIhVR/A99037CCi+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706748867; c=relaxed/simple;
	bh=WD9xP9ReK2ODSh2oUCEK3pkqVJKN8VD1M+3RBj4SGXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4eptMfAluhqC9UWCGdrizEbt8cRjCugHyGJ0D6rnoZzk1qRb4nO4b6mHOcSOWbeFAWGvw1NL5CeyN2N9tHXK0OmQPl/0TuskRV7lEcGaX2KA35fG4hWvr4bUay+yJhc03RFkbQYCBmFEaPl2GzOY2epI7LdgT0AWc0iAbc4tC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RBQyejXR; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706748867; x=1738284867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WD9xP9ReK2ODSh2oUCEK3pkqVJKN8VD1M+3RBj4SGXI=;
  b=RBQyejXRV77jeplLTGFzzGyMzpCd6e0kxNDgwwi+pDmruH+fB+/vTtW3
   1XSqm9YORV3JyJSn7/8/pUhs4IzNu9EC2HMjtRJ9pBtlRuJ5uNqQPvo14
   WopSx+3Ls5kyRLa9Q1H11rriLOgkfYoGXwEbyTYrj12udPm0kCYLjyY13
   FGrByMhxP0uSgRHKDcZxorSFY8EQbvNQR2YGC9UhiC6VLhrwcPePOJiaP
   LgWIrkTY2CfV6mBeaPR+7GKE5/VKDiJq6KrMrt8A8dTr2T5nWbDEkQcBk
   cyyC4rcB6fepU8ZHh5v65Zdv5W3L5rlBgikDk8FuI08aMAFXlmhO1xnRY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22274084"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="22274084"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:54:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="858988502"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="858988502"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 16:54:24 -0800
Date: Wed, 31 Jan 2024 16:55:47 -0800
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
	linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
Subject: Re: [PATCH v2 5/6] sched/fair: pack SD_ASYM_PACKING into
 sched_use_asym_prio
Message-ID: <20240201005547.GC18560@ranerica-svr.sc.intel.com>
References: <20240130131708.429425-1-alexs@kernel.org>
 <20240130131708.429425-5-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130131708.429425-5-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jan 30, 2024 at 09:17:07PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
pack SD_ASYM_PACKING into sched_use_asym_prio

Instead of saying `pack` you could say "Check the SD_ASYM_PACKING flag
in sched_use_asym_prio()"

> 
> Then the flags check passed into sched_asym and sched_group_asym.
> It's a code cleanup, no func changes.

I'd the changelog as follows:

"sched_use_asym_prio() checks whether CPU priorities should be used. It
makes sense to check for the SD_ASYM_PACKING() inside the function.
Since both sched_asym() and sched_group_asym() use sched_use_asym_prio(),
remove the now superfluous checks for the flag in various places"

