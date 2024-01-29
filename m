Return-Path: <linux-kernel+bounces-43470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D200841452
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:30:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC58A1F23AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AAF2158D71;
	Mon, 29 Jan 2024 20:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLlFbQRu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BE0157E6B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560171; cv=none; b=LnA/qH/Xaxu37W05hT8n0JpjRft88Ijxtp/TTHndh5RuL97vjFyXfEpDeu7UbPdOg56n/nfvrxzEo6suK+jn70wyeCRAFWKeVlYhtTOjOG327PY5JrfxQEr/4kkguQ72eM8EQIqnKadDU2x08Kr4SLyZGYVFYCCBnTkMXk3C2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560171; c=relaxed/simple;
	bh=Q2PS2lZlOGrrB/bPRS9SVGx50bnEePqslt7qVPvTqkk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eevsYGHcJRoG+vQ+F67qnUM0xOwYIrSqZ5tQx4AdDHVAfBPqbc2Nyjzz1FmEw6pXkVCKTv5XHGFZ1yA0X96fpWTKodQOvbcsknBOXsP1aXXZmGaIRe6FctzVbHqJAXnFo+kCJ33wPfJtvUNH8SZPhpkhg/4ZQ7BLhIf5WuVrLIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLlFbQRu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E81C0C433C7;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706560171;
	bh=Q2PS2lZlOGrrB/bPRS9SVGx50bnEePqslt7qVPvTqkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DLlFbQRueLvaM92KSa8aniBK5Gv7KaHB5WWk1W1L+ucr6y4bLJ32QLa1xxHezm3Nt
	 2MjVcET8vyhIkNcCRozyl3VJRhN3qp5wG9JRHUE9XTG/+cTVB760pYFj2KE02A3MWx
	 cb/p0xvOhAk5Kjlb2fYzwGcx/m/WaVigu1JlYTtWmY9RpMKeJyHenmAcI6mhxEYBhy
	 Xd63Bf5sfsotMyg4MYgSRrIUz0CWFugghUrXAf7sWcLQWwSEhe2ccOMdjlTdq+dPBf
	 ErEyvkXQEcBcVn7OENzLPjK208UZ/hCtXRQdz7yRImDV3y6LqVemBocaJ3BNTLgRSZ
	 2LdtlMhv7lZSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D27C9C4166F;
	Mon, 29 Jan 2024 20:29:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: check free sections before disable
 checkpoint
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170656017085.16041.11567801546674226632.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jan 2024 20:29:30 +0000
References: <20231229032507.2016012-1-bo.wu@vivo.com>
In-Reply-To: <20231229032507.2016012-1-bo.wu@vivo.com>
To: Wu Bo <bo.wu@vivo.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, wubo.oduw@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 28 Dec 2023 20:25:07 -0700 you wrote:
> 'f2fs_is_checkpoint_ready()' checks free sections. If there is not
> enough free sections, most f2fs operations will return -ENOSPC when
> checkpoint is disabled.
> 
> It would be better to check free sections before disable checkpoint.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: check free sections before disable checkpoint
    https://git.kernel.org/jaegeuk/f2fs/c/e2f29120ff1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



