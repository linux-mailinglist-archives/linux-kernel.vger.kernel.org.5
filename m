Return-Path: <linux-kernel+bounces-130829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE004897D98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 04:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8B691C22BC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269851B59A;
	Thu,  4 Apr 2024 02:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SihH5gj+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66999748D;
	Thu,  4 Apr 2024 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196532; cv=none; b=ipulzpaY14sZ1HxDmjTJygT3fMSab35kUmjjPaDoVJEoujU862BDg0q7H5WsmJw5inZ1zqANzgrq98uqF2N+oqx56OAfV3aWSWEJZRLvNiEJ4M5iq4MleZwSkAZMZSqXxBQgpKujx1XwJ69IsHjItjPR6mMc0wXAiQl5QT6h79o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196532; c=relaxed/simple;
	bh=h8u3zIccZx3zKNAQC0hjVXdlOZMF0TESTGo5Nwdk+4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFxF8zQCLarG/KXlZPaior+XzNNA1INEo7yhJ4mAMc+l3owDGCt28u+zIRqSh/RC82F42o68xSgmpki7c8fw/0S7SKxWxuU+ZNTZVUTxAz+rbh4A8/ySI++viVCiLmbuB0+UdBm+H1xME7mNc5zZcvdhuAenAtSw+8XhhQI8ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SihH5gj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4076C433F1;
	Thu,  4 Apr 2024 02:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712196532;
	bh=h8u3zIccZx3zKNAQC0hjVXdlOZMF0TESTGo5Nwdk+4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SihH5gj+pfl0SFU7MF6rRYBdNIRS7jTXenqLkLQr1I/PRAABpzFr0pWqKNS5CCX8o
	 D6iYV/z970ZVbCLxALp4ojdDvlPz/sWWNa3gqU2AT5ObYjNsjIzwfuB2q00cmWs1v0
	 90efgRd9rbslKeHzAj4rz5iQxdsQapytwiqAHfk6AlIa4UD6q8SKOMOHHAPEjLwr2Z
	 p4CcrD8SxIsu8yPTcCWI17aFCoWTZFst9yOWesgGVFtRwRY6jl/hVRaHc1rRAv4nDe
	 WCG1hwXEn8bkQKfn3jaM9c0pQ4ik/dJV+3UTwZDbNUlnVC8D6XCimTiBubfSs0LMAY
	 ATsMVnRmUR5OQ==
Date: Wed, 3 Apr 2024 19:08:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maheshb@google.com, edumazet@google.com,
 gia-khanh.nguyen@oracle.com
Subject: Re: [PATCH net-next] ipvlan: handle NETDEV_DOWN event
Message-ID: <20240403190850.1a804753@kernel.org>
In-Reply-To: <1711892489-27931-2-git-send-email-venkat.x.venkatsubra@oracle.com>
References: <1711892489-27931-1-git-send-email-venkat.x.venkatsubra@oracle.com>
	<1711892489-27931-2-git-send-email-venkat.x.venkatsubra@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 31 Mar 2024 06:41:29 -0700 Venkat Venkatsubra wrote:
> In case of stacked devices, to help propagate the down
> link state from the parent/root device (to this leaf device),
> handle NETDEV_DOWN event like it is done now for NETDEV_UP.
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
>         ...
> [root@testnode-ol8 /]#
> 
> eth0's state continues to show up as UP even though ens5 is now DOWN.

When you squash the cover letter in, please add say that for macvlan
the handling was added in commit 80fd2d6ca546 ("macvlan: Change status
when lower device goes down").

> Reported-by: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Signed-off-by: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index 5920f7e63352..724d660904a2 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -736,6 +736,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
>  	switch (event) {
>  	case NETDEV_UP:
>  	case NETDEV_CHANGE:
> +	case NETDEV_DOWN:

Maybe put these in the same order they are in macvlan?

