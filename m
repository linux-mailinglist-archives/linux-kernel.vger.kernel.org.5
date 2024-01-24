Return-Path: <linux-kernel+bounces-36778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A278783A66C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7F2FB23C9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8FF18659;
	Wed, 24 Jan 2024 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kj5GJSSt"
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D270B18645
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091055; cv=none; b=jU4uyLCBwIykdH4DW4TlBI/s1RP+wGyDCofVJSulqkEKKuW0jPpCftMVYfKmr2pzCK68qrQt2+VIIHIEz5FH4JE/zo2KgHRTfa5XuhZHK7Ts7Le/K3xrAs5CYrZWEMaCJ6vdQklWOk0TS+EjEp8pRn0ie9lp/H24yv6M9kWATYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091055; c=relaxed/simple;
	bh=SSWNhg1BeWMjlsW8eOblnkY8M41Gr7UmMlQfPptWizU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xgb5gex5aCRcNeR1FT5O3w6c7kZzoWpZRATUgTY2OoROdM2+LhnH/PEF1bxtQ0kRF/aBN7PzsSsxbjYoiHo9fYSj//jEM/sBR8f1feLP0mUz6TrIlukhehuzwdn5VoIZpdFzsqI32hPnM0SXurXqMhMEguUt2PnqFe4bvYwvLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kj5GJSSt; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <fc421c38-66b7-4d4e-abfa-051eccbf793c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706091051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kazOr6AAUqaXXxOqjGWomQo5TpJnFcKaIZXSMkHqQh4=;
	b=Kj5GJSStFxxpSQW/5cQIZZSMUR8GOXhqanSovUXTJMwsCAN9lITPvR1nvMwgCOn7dVvIAO
	Z31fJeY4dcB0XYncgCP+XSqc4LCNRDUAFOMO6R8Lzybp0I5JAf+/IKdnzGSNAuQreabNc9
	jztywpVNReG6Q3OnAo7Tjxhm34KjWsU=
Date: Wed, 24 Jan 2024 10:10:46 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] net: wan: fsl_qmc_hdlc: Add runtime timeslots changes
 support
Content-Language: en-US
To: Herve Codina <herve.codina@bootlin.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Andrew Lunn <andrew@lunn.ch>,
 Mark Brown <broonie@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240123164912.249540-1-herve.codina@bootlin.com>
 <20240123164912.249540-4-herve.codina@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240123164912.249540-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/01/2024 16:49, Herve Codina wrote:
