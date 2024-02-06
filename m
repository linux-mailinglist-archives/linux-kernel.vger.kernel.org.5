Return-Path: <linux-kernel+bounces-54225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E4A84AC88
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98DFEB23EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C680873160;
	Tue,  6 Feb 2024 02:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5vGTawF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899696E2BB;
	Tue,  6 Feb 2024 02:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707188144; cv=none; b=sAXeIAx7zo9N+hTkdH+FvwtNPvYsXtjLXpVbSGyojxxo4Uy2cBElKiqn6xELBEJop0FvDPEsvwgB/5vay2H6Eck0EkvDf1GymsrEQeSd/O+vGgc0sRL4NaXJCAY5/BQ5gQO+jY31B/fG+jkf0NxO0RyeWr85/7r4WbKhtox9no8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707188144; c=relaxed/simple;
	bh=7Aqk5ndLhvDUprO0Hw4S1pB5ktqjj/XziT32F4EOvF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bagr21Z2vXBRBFq9O5oOqePhN1bRBYGx18gnGPGOzMFQ4Kya1ptgKS7BvzT0NxgDzFQtMKt2BecG2gjhU3gdY0jGVN7SgomT8z9I5BUWU886dOkMJhZqyZSW+FE28gZJ3WcqttQN86cOTqwgsCE2TrQmafb+jVBMsx1BV+zGqFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5vGTawF; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707188143; x=1738724143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Aqk5ndLhvDUprO0Hw4S1pB5ktqjj/XziT32F4EOvF4=;
  b=R5vGTawFjd60fyLxGp6+z3J66SZvG5yoj1sKdtoc+vTxv6KZ2l58Jgia
   4q1EbUFAHWXKT/0Poov/m8tZu0i6KJU8bx6YuAUEcRZV38JZ8f7pqBGOc
   NESYpcXJC/sq0cTzmP+X+0P3JS1qC8j7TcMUroPhqA/Dy8jQ8VM/bEd2p
   MAidXzX4vhA9cWVD/dAlWBC0FWeYO5FF0TxV6IOLV93TsurbJwgtlQeq5
   qT1vCiyYo2e92YKh6EIHj0co8/5x5MBdqFKQ2h/F2at+4iAeKaWT0wmEy
   1pXe/4NhgT8zc7TI10mX4M8I69PJCRA0mDMdLQhGsSwjxU254AZHdrGox
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="26097981"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="26097981"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:55:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="31957401"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:55:40 -0800
Date: Mon, 5 Feb 2024 18:57:00 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 6/9] thermal: intel: hfi: Enable Intel Thread Director
Message-ID: <20240206025700.GE17602@ranerica-svr.sc.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-7-ricardo.neri-calderon@linux.intel.com>
 <ZcC4Xy9xBtBsCDLq@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcC4Xy9xBtBsCDLq@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, Feb 05, 2024 at 11:28:47AM +0100, Stanislaw Gruszka wrote:
> On Fri, Feb 02, 2024 at 08:05:12PM -0800, Ricardo Neri wrote:
> > Enable Intel Thread Director (ITD) from the CPU hotplug callback: globally
> > from CPU0 and then enable the thread-classification hardware in each
> > logical processor individually.
> > 
> > Also, initialize the number of classes supported.
> > 
> > Currently, a bare-metal machine does not use ITD, but KVM uses the
> > attributes of the bare-metal machine to virtualize HFI.
> > 
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> > Cc: Zhao Liu <zhao1.liu@linux.intel.com>
> > Cc: Zhuocheng Ding <zhuocheng.ding@intel.com>
> > Cc: x86@kernel.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> # intel_hfi.c
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Discussion:
> > 
> > This patch conflicts with a patchset from Stanislaw Gruszka to enable HFI
> > only if there are user space entities listening to the thermal netlink
> > events. ITD requires that HFI is enabled to function. ITD needs to be
> > unconditionally enabled for virtual machines.
> 
> Why unconditionally? From what I can tell from KVM patches (please correct
> me if I'm wrong) guests need to be modified to utilize HFI/ITD. Do we
> also have to enable HFI/ITD if no such guest run on virtual machine ?

You are correct. ITD needs to be enabled unconditionally iff we can't know
when a guest machine is running.

> 
> > Options to resolve this conflict include a command-line argument for users
> > wanting to virtualize HFI or a CONFIG_ option for the same effect. QEMU
> > could also learn to listen to thermal netlink event. A blunter option is
> > to unconditionally enable HFI when KVM is enabled at build time.
> 
> In general similar principle should be applied - do not enable if not
> needed. We should be able to get information from KVM when there is
> actual need.

Agreed, Zhao had suggested to enable/disable when virtual machines are
built/destroyed.

> QEMU registering to thermal events seems to be odd for
> me, and I think there must be better solution.

Right.

