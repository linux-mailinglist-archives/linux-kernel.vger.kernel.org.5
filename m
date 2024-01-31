Return-Path: <linux-kernel+bounces-46459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2484400A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B399429515A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807CF7AE6E;
	Wed, 31 Jan 2024 13:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N9QLdKmY"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AB15A7A1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706385; cv=none; b=iGL/fKYuAEuYCxs1PzjEazMp6KQzcB10XBbFvz0M4cenaR0YP3tZ5FUUmQ1mUJvLJ1PSNY6o/045I7quFIvwSfbU0UB4GzzuINc6tQpxIOEWFsJptB3wU1XxqzLM8TsjqHHSCoU14l0XNdOti3YDBsjwKZNGd8oHYax1Q3UPjis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706385; c=relaxed/simple;
	bh=GEGBOsy/KDcNncxgnTgbSSkW226Obrv2mcjzoIzZO1s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/ClD+muc0P5YFjx94ikovyZVaOg0YElN3CbQ/tUad9FaO466R2xD+UdbgM2JBrIKq8WxAVj+9t9PuOPcDCe689mpIozu3xsy2Y0FMd6qLHFtuSPyh40NCnKkpkkNoaGCCUJZQ/bpIVNV7Zg+SewHE1ZppNXMclB/TSSI7zmyx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N9QLdKmY; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706706384; x=1738242384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GEGBOsy/KDcNncxgnTgbSSkW226Obrv2mcjzoIzZO1s=;
  b=N9QLdKmYuB2tvowGR0q10LWUom0mkMzTmII+qVaYpRb81Q8IJYru7XZK
   4pLfTNuHhQRz1gq/02BqGlhW7zbjUcDefyPMHvb2vjiELf2tKUYZqe+ng
   EYYZLJmNAcJA6f/Wn3brHj44MMeLuvC+d51jRE1PSmfDUKRxozTPP2GP5
   m24PP16CIkuX0IhAe5+V163AGU/7QNr9mALRuXnxQDDovi7mwvmaRWryL
   AWat4pNersXMasl7QcCrZ8JDwaChEN4AW1Gq9S7Q0ETsHxBXG6G7A7bF6
   T+b970zq/lOrE/SJm+poeF6Lu78hwzHHAt0gnkyGnbIjbb5L01nA9j0JW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403216493"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="403216493"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="931835998"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="931835998"
Received: from hmer-mobl.ger.corp.intel.com (HELO [10.251.217.183]) ([10.251.217.183])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 05:05:28 -0800
Message-ID: <b93ec9c2-23f5-486b-a3dc-ed9b960df359@linux.intel.com>
Date: Wed, 31 Jan 2024 14:05:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sysfs: Introduce a mechanism to hide static
 attribute_groups
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Sanyog Kale <sanyog.r.kale@intel.com>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <2024013028-deflator-flaring-ec62@gregkh>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <2024013028-deflator-flaring-ec62@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/30/24 19:46, Greg Kroah-Hartman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Add a mechanism for named attribute_groups to hide their directory at
> sysfs_update_group() time, or otherwise skip emitting the group
> directory when the group is first registered. It piggybacks on
> is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
> in the upper bits of the returned mode. To use it, specify a symbol
> prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
> to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:
> 
> 	DEFINE_SYSFS_GROUP_VISIBLE($prefix)
> 
> 	struct attribute_group $prefix_group = {
> 		.name = $name,
> 		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
> 	};
> 
> SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
> and $prefix_attr_visible(), where $prefix_group_visible() just returns
> true / false and $prefix_attr_visible() behaves as normal.
> 
> The motivation for this capability is to centralize PCI device
> authentication in the PCI core with a named sysfs group while keeping
> that group hidden for devices and platforms that do not meet the
> requirements. In a PCI topology, most devices will not support
> authentication, a small subset will support just PCI CMA (Component
> Measurement and Authentication), a smaller subset will support PCI CMA +
> PCIe IDE (Link Integrity and Encryption), and only next generation
> server hosts will start to include a platform TSM (TEE Security
> Manager).
> 
> Without this capability the alternatives are:
> 
> * Check if all attributes are invisible and if so, hide the directory.
>   Beyond trouble getting this to work [1], this is an ABI change for
>   scenarios if userspace happens to depend on group visibility absent any
>   attributes. I.e. this new capability avoids regression since it does
>   not retroactively apply to existing cases.
> 
> * Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
>   devices (i.e. for the case when TSM platform support is present, but
>   device support is absent). Unfortunate that this will be a vestigial
>   empty directory in the vast majority of cases.
> 
> * Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
>   in the PCI core. Bjorn has already indicated that he does not want to
>   see any growth of pci_sysfs_init() [2].
> 
> * Drop the named group and simulate a directory by prefixing all
>   TSM-related attributes with "tsm_". Unfortunate to not use the naming
>   capability of a sysfs group as intended.
> 
> In comparison, there is a small potential for regression if for some
> reason an @is_visible() callback had dependencies on how many times it
> was called. Additionally, it is no longer an error to update a group
> that does not have its directory already present, and it is no longer a
> WARN() to remove a group that was never visible.
> 
> Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
> Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This patch seems to introduce a regression on our Lunar Lake test
devices, where we can't boot to an ssh shell. No issues on older devices
[1]. Bard Liao and I reproduced the same results on different boards.

We'll need to find someone with direct device access to provide more
information on the problem, remote testing without ssh is a
self-negating proposition.

Is there a dependency on other patches? Our tests are still based on
6.7.0-rc3 due to other upstream issues we're currently working through.

[1] https://github.com/thesofproject/linux/pull/4799

