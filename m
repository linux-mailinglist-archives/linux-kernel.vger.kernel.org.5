Return-Path: <linux-kernel+bounces-55778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D95D84C1AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A95DCB23A39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03307BE4D;
	Wed,  7 Feb 2024 01:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLu4yKjX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC1D8F55
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268084; cv=none; b=VSnsva3dj1gT1ajBAKRHzhYdrOMazJZuoq6FkMTLaRIg+r9Om1JPJ4LuTlE+Bh91dXPoq3tYbr2pa2zugIUHvKX4rzLibpHXgSZsq0424GqaiuSEKl+4NIIOrX2NLtsuE92GKFinT/GDf14/EE5ndJb0B8lNlrVAyvwhfBguaYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268084; c=relaxed/simple;
	bh=YWoqPUFfMGS47WFb4mE5+cl1K2/d2tJFTG4u0nDPs6Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b0ezG1wkmYSHDkGtWN1HFPxgJN3LF090HJr514uAuF86TX9m1l3x4Qqa2EWFGva2s2720PBygwEcMHfaOIvzaJgq9/wnHH7z4EK4vxB7XVUT0xvnmNtEf4iRFV3eJXaXxFICLNmAP6ivxTNnw7XpT8jXosB1lmFc5RZQaqNCAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLu4yKjX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707268081; x=1738804081;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YWoqPUFfMGS47WFb4mE5+cl1K2/d2tJFTG4u0nDPs6Q=;
  b=ZLu4yKjX/hUYIj8V3mtDyYSM25s0Jl2r3BHa3XEyE/aYphjXjafVxsBc
   jTktXKxwoqu2t1e8uBu83CaiHTMdpa7RyRhb2h26O92JbWFV8E41wN1s+
   e/J2b/XNtXSPl1hTWp/Q2P+5YPzPY/OTvjAyOsCKTRPM4JAB9z2ZK6Mo5
   agVGlzLxZtZyhAchQK6n7rfKUA71YAYJCYviIlKZLf2sisxJZ4IYfTJKG
   xeTCODAxlKbVOS8fTA2ArFWP65vlVdx8kdZgnFohE9ZT02hhs0wTYr/ky
   fGzCMwSzRyKoQP0O6lgyOr70BSzUNNlPnrE9Dji+7zgT014+9mNaL5HQp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="26326489"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="26326489"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 17:08:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="32260071"
Received: from rmahambr-mobl.amr.corp.intel.com (HELO [10.209.58.248]) ([10.209.58.248])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 17:08:00 -0800
Message-ID: <a869aff64f69bd1e1318653559f4c32e9f0a4c08.camel@linux.intel.com>
Subject: Re: [PATCH v2] mm: swap: async free swap slot cache entries
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,  Wei =?UTF-8?Q?Xu=EF=BF=BC?= <weixugc@google.com>, Yu
 =?UTF-8?Q?Zhao=EF=BF=BC?= <yuzhao@google.com>, Greg Thelen
 <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, Suren
 =?UTF-8?Q?Baghdasaryan=EF=BF=BC?= <surenb@google.com>, Yosry
 =?UTF-8?Q?Ahmed=EF=BF=BC?= <yosryahmed@google.com>,  Brain Geffon
 <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko
 <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Nhat Pham
 <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song
 <kasong@tencent.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng
 Shi <shikemeng@huaweicloud.com>,  Barry Song <v-songbaohua@oppo.com>
Date: Tue, 06 Feb 2024 17:08:00 -0800
In-Reply-To: <CAF8kJuMz+HCHkPUQhum32EPB7E1uVvN-E-TffOS7SSHxJNwNmQ@mail.gmail.com>
References: <20240131-async-free-v2-1-525f03e07184@kernel.org>
	 <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com>
	 <7f19b4d69ff20efe8260a174c7866b4819532b1f.camel@linux.intel.com>
	 <CAF8kJuNvB8gXv3kj2nkN5j2ny0ZjJoVEdkeDDWSuWxySkKE=1g@mail.gmail.com>
	 <1fa1da19b0b929efec46bd02a6fc358fef1b9c42.camel@linux.intel.com>
	 <CAF8kJuMz+HCHkPUQhum32EPB7E1uVvN-E-TffOS7SSHxJNwNmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-05 at 11:10 -0800, Chris Li wrote:
>=20
>=20
> In our system, a really heavy swap load is rare and it means something
> is already wrong. At that point the app's SLO is likely at risk,
> regardless of long tail swap latency. It is already too late to
> address it at the swap fault end. We need to address the source of the
> problem which is swapping out too much.
>=20
>=20

Could some usage scenarios put more pressure on swap than your
usage scenario?  Say system with limited RAM and rely on zswap?

Tim

