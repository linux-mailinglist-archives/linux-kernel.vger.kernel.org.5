Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E89F7B6F57
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbjJCRNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjJCRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:13:34 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1556AF;
        Tue,  3 Oct 2023 10:13:30 -0700 (PDT)
Received: from [192.168.0.2] (chello085216244195.chello.sk [85.216.244.195])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id DD7817A0090;
        Tue,  3 Oct 2023 19:13:29 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 4/4] pata_parport-fit3: implement IDE command set registers
Date:   Tue, 3 Oct 2023 19:13:27 +0200
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk> <20230930191511.24994-5-linux@zary.sk> <e35003ab-4dfe-6154-5873-cc90f65008a8@omp.ru>
In-Reply-To: <e35003ab-4dfe-6154-5873-cc90f65008a8@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202310031913.27387.linux@zary.sk>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2023 22:06:52 Sergey Shtylyov wrote:
> On 9/30/23 10:15 PM, Ondrej Zary wrote:
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
> > ---
> >  drivers/ata/pata_parport/fit3.c | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/ata/pata_parport/fit3.c b/drivers/ata/pata_parport/fit3.c
> > index bad7aa920cdc..86b39966755b 100644
> > --- a/drivers/ata/pata_parport/fit3.c
> > +++ b/drivers/ata/pata_parport/fit3.c
> [...]
> > @@ -35,10 +30,11 @@
> >   * cont = 1 - access the IDE command set
> >   */
> >  
> > +static int cont_map[] = { 0x00, 0x08 };
> 
>    const?

There's no 'const' in other protocol drivers. Maybe it should be added to all of them.

> > +
> >  static void fit3_write_regr(struct pi_adapter *pi, int cont, int regr, int val)
> >  {
> > -	if (cont == 1)
> > -		return;
> > +	regr += cont_map[cont];
> 
>    Perhaps regr += cont << 3 instead?

I matched the style used by other protocol drivers.

> >  
> >  	switch (pi->mode) {
> >  	case 0:
> > @@ -59,11 +55,7 @@ static int fit3_read_regr(struct pi_adapter *pi, int cont, int regr)
> >  {
> >  	int  a, b;
> >  
> > -	if (cont) {
> > -		if (regr != 6)
> > -			return 0xff;
> > -		regr = 7;
> > -	}
> > +	regr += cont_map[cont];
> 
>    Likewise here?
> 
> [...]
> 
> MBR, Sergey
> 


-- 
Ondrej Zary
