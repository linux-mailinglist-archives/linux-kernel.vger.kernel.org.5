Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213C57B5E69
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 02:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238944AbjJCA4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 20:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjJCA4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 20:56:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4219AAD;
        Mon,  2 Oct 2023 17:56:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5652CC433CB;
        Tue,  3 Oct 2023 00:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696294592;
        bh=olLlimnWhkeDBquUxrrCAb+tBw4ZjRVCdKdts8iJ1bw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sXgeUyNFQa9IbtkGptuokc2Yc2YDBuIrrF5xYFInVXQnl6SzaQGJzzpdmq5JBRLIE
         qbSYkToNvy6RpWYSytU3hZpO1/g0N/i9va6OX9pm8GuOBdXRodxz7BLCKVnb26vTLl
         wPMPiLL/9qcl78w8QNQJ6CRle4qU2CvF1aD3R5Rb0MOS/u9C5wnc+1Yf41lQtIClA6
         Srx2AIqJT+mhCy1HdZX/IDwY1MXRo9iuZlqlhEwOP/KS3uDiMVJPmmaxp6GG7RLrMX
         qY2vDHklP27X3WQLc6AY/I929R75ZrmDL8XvUJZxfjjI1SaSZ01h1MVCNzk4nBnI2c
         9zR30UrLT3i8Q==
Message-ID: <ef22ae11-ae72-d92e-7f17-a8a706c40614@kernel.org>
Date:   Tue, 3 Oct 2023 09:56:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 4/4] pata_parport-fit3: implement IDE command set
 registers
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>,
        linux-block@vger.kernel.org, linux-parport@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk>
 <20230930191511.24994-5-linux@zary.sk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230930191511.24994-5-linux@zary.sk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/23 04:15, Ondrej Zary wrote:
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

For all patches of this series: please change the commit title to:

ata: pata_parport: xxx

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

