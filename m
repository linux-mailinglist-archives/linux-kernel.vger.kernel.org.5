Return-Path: <linux-kernel+bounces-90808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAF6870544
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9859528B93C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B9F34CE0E;
	Mon,  4 Mar 2024 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TFeguyTC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2E47A53
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709565480; cv=none; b=kXBttwo8AGjjORMLN8DlZkSNZtg/ns20ie3WZJpzPdqG7FYUJZKyvpOvAnRxVx6S+wy1FO3ymgdJwBfvdUaAY6JIPLNcQrfEkuHaaA0hUkAu8YDpiCfIiSZniSS9Zc5Hv/tGa7FuwoJ8XYAPxdOKsWvKWjAOcimzc6/d33N+mPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709565480; c=relaxed/simple;
	bh=iGWbUOk5sz0iDpW3B82/sofcD0oPQ1Xbh0eWrmMSxY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irvvp/J2p2lJ1sLILZk8p8VrRGhUCBUuOoeQVdaoBeJgry39qlcGDuO6XSNPwqnekHi6mkQAy2bDjtsbRx5wh/VDInss8cgVJhMuXUf/oXB6tXLKcmkye3E04b8pwA28R+XpRwiw3YDoeq/oyuJsePVRhoF79bl/N29sS3FYE0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TFeguyTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D3DC433C7;
	Mon,  4 Mar 2024 15:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709565480;
	bh=iGWbUOk5sz0iDpW3B82/sofcD0oPQ1Xbh0eWrmMSxY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TFeguyTC15cxK21YQjVHSDyeg+o3Q9jotEJ61XbgFN4Lr9b87y/9AdYAsj04TLEey
	 h9CoHo5gp70vMoleSQYcnR/VJLTdt8tYulpp46aM2SHIoyxRd0VWv7hTnDRGVpvygH
	 48W3g6orXv1ntxwEOmFGpwQvabjlZg8VgCW9RpXJgx/hGkX/g2Sn20D0xhCaZF5Pxf
	 t1lpKk5JFo5Se3aKGNwDMciu0WwrtomB+eReeHAF4mXgcbi3ThxAVBwshF0qexjdxG
	 p8wybImqoW1UyZiYi50A54aFEfrOHiqZzhGUhKaeXnrzYuc6hDP9NzenfXZkQauntt
	 CUATwdMkXXVQQ==
From: Will Deacon <will@kernel.org>
To: jonathan.cameron@huawei.com,
	Junhao He <hejunhao3@huawei.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxarm@huawei.com,
	yangyicong@huawei.com,
	prime.zeng@hisilicon.com
Subject: Re: [PATCH v2] drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for HIP09
Date: Mon,  4 Mar 2024 15:17:52 +0000
Message-Id: <170956177083.3267340.13885181696312614288.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240227125231.53127-1-hejunhao3@huawei.com>
References: <20240227125231.53127-1-hejunhao3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Feb 2024 20:52:31 +0800, Junhao He wrote:
> HiSilicon UC PMU v2 suffers the erratum 162700402 that the PMU counter
> cannot be set due to the lack of clock under power saving mode. This will
> lead to error or inaccurate counts. The clock can be enabled by the PMU
> global enabling control.
> 
> This patch tries to fix this by set the UC PMU enable before set event
> period to turn on the clock, and then restore the UC PMU configuration.
> The counter register can hold its value without a clock.
> 
> [...]

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: hisi: Enable HiSilicon Erratum 162700402 quirk for HIP09
      https://git.kernel.org/will/c/e10b6976f6b9

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