> QMC channels support runtime timeslots changes but nothing is done at
> the QMC HDLC driver to handle these changes.
> 
> Use existing IFACE ioctl in order to configure the timeslots to use.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   drivers/net/wan/fsl_qmc_hdlc.c | 169 ++++++++++++++++++++++++++++++++-
>   1 file changed, 168 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wan/fsl_qmc_hdlc.c b/drivers/net/wan/fsl_qmc_hdlc.c
> index 31b637ec8390..82019cd96365 100644
> --- a/drivers/net/wan/fsl_qmc_hdlc.c
> +++ b/drivers/net/wan/fsl_qmc_hdlc.c
> @@ -32,6 +32,7 @@ struct qmc_hdlc {
>   	struct qmc_hdlc_desc tx_descs[8];
>   	unsigned int tx_out;
>   	struct qmc_hdlc_desc rx_descs[4];
> +	u32 slot_map;
>   };
>   
>   static inline struct qmc_hdlc *netdev_to_qmc_hdlc(struct net_device *netdev)
> @@ -202,6 +203,162 @@ static netdev_tx_t qmc_hdlc_xmit(struct sk_buff *skb, struct net_device *netdev)
>   	return NETDEV_TX_OK;
>   }
>   
> +static int qmc_hdlc_xlate_slot_map(struct qmc_hdlc *qmc_hdlc,
> +				   u32 slot_map, struct qmc_chan_ts_info *ts_info)
> +{
> +	u64 ts_mask_avail;
> +	unsigned int bit;
> +	unsigned int i;
> +	u64 ts_mask;
> +	u64 map;
> +
> +	/* Tx and Rx masks must be identical */
> +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> +		return -EINVAL;
> +	}
> +
> +	ts_mask_avail = ts_info->rx_ts_mask_avail;
> +	ts_mask = 0;
> +	map = slot_map;
> +	bit = 0;
> +	for (i = 0; i < 64; i++) {
> +		if (ts_mask_avail & BIT_ULL(i)) {
> +			if (map & BIT_ULL(bit))
> +				ts_mask |= BIT_ULL(i);
> +			bit++;
> +		}
> +	}
> +
> +	if (hweight64(ts_mask) != hweight64(map)) {
> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots 0x%llx -> (0x%llx,0x%llx)\n",
> +			map, ts_mask_avail, ts_mask);
> +		return -EINVAL;
> +	}
> +
> +	ts_info->tx_ts_mask = ts_mask;
> +	ts_info->rx_ts_mask = ts_mask;
> +	return 0;
> +}
> +
> +static int qmc_hdlc_xlate_ts_info(struct qmc_hdlc *qmc_hdlc,
> +				  const struct qmc_chan_ts_info *ts_info, u32 *slot_map)
> +{
> +	u64 ts_mask_avail;
> +	unsigned int bit;
> +	unsigned int i;
> +	u64 ts_mask;
> +	u64 map;
> +

Starting from here ...

> +	/* Tx and Rx masks must be identical */
> +	if (ts_info->rx_ts_mask_avail != ts_info->tx_ts_mask_avail) {
> +		dev_err(qmc_hdlc->dev, "tx and rx available timeslots mismatch (0x%llx, 0x%llx)\n",
> +			ts_info->rx_ts_mask_avail, ts_info->tx_ts_mask_avail);
> +		return -EINVAL;
> +	}
> +	if (ts_info->rx_ts_mask != ts_info->tx_ts_mask) {
> +		dev_err(qmc_hdlc->dev, "tx and rx timeslots mismatch (0x%llx, 0x%llx)\n",
> +			ts_info->rx_ts_mask, ts_info->tx_ts_mask);
> +		return -EINVAL;
> +	}
> +
> +	ts_mask_avail = ts_info->rx_ts_mask_avail;
> +	ts_mask = ts_info->rx_ts_mask;
> +	map = 0;
> +	bit = 0;
> +	for (i = 0; i < 64; i++) {
> +		if (ts_mask_avail & BIT_ULL(i)) {
> +			if (ts_mask & BIT_ULL(i))
> +				map |= BIT_ULL(bit);
> +			bit++;
> +		}
> +	}
> +
> +	if (hweight64(ts_mask) != hweight64(map)) {
> +		dev_err(qmc_hdlc->dev, "Cannot translate timeslots (0x%llx,0x%llx) -> 0x%llx\n",
> +			ts_mask_avail, ts_mask, map);
> +		return -EINVAL;
> +	}
> +

till here the block looks like copy of the block from previous function.
It worth to make a separate function for it, I think.

> +	if (map >= BIT_ULL(32)) {
> +		dev_err(qmc_hdlc->dev, "Slot map out of 32bit (0x%llx,0x%llx) -> 0x%llx\n",
> +			ts_mask_avail, ts_mask, map);
> +		return -EINVAL;
> +	}
> +
> +	*slot_map = map;
> +	return 0;
> +}
> +
> +static int qmc_hdlc_set_iface(struct qmc_hdlc *qmc_hdlc, int if_iface, const te1_settings *te1)
> +{
> +	struct qmc_chan_ts_info ts_info;
> +	int ret;
> +
> +	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "get QMC channel ts info failed %d\n", ret);
> +		return ret;
> +	}
> +	ret = qmc_hdlc_xlate_slot_map(qmc_hdlc, te1->slot_map, &ts_info);
> +	if (ret)
> +		return ret;
> +
> +	ret = qmc_chan_set_ts_info(qmc_hdlc->qmc_chan, &ts_info);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "set QMC channel ts info failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	qmc_hdlc->slot_map = te1->slot_map;
> +
> +	return 0;
> +}
> +
> +static int qmc_hdlc_ioctl(struct net_device *netdev, struct if_settings *ifs)
> +{
> +	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> +	te1_settings te1;
> +
> +	switch (ifs->type) {
> +	case IF_GET_IFACE:
> +		ifs->type = IF_IFACE_E1;
> +		if (ifs->size < sizeof(te1)) {
> +			if (!ifs->size)
> +				return 0; /* only type requested */
> +
> +			ifs->size = sizeof(te1); /* data size wanted */
> +			return -ENOBUFS;
> +		}
> +
> +		memset(&te1, 0, sizeof(te1));
> +
> +		/* Update slot_map */
> +		te1.slot_map = qmc_hdlc->slot_map;
> +
> +		if (copy_to_user(ifs->ifs_ifsu.te1, &te1, sizeof(te1)))
> +			return -EFAULT;
> +		return 0;
> +
> +	case IF_IFACE_E1:
> +	case IF_IFACE_T1:
> +		if (!capable(CAP_NET_ADMIN))
> +			return -EPERM;
> +
> +		if (netdev->flags & IFF_UP)
> +			return -EBUSY;
> +
> +		if (copy_from_user(&te1, ifs->ifs_ifsu.te1, sizeof(te1)))
> +			return -EFAULT;
> +
> +		return qmc_hdlc_set_iface(qmc_hdlc, ifs->type, &te1);
> +
> +	default:
> +		return hdlc_ioctl(netdev, ifs);
> +	}
> +}
> +
>   static int qmc_hdlc_open(struct net_device *netdev)
>   {
>   	struct qmc_hdlc *qmc_hdlc = netdev_to_qmc_hdlc(netdev);
> @@ -328,13 +485,14 @@ static const struct net_device_ops qmc_hdlc_netdev_ops = {
>   	.ndo_open       = qmc_hdlc_open,
>   	.ndo_stop       = qmc_hdlc_close,
>   	.ndo_start_xmit = hdlc_start_xmit,
> -	.ndo_siocwandev	= hdlc_ioctl,
> +	.ndo_siocwandev = qmc_hdlc_ioctl,
>   };
>   
>   static int qmc_hdlc_probe(struct platform_device *pdev)
>   {
>   	struct device_node *np = pdev->dev.of_node;
>   	struct qmc_hdlc *qmc_hdlc;
> +	struct qmc_chan_ts_info ts_info;
>   	struct qmc_chan_info info;
>   	hdlc_device *hdlc;
>   	int ret;
> @@ -364,6 +522,15 @@ static int qmc_hdlc_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   	}
>   
> +	ret = qmc_chan_get_ts_info(qmc_hdlc->qmc_chan, &ts_info);
> +	if (ret) {
> +		dev_err(qmc_hdlc->dev, "get QMC channel ts info failed %d\n", ret);
> +		return ret;
> +	}
> +	ret = qmc_hdlc_xlate_ts_info(qmc_hdlc, &ts_info, &qmc_hdlc->slot_map);
> +	if (ret)
> +		return ret;
> +
>   	qmc_hdlc->netdev = alloc_hdlcdev(qmc_hdlc);
>   	if (!qmc_hdlc->netdev) {
>   		dev_err(qmc_hdlc->dev, "failed to alloc hdlc dev\n");


