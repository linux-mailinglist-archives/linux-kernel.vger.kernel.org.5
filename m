Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546C379F63B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 03:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbjINBSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 21:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjINBSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 21:18:53 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36DA1724;
        Wed, 13 Sep 2023 18:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=eHIQuT6UlrAMV8LSR515DTq2wIcqJxO0YuYeb28K3lY=; b=Wjv7sm3DNC7tMRxgXrWbtjkyt1
        hfskufYENJkJvGnSvOYswn9dAvkeVBSICVfLXWbC3/bZUPS07mOxzrmfrTjjLi4+s7m+wG4FuLWjS
        yqPz0mdSf0iYA8nPlmeGlSzlSjgT2Zc5/t4UZ4l1ihc6++rxA+40r81XRRlukHnQLmyQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qgb09-006Lwq-D4; Thu, 14 Sep 2023 03:18:37 +0200
Date:   Thu, 14 Sep 2023 03:18:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        corbet@lwn.net, steen.hegelund@microchip.com,
        rdunlap@infradead.org, horms@kernel.org, casper.casan@gmail.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        horatiu.vultur@microchip.com, Woojung.Huh@microchip.com,
        Nicolas.Ferre@microchip.com, UNGLinuxDriver@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [RFC PATCH net-next 4/6] net: ethernet: implement data
 transaction interface
Message-ID: <e874dab4-e701-44f8-bbe0-ce66784ecf5c@lunn.ch>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
 <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908142919.14849-5-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static void oa_tc6_rx_eth_ready(struct oa_tc6 *tc6)
