Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86E37D1D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 15:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjJUM4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjJUM4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 08:56:36 -0400
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92038D63;
        Sat, 21 Oct 2023 05:56:32 -0700 (PDT)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id F22DA207BA;
        Sat, 21 Oct 2023 14:56:25 +0200 (CEST)
Received: from livingston (unknown [192.168.42.11])
        by gaggiata.pivistrello.it (Postfix) with ESMTP id AAF537FA89;
        Sat, 21 Oct 2023 14:56:25 +0200 (CEST)
Received: from pivi by livingston with local (Exim 4.96)
        (envelope-from <francesco@dolcini.it>)
        id 1quBWj-0002k7-1n;
        Sat, 21 Oct 2023 14:56:25 +0200
Date:   Sat, 21 Oct 2023 14:56:25 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        Sharvari Harisangam <sharvari.harisangam@nxp.com>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
Subject: Re: [PATCH] wifi: mwifiex: added delay after firmware downloaded.
Message-ID: <ZTPKedZWWAfDjmpo@livingston.pivistrello.it>
References: <PA4PR04MB96388864C8B07F2B3AA7964AD1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96388864C8B07F2B3AA7964AD1DBA@PA4PR04MB9638.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,
thanks for your patch.

On Fri, Oct 20, 2023 at 03:35:34AM +0000, David Lin wrote:
> Added 100 ms delayed after firmware is downloaded and active in order to
> avoid command timeout for the first command sent to firmware.

Please have a look at Documentation/process/submitting-patches.rst.
In very brief:
 - you should use imperative mood to describe your changes
 - this is fixing a real issue, I believe this is worth a more complete commit
   message, including a log of the failure this is solving.

I am also inclined to think that this change should be backported and it likely
would need a Fixes: tag.

> ---
>  drivers/net/wireless/marvell/mwifiex/main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
> index d99127dc466e..a25e8bb8daec 100644
> --- a/drivers/net/wireless/marvell/mwifiex/main.c
> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
> @@ -570,6 +570,7 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
>  		goto err_dnld_fw;
>  
>  	mwifiex_dbg(adapter, MSG, "WLAN FW is active\n");
> +	mdelay(100);

from my understanding there is already a function polling for the firmware to be
active, e.g. mwifiex_check_fw_status(). Maybe is that function that needs to be
fixed instead of adding an additional delay here? 

Francesco

