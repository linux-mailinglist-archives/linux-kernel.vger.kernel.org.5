Return-Path: <linux-kernel+bounces-79242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C743C861F72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 23:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B9352874FB
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D47614DFE6;
	Fri, 23 Feb 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtIikt1L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB76714CAB3;
	Fri, 23 Feb 2024 22:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708726451; cv=none; b=CYUFM32UWVNHhn4Xi7neeNe7XXnapzvVXBXowL1kCihUap+RSFVXUSVtAeKXiuiYU1MNqY831AMdYRVfLTSaZfzCgXhMu5QkXsdmDV06Uoq79yIzudK8JIl6KbOdFdE9nnzHUOHj4kGNVF2aEhs2N+EAfEi7zBz5hGc8RP6/2DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708726451; c=relaxed/simple;
	bh=TpdIGHDKiBLkF+RxhpFOmgRov1SmClhrWulZMrP2Nts=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TKOwwWGzXZv0JRMdK9lGcsbtJ72mJpGIMspzgZq6KhIBdioClbS0grreOuqlptZyZBYuP0WskvsHLmQhzU2OdtoVEhVm0LA4WBUGpSJKNal3DT5CY3jOVAGqxsC0C5m2u2EDJcGnnf5y0f5cF+lSK4FgSPmU6KGXoKWYX/WwIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtIikt1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22D6C433F1;
	Fri, 23 Feb 2024 22:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708726451;
	bh=TpdIGHDKiBLkF+RxhpFOmgRov1SmClhrWulZMrP2Nts=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XtIikt1LiQ7Oq+XYnsYqUhazCT64NgcwoZ6Ja2kVpLmEceONbe1Tot2gtzHwA4zJT
	 sArrRepn+R7ctHwLAYWzFpjQrMdjqCCBLqVQ8dXLP79luqVW8mP4hIRiGWX92bhLsd
	 CeKwGu7gJODvEIHfVx7LCErAEqbZj/SvnJb6R0Z4jxeIjIZM9TmaJ9r4itsNYAoAJ6
	 /rr2RdVQ+1f6XvnGaM+RtPebfINkVQkxdCznaxXgtn2pEyh/bZYrGPwwOhnGCAVexE
	 nsmsqaZCGpPMIXVYsxssD35Rm6Uorb8kmZ7KJnjTQsTPkIq1NuodDyapT3XCpsmLQR
	 EYlks6iF/MUhQ==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	James Clark <james.clark@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	llvm@lists.linux.dev,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v6 0/8] Run tests in parallel
Date: Fri, 23 Feb 2024 14:14:07 -0800
Message-ID: <170872283709.3880577.13004256445870612040.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240221034155.1500118-1-irogers@google.com>
References: <20240221034155.1500118-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 20 Feb 2024 19:41:47 -0800, Ian Rogers wrote:
> If command line option '-p' is provided, start/fork all tests in the
> main thread and then gather them in order at the end. On a laptop test
> time was reduced from 5 minutes 21 seconds to 1 minute 50 seconds. The
> option isn't default as the test shows up perf and test flakes.
> 
> The '-v' option is modified so that 'perf test -v' will give verbose
> output only from failing tests.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

