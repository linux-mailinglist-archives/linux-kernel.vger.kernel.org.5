Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248B97DD155
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 17:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344963AbjJaQN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 12:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344932AbjJaQNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 12:13:52 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E67BA6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 09:13:50 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39VGDY9f129042;
        Tue, 31 Oct 2023 11:13:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1698768814;
        bh=hfNbY2AmnmOKK0h6VK9HtZx1Vqfd5+Nfz21HDYq/4xA=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=EBZnQQoYJi7WPOLBNKcqfKCQQbC46uBoGqv9Zk2gU7+niavim+2aYmXuF+MNbDPMP
         BfcRVQDkDY0n4Pvot9dWM/snVmaVVVhLrybPw5Z/L6tyftFU3R6/IKqvGX1Ky6sQZp
         lTydj0gPEfJYzEtlKE1EFMfzPzNZjwqUW4sPucPg=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39VGDYQV081239
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 31 Oct 2023 11:13:34 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 31
 Oct 2023 11:13:34 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 31 Oct 2023 11:13:34 -0500
Received: from [10.249.132.69] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39VGDURk016065;
        Tue, 31 Oct 2023 11:13:31 -0500
Message-ID: <c7932fed-176f-e113-9a80-f6c5528a9414@ti.com>
Date:   Tue, 31 Oct 2023 21:43:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] drm/tilcdc: Fix irq free on unload
Content-Language: en-US
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>
References: <20230919-lcdc-v1-1-ba60da7421e1@ideasonboard.com>
From:   Aradhya Bhatia <a-bhatia1@ti.com>
In-Reply-To: <20230919-lcdc-v1-1-ba60da7421e1@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19-Sep-23 12:42, Tomi Valkeinen wrote:
> The driver only frees the reserved irq if priv->irq_enabled is set to
> true. However, the driver mistakenly sets priv->irq_enabled to false,
> instead of true, in tilcdc_irq_install(), and thus the driver never
> frees the irq, causing issues on loading the driver a second time.
> 
> Fixes: b6366814fa77 ("drm/tilcdc: Convert to Linux IRQ interfaces")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---

Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>

Regards
Aradhya

>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index fe56beea3e93..83233bdc0526 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -138,7 +138,7 @@ static int tilcdc_irq_install(struct drm_device *dev, unsigned int irq)
>  	if (ret)
>  		return ret;
>  
> -	priv->irq_enabled = false;
> +	priv->irq_enabled = true;
>  
>  	return 0;
>  }
> 
> ---
> base-commit: 0663e1da5ba8e6459e3555ac12c62741668c0d30
> change-id: 20230919-lcdc-9e09e94f4e93
> 
> Best regards,

