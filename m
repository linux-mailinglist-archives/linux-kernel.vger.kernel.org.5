Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293AE805EF9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbjLEUAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEUAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:00:36 -0500
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA2F188;
        Tue,  5 Dec 2023 12:00:42 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        by mail11.truemail.it (Postfix) with ESMTPA id 3D6CC1F8F7;
        Tue,  5 Dec 2023 21:00:41 +0100 (CET)
Date:   Tue, 5 Dec 2023 21:00:37 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     David Lin <yu-hao.lin@nxp.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
        tsung-hsien.hsieh@nxp.com
Subject: Re: [PATCH] wifi: mwifiex: added extra delay for firmware ready.
Message-ID: <ZW+BZRHDta7vKZgs@francesco-nb.int.toradex.com>
References: <20231128082544.613179-1-yu-hao.lin@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128082544.613179-1-yu-hao.lin@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

thanks for your patch. Planning to run some test on this over the next
days and we'll provide some actual feedback if this really solves the
issue we are affected by.

Just a couple of nitpicky comments on the actual patch.


On the commit message you should use imperative mood, e.g.

`wifi: mwifiex: add extra delay for firmware ready`

with no period at the end of the line.

On Tue, Nov 28, 2023 at 04:25:44PM +0800, David Lin wrote:
> For SDIO IW416, in a corner case FW may return ready before complete full
> initialization.
> Command timeout may occur at driver load after reboot.
> Workaround by adding 100ms delay at checking FW status.
> 
> Signed-off-by: David Lin <yu-hao.lin@nxp.com>

Add

Cc: stable@...

> ---
>  drivers/net/wireless/marvell/mwifiex/sdio.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
> index 6462a0ffe698..744e9403430a 100644
> --- a/drivers/net/wireless/marvell/mwifiex/sdio.c
> +++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
> @@ -783,6 +783,9 @@ static int mwifiex_check_fw_status(struct mwifiex_adapter *adapter,
>  		ret = -1;
>  	}
>  
> +	if (!ret)
> +		msleep(100);
> +

you could just add the delay after

  if (firmware_stat == FIRMWARE_READY_SDIO) {

this would be more read-able to me. Adding also a short comment like

  /* Firmware might pretend to be ready, when it's not.
   * Wait a little bit more as a workaround */


Francesco

