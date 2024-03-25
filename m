Return-Path: <linux-kernel+bounces-116440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD45F889E74
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91D3E1F37A25
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9025A44C73;
	Mon, 25 Mar 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXKzRGUZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4780229D69;
	Mon, 25 Mar 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711334429; cv=none; b=VnFs+MrpLAvZgjcsqUQRwsdOhTva/qCaaFRvWIwfaHsVC0nFonreB0ZKt/bdqmeolH/XKn2p84RFOBi2wlx6PnKwppM0v9Ps753DV6uSVAmigEWfM/WPxmr3XLhibKVpFN8FB1OXq3vaUiD+17RRMJXAUh/Xg8OaXUQdPRclwjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711334429; c=relaxed/simple;
	bh=a6o0x0cn8UUWF8IiBFE8IjvcWmSjhyg4QzAPtf+k3zQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MHZRQA9FYfQxyC5fdvT4/Ce9vob51Q6ITLAx+pipcqi40i0R8Arim19tafa7A3GD3vfs6WIuzNEhAUWvhHLYZhorPVJPJ4WskJ6wv6Yr9nYolhb/DP/LIm7Wf9PDdwUmdyx8ZfbJVtaXbPFkDhEwRUE1KpkZ+JbpE3uUpbynDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXKzRGUZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FB0AC43394;
	Mon, 25 Mar 2024 02:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711334428;
	bh=a6o0x0cn8UUWF8IiBFE8IjvcWmSjhyg4QzAPtf+k3zQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oXKzRGUZrsUezrRY4ojSaktWJPd4nySZTX249T7fZxdNxmseFhGvYQ+NhGylQDtU+
	 1hIsl7EPRQbo50YQcRZ6BW/Opwij8Rt07l7G0czrcM/FgDW4daUPiBnP/rn06A7rn0
	 z0sNJqpc4j69ys3BqI1k/CY9RmH+Zz5l8v2xUTviPRloRZB+UaFixm311YKRzDCha4
	 SBj4Jn3jADBN4DqRqw7uo7Dsl+IjawOFvO9RK/PdC50kG1a364a6I2bW5J8GmY2NxQ
	 vWLBjFE414DMKZrL4CM4UFGgKNWZyihy/19i7rDgtsMXK+EPzqFgEhPLewDLy5cY+M
	 ax2Ub3wGxte8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42100D2D0EC;
	Mon, 25 Mar 2024 02:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] platform/chrome: use sysfs_emit() instead of sprintf()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133442826.31480.17940865345620526235.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:40:28 +0000
References: <20240314052828.186924-1-aichao@kylinos.cn>
In-Reply-To: <20240314052828.186924-1-aichao@kylinos.cn>
To: Ai Chao <aichao@kylinos.cn>
Cc: bleung@chromium.org, tzungbi@kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Thu, 14 Mar 2024 13:28:28 +0800 you wrote:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: Ai Chao <aichao@kylinos.cn>
> ---
>  drivers/platform/chrome/wilco_ec/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1] platform/chrome: use sysfs_emit() instead of sprintf()
    https://git.kernel.org/chrome-platform/c/f7496450528b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



