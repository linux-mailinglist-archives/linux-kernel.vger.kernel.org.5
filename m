Return-Path: <linux-kernel+bounces-44762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F527842709
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB0A28EC06
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E407C0AE;
	Tue, 30 Jan 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW9hb5eW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1567C59165;
	Tue, 30 Jan 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706625560; cv=none; b=adBsX1uwnyNHfkeCfQYBaxR+RUzUo2xEWZ+uIOgxYcVpxyxTTrjxTpQqDwOjlL5cJd4ggRsYlEaDYwsidFAao8rjdL3n0+FVC9Y3K5i/CeuE9ZNPrOeryEoKQKBTCEJ0XgVw2MdSKeWtlUK6r5xhwsEtJtsRiWVS/f0JEg6e9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706625560; c=relaxed/simple;
	bh=twhlpP4bEJB8a4B8B+SAN5xVLlCuRCkzWmOyPl3lKBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US+Euvl2e/px+4omCtOGBiWW7dTUko8EfUDZ5C4fzIJEpxMsdF4YQ4WEqSdRiVQbPbzZhH9R3/1+J2mEWxcq0fCbDSPxC5yb9kmbSZZlekqcNXV4SHy2tNQhSgvWtBU8LeDyRxsfeK8iWivYRflAslai7Hj73NOQePSWHHOqs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW9hb5eW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70600C433C7;
	Tue, 30 Jan 2024 14:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706625559;
	bh=twhlpP4bEJB8a4B8B+SAN5xVLlCuRCkzWmOyPl3lKBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GW9hb5eWTHFKkNMehSN3kpb61L0gCba1Xdp+Wg+v6n3vODwU9v9e9ntXqYNstHq8v
	 i2GThP++ZnL/pgQF1iKty42By8Gt5k5qp6fLVDKstHP8vH8xJok8Ya7p3TcbWtqAVN
	 pW1Myqb5cuL+xQGMb4D1+a3JTsnAiPSzrQuLtU9090G4R3ehgBO2fvz58lT95qlBSf
	 5COmUHdWPO0XCptIU+tQk64bq2lTY7O+p7n0hynaM1G/lp/nL0gnZ2wADfXZzaWWxm
	 WBH1q4aepvi/u9sfUzHwVIU4se77Fit4AHqvx5KAQoUflhP46axIZ/4tXXtctzB5v2
	 Wrj6+OqSTbGiA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 0A47940441; Tue, 30 Jan 2024 11:39:17 -0300 (-03)
Date: Tue, 30 Jan 2024 11:39:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: James Clark <james.clark@arm.com>
Cc: linux-perf-users@vger.kernel.org, irogers@google.com,
	namhyung@kernel.org, Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Changbin Du <changbin.du@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf evlist: Fix evlist__new_default() for > 1 core
 PMU
Message-ID: <ZbkKFHsdOJOnzmdF@kernel.org>
References: <20240124094358.489372-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124094358.489372-1-james.clark@arm.com>
X-Url: http://acmel.wordpress.com

Em Wed, Jan 24, 2024 at 09:43:57AM +0000, James Clark escreveu:
> Fixes: 251aa040244a ("perf parse-events: Wildcard most "numeric" events")
> Closes: https://lore.kernel.org/lkml/CAP-5=fWVQ-7ijjK3-w1q+k2WYVNHbAcejb-xY0ptbjRw476VKA@mail.gmail.com/
> Tested-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Tested-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: James Clark <james.clark@arm.com>

Thanks, applied to perf-tools.

- Arnaldo


