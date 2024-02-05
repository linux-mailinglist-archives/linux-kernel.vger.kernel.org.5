Return-Path: <linux-kernel+bounces-53147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EE284A13E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A5761F232CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106784A9A5;
	Mon,  5 Feb 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoPLMbFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47875495DC
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155221; cv=none; b=tsU0wS8T03FbmhBFebmHE+5Z3P+d2uLaCFPrL9nXQMP5lPHphuit7Q2q3RFO1Lc1qwXOw7lLnp3Ouzm3PNqkWaWwUdmdh8XFsLyFjyQ45uAmlYeIKu4yPQrrPN1VmE707ujamwvQ4HBHhmbRTW3Yjpf2/+FUelLfQVEO6j7SVpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155221; c=relaxed/simple;
	bh=VeUkkU9+uABi8/SPsjzpVtKvmbwtiH+ymuIgRbB2DnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=okHeaAGpJtMogr0z8EsuYirw/2+q9lfEcJ4TI66KDpX96AY9e8NcYlHmslUILn6IuAJjAWpyV3PQPrli9uiNjC9KvR8UNHhHkFvuRvsBMN8H0Z5n2xYuEwXH7Q6t14aIt+cB0nu65sRulcYWUC5E0ds8E/1YXyL0y7dr8jJwa6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoPLMbFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16EC433F1;
	Mon,  5 Feb 2024 17:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707155220;
	bh=VeUkkU9+uABi8/SPsjzpVtKvmbwtiH+ymuIgRbB2DnA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=MoPLMbFkQ54yli0Y7Bu6TIpzKVNfbDUeTQ88gaCY/l2owdHXfiizfSXi/yvmUNc5Y
	 E3Y7efhJ4i3GeI0orycAUNbBI6Hie7+B0xhatecuXhF1FFRI0chvU5IJZLJxdD/6MW
	 ss2g6RRZYU00LWb8taqhgki7uoMmrHzF09219k7UvB4KNzAtuofqEbcQ11lu2Nnf6J
	 fvlv0QzoxBfr3RkUCfhM+JrY+XeY8hFjwIEBUn55j5vr1fM302/23TePCCNYJ/uLIn
	 iDSwJEK9QiTziqhbbg8TxeoYiqLuJOEPIg4jwTcD7BFqtX6IeXdMPPNLhXThhfSGPm
	 ZxulTYYzJstjQ==
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org, 
 Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: kernel@salutedevices.com
In-Reply-To: <20240126200836.1829995-1-jan.dakinevich@salutedevices.com>
References: <20240126200836.1829995-1-jan.dakinevich@salutedevices.com>
Subject: Re: [RFC] regmap: rework ->max_register handling
Message-Id: <170715521846.847227.12922920543306914597.b4-ty@kernel.org>
Date: Mon, 05 Feb 2024 17:46:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Fri, 26 Jan 2024 23:08:36 +0300, Jan Dakinevich wrote:
> When regmap consists of single register, 'regmap' subsystem is unable to
> understand whether ->max_register is set or not, because in both cases it
> is equal to zero. It leads to that the logic based on value of
> ->max_register doesn't work. For example using of REGCACHE_FLAT fails.
> 
> This patch introduces an extra parameter to regmap config, indicating
> that zero value in ->max_register is authentic.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next

Thanks!

[1/1] regmap: rework ->max_register handling
      commit: 0ec74ad3c157bd4bcbcc8b294777733687e8cd2a

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


