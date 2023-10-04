Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961E77B9848
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236644AbjJDWnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJDWnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:43:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C0EC9;
        Wed,  4 Oct 2023 15:43:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09409C433C7;
        Wed,  4 Oct 2023 22:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696459383;
        bh=xiFYyd2cMCEdaqtSn5Y6qReiUUe9LSLHDqPkOd4T3mc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GCOAAS+P7+NvLI5JaKLawgdhMJp0ItYh/ofLWCIpsZXt1uNTpoa8JQFsPWFTYnFYH
         F+pHT/mYsD/C9LfDu/L5smS2kOYuZXgJ4Kpn66xLLxLtNVXMYROPp60feChJvIx4IU
         60a0kcd1Y2oH0BBH+/D4TPMx9KKGq5lbdPnRgNGlZLn5fsW+E5yt321jjgx2xbQDYW
         YSxT1zeijL81hxYMoKkN7bpSL9wIwbjnIOqa+WwuWTyelfgWkSGuyBm2LzFY/XVxLb
         3T7osJ3DGW+nTHbwBpDKbroIMx69pRuRw0nQd7Gc081ByWGiiplD0iZS4WRn8nLbtu
         UFfMpiOwyrYQg==
Message-ID: <640e1c7a-4356-70b7-d881-df13c8d72447@kernel.org>
Date:   Thu, 5 Oct 2023 07:43:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] ata: pata_parport: fit3: implement IDE command set
 registers
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231004185235.27417-1-linux@zary.sk>
 <20231004185235.27417-5-linux@zary.sk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231004185235.27417-5-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 03:52, Ondrej Zary wrote:
> fit3 protocol driver does not support accessing IDE control registers
> (device control/altstatus). The DOS driver does not use these registers
> either (as observed from DOSEMU trace). But the HW seems to be capable
> of accessing these registers - I simply tried bit 3 and it works!
> 
> The control register is required to properly reset ATAPI devices or
> they will be detected only once (after a power cycle).
> 
> Tested with EXP Computer CD-865 with MC-1285B EPP cable and
> TransDisk 3000.
> 
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
>  drivers/ata/pata_parport/fit3.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
> index bad7aa920cdc..86b39966755b 100644
> --- a/drivers/ata/pata_parport/fit3.c
> +++ b/drivers/ata/pata_parport/fit3.c
> @@ -9,11 +9,6 @@
>   *
>   * The TD-2000 and certain older devices use a different protocol.
>   * Try the fit2 protocol module with them.
> - *
> - * NB:  The FIT adapters do not appear to support the control
> - * registers.  So, we map ALT_STATUS to STATUS and NO-OP writes
> - * to the device control register - this means that IDE reset
> - * will not work on these devices.
>   */
>  
>  #include <linux/module.h>
> @@ -35,10 +30,11 @@
>   * cont = 1 - access the IDE command set
>   */
>  
> +static int cont_map[] = { 0x00, 0x08 };
> +
>  static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
>  {
> -	if (cont == 1)
> -		return;
> +	regr += cont_map[cont];

It is a little silly to have that cont_map array for this only... Why not simply
"regr += cont << 3;" ? Sergey suggested that already I think.

>  
>  	switch (pi->mode) {
>  	case 0:
> @@ -59,11 +55,7 @@ static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
>  {
>  	int  a, b;
>  
> -	if (cont) {
> -		if (regr != 6)
> -			return 0xff;
> -		regr = 7;
> -	}
> +	regr += cont_map[cont];
>  
>  	switch (pi->mode) {
>  	case 0:

-- 
Damien Le Moal
Western Digital Research

