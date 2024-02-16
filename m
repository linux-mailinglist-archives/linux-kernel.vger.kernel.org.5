Return-Path: <linux-kernel+bounces-68766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B51FC857FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5CD71C223E9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD6112F367;
	Fri, 16 Feb 2024 14:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZKs18Gx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0971412C7F3;
	Fri, 16 Feb 2024 14:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095192; cv=none; b=lEoswM+nbYUwpj/5RxNam5grYwOPkxg8FkmELbgALOvzbGYnoSd3+2s4OE5q8fRG2SC0WugCG+MFrem5GamYU/j5G8OOySRWHajZTGg4S5Fezjy5LZ0fHNt1+f+4pazBng38nwnS7Ovy7uoE8BBfiasI0IpTY3MBx0tEv5UQEYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095192; c=relaxed/simple;
	bh=LMzBUEQYo4XVPtgX9jhAJ0vQ5+QsH4ZNObN1SC7ineU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YgbvaRx+6NM4TbkURk8ZdLXWN6NHEW4NjNMRZmog52qqgLSYYRkdDhqbNrGDQsJ4aXHll58Is5+Pddj8L0RQ+PaeJ1NMr7z862CxKOATcfyXF6Wnj04Fbk0+4/SfjVC7V+FAyRYFiuLKDbaE0T13zXbfh9ltTFSQBnScxjx0Sng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZKs18Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6CD7C433F1;
	Fri, 16 Feb 2024 14:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708095191;
	bh=LMzBUEQYo4XVPtgX9jhAJ0vQ5+QsH4ZNObN1SC7ineU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JZKs18GxecAhHOd/DdjSMCLrm2AVjc/3dPy73RswFIxKGlIBbCO5UUbL2wDrnB2+L
	 yhRfrzcfoNUdbFL+LUh9olTAxNLVPIbvPDXF9xN6GUJAtdPAmIMVwEIFsnTFUG8LRH
	 0xTdPPhihjIAkD5XdCe6HiPbPG/6mGwNFNrhdD64ORXdF46Zok7U0mlu/zU34SViit
	 4rSz09NQG7CLu96MVUgj4WL/Yru+5Y9C+3vSbcKTerT4Xb1bdOnhK7qt831WhZlTbr
	 kSyh1GuLclVuYFZG+NyvqDO7VsylnyNV+KKxKBmhfF+uoxw80zd2YX3iTuHIL4kib3
	 KpmNU1A3Eck7Q==
Date: Fri, 16 Feb 2024 15:53:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: [PATCH 2/2] kobject: reduce uevent_sock_mutex scope
Message-ID: <20240216-handwagen-weltfremd-258b1ea3921d@brauner>
References: <20240214084829.684541-1-edumazet@google.com>
 <20240214084829.684541-3-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240214084829.684541-3-edumazet@google.com>

On Wed, Feb 14, 2024 at 08:48:29AM +0000, Eric Dumazet wrote:
> This is a followup of commit a3498436b3a0 ("netns: restrict uevents")
> 
> - uevent_sock_mutex no longer protects uevent_seqnum thanks
>   to prior patch in the series.
> 
> - uevent_net_broadcast() can run without holding uevent_sock_mutex.
> 
> - Instead of grabbing uevent_sock_mutex before calling
>   kobject_uevent_net_broadcast(), we can move the
>   mutex_lock(&uevent_sock_mutex) to the place we iterate over
>   uevent_sock_list : uevent_net_broadcast_untagged().
> 
> After this patch, typical netdevice creations and destructions
> calling uevent_net_broadcast_tagged() no longer need to acquire
> uevent_sock_mutex.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christian Brauner <brauner@kernel.org>
> ---

Very nice,
Reviewed-by: Christian Brauner <brauner@kernel.org>

