Return-Path: <linux-kernel+bounces-164869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586348B8437
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 04:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4651F23527
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 02:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9959C1BDE6;
	Wed,  1 May 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjVQCce/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD2B18EBF;
	Wed,  1 May 2024 02:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714529433; cv=none; b=JUNEFWYXUSBnrg7yENfgfpguZjpZASKAtEd/KDd7e5oI/p3qiYTwa32NZTQC48ekpXuFJT+fR6QJ6o0BfeT/VdpDcDeFwz8rFWo3878oiqjbvRfhnEpska6HGzG7/B+0Ad80shaa1DLYcctlFvfIPw/3UADlh2p3cfpwlgI1pNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714529433; c=relaxed/simple;
	bh=kPMLOGmsDbAquSqDz0H95AiVcHWqf671Pp88X9yzvXY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lydxyAXHqqHTsPtN6SDN5GT9r0aj3rWp/5tKlFuuBlXiUJZ+GohyjimOz/TMbdBPl0xzgX3AV4CcRxQ2nLtQhEhZ37hzTKsMltdRZl0/qvdmOi19MYRl1esrgccr5AdFbwMOliAP/lrrPc+RKUBUy5AIXpjldTscXfkhNRCkWW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjVQCce/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 447E4C4AF50;
	Wed,  1 May 2024 02:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714529433;
	bh=kPMLOGmsDbAquSqDz0H95AiVcHWqf671Pp88X9yzvXY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OjVQCce/RSaC+Dj0t0SZ5Zie+eD4nkDZNDSMjd4c+8dyRzN2q70sJvo31pNjVFLWl
	 V1deDJD4fmSEq+Cy8VZlTGdPfGNoo8Snehcz73nnssCD72L9pWNU7IUzDjZEzDahAp
	 bxJma3KvG2wOdyg6vTKfnBdMbtThGolXjMYsUfr0ENYA7iK0onbbmB22Yy6yeXLgPV
	 M85tKC6ftQKk70tv/BsU2sKAQJJtWDBAf8bEXRq2P7UREKTHu2M7hwZcsFJqBX6yQb
	 jCTZfTmIZcazwM3jCR3MROtDYfU53GhYxcb2/c5LDKkMivDLZxR/MjgPwV0h6x9ERv
	 ZZA3xXbRKcEJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 388BFC43443;
	Wed,  1 May 2024 02:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: msft: fix slab-use-after-free in
 msft_do_close()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171452943322.31721.8564512267208580003.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 02:10:33 +0000
References: <20240501014335.2329860-1-iam@sung-woo.kim>
In-Reply-To: <20240501014335.2329860-1-iam@sung-woo.kim>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, benquike@gmail.com, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Apr 2024 21:43:36 -0400 you wrote:
> Dear Luiz, could you revert the v3 patch and apply this?
> 
> Fix the use-after-free bug in msft->data by tying the
> msft->data lifectime to hdev.
> Also, change msft_unregister() name to msft_release().
> 
> How msft is used after freed:
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: msft: fix slab-use-after-free in msft_do_close()
    https://git.kernel.org/bluetooth/bluetooth-next/c/c2d3fedad3ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



