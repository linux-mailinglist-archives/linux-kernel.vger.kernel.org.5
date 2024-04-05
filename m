Return-Path: <linux-kernel+bounces-133530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E537889A4EF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AE7F1F21F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D5172BD4;
	Fri,  5 Apr 2024 19:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCDnoxOU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF15172BBC;
	Fri,  5 Apr 2024 19:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712345284; cv=none; b=REi9pmasdMOHdvYLG0ahHtqEaUnkKMzkVO+ScZpxmIyHH4XmGawV32EHc8HOllqfcK0ex4mLHkUto6qRkw8vXruuiCL5yqTlio5EVLNG93bVcIpGYGuQU7+b5tRhLKps0yEocwOGMhb5lV4eVo4gYN0xEgPdsFWJurHA7wThA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712345284; c=relaxed/simple;
	bh=s4X5xF38G0xdBCRwrgje/a8N9SSzOSAJM1btVV1Oid0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MBKD2RMrqk/x0wL54mL8t71MHdzo8ypraL0dDODX9Sg0Pres1pfZj3Q5pMePbCN73awHpqLonvnqmLzAz81wySYdd0by4Ty2+nr6GAgEIm5AhAqPQ1Yf4Rxk0w+I62A1NycdJiyAVs9ALLwcPUFbjKt1r1OLWdTPVGGDYtXtSnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCDnoxOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825B1C433F1;
	Fri,  5 Apr 2024 19:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712345284;
	bh=s4X5xF38G0xdBCRwrgje/a8N9SSzOSAJM1btVV1Oid0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCDnoxOUCYeV7Pblmh2okpq4jgNajyC9ezTEfuysj8xIgQKvwqhTYee3ZS3FxYtGk
	 DBOFJx2XagEzwPdeTYjk6C+UP8e6UrD7gyf/wU/1yucN4R9ldy2eot1NzCotWPvacE
	 V6lYbcEcSYhEfUfSfzDcT28OfD/yEHL4Qj0GfsXuwOEex5sy1QxFCijWCMNYrX1MPH
	 0ctHqJrxJBtK1OjhAdshieBRj4Lc0632VWS5fzLo/FlklR2lnGZITVAA0IfDmdhnvs
	 U6+woybOxPLwlLrGCqCgeDVTbN/mL2EVGoqUxyZfKWfFMz41nCtxnFzCmqn7wiPanQ
	 tZaTkhPL2Uz8g==
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
Subject: Re: [RFC PATCH v3 0/7] DAMON based tiered memory management for CXL memory
Date: Fri,  5 Apr 2024 12:28:00 -0700
Message-Id: <20240405192800.67163-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240405060858.2818-1-honggyu.kim@sk.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Honggyu,

On Fri,  5 Apr 2024 15:08:49 +0900 Honggyu Kim <honggyu.kim@sk.com> wrote:

> There was an RFC IDEA "DAMOS-based Tiered-Memory Management" previously
> posted at [1].
> 
> It says there is no implementation of the demote/promote DAMOS action
> are made.  This RFC is about its implementation for physical address
> space.
> 
> 
> Changes from RFC v2:
>   1. Rename DAMOS_{PROMOTE,DEMOTE} actions to DAMOS_MIGRATE_{HOT,COLD}.
>   2. Create 'target_nid' to set the migration target node instead of
>      depending on node distance based information.
>   3. Instead of having page level access check in this patch series,
>      delegate the job to a new DAMOS filter type YOUNG[2].
>   4. Introduce vmstat counters "damon_migrate_{hot,cold}".
>   5. Rebase from v6.7 to v6.8.

Thank you for patiently keeping discussion and making this great version!  I
left comments on each patch, but found no special concerns.  Per-page access
recheck for MIGRATE_HOT and vmstat change are taking my eyes, though.  I doubt
if those really needed.  It would be nice if you could answer to the comments.

Once my comments on this version are addressed, I would have no reason to
object at dropping the RFC tag from this patchset.

Nonetheless, I show some warnings and errors from checkpatch.pl.  I don't
really care about those for RFC patches, so no problem at all.  But if you
agree to my opinion about RFC tag dropping, and therefore if you will send next
version without RFC tag, please make sure you also run checkpatch.pl before
posting.


Thanks,
SJ

[...]

