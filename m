Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6177753C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235250AbjHJKAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235206AbjHJKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:00:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B798211B;
        Thu, 10 Aug 2023 02:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF1A3656DA;
        Thu, 10 Aug 2023 09:59:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBB5C433CA;
        Thu, 10 Aug 2023 09:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691661579;
        bh=tZc2QoE3nz8xkaCTNRvdEugBH9AUTd2t85+e5AqKrtE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E208qzHV/zGeeBahwPbqcofF723S3g67W/2omkRJEZkcw8ksMHFOkjPKqIsZA9KF6
         CpZpbZPSmpIJtznkpmF+vJM49P1Yxa205kLfeHQdW2IlL0x+3OoaZ5FWMLLbQu38gH
         2tK87jaAjtQ/dHUdVmTjncUuEo3ZXQmtpVJVlVJ2F5uN1SXRdmaycsPQBlMY3QDYM0
         II35F37cF6ArJNW2cOdTqwq2I22VbgTAWgRpfx1pEu1zQfJo1v88EQmhrqVomdlIiK
         Hd9lOY0NCaJfysImIRI/kjG/omIzVfmPaUNS+ELVsriD3NhSvjeR3KOLJP56L/6KtZ
         eUiptqhfiHMeg==
Message-ID: <987e0190-869f-76e0-9a0f-4ba122ce217a@kernel.org>
Date:   Thu, 10 Aug 2023 18:59:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ahci: libahci: clear pending interrupt status
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Szuying Chen <Chloe_Chen@asmedia.com.tw>
References: <20230810093147.45678-1-Chloe_Chen@asmedia.com.tw>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230810093147.45678-1-Chloe_Chen@asmedia.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 18:31, Szuying Chen wrote:
> On 8/10/23 14:12, Damien Le Moal wrote: 
>>    On 8/10/23 14:05, Szuying Chen wrote:
>>    > When ISR handle interface fatal error with error recovery after clear PxIS
>>    > and PxIE. Another FIS(SDB FIS with err) that set PxIS.IFS to 1 is recevied
>>    > during error recovery, which causing the HBA not issue any new commands
>>    > after cmd.ST set 1.
>>
>>    This is not very clear. If there was a fatal error, the drive should be in
>>    error state and no other SDB FIS can be received as the drive does absolutely
>>    nothing while in error state (it only waits for a read log 10h command to be>
>>    issued to get it out of error state). So if you are seeing 2 SDB FIS with
>>    errors one after the other, you have a buggy device...
>>
>>    However, I may be misunderstanding your issue here. Could you provide more
>>    details and a dmesg output example of the issue ?
> 
> According to AHCI 1.3.1 specification ch6.1.9, when an R_ERR is received
> on an H2D Data FIS in normal operation, the HBA sets PxIS.IFS to 1
> (fatal error) and halts operation. Referring to SATA 3.0 specification we
> know the device will halt queued command processing and transmit SDB FIS to
> host with ERR bit in Status field set to one(set PxIS.TFES to 1).

Sure, but that SBD FIS should be completely ignored by the adapter since it
stopped operation. If you see it, then it means that the handling of the first
error was incomplete.

> In our case, the ISR handles fatal errors(PxIS.IFS) and enters error 
> recovery after cleaning up PxIS and PxIE. Then a SDB FIS is received 
> with interrupt bit(PxIS.TFES) set to 1. According to AHCI 1.3.1 
> specification ch6.2.2, HBA can't issue(cmd.ST set to 1) any new commands
> under PxIS.TFES alive during error recovery.

But how come you see a new command being issued ? This entire situation should
result in a port reset with the first error. I do not see how this is possible.
Are you saying that the port reset is not cleaning things up properly ? Could
you share the dmesg output of this case ?

> 
>>    >
>>    > Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
>>    > ---
>>    >  drivers/ata/libahci.c | 12 ++++++++++++
>>    >  1 file changed, 12 insertions(+)
>>    >
>>    > diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
>>    > index 06aec35f88f2..0ae51fd95d46 100644
>>    > --- a/drivers/ata/libahci.c
>>    > +++ b/drivers/ata/libahci.c
>>    > @@ -679,9 +679,21 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
>>    >
>>    >  void ahci_start_engine(struct ata_port *ap)
>>    >  {
>>    > +     struct ahci_host_priv *hpriv = ap->host->private_data;
>>    >       void __iomem *port_mmio = ahci_port_base(ap);
>>    >       u32 tmp;
>>    >
>>    > +     /* clear SError */
>>    > +     tmp = readl(port_mmio + PORT_SCR_ERR);
>>    > +     writel(tmp, port_mmio + PORT_SCR_ERR);
>>    > +
>>    > +     /* clear port IRQ */
>>    > +     tmp = readl(port_mmio + PORT_IRQ_STAT);
>>    > +     if (tmp)
>>    > +             writel(tmp, port_mmio + PORT_IRQ_STAT);
>>    > +
>>    > +     writel(1 << ap->port_no, hpriv->mmio + PORT_IRQ_STAT);
>>    > +
>>    >       /* start DMA */
>>    >       tmp = readl(port_mmio + PORT_CMD);
>>    >       tmp |= PORT_CMD_START;
>>    > --
>>    > 2.39.2
>>   >
>>
>>   -- 
>>   Damien Le Moal
>>    Western Digital Research
>>
> Thanks. 
> 

-- 
Damien Le Moal
Western Digital Research

