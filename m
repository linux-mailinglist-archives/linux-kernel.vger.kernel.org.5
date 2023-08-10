Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D402776F61
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 07:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHJFMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 01:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbjHJFMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 01:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E51F196;
        Wed,  9 Aug 2023 22:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33B5D633A7;
        Thu, 10 Aug 2023 05:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28F3C433C7;
        Thu, 10 Aug 2023 05:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691644334;
        bh=R2QLrgv7LuJ7RfJsajq+FqkV9S/7dE3u5AygldaBQSs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tfA8TuEPBFq93KpZ2aaFO2fUUGXiTfNH9AIE0ssRMtgvqQb3EPhd7pz0MQmlJWnDg
         9UixSyz+QZbMguN8nJezaX7kfPsnPVcrGZyfXgleqJICh0MOJsXEY0ZCE34RUFoSS8
         O7c1slh3H2OatQxgO7ayi7p7BAl4tFNgqbFnoBxXFKe5DG9CjviosUVGOSwWDaHal4
         XgX+ARkPB/chx4MB9WpULSZH66fR5Osklaq/GJz/RfQu/6LKOwmAA3ycllCqSbfpdi
         NanE0XpxbV9wF7/WzEr4cn1gKA7uXBVGZPwchKVSn4MVy3rMqWJuLNCagIA6X3Ei6L
         naZykZKCy8LgQ==
Message-ID: <23cc546e-bf87-b3c7-6b75-b895c1241a4b@kernel.org>
Date:   Thu, 10 Aug 2023 14:12:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ahci: libahci: clear pending interrupt status
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_chen@asmedia.com.tw
References: <20230810050531.43505-1-Chloe_Chen@asmedia.com.tw>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230810050531.43505-1-Chloe_Chen@asmedia.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 14:05, Szuying Chen wrote:
> When ISR handle interface fatal error with error recovery after clear PxIS
> and PxIE. Another FIS(SDB FIS with err) that set PxIS.IFS to 1 is recevied
> during error recovery, which causing the HBA not issue any new commands
> after cmd.ST set 1.

This is not very clear. If there was a fatal error, the drive should be in
error state and no other SDB FIS can be received as the drive does absolutely
nothing while in error state (it only waits for a read log 10h command to be
issued to get it out of error state). So if you are seeing 2 SDB FIS with
errors one after the other, you have a buggy device...

However, I may be misunderstanding your issue here. Could you provide more
details and a dmesg output example of the issue ?

> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>
> ---
>  drivers/ata/libahci.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index 06aec35f88f2..0ae51fd95d46 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -679,9 +679,21 @@ static int ahci_scr_write(struct ata_link *link, unsigned int sc_reg, u32 val)
> 
>  void ahci_start_engine(struct ata_port *ap)
>  {
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
>  	void __iomem *port_mmio = ahci_port_base(ap);
>  	u32 tmp;
> 
> +	/* clear SError */
> +	tmp = readl(port_mmio + PORT_SCR_ERR);
> +	writel(tmp, port_mmio + PORT_SCR_ERR);
> +
> +	/* clear port IRQ */
> +	tmp = readl(port_mmio + PORT_IRQ_STAT);
> +	if (tmp)
> +		writel(tmp, port_mmio + PORT_IRQ_STAT);
> +
> +	writel(1 << ap->port_no, hpriv->mmio + PORT_IRQ_STAT);
> +
>  	/* start DMA */
>  	tmp = readl(port_mmio + PORT_CMD);
>  	tmp |= PORT_CMD_START;
> --
> 2.39.2
> 

-- 
Damien Le Moal
Western Digital Research

