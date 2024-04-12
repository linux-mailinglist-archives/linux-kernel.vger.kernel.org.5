Return-Path: <linux-kernel+bounces-143007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5038A3321
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C8EE1C21D6C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93095149DE6;
	Fri, 12 Apr 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsmLtJW9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6672149DE2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938021; cv=none; b=dtLx7e4vLbFOEeUrMAYrUr/2qq7Z8t0XDNC2s+BaxigmAjZTJe19VbBkXnsoTh7nWQ4jSi8JlTvCSi86FYHb23sTG0x1eQ7+fwGO6iHf0H+xoJDGL3F2TN9AnUANE5N/YBLfCSjxuQCxE8zHiXPsFP59qD6xzBMjuG/bvcE+cYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938021; c=relaxed/simple;
	bh=Kq2Qv5HKN8VTt0ixnatAxkoSanE29MgxLBoVDR7PqWY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ftXatXEehsDptSeDsboibUBg8vQJMIY9SPqKxA9agBNKePF5++K/mi/i98+y6OMkWiPT8USZdwXtm463ipyA8D0fERbQvvcZRrvOv80iqI8luszX3q6JSs5mh0qqnn/NAyBsj6p7K8pisY+ANXqWP+/b9w1oP+TvqugeOc2dV3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsmLtJW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2377FC2BD11;
	Fri, 12 Apr 2024 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712938021;
	bh=Kq2Qv5HKN8VTt0ixnatAxkoSanE29MgxLBoVDR7PqWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gsmLtJW9LTMwyOItD4ObLaKXkh2lfqifIDB8SftWrBMw9G5Yc5SKyoEyBqdEijis1
	 RHJx1UXz0nG3E5XDBR9fG3x4RcFxUGHMrAsXYibTEEM8ZQ4EF/Jw8ClIOh/L79CdeT
	 2xaRmoQbU0QaY6RNzeJ8qen22yv2S4sUMWHfNljofJhd2GKSRipZhhjBU9UQkiy61B
	 5WKomkGPY4CtW16Kb8lF9q0zxEjq3w+XY0D4nXzKsX6uLYu/NdbBsbLytk8sjdr4T5
	 fMIfKQVSZK3DyI5XnTvSsQR3raR4OhKoeCylRVwJlZWc3QG7A+Vy0hEelMAL28Vglt
	 Zb/R17NaS9Sww==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	catalin.marinas@arm.com,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yicong Yang <yangyicong@huawei.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	jonathan.cameron@huawei.com,
	prime.zeng@hisilicon.com,
	linuxarm@huawei.com,
	yangyicong@hisilicon.com
Subject: Re: [PATCH v2] arm64: arm_pmuv3: Correctly extract and check the PMUVer
Date: Fri, 12 Apr 2024 17:06:43 +0100
Message-Id: <171292289666.129267.8434461494891295538.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240411123030.7201-1-yangyicong@huawei.com>
References: <20240411123030.7201-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 11 Apr 2024 20:30:30 +0800, Yicong Yang wrote:
> Currently we're using "sbfx" to extract the PMUVer from ID_AA64DFR0_EL1
> and skip the init/reset if no PMU present when the extracted PMUVer is
> negative or is zero. However for PMUv3p8 the PMUVer will be 0b1000 and
> PMUVer extracted by "sbfx" will always be negative and we'll skip the
> init/reset in __init_el2_debug/reset_pmuserenr_el0 unexpectedly.
> 
> So this patch use "ubfx" instead of "sbfx" to extract the PMUVer. If
> the PMUVer is implementation defined (0b1111) or not implemented(0b0000)
> then skip the reset/init. Previously we'll also skip the init/reset
> if the PMUVer is higher than the version we known (currently PMUv3p9),
> with this patch we'll only skip if the PMU is not implemented or
> implementation defined. This keeps consistence with how we probe
> the PMU in the driver with pmuv3_implemented().
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] arm64: arm_pmuv3: Correctly extract and check the PMUVer
      https://git.kernel.org/will/c/b782e8d07baa

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

