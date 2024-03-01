Return-Path: <linux-kernel+bounces-89020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C229186E994
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EE11F25E43
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E8D3AC14;
	Fri,  1 Mar 2024 19:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkwHzMHW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1847F24B23;
	Fri,  1 Mar 2024 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321402; cv=none; b=fo6mwAvqyO5qhEqJAJeMU20PXaQxKQcwqH1zTnCaxhuSPPlHOvCPmc7l6fYZ+yDSAUhLeSGunmZkcv1h55MDOWCIdXms1+8G//FMTxJdC04xhP7vYEBgtBgss1FdVcHbOTeMdQMkOCiPR1d8y9nQD9tmU1FKMFBOAt95ZP+e7Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321402; c=relaxed/simple;
	bh=Nz/QJoLkzoB8iob4rLnHiOlC6nJlTAcZG95r3IJ/SQg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XES+PH1VTKT5wz1kyrGhSM6Ts/u5S8ZOtVWXk50lmFKlA0Hd8UCGTkA/WdDUkWvDfKFg9YCPK4LX9ODHrv0oro37y7k9szbXujwt9X/o4p/5pYCbNsNxZJfrodXeScxThAOW9TdeQpnBJ3OB7FTmHJaajzof35jc8989pHh7wkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkwHzMHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9AEC43390;
	Fri,  1 Mar 2024 19:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321401;
	bh=Nz/QJoLkzoB8iob4rLnHiOlC6nJlTAcZG95r3IJ/SQg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=LkwHzMHW7J5ryZEQ6R/I2NywAst5D0BK3bTWlg1/FFURtJzFvI1MOvIszWXqtYLJc
	 ZvxGGvY2ngbuAkEO/qmenBtGMgefko9ngZwrYZEcShZd2meakPFhYMEBKa6eQ2irII
	 JfpOusSREUIwlgJs4+sJAKcKcK5L5dTrsYU+E9DyoejTgwJ2J6heV7kfR87MzH/bnc
	 eSGzikvSBUURFmHBlvQcY8AnLTHApQH0GzGCGal+Vw+GRPZf/z3xnJ2pRRwfoET3Ib
	 KBqhDAjKcwtDEzJueRFzG2wlT8OTxwOXYpm5B/B4TumAqbLEidpP0lUG4Jc18f0mO0
	 xRVVHlch9NJtA==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v1 1/2] perf metrics: Fix metric matching
Date: Fri,  1 Mar 2024 11:29:58 -0800
Message-ID: <170932136986.3731358.13745527193899618886.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240224011420.3066322-1-irogers@google.com>
References: <20240224011420.3066322-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 17:14:19 -0800, Ian Rogers wrote:
> The metric match function fails for cases like looking for "metric" in
> the string "all;foo_metric;metric" as the "metric" in "foo_metric"
> matches but isn't preceeded by a ';'. Fix this by matching the first
> list item and recursively matching on failure the next item after a
> semicolon.
> 
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

