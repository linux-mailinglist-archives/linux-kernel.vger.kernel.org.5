Return-Path: <linux-kernel+bounces-17217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8278249F2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D2F287C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 21:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4142C1B5;
	Thu,  4 Jan 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKkap8LN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6EE2D78D;
	Thu,  4 Jan 2024 21:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4D5C433C8;
	Thu,  4 Jan 2024 21:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704402017;
	bh=dmMY+NqMp5EPtMDl4fN5j64AngkjIkbw86hL5YSeuhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dKkap8LNcwOi4O6dx1Yj8GhJyrY2Oj8IVc3t8GA7bK2MnigpF9c0R6Dgivem55J51
	 aZ+qmB1rQxjDDlcAvl11/G1o3U2kXptANj4ovtzF4r5K3Zf8tPvksKBfJkW7f3ZtPE
	 /LdbnsQYHA63LhGmahmSbPvfP5ceJKnHGH83ML5XRNz+BMVc9cAni4s8GnkXMPtjBb
	 OUBjZx8iIV+9RoMetXN5kQ7xo5WIOkITUhFbHtRmdJwxLc/TJDX2uCOxFRM0iSJjFF
	 TL7z8VCIMWVxEpeOt+yuvNOFPvfKqiCJH9+9jzKS0HWA/GK22bhpBYl0rHGzzAtxHn
	 5t7ipmqeQNK2w==
Date: Thu, 4 Jan 2024 13:00:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <vimleshk@marvell.com>, <sedara@marvell.com>,
 <egallen@redhat.com>, <mschmidt@redhat.com>, <pabeni@redhat.com>,
 <horms@kernel.org>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <konguyen@redhat.com>, Veerasenareddy Burru <vburru@marvell.com>, Satananda
 Burla <sburla@marvell.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 6/8] octeon_ep_vf: add Tx/Rx processing and
 interrupt support
Message-ID: <20240104130016.47bc1071@kernel.org>
In-Reply-To: <20231223134000.2906144-7-srasheed@marvell.com>
References: <20231223134000.2906144-1-srasheed@marvell.com>
	<20231223134000.2906144-7-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Dec 2023 05:39:58 -0800 Shinas Rasheed wrote:
> +static int octep_vf_napi_poll(struct napi_struct *napi, int budget)
> +{
> +	struct octep_vf_ioq_vector *ioq_vector =
> +		container_of(napi, struct octep_vf_ioq_vector, napi);
> +	u32 tx_pending, rx_done;
> +
> +	tx_pending = octep_vf_iq_process_completions(ioq_vector->iq, budget);

completions should use some static budget, say 256, the budget passed
in is for Rx.

> +	rx_done = octep_vf_oq_process_rx(ioq_vector->oq, budget);

You should not call Rx processing if budget is 0 at all, please see
NAPI docs. Looks like the function may try to refill Rx buffers with
budget of 0.

> +	/* need more polling if tx completion processing is still pending or
> +	 * processed at least 'budget' number of rx packets.
> +	 */
> +	if (tx_pending || rx_done >= budget)
> +		return budget;
> +
> +	napi_complete(napi);

please use napi_complete_done().

> +	octep_vf_enable_ioq_irq(ioq_vector->iq, ioq_vector->oq);
> +	return rx_done;
> +}

