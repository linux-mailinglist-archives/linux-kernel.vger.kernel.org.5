Return-Path: <linux-kernel+bounces-160556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4998B3F19
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:16:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A03028320E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2B616E888;
	Fri, 26 Apr 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAneWE1V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB420160787;
	Fri, 26 Apr 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714155322; cv=none; b=abpRVx1RbbHA4OXKjrM8pRvwcgwcg+PwG6ayzAUcGJ0EG0u/ieFKbYwCElx1s3Dk8kPsQrF0TLyIWDpz7i8Zg4uSAuYSB+9fC3OvWRQxMx8HkAvk3fvt/NccJA7fq9FMyeioySufU4TB5oqrLH/wRUpRQXkB3nwKVR+ljVEljlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714155322; c=relaxed/simple;
	bh=NBx5WI2xYCiixhHhcbYtdw3q11V3t5DrEOf3fzBzeMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNFvjx+qY2v9OCVBrDH9AluWDfol9dgQkUeKyhyNC7OfiBJshqxIjQyef3o5+fwP+4BYOQIHZuwh602+7Ej1suL9pX4MH70vN9nsIELBB5QtEbm4nkgrSgngb0n+2vE/qPhcAWplS4kJ2BB6NQ7IUTVbE5YFBt+yOjh5dYxZXHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vAneWE1V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 882F5C113CD;
	Fri, 26 Apr 2024 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714155322;
	bh=NBx5WI2xYCiixhHhcbYtdw3q11V3t5DrEOf3fzBzeMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vAneWE1VrIVOKs/7nEtKGA2bRfxvJsvb6VfsGcnzDg9e5gzYQdHqUR+Y+VKr2DyKQ
	 tn8MQvajhs6bc25GvyEUetum7btnsbu/ZvpwixQuhn7VN88NmcuAG2lYSHqaJlkfci
	 A/O1YL6jWLHi/bjS/17O9cW/Ulbik/VBU2q4EVPW+pAnRtPQQF5Sbq623v2cXrsGgH
	 4i9Wm+hDNoUlqbmXjup/SfQ2OtCZAPcJoyk8FdRs3yyFQB9HUdGi/YK/yMOd+T1FnK
	 mS9E/YZYGu1zFKDvomJjjk318agOt9daawhzjOPdgFbesSy7In8ZSmbDeWCcKhGHDH
	 xE2Bb/KQOzclw==
Date: Fri, 26 Apr 2024 19:15:17 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 6/7] net: hns3: fix port vlan filter not disabled
 issue
Message-ID: <20240426181517.GB516117@kernel.org>
References: <20240426100045.1631295-1-shaojijie@huawei.com>
 <20240426100045.1631295-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426100045.1631295-7-shaojijie@huawei.com>

On Fri, Apr 26, 2024 at 06:00:44PM +0800, Jijie Shao wrote:
> From: Yonglong Liu <liuyonglong@huawei.com>
> 
> According to hardware limitation, for device support modify
> VLAN filter state but not support bypass port VLAN filter,
> it should always disable the port VLAN filter. but the driver
> enables port VLAN filter when initializing, if there is no
> VLAN(except VLAN 0) id added, the driver will disable it
> in service task. In most time, it works fine. But there is
> a time window before the service task shceduled and net device
> being registered. So if user adds VLAN at this time, the driver
> will not update the VLAN filter state,  and the port VLAN filter
> remains enabled.
> 
> To fix the problem, if support modify VLAN filter state but not
> support bypass port VLAN filter, set the port vlan filter to "off".
> 
> Fixes: 184cd221a863 ("net: hns3: disable port VLAN filter when support function level VLAN filter control")
> Fixes: 2ba306627f59 ("net: hns3: add support for modify VLAN filter state")

For the record, my reading of this is:

184cd221a863 is a fix for 2ba306627f59. Both were included in v5.14.
This patch fixes 184cd221a863 and in turn 2ba306627f59.

> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>

..

