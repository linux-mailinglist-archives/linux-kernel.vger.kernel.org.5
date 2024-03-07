Return-Path: <linux-kernel+bounces-95915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1CB8754EC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A17287172
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21EE130ADE;
	Thu,  7 Mar 2024 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoM1bZ8W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E044C12FF6A;
	Thu,  7 Mar 2024 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831522; cv=none; b=HGsUXmkTvlmdzN5dDGmACNPXB2lUinIDEhnN+tW7gVKi93fxKrE0EUntUvvTWiDLJDwROZYF96O1t+kbh+UlQizmlWkTP1O9D4PjlEthoIjAzJPjKiDwie+Z8Z7akiO0Jg6n5XBscNP/CpAtAW7gKeyjT+sfetdn5xBRR+esL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831522; c=relaxed/simple;
	bh=plRVies8RIj3k/yIYB7vxQL1d+nILksaSKr4ix1IsUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Brq4Gg+PcVey9LKzW/uNCQEe9j57i0rhIuXObUEGrmEWYQHL4nW2GGVMmdnSi5KGLCE+VfaxMKpLotBfsxXlQ0zgSXv4+F/qSc3MXgWwhclXebBHXJBe3zRzvoXbTIoHR9U1vJoJWhXgnwQShjfDV+UQ0PbqR5g8rbsfw799sNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoM1bZ8W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC10FC433C7;
	Thu,  7 Mar 2024 17:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709831521;
	bh=plRVies8RIj3k/yIYB7vxQL1d+nILksaSKr4ix1IsUM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NoM1bZ8WWmKVPiZbhFTL/7K5anyMmK8OkMcKh7EXZZ3KxenrrW883pDsLPYsOwvpL
	 KJxQmdm2/mtuwL4/ue+Ao+JKBoIfZdfhuWnCQ1XoBxwNBFtzHOGTQLl+vcwZkWRP1b
	 8yL+8FkosXvUSiZA0sDkvxPR8WzH8savPRudLouBMHFjY6ScwrhQ8/aF9sTKHiC7TC
	 /VpBjVPDopz6hvOaFKHlpkjPpNguoDj7JzsYEJwCdlSKozfXdgXvOnDxuEvaZbGcdi
	 d6mqMZ4VquQicDrPpF/50w9i8JvNiqK72WtI7Lf21AjBwiANsBjPa+ImEeM4dCgRmQ
	 AKA06ZdOYXDDA==
Date: Thu, 7 Mar 2024 09:11:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Arun.Ramadoss@microchip.com, andrew@lunn.ch, kernel@pengutronix.de,
 olteanv@gmail.com, davem@davemloft.net, Woojung.Huh@microchip.com,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, f.fainelli@gmail.com,
 edumazet@google.com, netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net v2 1/1] net: dsa: microchip: make sure drive
 strength configuration is not lost by soft reset
Message-ID: <20240307091159.07146257@kernel.org>
In-Reply-To: <ZemCysWKkG2BjYiV@pengutronix.de>
References: <20240305064802.2478971-1-o.rempel@pengutronix.de>
	<20240305191457.37419bd4@kernel.org>
	<935b7bd6fe116291ff5f1f5a7a52cdad89e4607a.camel@microchip.com>
	<ZegHO_PqO-3qwFMQ@pengutronix.de>
	<ZemCysWKkG2BjYiV@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 10:03:06 +0100 Oleksij Rempel wrote:
> > > Suggestion: Instead of moving ksz_parse_drive_strength() from end of
> > > file to above, can we move ksz_setup() & ksz_teardown() down. So that
> > > the changes will be minimal. Will that work?  
> > 
> > This will make it hard portable to stable too. As alternative I can
> > offer to use v1 patch for stable and send bigger patch for next after
> > in the next net-next window.  
> 
> Are any changes on my side required?

Not really, just waiting for anyone to speak up, I'll apply v1 soon.
(I can't revive v1 in patchwork because Konstantin's bot will set it
to Superseded, immediately, again :|)

