Return-Path: <linux-kernel+bounces-38496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BE483C0A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6E91F222FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3283D392;
	Thu, 25 Jan 2024 11:17:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A0D41742;
	Thu, 25 Jan 2024 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706181467; cv=none; b=UBKqLbbwndGAubcjzYO1CxsPO+5jKjqkam9lV+qoY6/u+DZBOeelE2r+3iipJRdZGpMY84o6IPSpERG4rN1BMtCUAotmqhxW7gq70VnT6vNUKSwu/eUaDYcAJZEUmk0xQ3aHOnCBm9lEQyg4XJswnUhW+YqqvdDR9XidzogdHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706181467; c=relaxed/simple;
	bh=igm/h/zmoLbXL5iWQEwPa7zebeNK6VDp4ngPTNMXweg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk6kbY7G+rV58AV0wE1z3LlhT3TRcVK0oW+gt6LIg0PHwej0AS6Kwlzn45IDjU3mzZ06blqS8LSK4eIjyW/PNDLYhbyzDk7EGxFrpFP0EctwX3HKyXifaTAJX7QMKYMqkMAKac7Zs4eXAj0o/Rjaz4lQvZHZbjATWoEN4ewMDXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DC181477;
	Thu, 25 Jan 2024 03:18:29 -0800 (PST)
Received: from bogus (unknown [10.57.78.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D7673F73F;
	Thu, 25 Jan 2024 03:17:41 -0800 (PST)
Date: Thu, 25 Jan 2024 11:17:38 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc: x86@kernel.org, Andreas Herrmann <aherrmann@suse.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Chen Yu <yu.c.chen@intel.com>, Len Brown <len.brown@intel.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Radu Rendec <rrendec@redhat.com>,
	Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen <puwen@hygon.cn>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Will Deacon <will@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Huang Ying <ying.huang@intel.com>,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] x86/cacheinfo: Set the number of leaves per CPU
Message-ID: <20240125111738.4otb55z2pj7ddtpk@bogus>
References: <20231212222519.12834-1-ricardo.neri-calderon@linux.intel.com>
 <20240125025652.GA15039@ranerica-svr.sc.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125025652.GA15039@ranerica-svr.sc.intel.com>

On Wed, Jan 24, 2024 at 06:56:52PM -0800, Ricardo Neri wrote:
> On Tue, Dec 12, 2023 at 02:25:15PM -0800, Ricardo Neri wrote:
> > Hi,
> > 
> > The interface /sys/devices/system/cpu/cpuX/cache is broken (not populated)
> > if CPUs have different numbers of subleaves in CPUID 4. This is the case
> > of Intel Meteor Lake.
> 
> Hello. Wondering if there is any feedback on this patchset. The interface
> /sys/devices/system/cpu/cpuX/cache is still broken on Meteor Lake with
> v6.8-rc1.
> 
> I verified that this patchset applies cleanly on v6.8-rc1.
> 

Sorry I though I had acked it but now I see 1/4 is new in v4. I have
responded on the original patch.

--
Regards,
Sudeep

