Return-Path: <linux-kernel+bounces-59753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7FC84FB48
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 058B8B23611
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A205F7EF17;
	Fri,  9 Feb 2024 17:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TblmMRHj"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34ADC73161
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 17:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707501167; cv=none; b=j3/mShZ7gxNwfFsQTZ2UkVxzlzvQ+zpFvu+DbD+CozsAoZ5hG17UsvoPO9VUfDZCdj+dH3t3anGOgBpM42odEn8aPqgOpwdW6XXvQqeiNTfJm7Rc0F2/cnB2Wh472L0B513p9gvYzYmJJdmIcSkfFhonRqDuekIf9nPEgTsjwR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707501167; c=relaxed/simple;
	bh=r9ptD/D9HY0EEOB5q1BgMMq6Q5nu3lZqkdrr6XOXEtM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sDaPip57JkvX2UQNaNogvxV4TNdE46flZIwqKbKIsNDE2a57VG21C3qS/1j5eU8+B0D+FmE6ygn1dP87Mppy7Nr3lD47TV0TkyuMkJHDynVLnHVVFHKBkNy9nk3AS5AxYbcuGDlp61JwxwOq+laIaYq5sJLCrEvO1vVehCYUErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TblmMRHj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707501166; x=1739037166;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=r9ptD/D9HY0EEOB5q1BgMMq6Q5nu3lZqkdrr6XOXEtM=;
  b=TblmMRHj8ys4E83aLcKqzdGJKPIgGW452Wvui72ocdhxpAVV9hp/jMzu
   IAWS3w7O+Ie1BGwvRdswKfn8ufSVEvGBp1Ab4yXbxJsCptlSSil15uBxd
   Yz5WhaBOt/c8e8yXwx959Qkv7NCE71RK/PsWOm2jBnC0WcAbv5C+qYWUQ
   fhpxmh1SaRmJLIJzm85Ntxl5ZScDdMiDdUYPsQ/KGLuMfESHywKAa3uy2
   N79H//b8EdPieO1EA5VZLJkuI1UTRDGOGfUdbV8SluHlnDp9kzl09HIPL
   +PsSWGjLHkTM4jje7fypnS15QIhNUCgPDGeX3KL19Oab+TGeKSbGOi083
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="4450972"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="4450972"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:52:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6746729"
Received: from mfahimal-mobl2.amr.corp.intel.com (HELO [10.212.132.151]) ([10.212.132.151])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 09:52:44 -0800
Message-ID: <4f1d0c0369e3b08cb0c8d2271396277df6e1d37e.camel@linux.intel.com>
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
Date: Fri, 09 Feb 2024 09:52:44 -0800
In-Reply-To: <CAF8kJuNC1D0sy90GoSt6yiA7T0Htsu_-gXsbTkmK5GAdO4udgA@mail.gmail.com>
References: <20240131-async-free-v2-1-525f03e07184@kernel.org>
	 <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com>
	 <7f19b4d69ff20efe8260a174c7866b4819532b1f.camel@linux.intel.com>
	 <CAF8kJuNvB8gXv3kj2nkN5j2ny0ZjJoVEdkeDDWSuWxySkKE=1g@mail.gmail.com>
	 <1fa1da19b0b929efec46bd02a6fc358fef1b9c42.camel@linux.intel.com>
	 <CAF8kJuMz+HCHkPUQhum32EPB7E1uVvN-E-TffOS7SSHxJNwNmQ@mail.gmail.com>
	 <a869aff64f69bd1e1318653559f4c32e9f0a4c08.camel@linux.intel.com>
	 <CAF8kJuNC1D0sy90GoSt6yiA7T0Htsu_-gXsbTkmK5GAdO4udgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-02-06 at 17:51 -0800, Chris Li wrote:
> On Tue, Feb 6, 2024 at 5:08=E2=80=AFPM Tim Chen <tim.c.chen@linux.intel.c=
om> wrote:
> >=20
> > On Mon, 2024-02-05 at 11:10 -0800, Chris Li wrote:
> > >=20
> > >=20
> > > In our system, a really heavy swap load is rare and it means somethin=
g
> > > is already wrong. At that point the app's SLO is likely at risk,
> > > regardless of long tail swap latency. It is already too late to
> > > address it at the swap fault end. We need to address the source of th=
e
> > > problem which is swapping out too much.
> > >=20
> > >=20
> >=20
> > Could some usage scenarios put more pressure on swap than your
> > usage scenario?  Say system with limited RAM and rely on zswap?
> >=20
> Of course. In that case what I proposed  to do will already doing what
> I think is the best of this situation. After grabbing the cache lock
> and finding out async fre hasn't started the freeing yet. Just free
> all 64 entries in the swap slot cache. It is similar to the old code
> behavior.
> Yes, it will have the long tail latency due to batch freeing 64 entries.
> My point is not that I don't care about heavy swap behavior.
> My point is that the app will suffer from the swap strom anyway, it is
> unavoidable. That will be the dominant factor shadowing the batch free
> optimization effect.

The original optimization introducing swap_slots target such heavy
swap use cases when we have fast swap backend to allow higher sustainable
swap throughput.  We should not ignore it.  And I am afraid your current
patch as is will hurt that performance.  If you change the direct free
path to free all entries, that could maintain the throughput and I'll
be okay with that.

>=20
> Or do I miss your point as you want to purpose the swap cache double
> buffer  so it can perform better under swap storm situations?
>=20

I am not actually proposing doubling the buffer as that proposal have
its own downside.=20

Tim


