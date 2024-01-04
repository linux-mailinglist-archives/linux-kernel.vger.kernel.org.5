Return-Path: <linux-kernel+bounces-17046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF27E824792
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743B81F222EC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D58528DA7;
	Thu,  4 Jan 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UG0FYjZN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018AD28688;
	Thu,  4 Jan 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704389921; x=1735925921;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WiYj6jsuvxuNOKApf9v1fdSvLS07twZp93zp05rsGz8=;
  b=UG0FYjZNHnwdC18RkOSYsBIid55MEmoOwHY2NP0xsaza74aCc8ffn+Be
   zYKe5SBLsl0+XtBDko8SnIvP73roJy7cPL0OtsrjhJPuonRcgZm9E7Ser
   4tfySLf3DGVP6+HnYoAM3mmo1j/EC1PTJAVm6XYrQdVyDdAjaZBkoE8By
   iBuazPq+x45+7AmAE7ytbQf8+aTVLqVrw6xeV/Ia9IZePKpdGWzyRAfNv
   /wblGOfNWh90G68oYqSOkZTgqKuURAKLEOsyFW9nFA6mLNU9IbZxkDQK5
   6CriOWEapn3OrYyDit2elmgfoCoKOoUbBKOXUMttTIOdGBcEXzHH31DUx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="4678047"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="4678047"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:38:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="1111834093"
X-IronPort-AV: E=Sophos;i="6.04,331,1695711600"; 
   d="scan'208";a="1111834093"
Received: from asebenix-mobl1.ger.corp.intel.com ([10.251.210.215])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 09:38:37 -0800
Date: Thu, 4 Jan 2024 19:38:35 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Liming Sun <limings@nvidia.com>
cc: Vadim Pasternak <vadimp@nvidia.com>, 
    David Thompson <davthompson@nvidia.com>, 
    Hans de Goede <hdegoede@redhat.com>, Mark Gross <markgross@kernel.org>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] Drop Tx network packet when Tx TmFIFO is full
In-Reply-To: <02fd0faaa555d1914b6ff4bd4b0b294e16989cef.1704381197.git.limings@nvidia.com>
Message-ID: <c510206b-1dbb-8f1-642d-7e1c8ac7a7c@linux.intel.com>
References: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com> <02fd0faaa555d1914b6ff4bd4b0b294e16989cef.1704381197.git.limings@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-677012229-1704389919=:10531"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-677012229-1704389919=:10531
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 4 Jan 2024, Liming Sun wrote:

> Starting from Linux 5.16 kernel, Tx timeout mechanism was added
> into the virtio_net driver which prints the "Tx timeout" message
> when a packet is stuck in Tx queue for too long which could happen
> when external host driver is stuck or stopped and failed to read
> the FIFO.
> 
> Below is an example of the reported message:
> 
> "[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
> queue: 0, sq: output.0, vq: 0×1, name: output.0, usecs since
> last trans: 3079892256".
> 
> To avoid such "Tx timeout" messages, this commit adds a timeout
> mechanism to drop and release the pending Tx packet if not able to
> transmit for two seconds due to Tx FIFO full.
> 
> This commit also handles the special case that the packet is half-
> transmitted into the Tx FIFO. In such case, the packet is discarded
> with remaining length stored in vring->rem_padding. So paddings with
> zeros can be sent out when Tx space is available to maintain the
> integrity of the packet format. The padded packet will be dropped on
> the receiving side.
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>

This doesn't really explain how it helps (other than avoiding the 
message which sounds like just hiding the issue). That is, how this helps 
to resume Tx? Or does Tx resume? There's nothing to indicate either way.

-- 
 i.


