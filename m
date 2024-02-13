Return-Path: <linux-kernel+bounces-63154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98544852BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:50:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5436C285D32
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E80F1B598;
	Tue, 13 Feb 2024 08:50:00 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAFE20DF8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814200; cv=none; b=tocfaWKA48JIVLa4pKbeB1pDlBR+8mnKRLeeD2XP3/wd5xl1hLQvK4mWpyNftJlSVFBEr9hZvF807Stwyxc9pwaKOaGP6KBngAj15/k6hJwuvOk6zoeXq7cGbamiQ+MiBuRWiHtCyhWSKRFXrzUtw16JEvijSreAkwq9pMlYz9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814200; c=relaxed/simple;
	bh=sadaPCdmwkHHMrHeq/JKhLMCFklg7Qow7J7JVWooHss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoZUzNA4gHCpoRGO5E/9ZkJsHaxhx8+HNsDRwWNUgETeRAZ3y95etp0290Z1seHgrHLOOCl053eYB1rK59ddA5SflP14OfQXpDm0df+hD7d545RvISjkKnK1bckzXSV9KXFEx+LnGiQMfJdNpo/frf/WzTRnK21TMzI5uALz8NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 68DFEDA7;
	Tue, 13 Feb 2024 00:50:36 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943EA3F5A1;
	Tue, 13 Feb 2024 00:49:53 -0800 (PST)
Date: Tue, 13 Feb 2024 08:49:51 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	sudeep.holla@arm.com, vincent.guittot@linaro.org,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	quic_nkela@quicinc.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH 06/11] firmware: arm_scmi: Implement Clock
 .is_notify_supported callback
Message-ID: <ZcstL8tRVKIUFoBr@pluto>
References: <20240212123233.1230090-7-cristian.marussi@arm.com>
 <202402131047.2NVZWHma-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402131047.2NVZWHma-lkp@intel.com>

On Tue, Feb 13, 2024 at 10:58:23AM +0800, kernel test robot wrote:
> Hi Cristian,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on soc/for-next]
> [also build test ERROR on linus/master v6.8-rc4 next-20240212]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 

Hi,

this series, as stated in the cover-letter, is based off the current tip of

	sudeep/for-next/scmi/updates

and particularly needs commit:

	9c5bc650031e firmware: arm_scmi: Rework clock domain info lookups

from there, since it contains the missing scmi_clock_domain_lookup().

Not_sure/dont_known if there is any way to convey this "based-on-branch"
info to your/any CI at the moment.

Thanks,
Cristian

> url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/firmware-arm_scmi-Check-for-notification-support/20240212-203727
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
> patch link:    https://lore.kernel.org/r/20240212123233.1230090-7-cristian.marussi%40arm.com
> patch subject: [PATCH 06/11] firmware: arm_scmi: Implement Clock .is_notify_supported callback
> config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20240213/202402131047.2NVZWHma-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project c08b90c50bcac9f3f563c79491c8dbcbe7c3b574)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402131047.2NVZWHma-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402131047.2NVZWHma-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/firmware/arm_scmi/clock.c:853:8: error: call to undeclared function 'scmi_clock_domain_lookup'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>      853 |         clk = scmi_clock_domain_lookup(ci, src_id);
>          |               ^
> >> drivers/firmware/arm_scmi/clock.c:853:6: error: incompatible integer to pointer conversion assigning to 'struct scmi_clock_info *' from 'int' [-Wint-conversion]
>      853 |         clk = scmi_clock_domain_lookup(ci, src_id);
>          |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    2 errors generated.
> 
> 
> vim +/scmi_clock_domain_lookup +853 drivers/firmware/arm_scmi/clock.c
> 
>    842	
>    843	static bool scmi_clk_notify_supported(const struct scmi_protocol_handle *ph,
>    844					      u8 evt_id, u32 src_id)
>    845	{
>    846		bool supported;
>    847		struct scmi_clock_info *clk;
>    848		struct clock_info *ci = ph->get_priv(ph);
>    849	
>    850		if (evt_id >= ARRAY_SIZE(evt_2_cmd))
>    851			return false;
>    852	
>  > 853		clk = scmi_clock_domain_lookup(ci, src_id);
>    854		if (IS_ERR(clk))
>    855			return false;
>    856	
>    857		if (evt_id == SCMI_EVENT_CLOCK_RATE_CHANGED)
>    858			supported = clk->rate_changed_notifications;
>    859		else
>    860			supported = clk->rate_change_requested_notifications;
>    861	
>    862		return supported;
>    863	}
>    864	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

