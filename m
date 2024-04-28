Return-Path: <linux-kernel+bounces-161335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8875E8B4ACA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86AB01C20E91
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2AB54906;
	Sun, 28 Apr 2024 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeiKV1ZQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DE54F95
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 08:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714294766; cv=none; b=pKqxeHifqCXj0YhRZGWv1aqE1fRaZEVvUEBEsVlgIOV6bD4WwpR57SNYisWwZynSCpAFxejVRsNqa5b3cZBUKz9OhImtrtbKGpVCCJySMNP3GDgzN+gLAO0RinimbhaBZr9wPacTFh/Oh6J4YDSjQTKoMhR+1heasPY4Y2VR2vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714294766; c=relaxed/simple;
	bh=moKPWg4HoUAMMWt5D3HgVlMGhsM0difbJWX0Jx8YfKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JMgNL5N+FSY+Ns+ySlkWE8HxF7YO9HVnuRgHVq3gscLlpxeU+hD7MyQewPZo3vLliD6T+/86LG8FJAoS8w3srPYJe1dG3rUTRL5+G13W8m+gC9fFBsYBIx0VyOsHGUTulKJ9kw/rcYt7YjyTAM6FYsfqUkjn3wpgPW8funLbQJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeiKV1ZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5899C4AF1A;
	Sun, 28 Apr 2024 08:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714294766;
	bh=moKPWg4HoUAMMWt5D3HgVlMGhsM0difbJWX0Jx8YfKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FeiKV1ZQaqmahoK/idO+spNXmFqG2Xc5HOhgLVNq/Anfk0ovMbLq3Z4/iZKwwo518
	 PJ6mjOz70rM1eY3nGgOVvAq51PxnuOF4bxwqADgRpoCq7kAo/hR9Ky0r5P3ZwEiZiS
	 V2F3uhv5NeS71YxFnscpczJ5PdAMLY5uWnuDUn5mSHTW89saiaJkwn0HAXVazkLjEA
	 5bafaH7jOkQ9FDWdHnLuoAXFRbFqtTGy1/PiuNpBcF138mT7bi9NCPOV4OT/ssywnK
	 K4IcaVFFJ5llVfg/mQbNxniZDA+N3hWq45ZfS6Sm/1qmukiu3xVwwhP/L5+Gi4ND5Y
	 PJXpSoXzNRmaA==
From: Will Deacon <will@kernel.org>
To: jonathan.cameron@huawei.com,
	yangyicong@huawei.com,
	shaojijie@huawei.com,
	Junhao He <hejunhao3@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxarm@huawei.com,
	prime.zeng@hisilicon.com,
	chenhao418@huawei.com
Subject: Re: [PATCH 0/3] drivers/perf: hisi: Fixed some issues with hisi pmu
Date: Sun, 28 Apr 2024 09:59:14 +0100
Message-Id: <171429057181.1717445.14884493742723500946.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240425124627.13764-1-hejunhao3@huawei.com>
References: <20240425124627.13764-1-hejunhao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 25 Apr 2024 20:46:24 +0800, Junhao He wrote:
> This patchset includes 3 bug fixes changes to hisi PMU:
> - Fix out-of-bound access when valid event group in hns pmu
> - Fixes the memory leak in hns pmu
> - Fix out-of-bound access when valid event group in pcie pmu
> 
> Hao Chen (1):
>   drivers/perf: hisi: hns3: Actually use devm_add_action_or_reset()
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/3] drivers/perf: hisi_pcie: Fix out-of-bound access when valid event group
      https://git.kernel.org/will/c/77fce82678ea
[2/3] drivers/perf: hisi: hns3: Fix out-of-bound access when valid event group
      https://git.kernel.org/will/c/81bdd60a3d1d
[3/3] drivers/perf: hisi: hns3: Actually use devm_add_action_or_reset()
      https://git.kernel.org/will/c/582c1aeee0a9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

