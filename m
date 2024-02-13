Return-Path: <linux-kernel+bounces-62759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BE5852556
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477211F24BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934442BB08;
	Tue, 13 Feb 2024 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABBRO/lf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DEB28F3;
	Tue, 13 Feb 2024 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707784038; cv=none; b=nsuRWA2bbRnTJrtziqBFTHkLZTUqzozophR+fR3MtqCEWfFthc8VQeWcb0/bws4NczCJFfcXtr46Auum6OOwDHgFT1OH4pGl17eobGoVkDZ/g2dc0aVEVW10zjJoEZvWZ6PookEVhwVjTEM0Uvkw68DfghrIwWfrDna++L4EhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707784038; c=relaxed/simple;
	bh=xa2oLixYH54yKOS4wx6qyOKj3uS0moEuwKs5rzbxVJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFz7fJul5MqcJM6Cr2psHjN8lBpZyxc4zRpnDXrFoak39M4qnJnF4oQZp4XndTcwiVXQ4okuGH1VHn6flikz4EvTCoittFWcFeEScQR4o0pw3wN6U9wgPtKj8vO95JMeHYbTd1nRvD3lRtyxBDjRMP9EG3up79HYeQKya+W7iYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABBRO/lf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC05C433F1;
	Tue, 13 Feb 2024 00:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707784038;
	bh=xa2oLixYH54yKOS4wx6qyOKj3uS0moEuwKs5rzbxVJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ABBRO/lf+/k9i2TOlc4qooYhDRcwXRi7Ka14CzL8TjCZtDzhKEUMNhFq75QCzFVGX
	 l4c42f/jRbjPmLDblX2KoJ5ZJj51pTdm3+rK39DSckdfOq9Xf/kJ5B4FJ3AAX7Pjkd
	 PRB9HXw7FcLjW2ozIoGRRO40Om/4saTN3TCbOg62JQpldimqRGSqWp7ayl//XJ0E0Y
	 N7XePU+CtHkStu8zLvxCuQ925hD1cxoDm4GdKHwOeXMVZokl75icfdFb+JJ0ptBSNA
	 BwmXL5ywJha3ezjx1TgD2HxOoUMhBvxs7UXXxgirNG/cIuQLLxjoXd071/3q5iCnj0
	 tShUm13obv+Tw==
Date: Mon, 12 Feb 2024 16:27:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH net v2] lan966x: Fix crash when adding interface under a
 lag
Message-ID: <20240212162717.2c8cb74e@kernel.org>
In-Reply-To: <20240212083229.tg3cabp4iee3p6tq@DEN-DL-M31836.microchip.com>
References: <20240206123054.3052966-1-horatiu.vultur@microchip.com>
	<20240209135220.42e670d4@kernel.org>
	<20240212081038.cbsb2exfmcxxntzq@DEN-DL-M31836.microchip.com>
	<20240212083229.tg3cabp4iee3p6tq@DEN-DL-M31836.microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 09:32:29 +0100 Horatiu Vultur wrote:
> > You are right, the lan966x_lag_get_mask() will not set a bit for a port
> > that doesn't exist[1]. Therefore this check is not needed.
> > 
> > [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/ethernet/microchip/lan966x/lan966x_lag.c#L354  
> 
> While trying to rebase on net, the next version of this patch, I have seen that
> actually this version was accepted even though it was marked as "Changes
> Requested".
> The commit sha is: 15faa1f67ab405d47789d4702f587ec7df7ef03e
> 
> How do you prefer to go forward from here?
> - do you want to revert this and then I will send a new version?
> - should I send a patch that just removes this unneeded check?
> - any other suggestion?

Sorry about that, I must have forgotten to reset the tree after viewing
and didn't spot this between Brenos patches :S No big deal, let's leave
it as is.

