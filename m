Return-Path: <linux-kernel+bounces-65861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0314B8552E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CEC283789
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694DF13A861;
	Wed, 14 Feb 2024 19:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knIwMrsQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E1171A2;
	Wed, 14 Feb 2024 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937674; cv=none; b=XVfeQWn2YBNnoE4sosJang3A1xbY/Ltkq5w8UwJoDKo7yB4VoJwfboX++D9viZ58P7yILoRswG6RmigM7U9OZcuhe8k6/4bw0rVKn41twdQPFuUe7ffxkbowwIZhX2i5caZXMs53AOZ8yyishNyuZI0FOX2SslfQHtaP7ZuI6a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937674; c=relaxed/simple;
	bh=dVuNhVECkCBDQPkTl0TEAQMEvJNx8lia/jdD3LQoT00=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrQiDUMiEJtOJt+NV+GnlYGchEla0FCUPIIsJaz//x8lP3y9PNWl8uw5D3fcS21iPLPX1M31hRMFVq66v8Y408Upd5uZ1eux9Pvotu2MKyQiruxQ/Pk/KG7H7Nbx1zQ72qB6kYSg8UaBa4LHTaTv4SuVyRshDad7bMzG3heeqVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knIwMrsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9591C433C7;
	Wed, 14 Feb 2024 19:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707937674;
	bh=dVuNhVECkCBDQPkTl0TEAQMEvJNx8lia/jdD3LQoT00=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=knIwMrsQhD06Fwz0QZYZupl37P0zkFwlFYnn6Dn14TiLK02GOpoqz+Juo4U3VHMlT
	 ZVb1s8J299/C0UrlPSzNL9i/QmTbSDQRqoyZfpRrueB3guGJ8VWhaognZvCdzN30/K
	 Vt6JyS0+VJEJFuvikQ2QCNb1w7bHnxmJZWdXrzYJgKy1GsiVe10VxE+xM2sbrraxWd
	 XAVEdrTIwzSRUwFSsQLSwCHxz8gfPgXk9oR054x/4yWrnxGfdz7hrY6hhLslYOOMCo
	 cMrGqJn1FV7hnf0yIg1Fc5tgzCITWfD4qvDTuq0LsywGuBHogieQwYz+Q1e9cGT8GM
	 SFYcaXhM/vP5g==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Kaige Ye <ye@kaige.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	James Clark <james.clark@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/4] Fixes/improvements to metric output
Date: Wed, 14 Feb 2024 11:07:50 -0800
Message-ID: <170793764755.751788.14116440459432797580.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240209204947.3873294-1-irogers@google.com>
References: <20240209204947.3873294-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 9 Feb 2024 12:49:43 -0800, Ian Rogers wrote:
> A small addition to allow NaNs to be encoded in metrics and then 3
> fixes to various metric related issues.
> 
> Ian Rogers (4):
>   perf expr: Allow NaN to be a valid number
>   perf expr: Fix "has_event" function for metric style events
>   perf stat: Avoid metric-only segv
>   perf metric: Don't remove scale from counts
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

