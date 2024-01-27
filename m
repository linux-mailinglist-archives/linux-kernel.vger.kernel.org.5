Return-Path: <linux-kernel+bounces-41353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 571DB83EF71
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED2801F23A4A
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB802D634;
	Sat, 27 Jan 2024 18:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNZG0xgF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793442D60B;
	Sat, 27 Jan 2024 18:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706379437; cv=none; b=kbRgsnd4t3Zs/7o3eDnFIDiSzaad1q5W6ZY+aLmCvfTNA0oPHJCvMuQ4dg44wLHf/D9/ucSRem9r5zVEn29Au2g71g4iPpvux7h7WQm3ceaRcZ4VgsOpVrUYVh3mD2wFK8bPg1vcp83Du8aash9sizJ/yvjcYvsdTofQq/1Y2Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706379437; c=relaxed/simple;
	bh=Utq9tio4RWPPxgl5I4Nc03H22psTj6k7Wv36MjSGEEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDKUBIELs8174eQJf+ls/gS1drGbRYrB75Kx0DbDjth1mZLMNVEkztfsYHMYsEfYKBu2KaIE8AkhOTDxOEs/1JKmJpWeBshTTF9SFyAcLVhRJbwx2N1cGEHqVvd29CcCERTvT3YmWvJy79QhVhnzHlSVfl1s40tOIw9x2jPntqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNZG0xgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF8C433C7;
	Sat, 27 Jan 2024 18:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706379437;
	bh=Utq9tio4RWPPxgl5I4Nc03H22psTj6k7Wv36MjSGEEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNZG0xgFq1Fh4aH3gi51Ppp15guU5PVmcT9XbUhIUIUoW/9ltcsOZeKEAZ1Jvmau+
	 UuPn8XDtX3yWqxJsM82FDOavdt+4WXn6R+X9ZF1I+kBe9OHC4L8EcVVhQoZxNww+RP
	 D7yHBCVbVrY162iyLCQ3MIrjihpQeFza40HxBtd5kCzpzdNzSZ1iRCgFm0BEifO8R+
	 ngCykJT1NIxKLLl33wjmwnJCAzdKfynyutVMiqvcIq16ET/E/ts+02yWBlLgTz3Jyz
	 K8LXDk8dbL3K7ArguapjRMlVhMx+6MXVoWy8o5Lf1ZClYiXnUXc7M/qehC3kAznJ2F
	 BcWO28MmFbsSA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH RESEND] perf tools: Add -H short option for --hierarchy
Date: Sat, 27 Jan 2024 10:17:14 -0800
Message-ID: <170637928211.816351.10097608257207338601.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240125055124.1579617-1-namhyung@kernel.org>
References: <20240125055124.1579617-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 24 Jan 2024 21:51:24 -0800, Namhyung Kim wrote:
> I found the hierarchy mode useful, but it's easy to make a typo when
> using it.  Let's add a short option for that.
> 
> Also update the documentation. :)
> 
> 

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

