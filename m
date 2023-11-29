Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F4E7FCC98
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 03:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjK2CLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 21:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjK2CLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 21:11:01 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF557198D;
        Tue, 28 Nov 2023 18:11:03 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8EF8924E29A;
        Wed, 29 Nov 2023 10:10:55 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 10:10:54 +0800
Received: from [192.168.125.107] (113.72.145.176) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 29 Nov
 2023 10:10:53 +0800
Message-ID: <cc617644-029e-4671-8231-a2b01627a08f@starfivetech.com>
Date:   Wed, 29 Nov 2023 10:10:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: staging: starfive: camss: fix off by one in
 isp_enum_mbus_code()
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        Jack Zhu <jack.zhu@starfivetech.com>
CC:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>, <linux-staging@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <7d222638-2d19-466d-8dd4-9e1ceb1d46f3@moroto.mountain>
Content-Language: en-US
From:   Changhuang Liang <changhuang.liang@starfivetech.com>
In-Reply-To: <7d222638-2d19-466d-8dd4-9e1ceb1d46f3@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [113.72.145.176]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX162.cuchost.com
 (172.16.6.72)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/11/28 22:40, Dan Carpenter wrote:
> These > comparisons should be >=.  The formats->fmts[] array is either
> a pointer to isp_formats_sink[] or isp_formats_source[] respectively.
> 
> Fixes: e57854628f58 ("media: staging: media: starfive: camss: Add ISP driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>

> ---
>  drivers/staging/media/starfive/camss/stf-isp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/media/starfive/camss/stf-isp.c b/drivers/staging/media/starfive/camss/stf-isp.c
> index 893dbd8cddc8..98d61d71c31b 100644
> --- a/drivers/staging/media/starfive/camss/stf-isp.c
> +++ b/drivers/staging/media/starfive/camss/stf-isp.c
> @@ -120,7 +120,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
>  	const struct stf_isp_format_table *formats;
>  
>  	if (code->pad == STF_ISP_PAD_SINK) {
> -		if (code->index > ARRAY_SIZE(isp_formats_sink))
> +		if (code->index >= ARRAY_SIZE(isp_formats_sink))
>  			return -EINVAL;
>  
>  		formats = &isp_dev->formats[SINK_FORMATS_INDEX];
> @@ -128,7 +128,7 @@ static int isp_enum_mbus_code(struct v4l2_subdev *sd,
>  	} else {
>  		struct v4l2_mbus_framefmt *sink_fmt;
>  
> -		if (code->index > ARRAY_SIZE(isp_formats_source))
> +		if (code->index >= ARRAY_SIZE(isp_formats_source))
>  			return -EINVAL;
>  
>  		sink_fmt = v4l2_subdev_state_get_format(state,
