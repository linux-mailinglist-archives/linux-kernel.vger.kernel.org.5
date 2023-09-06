Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180ED793BE8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 13:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240226AbjIFL4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 07:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbjIFL4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 07:56:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CEBBF;
        Wed,  6 Sep 2023 04:56:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC53CC433C7;
        Wed,  6 Sep 2023 11:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694001370;
        bh=w+6qcKLjdG4HhCP+WlhPGMCu+J7umgz0Okwh5lPyuZE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fnLWcltCu4/mamDK0Fw0R1YU7cspFhOZwZZemNeBmB6KxXYJLdrn4EKpPJ17A0Kr7
         QQNY3GS6yBJyqFpQvtVy5NMAlAtTrkg8bZuiNVG64/PX6ZBMcmIe9W4C9VGVXpyUIi
         7xEyaH4dMj7YppzY/o8l+AnFA0Pfo7UjPtMZlgSpIf/UVSdBMuw9tAs8lhtrMFYohZ
         bv+G2tkJyzt6hLp+QLrsBOIbVNVKUCJHoizFY2N7FOIVByP7XZgF2z3PxDh/kRoVqh
         zz0RXyd5AQ3EE0pFYM5uU+zB1G/nSRZvmIKB9ln5sFxbD2P8lMBU9b24cRZsLmsIOj
         +TSkGhBnB5MhQ==
Message-ID: <14338db6-2cf8-06f1-d584-3fbdde82dd4d@kernel.org>
Date:   Wed, 6 Sep 2023 20:56:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] ahci: libahci: clear pending interrupt status
Content-Language: en-US
To:     Szuying Chen <chensiying21@gmail.com>, Niklas.Cassel@wdc.com,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jesse1_Chang@asmedia.com.tw, Richard_Hsu@asmedia.com.tw,
        Chloe_Chen@asmedia.com.tw
References: <20230906095334.10310-1-Chloe_Chen@asmedia.com.tw>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230906095334.10310-1-Chloe_Chen@asmedia.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 18:53, Szuying Chen wrote:
> Cleared PxIS and PxIE with error recovery when ISR handle interface fatal.
> Then a SDB FIS with ERR (set PxIS.TFES) is received
> before PxCMD.ST is set to 0.
> When error recovery was finish and PxCMD.ST is set to 1.
> The HBA can't issue any new commands.
> Because the PxIS.TFES bit is not cleared.
> To avoid this,
> we adds the function to clear pending interrupt before COMRESET.
> It follows the AHCI 1.3.1 - section 6.2.2.2 specification.
> 
> Signed-off-by: Szuying Chen <Chloe_Chen@asmedia.com.tw>

Fixes tag ?

> ---
> V1->V2: On suggestion by Damien to renamed helper function and modified
> ahci_port_init() to make use of the helper.
> V2->V3: On suggestion by Niklas to modify commit log and delete the
> extra describe.
> 
>  drivers/ata/libahci.c | 35 +++++++++++++++++++++++------------
>  1 file changed, 23 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index e2bacedf28ef..f1263364fa97 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -1256,6 +1256,26 @@ static ssize_t ahci_activity_show(struct ata_device *dev, char *buf)
>  	return sprintf(buf, "%d\n", emp->blink_policy);
>  }
> 
> +static void ahci_port_clear_pending_irq(struct ata_port *ap)
> +{
> +	struct ahci_host_priv *hpriv = ap->host->private_data;
> +	void __iomem *port_mmio = ahci_port_base(ap);
> +	u32 tmp;
> +
> +	/* clear SError */
> +	tmp = readl(port_mmio + PORT_SCR_ERR);
> +	dev_dbg(ap->host->dev, "PORT_SCR_ERR 0x%x\n", tmp);
> +	writel(tmp, port_mmio + PORT_SCR_ERR);
> +
> +	/* clear port IRQ */
> +	tmp = readl(port_mmio + PORT_IRQ_STAT);
> +	dev_dbg(ap->host->dev, "PORT_IRQ_STAT 0x%x\n", tmp);
> +	if (tmp)
> +		writel(tmp, port_mmio + PORT_IRQ_STAT);
> +
> +	writel(1 << ap->port_no, hpriv->mmio + HOST_IRQ_STAT);
> +}
> +
>  static void ahci_port_init(struct device *dev, struct ata_port *ap,
>  			   int port_no, void __iomem *mmio,
>  			   void __iomem *port_mmio)
> @@ -1270,18 +1290,7 @@ static void ahci_port_init(struct device *dev, struct ata_port *ap,
>  	if (rc)
>  		dev_warn(dev, "%s (%d)\n", emsg, rc);
> 
> -	/* clear SError */
> -	tmp = readl(port_mmio + PORT_SCR_ERR);
> -	dev_dbg(dev, "PORT_SCR_ERR 0x%x\n", tmp);
> -	writel(tmp, port_mmio + PORT_SCR_ERR);
> -
> -	/* clear port IRQ */
> -	tmp = readl(port_mmio + PORT_IRQ_STAT);
> -	dev_dbg(dev, "PORT_IRQ_STAT 0x%x\n", tmp);
> -	if (tmp)
> -		writel(tmp, port_mmio + PORT_IRQ_STAT);
> -
> -	writel(1 << port_no, mmio + HOST_IRQ_STAT);
> +	ahci_port_clear_pending_irq(ap);
> 
>  	/* mark esata ports */
>  	tmp = readl(port_mmio + PORT_CMD);
> @@ -1603,6 +1612,8 @@ int ahci_do_hardreset(struct ata_link *link, unsigned int *class,
>  	tf.status = ATA_BUSY;
>  	ata_tf_to_fis(&tf, 0, 0, d2h_fis);
> 
> +	ahci_port_clear_pending_irq(ap);
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

