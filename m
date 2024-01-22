Return-Path: <linux-kernel+bounces-32915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A78361DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95D81F24BA7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3403D571;
	Mon, 22 Jan 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OJGaeuHt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F5E3DB95
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922684; cv=none; b=R9By+Rl9HQb0xqjM1AJA2d2L2ozadLk4Z0uRuipdQPmZor27yBzoVtlwLicSFf8hjGTFMJi6328Uf0jHOS6We6FyDg62ALvW4yiTBoaSKg5+bz0TEgCYdK+36/Y5stgafnS0GdvgHUa5nOMbzmkQR09WGf7xrIhLBws04uKvbEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922684; c=relaxed/simple;
	bh=yHR2yz+3CdE61E4n0W3BNb+3FTIUhRAD2+FYuwrHJ84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k31nlW0TewTDUj71gM/Go4g7Z2HtnjkUlxTjQdznZb6AOh7+p0XmH1u3RnXXeAJbh2bUQzTsVfACpyr+IDLq6krs1MwvatdKf/+SG+WkOehXzZWwKUV7amTG4HlDI7a8OWnZHr6ZrZ/Q5oGJyYcknbY0bV28aIQSZT1wj1n9eHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OJGaeuHt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705922680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xszYClSK+CsCGTSpIxFxpuSnSH1wZstVsErrb4ghUjg=;
	b=OJGaeuHtetWactDIJ3+UdAltHN+AaA5Pm9UU7bx0KbQBOpCt95IFWuV+7ZQAHrHC7pRE+Y
	2zP0NjCx93aX5OEDpMkbvXJXwXXXQn68xlOyhYDXDnzo4SCODqSuMe+dz+k/JtD/F0jMAz
	HvpNnHhHXcyVKzoV0ejh1RFbBb6Ow1s=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-rNIKWsBSP7SYeHtNX2y6dg-1; Mon, 22 Jan 2024 06:24:38 -0500
X-MC-Unique: rNIKWsBSP7SYeHtNX2y6dg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-50e7ddf4dacso2185480e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:24:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922676; x=1706527476;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xszYClSK+CsCGTSpIxFxpuSnSH1wZstVsErrb4ghUjg=;
        b=Qh6ax40Z9IJ05BFuFSK0vF8rl15HTsv3M/m7L2cyMpNhJl/ADBp7ErHRoiJxyKhTQH
         ShrXv+3N7uBrCE1D7zGBaAyMdYx21X5nrL4yDV7vCtrKRzuuSuTPxZEtSNo0GF1q0Iam
         aHXoP/33WNjRDT/KJIsdNLijp4ja8bSOcOoUbeT6wZAGXPqa7s39+22DGhWxKqgELfL7
         tw6vZkz6bOcYnybdYIN8CnOg3h0T6M8sQvcyvRj/aM20VKLuNJv6/S3WhhRaWXWH4KfY
         XUuzmlOGUsQgzka3CQ9fz+/s4d5XBwDsnCsLCYkq9IKn+HgYzkYWjDK8GsJY8JzzfTi1
         3zVA==
X-Gm-Message-State: AOJu0Ywp6msw1pJjN3R0L0DspIrA/fqsA0LZoSjZ+87Vt++IIdn/v4Yf
	P/QSa44rJzFQsn799TZQPVWsVdlPcpW9Uw1VrfMWZJOBYjgntS1HDf4dvZnujLRcyHW7q74a5L6
	4UUdQdHbHZsSFL5GhJCzFFy8tnGzz2H09rsRR/WA51gNowOJV0eQPybNvwArObrmbaMigHw==
X-Received: by 2002:a05:6512:110d:b0:50e:7cbf:7777 with SMTP id l13-20020a056512110d00b0050e7cbf7777mr1973085lfg.79.1705922676236;
        Mon, 22 Jan 2024 03:24:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8cG0yZMZcmZP4p5gg7vg30UY1Rf2Ry1OA7MlEPVeLzoSmtPn/3beE148OKPwedEvZ5qBcGg==
X-Received: by 2002:a05:6512:110d:b0:50e:7cbf:7777 with SMTP id l13-20020a056512110d00b0050e7cbf7777mr1973078lfg.79.1705922675868;
        Mon, 22 Jan 2024 03:24:35 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id fi6-20020a056402550600b0055c38f3ca66sm1057376edb.29.2024.01.22.03.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 03:24:35 -0800 (PST)
Message-ID: <7121300c-1fa3-461f-a531-d148b16d5079@redhat.com>
Date: Mon, 22 Jan 2024 12:24:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Drop Tx network packet when Tx TmFIFO is full
Content-Language: en-US, nl
To: Liming Sun <limings@nvidia.com>, Vadim Pasternak <vadimp@nvidia.com>,
 David Thompson <davthompson@nvidia.com>, Mark Gross <markgross@kernel.org>,
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f250079635da4ba75c3a3a1d7c3820f48cfc3f06.1704380474.git.limings@nvidia.com>
 <20240111173106.96958-1-limings@nvidia.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240111173106.96958-1-limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 1/11/24 18:31, Liming Sun wrote:
> Starting from Linux 5.16 kernel, Tx timeout mechanism was added
> in the virtio_net driver which prints the "Tx timeout" warning
> message when a packet stays in Tx queue for too long. Below is an
> example of the reported message:
> 
> "[494105.316739] virtio_net virtio1 tmfifo_net0: TX timeout on
> queue: 0, sq: output.0, vq: 0×1, name: output.0, usecs since
> last trans: 3079892256".
> 
> This issue could happen when external host driver which drains the
> FIFO is restared, stopped or upgraded. To avoid such confusing
> "Tx timeout" messages, this commit adds logic to drop the outstanding
> Tx packet if it's not able to transmit in two seconds due to Tx FIFO
> full, which can be considered as congestion or out-of-resource drop.
> 
> This commit also handles the special case that the packet is half-
> transmitted into the Tx FIFO. In such case, the packet is discarded
> with remaining length stored in vring->rem_padding. So paddings with
> zeros can be sent out when Tx space is available to maintain the
> integrity of the packet format. The padded packet will be dropped on
> the receiving side.
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>

Thank you for your patch/series, I've applied this patch
(series) to my review-hans branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in the pdx86 review-hans branch once I've
pushed my local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans




> ---
> v2->v3:
>   Updates for Ilpo's comments:
>   - Revises commit message to avoid confusion.
> v2: Fixed formatting warning
> v1: Initial version
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


