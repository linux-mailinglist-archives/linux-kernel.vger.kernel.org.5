Return-Path: <linux-kernel+bounces-46807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D05484448F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A027F1F2D6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EF412C53D;
	Wed, 31 Jan 2024 16:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GL+2WMA3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0212C52C
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706718655; cv=none; b=AZGbmP5emsCiQ7lJJYYL35sbhrA6DhGBnfgAEYbRSLaOYPp+P0GoiDIBriT7U49DFtfBJE4Puq1v1IiNPEHrmq/vcj/oODOh1iOij7Nh9AMw1kD3NPdbyzgbE6y/rT+BFzBneib1PvUjPsYNOk3yky38Mujp13x1FTsbyIDZ4LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706718655; c=relaxed/simple;
	bh=EK6mQSU0rXidzQqllRwP/i4twW+fkBaD850m2dD4R6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUKSz8KMZy2a4inl+FjQ1pU8qUDOJe7Qw1T9JdBqgSHX0Oa+X64VYQMeZUH/NEKJN8gsY6yv1b3ddZ+PRM6sZVqnR3nQYGEIhplIr34tDyPG+Gm5+mzCeNRNIhqNhmqrGE124xAYV4iqC4srmoCUMYWX6n7/Zm5ZMj5uzp4PglI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GL+2WMA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64931C43399;
	Wed, 31 Jan 2024 16:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706718654;
	bh=EK6mQSU0rXidzQqllRwP/i4twW+fkBaD850m2dD4R6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GL+2WMA36zNaEzVS4UtwxtwU87UtEAZBZuoua1+MclmG0EvDU5inUx5xPgWlQhCx+
	 tKugeGg8DdA7+H8g4Mepz8bunlb4c0wF/Pr0qr4f3jJkorpgNAn6azaNsOIaOJ6UPE
	 LIF4d4pVZs/ptNasV6jTOPtZAMkLI0nblUby8KQA=
Date: Wed, 31 Jan 2024 08:30:53 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
	Dan Williams <dan.j.williams@intel.com>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>
Subject: Re: [PATCH 1/6] sysfs: Introduce a mechanism to hide static
 attribute_groups
Message-ID: <2024013139-thermal-eaten-f179@gregkh>
References: <2024013025-spoiling-exact-ad20@gregkh>
 <2024013028-deflator-flaring-ec62@gregkh>
 <b93ec9c2-23f5-486b-a3dc-ed9b960df359@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b93ec9c2-23f5-486b-a3dc-ed9b960df359@linux.intel.com>

On Wed, Jan 31, 2024 at 02:05:04PM +0100, Pierre-Louis Bossart wrote:
> 
> 
> On 1/30/24 19:46, Greg Kroah-Hartman wrote:
> > From: Dan Williams <dan.j.williams@intel.com>
> > 
> > Add a mechanism for named attribute_groups to hide their directory at
> > sysfs_update_group() time, or otherwise skip emitting the group
> > directory when the group is first registered. It piggybacks on
> > is_visible() in a similar manner as SYSFS_PREALLOC, i.e. special flags
> > in the upper bits of the returned mode. To use it, specify a symbol
> > prefix to DEFINE_SYSFS_GROUP_VISIBLE(), and then pass that same prefix
> > to SYSFS_GROUP_VISIBLE() when assigning the @is_visible() callback:
> > 
> > 	DEFINE_SYSFS_GROUP_VISIBLE($prefix)
> > 
> > 	struct attribute_group $prefix_group = {
> > 		.name = $name,
> > 		.is_visible = SYSFS_GROUP_VISIBLE($prefix),
> > 	};
> > 
> > SYSFS_GROUP_VISIBLE() expects a definition of $prefix_group_visible()
> > and $prefix_attr_visible(), where $prefix_group_visible() just returns
> > true / false and $prefix_attr_visible() behaves as normal.
> > 
> > The motivation for this capability is to centralize PCI device
> > authentication in the PCI core with a named sysfs group while keeping
> > that group hidden for devices and platforms that do not meet the
> > requirements. In a PCI topology, most devices will not support
> > authentication, a small subset will support just PCI CMA (Component
> > Measurement and Authentication), a smaller subset will support PCI CMA +
> > PCIe IDE (Link Integrity and Encryption), and only next generation
> > server hosts will start to include a platform TSM (TEE Security
> > Manager).
> > 
> > Without this capability the alternatives are:
> > 
> > * Check if all attributes are invisible and if so, hide the directory.
> >   Beyond trouble getting this to work [1], this is an ABI change for
> >   scenarios if userspace happens to depend on group visibility absent any
> >   attributes. I.e. this new capability avoids regression since it does
> >   not retroactively apply to existing cases.
> > 
> > * Publish an empty /sys/bus/pci/devices/$pdev/tsm/ directory for all PCI
> >   devices (i.e. for the case when TSM platform support is present, but
> >   device support is absent). Unfortunate that this will be a vestigial
> >   empty directory in the vast majority of cases.
> > 
> > * Reintroduce usage of runtime calls to sysfs_{create,remove}_group()
> >   in the PCI core. Bjorn has already indicated that he does not want to
> >   see any growth of pci_sysfs_init() [2].
> > 
> > * Drop the named group and simulate a directory by prefixing all
> >   TSM-related attributes with "tsm_". Unfortunate to not use the naming
> >   capability of a sysfs group as intended.
> > 
> > In comparison, there is a small potential for regression if for some
> > reason an @is_visible() callback had dependencies on how many times it
> > was called. Additionally, it is no longer an error to update a group
> > that does not have its directory already present, and it is no longer a
> > WARN() to remove a group that was never visible.
> > 
> > Link: https://lore.kernel.org/all/2024012321-envious-procedure-4a58@gregkh/ [1]
> > Link: https://lore.kernel.org/linux-pci/20231019200110.GA1410324@bhelgaas/ [2]
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> This patch seems to introduce a regression on our Lunar Lake test
> devices, where we can't boot to an ssh shell. No issues on older devices
> [1]. Bard Liao and I reproduced the same results on different boards.
> 
> We'll need to find someone with direct device access to provide more
> information on the problem, remote testing without ssh is a
> self-negating proposition.
> 
> Is there a dependency on other patches? Our tests are still based on
> 6.7.0-rc3 due to other upstream issues we're currently working through.

This should be totally stand-alone and not cause any problems,
especially if you don't have any other patches applied.

I did make this against 6.8-rc2, perhaps that's the issue?

thanks,

greg k-h

