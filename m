Return-Path: <linux-kernel+bounces-73925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B120285CDA4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:00:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D836B23912
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5515B5235;
	Wed, 21 Feb 2024 01:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZ1Kex7B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B1353AC;
	Wed, 21 Feb 2024 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480793; cv=none; b=Yqv2/9wwFtveUbJRMkTQkvCU50MMSRIec+WdJAa6gs6oKjG2fGfATwuqyhXdtqgWln7BwC6V5+LVtNPFjw0cayWfP8rU9G6sboUguzccFgbYA4aJ1/XiTXJSUbcXedPe/2XMxRofW+i3DStIrlGfs0rI2QECXAhfutPOK9TlxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480793; c=relaxed/simple;
	bh=sEkCxHX6RnAczbZivO5ymv01uGSyS7puhDorwgbbBbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PAZscqknEclF7QL1FhwQBzZ3B2YbvbdS1yClkGWtA6wVxqNmMIsPEhTLS73nWAJChwT4zUpts9ryMCHIA4dmc23uVx34zN/5BUHxhstsVXEpPiz3PwXMgeaJxaVnheTXzNgSp6uJqrY6/SrB1pXp3UvY0sGpilL0Qk1thPDn2vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZ1Kex7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B931C433C7;
	Wed, 21 Feb 2024 01:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708480793;
	bh=sEkCxHX6RnAczbZivO5ymv01uGSyS7puhDorwgbbBbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZ1Kex7BbWPkjHWC8fZf6PW1rYnJzz3Sqgpz77CtVwj5WhIsBJBcWGDLnTfy7k7Q0
	 l2c4YLtODQlIbNy/EHdd+TJtKuzxbJ79ZSPeaVViEvi+D8kHnFPVSP7gUicEL0hGMH
	 7+c4ceU9asQttKPVBLGv7qIh6dl/5Tw3ZU2YTOO0LlyxKzePOyEzgFGBHGTUfEQWjb
	 1YeRiNgRonvsUKlRk9Onys74vQrIEwtXoTfBsdkr6M/eHXDJzXMneHG9cJZbya7x8w
	 fAMkcmib9Jlie5k44idY71rx3fiw9VrNtXHRoz0K5fqZTwMk3USkUdhmfkhrETZMuJ
	 qa8bQFJ/UtapQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Samantha Alt <samantha.alt@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	linux-kernel@vger.kernel.org,
	Kan Liang <kan.liang@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Caleb Biggers <caleb.biggers@intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Perry Taylor <perry.taylor@intel.com>,
	Ian Rogers <irogers@google.com>,
	Edward Baker <edward.baker@intel.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v1 00/30] perf vendor event and TMA 4.7 metric update
Date: Tue, 20 Feb 2024 17:59:50 -0800
Message-ID: <170848061724.1313505.6465396484131071224.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240214011820.644458-1-irogers@google.com>
References: <20240214011820.644458-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 13 Feb 2024 17:17:49 -0800, Ian Rogers wrote:
> The first 12 patches update vendor events to those in:
> https://github.com/intel/perfmon
> 
> The next 18 patches update the TMA metrics from version 4.5 to version
> 4.7. This includes improvements to many models like the
> tma_info_bottleneck* metrics, an abstraction or summarization of the
> 100+ TMA tree nodes into 12-entry familiar performance metrics.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

