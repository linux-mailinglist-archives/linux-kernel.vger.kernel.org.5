Return-Path: <linux-kernel+bounces-68049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8494085754F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6F9285F88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFB1AADB;
	Fri, 16 Feb 2024 04:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JMf7oFB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1DC1AAA5
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 04:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708056988; cv=none; b=L2G78DQMnixjdmpGU1O8+u7e5YUBzqITxLOjxewam62lWxn8m9KC5vgeHcFZJXiwKy7BVv6q7b+4D7VuSwKIFvvErcZ7brTr+EPGjlTK488ADPZOzcKOFZBilLJDGFrkgQTqiEZRkiAfNjdbzli9oaLNjhyjyacCcAP3Hr0WuH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708056988; c=relaxed/simple;
	bh=sUxXigIboc9iP68W8TP9S/5UxJ1R1MlA21rkHc06KEQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WlU9bFClOlfRmmR6XCv8agDPcx1CGJhwcsVSrJhZD+Pdi92eL5MTarsTvSJh6g0gkKLb3TwrK8ZUWmoPL1+q7y1cKppp04gnwFdpNk6nQBA7hq6WfDruw3G1HdUoevm0N6H3Ag4JRAXyHT9N9sJIXuGJ4Z+px05XhQlAztWyxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JMf7oFB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EA5C433F1;
	Fri, 16 Feb 2024 04:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708056988;
	bh=sUxXigIboc9iP68W8TP9S/5UxJ1R1MlA21rkHc06KEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JMf7oFB/ecGdP2c3QkPhYjjbePLbikrAt7dmWv8nrdDMNsNFliGc9DEjRK57jB38B
	 68YjhDSAUnWKltkJC42+AlGd7wJp6GL21Uiqh0ZYDWJG04sm6wS1WkrEqQBEbWXnQF
	 11GlZf75R65UA9wZGC0DHB7ZjbQKDqkAjfHESTw0=
Date: Thu, 15 Feb 2024 20:16:27 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: Chris Li <chrisl@kernel.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Wei Xu <weixugc@google.com>, Yu Zhao
 <yuzhao@google.com>, Greg Thelen <gthelen@google.com>, Chun-Tse Shao
 <ctshao@google.com>, Yosry Ahmed <yosryahmed@google.com>, Michal Hocko
 <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Huang Ying
 <ying.huang@intel.com>, Nhat Pham <nphamcs@gmail.com>, Kairui Song
 <kasong@tencent.com>, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v4] mm: swap: async free swap slot cache entries
Message-Id: <20240215201627.5abd1841192feaa262d545ba@linux-foundation.org>
In-Reply-To: <1b9a69d1ecaac45a228eb2993d5d9b8234a84155.camel@linux.intel.com>
References: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org>
	<20240215161114.6bd444ed839f778eefdf6e0a@linux-foundation.org>
	<1b9a69d1ecaac45a228eb2993d5d9b8234a84155.camel@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Feb 2024 17:38:38 -0800 Tim Chen <tim.c.chen@linux.intel.com> wr=
ote:

> > What this description lacks is any description of why anyone cares.=20
> >=20
> > The patch clearly decreases overall throughput (speed-vs-latency is a
> > common tradeoff).

This, please.

> > And the "we don't know how to fix this properly so punt it into a
> > kernel thread" approach remains lame.  For example, the risk that the
> > now-liberated allocator can outpace the async freeing, resulting in
> > unlimited object windup.
>=20
>=20
> Andrew,
>=20
> What you are saying about outpacing asyn free is true for v1 and v2 versi=
ons of the patch.
>=20
> But in this latest version, if another reclaim comes in before the async =
free has kicked in,
> we would be freeing the whole cache directly, same as original code, with=
out waiting
> for the async free.  It is different from the first version
> where you go into the free one at a time mode while waiting for the async=
 free.=A0
> That was also my objection to the first two versions as you could be in t=
his
> slow free one at a time mode for a long time.
>=20
> So now we should not have unlimited object windup.  And we would be doing=
 free
> in batch of 64, either still in the direct path or in the async path.
>=20

OK, thanks, I didn't read closely enough,

> If the next swap fault comes in very fast, before the async
> free gets a chance to run. It will directly free all the swap
> cache in the swap fault the same way as previously.

And might it be a win to cancel the async_work in this case?


Again, without a clear description of the userspace-visible effects of
this problem I am groping in the dark.  My hands blindly landed upon
the question: the overall effect here is to leave worst-case latency
unaltered, but to decrease average latency.  Does this satisfy the
yet-to-be-described requirements?


Also, the V4 patch's quoted quantitative testing results are pasted
from the V2 patch's.  V2 was a fundamentally different implementation.=20
I think it is fair to say that V4 is "untested", with regard to
satisfying its runtime objectives.

