Return-Path: <linux-kernel+bounces-69586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA232858BE3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5291928A251
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A233199DC;
	Sat, 17 Feb 2024 00:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErEZfRI/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D37011CAB
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129722; cv=none; b=LWRbC+RZNUSUyKrYp5l/rCfa7qSJK4qjvJsYriKbDetVad2S1JLmCEJAxSiDnXQJ9s4Ud2dB76OvZo0MmumdC5Azr7uCF+WbsBEr2GLjQ47PcAcF6JM/3asB7b1GrKuXEfb6cAoTc9o99Esz/+M+keYH4EpcG9kDg0AmFbRHAXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129722; c=relaxed/simple;
	bh=R40QHWBwT3Y9mpARpyccgf8Kq8e1WntO9rP9mLvye4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKGj5uC4+oiaukQanmf0PIrKxUtpw4j5N7sWIgSNkqma3nk1dBh21YLvL43ev1DrMvVLyrT9NsyTF45XuWZh5KVarD0bBU1en5V89Zq9xYomyRSS/kD9nuJYeg2CepdLZqsawqO/MVuBnlmgtWqsYwJYPZdzsr13V3P33b6wY6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErEZfRI/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708129720; x=1739665720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R40QHWBwT3Y9mpARpyccgf8Kq8e1WntO9rP9mLvye4k=;
  b=ErEZfRI/1bsOUui10sMRQEMJ0zQS9NaSROw+NoQqW2VlK7hd5iaTtCnB
   Sm4PJ+eFgRgJkFmBUKuSlfvku6PIb5gxBMkubAfvmyR+jVUh/9dL7t3Tw
   rkIpaG3Y5LSkcxrUF02MFAZmR3bCP9rJHHJWI2p5sqgGsl/0KSwx60Yzo
   Agh/QYSg6cg1Fu6IILB8nMDrcwdfNlA/FUypQCKqybyR6q9JviuE20sXl
   g4pscT/wAu84qvL75ijS0WWlGMTYMftGcBe6Dyvwl9j6A3IH9ziaYqnIU
   CcqIBERXfDeELhvsg/KYxIo4kW+6DSdKoXz9Nh4y012jZ5sDM3t56YCpr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="19696922"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="19696922"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 16:28:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="34771143"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 16:28:38 -0800
Date: Fri, 16 Feb 2024 16:28:36 -0800
From: Tony Luck <tony.luck@intel.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v9 00/24] x86/resctrl: monitored closid+rmid together,
 separate arch/fs locking
Message-ID: <Zc_9tPkfvqRkedrb@agluck-desk3>
References: <20240213184438.16675-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213184438.16675-1-james.morse@arm.com>

On Tue, Feb 13, 2024 at 06:44:14PM +0000, James Morse wrote:
> Hello!
> 
> It's been back and forth for whether this series should be rebased onto Tony's
> SNC series. This version isn't, its based on tip/x86/cache.
> (I have the rebased-and-tested versions if anyone needs them)

In case James' patches go first, I took a crack at basing my SNC series
on top of his patches (specifically the mpam/monitors_and_locking/v9
branch of git://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git).

Result is here:

git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux.git
Branch: james_then_snc

The end result of which ought to be pretty similar to the
"rebased-and-tested" versions that James mentions above.

-Tony

