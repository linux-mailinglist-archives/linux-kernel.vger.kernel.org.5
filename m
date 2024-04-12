Return-Path: <linux-kernel+bounces-141824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BEB8A23EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53466B23B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 02:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F8C134B6;
	Fri, 12 Apr 2024 02:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR1JybLc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660310A24;
	Fri, 12 Apr 2024 02:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712890291; cv=none; b=cTdtLjies0HM1o7W065hzqwRNAroa9E8ighN8tL6rMw9r77tfdF4eON+fOLaWO1JyXdvpfm8ST9ccZwWjsr0EBVoB84pugvzT8npX/vwKFLf7eqjZ+BeWhYmK7GYcZ2h9s/D3lqXoHABJvNrxOQFfAJnR0uE4VmS3geQs2tIdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712890291; c=relaxed/simple;
	bh=JLSsFNuTS/XXGmjbgOU7MixG+Yt1/H2zmieyO7GGxMM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vba3NiOkNuzxsOrp1MRPPtGHfNeHdfEcjsQctn/gRV+jjcFdj/4Xme3jf3de7VC43TnHvLnVDGalG+CNU9u30M/2S4QPoDBppFOQKuRDC1gPwmwLsENoA3mdmmSWoFrtugc0jaiRlWXv8n7ALFslfDYSbJXtalVm8ZLuLNkOTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR1JybLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC69C072AA;
	Fri, 12 Apr 2024 02:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712890291;
	bh=JLSsFNuTS/XXGmjbgOU7MixG+Yt1/H2zmieyO7GGxMM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DR1JybLcJI6E78CFpFQm2BDyx0OIXKm6fZPwjr/Nyu6Md+FqcBBemwL02ZZXqNM8+
	 vgpDDW0pNaRRuMvuACSYt8A6NM+INoBUuZ3drApLMfJIY95lUdTzao7+ILFfmlA8IF
	 dcLhGhwlkl4V9Cq6Cbya2+JdL0DaUQw7aL64oo24elKNDw43JvJC5a5fYz01EQpzut
	 uouWdN0wfAYtRo8rUPxa8J420UVZFiaMeVn2hBZQ2HIybPqRsOH1WrvUhosiZ7oiXc
	 cS69wqM+hR8W18Sm+FyH4irMAw+0I7ztNyXe/oC/ljPD45+/68E6LERrwJtyWnTiky
	 gssoMX5k6Y5cw==
Date: Thu, 11 Apr 2024 19:51:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jarkko Palviainen
 <jarkko.palviainen@gmail.com>
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
Message-ID: <20240411195129.69ff2bac@kernel.org>
In-Reply-To: <20240410095603.502566-1-jtornosm@redhat.com>
References: <20240410095603.502566-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 11:55:49 +0200 Jose Ignacio Tornos Martinez wrote:
> After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
> consecutive device resets"), reset operation, in which the default mac
> address from the device is read, is not executed from bind operation and
> the random address, that is pregenerated just in case, is direclty written
> the first time in the device, so the default one from the device is not
> even read. This writing is not dangerous because is volatile and the
> default mac address is not missed.

AFAICT the reset is synchronous to resume, right?

I think you can use netif_device_detach() and netif_device_attach()
to prevent getting called while suspended.

