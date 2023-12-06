Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3197280705D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378224AbjLFM5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjLFM5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:57:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389C6FA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:57:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC61C433CB;
        Wed,  6 Dec 2023 12:57:47 +0000 (UTC)
Message-ID: <2c9b85dc-ebd7-43a7-bb66-d96ba9a28082@xs4all.nl>
Date:   Wed, 6 Dec 2023 13:57:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 09/11] media: s5p-mfc: Load firmware for each run in
 MFCv12.
Content-Language: en-US, nl
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        linux-samsung-soc@vger.kernel.org, andi@etezian.org,
        gost.dev@samsung.com, alim.akhtar@samsung.com,
        aswani.reddy@samsung.com, pankaj.dubey@samsung.com,
        ajaykumar.rs@samsung.com, linux-fsd@tesla.com,
        Smitha T Murthy <smithatmurthy@gmail.com>
References: <20231206063045.97234-1-aakarsh.jain@samsung.com>
 <CGME20231206063134epcas5p2b3b9ca0351cd9c1cb169d7a4a3a30b80@epcas5p2.samsung.com>
 <20231206063045.97234-10-aakarsh.jain@samsung.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20231206063045.97234-10-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2023 07:30, Aakarsh Jain wrote:
> In MFCv12, some section of firmware gets updated at each MFC run.
> Hence we need to reload original firmware for each run at the start.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Smitha T Murthy <smithatmurthy@gmail.com>
> Signed-off-by: Aakarsh Jain <aakarsh.jain@samsung.com>
> ---
>  drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> index b49159142c53..24dd40ae71ec 100644
> --- a/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> +++ b/drivers/media/platform/samsung/s5p-mfc/s5p_mfc_ctrl.c
> @@ -51,8 +51,10 @@ int s5p_mfc_load_firmware(struct s5p_mfc_dev *dev)
>  	 * into kernel. */
>  	mfc_debug_enter();
>  
> -	if (dev->fw_get_done)
> -		return 0;
> +	/* Load MFC v12 firmware for each run when MFC runs sequentially */

You had a much longer explanation in your reply to my original question.

I think it is better if that longer explanation is added here.

Things that are weird and unexpected need good comments, explaining why
it is done, and also what you know and do not know about this.

E.g. you know through trial and error that it is needed (or perhaps you
got information on this some the fw team), but there might be open questions
that are not yet answered.

This is all information that you can't get from the source code since it has
to do with the black box firmware. So putting all you know in a comment is
the best way of communicating this to future readers of the source code.

Regards,

	Hans

> +	if (!IS_MFCV12(dev))
> +		if (dev->fw_get_done)
> +			return 0;
>  
>  	for (i = MFC_FW_MAX_VERSIONS - 1; i >= 0; i--) {
>  		if (!dev->variant->fw_name[i])

