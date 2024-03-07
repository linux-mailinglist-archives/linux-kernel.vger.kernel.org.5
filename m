Return-Path: <linux-kernel+bounces-95910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DA78754DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAE41C21D76
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90172130AD7;
	Thu,  7 Mar 2024 17:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KEWhWjVK"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBF612DDBE;
	Thu,  7 Mar 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709831321; cv=none; b=Dftxcn9d8SRIPH+AZFBAa3FMuTG39Wi/+v8KWyu/EMuSN2xcBsS+gmTxJ1VR0T0PhU6JngkQzYJKbf8OCQOwQM9pCNHZJ3Cy23qdDPxoMjd3a59kGErux7uDiW4DJ13UzzHeyMG5GA5OIetrCPy+QfM0d+PdqHHqmCcB6q/fmHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709831321; c=relaxed/simple;
	bh=JXl2uazT63Iyfp3B6864Ck7/1RQX0rkbSuPryxHAo0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loCZEV8HoQeUjiveMgdc/zVgZOmVfWvQzc1Ek3vV6/WIbl6WL99Ruebk+Rj0uvKtqHNneK7V43E+1WXHEkBQ6t8DV641PSXne9PAdRJQICzPvdGCj49uefx5gUNX4mYuM6WGR9tQVukS1GPWoWPxCEDI8rjTDjm2EfJ+qveDO1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KEWhWjVK; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5k0dUR2rE2fxeaqvwbqJwiFlYYiMm6GdJ7apm0o5Iao=; b=KEWhWjVKEPumuzv+FC9Okoz2rs
	sFQizONg4p1DYUBmD7SY/D7PHP2LWvDMYhY4s1W381ZZsl7MiX1oJHkBcEe/jjLKYhN7XBgv/tY6N
	n24mGeuswskJ2SFIpb0Kc3GglnZXQM7ne/YzhuyCW6er60H3yukn3ZevfzRcTKofH2zk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1riHEi-009bZV-K1; Thu, 07 Mar 2024 18:08:52 +0100
Date: Thu, 7 Mar 2024 18:08:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, saeedm@nvidia.com,
	anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, corbet@lwn.net,
	linux-doc@vger.kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, horatiu.vultur@microchip.com,
	ruanjinjie@huawei.com, steen.hegelund@microchip.com,
	vladimir.oltean@nxp.com, UNGLinuxDriver@microchip.com,
	Thorsten.Kummermehr@microchip.com, Pier.Beruto@onsemi.com,
	Selvamani.Rajagopal@onsemi.com, Nicolas.Ferre@microchip.com,
	benjamin.bigler@bernformulastudent.ch
Subject: Re: [PATCH net-next v3 08/12] net: ethernet: oa_tc6: implement
 transmit path to transfer tx ethernet frames
Message-ID: <208fb61b-4740-46bf-8c70-29ab59cbb965@lunn.ch>
References: <20240306085017.21731-1-Parthiban.Veerasooran@microchip.com>
 <20240306085017.21731-9-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306085017.21731-9-Parthiban.Veerasooran@microchip.com>

> @@ -55,6 +77,14 @@
>  						(OA_TC6_CTRL_MAX_REGISTERS *\
>  						OA_TC6_CTRL_REG_VALUE_SIZE) +\
>  						OA_TC6_CTRL_IGNORED_SIZE)
> +#define OA_TC6_CHUNK_PAYLOAD_SIZE		64
> +#define OA_TC6_DATA_HEADER_SIZE			4
> +#define OA_TC6_CHUNK_SIZE			(OA_TC6_DATA_HEADER_SIZE +\
> +						OA_TC6_CHUNK_PAYLOAD_SIZE)
> +#define OA_TC6_TX_SKB_QUEUE_SIZE		100

So you keep up to 100 packets in a queue. If use assume typical MTU
size packets, that is 1,238,400 bits. At 10Mbps, that is 120ms of
traffic. That is quite a lot of latency when a high priority packet is
added to the tail of the queue and needs to wait for all the other
packets to be sent first.

Chunks are 64 bytes. So in practice, you only ever need two
packets. You need to be able to fill a chunk with the final part of
one packet, and the beginning of the next. So i would try using a much
smaller queue size. That will allow Linux queue disciplines to give
you the high priority packets first which you send with low latency.

> +static void oa_tc6_add_tx_skb_to_spi_buf(struct oa_tc6 *tc6)
> +{
> +	enum oa_tc6_data_start_valid_info start_valid = OA_TC6_DATA_START_INVALID;
> +	enum oa_tc6_data_end_valid_info end_valid = OA_TC6_DATA_END_INVALID;
> +	__be32 *tx_buf = tc6->spi_data_tx_buf + tc6->spi_data_tx_buf_offset;
> +	u16 remaining_length = tc6->tx_skb->len - tc6->tx_skb_offset;
> +	u8 *tx_skb_data = tc6->tx_skb->data + tc6->tx_skb_offset;
> +	u8 end_byte_offset = 0;
> +	u16 length_to_copy;
> +
> +	/* Set start valid if the current tx chunk contains the start of the tx
> +	 * ethernet frame.
> +	 */
> +	if (!tc6->tx_skb_offset)
> +		start_valid = OA_TC6_DATA_START_VALID;
> +
> +	/* If the remaining tx skb length is more than the chunk payload size of
> +	 * 64 bytes then copy only 64 bytes and leave the ongoing tx skb for
> +	 * next tx chunk.
> +	 */
> +	length_to_copy = min_t(u16, remaining_length, OA_TC6_CHUNK_PAYLOAD_SIZE);
> +
> +	/* Copy the tx skb data to the tx chunk payload buffer */
> +	memcpy(tx_buf + 1, tx_skb_data, length_to_copy);
> +	tc6->tx_skb_offset += length_to_copy;

You probably need a call to skb_linearize() somewhere. You assume the
packet data is contiguous. It can in fact be split into multiple
segments. skb_linearize() will convert it to a single buffer.

> +static int oa_tc6_try_spi_transfer(struct oa_tc6 *tc6)
> +{
> +	int ret;
> +
> +	while (true) {
> +		u16 spi_length = 0;
> +
> +		tc6->spi_data_tx_buf_offset = 0;
> +
> +		if (tc6->tx_skb || !skb_queue_empty(&tc6->tx_skb_q))
> +			spi_length = oa_tc6_prepare_spi_tx_buf_for_tx_skbs(tc6);
> +
> +		if (spi_length == 0)
> +			break;
> +
> +		ret = oa_tc6_spi_transfer(tc6, OA_TC6_DATA_HEADER, spi_length);
> +		if (ret) {
> +			netdev_err(tc6->netdev,
> +				   "SPI data transfer failed. Restart the system: %d\n",
> +				   ret);

What does Restart the system mean?

> +static int oa_tc6_spi_thread_handler(void *data)
> +{
> +	struct oa_tc6 *tc6 = data;
> +	int ret;
> +
> +	while (likely(!kthread_should_stop())) {
> +		/* This kthread will be waken up if there is a tx skb */
> +		wait_event_interruptible(tc6->spi_wq,
> +					 !skb_queue_empty(&tc6->tx_skb_q) ||
> +					 kthread_should_stop());
> +		ret = oa_tc6_try_spi_transfer(tc6);

Shouldn't you check why you have been woken up? It seems more logical
to test here for kthread_should_stop() rather than have
oa_tc6_try_spi_transfer() handle there is not actually a packet to be
sent.

	Andrew

