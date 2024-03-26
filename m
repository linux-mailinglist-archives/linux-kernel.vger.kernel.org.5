Return-Path: <linux-kernel+bounces-120118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC5188D296
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD861C39B10
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D9A13DDB8;
	Tue, 26 Mar 2024 23:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRczeLk5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FD373189;
	Tue, 26 Mar 2024 23:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711494193; cv=none; b=OditIgr5UEDrusKWrRo76H7HLs60EiR4E++BBmCPMOHGWhGN4iMfv2JXGXbGVV7kpgz9BPqWfidzqX9iR2GeFZq+0qA4YNkm29Wa3661u+PoDVacEtAIuQIjTk5MaxWlPtcmjv7Y1K8H0zMukizA1Qsbf3kh/oF7kDZvUYXvZ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711494193; c=relaxed/simple;
	bh=y8X4CghROntNwx0hRkVczdZ/8zLwN37++zC1IctRuYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EhmkeTir13emHZXlH69r+X//rX60egMw9/ine93OmkiUButpHXWSjoGfS6oXb6F9S9G3x9TKLdRNp4+uvKlgcFpmrtMlvXIXbMKRA8nbeoek7rmOqj4FoROh27foNRH1YjFF1hIEE3Kxn7Iq/OyiD38Qwc0yc1DEviVrYq2CVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRczeLk5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00AD0C433F1;
	Tue, 26 Mar 2024 23:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711494192;
	bh=y8X4CghROntNwx0hRkVczdZ/8zLwN37++zC1IctRuYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PRczeLk5OZ3BfuojZQxwA+5eVan09Z5hQoK1oU4ySRx0TU+IStqtoeyZUDspMapc0
	 IpRJMQC1IRySBQIRtFaQAwGI0aAQDzdflzYf4q66fgYI+xpoRjcjBygpfpuSKUfqDQ
	 yNqDLPpU+q34TlbIg9feAYuCShRSJXA6IcJYwP/MacU/rj30n3+ilmp+s7TKvr48wz
	 XVSZT5JOfdgtJnLff7Yvgc+7FpuWgVMz81HlrDqXcqqahUTdxEnUKufHFYA++KH9Jd
	 XM2NWQv9+Sz2xmNckN+sCD7uyfDO5RbGaD4T52lJ7o7KYdyeRkqx9MQjPo2YmvioU8
	 iM8aSKaB73J8w==
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
Date: Tue, 26 Mar 2024 16:03:09 -0700
Message-Id: <20240326230309.47079-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325225304.235736-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 25 Mar 2024 15:53:03 -0700 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 25 Mar 2024 21:01:04 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...]
> > On Fri, 22 Mar 2024 09:32:23 -0700 SeongJae Park <sj@kernel.org> wrote:
> > > On Fri, 22 Mar 2024 18:02:23 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:
[...]
> >
> > I would like to hear how you think about this.
> 
> So, to summarize my humble opinion,
> 
> 1. I like the idea of having two actions.  But I'd like to use names other than
>    'promote' and 'demote'.
> 2. I still prefer having a filter for the page granularity access re-check.
> 
[...]
> > I will join the DAMON Beer/Coffee/Tea Chat tomorrow as scheduled so I
> > can talk more about this issue.
> 
> Looking forward to chatting with you :)

We met and discussed about this topic in the chat series yesterday.  Sharing
the summary for keeping the open discussion.

Honggyu thankfully accepted my humble suggestions on the last reply.  Honggyu
will post the third version of this patchset soon.  The patchset will implement
two new DAMOS actions, namely MIGRATE_HOT and MIGRATE_COLD.  Those will migrate
the DAMOS target regions to a user-specified NUMA node, but will have different
prioritization score function.  As name implies, they will prioritize more hot
regions and cold regions, respectively.

Honggyu, please feel free to fix if there is anything wrong or missed.

And thanks to Honggyu again for patiently keeping this productive discussion
and their awesome work.


Thanks,
SJ

[...]

