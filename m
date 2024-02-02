Return-Path: <linux-kernel+bounces-50560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B72F847AD2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE6AD283302
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABFB7C6CE;
	Fri,  2 Feb 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tkJyP0/G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8257765D;
	Fri,  2 Feb 2024 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907428; cv=none; b=hosPYypbQk9lyvftxyz6JsSNUKvVGwx/D4GRPlkewYHKYLKkhQ/j98V5hVN5HppzPvFEdZyGff6oinurLI4OvFxMnD1UPpibDC3UkYXz07x7+6T8GSfBWK3NrEWl1deuy+bTz34iSMm+wwO0wUumKrtYfc/gGXBLcuP6VhWxoO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907428; c=relaxed/simple;
	bh=frHQ/yeUekczVJm0BUTiuYzRV0/Mo1G2u+LCKvaWbT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpMxsBPJ+Qxnx+rJSXSmJL3afNMHxdRZqdiLuwjFSkLdtzjYtJC0mt3II1zqC+evXYTHLVuAf7IxLWzTQ+CZ/UxqtxAp7H40Pu0fn1yP0DVanTFu72elgHbRiY9695Ped1MTSuqM5XG8KyxnQDkaf76hzXKzEHst7zx8eQc56JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tkJyP0/G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C352C433F1;
	Fri,  2 Feb 2024 20:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706907427;
	bh=frHQ/yeUekczVJm0BUTiuYzRV0/Mo1G2u+LCKvaWbT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tkJyP0/GaIbGr1XNSGB1IbQvrGThxyjMuYY9rouzwDXcpBPGgx3MbI/ut+vnAqxmc
	 EO6nwdXcxPbrv6N5kma6EyXRYx5W3aqBQ2XJJIERXLhTSSp+/aKqcYfhnN7Pi4MbIv
	 xxhsOUm+RttKgkrm36Q8PNmsUejmWpVuc15kVbt7oLTkGhG5O/iJRFy8yMGPEt6zni
	 PB/uirO3BsqWaImSka/Xb9bg230pCmVDMWYVlar3TYdgEZT9RF3X52+0Zby/CdvWNB
	 6QHQTVX1U5dX/2X+j/8TW3HxHTIpf3ul1btIVF94uhimdutd0GeGfSOvduKOUsWYRI
	 6mPBi+tP86DKg==
From: Namhyung Kim <namhyung@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ian Rogers <irogers@google.com>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Ze Gao <zegao@tencent.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf evsel: Rename get_states() to parse_task_states() and make it public
Date: Fri,  2 Feb 2024 12:57:00 -0800
Message-ID: <170690725031.1264496.18004455069191563889.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240123070210.1669843-2-zegao@tencent.com>
References: <20240122070859.1394479-2-zegao@tencent.com> <20240123070210.1669843-2-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 23 Jan 2024 02:02:11 -0500, Ze Gao wrote:
> Since get_states() assumes the existence of libtraceevent, so move
> to where it should belong, i.e, util/trace-event-parse.c, and also
> rename it to parse_task_states().
> 
> Leave evsel_getstate() untouched as it fits well in the evsel
> category.
> 
> [...]

Applied to perf-tools-next now, thanks for your work!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

