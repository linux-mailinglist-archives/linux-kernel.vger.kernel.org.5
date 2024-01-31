Return-Path: <linux-kernel+bounces-46910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BDA844644
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D744E283A21
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8912DDAC;
	Wed, 31 Jan 2024 17:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nF3k3kVD"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FCF12CDB4;
	Wed, 31 Jan 2024 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722624; cv=none; b=hXP09YexvkSObnJdVrLLeldvLVD0HoaUPN6HrXnqIlvsJYusdiQPuKYgNJJXnX4PmIjNsUVo/XJLC4SxNGnlzMYhtNefOO0v/FcXy/oC/7TcKau20InK8bRCXdSUVUa6HA+CDnc0Pr9kCKAa3HmCXYye4GE3AMo+px/IfClrvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722624; c=relaxed/simple;
	bh=a0P+lMRjYaPeMolIYIQjzbUFgcGY/qyTR/5pwhzuHxo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YnoJLJFtQhqi63zLfYrHI4xHTyvrBbkj3U0BZBCOkVMzkQ3iMmVKyD5MLQYw4VgGo2wg6jPTJd/+oHn+6cWo00h8wuqKT72Ent5lD+zBD90WwaXYSpk3El8nv18QfXfBRVaE8qJSsF+SvfyPUl5r/C+UdRyhfxjxhn55XSPVFB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=nF3k3kVD; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40VHapN8063748;
	Wed, 31 Jan 2024 11:36:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706722611;
	bh=WTTPI1YMhpzX7MWjUurK3vAS6Baqvui9xeLzvJebuv8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=nF3k3kVDrFKU7N8UmIlEnj4ehPEIiEnuKbgPH6/RDKHxFr6Y3CC6WEkGxKJCQJUkj
	 kJzARE4OARJhVc1GMn0wemuf5vCenkfaQdABMr94tpVYVAuJqHdLehrjd2QMbdkvmO
	 kVkxi+aP1fDEePWosC0ulK/4qkkHuSHdELKM1XiY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40VHap0o002539
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 31 Jan 2024 11:36:51 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 11:36:51 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 11:36:51 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40VHaoT6060251;
	Wed, 31 Jan 2024 11:36:50 -0600
Message-ID: <7bc035db-607a-48db-b497-4bc29d0a805c@ti.com>
Date: Wed, 31 Jan 2024 11:36:50 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v0 4/5] wave5: Use the bitstream buffer size from
 host.
Content-Language: en-US
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, <mchehab@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nas.chung@chipsnmedia.com>
CC: <lafley.kim@chipsnmedia.com>, <b-brnich@ti.com>
References: <20240131013046.15687-1-jackson.lee@chipsnmedia.com>
 <20240131013046.15687-5-jackson.lee@chipsnmedia.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240131013046.15687-5-jackson.lee@chipsnmedia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/30/24 7:30 PM, jackson.lee wrote:
> In V4L2 spec, Host can set the bitstream buffer size.
> Allow the larger size between default size and input size.
> 
> Signed-off-by: Jackson Lee <jackson.lee@chipsnmedia.com>
> Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> ---
>   drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> index ff73d69de41c..19018ace41b6 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> @@ -11,6 +11,10 @@
>   #define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
>   #define VPU_ENC_DRV_NAME "wave5-enc"
>   
> +#define DEFAULT_SRC_SIZE(width, height) ({			\
> +	(width) * (height) / 8 * 3;					\

These "\" are tabbed out way to far, and not to the same amount..
Why have this in {;} brackets?
Why multiple lines?
Just:

#define DEFAULT_SRC_SIZE(width, height) ((width) * (height) / 8 * 3)

Andrew

> +})
> +
>   static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] = {
>   	[VPU_FMT_TYPE_CODEC] = {
>   		{
> @@ -193,7 +197,8 @@ static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp, unsigned
>   		pix_mp->width = width;
>   		pix_mp->height = height;
>   		pix_mp->plane_fmt[0].bytesperline = 0;
> -		pix_mp->plane_fmt[0].sizeimage = width * height / 8 * 3;
> +		pix_mp->plane_fmt[0].sizeimage = max(DEFAULT_SRC_SIZE(width, height),
> +						     pix_mp->plane_fmt[0].sizeimage);
>   		break;
>   	}
>   }

