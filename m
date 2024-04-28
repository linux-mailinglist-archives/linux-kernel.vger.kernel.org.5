Return-Path: <linux-kernel+bounces-161305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3788B4A74
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FF1D1F21B7F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7AC50264;
	Sun, 28 Apr 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f0dWapUU"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DF24F1E4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288661; cv=none; b=sPIcETy8qz9p5I/yPwaWOnM1ubsdPt1oHtyBtX1Cyqj8FV75ewxyPPFKKIq2lOhrfRHSWsjjcjlOvTjiU3JJcEyyqqkoD8wsLoTFZzzNw2R+snqPu3/b2HidNF5uBdCgk6RSSAvcXIUsZfX5TzvjOKHnCcj5rw3wSV4wA26j06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288661; c=relaxed/simple;
	bh=gYY7v02S2zkJs5o/bwk1jVObM0FWr25UBqQ3c5f8Bvk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWDC+PBeqehX1nwJ/BcaACi8F3rZUWH0MaOFboFUv+T4bjj9qgl4mGZfij3cuMfJX2iMzZbV48DotYoFTSfuFIo7x6TIl8lwAFuou4IeSV7IEpIdMXnAJEPeQrYzyZeVbbqqI5zpA2910yHJ9ZzD/WcW/2tuyzwF7DBvHTsCE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f0dWapUU; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714288656; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ElM6MfNktHIzrhGINadeKp0SVn1/8qMDX9pmLKgfGNE=;
	b=f0dWapUUVt2eJuh2weIwbW39Bp2REuC0ZneLDtkNR7YEIpO/QcgtadA/yR5Qk+qxJykl8xWiE0QRHmoe5v+68eMEnckguwe8UX9mrMw6bM2afe0HupRDIfg+CESBvgVei641p/Pu7ojnAHPP86G4qROKI0OJ0pWhVZefDE+iQgY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5Nef7l_1714288653;
Received: from 30.221.129.62(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5Nef7l_1714288653)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 15:17:35 +0800
Message-ID: <bc0119e6-3f21-4fc2-9deb-51bc2ca8749f@linux.alibaba.com>
Date: Sun, 28 Apr 2024 15:17:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 2/2] erofs: reliably distinguish block based and
 fscache mode
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-3-libaokun1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240419123611.947084-3-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/19 20:36, Baokun Li wrote:
> From: Christian Brauner <brauner@kernel.org>
> 
> When erofs_kill_sb() is called in block dev based mode, s_bdev may not
> have been initialised yet, and if CONFIG_EROFS_FS_ONDEMAND is enabled,
> it will be mistaken for fscache mode, and then attempt to free an anon_dev
> that has never been allocated, triggering the following warning:
> 
> ============================================
> ida_free called for id=0 which is not allocated.
> WARNING: CPU: 14 PID: 926 at lib/idr.c:525 ida_free+0x134/0x140
> Modules linked in:
> CPU: 14 PID: 926 Comm: mount Not tainted 6.9.0-rc3-dirty #630
> RIP: 0010:ida_free+0x134/0x140
> Call Trace:
>   <TASK>
>   erofs_kill_sb+0x81/0x90
>   deactivate_locked_super+0x35/0x80
>   get_tree_bdev+0x136/0x1e0
>   vfs_get_tree+0x2c/0xf0
>   do_new_mount+0x190/0x2f0
>   [...]
> ============================================
> 
> Now when erofs_kill_sb() is called, erofs_sb_info must have been
> initialised, so use sbi->fsid to distinguish between the two modes.
> 
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

