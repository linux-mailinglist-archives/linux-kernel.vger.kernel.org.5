Return-Path: <linux-kernel+bounces-17772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F21825268
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D24285F55
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2ABA28DD7;
	Fri,  5 Jan 2024 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtAjA+qz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B303250ED;
	Fri,  5 Jan 2024 10:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BD9C433C7;
	Fri,  5 Jan 2024 10:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704451865;
	bh=5HHiCiAjaAuvHgJa/tj8s1DVpjgUXb7qEvW/V/7Aapw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtAjA+qznnwWl93QZ9tvOZhxh0Szm0vvtmllgiwfkyfHxLaVVPaFGmyMycpOeP+vr
	 WpCTG92zlMM4drY5Zt0ek0Yyt1YhpAoNsFDaBKMdTzZmbkCJdQ04WJSQWYuW/+ePtV
	 0633wfnere8l2LuGu9R3G+PVQTwNbLgfpj5vhvTidKfruSh2fay5O/vHj4F5ZpQrFb
	 PXJRsGSNKRtz8I082lnvAslQSMKCbSYxkR6fOZy6BYFJ95Yw4A+zgA7J2YPNvh343k
	 CPUlY39XZr3bGMsabr2LVQpbtd3AccsTbqRjqILZTDq3zh7muN0oWWpeHisBTvo84/
	 BPIt3vU6dPstg==
Date: Fri, 5 Jan 2024 10:50:59 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, sedara@marvell.com, egallen@redhat.com,
	mschmidt@redhat.com, pabeni@redhat.com, kuba@kernel.org,
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
	Veerasenareddy Burru <vburru@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v2 4/8] octeon_ep_vf: add Tx/Rx ring resource
 setup and cleanup
Message-ID: <20240105105059.GS31813@kernel.org>
References: <20231223134000.2906144-1-srasheed@marvell.com>
 <20231223134000.2906144-5-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223134000.2906144-5-srasheed@marvell.com>

On Sat, Dec 23, 2023 at 05:39:56AM -0800, Shinas Rasheed wrote:
> Implement Tx/Rx ring resource allocation and cleanup.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Hi Shinas,

some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c

...

> +/**
> + * octep_vf_oq_fill_ring_buffers() - fill initial receive buffers for Rx ring.
> + *
> + * @oq: Octeon Rx queue data structure.
> + *
> + * Return: 0, if successfully filled receive buffers for all descriptors.
> + *         -1, if failed to allocate a buffer or failed to map for DMA.

I think it is more idiomatic to use well known error codes
in kernel code. In this case, perhaps -ENOMEM.

Likewise elsewhere in this patch.

> + */
> +static int octep_vf_oq_fill_ring_buffers(struct octep_vf_oq *oq)
> +{
> +	struct octep_vf_oq_desc_hw *desc_ring = oq->desc_ring;
> +	struct page *page;
> +	u32 i;
> +
> +	for (i = 0; i < oq->max_count; i++) {
> +		page = dev_alloc_page();
> +		if (unlikely(!page)) {
> +			dev_err(oq->dev, "Rx buffer alloc failed\n");
> +			goto rx_buf_alloc_err;
> +		}
> +		desc_ring[i].buffer_ptr = dma_map_page(oq->dev, page, 0,
> +						       PAGE_SIZE,
> +						       DMA_FROM_DEVICE);
> +		if (dma_mapping_error(oq->dev, desc_ring[i].buffer_ptr)) {
> +			dev_err(oq->dev,
> +				"OQ-%d buffer alloc: DMA mapping error!\n",
> +				oq->q_no);
> +			put_page(page);
> +			goto dma_map_err;

nit: I think put_page() can be moved to the dma_map_err label.

> +		}
> +		oq->buff_info[i].page = page;
> +	}
> +
> +	return 0;
> +
> +dma_map_err:
> +rx_buf_alloc_err:
> +	while (i) {
> +		i--;
> +		dma_unmap_page(oq->dev, desc_ring[i].buffer_ptr, PAGE_SIZE, DMA_FROM_DEVICE);
> +		put_page(oq->buff_info[i].page);
> +		oq->buff_info[i].page = NULL;
> +	}
> +
> +	return -1;
> +}
> +
> +/**
> + * octep_vf_setup_oq() - Setup a Rx queue.
> + *
> + * @oct: Octeon device private data structure.
> + * @q_no: Rx queue number to be setup.
> + *
> + * Allocate resources for a Rx queue.
> + */
> +static int octep_vf_setup_oq(struct octep_vf_device *oct, int q_no)
> +{
> +	struct octep_vf_oq *oq;
> +	u32 desc_ring_size;
> +
> +	oq = vzalloc(sizeof(*oq));
> +	if (!oq)
> +		goto create_oq_fail;
> +	oct->oq[q_no] = oq;
> +
> +	oq->octep_vf_dev = oct;
> +	oq->netdev = oct->netdev;
> +	oq->dev = &oct->pdev->dev;
> +	oq->q_no = q_no;
> +	oq->max_count = CFG_GET_OQ_NUM_DESC(oct->conf);
> +	oq->ring_size_mask = oq->max_count - 1;
> +	oq->buffer_size = CFG_GET_OQ_BUF_SIZE(oct->conf);
> +	oq->max_single_buffer_size = oq->buffer_size - OCTEP_VF_OQ_RESP_HW_SIZE;
> +
> +	/* When the hardware/firmware supports additional capabilities,
> +	 * additional header is filled-in by Octeon after length field in
> +	 * Rx packets. this header contains additional packet information.
> +	 */
> +	if (oct->fw_info.rx_ol_flags)
> +		oq->max_single_buffer_size -= OCTEP_VF_OQ_RESP_HW_EXT_SIZE;
> +
> +	oq->refill_threshold = CFG_GET_OQ_REFILL_THRESHOLD(oct->conf);
> +
> +	desc_ring_size = oq->max_count * OCTEP_VF_OQ_DESC_SIZE;
> +	oq->desc_ring = dma_alloc_coherent(oq->dev, desc_ring_size,
> +					   &oq->desc_ring_dma, GFP_KERNEL);
> +
> +	if (unlikely(!oq->desc_ring)) {
> +		dev_err(oq->dev,
> +			"Failed to allocate DMA memory for OQ-%d !!\n", q_no);
> +		goto desc_dma_alloc_err;
> +	}
> +
> +	oq->buff_info = (struct octep_vf_rx_buffer *)
> +			vzalloc(oq->max_count * OCTEP_VF_OQ_RECVBUF_SIZE);

nit: there is no need to cast a void pointer.

	oq->buff_info = vzalloc(oq->max_count * OCTEP_VF_OQ_RECVBUF_SIZE);

> +	if (unlikely(!oq->buff_info)) {
> +		dev_err(&oct->pdev->dev,
> +			"Failed to allocate buffer info for OQ-%d\n", q_no);
> +		goto buf_list_err;
> +	}
> +
> +	if (octep_vf_oq_fill_ring_buffers(oq))
> +		goto oq_fill_buff_err;
> +
> +	octep_vf_oq_reset_indices(oq);
> +	oct->hw_ops.setup_oq_regs(oct, q_no);
> +	oct->num_oqs++;
> +
> +	return 0;
> +
> +oq_fill_buff_err:
> +	vfree(oq->buff_info);
> +	oq->buff_info = NULL;
> +buf_list_err:
> +	dma_free_coherent(oq->dev, desc_ring_size,
> +			  oq->desc_ring, oq->desc_ring_dma);
> +	oq->desc_ring = NULL;
> +desc_dma_alloc_err:
> +	vfree(oq);
> +	oct->oq[q_no] = NULL;
> +create_oq_fail:
> +	return -1;
> +}

