Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717217B6F96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 19:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbjJCRUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 13:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231571AbjJCRUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 13:20:37 -0400
Received: from hosting.gsystem.sk (hosting.gsystem.sk [212.5.213.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47F719B;
        Tue,  3 Oct 2023 10:20:34 -0700 (PDT)
Received: from [192.168.0.2] (chello085216244195.chello.sk [85.216.244.195])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by hosting.gsystem.sk (Postfix) with ESMTPSA id 0DCA17A0090;
        Tue,  3 Oct 2023 19:20:33 +0200 (CEST)
From:   Ondrej Zary <linux@zary.sk>
To:     Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH 3/4] pata_parport: add custom version of wait_after_reset
Date:   Tue, 3 Oct 2023 19:20:29 +0200
User-Agent: KMail/1.9.10
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Tim Waugh <tim@cyberelk.net>,
        linux-parport@lists.infradead.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230930191511.24994-1-linux@zary.sk> <20230930191511.24994-4-linux@zary.sk> <a164fc88-ef57-f957-25df-e149540830c0@omp.ru>
In-Reply-To: <a164fc88-ef57-f957-25df-e149540830c0@omp.ru>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202310031920.29288.linux@zary.sk>
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 October 2023 22:48:59 Sergey Shtylyov wrote:
> On 9/30/23 10:15 PM, Ondrej Zary wrote:
> 
> > Some parallel adapters (e.g. EXP Computer MC-1285B EPP Cable) return
> > bogus values when there's no master device present. This can cause
> > reset to fail, preventing the lone slave device (such as EXP Computer
> > CD-865) from working.
> > 
> > Add custom version of wait_after_reset that ignores master failure when
> > a slave device is present. The custom version is also needed because
> > the generic ata_sff_wait_after_reset uses direct port I/O for slave
> > device detection.
> > 
> > Signed-off-by: Ondrej Zary <linux@zary.sk>
> > ---
> >  drivers/ata/pata_parport/pata_parport.c | 65 ++++++++++++++++++++++++-
> >  1 file changed, 64 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ata/pata_parport/pata_parport.c b/drivers/ata/pata_parport/pata_parport.c
> > index cf87bbb52f1f..b3db953e615a 100644
> > --- a/drivers/ata/pata_parport/pata_parport.c
> > +++ b/drivers/ata/pata_parport/pata_parport.c
> > @@ -80,6 +80,69 @@ static bool pata_parport_devchk(struct ata_port *ap, unsigned int device)
> >  	return (nsect == 0x55) && (lbal == 0xaa);
> >  }
> >  
> > +static int pata_parport_wait_after_reset(struct ata_link *link,
> > +					 unsigned int devmask,
> > +					 unsigned long deadline)
> > +{
> > +	struct ata_port *ap = link->ap;
> > +	struct pi_adapter *pi = ap->host->private_data;
> > +	unsigned int dev0 = devmask & (1 << 0);
> > +	unsigned int dev1 = devmask & (1 << 1);
> > +	int rc, ret = 0;
> > +
> > +	ata_msleep(ap, ATA_WAIT_AFTER_RESET);
> > +
> > +	/* always check readiness of the master device */
> > +	rc = ata_sff_wait_ready(link, deadline);
> > +	/* some adapters return bogus values if master device is not present,
> 
>    The multiline comments should start with /* on its own line.
>    Have you run scripts/checkpatch.pl on the patches?

Checkpatch doesn't complain.

> > +	 * so don't abort now if a slave device is present
> > +	 */
> > +	if (rc) {
> > +		if (!dev1)
> > +			return rc;
> > +		ret = -ENODEV;
> > +	}
> > +
> > +	/* if device 1 was found in ata_devchk, wait for register
> 
>    Likewise here...
> 
> > +	 * access briefly, then wait for BSY to clear.
> > +	 */
> > +	if (dev1) {
> > +		int i;
> > +
> > +		pata_parport_dev_select(ap, 1);
> > +
> > +		/* Wait for register access.  Some ATAPI devices fail
> 
>    And here...
> 
> [...]
> 
> MBR, Sergey
> 


-- 
Ondrej Zary
