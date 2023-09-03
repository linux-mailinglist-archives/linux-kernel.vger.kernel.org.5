Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A90D790DE1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 22:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347752AbjICUXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 16:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbjICUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 16:23:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6BBF7;
        Sun,  3 Sep 2023 13:23:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8867460BEF;
        Sun,  3 Sep 2023 20:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCADC433C8;
        Sun,  3 Sep 2023 20:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693772620;
        bh=dGeWDYffGXpYdRIjbzwkZnHNen8yfRyoIpJPK7mrlhg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bmU7K7ryj4099spbk1nlKsJGrrwvu4a/0ZewREUVQM+JubSpMcHS0qUj1Nkm9HC5o
         W2d7dRcCMOvZV5TTe4+AMNxD6aIgST2SUeFSq1Mt48Mv4/nEmsRJ6GBnRoJnAcomwj
         ka8BAfJJf2I6CtiTRaZjNu2HeRZFt+H2G9ku7JfZ2E5+dgiLnmel0jxkzHHzCCVXcU
         Xjm/jLj8YuB6wYcVW4B1sH0QSLoIyF+XKMzVmZW8bFATS5Ga3StVNrjz+3pXoiX9eo
         m/blwEZR4ZCqVyPOWe8jIVZu9eVG7Dnqkczd+HSlcT8XmNpyEGaoeI61ne0w/S/zhq
         vXpEBs1ErC1Iw==
Date:   Sun, 3 Sep 2023 22:23:36 +0200
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Katya Orlova <e.orlova@ispras.ru>
Cc:     Sylwester Nawrocki <sylvester.nawrocki@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] media: s3c-camif: Avoid inappropriate kfree()
Message-ID: <20230903202336.qjdg6zw6otig2qdv@zenone.zhora.eu>
References: <20230824090725.28148-1-e.orlova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824090725.28148-1-e.orlova@ispras.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Katya,

On Thu, Aug 24, 2023 at 12:07:25PM +0300, Katya Orlova wrote:
> s3c_camif_register_video_node() works with video_device structure stored
> as a field of camif_vp,
> so it should not be kfreed. But there is video_device_release() on error
> path that do it.

that's correct, the video_device is allocated with the camif_dev
allocation.

> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")
> Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
> ---
>  drivers/media/platform/samsung/s3c-camif/camif-capture.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/platform/samsung/s3c-camif/camif-capture.c b/drivers/media/platform/samsung/s3c-camif/camif-capture.c
> index 76634d242b10..79c8ee845c38 100644
> --- a/drivers/media/platform/samsung/s3c-camif/camif-capture.c
> +++ b/drivers/media/platform/samsung/s3c-camif/camif-capture.c
> @@ -1172,7 +1172,6 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
>  err_me_cleanup:
>  	media_entity_cleanup(&vfd->entity);
>  err_vd_rel:
> -	video_device_release(vfd);

The best fix, though, is to completely get rid of the
"err_vd_rel" goto label. You mind doint that on a v2?

Thanks,
Andi

>  	return ret;
>  }
>  
> -- 
> 2.30.2
> 
