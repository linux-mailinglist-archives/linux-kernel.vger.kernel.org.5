Return-Path: <linux-kernel+bounces-57242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDBD84D590
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 702531C25AE7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1413A86C;
	Wed,  7 Feb 2024 21:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxgm98ni"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1526713A267;
	Wed,  7 Feb 2024 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707342505; cv=none; b=KO0FHf+RobKQlK67Q6VT/oeXHftafM8XlBTO/S2zf+cFYEbwrEG9apDf5N1L/gx7HSojIQRJG6VxVo2flCXozws2uC1VzyOXkKbCM4aEawTRFgu3o5a8FCVHIlUDJCFtx0AuYTrklrXiQQ4mYn/s1om9JosotolEEsu87CR6D7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707342505; c=relaxed/simple;
	bh=cQc83WQNS4DBqYu+rWS1YbdONY3oCSTty9XL4pzc+/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alEGqvK7FjYwVPIIJOhHNRnSHhLU+TftsKFyBJ19Qb5iSPdP2uVxGrEOBhGC47PnHXp1jFOcwgOFMH3yGrorKFLY0rJNZvIAfxaXcbuxMtUaStqMcFRBOjJz1mG9ts3GaxUtY5AVHMS9Aa+5pD2GD9mSmIDRgTi0aLGqWScRsIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxgm98ni; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344D1C433C7;
	Wed,  7 Feb 2024 21:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707342503;
	bh=cQc83WQNS4DBqYu+rWS1YbdONY3oCSTty9XL4pzc+/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rxgm98niMP3JsDJIOeAYW6nUdaWM2MfJOihD6GEQKVUFOI84U8YGpLrxuZLyb/1H2
	 gxJOHsMjuOG0SxmSAqXTy805Irmf/1uqEnaCGkVe6LESVKwVfDhSpihk4cqoxCNwDg
	 gmN5qlT7WqOLGlfjTFdTksXkzqgLpQXjE7+ob1CUnHCiwivrr8YNrtkXOX5i+wMsks
	 +T4FxxroqtBgJDq/bbwnyKbDJEg9hhlzgsRQfyAOzy4T5iK3BY7Co2KPuBv0TJLObf
	 VITsdpFoZv/7w+f9xHjmHAPpphz79yf/S0UZVCiHLp3lWgGdXJRkgHw10L+5MYXeY0
	 rx07r4T6P8rSg==
From: Namhyung Kim <namhyung@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-perf-users@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf record: Display data size on pipe mode
Date: Wed,  7 Feb 2024 13:48:21 -0800
Message-ID: <170734243427.3472515.6384154144082025700.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240112231340.779469-1-namhyung@kernel.org>
References: <20240112231340.779469-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 12 Jan 2024 15:13:40 -0800, Namhyung Kim wrote:
> Currently pipe mode doesn't set the file size and it results in a
> misleading message of 0 data size at the end.  Although it might miss
> some accounting for pipe header or more, just displaying the data size
> would reduce the possible confusion.
> 
> Before:
>   $ perf record -o- perf test -w noploop | perf report -i- -q --percent-limit=1
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 0.000 MB - ]    <======  (here)
>       99.58%  perf     perf                  [.] noploop
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