...

> +/**
> + * octep_vf_free_oq() - Free Rx queue resources.
> + *
> + * @oq: Octeon Rx queue data structure.
> + *
> + * Free all resources of a Rx queue.
> + */
> +static int octep_vf_free_oq(struct octep_vf_oq *oq)
> +{
> +	struct octep_vf_device *oct = oq->octep_vf_dev;
> +	int q_no = oq->q_no;
> +
> +	octep_vf_oq_free_ring_buffers(oq);
> +
> +	if (oq->buff_info)
> +		vfree(oq->buff_info);

nit: there is no need to check for NULL as vfree() can handle
     a NULL argument.

> +
> +	if (oq->desc_ring)
> +		dma_free_coherent(oq->dev,
> +				  oq->max_count * OCTEP_VF_OQ_DESC_SIZE,
> +				  oq->desc_ring, oq->desc_ring_dma);
> +
> +	vfree(oq);
> +	oct->oq[q_no] = NULL;
> +	oct->num_oqs--;
> +	return 0;
> +}

...

> +/**
> + * octep_vf_free_iq() - Free Tx queue resources.
> + *
> + * @iq: Octeon Tx queue data structure.
> + *
> + * Free all the resources allocated for a Tx queue.
> + */
> +static void octep_vf_free_iq(struct octep_vf_iq *iq)
> +{
> +	struct octep_vf_device *oct = iq->octep_vf_dev;
> +	u64 desc_ring_size, sglist_size;
> +	int q_no = iq->q_no;
> +
> +	desc_ring_size = OCTEP_VF_IQ_DESC_SIZE * CFG_GET_IQ_NUM_DESC(oct->conf);
> +
> +	if (iq->buff_info)
> +		vfree(iq->buff_info);

Ditto.

> +
> +	if (iq->desc_ring)
> +		dma_free_coherent(iq->dev, desc_ring_size,
> +				  iq->desc_ring, iq->desc_ring_dma);
> +
> +	sglist_size = OCTEP_VF_SGLIST_SIZE_PER_PKT *
> +		      CFG_GET_IQ_NUM_DESC(oct->conf);
> +	if (iq->sglist)
> +		dma_free_coherent(iq->dev, sglist_size,
> +				  iq->sglist, iq->sglist_dma);
> +
> +	vfree(iq);
> +	oct->iq[q_no] = NULL;
> +	oct->num_iqs--;
>  }

...

