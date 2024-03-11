Return-Path: <linux-kernel+bounces-99655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CEF878B76
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102151C20C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997F759167;
	Mon, 11 Mar 2024 23:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCybjNwF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8658AAC;
	Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710199231; cv=none; b=rDn0Xvy4c0CnB7WrVoO7FroZfTBw4JL2I3igxUux0Pu+xz13RStYjzwTVsAPEiL6tThQAQ0wqZ28dqgQ46jD75sNY9yYvAYJOb60Vbxoz0llFcN2frfvaN/tPvPfRFyYgfsYYIhOtVoMo6IVlyHE1Z0isYImkZtQ8yJa/lOh/9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710199231; c=relaxed/simple;
	bh=/SfPJdQLLpKy4wOW1GxWa5+tTB7sghSqtQujy4vtbq0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ItahqO6lb2itWHBSxHvf8dYtWU6vzkX3XxWG/EU10FLBzlQYxKyTFwlbykOLUNP8FwntbWL8jFJwCetp6VGQz82e4PE0xia3TjmsoqVGS5/m8ADcd1DZSLMO2UWbAvCB0lApTcMFcfRx6UcNuEjJrUroAMabrZYnBeO6eE8OZF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCybjNwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B3354C43394;
	Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710199231;
	bh=/SfPJdQLLpKy4wOW1GxWa5+tTB7sghSqtQujy4vtbq0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KCybjNwF7Gn0mJVZZaXAIQq5RXZLm8oglHmJZVvtsNleZcGXS6Xn9WBnfUuhYwMHL
	 IhtatKt9GdpfsAHXUk/C5tHm30vaIKCDJEqqgQifNoEbHJ4ie+vWeWOpKrAUNbeKvO
	 amG+3zDoZKzAw2FEehrTumEtpTZ18MvnmGdJr0nyOMnelMqfN+gVQ3VBdfjfLQZ8rN
	 YUGjwhSnFDNY9OFTun0yyo7EySBnpiL3JXFGESSOstqao0NpUOYXoMDvIY96wwNAfo
	 wBz8yNY9qjyRK/6nDTAkbzK+YUWZ6SqwWsXHNxdc29qnWg31YbYRVmGOtvuXlVIMRo
	 0nqKiA8SfSoFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C956D95055;
	Mon, 11 Mar 2024 23:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] ptp: Move from simple ida to xarray
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019923163.27198.3435432996838063390.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:20:31 +0000
References: <20240311144730.1239594-1-kory.maincent@bootlin.com>
In-Reply-To: <20240311144730.1239594-1-kory.maincent@bootlin.com>
To: =?utf-8?q?K=C3=B6ry_Maincent_=3Ckory=2Emaincent=40bootlin=2Ecom=3E?=@codeaurora.org
Cc: kuba@kernel.org, horms@kernel.org, przemyslaw.kitszel@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, richardcochran@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Mar 2024 15:47:29 +0100 you wrote:
> Move from simple ida to xarray for storing and loading the ptp_clock
> pointer. This prepares support for future hardware timestamp selection by
> being able to link the ptp clock index to its pointer.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> [...]

Here is the summary with links:
  - [v4,net-next] ptp: Move from simple ida to xarray
    https://git.kernel.org/netdev/net-next/c/f095fefacdd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



