Return-Path: <linux-kernel+bounces-111787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A72978870FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DE0284F04
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956575CDC0;
	Fri, 22 Mar 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT6ZfUcI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21F3495F0;
	Fri, 22 Mar 2024 16:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125557; cv=none; b=hFTi7/h1pTwcyXcwOtKCdl6i0TuUtqxcqmdNguwB+aPn/1txUec7WrkIcXbmVBpeKick52ryoiuQ8uA2hDxgcqO5/lHoc4mEcvjbX6O97WCL+BskzOa7JhRlNrU19PaADBwovKJ3bZRbVPbtWfvpt/EJMyGUeo/cBzvVudgd1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125557; c=relaxed/simple;
	bh=2geR0ApH0yInHgP7oRxLLRxqBIVI0b8whSqETq2TB0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rATrQNPiGC/O1a7uMMahRnXz3AfVhDGaskIzku0Sr+Cqr3Pkw608+7Wk04UWp35k2O/JP7RlUFrDMMnSiSOKfVOZ/qRuAR+lsH7wdvx5GGuhdRVjiaQ4eFRiC6ODr12Uw8uuJ14bWMxsWFzvFfQb0olvkdrOwMoBCJJ6NrfNVjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT6ZfUcI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7106C433C7;
	Fri, 22 Mar 2024 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711125557;
	bh=2geR0ApH0yInHgP7oRxLLRxqBIVI0b8whSqETq2TB0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aT6ZfUcIAa38sOwvHURZmqZl0YLgUbXs7mQpV09jufoZNhvHq1LKPrVGPTn5UMYlY
	 hyyAZUU39eS83Bx2dJr4BiAloL6veZwgE85ZAbCKbl99gjOsz91wa6nMCAy959FruF
	 XqcM/CUfS+aT9+rtpXyWjDAdhd8brQS/dSVAXCEl0ik616uDQ3LK8xKJ6MHnfw6+UN
	 ZKfMA5yhQFLWRaiSuRONKa4g8BkS3vSvyxEzbKzhZlt7wmocqIoCThRDJjkSDgleW0
	 Mz5GGoWAhUDcTn2QHx0NoI2WKQmxLjNQ+jTUubWkkQUe9lNc2Qiez5XgzDocGaEh1X
	 a8JJRWAh6UWPQ==
From: SeongJae Park <sj@kernel.org>
To: Honggyu Kim <honggyu.kim@sk.com>
Cc: SeongJae Park <sj@kernel.org>,
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
	42.hyeyoo@gmail.com,
	art.jeongseob@gmail.com
Subject: Re: [RFC PATCH v2 0/7] DAMON based 2-tier memory management for CXL memory
Date: Fri, 22 Mar 2024 09:39:14 -0700
Message-Id: <20240322163914.68475-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322082742.2233-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 22 Mar 2024 17:27:34 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

[...]
> OK. It could be a matter of preference and the current filter is already
> in the mainline so I won't insist more.

Thank you for accepting my humble suggestion.

[...]
> > I'd prefer improving the documents or
> > user-space tool and keep the kernel code simple.
> 
> OK. I will see if there is a way to improve damo tool for this instead
> of making changes on the kernel side.

Looking forward!

[...]
> Yeah, I made this thread too much about filter naming discussion rather
> than tiered memory support.

No problem at all.  Thank you for keeping this productive discussion.

[...]
> Thanks again for your feedback.

That's my pleasure :)


Thanks,
SJ

[...]

