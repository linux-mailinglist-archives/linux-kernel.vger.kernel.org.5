Return-Path: <linux-kernel+bounces-139386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E308A0259
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FAA1B22B91
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65020184107;
	Wed, 10 Apr 2024 21:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="lqM+vvql"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAA1E877
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 21:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712785834; cv=none; b=ArvaYpHuzFupHbNAF7FNdGyiSi8gyZwYrrlAzAZ2NylnSQr284xWneTqTrYlY/4aMPGM+OKdBDb4WSheGxvnNYHz/ta78ICwLY0O5ojJQMjOBVKkvF+IoL9aPdvLMIwo/ggTvy/8kab63b6WT/Z9KiA9zaWCb1rha1a6vqrePPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712785834; c=relaxed/simple;
	bh=yh3IWOaQtFjiF7MditS6RnNuh0K6U3o5yhxsX2GMDTA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=k/rg5Bjy0wgFKpevUVxt5GXhC8RFfOMjnG03Eqf5C0miKuJunhQMSsXWWY7G8vvxP6wu9HdRk+xxJfBxYzWbfaQkxgl2MqjYNJEJR93uiJFq8uKrTKnI9Kob4AuEF+IPEDYrTIv0iPYLw32kJGgBa5r5nYXqLX3u5/nyW6+blyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=lqM+vvql; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F97C433C7;
	Wed, 10 Apr 2024 21:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712785834;
	bh=yh3IWOaQtFjiF7MditS6RnNuh0K6U3o5yhxsX2GMDTA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lqM+vvqloDVWttOtSYXVhi4ub9WpGrP3QcdXnOlKwjVihHfyRykWEG1HGe3AEUszb
	 kLw9KeQp65S7jGLvAoe3J7chll6YXlgxNh5C8UxjH2ck9JDiVV0Zqz7bLZhRItqxQU
	 GZ0BdWcndjAVMBATSmzlbpRgbS+c4YSB1bO5XZjE=
Date: Wed, 10 Apr 2024 14:50:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lance Yang <ioworker0@gmail.com>
Cc: ryan.roberts@arm.com, david@redhat.com, 21cnbao@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, zokeefe@google.com,
 shy828301@gmail.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Message-Id: <20240410145033.5cdb8a41f3a6894a62191f42@linux-foundation.org>
In-Reply-To: <20240408042437.10951-1-ioworker0@gmail.com>
References: <20240408042437.10951-1-ioworker0@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 12:24:35 +0800 Lance Yang <ioworker0@gmail.com> wrote:

> Hi All,
> 
> This patchset adds support for lazyfreeing multi-size THP (mTHP) without
> needing to first split the large folio via split_folio(). However, we
> still need to split a large folio that is not fully mapped within the
> target range.
> 
> If a large folio is locked or shared, or if we fail to split it, we just
> leave it in place and advance to the next PTE in the range. But note that
> the behavior is changed; previously, any failure of this sort would cause
> the entire operation to give up. As large folios become more common,
> sticking to the old way could result in wasted opportunities.
> 
> Performance Testing
> ===================
> 
> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by PTE-mapped folios of
> the same size results in the following runtimes for madvise(MADV_FREE)
> in seconds (shorter is better):
> 
> Folio Size |   Old    |   New    | Change
> ------------------------------------------
>       4KiB | 0.590251 | 0.590259 |    0%
>      16KiB | 2.990447 | 0.185655 |  -94%
>      32KiB | 2.547831 | 0.104870 |  -95%
>      64KiB | 2.457796 | 0.052812 |  -97%
>     128KiB | 2.281034 | 0.032777 |  -99%
>     256KiB | 2.230387 | 0.017496 |  -99%
>     512KiB | 2.189106 | 0.010781 |  -99%
>    1024KiB | 2.183949 | 0.007753 |  -99%
>    2048KiB | 0.002799 | 0.002804 |    0%

That looks nice but punting work to another thread can slightly
increase overall system load and can mess up utilization accounting by
attributing work to threads which didn't initiate that work.

And there's a corner-case risk where the thread running madvise() has
realtime policy (SCHED_RR/SCHED_FIFO) on a single-CPU system,
preventing any other threads from executing, resulting in indefinitely
deferred freeing resulting in memory squeezes or even OOM conditions.

It would be good if the changelog(s) were to show some consideration of
such matters and some demonstration that the benefits exceed the risks
and costs.


