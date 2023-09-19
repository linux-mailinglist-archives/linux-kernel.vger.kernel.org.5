Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223DF7A6101
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjISLQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbjISLQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:16:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740CAFC;
        Tue, 19 Sep 2023 04:16:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544B8C433C8;
        Tue, 19 Sep 2023 11:16:05 +0000 (UTC)
Message-ID: <cbfef598-8faa-40e6-8dc2-a1efd03f9560@xs4all.nl>
Date:   Tue, 19 Sep 2023 13:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 16/49] media: verisilicon: postproc: Fix down scale
 test
Content-Language: en-US, nl
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20230914133323.198857-1-benjamin.gaignard@collabora.com>
 <20230914133323.198857-17-benjamin.gaignard@collabora.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230914133323.198857-17-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2023 15:32, Benjamin Gaignard wrote:
> Do not allow down scaling if the source buffer resolution is
> smaller  than destination one.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Fixes: fbb6c848dd89 ("media: destage Hantro VPU driver")

Is this really a fix? I gather that this relies on "VP9 resolution change without
doing stream off/on" support, and support for that is added by these patches.

Adding the Fixes tag would cause stable maintainers to queue this patch up for
older kernels, but I don't think that is needed here at all.

And related I also think that this really does not belong to this patch series.

As I understand it, patch 13/49 extends the verisilicon driver to support more
than 32 buffers, so that one makes sense in the context of this series.

But the other verisilicon patches appear to be unrelated and instead add a new
feature, and I don't believe it relates to this series at all.

If I am right, then please post this as a separate series, possibly mentioning
that it sits on top of this series.

Regards,

	Hans

> ---
>  drivers/media/platform/verisilicon/hantro_postproc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drivers/media/platform/verisilicon/hantro_postproc.c
> index e624cd98f41b..77d8ecfbe12f 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -107,7 +107,7 @@ static void hantro_postproc_g1_enable(struct hantro_ctx *ctx)
>  
>  static int down_scale_factor(struct hantro_ctx *ctx)
>  {
> -	if (ctx->src_fmt.width == ctx->dst_fmt.width)
> +	if (ctx->src_fmt.width <= ctx->dst_fmt.width)
>  		return 0;
>  
>  	return DIV_ROUND_CLOSEST(ctx->src_fmt.width, ctx->dst_fmt.width);

