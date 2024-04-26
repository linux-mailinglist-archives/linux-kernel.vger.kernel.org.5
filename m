Return-Path: <linux-kernel+bounces-160154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292FE8B39EA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E40E1C2250D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD95B155A5F;
	Fri, 26 Apr 2024 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qir+Mwqb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E04154450;
	Fri, 26 Apr 2024 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141559; cv=none; b=ky8arRHETacGIBw263iDuEEgHVNrtyenQ4Lo7Umxzeis7Uyotf1qH2puWXcnPkvjhYT/340tP0FYAy1ApjCPte82fyubjBk4lB/cOWrPFoJxPjwlaU9ZmS5lhpJc0UHYmOyaZcfYmfbWhlj72wu46BRqiEzixISdFXu137w0Qf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141559; c=relaxed/simple;
	bh=JAlZlhRgd43TtcbyzJjboofIoaeMSgpIa90XkM2QRNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bly2ruxqcLl/SomsvDzi2SZie4+A80R/OOOnvuShLmViIyIuLuKL0TFzV6HunMb2m1Hiz08PsnkJ59UXh/MuWJKT0NriD5q4yvsGbDok6BQcRJ4tKeRIsea62vVf7xezFH95xFyWzz9JY2Qz7QueUseKfxQLYKvNPJVWFde25Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qir+Mwqb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC7BC2BD10;
	Fri, 26 Apr 2024 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141558;
	bh=JAlZlhRgd43TtcbyzJjboofIoaeMSgpIa90XkM2QRNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qir+Mwqb5Zq5hWmubS/5pJqzYxgn5aTBjTqr0TpgW4AM4iQ+njzAOLQJThbz/7Mpl
	 PhGYYqgksOCndQzchmi2jKZuYtz0+jq8klFTZr/64s+8NfsEkp/6m0YjcEMHq8IwaT
	 oekwUamRvgweQ5GN7ZO6cD2rBTYW7QiKD7joaWPgrhoJjo6GFWX9gJruEUfjKSbulb
	 xRmSnCokz5ttfmiDPFy/Mrfn8AV2uKfP4mFk9/tKObmooSYZV+MYMkBNtsegpmVzoo
	 oqVvJWWMcmHBV8QRF3kQKQ3tE7DLy8eHjKDTqCGNI/7JV5xYR8KNTAWWZw2FzCLOnr
	 JEbaKD8KX2esw==
Date: Fri, 26 Apr 2024 15:25:53 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 4/7] net: hns3: use appropriate barrier function
 after setting a bit value
Message-ID: <20240426142553.GB513047@kernel.org>
References: <20240426100045.1631295-1-shaojijie@huawei.com>
 <20240426100045.1631295-5-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426100045.1631295-5-shaojijie@huawei.com>

On Fri, Apr 26, 2024 at 06:00:42PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> There is a memory barrier in followed case. When set the port down,
> hclgevf_set_timmer will set DOWN in state. Meanwhile, the service task has
> different behaviour based on whether the state is DOWN. Thus, to make sure
> service task see DOWN, use smp_mb__after_atomic after calling set_bit().
> 
>           CPU0                        CPU1
> ========================== ===================================
> hclgevf_set_timer_task()    hclgevf_periodic_service_task()
>   set_bit(DOWN,state)         test_bit(DOWN,state)
> 
> pf also has this issue.
> 
> Fixes: ff200099d271 ("net: hns3: remove unnecessary work in hclgevf_main")
> Fixes: 1c6dfe6fc6f7 ("net: hns3: remove mailbox and reset work in hclge_main")

FWIIW, I think it is fine to fix both problems in one patch
because both the cited patches were included in the same release - v5.6.
(Actually, they seem to be consecutive patches in git history.)

> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> ---
>  drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 3 +--
>  drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> index a068cd745eb4..6eda73f1e6ad 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
> @@ -7954,8 +7954,7 @@ static void hclge_set_timer_task(struct hnae3_handle *handle, bool enable)
>  		/* Set the DOWN flag here to disable link updating */
>  		set_bit(HCLGE_STATE_DOWN, &hdev->state);
>  
> -		/* flush memory to make sure DOWN is seen by service task */
> -		smp_mb__before_atomic();
> +		smp_mb__after_atomic(); /* flush memory to make sure DOWN is seen by service task */

If you need to post a v2 for some other reason, please consider reworking
this comment so lines are no longer than 80 columns wide. The previous form
where the comment was on it's own line looks good to me.

Likewise below.

In any case, this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

>  		hclge_flush_link_update(hdev);
>  	}
>  }
> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> index b57111252d07..08db8e84be4e 100644
> --- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
> @@ -2181,8 +2181,7 @@ static void hclgevf_set_timer_task(struct hnae3_handle *handle, bool enable)
>  	} else {
>  		set_bit(HCLGEVF_STATE_DOWN, &hdev->state);
>  
> -		/* flush memory to make sure DOWN is seen by service task */
> -		smp_mb__before_atomic();
> +		smp_mb__after_atomic(); /* flush memory to make sure DOWN is seen by service task */
>  		hclgevf_flush_link_update(hdev);
>  	}
>  }
> -- 
> 2.30.0
> 
> 

