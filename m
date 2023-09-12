Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D99B279C7AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjILHHH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 12 Sep 2023 03:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjILHHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:07:06 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F45AE79
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:07:02 -0700 (PDT)
X-UUID: 4c5f962676df41fd88c33b35345abea5-20230912
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:99d3588d-76c7-47f3-8d5b-9077c3b64bd4,IP:5,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-4
X-CID-INFO: VERSION:1.1.31,REQID:99d3588d-76c7-47f3-8d5b-9077c3b64bd4,IP:5,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:-4
X-CID-META: VersionHash:0ad78a4,CLOUDID:17ad98ef-9a6e-4c39-b73e-f2bc08ca3dc5,B
        ulkID:2309121506533HBDAXDZ,BulkQuantity:0,Recheck:0,SF:19|43|64|38|24|17|1
        02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-UUID: 4c5f962676df41fd88c33b35345abea5-20230912
X-User: zhouzongmin@kylinos.cn
Received: from [172.20.12.156] [(111.48.58.12)] by mailgw
        (envelope-from <zhouzongmin@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1882865759; Tue, 12 Sep 2023 15:06:52 +0800
Message-ID: <0fce832b81d676da8bde28bc7acf4d56932f244d.camel@kylinos.cn>
Subject: Re: [RESEND PATCH] drm/qxl: prevent memory leak
From:   zongmin zhou <zhouzongmin@kylinos.cn>
To:     airlied@redhat.com, kraxel@redhat.com, airlied@gmail.com,
        daniel@ffwll.ch
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Sep 2023 15:06:35 +0800
In-Reply-To: <20230801025309.4049813-1-zhouzongmin@kylinos.cn>
References: <20230425014543.3448839-1-zhouzongmin@kylinos.cn>
         <20230801025309.4049813-1-zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-01 at 10:53 +0800, Zongmin Zhou wrote:
> The allocated memory for qdev->dumb_heads should be released
> in qxl_destroy_monitors_object before qxl suspend.
> otherwise,qxl_create_monitors_object will be called to
> reallocate memory for qdev->dumb_heads after qxl resume,
> it will cause memory leak.
> 
> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
> ---
>  drivers/gpu/drm/qxl/qxl_display.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/qxl/qxl_display.c
> b/drivers/gpu/drm/qxl/qxl_display.c
> index 6492a70e3c39..404b0483bb7c 100644
> --- a/drivers/gpu/drm/qxl/qxl_display.c
> +++ b/drivers/gpu/drm/qxl/qxl_display.c
> @@ -1229,6 +1229,9 @@ int qxl_destroy_monitors_object(struct
> qxl_device *qdev)
>         if (!qdev->monitors_config_bo)
>                 return 0;
>  
> +       kfree(qdev->dumb_heads);
> +       qdev->dumb_heads = NULL;
> +
>         qdev->monitors_config = NULL;
>         qdev->ram_header->monitors_config = 0;
>  
Friendly ping...

Hello, I sent this patch a few months ago.
Could you please help me review it as well and see if there are any
issues?

I'm looking forward to your reply.
Thanks
