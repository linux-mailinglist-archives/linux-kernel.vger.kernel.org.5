Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DDA7F2911
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjKUJi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:38:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjKUJiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:38:25 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B891
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:38:21 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1r5NCX-00051K-Va; Tue, 21 Nov 2023 10:37:50 +0100
Message-ID: <fb963c37-db12-0f1c-c9a6-d67095ccaba1@pengutronix.de>
Date:   Tue, 21 Nov 2023 10:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: imx: Check return value of devm_kasprintf in
 imx_mmdc_perf_init
Content-Language: en-US
To:     Kunwu Chan <chentao@kylinos.cn>, linux@armlinux.org.uk,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, angus.chen@jaguarmicro.com,
        arnd@arndb.de, u.kleine-koenig@pengutronix.de
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kunwu.chan@hotmail.com
References: <20231121092526.6708-1-chentao@kylinos.cn>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20231121092526.6708-1-chentao@kylinos.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Kunwu,

On 21.11.23 10:25, Kunwu Chan wrote:
> devm_kasprintf() returns a pointer to dynamically allocated memory
> which can be NULL upon failure. Ensure the allocation was successful
> by checking the pointer validity.
> 
> Fixes: ebeb49f43c89 ("ARM: imx: Call ida_simple_remove() for ida_simple_get")

This commit only moves the allocation around, but it didn't introduce it.
Please reference the first commit that added the allocation.

> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> ---
>  arch/arm/mach-imx/mmdc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
> index 2157493b78a9..7c471d6a851d 100644
> --- a/arch/arm/mach-imx/mmdc.c
> +++ b/arch/arm/mach-imx/mmdc.c
> @@ -501,6 +501,10 @@ static int imx_mmdc_perf_init(struct platform_device *pdev, void __iomem *mmdc_b
>  
>  	name = devm_kasprintf(&pdev->dev,
>  				GFP_KERNEL, "mmdc%d", ret);
> +	if (!name) {
> +		ret = -ENOMEM;
> +		goto pmu_free;

Cleanup is incomplete if you goto pmu_free, e.g. ida_simple_remove()
isn't called. pmu_register_err does too much cleanup, so you'll need
to add a new cleanup label.

Cheers,
Ahmad


> +	}
>  
>  	pmu_mmdc->mmdc_ipg_clk = mmdc_ipg_clk;
>  	pmu_mmdc->devtype_data = (struct fsl_mmdc_devtype_data *)of_id->data;

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

