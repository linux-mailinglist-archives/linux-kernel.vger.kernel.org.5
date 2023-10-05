Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24397BAB99
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjJEUqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJEUqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:46:42 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ACFD95;
        Thu,  5 Oct 2023 13:46:41 -0700 (PDT)
Received: from [192.168.0.2] (chello085216244195.chello.sk [85.216.244.195])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 3DC607A001E;
        Thu,  5 Oct 2023 22:46:40 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 4/4] ata: pata_parport: fit3: implement IDE command set registers
Date:   Thu, 5 Oct 2023 22:46:37 +0200
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231005192440.4047-1-linux@zary.sk> <20231005192440.4047-5-linux@zary.sk> <c2e074e0-ad91-e8b4-debf-00661ad5c720@omp.ru>
In-Reply-To: <c2e074e0-ad91-e8b4-debf-00661ad5c720@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202310052246.37625.linux@zary.sk>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 October 2023 21:53:44 Sergey Shtylyov wrote:
> On 10/5/23 10:24 PM, Ondrej Zary wrote:
> 
> > fit3 protocol driver does not support accessing IDE control registers
> > (device control/altstatus). The DOS driver does not use these registers
> > either (as observed from DOSEMU trace). But the HW seems to be capable
> > of accessing these registers - I simply tried bit 3 and it works!
> > 
> > The control register is required to properly reset ATAPI devices or
> > they will be detected only once (after a power cycle).
> > 
> > Tested with EXP Computer CD-865 with MC-1285B EPP cable and
> > TransDisk 3000.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> 
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> > ---
> >  drivers/ata/pata_parport/fit3.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
> > index bad7aa920cdc..d2b81cf2e16d 100644
> > --- a/drivers/ata/pata_parport/fit3.c
> > +++ b/drivers/ata/pata_parport/fit3.c
> [...]
> > @@ -59,11 +53,7 @@ static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
> >  {
> >  	int  a, b;
> >  
> > -	if (cont) {
> > -		if (regr != 6)
> > -			return 0xff;
> > -		regr = 7;
> > -	}
> > +	regr += cont << 3;
> 
>    So, is regr == 7 instead of 8 intentional?

The original code read ATA_REG_STATUS (7) in context 0 instead of ALT_STATUS (6) in context 1.

-- 
Ondrej Zary
