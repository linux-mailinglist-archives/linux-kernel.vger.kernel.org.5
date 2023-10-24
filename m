Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB107D4552
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 04:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjJXCHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 22:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjJXCHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 22:07:23 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E15A4;
        Mon, 23 Oct 2023 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=kLiGhnX5zQwB/BzwQRqYcmHWrhiC8XReLyj6hICSTFo=; b=vPeLO5pVIVQ+DszrzLwWXndym5
        QBVFQjOlofnj/GByDXGDmhJxx4M8h/EbwmHxWgjKPRriUIEthQ0UdmG+QJ3PAlyZfJzKRT66C+llX
        NsPhQo9vf8y9S9B+URxAejEoe5WmNwDZEWJlK2hpcuuwXeRoGB36BnwyeFKrmnGi0lQU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qv6ow-00020X-5N; Tue, 24 Oct 2023 04:07:02 +0200
Date:   Tue, 24 Oct 2023 04:07:02 +0200
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
Subject: Re: [PATCH net-next v2 7/9] net: ethernet: oa_tc6: implement data
 transaction interface
Message-ID: <9b7a5ed9-840f-4346-a168-e538a8477714@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <20231023154649.45931-8-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023154649.45931-8-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static u16 oa_tc6_prepare_empty_chunk(struct oa_tc6 *tc6, u8 *buf, u8 cp_count)
> +{
> +	u32 hdr;
> +
> +	/* Prepare empty chunks used for getting interrupt information or if
> +	 * receive data available.
> +	 */
> +	for (u8 i = 0; i < cp_count; i++) {
> +		hdr = FIELD_PREP(DATA_HDR_DNC, 1);
> +		hdr |= FIELD_PREP(DATA_HDR_P, oa_tc6_get_parity(hdr));
> +		*(__be32 *)&buf[i * (tc6->cps + TC6_HDR_SIZE)] = cpu_to_be32(hdr);
> +		memset(&buf[TC6_HDR_SIZE + (i * (tc6->cps + TC6_HDR_SIZE))], 0,
> +		       tc6->cps);
> +	}

This is not simple, and its the sort of code which makes me wounder if
its gone off the end of the buffer. It would be good to find somebody
internally within Microchip to review this code.

> +static void oa_tc6_rx_eth_ready(struct oa_tc6 *tc6)
> +{
> +	struct sk_buff *skb;
> +
> +	/* Send the received ethernet packet to network layer */
> +	skb = netdev_alloc_skb(tc6->netdev, tc6->rxd_bytes + NET_IP_ALIGN);
> +	if (!skb) {
> +		tc6->netdev->stats.rx_dropped++;
> +		netdev_dbg(tc6->netdev, "Out of memory for rx'd frame");

You can just return here, and skip the else. Less indentation is
better, it generally makes the code more readable.

> +	} else {
> +		skb_reserve(skb, NET_IP_ALIGN);
> +		memcpy(skb_put(skb, tc6->rxd_bytes), &tc6->eth_rx_buf[0],
> +		       tc6->rxd_bytes);
> +		skb->protocol = eth_type_trans(skb, tc6->netdev);
> +		tc6->netdev->stats.rx_packets++;
> +		tc6->netdev->stats.rx_bytes += tc6->rxd_bytes;
> +		/* 0 for NET_RX_SUCCESS and 1 for NET_RX_DROP */
> +		if (netif_rx(skb))
> +			tc6->netdev->stats.rx_dropped++;

Rather than have a comment do:

		if (netif_rx(skb) == NET_RX_DROP)
			tc6->netdev->stats.rx_dropped++;


> +static void oa_tc6_rx_eth_complete2(struct oa_tc6 *tc6, u8 *payload, u32 ftr)
> +{
> +	u16 ebo;

What does ftr and ebo mean? Its really hard to read this code because
the names are not really meaningful.

> +
> +	if (FIELD_GET(DATA_FTR_EV, ftr))
> +		ebo = FIELD_GET(DATA_FTR_EBO, ftr) + 1;
> +	else
> +		ebo = tc6->cps;
> +
> +	memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[0], ebo);
> +	tc6->rxd_bytes += ebo;
> +	if (FIELD_GET(DATA_FTR_EV, ftr)) {
> +		/* If EV set then send the received ethernet frame to n/w */
> +		oa_tc6_rx_eth_ready(tc6);
> +		tc6->rxd_bytes = 0;
> +		tc6->rx_eth_started = false;
> +	}
> +}
> +
> +static void oa_tc6_rx_eth_complete1(struct oa_tc6 *tc6, u8 *payload, u32 ftr)
> +{
> +	u16 ebo;
> +	u16 sbo;
> +
> +	sbo = FIELD_GET(DATA_FTR_SWO, ftr) * 4;
> +	ebo = FIELD_GET(DATA_FTR_EBO, ftr) + 1;
> +
> +	if (ebo <= sbo) {
> +		memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[0], ebo);
> +		tc6->rxd_bytes += ebo;
> +		oa_tc6_rx_eth_ready(tc6);
> +		tc6->rxd_bytes = 0;
> +		memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[sbo],
> +		       tc6->cps - sbo);
> +		tc6->rxd_bytes += (tc6->cps - sbo);
> +	} else {
> +		memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[sbo],
> +		       ebo - sbo);
> +		tc6->rxd_bytes += (ebo - sbo);
> +		oa_tc6_rx_eth_ready(tc6);
> +		tc6->rxd_bytes = 0;
> +	}
> +}
> +
> +static void oa_tc6_start_rx_eth(struct oa_tc6 *tc6, u8 *payload, u32 ftr)
> +{
> +	u16 sbo;
> +
> +	tc6->rxd_bytes = 0;
> +	tc6->rx_eth_started = true;
> +	sbo = FIELD_GET(DATA_FTR_SWO, ftr) * 4;
> +	memcpy(&tc6->eth_rx_buf[tc6->rxd_bytes], &payload[sbo], tc6->cps - sbo);
> +	tc6->rxd_bytes += (tc6->cps - sbo);
> +}
> +
> +static u32 oa_tc6_get_footer(struct oa_tc6 *tc6, u8 *buf, u8 cp_num)
> +{
> +	__be32 ftr;
> +
> +	ftr = *(__be32 *)&buf[tc6->cps + (cp_num * (tc6->cps + TC6_FTR_SIZE))];
> +
> +	return be32_to_cpu(ftr);
> +}
> +
> +static void oa_tc6_update_txc_rca(struct oa_tc6 *tc6, u32 ftr)
> +{
> +	tc6->txc = FIELD_GET(DATA_FTR_TXC, ftr);
> +	tc6->rca = FIELD_GET(DATA_FTR_RCA, ftr);
> +}
> +
> +static int oa_tc6_check_ftr_errors(struct oa_tc6 *tc6, u32 ftr)
> +{
> +	/* Check for footer parity error */
> +	if (oa_tc6_get_parity(ftr)) {
> +		net_err_ratelimited("%s: Footer parity error\n",
> +				    tc6->netdev->name);
> +		return FTR_ERR;
> +	}
> +	/* If EXST set in the footer then read STS0 register to get the
> +	 * status information.
> +	 */
> +	if (FIELD_GET(DATA_FTR_EXST, ftr)) {
> +		if (oa_tc6_process_exst(tc6))
> +			net_err_ratelimited("%s: Failed to process EXST\n",
> +					    tc6->netdev->name);
> +		return FTR_ERR;
> +	}
> +	if (FIELD_GET(DATA_FTR_HDRB, ftr)) {
> +		net_err_ratelimited("%s: Footer eeceived header bad\n",
> +				    tc6->netdev->name);
> +		return FTR_ERR;
> +	}
> +	if (!FIELD_GET(DATA_FTR_SYNC, ftr)) {
> +		net_err_ratelimited("%s: Footer configuration unsync\n",
> +				    tc6->netdev->name);
> +		return FTR_ERR;
> +	}
> +	return FTR_OK;
> +}
> +
> +static void oa_tc6_drop_rx_eth(struct oa_tc6 *tc6)
> +{
> +	tc6->rxd_bytes = 0;
> +	tc6->rx_eth_started = false;
> +	tc6->netdev->stats.rx_dropped++;
> +	net_err_ratelimited("%s: Footer frame drop\n",
> +			    tc6->netdev->name);
> +}
> +
> +static int oa_tc6_process_rx_chunks(struct oa_tc6 *tc6, u8 *buf, u16 len)
> +{
> +	u8 cp_count;
> +	u8 *payload;
> +	u32 ftr;
> +	int ret;
> +
> +	/* Calculate the number of chunks received */
> +	cp_count = len / (tc6->cps + TC6_FTR_SIZE);
> +
> +	for (u8 i = 0; i < cp_count; i++) {
> +		/* Get the footer and payload */
> +		ftr = oa_tc6_get_footer(tc6, buf, i);
> +		payload = &buf[(i * (tc6->cps + TC6_FTR_SIZE))];

This would be more readable:

	/* Calculate the number of chunks received */
	chunks = len / (tc6->cps + TC6_FTR_SIZE);

	for (u8 chunk = 0; chunk < chunks; chunk++) {
		/* Get the footer and payload */
		ftr = oa_tc6_get_footer(tc6, buf, chunk);
		payload = &buf[(chunk * (tc6->cps + TC6_FTR_SIZE))];

etc.

And maybe move most of this code into a function
oa_tc6_process_rx_chunk(). With lots of small functions with good
names, you need less comments.


> +		/* Check for data valid */
> +		if (FIELD_GET(DATA_FTR_DV, ftr)) {
> +			/* Check whether both start valid and end valid are in a
> +			 * single chunk payload means a single chunk payload may
> +			 * contain an entire ethernet frame.
> +			 */
> +			if (FIELD_GET(DATA_FTR_SV, ftr) &&
> +			    FIELD_GET(DATA_FTR_EV, ftr)) {


		if (FIELD_GET(DATA_FOOTER_START_VALID, footer) &&
		    FIELD_GET(DATA_FOOTER_END_VALID, footer)) {

Don't you think that is more readable?

> +static void oa_tc6_prepare_tx_chunks(struct oa_tc6 *tc6, u8 *buf,
> +				     struct sk_buff *skb)
> +{
> +	bool frame_started = false;
> +	u16 copied_bytes = 0;
> +	u16 copy_len;
> +	u32 hdr;
> +
> +	/* Calculate the number tx credit counts needed to transport the tx
> +	 * ethernet frame.
> +	 */
> +	tc6->txc_needed = (skb->len / tc6->cps) + ((skb->len % tc6->cps) ? 1 : 0);

Why call it a credit here, but a chunk when receiving?

> +static int oa_tc6_perform_spi_xfer(struct oa_tc6 *tc6)
> +{
> +	bool do_tx_again;
> +	u16 total_len;
> +	u16 rca_len;
> +	u16 tx_len;
> +	int ret;
> +
> +	do {
> +		do_tx_again = false;
> +		rca_len = 0;
> +		tx_len = 0;
> +
> +		/* In case of an interrupt, perform an empty chunk transfer to
> +		 * know the purpose of the interrupt. Interrupt may occur in
> +		 * case of RCA (Receive Chunk Available) and TXC (Transmit
> +		 * Credit Count). Both will occur if they are not indicated
> +		 * through the previous footer.
> +		 */
> +		if (tc6->int_flag) {
> +			tc6->int_flag = false;
> +			total_len = oa_tc6_prepare_empty_chunk(tc6,
> +							       tc6->spi_tx_buf,
> +							       1);
> +		} else {
> +			/* Calculate the transfer length */
> +			if (tc6->tx_flag && tc6->txc) {
> +				tx_len = oa_tc6_calculate_tx_len(tc6);
> +				memcpy(&tc6->spi_tx_buf[0],
> +				       &tc6->eth_tx_buf[tc6->tx_pos], tx_len);
> +			}
> +
> +			if (tc6->rca)
> +				rca_len = oa_tc6_calculate_rca_len(tc6, tx_len);
> +
> +			total_len = tx_len + rca_len;
> +		}
> +		ret = oa_tc6_spi_transfer(tc6->spi, tc6->spi_tx_buf,
> +					  tc6->spi_rx_buf, total_len);
> +		if (ret)
> +			return ret;
> +		/* Process the rxd chunks to get the ethernet frame or status */
> +		ret = oa_tc6_process_rx_chunks(tc6, tc6->spi_rx_buf, total_len);
> +		if (ret)
> +			return ret;
> +		if (tc6->tx_flag) {
> +			tc6->tx_pos += tx_len;
> +			tc6->txc_needed = tc6->txc_needed -
> +					  (tx_len / (tc6->cps + TC6_HDR_SIZE));
> +			/* If the complete ethernet frame is transmitted then
> +			 * return the skb and update the details to n/w layer.
> +			 */
> +			if (!tc6->txc_needed)
> +				oa_tc6_tx_eth_complete(tc6);
> +			else if (tc6->txc)
> +				/* If txc is available again and updated from
> +				 * the previous footer then perform tx again.
> +				 */
> +				do_tx_again = true;
> +		}
> +
> +		/* If rca is updated from the previous footer then perform empty
> +		 * tx to receive ethernet frame.
> +		 */
> +		if (tc6->rca)
> +			do_tx_again = true;
> +	} while (do_tx_again);

The coding standard say:

Functions should be short and sweet, and do just one thing. They
should fit on one or two screenfuls of text (the ISO/ANSI screen size
is 80x24, as we all know), and do one thing and do that well.

This is too long, and does too many things.

     Andrew
