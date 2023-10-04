Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC77B984C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 00:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjJDWoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 18:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbjJDWof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 18:44:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2290;
        Wed,  4 Oct 2023 15:44:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CF2C433C7;
        Wed,  4 Oct 2023 22:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696459472;
        bh=S6YkqsS+jM8OhnVJzdkiTNUfaHH2wWNp3iTGptEgCzA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ibVTPqmvQyVnrSSZSKOocBhyIV5caI8By7gsDftqS4PNEKoque9dR5vw1PQbFytFf
         YQ+UPgrVSiQ0Qrd4aV9II+1RpxFZ4x65y+4M9VqSrokw9SHK7KNichOr1JHgBNvt//
         MzyUA8Soovh7VlxlRko8AVSLuyxPXlP0d3pAhCl1UL9jT0Xa5p23oFQuGp7b2+r6Hh
         97IPCwYt9fpuTEJ0rmnEO/UzkGH09Qn3LmEzCIMPn6dqLgZeywQVW3nl5IdIsV/7+V
         F942g6QF+7GaMlkYoW2wDj4d0disd4y5Ex2N2pCgBkRDOyH3EaP4lpvB7ctffOA9NN
         p2zAw8ASECynw==
Message-ID: <583d9807-764b-9266-bf55-e6aefe8c4b82@kernel.org>
Date:   Thu, 5 Oct 2023 07:44:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] ata: pata_parport: implement set_devctl
Content-Language: en-US
To:     Ondrej Zary <linux@zary.sk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231004185235.27417-1-linux@zary.sk>
 <20231004185235.27417-3-linux@zary.sk>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231004185235.27417-3-linux@zary.sk>
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
> Add missing ops->sff_set_devctl implementation.
> 
> Fixes: 246a1c4c6b7f ("ata: pata_parport: add driver (PARIDE replacement)")

Missing "Cc: stable@vger.kernel.org" here. Same comment for patch 1.
Otherwise, looks OK.

> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Ondrej Zary <linux@zary.sk>
> ---
>  drivers/ata/pata_parport/pata_parport.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> index 258d189f42e5..cf87bbb52f1f 100644
> --- a/drivers/ata/pata_parport/pata_parport.c
> +++ b/drivers/ata/pata_parport/pata_parport.c
> @@ -51,6 +51,13 @@ static void pata_parport_dev_select(struct ata_port *ap, unsigned int device)
>  	ata_sff_pause(ap);
>  }
>  
> +static void pata_parport_set_devctl(struct ata_port *ap, u8 ctl)
> +{
> +	struct pi_adapter *pi = ap->host->private_data;
> +
> +	pi->proto->write_regr(pi, 1, 6, ctl);
> +}
> +
>  static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
>  {
>  	struct pi_adapter *pi = ap->host->private_data;
> @@ -252,6 +259,7 @@ static struct ata_port_operations pata_parport_port_ops = {
>  	.hardreset		= NULL,
>  
>  	.sff_dev_select		= pata_parport_dev_select,
> +	.sff_set_devctl		= pata_parport_set_devctl,
>  	.sff_check_status	= pata_parport_check_status,
>  	.sff_check_altstatus	= pata_parport_check_altstatus,
>  	.sff_tf_load		= pata_parport_tf_load,

-- 
Damien Le Moal
Western Digital Research

