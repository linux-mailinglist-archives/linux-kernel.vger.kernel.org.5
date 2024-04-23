Return-Path: <linux-kernel+bounces-154960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787628AE3A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18DA91F23E92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425087FBA2;
	Tue, 23 Apr 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koWgQDiz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65820B33;
	Tue, 23 Apr 2024 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870923; cv=none; b=ggO4watn4jr13C/QQ2PenWNiakuDkHmJsbrUpJ38hRDoTw5z6MWn6lObCnsn1/ruT4ufgNkp6SCpTXFJnMgiKO+aijFL1zsPdAG1yfhHiJofenomRPvVVieLUAzGHqDiald5jGbKPkhLvvbVXZRKYJQFIXeHUMeq3LuXumXcT5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870923; c=relaxed/simple;
	bh=X06P0iT9hXvAJ3wHazo2BpgYDWucrgTbVBpwXx5xHt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItkBlxjpfSVuaqrOrwY/2EDH2J3ll5Oy+rxn+nuTiFNXayuZ8xW7GcCa3t3ISpvfkwKpKifHpkKbsSPysn+V5ZSWGcYfhM8ce2/PqsDp+/NPRkj1L5dmL4MJwDrlUSt3U4yZjSIqns+u9ADE0wVhL7tKrRJnMvaS0WeuAD+QfN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koWgQDiz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1452C116B1;
	Tue, 23 Apr 2024 11:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713870923;
	bh=X06P0iT9hXvAJ3wHazo2BpgYDWucrgTbVBpwXx5xHt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=koWgQDizCZEcJs76Nz0MSqyT5xAYYJxGZ09xwi7RWclILPj1GYNJFLHIcFIjPWJEc
	 zl/fUkBsX+n+wTlLKuV0sSNyUcYpEmR5fWc7hw1bpX3VxL8qWUGcLFAI4MzvI545aR
	 cBfpuGfvosjMOH+UpJoAUGyP1l2y+R58xn4nOyq9IHoT+rPd2bFWsIpF7v0H/19ahU
	 plBcDonVNSC+DfmDCI4vOaUNWl2VBKUBXFFQmPHLFNqn+Ncw3rZTFtVh7XqQXAqfR2
	 RvTulhxi5PS/VtZknwe9JbhwrUId2hr5bHF6FHddgk+YI/02nOSZ3j7dFFJGIOzRkL
	 SD+3iSlfWni7A==
Date: Tue, 23 Apr 2024 12:15:18 +0100
From: Simon Horman <horms@kernel.org>
To: Jun Gu <jun.gu@easystack.cn>
Cc: pshelar@ovn.org, dev@openvswitch.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: Release reference
 to netdev
Message-ID: <20240423111518.GQ42092@kernel.org>
References: <20240423073751.52706-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423073751.52706-1-jun.gu@easystack.cn>

+ David Miller, Eric Dumazet, Jakub Kicinski, Paolo Abeni, Eelco Chaudron

On Tue, Apr 23, 2024 at 03:37:51PM +0800, Jun Gu wrote:
> dev_get_by_name will provide a reference on the netdev. So ensure that
> the reference of netdev is released after completed.
> 
> Fixes: 2540088b836f ("net: openvswitch: Check vport netdev name")
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>

Hi Jun Gu,

This change looks good to me.

Unfortunately  didn't seem to hit netdev for some reason.

And, probably unrelated to that some CCs were missing:
they should be seeded using ./scripts/get_maintainer.pl my.patch

I'd wait for feedback from Jakub on if a repost is needed
(because for one thing it's not good to repost within 24h.)

The above notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/openvswitch/vport-netdev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
> index 618edc346c0f..91a11067e458 100644
> --- a/net/openvswitch/vport-netdev.c
> +++ b/net/openvswitch/vport-netdev.c
> @@ -78,12 +78,16 @@ struct vport *ovs_netdev_link(struct vport *vport, const char *name)
>  	int err;
>  
>  	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
> +	if (!vport->dev) {
> +		err = -ENODEV;
> +		goto error_free_vport;
> +	}
>  	/* Ensure that the device exists and that the provided
>  	 * name is not one of its aliases.
>  	 */
> -	if (!vport->dev || strcmp(name, ovs_vport_name(vport))) {
> +	if (strcmp(name, ovs_vport_name(vport))) {
>  		err = -ENODEV;
> -		goto error_free_vport;
> +		goto error_put;
>  	}
>  	netdev_tracker_alloc(vport->dev, &vport->dev_tracker, GFP_KERNEL);
>  	if (vport->dev->flags & IFF_LOOPBACK ||
> -- 
> 2.25.1
> 
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
> 