>  /**
>   * octep_vf_start_xmit() - Enqueue packet to Octoen hardware Tx Queue.
>   *
> @@ -184,6 +591,143 @@ static int octep_vf_stop(struct net_device *netdev)
>  static netdev_tx_t octep_vf_start_xmit(struct sk_buff *skb,
>  				       struct net_device *netdev)
>  {
> [...]
> +dma_map_sg_err:
> +	if (si > 0) {
> +		dma_unmap_single(iq->dev, sglist[0].dma_ptr[0],
> +				 sglist[0].len[0], DMA_TO_DEVICE);
> +		sglist[0].len[0] = 0;
> +	}
> +	while (si > 1) {
> +		dma_unmap_page(iq->dev, sglist[si >> 2].dma_ptr[si & 3],
> +			       sglist[si >> 2].len[si & 3], DMA_TO_DEVICE);
> +		sglist[si >> 2].len[si & 3] = 0;
> +		si--;
> +	}
> +	tx_buffer->gather = 0;
> +dma_map_err:

if previous tx had xmit_more() you need to ring the doorbell here

> +	dev_kfree_skb_any(skb);
>  	return NETDEV_TX_OK;
>  }

> @@ -114,8 +158,8 @@ static int octep_vf_setup_oq(struct octep_vf_device *oct, int q_no)
>  		goto desc_dma_alloc_err;
>  	}
>  
> -	oq->buff_info = (struct octep_vf_rx_buffer *)
> -			vzalloc(oq->max_count * OCTEP_VF_OQ_RECVBUF_SIZE);
> +	oq->buff_info = vzalloc(oq->max_count * OCTEP_VF_OQ_RECVBUF_SIZE);
> +

bad fixup squash?

>  	if (unlikely(!oq->buff_info)) {
>  		dev_err(&oct->pdev->dev,
>  			"Failed to allocate buffer info for OQ-%d\n", q_no);


> +		/* Swap the length field that is in Big-Endian to CPU */
> +		buff_info->len = be64_to_cpu(resp_hw->length);
> +		if (oct->fw_info.rx_ol_flags) {
> +			/* Extended response header is immediately after
> +			 * response header (resp_hw)
> +			 */
> +			resp_hw_ext = (struct octep_vf_oq_resp_hw_ext *)
> +				      (resp_hw + 1);
> +			buff_info->len -= OCTEP_VF_OQ_RESP_HW_EXT_SIZE;
> +			/* Packet Data is immediately after
> +			 * extended response header.
> +			 */
> +			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE +
> +				      OCTEP_VF_OQ_RESP_HW_EXT_SIZE;
> +			rx_ol_flags = resp_hw_ext->rx_ol_flags;
> +		} else {
> +			/* Data is immediately after
> +			 * Hardware Rx response header.
> +			 */
> +			data_offset = OCTEP_VF_OQ_RESP_HW_SIZE;
> +			rx_ol_flags = 0;
> +		}
> +		rx_bytes += buff_info->len;
> +
> +		if (buff_info->len <= oq->max_single_buffer_size) {
> +			skb = build_skb((void *)resp_hw, PAGE_SIZE);

napi_build_skb() ?

> +			skb_reserve(skb, data_offset);
> +			skb_put(skb, buff_info->len);
> +			read_idx++;
> +			desc_used++;
> +			if (read_idx == oq->max_count)
> +				read_idx = 0;
> +		} else {
> +			struct skb_shared_info *shinfo;
> +			u16 data_len;
> +
> +			skb = build_skb((void *)resp_hw, PAGE_SIZE);

ditto

> +			skb_reserve(skb, data_offset);
> +			/* Head fragment includes response header(s);
> +			 * subsequent fragments contains only data.
> +			 */
> +			skb_put(skb, oq->max_single_buffer_size);
> +			read_idx++;
> +			desc_used++;
> +			if (read_idx == oq->max_count)
> +				read_idx = 0;
> +
> +			shinfo = skb_shinfo(skb);
> +			data_len = buff_info->len - oq->max_single_buffer_size;
> +			while (data_len) {
> +				dma_unmap_page(oq->dev, oq->desc_ring[read_idx].buffer_ptr,
> +					       PAGE_SIZE, DMA_FROM_DEVICE);
> +				buff_info = (struct octep_vf_rx_buffer *)
> +					    &oq->buff_info[read_idx];
> +				if (data_len < oq->buffer_size) {
> +					buff_info->len = data_len;
> +					data_len = 0;
> +				} else {
> +					buff_info->len = oq->buffer_size;
> +					data_len -= oq->buffer_size;
> +				}
> +
> +				skb_add_rx_frag(skb, shinfo->nr_frags,
> +						buff_info->page, 0,
> +						buff_info->len,
> +						buff_info->len);
> +				buff_info->page = NULL;
> +				read_idx++;
> +				desc_used++;
> +				if (read_idx == oq->max_count)
> +					read_idx = 0;
> +			}
> +		}
> +
> +		skb->dev = oq->netdev;
> +		skb->protocol =  eth_type_trans(skb, skb->dev);

double space

> +		if (feat & NETIF_F_RXCSUM &&
> +		    OCTEP_VF_RX_CSUM_VERIFIED(rx_ol_flags))
> +			skb->ip_summed = CHECKSUM_UNNECESSARY;
> +		else
> +			skb->ip_summed = CHECKSUM_NONE;
> +		napi_gro_receive(oq->napi, skb);
> +	}
> +
> +	oq->host_read_idx = read_idx;
> +	oq->refill_count += desc_used;
> +	oq->stats.packets += pkt;
> +	oq->stats.bytes += rx_bytes;
> +
> +	return pkt;
> +}

> +/**
> + * octep_vf_iq_process_completions() - Process Tx queue completions.
> + *
> + * @iq: Octeon Tx queue data structure.
> + * @budget: max number of completions to be processed in one invocation.
> + */
> +int octep_vf_iq_process_completions(struct octep_vf_iq *iq, u16 budget)
> +{
> [...]
> +	netdev_tx_completed_queue(iq->netdev_q, compl_pkts, compl_bytes);
> +
> +	if (unlikely(__netif_subqueue_stopped(iq->netdev, iq->q_no)) &&
> +	    (IQ_INSTR_SPACE(iq) >
> +	     OCTEP_VF_WAKE_QUEUE_THRESHOLD))
> +		netif_wake_subqueue(iq->netdev, iq->q_no);

Please use helpers form net/netdev_queues.h

> @@ -195,8 +267,7 @@ static void octep_vf_free_iq(struct octep_vf_iq *iq)
>  
>  	desc_ring_size = OCTEP_VF_IQ_DESC_SIZE * CFG_GET_IQ_NUM_DESC(oct->conf);
>  
> -	if (iq->buff_info)
> -		vfree(iq->buff_info);
> +	vfree(iq->buff_info);

This should be in a previous patch.

