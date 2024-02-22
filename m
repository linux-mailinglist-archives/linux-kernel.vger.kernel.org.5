Return-Path: <linux-kernel+bounces-76908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FDB85FE7B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B59A1F28220
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860EA153BFD;
	Thu, 22 Feb 2024 16:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0Wh3HJi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA756153BC9;
	Thu, 22 Feb 2024 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620804; cv=none; b=XJz1z1rPCCcz5e6y/iZLlj7aowdRT28TEf1XL/aFWQOzM0VxtrJjOCi+2OcK6wgfWxGYBNPBi7tu1FCncBAvreRFOEcWwtQusqROM+NvCwHDyqPPAxVQr0Zhw0Ag2gUMbBoUUcyCTw/apOWrNL45btYR/+9jxkpiSaWRPKzrUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620804; c=relaxed/simple;
	bh=9Ux3/1Qnwjn25pAAnhZvRLEmk9F6Wz6WljZVmjWNokE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OAV1fVLW+TmCDKLHAD10kUBuhKBbkzfTuWMY+FH5Yf/xEZIaibohSI7q5dZhXu5DJK0QuksVKtmMgP1Z37XGU7JATCbGfRNl3lqhzgUlEMfH8kgRhxt1SFdGEVezj9Ep68k6/CBcjf7iau9wy1nDVWHFo3MCvkpoxEqiUb0zeFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0Wh3HJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC37C433C7;
	Thu, 22 Feb 2024 16:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708620804;
	bh=9Ux3/1Qnwjn25pAAnhZvRLEmk9F6Wz6WljZVmjWNokE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E0Wh3HJiRvTyY1Et+pZBgl3FkA6p/dz7m7xrQjJ4ZRZcqFSejXZoLI9scHWFoHPHU
	 0MP/WayrcNjgBGr4e5BLrz9OFuHc7oCEvHJ74RmBCXvV8BQfdn9f1Cpv8Hcephh+Mx
	 j9r3y8VLmUKMWX4pU+jrcxSQsXQZM2MVljvMdavvldGARq1/3NDh8kf8umlXj0llAm
	 gGWx3T7G4fpa7080Z1JucwOJNDY7oyKntFwIsZiNW7XtIYC52Be6XO0wJPjXvw1gng
	 +XvXryHdTllppvr074uRizGIXlJFryEw5gikDwnBhIT9qORgg19Hlg4OEbrhKhtDtA
	 LNi59L1BCxE3A==
From: Namhyung Kim <namhyung@kernel.org>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Changbin Du <changbin.du@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Changbin Du <changbin.du@intel.com>
Subject: Re: [PATCH v8 0/5] perf: script: Intro capstone disasm engine to show instruction trace
Date: Thu, 22 Feb 2024 08:53:21 -0800
Message-ID: <170862076568.3024784.8799548310369120740.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240217074046.4100789-1-changbin.du@huawei.com>
References: <20240217074046.4100789-1-changbin.du@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 17 Feb 2024 15:40:41 +0800, Changbin Du wrote:
> This series introduces capstone disassembler engine to print instructions of
> Intel PT trace, which was printed via the XED tool.
> 
> The advantages compared to XED tool:
>     * Support arm, arm64, x86-32, x86_64, s390 (more could be supported),
>       xed only for x86_64.
>     * More friendly to read. Immediate address operands are shown as symbol+offs.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

