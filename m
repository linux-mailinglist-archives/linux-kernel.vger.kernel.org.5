Return-Path: <linux-kernel+bounces-66082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A2585565E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90C41C21E75
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309692574B;
	Wed, 14 Feb 2024 22:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ctp8OSO5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6ED12E72
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707951263; cv=none; b=CRKigDsgFlpl+D43hxRG1fDKeitT18I0f22D74rRoGJzvi5gQF2jE+jY//GGiXVEhZs9th17EHN3/i61k9Xz9dDAXsVArGlbSLJLogcsXavfHyEq8FKXp7jjg9sTEGIOlBkoURRRoAadI05wyhJfJBBx47zdL+OJGgAdBKHA+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707951263; c=relaxed/simple;
	bh=IWhUg7d/C6jHVyCqMtt1pfAI113aqF/StezZi96q7+w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTxY/JLN6q3Kdxy4x6Gy3x+ku/MToCGYMzEb7DOLN1aYWRzgATz+pjlzlFTt/9LpX03SZ3oB4V14Heku2kKzmRDxfE2VHUDmSt15jvR1geH9RVE/hMhAQUiXhian86wIquVHM8/79P9W4JcvlcxxK9fKSXw5xJwXP3RnSkSbkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ctp8OSO5; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707951262; x=1739487262;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=IWhUg7d/C6jHVyCqMtt1pfAI113aqF/StezZi96q7+w=;
  b=Ctp8OSO5mwZHN83bIpfw5QUJpavtbsV/dDqAhiArqw2a1lmt1gTuJdTY
   GsqgpQ7K4U7EGOyNLMXvT62t7ot++zoKnJq81/Ys2215ADNRRGm2uWLr/
   3aww0pIxG1iss7C75qN8proGGsSD66QS9+ugAnCZfmBobcI+n4I3afGbL
   CYpzZsPNzdp10j75f0lk8SE+ESbJAMAZJDnL8bbqirKwQyemc6GcGSUeX
   tdooVT6bP985U0mh4o1k07Q/btA9F7XblMCxRLbzRXF3soMIY0RxTMeFO
   zaeicA6ECYrFJW7yXgWD0It8FJF8f/SceZU+MY1xXNLIv0n2gnkwURlRU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1895529"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1895529"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:54:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7966142"
Received: from wfaimone-mobl.amr.corp.intel.com (HELO [10.209.29.231]) ([10.209.29.231])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:54:20 -0800
Message-ID: <f495b4844ffd9ad4340051edf8744d9d5584747b.camel@linux.intel.com>
Subject: Re: [PATCH v3] mm: swap: async free swap slot cache entries
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chris Li <chriscli@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
  linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao
 <yuzhao@google.com>,  Greg Thelen <gthelen@google.com>, Chun-Tse Shao
 <ctshao@google.com>, Yosry Ahmed <yosryahmed@google.com>,  Michal Hocko
 <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Huang Ying
 <ying.huang@intel.com>,  Nhat Pham <nphamcs@gmail.com>, Kairui Song
 <kasong@tencent.com>, Barry Song <v-songbaohua@oppo.com>
Date: Wed, 14 Feb 2024 14:54:19 -0800
In-Reply-To: <CAF8kJuMXjp1A1kdS_x-S_dyst8MLHwjuAEt-SfGERKVYZNmRww@mail.gmail.com>
References: <20240213-async-free-v3-1-b89c3cc48384@kernel.org>
	 <c4ae18fb13ab1c63cdd34da9fe7b1e0f1a91c909.camel@linux.intel.com>
	 <CAF8kJuMXjp1A1kdS_x-S_dyst8MLHwjuAEt-SfGERKVYZNmRww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-14 at 10:56 -0800, Chris Li wrote:
> On Tue, Feb 13, 2024 at 4:08=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.=
com> wrote:
> >=20
> >=20
> > >=20
> > >  extern bool swap_slot_cache_enabled;
> > > +extern uint8_t slot_cache_async_free __read_mostly;
> >=20
> > Why wouldn't you enable the async_free always?
> > Otherwise the patch looks fine to me.
>=20
> Thanks for the feedback.
>=20
> Just in case someone doesn't care about this optimization and wants to
> opt out this behavior?
> Anyway, I am happy to update the patch without the sysfs control file as =
well.
>=20

At least I couldn't see a downside to enable it always in the latest
patch.  I think adding an extra sysfs is unnecessary.

Tim

