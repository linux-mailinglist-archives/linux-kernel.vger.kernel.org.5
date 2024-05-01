Return-Path: <linux-kernel+bounces-165733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BFC8B9059
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 22:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3414F284983
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16BB2163AA7;
	Wed,  1 May 2024 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOB6p/3E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4354F161935;
	Wed,  1 May 2024 20:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714593633; cv=none; b=FODFdUMmRNadCTmsIYXL2zv+sqGRveJq+lkVObRgFrZQVGCgMn7jU3/krWDunNSefDFeNJsdMW9nDlwc80OHWG4UzQBzMjN1vXTUpbzOW7+vdmYDMkyWSr4ANFtAxcxt2BbW4y99d83kBNo9g8C/W5aUmT5Bz+1ozZ4Mj8tQFCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714593633; c=relaxed/simple;
	bh=YKtZHOVcfK5pZifTsmCfvuROX7xhfvNANJSNxpShWXU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EPBlZuAQnmWfTxXjra2rmwcoj+rRBrBLs7MOJ3FQ6Cs6YCp7zbhqVTjWtB89d0jryYkqJB8eKcPqINE0E49xA+cQSdT9MGF3XXG1lnziHqE5HkjsStE+ddcI0aykh1YLDdM8tKswCODWHGxWVvn4w5HTLVywhwXmjsqoQjbTFc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOB6p/3E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DF878C4AF1A;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714593632;
	bh=YKtZHOVcfK5pZifTsmCfvuROX7xhfvNANJSNxpShWXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rOB6p/3Elfv1x7wXeXd3ApGYwjld6NKQoaTsTJiBwD7skuvvcIT93h1/RuAU7SkW6
	 TA0KcGHZhARxdtFYgpPawmQXy9mnxwE1PlqNLsIEs3I4fQf1tNcoDl6onX5m3l1ses
	 9lNCtgeofn8JC76Owtue9mXrcTIUOfy9634GSL8ZfL2FtAh4I/fTuQaiYh0JDEC7ju
	 monnyF/9FLnT55sKJ5HhTqt6UIPAbeNhwymkl5Tf+HnhMvC8niv0cL6f65yd1/FnTB
	 01ax01OdiSSy1VZNxBt27+zWns5D2cjh5n228Ho/zdcjSO7MeiShYMMJyzi1ePsgtb
	 0wW6xDXkwEjgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CF892C4339F;
	Wed,  1 May 2024 20:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][next] Bluetooth: hci_sync: Use cmd->num_cis instead of magic
 number
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171459363284.6729.3328094972268043156.git-patchwork-notify@kernel.org>
Date: Wed, 01 May 2024 20:00:32 +0000
References: <ZjKAyg2bZNyTcT+C@neat>
In-Reply-To: <ZjKAyg2bZNyTcT+C@neat>
To: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 1 May 2024 11:50:02 -0600 you wrote:
> At the moment of the check, `cmd->num_cis` holds the value of 0x1f,
> which is the max number of elements in the `cmd->cis[]` array at
> declaration, which is 0x1f.
> 
> So, avoid using 0x1f directly, and instead use `cmd->num_cis`. Similarly
> to this other patch[1].
> 
> [...]

Here is the summary with links:
  - [next] Bluetooth: hci_sync: Use cmd->num_cis instead of magic number
    https://git.kernel.org/bluetooth/bluetooth-next/c/39e4d6fb881d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



