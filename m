Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792B97B6A64
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjJCNXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjJCNXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:23:16 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD41A3
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:23:12 -0700 (PDT)
X-KPN-MessageId: fe5816ca-61ef-11ee-b94e-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id fe5816ca-61ef-11ee-b94e-005056992ed3;
        Tue, 03 Oct 2023 15:23:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=fBK3ZyyNKocOX4XjWS5oCsnNQEjc4aFYVR6szoxTD5I=;
        b=XzRY5BPWurc8EfXN20Oz0kk03McgTiKUs6fVEhPfvc930mwudc8ozVwMtMRZmAPv3AZ7WwXjQffl9
         izLLpmj8prh5NVgJ5zewR7ZvWEnMwDaWPozS+acLbwf5gvBmNa6noMIGTcFSXtZvNiQ+zLhenuK/FE
         aVzvwadVniFZmcAy/tKBipfMzRQQSpUC9pf3c0NZ292kle0rpnipfv5m1gfqI3AqBSVTM6+MkBjrUk
         r8I1bGBCcZTqEw6eKEJHlxHojJ8Hopg1bCFiikMmH/NIjA5sKeFYr2xu9Z6LYyxUfoSx4HG5VXqjPs
         /84/o98Ytj39laYZCiTpPoD9mv6pRpw==
X-KPN-MID: 33|eB3i4tWe0ravoetkyYEFHpSo0xF7TJz17Bl3Dx3b1C1g6gtg8Qi/lzttKb83xZX
 qzAnwsZadIevXQWKCEsDZfnRuhLQd+WWAODKZjAgsk/s=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|wYgDMpCR3QkPrGwrvjNYY8xiXfxcQUNl2Fk/1tQ25S6jTgB1LG6Dn5x55UmqYxR
 WxXWzKzVNKlYcEmctrsTfVw==
X-Originating-IP: 173.38.220.46
Received: from [10.47.77.214] (unknown [173.38.220.46])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id fe05b6bb-61ef-11ee-ad2d-005056998788;
        Tue, 03 Oct 2023 15:23:08 +0200 (CEST)
Message-ID: <1e5bb09f-be36-4fc6-88f3-8f6565b6147f@xs4all.nl>
Date:   Tue, 3 Oct 2023 15:23:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: nuvoton: npcm-video: Fix sleeping in atomic
 context
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org
Cc:     dan.carpenter@linaro.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        avifishman70@gmail.com, tmaimon77@gmail.com, kwliu@nuvoton.com,
        kflin@nuvoton.com
References: <20231003075512.2081141-1-milkfafa@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231003075512.2081141-1-milkfafa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/23 09:55, Marvin Lin wrote:
> Fix sleeping in atomic context warnings reported by the Smatch static
> analysis tool. Use GFP_ATOMIC instead of GFP_KERNEL in atomic context.
> 
> Fixes: 70721089985c ("media: nuvoton: Add driver for NPCM video capture and encoding engine")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---
>  drivers/media/platform/nuvoton/npcm-video.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/nuvoton/npcm-video.c b/drivers/media/platform/nuvoton/npcm-video.c
> index ac8d73b794d3..5d160978f7b3 100644
> --- a/drivers/media/platform/nuvoton/npcm-video.c
> +++ b/drivers/media/platform/nuvoton/npcm-video.c
> @@ -412,7 +412,7 @@ static unsigned int npcm_video_add_rect(struct npcm_video *video,
>  	struct rect_list *list = NULL;
>  	struct v4l2_rect *r;
>  
> -	list = kzalloc(sizeof(*list), GFP_KERNEL);
> +	list = kzalloc(sizeof(*list), GFP_ATOMIC);
>  	if (!list)
>  		return 0;
>  
> @@ -467,7 +467,7 @@ static struct rect_list *npcm_video_new_rect(struct npcm_video *video,
>  	struct rect_list *list = NULL;
>  	struct v4l2_rect *r;
>  
> -	list = kzalloc(sizeof(*list), GFP_KERNEL);
> +	list = kzalloc(sizeof(*list), GFP_ATOMIC);
>  	if (!list)
>  		return NULL;
>  

I'm not really sure this is the right approach.

Looking closer at the code I notice that npcm_video_irq is a threaded
interrupt handler, so wouldn't it be easier to change the video->lock
spinlock to a mutex?

Regards,

	Hans
