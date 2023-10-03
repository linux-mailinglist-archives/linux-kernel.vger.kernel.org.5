Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A217B6F41
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjJCRHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJCRHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:07:54 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E023A7;
        Tue,  3 Oct 2023 10:07:50 -0700 (PDT)
Received: from [192.168.0.2] (chello085216244195.chello.sk [85.216.244.195])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 83FF57A0090;
        Tue,  3 Oct 2023 19:07:48 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 1/4] pata_parport: fix pata_parport_devchk
Date:   Tue, 3 Oct 2023 19:07:45 +0200
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk> <20230930191511.24994-2-linux@zary.sk> <d040b3f7-4222-a027-34d0-5cf62aa63605@omp.ru>
In-Reply-To: <d040b3f7-4222-a027-34d0-5cf62aa63605@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202310031907.45632.linux@zary.sk>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2023 20:43:09 Sergey Shtylyov wrote:
> Hello!
> 
> On 9/30/23 10:15 PM, Ondrej Zary wrote:
> 
> > There's a 'x' missing in 0x55 in pata_parport_devchk(), causing the
> > detection to always fail. Fix it.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> 
>    I think we need a Fixes: tag here...
> 
> > ---
> >  drivers/ata/pata_parport/pata_parport.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> > index 1af64d435d3c..258d189f42e5 100644
> > --- a/drivers/ata/pata_parport/pata_parport.c
> > +++ b/drivers/ata/pata_parport/pata_parport.c
> > @@ -64,7 +64,7 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
> >  	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0xaa);
> >  	pi->proto->write_regr(pi, 0, ATA_REG_LBAL, 0x55);
> >  
> > -	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 055);
> > +	pi->proto->write_regr(pi, 0, ATA_REG_NSECT, 0x55);
> 
>    Oh, Gawd! How did this ever work?! :-/
>    This bug seems to predate the Big PARIDE move...

This code was not present in PARIDE - it's my bug.
The function is a clone of ata_devchk() without direct port access.
It's called only from softreset so nobody notices the breakage until something goes wrong. The CD-865 drive needs a reset to start working.

-- 
Ondrej Zary
