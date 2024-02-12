Return-Path: <linux-kernel+bounces-62258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6863851DA3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D08D28128C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8FE4642A;
	Mon, 12 Feb 2024 19:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTp+Xwir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAC40C15;
	Mon, 12 Feb 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765085; cv=none; b=EpJIuMGIq0jj+ZhHRBMOiRAEzNzV+FQQ6XPi01a/EPDJT6zL2Z1eQ9QjPN+r9bl01K7ukxCn+MFjlrVRP28bDNeQTmIODRBsDqZxtpXRylD09xbnk6vnGGodY3h0FpuMKsq96fgxIZjnBfJ86wBEg2hY8yZEL3JXdznourZK1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765085; c=relaxed/simple;
	bh=pjntRaF2ZUWt8qehOJs7aNCu4rWg3wEuvPh0NwqnyJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QYGHRtrOpBEJCPlKFOpvRCIc5+3uGxd9bd3Cr9xCdEd0Ht9W60meeV7dZ7qQqUjYjESfJkg13jTnLl9uhCEhPPuAm0m16lnNhHPwUoJx1teRBtJ3uEzYIaVKJSfBkbQLDOgxc9vWgBawM5J5S/592nLdrAs19vXV8ulVy7qC2WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTp+Xwir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C44CC433C7;
	Mon, 12 Feb 2024 19:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707765085;
	bh=pjntRaF2ZUWt8qehOJs7aNCu4rWg3wEuvPh0NwqnyJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTp+XwirSwdHzbf45kpucBQD0HIfaC92cmy/XEVivyxCi6XUM0/MhfcnOc24Hu3Xx
	 2gDWPZv2x1veS6rYfJRjr8hL/rXKukAuXFgom/vbpWDJ6jGhqNpjEdh2Od2/q5Z6yQ
	 5I0Rfd7l2RZ5R9W5SLxVqngs9padHVu4V7uAdAqYPKSoX9xwPAigIz6Bt3Pa5tXPdu
	 AR0FhBi098eU+gP9MeqkPabpxFgdef/R9e/MTZLu0h5SrUn97iSfwZp9ornDuwKAoA
	 pWbSg/GGC7LZ3LShgBsUe8HFvM2yZFRwJ+AidmcjMsfLW+iFCtYgwXTGDrHLLXnypj
	 EYIpV84mprUPw==
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com,
	james.clark@arm.com,
	Yicong Yang <yangyicong@huawei.com>,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org
Cc: tim.c.chen@intel.com,
	Tim Chen <tim.c.chen@linux.intel.com>,
	fanghao11@huawei.com,
	prime.zeng@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	yangyicong@hisilicon.com,
	linuxarm@huawei.com,
	Jonathan.Cameron@huawei.com,
	zhanjie9@hisilicon.com,
	21cnbao@gmail.com
Subject: Re: [PATCH v5] perf stat: Support per-cluster aggregation
Date: Mon, 12 Feb 2024 11:11:21 -0800
Message-ID: <170776504994.3461281.10666322368252974000.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240208024026.2691-1-yangyicong@huawei.com>
References: <20240208024026.2691-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 8 Feb 2024 10:40:26 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Some platforms have 'cluster' topology and CPUs in the cluster will
> share resources like L3 Cache Tag (for HiSilicon Kunpeng SoC) or L2
> cache (for Intel Jacobsville). Currently parsing and building cluster
> topology have been supported since [1].
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
-- 
Namhyung Kim <namhyung@kernel.org>

