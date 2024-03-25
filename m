Return-Path: <linux-kernel+bounces-116521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9CB88A04E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC7DE1C3743D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4140313E41F;
	Mon, 25 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkhhEapM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2FA1C257B;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341756; cv=none; b=KJuS01C1FJaTNpsOkk4j3RHeWTjHZliKJHJHK0ukDEoUDzcMZJvUPvyFNnof2R7dhbaOAlZLfIL7K7tIb4WjSUDeq5r3N3MYZE8ZlTD45guzHoV7GrCd/JBYTLSU2UDo0iazdyAViNv3gzUmjn1w9U5RhxvIhCOPADeRfJ2FLIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341756; c=relaxed/simple;
	bh=P55e0YdHr3EBbeSfVcEWlMRwZEnp0BSXvLy/GhsoFmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Woykv+P1O966sJDu/RqieTi1ZGhuK5jYqTjx5IOLhkXGN4lRoLUZk0IyeZyVcZS/eYdhS28K53+LJ8IwjOBnC575dwz8FcZ8WDkcEfQQt7T17KDIGeuKx74OYjNxnc2S6s+Im9H7nMyPgW2s3QJm35puUtILLhWsJijtijKgxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkhhEapM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B04EBC433C7;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341754;
	bh=P55e0YdHr3EBbeSfVcEWlMRwZEnp0BSXvLy/GhsoFmw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gkhhEapMgJhfVt+4ngHi5hJfu28kyDyu8exX07UCVkjOZS1ijZGamJNq3cK/0ow0q
	 aZ119Ybv/Lqh5GgFaBD0nQ0zAFQNc4GS6uupywX3Sp065WVt9qAve+UTRAMWGodDUL
	 FUrXOkUF2buJtldasEOiHKcXylWilsDPFGxx1ZFtu4o6VXhKJGJMZc4ea4VgWDnRDs
	 q0AoqAXJV5+s0jba/xzBOi5pslR8k96AhQme1LjUKg7c1TnPATglM1Pl6h5t1hIf7Q
	 GzXJOVA175jcv3FrGsF5THwZu/6BAWklYPRH5nP882M1GcjKKcB7OfJgDdHJDkr7Ne
	 C7YvcEVv8dHxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 97DCED8BCE3;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cache: ax45mp_cache: Align end size to cache boundary in
 ax45mp_dma_cache_wback()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134175461.18749.5523574540547752067.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:42:34 +0000
References: <20240203212640.129797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240203212640.129797-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-riscv@lists.infradead.org, geert+renesas@glider.be,
 conor@kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, pavel@denx.de

Hello:

This patch was applied to riscv/linux.git (fixes)
by Conor Dooley <conor.dooley@microchip.com>:

On Sat,  3 Feb 2024 21:26:40 +0000 you wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Align the end size to cache boundary size in ax45mp_dma_cache_wback()
> callback likewise done in ax45mp_dma_cache_inv() callback.
> 
> Additionally return early in case of start == end.
> 
> [...]

Here is the summary with links:
  - cache: ax45mp_cache: Align end size to cache boundary in ax45mp_dma_cache_wback()
    https://git.kernel.org/riscv/c/9bd405c48b0a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



