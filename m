Return-Path: <linux-kernel+bounces-122145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B66B88F2AE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D58F1C267C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634D1153BE2;
	Wed, 27 Mar 2024 23:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmHuOjuk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90402433D8;
	Wed, 27 Mar 2024 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581453; cv=none; b=ks6C7k9crJ2ljBRUEV5Uh22OXJgsnqY+9mEOkeXWj1A4uglDIMKKQS5K4um+8i2EjFq/QUx5qMlXzxYn/O9015Bvlr/1lEN/wx/E7fs3CrqP/gB7gcl27r1gwtF3FIfUGXFhPWn4ewlQV1QwaLIjZlpLnt+KruWi0J/SCVNKRZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581453; c=relaxed/simple;
	bh=4WjYjDwm3w6B8gj/uMoHHzsRpfRNRmomT5co1eXnBjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/KFP/C9DOPveRynt/UK/ss8eHPAl2L35k3u2e+ru7886LMrFB1tZxgfQDcdMU0Q9jUoXXHghprJX+gG1BrSo/6QFbMTJuypzG2bepo7V0vmSQgSLJgNvTcuVfSs6dswmPBoZgKyZXNrBKoPrQaD/LTySS176fWFhlyE44YrzNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmHuOjuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B581C433F1;
	Wed, 27 Mar 2024 23:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711581453;
	bh=4WjYjDwm3w6B8gj/uMoHHzsRpfRNRmomT5co1eXnBjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dmHuOjukP1kaGro22Y0vhnpswDZgRdNyRJt7B3uGRuZ3lrksJ4JUVg52O1Kgj1vfh
	 k/y/tJjqqZ8kepp0hFZ7qKpem4EkaPTqM2f8kWLalCtunJG0JcGrUPS1XtdX0JsFGa
	 l4YeBpR0lwCCqKFDNdEFsLlXcCvsxVFxwUsn6WFgPywShmEWGNhjD+ZicAz2r3Xs4h
	 solnW6arXUGJ59dtOVSX2DaabGrPHCbxJ776kZcuUYodG1V3xwAPVd5DvqW+XNrr0J
	 DTXYfNZDphhJlhZ+UYnUFpmvG0fWviuF/eqTjTKWFL50RqrZ8yGTE56RkIMtwYnmYM
	 9nJ88asHnfDng==
Date: Wed, 27 Mar 2024 16:17:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 quic_jjohnson@quicinc.com, kvalo@kernel.org, leon@kernel.org,
 dennis.dalessandro@cornelisnetworks.com, Jiri Pirko <jiri@resnulli.us>,
 Simon Horman <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>,
 netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH net-next] net: create a dummy net_device allocator
Message-ID: <20240327161731.6b100cb8@kernel.org>
In-Reply-To: <20240327200809.512867-1-leitao@debian.org>
References: <20240327200809.512867-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 13:08:04 -0700 Breno Leitao wrote:
> It is impossible to use init_dummy_netdev together with alloc_netdev()
> as the 'setup' argument.
> 
> This is because alloc_netdev() initializes some fields in the net_device
> structure, and later init_dummy_netdev() memzero them all. This causes
> some problems as reported here:
> 
> 	https://lore.kernel.org/all/20240322082336.49f110cc@kernel.org/
> 
> Split the init_dummy_netdev() function in two. Create a new function called
> init_dummy_netdev_core() that does not memzero the net_device structure.
> Then have init_dummy_netdev() memzero-ing and calling
> init_dummy_netdev_core(), keeping the old behaviour.
> 
> init_dummy_netdev_core() is the new function that could be called as an
> argument for alloc_netdev().
> 
> Also, create a helper to allocate and initialize dummy net devices,
> leveraging init_dummy_netdev_core() as the setup argument. This function
> basically simplify the allocation of dummy devices, by allocating and
> initializing it. Freeing the device continue to be done through
> free_netdev()

Ah, but you need to make it part of the series with some caller.
Maybe convert all the ethernet ones?

$ git grep 'struct net_device [^*]*;' -- drivers/net/ethernet/
drivers/net/ethernet/cavium/thunder/thunder_bgx.c:      struct net_device       netdev;
drivers/net/ethernet/marvell/prestera/prestera_rxtx.c:  struct net_device napi_dev;
drivers/net/ethernet/microchip/vcap/vcap_api_debugfs_kunit.c:static struct net_device test_netdev = {};
drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:static struct net_device test_netdev = {};
-- 
pw-bot: cr

