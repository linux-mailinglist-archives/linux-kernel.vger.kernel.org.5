Return-Path: <linux-kernel+bounces-68996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CAC858321
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31D02810AF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6141E130AF6;
	Fri, 16 Feb 2024 16:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d4aMkHzX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FA31E86B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708102631; cv=none; b=C/HepJ0/qRfJ1QmSwc+wchQR2eA9MjouipNwJ2denTNMm3zTDhjtUHUoHmNg3PFA+/aWcl3/AFeCZyNnB94O9eQeOnttY0O1JBycKIsXbf4rft6/StHiosyFxZlDlVREpLdQXNqV3r56dbpxPRCHGEgBKzXnXMvCgj6wvPPc0Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708102631; c=relaxed/simple;
	bh=Njb939Xj2TSbF8CTUoe/en9KsOGgfKVWdwwSZxqrTVQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JY4NLfGfPfZWzFrlAectwt1mOpKtPvARV4GKqPXVr9FBLNd58ozwPwo5EQ+QF7QNdhuX1ACS4DN0w7W+vjxW7rayOLMZd4LIHOr1OZm0+LzKP7G+/qR7ftaGOGqgauqGlVmsF+xnQ/BY8VUuaTLWlaK1ScT/aeZD1T5Npz7hKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d4aMkHzX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708102630; x=1739638630;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Njb939Xj2TSbF8CTUoe/en9KsOGgfKVWdwwSZxqrTVQ=;
  b=d4aMkHzXvYwe/5YYiNazQjDoXJzJizNdzLS/MCgF6Dt6/j0zqaT0rMMT
   +Vbpr71odfPL3Dtkz67j6RXh2CqBBbfoZtUBiNQsk9uJecsEoPsIqYrvs
   QVkESHCFFED2lfTxaWl9lG9qYjISX8AOj5PjH2n5eKsQsqrAuKg/MWqiX
   OQO6LoxhRN7tVo5FMmMC7ZyAKiDkxnq/h86w/2YOGiRs37eNklY+sVuGI
   t2Z0b26/UZasXBX3aMPKWEk4k35i2REtdFDdHTrMisfcuRi+poyOMU2Pr
   9t+cI6rg5o20MoPm7u4o5g4YhQDrsB/rs96jJ5wB4QumMmA9b/aLEHBen
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12780604"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="12780604"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 08:57:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4167575"
Received: from sbiswas-mobl1.amr.corp.intel.com (HELO [10.255.230.53]) ([10.255.230.53])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 08:57:08 -0800
Message-ID: <52d414b85f41a76fc0a7b0082cba95297d9e5874.camel@linux.intel.com>
Subject: Re: [PATCH v4] mm: swap: async free swap slot cache entries
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao
 <yuzhao@google.com>,  Greg Thelen <gthelen@google.com>, Chun-Tse Shao
 <ctshao@google.com>, Yosry Ahmed <yosryahmed@google.com>,  Michal Hocko
 <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Huang Ying
 <ying.huang@intel.com>,  Nhat Pham <nphamcs@gmail.com>, Kairui Song
 <kasong@tencent.com>, Barry Song <v-songbaohua@oppo.com>
Date: Fri, 16 Feb 2024 08:57:07 -0800
In-Reply-To: <20240215201627.5abd1841192feaa262d545ba@linux-foundation.org>
References: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org>
	 <20240215161114.6bd444ed839f778eefdf6e0a@linux-foundation.org>
	 <1b9a69d1ecaac45a228eb2993d5d9b8234a84155.camel@linux.intel.com>
	 <20240215201627.5abd1841192feaa262d545ba@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 20:16 -0800, Andrew Morton wrote:
> On Thu, 15 Feb 2024 17:38:38 -0800 Tim Chen <tim.c.chen@linux.intel.com> =
wrote:
>=20
> > > What this description lacks is any description of why anyone cares.=
=20
> > >=20
> > > The patch clearly decreases overall throughput (speed-vs-latency is a
> > > common tradeoff).
>=20
> This, please.
>=20
> > > And the "we don't know how to fix this properly so punt it into a
> > > kernel thread" approach remains lame.  For example, the risk that the
> > > now-liberated allocator can outpace the async freeing, resulting in
> > > unlimited object windup.
> >=20
> >=20
> > Andrew,
> >=20
> > What you are saying about outpacing asyn free is true for v1 and v2 ver=
sions of the patch.
> >=20
> > But in this latest version, if another reclaim comes in before the asyn=
c free has kicked in,
> > we would be freeing the whole cache directly, same as original code, wi=
thout waiting
> > for the async free.  It is different from the first version
> > where you go into the free one at a time mode while waiting for the asy=
nc free.=C2=A0
> > That was also my objection to the first two versions as you could be in=
 this
> > slow free one at a time mode for a long time.
> >=20
> > So now we should not have unlimited object windup.  And we would be doi=
ng free
> > in batch of 64, either still in the direct path or in the async path.
> >=20
>=20
> OK, thanks, I didn't read closely enough,
>=20
> > If the next swap fault comes in very fast, before the async
> > free gets a chance to run. It will directly free all the swap
> > cache in the swap fault the same way as previously.
>=20
> And might it be a win to cancel the async_work in this case?
>=20
Canceling async_work will matter for the case where we push swap hard,
and have a better chance of finding async have not yet engaged when
we need to free additional swap slots.

Chris' tests so far has been for his use cases where swap is lightly
loaded.  The scenarios you listed are when=C2=A0
we push swap hard close to its max throughput.=C2=A0

It would help answer your concerns if Chris could also test high swap scena=
rio.
Then we can make sure sustainable swap throughput does not regress and
latency is improved. And check whether it is beneficial to cancel outstandi=
ng async_work on
direct free path. I think the pro of canceling the asyn_work is to
skip an extra lock acquisition on the cache. Though
there is also some overhead in canceling the work itself.

Tim

>=20
> Again, without a clear description of the userspace-visible effects of
> this problem I am groping in the dark.  My hands blindly landed upon
> the question: the overall effect here is to leave worst-case latency
> unaltered, but to decrease average latency.  Does this satisfy the
> yet-to-be-described requirements?
>=20
>=20
> Also, the V4 patch's quoted quantitative testing results are pasted
> from the V2 patch's.  V2 was a fundamentally different implementation.=
=20
> I think it is fair to say that V4 is "untested", with regard to
> satisfying its runtime objectives.
>=20


