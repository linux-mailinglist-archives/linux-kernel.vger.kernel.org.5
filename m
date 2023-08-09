Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E023177517F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 05:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbjHIDoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 23:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjHIDoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 23:44:01 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A0D1BC3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 20:43:59 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-686ba29ccb1so364188b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 20:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1691552638; x=1692157438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9oG4d/I8ir4/ruptehuylR56CYQvHC70jqVbzmkpk3I=;
        b=m0M9ESztIHd3k/4YAEahMQomo6yS3F+Z9cnYY9pM75iWtstE5bi9Po13NS3EXiM21r
         m4pY71hARK8luqnGo58LY6/hxXAVNtN58gy1tW5UBmG5vCJHq1FArK6iULv7VFqzRdiL
         QSgHmTtAvJANKMWjYGv0kTKGMtSpjSMVQYb40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691552638; x=1692157438;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oG4d/I8ir4/ruptehuylR56CYQvHC70jqVbzmkpk3I=;
        b=bRRKjfMWeAM71VFsswdgKOJYdiC6XlrTeTx5IsUB1myM/vrPpxYRl+8z1nHyLdfIUQ
         4JcVq8wDSqjQ/+OcN44O+SbLks+6K1/EGXHyytubWZqxEcpxDUmG5CA+Es49fSlj2hF0
         YkSCKn2IGK93X/niyKd30weJ9SPAJISuPB7cP+pk/zEPPnaflY64Mya5plU6vZRuro7u
         XouGuA2zNSu+hNmUUu0OGqHsYylYK1L5D2FS/SbH8d85yzMrJ39PQ5jpxj9N6El5fkvI
         Tt4eKiAC+UowYPR6pc3VudKV2+XFSXmcBcHzCTMBbCG6pfdFD9zvKaNftVVwpzgZfGeA
         Y3/A==
X-Gm-Message-State: AOJu0YxEHO9x6WKVLJBV7ZaRriaBk7vgVFmcXBBIa2dakB4mGF/V9+Dr
        TPLKUr2aSof1SjNdMZuscvV/7w==
X-Google-Smtp-Source: AGHT+IFHhyziILszxrpiAnFzHo8VltBiti0umAg2qsyWqMRc7sZaS1IAqOQed/uisVP/DuAKoVJv7w==
X-Received: by 2002:a05:6a00:2347:b0:684:bb4a:b86e with SMTP id j7-20020a056a00234700b00684bb4ab86emr2217159pfj.1.1691552638606;
        Tue, 08 Aug 2023 20:43:58 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:eed6:5c4f:9687:371])
        by smtp.gmail.com with ESMTPSA id h3-20020a633843000000b00564aee22f33sm7217056pgn.14.2023.08.08.20.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 20:43:58 -0700 (PDT)
Date:   Wed, 9 Aug 2023 11:43:55 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Wei Chen <harperchen1110@gmail.com>
Cc:     tiffany.lin@mediatek.com, andrew-ct.chen@mediatek.com,
        yunfei.dong@mediatek.com, mchehab@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] media: vcodec: Fix potential array out-of-bounds in
 vb2ops_venc_queue_setup
Message-ID: <20230809034355.GA589411@google.com>
References: <20230328092608.523933-1-harperchen1110@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328092608.523933-1-harperchen1110@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 09:26:08AM +0000, Wei Chen wrote:
> variable *nplanes is provided by user via system call argument. The
> possible value of q_data->fmt->num_planes is 1-3, while the value
> of *nplanes can be 1-8. The array access by index i can cause array
> out-of-bounds.
> 
> Fix this bug by checking *nplanes against the array size.

This should have a fixes tag:

Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")

And also CC the stable list:

Cc: stable@vger.kernel.org

> Signed-off-by: Wei Chen <harperchen1110@gmail.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>

> ---
>  drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> index d65800a3b89d..1ea02f9136f6 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
> @@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struct vb2_queue *vq,
>  		return -EINVAL;
>  
>  	if (*nplanes) {
> +		if (*nplanes != q_data->fmt->num_planes)
> +			return -EINVAL;
>  		for (i = 0; i < *nplanes; i++)
>  			if (sizes[i] < q_data->sizeimage[i])
>  				return -EINVAL;
> -- 
> 2.25.1
> 
