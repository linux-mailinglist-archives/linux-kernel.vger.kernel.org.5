Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712B578E5A5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240273AbjHaFaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjHaFaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:30:08 -0400
X-Greylist: delayed 475 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Aug 2023 22:30:02 PDT
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DEFE8;
        Wed, 30 Aug 2023 22:30:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 286FBCE1FDF;
        Thu, 31 Aug 2023 05:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AA7DC433C7;
        Thu, 31 Aug 2023 05:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693459322;
        bh=Weo6gLzi6uW4TlpJXEw9lfsi5qsrk+jOI56FqbLKSy0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MpnK8VubwrNwY5Tx3sd3EsZ71IgksGJQo73lhm3DT+/tmw2t6Z/Pn5akp5PSvcV42
         l7V7JrfrYwhJc/+fT/TP2aNqG5sxAW0+VFtP6YLTK2vkd+qk7W056vHQ6E+u4iI2an
         T+MrldS2RqwCDDQuNXMtmW6MxaXVcEyZWFj34a4Mf6eN/veKdlxQNpAeoM3bUy+IqM
         EvImLl1amfv0KQLmHegxtHQgt5FHmerY1Br8jk2HcD6CPKFIPkUHdJERHZ2IIil1mY
         zpK1rPO20ojD7W04m3gZ97FQIlTZyOq56XTIkWLqiCXooOkh1w2q/s8o4u/q6oylMp
         EamvtSBQsOSOg==
Message-ID: <2876b3bf-14e4-3570-064f-4d5f9b00314b@kernel.org>
Date:   Thu, 31 Aug 2023 14:22:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ahci: libahci: clear pending interrupt status
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, Niklas.Cassel@wdc.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
References: <20230831030924.21960-1-Chloe_Chen@asmedia.com.tw>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230831030924.21960-1-Chloe_Chen@asmedia.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/23 12:09, Szuying Chen wrote:
> This patch adds the function to clear pending interrupt before COMRESET.
> It follows the  AHCI1.3.1 - section6.2.2.2 specification.

Please explain here the relevant part of that section.

> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
>  drivers/ata/libahci.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 06aec35f88f2..1ae788251a6c 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1584,6 +1584,23 @@ static int ahci_pmp_retry_softreset(struct ata_link *link, unsigned int *class,
>  	return rc;
>  }
> 
> +static void PortClearPendingInterrupt(struct ata_port *ap)

No CaMeLCaSe please ! Call this ahci_port_clear_peinding_irq().

> +{
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u32 tmp;
> +
> +	/* clear port SERR */
> +	tmp = readl(port_mmio + PORT_SCR_ERR);
> +	writel(tmp, port_mmio + PORT_SCR_ERR);
> +
> +	/* clear port IRQ */
> +	tmp = readl(port_mmio + PORT_IRQ_STAT);
> +	writel(tmp, port_mmio + PORT_IRQ_STAT);
> +
> +	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);

This code is nearly identical to what ahci_port_init() does. So better make it
common: keep the debug messages that are in ahci_port_init() and modify that
function to call this new helper.

> +}
> +
>  int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  		      unsigned long deadline, bool *online)
>  {
> @@ -1602,6 +1619,9 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	tf.status = ATA_BUSY;
>  	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
> 
> +	/* clear pending Interrupt */
> +	PortClearPendingInterrupt(ap);
> +
>  	rc = sata_link_hardreset(link, timing, deadline, online,
>  				 ahci_check_ready);
> 
> --
> 2.39.2
> 

-- 
Damien Le Moal
Western Digital Research