> ---
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 67 ++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index 5c683b4eaf10..f39b7b9d2bfe 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -47,6 +47,9 @@
>  /* Message with data needs at least two words (for header & data). */
>  #define MLXBF_TMFIFO_DATA_MIN_WORDS		2
>  
> +/* Tx timeout in milliseconds. */
> +#define TMFIFO_TX_TIMEOUT			2000
> +
>  /* ACPI UID for BlueField-3. */
>  #define TMFIFO_BF3_UID				1
>  
> @@ -62,12 +65,14 @@ struct mlxbf_tmfifo;
>   * @drop_desc: dummy desc for packet dropping
>   * @cur_len: processed length of the current descriptor
>   * @rem_len: remaining length of the pending packet
> + * @rem_padding: remaining bytes to send as paddings
>   * @pkt_len: total length of the pending packet
>   * @next_avail: next avail descriptor id
>   * @num: vring size (number of descriptors)
>   * @align: vring alignment size
>   * @index: vring index
>   * @vdev_id: vring virtio id (VIRTIO_ID_xxx)
> + * @tx_timeout: expire time of last tx packet
>   * @fifo: pointer to the tmfifo structure
>   */
>  struct mlxbf_tmfifo_vring {
> @@ -79,12 +84,14 @@ struct mlxbf_tmfifo_vring {
>  	struct vring_desc drop_desc;
>  	int cur_len;
>  	int rem_len;
> +	int rem_padding;
>  	u32 pkt_len;
>  	u16 next_avail;
>  	int num;
>  	int align;
>  	int index;
>  	int vdev_id;
> +	unsigned long tx_timeout;
>  	struct mlxbf_tmfifo *fifo;
>  };
>  
> @@ -819,6 +826,50 @@ static bool mlxbf_tmfifo_rxtx_one_desc(struct mlxbf_tmfifo_vring *vring,
>  	return true;
>  }
>  
> +static void mlxbf_tmfifo_check_tx_timeout(struct mlxbf_tmfifo_vring *vring)
> +{
> +	unsigned long flags;
> +
> +	/* Only handle Tx timeout for network vdev. */
> +	if (vring->vdev_id != VIRTIO_ID_NET)
> +		return;
> +
> +	/* Initialize the timeout or return if not expired. */
> +	if (!vring->tx_timeout) {
> +		/* Initialize the timeout. */
> +		vring->tx_timeout = jiffies +
> +			msecs_to_jiffies(TMFIFO_TX_TIMEOUT);
> +		return;
> +	} else if (time_before(jiffies, vring->tx_timeout)) {
> +		/* Return if not timeout yet. */
> +		return;
> +	}
> +
> +	/*
> +	 * Drop the packet after timeout. The outstanding packet is
> +	 * released and the remaining bytes will be sent with padding byte 0x00
> +	 * as a recovery. On the peer(host) side, the padding bytes 0x00 will be
> +	 * either dropped directly, or appended into existing outstanding packet
> +	 * thus dropped as corrupted network packet.
> +	 */
> +	vring->rem_padding = round_up(vring->rem_len, sizeof(u64));
> +	mlxbf_tmfifo_release_pkt(vring);
> +	vring->cur_len = 0;
> +	vring->rem_len = 0;
> +	vring->fifo->vring[0] = NULL;
> +
> +	/*
> +	 * Make sure the load/store are in order before
> +	 * returning back to virtio.
> +	 */
> +	virtio_mb(false);
> +
> +	/* Notify upper layer. */
> +	spin_lock_irqsave(&vring->fifo->spin_lock[0], flags);
> +	vring_interrupt(0, vring->vq);
> +	spin_unlock_irqrestore(&vring->fifo->spin_lock[0], flags);
> +}
> +
>  /* Rx & Tx processing of a queue. */
>  static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
>  {
> @@ -841,6 +892,7 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
>  		return;
>  
>  	do {
> +retry:
>  		/* Get available FIFO space. */
>  		if (avail == 0) {
>  			if (is_rx)
> @@ -851,6 +903,17 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
>  				break;
>  		}
>  
> +		/* Insert paddings for discarded Tx packet. */
> +		if (!is_rx) {
> +			vring->tx_timeout = 0;
> +			while (vring->rem_padding >= sizeof(u64)) {
> +				writeq(0, vring->fifo->tx.data);
> +				vring->rem_padding -= sizeof(u64);
> +				if (--avail == 0)
> +					goto retry;
> +			}
> +		}
> +
>  		/* Console output always comes from the Tx buffer. */
>  		if (!is_rx && devid == VIRTIO_ID_CONSOLE) {
>  			mlxbf_tmfifo_console_tx(fifo, avail);
> @@ -860,6 +923,10 @@ static void mlxbf_tmfifo_rxtx(struct mlxbf_tmfifo_vring *vring, bool is_rx)
>  		/* Handle one descriptor. */
>  		more = mlxbf_tmfifo_rxtx_one_desc(vring, is_rx, &avail);
>  	} while (more);
> +
> +	/* Check Tx timeout. */
> +	if (avail <= 0 && !is_rx)
> +		mlxbf_tmfifo_check_tx_timeout(vring);
>  }
>  
>  /* Handle Rx or Tx queues. */
> 
--8323329-677012229-1704389919=:10531--

