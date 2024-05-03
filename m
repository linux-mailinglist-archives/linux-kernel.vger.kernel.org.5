Return-Path: <linux-kernel+bounces-168178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1911F8BB4C0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462BE1C23221
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F62158DAF;
	Fri,  3 May 2024 20:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3znZihv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4265C158D86;
	Fri,  3 May 2024 20:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767835; cv=none; b=kzJAUKDgS9h/dqjCaJGesIndT4SoIjUUlMuluR013VoMCB47oMLm6YEtREPRYs11mmgB2nOhOurCT/nyzQcZ4IN6sc+IAvEoPka2agpeyEZH70JV2J9FUebsGStk4luZg23MPWnYSruQB+Y0Z62ckuxVuITfBGfeNqZcBZcNeg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767835; c=relaxed/simple;
	bh=VHK2aYXQsjwUVWEy+15TxeXXA9tATJmF9VCn5bK+xlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CG6pBmPoXa7B2DoyMHla1kBOE/yK59plQujvRNdDEG3jAqbhNMJGvgoZ7uw2lKTgZqb4mtYpG2xs4RraxvGxEbBdoXNNhWfG2r9rMd1D0mH6zKT2MNxS9+L45snIMRDOIMOW34rdeTPJhPoJGFm/ZwxNTdNLy/t3insfY0kynHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3znZihv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAD8C116B1;
	Fri,  3 May 2024 20:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714767834;
	bh=VHK2aYXQsjwUVWEy+15TxeXXA9tATJmF9VCn5bK+xlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M3znZihvBOZCe+Su1jHeQ4Usj4NM8suZd89dcBJWo8tt5kYIE9olqRolnGuImWyyv
	 fhE8F72lrnZsrreBH4pXIxIvUCOqvVgxeGTV+6VXcASG1fL6cbANzlu8mI5ObU0lRY
	 pIw6V9c7Os3iZtCGUAnUMYZ99XchqPuoW3v8sNLkv/eLQkJ0qdI87sa8sZVaIHSp/Y
	 BmnUfO1ppzA5rYy+PuN7MKTuBJPR7XKNU4v2pmNpV4i9NsjQCj8F/nCNhgdLMZIN5O
	 z3JGzsb4A6I1+lSH8Ovyun6au29I2oiXNMQgtDB1CONeU0J3WmI+fvLy0Os5gwL78Y
	 d6sR9BBQQ6WDA==
Date: Fri, 3 May 2024 17:23:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, gankulkarni@os.amperecomputing.com,
	scclevenger@os.amperecomputing.com, coresight@lists.linaro.org,
	suzuki.poulose@arm.com, mike.leach@linaro.org,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 00/17] coresight: Use per-sink trace ID maps for Perf
 sessions
Message-ID: <ZjVH118DtAdZKo2v@x1>
References: <20240429152207.479221-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429152207.479221-1-james.clark@arm.com>

On Mon, Apr 29, 2024 at 04:21:45PM +0100, James Clark wrote:
> This will allow sessions with more than CORESIGHT_TRACE_IDS_MAX ETMs
> as long as there are fewer than that many ETMs connected to each sink.
> 
> Each sink owns its own trace ID map, and any Perf session connecting to
> that sink will allocate from it, even if the sink is currently in use by
> other users. This is similar to the existing behavior where the dynamic
> trace IDs are constant as long as there is any concurrent Perf session
> active. It's not completely optimal because slightly more IDs will be
> used than necessary, but the optimal solution involves tracking the PIDs
> of each session and allocating ID maps based on the session owner. This
> is difficult to do with the combination of per-thread and per-cpu modes
> and some scheduling issues. The complexity of this isn't likely to worth
> it because even with multiple users they'd just see a difference in the
> ordering of ID allocations rather than hitting any limits (unless the
> hardware does have too many ETMs connected to one sink).
> 
> Per-thread mode works but only until there are any overlapping IDs, at
> which point Perf will error out. Both per-thread mode and sysfs mode are
> left to future changes, but both can be added on top of this initial
> implementation and only sysfs mode requires further driver changes.
> 
> The HW_ID version field hasn't been bumped in order to not break Perf
> which already has an error condition for other values of that field.
> Instead a new minor version has been added which signifies that there
> are new fields but the old fields are backwards compatible.

I guess I can pick the tooling part now, right? Further reviewing would
be nice tho.

- Arnaldo

