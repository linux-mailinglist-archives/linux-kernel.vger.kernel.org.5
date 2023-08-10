Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A425F7773E9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbjHJJNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjHJJMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:12:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD8D2717;
        Thu, 10 Aug 2023 02:12:43 -0700 (PDT)
Received: from [192.168.0.125] (unknown [82.76.24.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ehristev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 969606607217;
        Thu, 10 Aug 2023 10:12:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691658762;
        bh=0Iq8D34Lbklgdl/9jdr8DFLgHMB7aekBr8AJu2XlV50=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VerEY/cM1db+oPVxME0Q0OW16JQXahZtGoZtorW3gNTu7iVDPYgMe+ssBYklK6br6
         mZrCxKjoGOJIYy4q2nMMt4lfeDiNRDl1/BW3+AdbGVRdh8KuXTWbUlnuxKvQ55GsSo
         IXB5sCWsF10W1YYMs3vIZACJNA28yPd8aHMuFkltth0QFS6x/vctNvATIQXF/J42pB
         eBodvnmQe8zkxCathdhkxEY5st4ZrdO80hB6utUhP5lFfiAjs95Hizbctlr8dKFPiD
         UtNdSvHYFIJjHHE2nBdb9uPPkrrT1s81NYo0cjrnjOto7HOTgiW6WarIUqdGYlBb5/
         72J4fNOYiiU9Q==
Message-ID: <45d0f538-9769-f4eb-7479-cf676337ff55@collabora.com>
Date:   Thu, 10 Aug 2023 12:12:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] media: vcodec: Fix potential array out-of-bounds in
 encoder queue_setup
Content-Language: en-US
To:     Wei Chen <harperchen1110@gmail.com>, tiffany.lin@mediatek.com
Cc:     andrew-ct.chen@mediatek.com, yunfei.dong@mediatek.com,
        mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, stable@vger.kernel.org
References: <20230810082333.972165-1-harperchen1110@gmail.com>
From:   Eugen Hristev <eugen.hristev@collabora.com>
In-Reply-To: <20230810082333.972165-1-harperchen1110@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On 8/10/23 11:23, Wei Chen wrote:
> variable *nplanes is provided by user via system call argument. The
> possible value of q_data->fmt->num_planes is 1-3, while the value
> of *nplanes can be 1-8. The array access by index i can cause array
> out-of-bounds.
> 
> Fix this bug by checking *nplanes against the array size.
> 
> Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
> Signed-off-by: Wei Chen <harperchen1110@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Add Fixes tag and CC stable email address
I guess stable needs to be added by the maintainer, not by the submitter

> - Change the title to be more expressive

Subject message should include mediatek I believe, as `media: vcodec:` 
does not reference the mediatek vcodec.

> 
>   drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> index 9ff439a50f53..9e8817863cb8 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> @@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
>   		return -EINVAL;
>   
>   	if (*nplanes) {
> +		if (*nplanes != q_data->fmt->num_planes)
> +			return -EINVAL;

Have you run v4l2-compliance on the device to make sure nothing is broken ?

>   		for (i = 0; i < *nplanes; i++)
>   			if (sizes[i] < q_data->sizeimage[i])
>   				return -EINVAL;


Greetings,
