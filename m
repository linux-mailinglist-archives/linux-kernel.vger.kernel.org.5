Return-Path: <linux-kernel+bounces-83716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A658F869E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FF44B30AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F7C14CAC4;
	Tue, 27 Feb 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pd1nYwDE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02ACC4E1BA;
	Tue, 27 Feb 2024 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054724; cv=none; b=uNQKSVFAY1lAbfaBHtBN6eZHMabbOPTJpSBGEx6YzkEVuzwo9uN9IJismYDyArbNPxph3XNVHE81hMANmzCW09lmOKv2SF8MRoR0WN09Cv58psplLkdu3EXWzQNEJXQGJbGO2mqfKVyYmHRHrYA8gsD4NxE3XOXzMVY+ZlWvrbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054724; c=relaxed/simple;
	bh=xCimZPtKHjwdU7nbtwoJGxR9Q9WTWA4Hg+6aLCtN9B8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbWA41G3O/N8UVqmSqpVTGGzciNtwSm48SWgfQjQcDPtcnHvlXVq6tPeLHz4A+6dJNbRgx0PXnsJXXqhzmCTzSexpsuAx8m2go7owFHMUCIkuXvTW1mj5HTo7pGGVApeQjYPeA59FJ5diQkfha81pCLKUpuBXKMJ4xAyRfDpbZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pd1nYwDE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAF3C433C7;
	Tue, 27 Feb 2024 17:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709054723;
	bh=xCimZPtKHjwdU7nbtwoJGxR9Q9WTWA4Hg+6aLCtN9B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pd1nYwDEDEWlIwyOQHUKH+/9CYNkMdDZPpaK50+aehXrf6KdtuFeTmdLMzHaE+Dj9
	 cGcBMnnFU8nLkTSqRqrLhkQA+gy93mE8S/dXHH8i0V3RsqAOp0705TadpSyw2X5pEh
	 Qo3G9HEJbJvvshDWaESwobRX5XoiWMckW2QdiTVcwt7uPs5bzcE9fDHlNtHV7R3Q7U
	 b6Wvu46MOl8IJipqapk0+27lgyKPXOtoHjtkIt5/PD++cgLWfdC94/+YWnjCsWW0p7
	 5xOCSsg1PGp1E7+60GdpMGlkwZXeyqPnNcwgFZq1OzQYvwV5KxCTGGMGWH2bmEi3Ho
	 g0Z27toQAmE6A==
From: Namhyung Kim <namhyung@kernel.org>
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>
Cc: Evgeny Pistun <kotborealis@awooo.ru>,
	linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v4] perf data convert: Fix segfault when converting to json when cpu_desc isn't set
Date: Tue, 27 Feb 2024 09:25:20 -0800
Message-ID: <170905469226.501091.4202015641394575376.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240223220458.15282-1-ilkka@os.amperecomputing.com>
References: <20240223220458.15282-1-ilkka@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 23 Feb 2024 14:04:58 -0800, Ilkka Koskinen wrote:
> Arm64 doesn't have Model in /proc/cpuinfo and, thus, cpu_desc doesn't get
> assigned.
> 
> Running
> 	$ perf data convert --to-json perf.data.json
> 
> ends up calling output_json_string() with NULL pointer, which causes a
> segmentation fault.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

