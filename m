Return-Path: <linux-kernel+bounces-79185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C5C861E96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD59B2211E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D42149387;
	Fri, 23 Feb 2024 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gx27df/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39431448DE;
	Fri, 23 Feb 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722882; cv=none; b=qmYjKijV+1NGFg5sv5DvWooicxPjuPjyayQ0h6wf4mwKvui17lXjNdcFTNANE7Xv50htYCjJbgIHPchWsFqeS5Nnw/vw/shFLi7NiaswU0TePPxxYSZcurJDjDxVA0zMPF70N1GOozNLqC3IqV5IGkHTE3dmgCkhAoaOmpR9DkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722882; c=relaxed/simple;
	bh=yl3CZeQj3q+MbODgHmMHwet9xKy0k4nfEARp/YeN2cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2gy79U3b/CtwReM8Q9an/pQpvVtGn3Lsg899ihPJIrMIUyIhM0Yhe2cyEmOq9/XDF8FKdqwhtTjLW6/of4J9o5mT2J0tU1DiHR7LbLcpdpbaNJdT/okZPGYdveGKBTsQn9/oQT5NUxFCXH6ducSdQLrUqU4c2Z7OsEWZqeWVJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gx27df/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFFEC433F1;
	Fri, 23 Feb 2024 21:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708722881;
	bh=yl3CZeQj3q+MbODgHmMHwet9xKy0k4nfEARp/YeN2cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gx27df/wdNJMr8+1CuZZ+3TaPkaZVRZX1o3fo9UZJNOXzo55Zj/MwVpoDNj4qydMt
	 yn6/WzHu0ZLTrOzllX1C9D5qukIg7QlPp/oN4H3kfJajOfiVhuSMOeypsxxT9RZcm9
	 EZ3TNnMDrI/yu8KM8729XCHFGblfKl/ICHkc8LmpgBQvvEncAkn6ajDqHwGcDInvbH
	 aO+GI34pX7KMAJxHNZcG5bl1hWOlwpMCGxhHRYsMxRu+XLj8PGUw5GMxwSFtCS8vve
	 UY5XvC/8+posYtErQlydXsAa1JJg+OcN7dFuim7Q/I080httJhRD8Kf16u8oP4I8af
	 2S578ThexXzVA==
From: Namhyung Kim <namhyung@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kajol Jain <kjain@linux.ibm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Kaige Ye <ye@kaige.org>,
	Mark Rutland <mark.rutland@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v3 1/3] perf stat: Pass fewer metric arguments
Date: Fri, 23 Feb 2024 13:14:38 -0800
Message-ID: <170872283702.3880577.15255792223602721084.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240221070754.4163916-1-irogers@google.com>
References: <20240221070754.4163916-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 23:07:52 -0800, Ian Rogers wrote:
> Pass metric_expr and evsel rather than specific variables from the
> struct, thereby reducing the number of arguments. This will enable
> later fixes.
> 
> To reduce the size of the diff, local variables are added to match the
> previous parameter names. This isn't done in the case of "name" as
> evsel->name is more intention revealing. A whitespace issue is also
> addressed.
> 
> [...]

Applied to perf-tools-next, thanks!

[1/3] perf stat: Pass fewer metric arguments
      commit: eee41e6b287e2adfefbe3b6fc80c66097c076f89
[2/3] perf metrics: Compute unmerged uncore metrics individually
      commit: a59fb796a36bb6c2b7e6e256a9e5f9ba18109937
[3/3] perf stat: Fix metric-only aggregation index
      commit: bafd4e75c1ac5a9da0aec5c7c52c7a72613a0cf3

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

