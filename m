Return-Path: <linux-kernel+bounces-49853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D8E847084
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 034BA1C26C29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0BC1874;
	Fri,  2 Feb 2024 12:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ijhod+4a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C7C15CE;
	Fri,  2 Feb 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877790; cv=none; b=nWAS1179RH1tkmo3/le4y/xUZuUhD1k3P/IoYaQHdxPDfuD7N/5zErtII5OpenfyVx61Cii30M7g95b6bSzTKhozkUKaeVDk31KHyx39pwB2pPhHofh6i8sZ7yU/kKzNTn2AdmFMfWm76AemsHnZ+wNN/93yaLz5EUZ0jv+cT1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877790; c=relaxed/simple;
	bh=PxfcsiEDIy9Qq5Fj9DyY2bRtJKhBqY6xM3ALRlMwdZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jxi5TJETlZGuO/RWiWBMMjCQAzIGll2zfWjCT2k8RTxvAzKB0gzFk/rvMsieDQ59wZnoW2KCzajPwFXiMaq083SP7zbogrXpbKJOG/82wUOcdAwloGF2R6dElx0+9c6JP8/MDT1SrN3Mm2/jwBkQCRpaGqTtCoRZVyajOXSwboI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ijhod+4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60B85C433C7;
	Fri,  2 Feb 2024 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706877789;
	bh=PxfcsiEDIy9Qq5Fj9DyY2bRtJKhBqY6xM3ALRlMwdZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ijhod+4a9Wm7Ak9rvxRN/3QoDdbZhfsYcuZEvIQQp9DPeaDFVc2+bazmthC1sBrbM
	 nQfyFhyaMS/RgoPZULthADl2xhEe1YJ3RxJX4a5YqjKuEPuENcdEAogRCXjwhUKuig
	 GxIFB7Wv5vCglxl2TmlUleC8CPFybvvHk4NO8y/kB9tVPTTPY2wWrWEA3QxOglNSZ3
	 ea4u26WP5CCBU0MQY/6AwgqnUWGR52FaxnjeTSRqo5ASYMFvSRLeImalC+jWNtw4C2
	 ZkCYwcsSqMy57sfl6NLDwjvyPQBdftP0vkYsiIugAl+osmKaF+xd8Q4GFnp4DvPRMf
	 ZfMSQ4zS/mTEw==
Date: Fri, 2 Feb 2024 13:43:04 +0100
From: Simon Horman <horms@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>,
	Mateusz Palczewski <mateusz.palczewski@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] i40e: Do not allow untrusted VF to remove
 administratively set MAC
Message-ID: <20240202124304.GQ530335@kernel.org>
References: <20240131131714.23497-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131131714.23497-1-ivecera@redhat.com>

On Wed, Jan 31, 2024 at 02:17:14PM +0100, Ivan Vecera wrote:
> Currently when PF administratively sets VF's MAC address and the VF
> is put down (VF tries to delete all MACs) then the MAC is removed
> from MAC filters and primary VF MAC is zeroed.
> 
> Do not allow untrusted VF to remove primary MAC when it was set
> administratively by PF.
> 
> Reproducer:
> 1) Create VF
> 2) Set VF interface up
> 3) Administratively set the VF's MAC
> 4) Put VF interface down
> 
> [root@host ~]# echo 1 > /sys/class/net/enp2s0f0/device/sriov_numvfs
> [root@host ~]# ip link set enp2s0f0v0 up
> [root@host ~]# ip link set enp2s0f0 vf 0 mac fe:6c:b5:da:c7:7d
> [root@host ~]# ip link show enp2s0f0
> 23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>     link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
>     vf 0     link/ether fe:6c:b5:da:c7:7d brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
> [root@host ~]# ip link set enp2s0f0v0 down
> [root@host ~]# ip link show enp2s0f0
> 23: enp2s0f0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
>     link/ether 3c:ec:ef:b7:dd:04 brd ff:ff:ff:ff:ff:ff
>     vf 0     link/ether 00:00:00:00:00:00 brd ff:ff:ff:ff:ff:ff, spoof checking on, link-state auto, trust off
> 
> Fixes: 700bbf6c1f9e ("i40e: allow VF to remove any MAC filter")
> Fixes: ceb29474bbbc ("i40e: Add support for VF to specify its primary MAC address")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks Ivan,

Reviewed-by: Simon Horman <horms@kernel.org>


