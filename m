Return-Path: <linux-kernel+bounces-167426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679FD8BA973
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A91E1C225F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D55514F110;
	Fri,  3 May 2024 09:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myHxHAay"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F514E2F2;
	Fri,  3 May 2024 09:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727275; cv=none; b=An3AeIq0IFabkzwQVsO+vZsLkp92jA6arSSCgABMwx1p5OokDiPghHxwkB9MmFyNPid4C1eyo3kmKiKq8OUyox9FU+qUieS1zDqltyO9KtWxs0whuCmlOrXeloWfxAWPiMfz0KqqysMqLKWlfLs40pZ2sb3PDFlcSPpQcKotv3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727275; c=relaxed/simple;
	bh=crGkBfU45fE9CNuOJ1cV0bXC5GMmaM5BnQQH6lqN5yU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rc07yA1f55otCABSDONIqqIMiuk8o9clHsHkCcVxNByuOV938r4nivbwcNqXJvfglDwfy42aRDyQIsE411KChMdk2MfjwvSCPrAw0lIrDUsguxWUERCEqx/Yc3O15Lzic4kWZSvoC1QN5XKPj7eRaIgbJ/7dKE3RBl6GwMPIuCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myHxHAay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B85C116B1;
	Fri,  3 May 2024 09:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714727275;
	bh=crGkBfU45fE9CNuOJ1cV0bXC5GMmaM5BnQQH6lqN5yU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=myHxHAay2QAP+hSP6jsNWc8KzeMU7YsVpYTaLCm2BOlH7pMfgJ+OlP00pKGPyRVv0
	 rm9mqi4ASJNMU1fWIGoZYBAXg/4QUnbLgwwfXmfvlnD0Aps214BYT9f6AQxD/rzMG5
	 rjkixU0dwAPvoAamyCCq1xfAOlwzacKsEiU9nnc/epoOrtLVWwhlgFReVq+YoQS4sI
	 189riYk522+mqpMpLPaiVGOgUh626tx1M/ieSUc9zqB9jiJHJ87YHpqNh/XeoRsU94
	 FqQV1nOiOJnfDEO5ycpfATWmxd9sEXooOa80qGJU0iFpbQWRFWaPZC495H3iNUI24R
	 jz9I2SK3/47uw==
Message-ID: <b7c7fab7-07d5-4654-a903-473f0c6dd4aa@kernel.org>
Date: Fri, 3 May 2024 11:07:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] nfc: nci: Fix uninit-value in nci_rx_work
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syoshida@redhat.com, syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
References: <20240502082323.250739-1-ryasuoka@redhat.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <20240502082323.250739-1-ryasuoka@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2024 10:22, Ryosuke Yasuoka wrote:
> syzbot reported the following uninit-value access issue [1]
> 
> nci_rx_work() parses received packet from ndev->rx_q. It should be
> validated header size, payload size and total packet size before
> processing the packet. If an invalid packet is detected, it should be
> silently discarded.
> 
> Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
> Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> ---
> 
> v3
> - As Simon pointed out, the valid packets will reach invalid_pkt_free
> and kfree_skb(skb) after being handled correctly in switch statement.
> It can lead to double free issues, which is not intended. So this patch
> uses "continue" instead of "break" in switch statement.
> 
> - In the current implementation, once zero payload size is detected, the
> for statement exits. It should continue processing subsequent packets. 
> So this patch just frees skb in invalid_pkt_free when the invalid 
> packets are detected.
> 
> v2
> https://lore.kernel.org/lkml/20240428134525.GW516117@kernel.org/T/
> 
> - The v1 patch only checked whether skb->len is zero. This patch also
>   checks header size, payload size and total packet size.
> 
> 
> v1
> https://lore.kernel.org/linux-kernel/CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com/T/
> 
> 
>  net/nfc/nci/core.c | 33 ++++++++++++++++++++++++---------
>  1 file changed, 24 insertions(+), 9 deletions(-)
> 
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 0d26c8ec9993..e4f92a090022 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1463,6 +1463,16 @@ int nci_core_ntf_packet(struct nci_dev *ndev, __u16 opcode,
>  				 ndev->ops->n_core_ops);
>  }
>  
> +static bool nci_valid_size(struct sk_buff *skb, unsigned int header_size)
> +{
> +	if (skb->len < header_size ||
> +	    !nci_plen(skb->data) ||
> +	    skb->len < header_size + nci_plen(skb->data)) {
> +		return false;
> +	}
> +	return true;
> +}
> +
>  /* ---- NCI TX Data worker thread ---- */
>  
>  static void nci_tx_work(struct work_struct *work)
> @@ -1516,30 +1526,35 @@ static void nci_rx_work(struct work_struct *work)
>  		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
>  				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
>  
> -		if (!nci_plen(skb->data)) {
> -			kfree_skb(skb);
> -			break;
> -		}
> +		if (!skb->len)
> +			goto invalid_pkt_free;
>  
>  		/* Process frame */
>  		switch (nci_mt(skb->data)) {
>  		case NCI_MT_RSP_PKT:
> +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> +				goto invalid_pkt_free;
>  			nci_rsp_packet(ndev, skb);
> -			break;
> +			continue;

I don't find this code readable.

>  
>  		case NCI_MT_NTF_PKT:
> +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> +				goto invalid_pkt_free;
>  			nci_ntf_packet(ndev, skb);
> -			break;
> +			continue;
>  
>  		case NCI_MT_DATA_PKT:
> +			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
> +				goto invalid_pkt_free;
>  			nci_rx_data_packet(ndev, skb);
> -			break;
> +			continue;
>  
>  		default:
>  			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
> -			kfree_skb(skb);
> -			break;
> +			goto invalid_pkt_free;
>  		}
> +invalid_pkt_free:
> +		kfree_skb(skb);

Why you cannot kfree in "default" and error cases? I don't think that
goto inside loop makes this code easier to follow.

>  	}
>  
>  	/* check if a data exchange timeout has occurred */

Best regards,
Krzysztof


