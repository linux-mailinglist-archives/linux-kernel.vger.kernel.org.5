Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7F25802E36
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjLDIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjLDIyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:54:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4185;
        Mon,  4 Dec 2023 00:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701680069; x=1733216069;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=ygCWSDYQlw1yVJhilY1MLD5z9RQ3sF3/7eRfaVIIdao=;
  b=Se5bFtNzb4IOP4peI7Q+FZnoBX+xAULFCoC91BH4QQlJKjYsJ9r8nUMM
   7Np0kNXTzVMbZc0v9oqIbcuOWxmCB8IWiu/m6sRPI9mc2Usx/ScMW+7Pf
   Q80ffc8rwEAlom3kl3oe0cN8+1H1WdJ3jO7Tu8A2DhATDuRaxay3wlPfx
   BT/QSnokL9VLymLgxDFRJrXzPhWewvYqEeu+eEV4p9JG7i7j2E6vKsxz7
   fdxdRg0k/n/OIrOWn1O9uhNMEfmOgtBhSfdziPk/ZSTlRzRCtUG4hGHtn
   j9tcnx/5w7wSdz53ByIPl5ynmlL4q5mNcnKkUy87Aw9o3WosatJ5oX+uj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="458025238"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="458025238"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 00:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="11894003"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 00:54:14 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     <sthanneeru.opensrc@micron.com>
Cc:     <aneesh.kumar@linux.ibm.com>, <hannes@cmpxchg.org>,
        <hasanalmaruf@fb.com>, <haowang3@fb.com>,
        <gregory.price@memverge.com>, <dan.j.williams@intel.com>,
        <mhocko@suse.com>, <tj@kernel.org>, <hezhongkun.hzk@bytedance.com>,
        <fvdl@google.com>, <john@jagalactic.com>, <mirakhur@micron.com>,
        <vtavarespetr@micron.com>, <Ravis.OpenSrc@micron.com>,
        <Jonathan.Cameron@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [RFC PATCH 0/2] Node migration between memory tiers
In-Reply-To: <20231130214858.1887-1-sthanneeru.opensrc@micron.com> (sthanneeru
        opensrc's message of "Fri, 1 Dec 2023 03:18:56 +0530")
References: <20231130214858.1887-1-sthanneeru.opensrc@micron.com>
Date:   Mon, 04 Dec 2023 16:52:12 +0800
Message-ID: <87o7f62vur.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> node migration. Each tier has a start abstract distance(adistance)
> and range.

We have discussed migrating nodes (in fact nodes of a memory type)
between tiers by sysadmin/root before.  The basic idea comes from
Johannes.  It is summarized in page 11 of [1],

[1] https://lpc.events/event/16/contributions/1209/attachments/1042/1995/Li=
ve%20In%20a%20World%20With%20Multiple%20Memory%20Types.pdf

The abstract distance of a memory type (e.g., GPU HBM) can be adjusted
via a sysfs knob (<memory_type>/abstract_distance_offset).

I still think that the memory type is better to be used to change
the abstract distance of nodes.  Do you agree?

--
Best Regards,
Huang, Ying

> To migrate a node to a tier, the corresponding node=E2=80=99s sysfs
> adistance_offset is written with a value corresponding to
> the tier=E2=80=99s adistance.
>
> Example: Move node2 to memory tier5 from its default tier(i.e 4)
>
> 1. Check default values:
> $cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
> 0-2
>
> $cat /sys/devices/system/node/node0/adistance_offset
> 0
> $cat /sys/devices/system/node/node1/adistance_offset
> 0
> $cat /sys/devices/system/node/node2/adistance_offset
> 0
>
> 2. Move node2 to  tier5:
>
> To move node2 from emory_tier4 (adistance=3D512) to
> emory_tier5 (abstract=3D640), set the `adistance_offset` of
> node 2 to 128 (i.e., 512 + 128 =3D 640).
>
> Tier4 adistance start can be derved from tier-id
> (i.e for tier4, 4 << 7 =3D 512).
>
> $echo 128 > /sys/devices/system/node/node2/adistance_offset
> $cat /sys/devices/system/node/node2/adistance_offset
> 128
>
> 3. Verify node2's tier id:
>
> $cat /sys/devices/virtual/memory_tiering/memory_tier5/nodelist
> 2
> $cat /sys/devices/virtual/memory_tiering/memory_tier4/nodelist
> 0-1
>
> Srinivasulu Thanneeru (2):
>   base/node: Add sysfs for adistance_offset
>   memory tier: Support node migration between tiers
>
>  drivers/base/node.c          | 51 +++++++++++++++++++++++
>  include/linux/memory-tiers.h | 11 +++++
>  include/linux/node.h         |  6 +++
>  mm/memory-tiers.c            | 79 ++++++++++++++++++++----------------
>  4 files changed, 113 insertions(+), 34 deletions(-)
