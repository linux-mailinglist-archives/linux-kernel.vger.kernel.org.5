Return-Path: <linux-kernel+bounces-124387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA208916C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9E72B20FCA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194E55467A;
	Fri, 29 Mar 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIyOpwrC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C254662
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708046; cv=none; b=ja2LkZon99jg5ujVIBRDRW2wRoCPhBq4SSNcyd02a+i5rHaY07nzf+9dxc/zfxDP/fpq36xZl+ipM2ebu23/FZz94IdMEeiW+s4Rka5HmAQ6QaGPqUx09bLPAsSJpHmZmJW+5F1kzweeIdIXlWGpVdtjFrstw1p667/CI3YiaE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708046; c=relaxed/simple;
	bh=8xMeaCmofKZN4p34vXY4FFK17GcCRICBaE1lcyCzeBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLsvpgR+65eCAlOYn2WKngDSYpsK4UUb38PRIS3mPI45kpQbAURtV+d3mR/NHOy5zhYsXc25LFM2UAJTZCS4y22QvNghAEXAuV3bE9bE5F27bLYpDqGicsjvDJdJuTXlcOxjRkv/PM+txrlypjt3x5Bz2GtCWAHmVNwboHM7rgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIyOpwrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D599DC433C7;
	Fri, 29 Mar 2024 10:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711708046;
	bh=8xMeaCmofKZN4p34vXY4FFK17GcCRICBaE1lcyCzeBM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PIyOpwrCPivcOVF6EfUHGrLZj2HiAf2Wi9ge1bXQnB5kBkAOtIFQyxiG5bM6VToQF
	 ny+g2wHOlBFl0qixv6urftD3AHuJp3tvnXCGJfshh9EbiyihhrO9f08e3DcisC0Vpn
	 gwkm8Yfmb3AeAJmu79QCSNaf2PatMbZ7/SD9mnDLYTeXZcEhROsWsCyqDJ4g2BzNwT
	 FtO9RFZQIgH1sn8D6l+t+KOK2a1yWStYkG+xY7vkjO38BvVH4JqWKktkcztTcH/1dq
	 QgJ0TNQgIH8cQsJm9k4KVPvPsqlQYrKwKxCrC0HrPlDRSkTv5JyxmEd/QWF8FXWNa7
	 sjmzuvCv5fZtg==
Message-ID: <9172f17e-deb4-4219-b917-330cdffa5a81@kernel.org>
Date: Fri, 29 Mar 2024 18:27:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix 0 addr of multi devices when dio mapping
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Wu Bo <wubo.oduw@gmail.com>
References: <20240329065508.2398202-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240329065508.2398202-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/3/29 14:55, Wu Bo wrote:
> Consider of a f2fs system with 2 devices:
> Info: Device[0] : /dev/block/dm-46 blkaddr = 0--3fffff
> Info: Device[1] : /dev/block/dm-47 blkaddr = 400000--67fffff
> 
> f2fs_map_blocks will return logical addr of fs when doing buffered io:
> f2fs_map_blocks: dev = (254,46), ino = 40020, file offset = 462865, start blkaddr = 0x400000
> 
> While dio mapping will return the addr of device:
> f2fs_map_blocks: dev = (254,47), ino = 40020, file offset = 462865, start blkaddr = 0x0
> 
> So the addr=0 is valid when the map.m_bdev is not s_bdev.

Thanks for catching this, there is already a formal patch as below link:

https://lore.kernel.org/linux-f2fs-devel/20240327074223.2216487-1-chao@kernel.org

Thanks,

> 
> Fixes: 8d3c1fa3fa5e ("f2fs: don't rely on F2FS_MAP_* in f2fs_iomap_begin")
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>   fs/f2fs/data.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d9494b5fc7c1..dca3628932c7 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -4185,7 +4185,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
>   	if (WARN_ON_ONCE(map.m_pblk == COMPRESS_ADDR))
>   		return -EINVAL;
>   
> -	if (map.m_pblk != NULL_ADDR) {
> +	if (map.m_pblk != NULL_ADDR ||
> +		(map.m_multidev_dio && map.m_bdev != inode->i_sb->s_bdev)) {
>   		iomap->length = blks_to_bytes(inode, map.m_len);
>   		iomap->type = IOMAP_MAPPED;
>   		iomap->flags |= IOMAP_F_MERGED;