> +{
> +	struct sk_buff *skb = NULL;
> +
> +	/* Send the received ethernet packet to network layer */
> +	skb = netdev_alloc_skb(tc6->netdev, tc6->rxd_bytes + NET_IP_ALIGN);
> +	if (!skb) {
> +		tc6->netdev->stats.rx_dropped++;
> +		netdev_err(tc6->netdev, "Out of memory for rx'd frame");

Being out of memory is not likely to go away quickly. So i can see
this spamming the kernel log. At minimum make it rate limited, or just
rely on the counter and do not print anything.

> +static int oa_tc6_process_exst(struct oa_tc6 *tc6)
> +{
> +	u32 regval;
> +	int ret;
> +
> +	ret = oa_tc6_read_register(tc6, OA_TC6_STS0, &regval, 1);
> +	if (ret) {
> +		netdev_err(tc6->netdev, "STS0 register read failed.\n");
> +		return ret;
> +	}
> +	if (regval & TXPE)
> +		netdev_err(tc6->netdev, "Transmit protocol error\n");
> +	if (regval & TXBOE)
> +		netdev_err(tc6->netdev, "Transmit buffer overflow\n");
> +	if (regval & TXBUE)
> +		netdev_err(tc6->netdev, "Transmit buffer underflow\n");
> +	if (regval & RXBOE)
> +		netdev_err(tc6->netdev, "Receive buffer overflow\n");
> +	if (regval & LOFE)
> +		netdev_err(tc6->netdev, "Loss of frame\n");
> +	if (regval & HDRE)
> +		netdev_err(tc6->netdev, "Header error\n");
> +	if (regval & TXFCSE)
> +		netdev_err(tc6->netdev, "Transmit Frame Check Sequence Error\n");

Do you expect these problems to magically fix themselves, or is this
going to spam the kernel log until the machine is rebooted?

It seems a counter would be more appropriate, and maybe one rate
limited message if the problem persists.

Please look at all your netdev_err() calls and consider if they are
really needed, should they be netdev_dbg(), or statistics counters.

> +static int oa_tc6_process_rx_chunks(struct oa_tc6 *tc6, u8 *buf, u16 len)
> +{
> +	u8 cp_count;
> +	u8 *payload;
> +	u32 ftr;
> +	u16 ebo;
> +	u16 sbo;
> +
> +	/* Calculate the number of chunks received */
> +	cp_count = len / (tc6->cps + TC6_FTR_SIZE);
> +
> +	for (u8 i = 0; i < cp_count; i++) {
> +		/* Get the footer and payload */
> +		ftr = *(u32 *)&buf[tc6->cps + (i * (tc6->cps + TC6_FTR_SIZE))];
> +		ftr = be32_to_cpu(ftr);
> +		payload = &buf[(i * (tc6->cps + TC6_FTR_SIZE))];
> +		/* Check for footer parity error */
> +		if (oa_tc6_get_parity(ftr)) {
> +			netdev_err(tc6->netdev, "Footer: Parity error\n");
> +			goto err_exit;
> +		}
> +		/* If EXST set in the footer then read STS0 register to get the
> +		 * status information.
> +		 */
> +		if (FIELD_GET(DATA_FTR_EXST, ftr)) {
> +			if (oa_tc6_process_exst(tc6))
> +				netdev_err(tc6->netdev, "Failed to process EXST\n");
> +			goto err_exit;
> +		}
> +		if (FIELD_GET(DATA_FTR_HDRB, ftr)) {
> +			netdev_err(tc6->netdev, "Footer: Received header bad\n");
> +			goto err_exit;
> +		}
> +		if (!FIELD_GET(DATA_FTR_SYNC, ftr)) {
> +			netdev_err(tc6->netdev, "Footer: Configuration unsync\n");
> +			goto err_exit;
> +		}
> +		/* If Frame Drop is set, indicates that the MAC has detected a
> +		 * condition for which the SPI host should drop the received
> +		 * ethernet frame.
> +		 */
> +		if (FIELD_GET(DATA_FTR_FD, ftr) && FIELD_GET(DATA_FTR_EV, ftr)) {
> +			netdev_warn(tc6->netdev, "Footer: Frame drop\n");
> +			if (FIELD_GET(DATA_FTR_SV, ftr)) {
> +				goto start_new_frame;
> +			} else {
> +				if (tc6->rx_eth_started) {
> +					tc6->rxd_bytes = 0;
> +					tc6->rx_eth_started = false;
> +					tc6->netdev->stats.rx_dropped++;
> +				}
> +				continue;
> +			}
> +		}
> +		/* Check for data valid */
> +		if (FIELD_GET(DATA_FTR_DV, ftr)) {
> +			/* Check whether both start valid and end valid are in a
> +			 * single chunk payload means a single chunk payload may
> +			 * contain an entire ethernet frame.
> +			 */
> +			if (FIELD_GET(DATA_FTR_SV, ftr) &&
> +			    FIELD_GET(DATA_FTR_EV, ftr)) {
> +				sbo = FIELD_GET(DATA_FTR_SWO, ftr) * 4;
> +				ebo = FIELD_GET(DATA_FTR_EBO, ftr) + 1;
> +				if (ebo <= sbo) {
> +					memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
> +					       &payload[0], ebo);
> +					tc6->rxd_bytes += ebo;
> +					oa_tc6_rx_eth_ready(tc6);
> +					tc6->rxd_bytes = 0;
> +					memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
> +					       &payload[sbo], tc6->cps - sbo);
> +					tc6->rxd_bytes += (tc6->cps - sbo);
> +					goto exit;
> +				} else {
> +					memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
> +					       &payload[sbo], ebo - sbo);
> +					tc6->rxd_bytes += (ebo - sbo);
> +					oa_tc6_rx_eth_ready(tc6);
> +					tc6->rxd_bytes = 0;
> +					goto exit;
> +				}
> +			}
> +start_new_frame:
> +			/* Check for start valid to start capturing the incoming
> +			 * ethernet frame.
> +			 */
> +			if (FIELD_GET(DATA_FTR_SV, ftr) && !tc6->rx_eth_started) {
> +				tc6->rxd_bytes = 0;
> +				tc6->rx_eth_started = true;
> +				sbo = FIELD_GET(DATA_FTR_SWO, ftr) * 4;
> +				memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
> +				       &payload[sbo], tc6->cps - sbo);
> +				tc6->rxd_bytes += (tc6->cps - sbo);
> +				goto exit;
> +			}
> +
> +			/* Check for end valid and calculate the copy length */
> +			if (tc6->rx_eth_started) {
> +				if (FIELD_GET(DATA_FTR_EV, ftr))
> +					ebo = FIELD_GET(DATA_FTR_EBO, ftr) + 1;
> +				else
> +					ebo = tc6->cps;
> +
> +				memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes],
> +				       &payload[0], ebo);
> +				tc6->rxd_bytes += ebo;
> +				if (FIELD_GET(DATA_FTR_EV, ftr)) {
> +					/* If End Valid set then send the
> +					 * received ethernet frame to n/w.
> +					 */
> +					oa_tc6_rx_eth_ready(tc6);
> +					tc6->rxd_bytes = 0;
> +					tc6->rx_eth_started = false;
> +				}
> +			}
> +		}
> +
> +exit:
> +		tc6->txc = FIELD_GET(DATA_FTR_TXC, ftr);
> +		tc6->rca = FIELD_GET(DATA_FTR_RCA, ftr);
> +	}
> +	return FTR_OK;
> +
> +err_exit:
> +	if (tc6->rx_eth_started) {
> +		tc6->rxd_bytes = 0;
> +		tc6->rx_eth_started = false;
> +		tc6->netdev->stats.rx_dropped++;
> +	}
> +	return FTR_ERR;
> +}

