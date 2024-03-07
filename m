Return-Path: <linux-kernel+bounces-94904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5991874686
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56549B22257
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9A2D2EE;
	Thu,  7 Mar 2024 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4xIBEcl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D9363D0;
	Thu,  7 Mar 2024 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780753; cv=none; b=Ryga7N7nEkvhrYIYM/olcU+IENjG7OXxogOXTlyD8YmJlhrHs3HWk7QYBGrVsnV273e82HpsvIv/qh93xR1Yf7gu6HaQArvEc9XE4ViNj2cxkR/WfkOVTtcIkwjNPqC1ePJ/b8jp0+CzIrWav7pH2bFjrStYD1StKVMVedsuTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780753; c=relaxed/simple;
	bh=8ful7sN8c0CPBqZwFl7Swppe+T+Tso7XnELEfEKpEhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPqyx/xuWQQkLVNi6x/ax3+/0H1Z9w0NYX67ck2PJAQFLTYueNyk+l474VaIlRaXe1+/sK7lnm2oW/VbemdK43/7zaA7aPSL8jNihd6Lnt+GUFCJVKjDfbvVGFgUz59dhH0ABuK0zCyDRczRhs+esL1QyiJXEqLKXQ6dxElDgGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4xIBEcl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F6DC43390;
	Thu,  7 Mar 2024 03:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709780753;
	bh=8ful7sN8c0CPBqZwFl7Swppe+T+Tso7XnELEfEKpEhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4xIBEclaYjge0kRl9J0ZEMfTN13SWxQ5od+q5AOqu7p+AF20i9NUe0E+fXws3Sft
	 ytWNrxRH9CPQHMcSYGFG1Yv3LewMySjQ2DntCwDIAYl/3Ctbl0F2fBrWbAxhmo+XiY
	 a4+oF+fKXDHI6EBIh0OeopGIdHTSU6rhOiXuFW2VrgCzBUvo18ugeBftvpT1KIKX0h
	 gbeulnr82Jz2kQfJMbP4RuqlwmrLuCh0VCRCoWOwxdcTJtR46hWU8mT5GxzxXpkyXZ
	 2Gf6iu8XXkDXD5JF/HvmB8D9VMEnFkVGFH1FBP31xBEnkavdP74oqcM1Gb4UA/7Ss6
	 G/NFgoeUidnqw==
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
	lizhijian@cn.fujitsu.com,
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
Date: Wed,  6 Mar 2024 19:05:50 -0800
Message-Id: <20240307030550.47095-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227235121.153277-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

On Tue, 27 Feb 2024 15:51:20 -0800 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 26 Feb 2024 23:05:46 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
> 
> > There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> > posted at [1].
> > 
> > It says there is no implementation of the demote/promote DAMOS action
> > are made.  This RFC is about its implementation for physical address
> > space.
[...]
> Honggyu joined DAMON Beer/Coffee/Tea Chat[1] yesterday, and we discussed about
> this patchset in high level.  Sharing the summary here for open discussion.  As
> also discussed on the first version of this patchset[2], we want to make single
> action for general page migration with minimum changes, but would like to keep
> page level access re-check.  We also agreed the previously proposed DAMOS
> filter-based approach could make sense for the purpose.
> 
> Because I was anyway planning making such DAMOS filter for not only
> promotion/demotion but other types of DAMOS action, I will start developing the
> page level access re-check results based DAMOS filter.  Once the implementation
> of the prototype is done, I will share the early implementation.  Then, Honggyu
> will adjust their implementation based on the filter, and run their tests again
> and share the results.

I just posted an RFC patchset for the page level access re-check DAMOS filter:
https://lore.kernel.org/r/20240307030013.47041-1-sj@kernel.org

I hope it to help you better understanding and testing the idea.

> 
> [1] https://lore.kernel.org/damon/20220810225102.124459-1-sj@kernel.org/
> [2] https://lore.kernel.org/damon/20240118171756.80356-1-sj@kernel.org


Thanks,
SJ

[...]

