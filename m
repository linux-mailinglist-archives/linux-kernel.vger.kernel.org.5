Return-Path: <linux-kernel+bounces-130828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9035C897D95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4545F1F28E11
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01F81BDC3;
	Thu,  4 Apr 2024 02:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hl/9axum"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A01BC3E;
	Thu,  4 Apr 2024 02:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196432; cv=none; b=GFpn322UAafQF+eqB+MYrOwQiTYw9giKHef68SVD3DHh4LhbzpSTBbuUwgiTw3gU0DnEPVygKcsOlssSZiF/bpZeREmJdkJi2uhIS3M+OFH3eUfdLdm7rE87MbTHQcgTjfKRgZuBMGrSsNZNloqKBj9U4k991h1EFP6jZpioN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196432; c=relaxed/simple;
	bh=0lyjrwaTUpg1Rvc/sVo0XwFKKqgw/mZirkOmOJKHuCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diC585Un8aXYcvJLA9hUBPh8AZiAGNrhgnIbMnMkxBvK7ivJWtmMo7ER2StnvtS434Gnw92fylkvUmJWol9h9EoWcbO2kx6Y8PuI70eL814pvKtchPIHMQgyWE6lVauBgKzvXQ/Jn7wbkZGunRihZYPqIF4KFxKfkgKIcr28Vyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hl/9axum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C2BC433C7;
	Thu,  4 Apr 2024 02:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712196431;
	bh=0lyjrwaTUpg1Rvc/sVo0XwFKKqgw/mZirkOmOJKHuCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hl/9axumTh7DE4Luwx63nUBi8JEDRCnV2Bz9iy41T7M38/p3zAsa+l1586APOEKU5
	 AxXEEI9saviXr+6FcvOF+YJMdnrHuq7Rw/J2zXiLKXZ/qILA6y/2CvFUqI3ibGHsy4
	 sjgUTLaoQjUi94AtCzvm2zBuqdNP7otd66Z0BQg0txJUWqzfR4RrM586RTU65tjJfQ
	 /Rsohk1qNcmiZlNIOXkheRwEeLlB8z0OKIoWbp8Tnl6nch5PcGfpYAvEMZj2SWj9Ph
	 JUtZfzQXMKwFsdvRpAboS9HxWXqZk6QW2GRaY1mUxtJDhChpnt0fOv5h52AnUGuPKO
	 uWdC3oED7DKzw==
Date: Wed, 3 Apr 2024 19:07:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maheshb@google.com, edumazet@google.com,
 gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH net-next] Add handling of NETDEV_DOWN event
Message-ID: <20240403190704.6df9481d@kicinski-fedora-PC1C0HJN>
In-Reply-To: <1711892489-27931-1-git-send-email-venkat.x.venkatsubra@oracle.com>
References: <1711892489-27931-1-git-send-email-venkat.x.venkatsubra@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Mar 2024 06:41:28 -0700 Venkat Venkatsubra wrote:
> When ethP is the parent interface of ipvlan interface ethC,
> and you do
> 
> # ip link set ethP down
> 
> ethC's link state is not brought down.
> 
> In the below example, ens5 is the host interface which is the 
> parent of the ipvlan interface eth0 in the container.
> 
> Host:
> 
> [root@gkn-podman-x64 ~]# ip link set ens5 down
> [root@gkn-podman-x64 ~]# ip -d link show dev ens5
> 3: ens5: <BROADCAST,MULTICAST> mtu 9000 qdisc mq state DOWN 
>       ...
> [root@gkn-podman-x64 ~]#
> 
> Container:
> 
> [root@testnode-ol8 /]# ip -d link show dev eth0
> 2: eth0@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 state UNKNOWN 
>         ...
>     ipvlan mode l2 bridge 
> [root@testnode-ol8 /]#
> 
> eth0 continues to remain UP.

No need to add a cover letter for a single patch.
Add what's relevant to the main commit message.

