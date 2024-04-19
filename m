Return-Path: <linux-kernel+bounces-151674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB7428AB1E6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E3B28313E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B950412FF9E;
	Fri, 19 Apr 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0MlU2GV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25BD12AAF4;
	Fri, 19 Apr 2024 15:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540793; cv=none; b=F9Yxr3IA21v5XVuQ2PDsg7eJ4Go7yhDirtiXlqXoTqIOe0Mwj2g8vic9Jy+LqvJCR6KEJwRbQZWETAacMhIZXK7uobom3N/5wQM2REOvvlAqKCWZYtcQPOe9XOMsYStldj8vhBxgT9laL5hWUEJqrLVaHyl7QfyrSEWe4xziHf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540793; c=relaxed/simple;
	bh=0O8rL07X4cRDqlk5nyVo8fbFX9mlJwFUGy/DUqJy5B8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YgqcTKEr0zi9EvW+AGth9Hb/TgmQk4z3L3z/OqAIiM+y8XglqWPBlHBwNekUopmyGKky3srw7yGfhQZC5+spy8w0J4HqGf5tGJwTcZ/C155QFutZAgdcLK8mQuSdp5Y1Rm9NuFiCZ4zMkx30kfhfGH/6oWVR8AGhP/ImR5Sh1WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0MlU2GV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14517C2BD10;
	Fri, 19 Apr 2024 15:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713540792;
	bh=0O8rL07X4cRDqlk5nyVo8fbFX9mlJwFUGy/DUqJy5B8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T0MlU2GVClmAuHg76TKlYktuGHJkoM5RCSUmjrHQce6VPKYhZKcvJd/s0rHruCwbs
	 Rm7e8VlSRUDH1O5YvHiN0Rg8IdzbOBaiZ4guzCLJtQGF9eknIXgIl80WgnGGT5P5kS
	 Gdn/IJfTbCrPNJtthaoufwKzFGImAUd6ndpbxXPcVHTGUsFsZQ+yB6aq4d10rvbGhM
	 +LHVlDlnJURnUcyZ8D2uNRbwTZr4RQQ1sHL2pPe7rGFfLO/Ht2fHlk84G95tVJY7Nc
	 /EbQseko55FOgJAD94K7lsofotYa/L+xiwXDJegzgy316L/GedTGaUdNVyEyu0QinB
	 w9yZq1gfgT4QA==
From: Will Deacon <will@kernel.org>
To: acme@redhat.com,
	catalin.marinas@arm.com,
	john.g.garry@oracle.com,
	james.clark@arm.com,
	mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	alisaidi@amazon.com,
	vsethi@nvidia.com,
	rwiley@nvidia.com,
	ywan@nvidia.com,
	Besar Wicaksono <bwicaksono@nvidia.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	treding@nvidia.com,
	jonathanh@nvidia.com
Subject: Re: [PATCH v1 0/3] arm64: Support Neoverse-V2 for Perf Arm SPE
Date: Fri, 19 Apr 2024 16:32:57 +0100
Message-Id: <171353423620.13067.5339491128253092613.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240109192310.16234-1-bwicaksono@nvidia.com>
References: <20240109192310.16234-1-bwicaksono@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 09 Jan 2024 13:23:07 -0600, Besar Wicaksono wrote:
> This series support Neoverse-V2 CPU in Perf Arm SPE.
> The first patch adds the Neoverse-V2 part number in kernel header.
> The second patch syncs the kernel change to the tools header.
> The third patch adds Neoverse-V2 into perf's Neoverse SPE data source list.
> 
> Besar Wicaksono (3):
>   arm64: Add Neoverse-V2 part
>   tools headers arm64: Add Neoverse-V2 part
>   perf arm-spe: Add Neoverse-V2 to neoverse list
> 
> [...]

Applied arch/arm64 part to arm64 (for-next/misc), thanks!

[1/3] arm64: Add Neoverse-V2 part
      https://git.kernel.org/arm64/c/f4d9d9dcc70b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

