Return-Path: <linux-kernel+bounces-37926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C04B83B859
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 04:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6901C21706
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D610A79C3;
	Thu, 25 Jan 2024 03:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cpk4h8KO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251CA6FB6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706153677; cv=none; b=gpd6PKJVX1Q5dzzaT2Y9tBNvSZLp3zcRuaVlVO+iCnbJ98BYyh/hLmNRtnecn4Hzzv9CxPENGRKJjyvTWKws1E77OtKZN+CHV8y9ryiuA1GPCeEaQcCohJD74DwpPd/jdprsmL99KYvCj4Re6wN91010oj0tAubobfzEKHMB4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706153677; c=relaxed/simple;
	bh=5nKlkdVTP90VlmmNuw9xvFlkteOuuubePKwYu2lTc2Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Go1YlOTRbc429keW6iwosnElLxfaU0/O9PYaim7eaiXFDAXKPRAXN8N0du2EHjXwJWEW4fuaQsOlYFgixdMIKA3yytEohcZz8QA/tbWW56P0aQ/u/Cid/OH05e+SBWU923iQhKPH8fKCX+0vfMmfxb1ruDW+nAc3AC3Aejx4AHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cpk4h8KO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3CBC433F1;
	Thu, 25 Jan 2024 03:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706153676;
	bh=5nKlkdVTP90VlmmNuw9xvFlkteOuuubePKwYu2lTc2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Cpk4h8KOwrzfshK6xRI4StxzD92WE9EX2ADLsHospm0v8cP72aQ32l4HbC6Yz0WA/
	 6JQdG8wvKXMPFN8KjfNfV0yECRq+VlRwFsD0b7+grCUE8o62KSRHl70o2BPM+HkYqf
	 PAgpuY0hq74NGMFXnfrphamHsoWFx+aqS6y4S/Y13TY1DeSG6GAWuIuM6PUjL9b3YR
	 BJB7XWUhGXx7rvnwb0ZPcPDzT5+eyZUZlvf4b6P99LeQCDCyzpkvNBM46N7UZvihdz
	 AJQ6RilSTj/yb1wv+2N46AFxwLDvbV90oFmBRc+2C+XNdUgXW8R1q5OHFAlRVAsXKL
	 SNdPyUfN9o5/g==
Message-ID: <df9645d9-1e9a-4bd2-88bb-26425cf45811@kernel.org>
Date: Thu, 25 Jan 2024 11:34:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: allocate logs after conventional
 area for HM zoned devices
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>,
 Yongpeng Yang <yangyongpeng1@oppo.com>
References: <20240117230032.2312067-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240117230032.2312067-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Cc Yongpeng Yang

Daeho,

Yongpeng reports a potential issue: if c.devices[0].total_segments is
larger than segments of mainarea, c.cur_seg[CURSEG_HOT_NODE] will exceed
end boundary of mainarea. Could you please check that? though it's a corner
case.

On 2024/1/18 7:00, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Make to allocate logs after conventional area for HM zoned devices to
> spare them for file pinning support.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>   mkfs/f2fs_format.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index f2840c8..91a7f4b 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -557,7 +557,8 @@ static int f2fs_prepare_super_block(void)
>   		c.cur_seg[CURSEG_COLD_DATA] = 0;
>   		c.cur_seg[CURSEG_WARM_DATA] = next_zone(CURSEG_COLD_DATA);
>   	} else if (c.zoned_mode) {
> -		c.cur_seg[CURSEG_HOT_NODE] = 0;
> +		c.cur_seg[CURSEG_HOT_NODE] = c.zoned_model == F2FS_ZONED_HM ?
> +			c.devices[0].total_segments : 0;
>   		c.cur_seg[CURSEG_WARM_NODE] = next_zone(CURSEG_HOT_NODE);
>   		c.cur_seg[CURSEG_COLD_NODE] = next_zone(CURSEG_WARM_NODE);
>   		c.cur_seg[CURSEG_HOT_DATA] = next_zone(CURSEG_COLD_NODE);

