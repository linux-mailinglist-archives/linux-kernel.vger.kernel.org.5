Return-Path: <linux-kernel+bounces-36223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB1B839DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:38:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 013821C21B7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD6110F2;
	Wed, 24 Jan 2024 00:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgL0FNnr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A208620;
	Wed, 24 Jan 2024 00:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706056725; cv=none; b=BuZG08pgEVJbRX33XnKhDZHRTuOnITK0XYCfAhXIPCw6Ix6V5uqzR/oyal8txWpF6bsdDyl1ud56aG1GWdsUdYnbXH+IIcw3PLC06MU3eb5NmbFwkAf6nrScMPPtEWIdj7cBq/IVQApzdbnYgC1NwLKYAtiOjXLUk2OmDkapAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706056725; c=relaxed/simple;
	bh=2RNVBVbGSf6lDzeopNXcQ1SyuEuGifLrQUM2Ezzj8Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixUG++DnoZBc+zzIUMAU/+b5Ev4LcZ8HTwtB1Bt989OZmVCtbDkwW1rlFgxJmOLQPlK3FdpxqgZ5O71GbfTT/w7Rg7SGQA+k2LNa6BOpeVVog1q6qUaChOEhEXjxLWB+QiMnHmXCsJknB9pN4bwi15mXRe4vPrCDTNAfdhrYt6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgL0FNnr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F82C433F1;
	Wed, 24 Jan 2024 00:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706056724;
	bh=2RNVBVbGSf6lDzeopNXcQ1SyuEuGifLrQUM2Ezzj8Qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dgL0FNnrBlOWhNEIQjuEF4T/+mJN5EV7/RSkpMwt7cZ+njwedRwIBfsWdwnSekWEX
	 ebdOesSDoBb1xqimgYOb6unbKI+7BUOy9TxnB0bbELXnpzn6TwACBz/VQOtX3+iL+/
	 ilHF7W3Oq1ssmRVS8qMxKSnoQDI93rX1qfts6QyJUMUq1CEJFXlCQBbgCQcTUxpoc2
	 EK0iNqgqb3wzvaPeKfDMkMSHqc8TPPNvFozjiL90bMBni4SBvKW1lGRN90E67gv95o
	 c0pOmk5SRjgGk79YfvYRqfTNAZMKsqGOyNuumC2BIX2fTg4rjcZBDMExRXUUypFD6n
	 sTJ6e9dI8wUYw==
From: Namhyung Kim <namhyung@kernel.org>
To: Ze Gao <zegao2021@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org,
	Ze Gao <zegao@tencent.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2 0/4] perf sched: Fix task state report
Date: Tue, 23 Jan 2024 16:38:40 -0800
Message-ID: <170605662743.1691877.1586103440745721732.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240122070859.1394479-2-zegao@tencent.com>
References: <20240122070859.1394479-2-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 22 Jan 2024 02:08:55 -0500, Ze Gao wrote:
> No functional changes introduced in v2, just got v1 rebased onto
> the tip of perf-tools-next for a clean apply.
> 

Applied to perf-tools-next except for the last refactoring one.
I'll test it separately.

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

