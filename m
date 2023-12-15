Return-Path: <linux-kernel+bounces-437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51871814122
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834BC1C22392
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 05:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823C8C8C4;
	Fri, 15 Dec 2023 05:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F21HQ4Ba"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CA846C;
	Fri, 15 Dec 2023 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702616704; x=1734152704;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=zVDTobLFJhMgqVsvxBgPsU6QiHyyeU7rAJxmclOn3CI=;
  b=F21HQ4BaQcYH3+7/Fryu98kelSJuwRLRI/KIDq6xa0SE+V2GUwoOg1A1
   gL/DXWVKPHwv8bkJLc7BUfGSP20cyOjyq8GbJj/LICBdleQlYQKy3U1NI
   WSBlZYkUbH1X9P2f271vHTRKqFDT5BMq1KbhXHOoL1zbbffq+855tl/zR
   W1F78eZTmNlpKcldF6k3rMuFr+HZ9F+s5qRfneqYUIOQOJOYkwU9UkWmU
   8rPXEgYxQfBdYNVbrLHEHj7cOE8Y5U3jSXx38Lm15Kmd9Qce/4KSGoYYE
   3458Zl4m8ei0UwW73orfhiV6oIYLQ9XmWBDiGX3gCuu7ICYna5S6HHAk9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2398142"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2398142"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:05:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803585229"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="803585229"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 21:04:59 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: <sthanneeru.opensrc@micron.com>
Cc: <linux-cxl@vger.kernel.org>,  <linux-mm@kvack.org>,
  <sthanneeru@micron.com>,  <aneesh.kumar@linux.ibm.com>,
  <dan.j.williams@intel.com>,  <gregory.price@memverge.com>,
  <mhocko@suse.com>,  <tj@kernel.org>,  <john@jagalactic.com>,
  <emirakhur@micron.com>,  <vtavarespetr@micron.com>,
  <Ravis.OpenSrc@micron.com>,  <Jonathan.Cameron@huawei.com>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/2] Node migration between memory tiers
In-Reply-To: <20231213175329.594-1-sthanneeru.opensrc@micron.com> (sthanneeru
	opensrc's message of "Wed, 13 Dec 2023 23:23:27 +0530")
References: <20231213175329.594-1-sthanneeru.opensrc@micron.com>
Date: Fri, 15 Dec 2023 13:02:59 +0800
Message-ID: <87cyv8qcqk.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<sthanneeru.opensrc@micron.com> writes:

> From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
>
> The memory tiers feature allows nodes with similar memory types
> or performance characteristics to be grouped together in a
> memory tier. However, there is currently no provision for
> moving a node from one tier to another on demand.
>
> This patch series aims to support node migration between tiers
> on demand by sysadmin/root user using the provided sysfs for
> node migration.
>
> To migrate a node to a tier, the corresponding node=E2=80=99s sysfs
> memtier_override is written with target tier id.
>
> Example: Move node2 to memory tier2 from its default tier(i.e 4)
>
> 1. To check current memtier of node2
> $cat  /sys/devices/system/node/node2/memtier_override
> memory_tier4
>
> 2. To migrate node2 to memory_tier2
> $echo 2 > /sys/devices/system/node/node2/memtier_override
> $cat  /sys/devices/system/node/node2/memtier_override
> memory_tier2
>
> Usecases:
>
> 1. Useful to move cxl nodes to the right tiers from userspace, when
>    the hardware fails to assign the tiers correctly based on
>    memorytypes.
>
>    On some platforms we have observed cxl memory being assigned to
>    the same tier as DDR memory. This is arguably a system firmware
>    bug, but it is true that tiers represent *ranges* of performance
>    and we believe it's important for the system operator to have
>    the ability to override bad firmware or OS decisions about tier
>    assignment as a fail-safe against potential bad outcomes.
>
> 2. Useful if we want interleave weights to be applied on memory tiers
>    instead of nodes.
> In a previous thread, Huang Ying <ying.huang@intel.com> thought
> this feature might be useful to overcome limitations of systems
> where nodes with different bandwidth characteristics are grouped
> in a single tier.
> https://lore.kernel.org/lkml/87a5rw1wu8.fsf@yhuang6-desk2.ccr.corp.intel.=
com/
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Version Notes:
>
> V2 : Changed interface to memtier_override from adistance_offset.
> memtier_override was recommended by
> 1. John Groves <john@jagalactic.com>
> 2. Ravi Shankar <ravis.opensrc@micron.com>
> 3. Brice Goglin <Brice.Goglin@inria.fr>

It appears that you ignored my comments for V1 as follows ...

https://lore.kernel.org/lkml/87o7f62vur.fsf@yhuang6-desk2.ccr.corp.intel.co=
m/
https://lore.kernel.org/lkml/87jzpt2ft5.fsf@yhuang6-desk2.ccr.corp.intel.co=
m/
https://lore.kernel.org/lkml/87a5qp2et0.fsf@yhuang6-desk2.ccr.corp.intel.co=
m/

--
Best Regards,
Huang, Ying

> V1 : Introduced adistance_offset sysfs.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Srinivasulu Thanneeru (2):
>   base/node: Add sysfs for memtier_override
>   memory tier: Support node migration between tiers
>
>  Documentation/ABI/stable/sysfs-devices-node |  7 ++
>  drivers/base/node.c                         | 47 ++++++++++++
>  include/linux/memory-tiers.h                | 11 +++
>  include/linux/node.h                        | 11 +++
>  mm/memory-tiers.c                           | 85 ++++++++++++---------
>  5 files changed, 125 insertions(+), 36 deletions(-)

