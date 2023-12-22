Return-Path: <linux-kernel+bounces-9741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA2481CA87
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C67D1F23DE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B2199A1;
	Fri, 22 Dec 2023 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3uscbi9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1DE182A1;
	Fri, 22 Dec 2023 13:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C95C433C8;
	Fri, 22 Dec 2023 13:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703250621;
	bh=FvnyuJhk+7r4BtcMqRVLyVhaGuE1vRlM7xCE2lBtl7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n3uscbi9mTpk09tfQXWBQ9C4fr4b7ys8h9nWXJ+dSxDHEvAhtzC0LA8Mpmq7UU9bh
	 /O+Hbhgj4cTQjhxCD6LWD9Wrbw3+MDFQC/4GoOYK7VkfhqC26sWFVxOjz4XsUoJ3uO
	 zy2noqDBRjs9Rt+8kevLk1rOqHEm0xIk5VsggD7a4HwgE8saYXz1Icj5lwBWDvLqDC
	 3S5d9o7MIkkqBj+cKblTWKrpwGdL5VjPyKVzhhp+uUYMkJv1UrAsp4NjPp0UufB6nQ
	 GkmluEfetP6hcN9BONpkijLX6AGQkXLjqwZBkKVE1EmQj2jtuejkasB8hQRTzgUzfN
	 OHX/sIUETpHbQ==
Date: Fri, 22 Dec 2023 14:10:12 +0100
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
Subject: Re: [PATCH net-next v1 4/8] octeon_ep_vf: add Tx/Rx ring resource
 setup and cleanup
Message-ID: <20231222131012.GG1202958@kernel.org>
References: <20231221092844.2885872-1-srasheed@marvell.com>
 <20231221092844.2885872-5-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221092844.2885872-5-srasheed@marvell.com>

On Thu, Dec 21, 2023 at 01:28:40AM -0800, Shinas Rasheed wrote:
> Implement Tx/Rx ring resource allocation and cleanup.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Hi Shinas,

some minor feedback from my side which you might consider addressing
if you have to respin the series for some other reason.

...

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

nit: There is no need to cast the return value of vzalloc()

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

nit: vfree can handle a NULL argument, so  there is no need to protect it
     with a if condition

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