This is quite a complex function, with a lot of gotos. Please try to
split it up into helpers.

> +
>  static int oa_tc6_handler(void *data)
>  {
>  	struct oa_tc6 *tc6 = data;
> +	bool txc_wait = false;
> +	u16 tx_pos = 0;
>  	u32 regval;
> +	u16 len;
>  	int ret;
>  
>  	while (likely(!kthread_should_stop())) {
> -		wait_event_interruptible(tc6->tc6_wq, tc6->int_flag ||
> +		wait_event_interruptible(tc6->tc6_wq, tc6->tx_flag ||
> +					 tc6->int_flag || tc6->rca ||
>  					 kthread_should_stop());
> -		if (tc6->int_flag) {
> +		if (tc6->int_flag && !tc6->reset) {
>  			tc6->int_flag = false;
> +			tc6->reset = true;
>  			ret = oa_tc6_perform_ctrl(tc6, OA_TC6_STS0, &regval, 1,
>  						  false, false);
>  			if (ret) {
> @@ -227,10 +435,170 @@ static int oa_tc6_handler(void *data)
>  				complete(&tc6->rst_complete);
>  			}
>  		}
> +
> +		if (tc6->int_flag || tc6->rca) {
> +			/* If rca is updated from the previous footer then
> +			 * prepare the empty chunks equal to rca and perform
> +			 * SPI transfer to receive the ethernet frame.
> +			 */
> +			if (tc6->rca) {
> +				len = oa_tc6_prepare_empty_chunk(tc6,
> +								 tc6->spi_tx_buf,
> +								 tc6->rca);
> +			} else {
> +				/* If there is an interrupt then perform a SPI
> +				 * transfer with a empty chunk to get the
> +				 * details.
> +				 */
> +				tc6->int_flag = false;
> +				len = oa_tc6_prepare_empty_chunk(tc6,
> +								 tc6->spi_tx_buf,
> +								 1);
> +			}
> +			/* Perform SPI transfer */
> +			ret = oa_tc6_spi_transfer(tc6->spi, tc6->spi_tx_buf,
> +						  tc6->spi_rx_buf, len);
> +			if (ret) {
> +				netdev_err(tc6->netdev, "SPI transfer failed\n");
> +				continue;
> +			}
> +			/* Process the received chunks to get the ethernet frame
> +			 * or interrupt details.
> +			 */
> +			if (oa_tc6_process_rx_chunks(tc6, tc6->spi_rx_buf, len))
> +				continue;
> +		}
> +
> +		/* If there is a tx ethernet frame available */
> +		if (tc6->tx_flag || txc_wait) {
> +			tc6->tx_flag = false;
> +			txc_wait = false;
> +			len = 0;
> +			if (!tc6->txc) {
> +				/* If there is no txc available to transport the
> +				 * tx ethernet frames then wait for the MAC-PHY
> +				 * interrupt to get the txc availability.
> +				 */
> +				txc_wait = true;
> +				continue;
> +			} else if (tc6->txc >= tc6->txc_needed) {
> +				len = tc6->txc_needed * (tc6->cps + TC6_HDR_SIZE);
> +			} else {
> +				len = tc6->txc * (tc6->cps + TC6_HDR_SIZE);
> +			}
> +			memcpy(&tc6->spi_tx_buf[0], &tc6->eth_tx_buf[tx_pos],
> +			       len);
> +			ret = oa_tc6_spi_transfer(tc6->spi, tc6->spi_tx_buf,
> +						  tc6->spi_rx_buf, len);
> +			if (ret) {
> +				netdev_err(tc6->netdev, "SPI transfer failed\n");
> +				continue;
> +			}
> +			/* Process the received chunks to get the ethernet frame
> +			 * or status.
> +			 */
> +			if (oa_tc6_process_rx_chunks(tc6, tc6->spi_rx_buf,
> +						     len)) {
> +				/* In case of error while processing rx chunks
> +				 * discard the incomplete tx ethernet frame and
> +				 * resend it.
> +				 */
> +				tx_pos = 0;
> +				tc6->txc_needed = tc6->total_txc_needed;
> +			} else {
> +				tx_pos += len;
> +				tc6->txc_needed = tc6->txc_needed -
> +						  (len / (tc6->cps + TC6_HDR_SIZE));
> +				/* If the complete ethernet frame is transmitted
> +				 * then return the skb and update the details to
> +				 * n/w layer.
> +				 */
> +				if (!tc6->txc_needed) {
> +					tc6->netdev->stats.tx_packets++;
> +					tc6->netdev->stats.tx_bytes += tc6->tx_skb->len;
> +					dev_kfree_skb(tc6->tx_skb);
> +					tx_pos = 0;
> +					tc6->tx_skb = NULL;
> +					if (netif_queue_stopped(tc6->netdev))
> +						netif_wake_queue(tc6->netdev);
> +				} else if (tc6->txc) {
> +					/* If txc is available again and updated
> +					 * from the previous footer then perform
> +					 * tx again.
> +					 */
> +					tc6->tx_flag = true;
> +				} else {
> +					/* If there is no txc then wait for the
> +					 * interrupt to indicate txc
> +					 * availability.
> +					 */
> +					txc_wait = true;
> +				}
> +			}
> +		}
>  	}
>  	return 0;
>  }

This is also a huge function. The Linux coding style says:

     Functions should be short and sweet, and do just one thing. They
     should fit on one or two screenfuls of text (the ISO/ANSI screen
     size is 80x24, as we all know), and do one thing and do that
     well.

Please break this up into lots of smaller functions which do just one
thing.

> -struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
> +struct oa_tc6 *oa_tc6_init(struct spi_device *spi, struct net_device *netdev)
>  {
>  	struct oa_tc6 *tc6;
>  	int ret;
> @@ -334,11 +710,39 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
>  	if (!spi)
>  		return NULL;
>  
> +	if (!netdev)
> +		return NULL;

Hos can this happen? Let is explode if some developer is dumb enough
to pass a NULL.

> +#define MAX_ETH_LEN	1536

Where do 1536 come from? Maybe this needs an OA_TC6 prefix to make it
clear this is specific to this protocol?

      Andrew
