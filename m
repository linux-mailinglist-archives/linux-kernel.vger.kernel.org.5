Return-Path: <linux-kernel+bounces-107632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB16787FF67
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75478285481
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507881AA1;
	Tue, 19 Mar 2024 14:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b="i5FRvAMD"
Received: from mr85p00im-hyfv06021301.me.com (mr85p00im-hyfv06021301.me.com [17.58.23.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2086C3BBD4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710857780; cv=none; b=ckbZL6eAi5SYHZdpX/JdKHev1XyJt2A4m4gSAaQ2K8XCy/Ggy2tsv4GVmkiu238PTat3xWemhZSgIw3jGuVDGHxvpxYJMHLkJD830IREgpeg1FvRSKp+n+zNLvksLxC4SmdV6enjqikCbwzMTb7djm1p/Lz+08puDiQwK64Ga5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710857780; c=relaxed/simple;
	bh=OfVIQKH8G3sal3vPAw1T3wx1fn7GFtfdKeV6Pwq/r00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGsndoCOz5aJFHsBj0GdHvY/eqwvCpFY0z1misLjFm682/VlMrjtogf8AjWDklrfND+Bai+cVgt+9bRAmeRZ5Jc0+Mup//iJuFeaTsxlqHAu3D/Te2UQRZwOXkABZHmRP/6ZkVObvb5nb0M1aXJeopEmWhkAjsOjzPw8EDxHrtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net; spf=pass smtp.mailfrom=danm.net; dkim=pass (2048-bit key) header.d=danm.net header.i=@danm.net header.b=i5FRvAMD; arc=none smtp.client-ip=17.58.23.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=danm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danm.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=danm.net; s=sig1;
	t=1710857777; bh=IiXA31WpMrMnC3zm3AybHOBIpk6BS47uPdS83Z5qxmE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=i5FRvAMD9upA3ejiWxhcm0qN0ZiP7rOGakWQe42a9hNOG3KHG3PEAaG7B0CbDDfk2
	 tWaXtIGYMe+C+ZLndvbPBjBw+ZPqPjvYidoxO4L2rb+IB9TF8WtT1rdJBU8nxeLu9d
	 0UkdcJ6imfo1xJBNOoN5TQgkCFHYH6ugx4dmGIm1O9+l4pTrosteaT02GoJx5f9YqV
	 z6wS9YTuYSSI1xynlCBERJTkJlQH7/rhh3wPqbzZAPL9L9kFI866mf1vwUxpth+gFC
	 AkM2lEmGqMceQi5mz3BWBPq5lL39mivs1oVviqbSqeobYpBmmJ6v3bp/jBlhg/dgw3
	 bDei4Yh+QusVw==
Received: from hitch.danm.net (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-hyfv06021301.me.com (Postfix) with ESMTPSA id 9A259215105A;
	Tue, 19 Mar 2024 14:16:15 +0000 (UTC)
From: Dan Moulding <dan@danm.net>
To: yukuai1@huaweicloud.com
Cc: dan@danm.net,
	gregkh@linuxfoundation.org,
	junxiao.bi@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org,
	regressions@lists.linux.dev,
	song@kernel.org,
	stable@vger.kernel.org,
	yukuai3@huawei.com
Subject: Re: [REGRESSION] 6.7.1: md: raid5 hang and unresponsive system; successfully bisected
Date: Tue, 19 Mar 2024 08:16:13 -0600
Message-ID: <20240319141613.27361-1-dan@danm.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <db4f5f1b-5eba-2cdb-fad0-7aa725cea508@huaweicloud.com>
References: <db4f5f1b-5eba-2cdb-fad0-7aa725cea508@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -h8Kiu6Q5qnw_ur0rtHciU2f3qWWxTyE
X-Proofpoint-GUID: -h8Kiu6Q5qnw_ur0rtHciU2f3qWWxTyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-19_03,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2403190108

> Thanks a lot for the testing! Can you also give following patch a try?
> It removes the change to blk_plug, because Dan and Song are worried
> about performance degradation, so we need to verify the performance
> before consider that patch.
> 
> Anyway, I think following patch can fix this problem as well.
> 
> Thanks,
> Kuai
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 3ad5f3c7f91e..ae8665be9940 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -6728,6 +6728,9 @@ static void raid5d(struct md_thread *thread)
>                  int batch_size, released;
>                  unsigned int offset;
> 
> +               if (test_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags))
> +                       goto skip;
> +
>                  released = release_stripe_list(conf, 
> conf->temp_inactive_list);
>                  if (released)
>                          clear_bit(R5_DID_ALLOC, &conf->cache_state);
> @@ -6766,6 +6769,7 @@ static void raid5d(struct md_thread *thread)
>                          spin_lock_irq(&conf->device_lock);
>                  }
>          }
> +skip:
>          pr_debug("%d stripes handled\n", handled);
> 
>          spin_unlock_irq(&conf->device_lock);

Yes, this patch also seems to work. I cannot reproduce the problem on
6.8-rc7 or 6.8.1 with just this one applied.

Cheers!

-- Dan

