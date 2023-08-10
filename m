Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5454F777575
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 12:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHJKJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 06:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjHJKJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 06:09:48 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF7BC5;
        Thu, 10 Aug 2023 03:09:47 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37A3YTcR009010;
        Thu, 10 Aug 2023 05:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=PODMain02222019; bh=k1KcfivkvfpCHq0
        NMs8Np9yM9659lSDv0JbCXObknfM=; b=I2F0Ex2TvSL3HvCUvzlDXlSVAtTbQ6I
        PDLS1qYOPaoJI+2rER4kGvy/YZ3veIOJ2XZAVgGLAtKsPrDL3S3hbJlFyEMgeb/r
        VexdZ6m2UzWeuJb+26UPIPI2RwHbopAV0FqzpB7cUEwl5hWqdu3HXJL0f4ricqk3
        GHnIVUFPcc/5/xneb5CtnyEEvcOe+1jap3p/pzB5YFUKjk/3TlJ/+G7cmQvKc53N
        S8zWjqSUGw4+T0R6/ux/Ki2/fZGOlmMepXrzLSa090XtBt/G4S1zluM498+6tmdG
        EUirnUOv4wunlcIEA3xfWPUgci4TPd6dVpjFkDiqsYN02NaRHC4TTGg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sb7vtbsrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 05:09:43 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 10 Aug
 2023 11:09:41 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Thu, 10 Aug 2023 11:09:41 +0100
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A23EB3578;
        Thu, 10 Aug 2023 10:09:41 +0000 (UTC)
Date:   Thu, 10 Aug 2023 10:09:41 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     "Goud, Srinivas" <srinivas.goud@amd.com>
CC:     "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] spi: spi-cadence: Interleave write of TX and read
 of RX FIFO
Message-ID: <20230810100941.GX103419@ediswmail.ad.cirrus.com>
References: <20230518093927.711358-1-ckeepax@opensource.cirrus.com>
 <PH8PR12MB66758946C395E678B7599FE5E112A@PH8PR12MB6675.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <PH8PR12MB66758946C395E678B7599FE5E112A@PH8PR12MB6675.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: -qXs0Ofrk2aeMXGFnh9c8P6jHLcf7H-N
X-Proofpoint-ORIG-GUID: -qXs0Ofrk2aeMXGFnh9c8P6jHLcf7H-N
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 11:31:24AM +0000, Goud, Srinivas wrote:
> >+	while (ntx || nrx) {
> > 		/* When xspi in busy condition, bytes may send failed,
> > 		 * then spi control did't work thoroughly, add one byte delay
> > 		 */
> >-		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
> >-		    CDNS_SPI_IXR_TXFULL)
> >+		if (cdns_spi_read(xspi, CDNS_SPI_ISR) &
> >CDNS_SPI_IXR_TXFULL)
> > 			udelay(10);
> Linux driver configured as Slave, due to this above delay we see data corruption issue on Master side.
> when Master is continuously reading the data, Slave is failed to prepare the date on time due to above delay.
> 
> >@@ -391,11 +388,10 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
> > 		if (xspi->tx_bytes < xspi->tx_fifo_depth >> 1)
> > 			cdns_spi_write(xspi, CDNS_SPI_THLD, 1);
> >
> >-		cdns_spi_read_rx_fifo(xspi, trans_cnt);
> >-
> > 		if (xspi->tx_bytes) {
> >-			cdns_spi_fill_tx_fifo(xspi, trans_cnt);
> >+			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
> > 		} else {
> >+			cdns_spi_process_fifo(xspi, 0, trans_cnt);
> When Linux driver configured as Slave, we observed data corruption issue with Slave mode read when data length is 400 bytes.
> As TX empty doesn't guaranties valid data in RX FIFO, hence we added one byte delay(10us) before RX FIFO read to overcome above issue.
> Created patch with above changes, find patch as attachment.
> Can you please test and let me know your observations.
> 

Yeah I can test the patch, I am on holiday this week so don't
have access to the hardware, but will do so next week.

> From 40154932ac7486c99e339bbc0b85b3cfe382286c Mon Sep 17 00:00:00 2001
> From: Srinivas Goud <srinivas.goud@amd.com>
> Date: Tue, 1 Aug 2023 21:21:09 +0530
> Subject: [PATCH] spi: spi-cadence: Fix data corruption issues in slave mode
> 
> Remove 10us delay in cdns_spi_process_fifo() (called from cdns_spi_irq())
> to fix data corruption issue on Master side when this driver
> configured in Slave mode, as Slave is failed to prepare the date
> on time due to above delay.
> 
> Add 10us delay before processing the RX FIFO as TX empty doesn't
> guaranty valid data in RX FIFO.

guarantee

> 
> Signed-off-by: Srinivas Goud <srinivas.goud@amd.com>
> ---
>  drivers/spi/spi-cadence.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
> index 42f101d..07a593c 100644
> --- a/drivers/spi/spi-cadence.c
> +++ b/drivers/spi/spi-cadence.c
> @@ -317,12 +317,6 @@ static void cdns_spi_process_fifo(struct cdns_spi *xspi, int ntx, int nrx)
>  	xspi->rx_bytes -= nrx;
>  
>  	while (ntx || nrx) {
> -		/* When xspi in busy condition, bytes may send failed,
> -		 * then spi control did't work thoroughly, add one byte delay
> -		 */
> -		if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
> -			udelay(10);
> -
>  		if (ntx) {
>  			if (xspi->txbuf)
>  				cdns_spi_write(xspi, CDNS_SPI_TXD, *xspi->txbuf++);
> @@ -392,6 +386,11 @@ static irqreturn_t cdns_spi_irq(int irq, void *dev_id)
>  		if (xspi->tx_bytes) {
>  			cdns_spi_process_fifo(xspi, trans_cnt, trans_cnt);
>  		} else {
> +			/* Fixed delay due to controller limitation with
> +			 * RX_NEMPTY incorrect status
> +			 * Xilinx AR:65885 contains more details

Do you have a web link to this ticket? Would be good to get some
more background.

> +			 */
> +			udelay(10);
>  			cdns_spi_process_fifo(xspi, 0, trans_cnt);
>  			cdns_spi_write(xspi, CDNS_SPI_IDR,
>  				       CDNS_SPI_IXR_DEFAULT);
> @@ -439,12 +438,18 @@ static int cdns_transfer_one(struct spi_controller *ctlr,
>  		cdns_spi_setup_transfer(spi, transfer);
>  	} else {
>  		/* Set TX empty threshold to half of FIFO depth
> -		 * only if TX bytes are more than half FIFO depth.
> +		 * only if TX bytes are more than FIFO depth.
>  		 */
>  		if (xspi->tx_bytes > xspi->tx_fifo_depth)
>  			cdns_spi_write(xspi, CDNS_SPI_THLD, xspi->tx_fifo_depth >> 1);
>  	}
>  
> +	/* When xspi in busy condition, bytes may send failed,
> +	 * then spi control did't work thoroughly, add one byte delay

Just noticing there is an n missing in didn't might as well add
that whilst moving the comment.

> +	 */
> +	if (cdns_spi_read(xspi, CDNS_SPI_ISR) & CDNS_SPI_IXR_TXFULL)
> +		udelay(10);
> +
>  	cdns_spi_process_fifo(xspi, xspi->tx_fifo_depth, 0);
>  	spi_transfer_delay_exec(transfer);
>  
> -- 
> 2.1.1

Thanks,
Charles
