Return-Path: <linux-kernel+bounces-98120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8550B87755F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 06:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5E3EB21C70
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FDC310A1C;
	Sun, 10 Mar 2024 05:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="HSuH3Roe"
Received: from mr85p00im-zteg06011501.me.com (mr85p00im-zteg06011501.me.com [17.58.23.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945816FF5C
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710047607; cv=none; b=IBe9En6nL7uw3YIr2tMVGscri5SmUIXReMWy4k4ArIv0PW/YlRwslzyjRwmkT1/TNuTuVqB4ChV9rgglEKgl5ed1qFX2Mz59s5O3jKgECCzo6Wm9edIvzKsQ0upv1hNZJSmevnou9hjK+44D87EkFrtC0m7H4k2BFiEs1A0rDHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710047607; c=relaxed/simple;
	bh=T6XjRhnGO6nIaTDzl99aOQ6bUYJdL4xvjrQ7ZIMu54s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi4qNo24nCbT6qvVTC1pArqpJs+PsFD5+rTbfPa9qMKR51Wl90UU8qQDfx5U1enk2u0tSE5papgPQqt7srih/jdfkxstk34C9/PpQZdcAs/zDjnJUVReglF6GkTxSNnHodZAsXYVj39gXL9b/HMBkXta6ymZduHkwsB816iCyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=HSuH3Roe; arc=none smtp.client-ip=17.58.23.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1710047604; bh=w5RhIat3cVeSw5iGnaflty1U4Kd5aUaXoJYaNdQwBJA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HSuH3RoerZbtH1tXsy/ZzNESP80YvZeB7v60YYjpz4+FBKQjP4C21DxYFGdREgCcN
	 TCAm+JqJbfo8mnvYAAJr0ACqBB5ifQTLtaH3zAR68L/X6/LfmmMM9FO0ROkwAQ3x+n
	 YGb1unOUgwznjUkp7C2N4mMI2hcL15hF7KZT3kohMDpBJamDofMZ+ajsLfJZz+tHos
	 d01NXUxwMtiF/tfYpUjMiTOup+QGhAg9bfbSBvBBT+VS2rFgLDUXlfnm9XkNKb/2Nv
	 qrIGw8KrpFTemMPCR211U+pfiKDNuPpNEHyRIcmVFowh1PfaAelTkSl2uQR7utAdb3
	 EUrmHFASJ/5zg==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 1AF6748012F;
	Sun, 10 Mar 2024 05:13:22 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: junxiao.bi@oracle.com
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Sat,  9 Mar 2024 22:13:21 -0700
Message-ID: <20240310051321.9812-1-dan@danm.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d3cdebfe-17c0-4f61-9ad9-71d9de2339b2@oracle.com>
References: <d3cdebfe-17c0-4f61-9ad9-71d9de2339b2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VCMOOETFy1S8Cuqw7AMi3jOVnDROoe4i
X-Proofpoint-ORIG-GUID: VCMOOETFy1S8Cuqw7AMi3jOVnDROoe4i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-10_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1030
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403100041

> Dan, can you try the following patch?
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index de771093b526..474462abfbdc 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1183,6 +1183,7 @@ void __blk_flush_plug(struct blk_plug *plug, bool 
> from_schedule)
>          if (unlikely(!rq_list_empty(plug->cached_rq)))
>                  blk_mq_free_plug_rqs(plug);
>   }
> +EXPORT_SYMBOL(__blk_flush_plug);
> 
>   /**
>    * blk_finish_plug - mark the end of a batch of submitted I/O
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8497880135ee..26e09cdf46a3 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6773,6 +6773,11 @@ static void raid5d(struct md_thread *thread)
> spin_unlock_irq(&conf->device_lock);
>                          md_check_recovery(mddev);
>                          spin_lock_irq(&conf->device_lock);
> +               } else {
> + spin_unlock_irq(&conf->device_lock);
> +                       blk_flush_plug(&plug, false);
> +                       cond_resched();
> +                       spin_lock_irq(&conf->device_lock);
>                  }
>          }
>          pr_debug("%d stripes handled\n", handled);

This patch seems to work! I can no longer reproduce the problem after
applying this.

Thanks,

-- Dan

