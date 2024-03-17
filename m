Return-Path: <linux-kernel+bounces-105512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812BB87DF8D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E47B20D1C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2861DFF9;
	Sun, 17 Mar 2024 19:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pe62biVs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9451DDD1;
	Sun, 17 Mar 2024 19:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702841; cv=none; b=tYActW4byavpcQh6GhQFtTjss4CuGMVBrhBc26VSACfJEUPjAKdfebbi7WN8bFJSbtDpSv1dE5RKvhdBqd7ndhi6V+4kvg3ANCvUHEusJeqRKr0Uz1EtT3UBYzGLJWD0tdRBn54Xiu0KE+V6QTeCJiQQPsxA6uSamHUiqkopLPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702841; c=relaxed/simple;
	bh=qY5H5aIaYNBa2SChjq9AE3ktByIG3xpixgbmma9+RHc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EWa/Oa3Uru1b7TAFul5m+9IKtd2011ms/6icD3/T5u3sG/hOsrdZxt/TW3wEzURKO1PKpS4HmLBqX1Kuj/5L7xhLn48JzzO/JZ0D9QlqU7AgeB34cKbpIA/aVyKMfyAg/nyJJ9nCmqqoX4u4ch4FLsiv1XHLbrDHK576WIIZSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pe62biVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5440CC433C7;
	Sun, 17 Mar 2024 19:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710702841;
	bh=qY5H5aIaYNBa2SChjq9AE3ktByIG3xpixgbmma9+RHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pe62biVsZkBTkvbUQpee9lM3WG3P0ngQ0Top+3fv4wE3pY1WJI5kDpORwcJ8NVgj5
	 sZW4TanLoLCgUjP5yDwFkKmZYE6Q519CiGmPlNdT0sBTVN6mzw15bFxcztd2mivRj8
	 VxHDDBh7x2Zzd/raY+tTJiNQo2EZGM1msOsZEqONHSuLawsqTtLZuByX6mSRHQ4HgK
	 9JsI+GNewoGU1DVf0Yp6usbuRr32YMrATBfCdfdhWaLaioUBGVgGwe4pUpD1nVr4BC
	 u1381u/qat4xU37yJfbORWJwO2x4A0Vvc5MQlKfXZYGlMk3lUOv0T6lEQWpiSsNeaR
	 RIQq4W5TNFtTw==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Honggyu Kim <honggyu.kim@sk.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	apopple@nvidia.com,
	baolin.wang@linux.alibaba.com,
	dave.jiang@intel.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	linmiaohe@huawei.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rakie.kim@sk.com,
	rostedt@goodmis.org,
	surenb@google.com,
	yangx.jy@fujitsu.com,
	ying.huang@intel.com,
	ziy@nvidia.com,
	42.hyeyoo@gmail.com
Subject: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Sun, 17 Mar 2024 12:13:57 -0700
Message-Id: <20240317191358.97578-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240317153144.11931-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 17 Mar 2024 08:31:44 -0700 SeongJae Park <sj@kernel.org> wrote:

> Hi Honggyu,
> 
> On Sun, 17 Mar 2024 17:36:29 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > Hi SeongJae,
> > 
> > Thanks for the confirmation.  I have a few comments on young filter so
> > please read the inline comments again.
> > 
> > On Wed, 12 Mar 2024 08:53:00 -0800 SeongJae Park <sj@kernel.org> wrote:
> > > Hi Honggyu,
[...]
> > Thanks.  I see that it works fine, but I would like to have more
> > discussion about "young" filter.  What I think about filter is that if I
> > apply "young" filter "true" for demotion, then the action applies only
> > for "young" pages, but the current implementation works opposite.
> > 
> > I understand the function name of internal implementation is
> > "damos_pa_filter_out" so the basic action is filtering out, but the
> > cgroup filter works in the opposite way for now.
> 
> Does memcg filter works in the opposite way?  I don't think so because
> __damos_pa_filter_out() sets 'matches' as 'true' only if the the given folio is
> contained in the given memcg.  'young' filter also simply sets 'matches' as
> 'true' only if the given folio is young.
> 
> If it works in the opposite way, it's a bug that need to be fixed.  Please let
> me know if I'm missing something.

I just read the DAMOS filters part of the documentation for DAMON sysfs
interface again.  I believe it is explaining the meaning of 'matching' as I
intended to, as below:

    You can write ``Y`` or ``N`` to ``matching`` file to filter out pages that does
    or does not match to the type, respectively.  Then, the scheme's action will
    not be applied to the pages that specified to be filtered out.

But, I found the following example for memcg filter is wrong, as below:

    For example, below restricts a DAMOS action to be applied to only non-anonymous
    pages of all memory cgroups except ``/having_care_already``.::
    
        # echo 2 > nr_filters
        # # filter out anonymous pages
        echo anon > 0/type
        echo Y > 0/matching
        # # further filter out all cgroups except one at '/having_care_already'
        echo memcg > 1/type
        echo /having_care_already > 1/memcg_path
        echo N > 1/matching

Specifically, the last line of the commands should write 'Y' instead of 'N' to
do what explained.  Without the fix, the action will be applied to only
non-anonymous pages of 'having_care_already' memcg.  This is definitely wrong.
I will fix this soon.  I'm unsure if this is what made you to believe memcg
DAMOS filter is working in the opposite way, though.


Thanks,
SJ

[...]

