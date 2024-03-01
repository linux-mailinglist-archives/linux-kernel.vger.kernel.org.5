Return-Path: <linux-kernel+bounces-89025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE9186E99E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC21B28C23
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA173B199;
	Fri,  1 Mar 2024 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOfMQX4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCBA3A1C2;
	Fri,  1 Mar 2024 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321443; cv=none; b=bEMPHGKtsDMXEZ4qEgOkQjvohwYkYvZAMEzXBRj5TqJmBzXdOqdJ0C7rzOhzyz7YuSv68ZWZRuCpHjdVLWaRezyK9F5DDpNSrk5O+Ch10nnK7yz+epKeeCJQCP/taA83+IzUuePDcbQiuIXd+gvMeW5z6vtjafvVlWUGE26x40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321443; c=relaxed/simple;
	bh=2tiUMGVucLnTsfdQmtV4Q/wjRqqk/yhTGxrQh1MIwak=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gN8wiY/SpideqIhezHLMaPYpWGeorUNvzlYv0/2SVNoy7faxH2LM52nVOsxFA3gtKZPsLxvJnasYJLggXpAEcz0fQueK3J3OXGLxjnVbSjmqa72LAuS61DYERzfeJHbsgpw/n0Z9GF+ng4X+8pmi4P4l6qzblk0wdptObbyJmZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOfMQX4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC33DC433C7;
	Fri,  1 Mar 2024 19:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709321443;
	bh=2tiUMGVucLnTsfdQmtV4Q/wjRqqk/yhTGxrQh1MIwak=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=AOfMQX4a48hOiQtATpUXJXg8Ffm8UIvp3TBzML2FaepaEFuo0Ma1N4CoeuRfTaKsM
	 O8Ic/vhEf09LTzyBkOgLX+1J5Nfli+HujskJYi+DjdwtS12MIyqUD+Rjl18b9ZtXFY
	 rXSu4aZfAu2B/9m7KhFsw17hcOXONj0qiRnw43m5DVLrGM7SSeHQMlNoQM+BXGlSan
	 t0Em5IaW1/DfJopc8OSYvWCwHwlBML6M4/n6TnvHqFLfGKG+MDYoMexma6tQWoTegG
	 7CRnRzkWd97RVNlW8LW5P/NKTb+MC4c76x/OhgNtgBGmZZq2msm84jyZ5J3SueOz2w
	 6x/4KMcIzTYsw==
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Yang Jihong <yangjihong1@huawei.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v1] libperf evlist: Avoid out-of-bounds access
Date: Fri,  1 Mar 2024 11:30:41 -0800
Message-ID: <170932136988.3731358.14011113608352874223.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240229070757.796244-1-irogers@google.com>
References: <20240229070757.796244-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 28 Feb 2024 23:07:57 -0800, Ian Rogers wrote:
> Parallel testing appears to show a race between allocating and setting
> evsel ids. As there is a bounds check on the xyarray it yields a segv
> like:
> 
> ```
> AddressSanitizer:DEADLYSIGNAL
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

