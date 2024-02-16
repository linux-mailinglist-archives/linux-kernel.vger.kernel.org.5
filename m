Return-Path: <linux-kernel+bounces-69256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AE885864B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277BB1F21C22
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7B5137C3B;
	Fri, 16 Feb 2024 19:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CovL0agA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AC433B0;
	Fri, 16 Feb 2024 19:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112539; cv=none; b=IGDy1QHzvmHA+DjNKEONwd3sskqu8OleoCYGEeA/7nteuJFSJHGoPgAY13NJilOW+2VGOJfpEoihWcGt8aKKBNvBH9/jZS+fpjCWRtq7/Dcrw+wMZN3nDpMI0/dDQtSA7upXR3y7BDtaGu0Onu4iJZBFJNID9XkoXAvYzsvgYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112539; c=relaxed/simple;
	bh=KVmXFaHE4oIqgJc2d6YPE7Mz/FJk0hdE88KLQxKmCPI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZdYU6Xi2Prq5kxgzcN8DU7inSqGlp8l988egyMTHz9I0i+XG3eSu4gYDxjXkRnhn0NkjEJdm7lnvW8DE+iSMh5gF5/Ymx7b0ejR+CO/zTxKuNrIeDXP+DHrWYnlVkgCg/T5xGKYiYq5NW+j95m22adFumG3B4I6v0IggDyztfjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CovL0agA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48F3C433C7;
	Fri, 16 Feb 2024 19:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708112538;
	bh=KVmXFaHE4oIqgJc2d6YPE7Mz/FJk0hdE88KLQxKmCPI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=CovL0agAKpy5rHJIW7atRNSaUKxKl3AjzFkUG+xvtMeybgZ7TKafYEFnsRjM9tZU3
	 p9bl2Gph2fOIPs7k2Hgby6NP5H85CixK4wqPJ7rYwXlrpsFHZGrYvyjja1QI3/uOf0
	 A9Ct7waEyoHrLvDLwbsz5i5IphS888nXJVwkYyQ9Paf7afqnSKL9+sdxZjZkGP4VvB
	 Dmwft2BU214hO+zreW3L+UKVG57Kr2cfiUawPH/kHEo2thoMXz6TNHB+5cM/Lf8M4l
	 mE+7huLG6N0cNmzyG0RsFRUJ/xp1RhbEAlAfR00OXG7r0YquHz968gHxr8AfYV6Tk4
	 RMIpbJfGwdAjg==
From: Namhyung Kim <namhyung@kernel.org>
To: John Garry <john.g.garry@oracle.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Guo Ren <guoren@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Mike Leach <mike.leach@linaro.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@arm.com>,
	linux-riscv@lists.infradead.org,
	Ming Wang <wangming01@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Will Deacon <will@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v1 0/4] perf parse-regs: Cleanup config and building
Date: Fri, 16 Feb 2024 11:42:14 -0800
Message-ID: <170811251451.2464880.2005329121787723704.b4-ty@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240214113947.240957-1-leo.yan@linux.dev>
References: <20240214113947.240957-1-leo.yan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 14 Feb 2024 19:39:43 +0800, Leo Yan wrote:
> Currently, the perf building enables register parsing based on the
> target architecture has supported register feature.
> 
> Furthermore, the perf building system needs to maintain a variable
> 'NO_PERF_REGS' and defines macro 'HAVE_PERF_REGS_SUPPORT' for statically
> compiling the tool.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

