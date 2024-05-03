Return-Path: <linux-kernel+bounces-167690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A5B8BAD78
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32AFB1C22067
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05CD15444B;
	Fri,  3 May 2024 13:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMgF+XHk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B515442F;
	Fri,  3 May 2024 13:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714742130; cv=none; b=adHzu++1EwoH4JV9LkHeXzj1n84+64KdPRpdXSf7fKojbJl8tkI48BzNVgQM08z73kM5k61Lnt3BdFL1Koqu44Qg9DkpBzGJVHc6Rdez+6QDz9qZZmgiyghUiN8kzbsPj3ButMM+3mvpNPekEBh5W9AxYTTb6bE4x8cfdBzxKH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714742130; c=relaxed/simple;
	bh=u7OhV14b+KvvL/Ob6hW0mx28C4XmQQk3bSQXLrG+R1g=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=Fb4G9dMIPUz8HVZnrVQcvqupKJxIRhmqyGUuCsGRpAo4427kvG4dBEvZU4unuCPm8PNoVVYILQALrc9/FBeyr7rH5ELD9xyI2RiAzoVu8wvvu812sysTdDJ1w80nlx5nTy4PdzzMj2cPGi0thzHPHaajRiaCNRlpQiSPkDfW70M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMgF+XHk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C9DC4AF1B;
	Fri,  3 May 2024 13:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714742129;
	bh=u7OhV14b+KvvL/Ob6hW0mx28C4XmQQk3bSQXLrG+R1g=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UMgF+XHkCoWysTyGLbnNRboqoX82pBZjHq8IISsbQmKwb5+lz58zNVpq6t6zv9b8l
	 2yaWIOPp89LuHIkKP9PCcUmyoY59voKR9wOPjUIm87jdE0jkhrmkTkuJk12oMYV5Er
	 ekmjuSPQrZDSCbd/TNlLNKzar9aesWO49u5WOWLBwPSu/IrF66f16F/xA5fzbVEfgU
	 2PyoozYi0OAdoiFeIDTI8jZdYhHyZZFqHSSakr+aZSTbhVmSC//38jPuaeUMhuHFzP
	 58uhFZFU67uwhluWGQnlPHpX3HcBSv288izLYJVZlg10gBh6PpeF8u9ev6/kEDJySG
	 5IcYCl1Jd8wIg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath11k: refactor CE remap & unmap
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240430-ce-unmap-v1-1-e468328f95d9@quicinc.com>
References: <20240430-ce-unmap-v1-1-e468328f95d9@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 Jeff Johnson <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171474212652.1512332.14638586836562362719.kvalo@kernel.org>
Date: Fri,  3 May 2024 13:15:28 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> Currently the logic that handles hw_params->ce_remap is inline code,
> both for doing the remap and the unmap. An upcoming change needs to do
> the unmap in a second place, so refactor the unmap logic into a
> separate function. And although it is only called from one place,
> refactor the remap logic as well to have functional symmetry.
> 
> No functional changes, compile tested only.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

8b9ea752a9d6 wifi: ath11k: refactor CE remap & unmap
c57d00a4d3d8 wifi: ath11k: unmap the CE in ath11k_ahb_probe() error path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240430-ce-unmap-v1-1-e468328f95d9@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


