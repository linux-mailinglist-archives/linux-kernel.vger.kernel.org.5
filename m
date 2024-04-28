Return-Path: <linux-kernel+bounces-161443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7798B4C07
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFADE1C20DB7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 13:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90D26E5EC;
	Sun, 28 Apr 2024 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OuUC0+eZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D5958129;
	Sun, 28 Apr 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714312020; cv=none; b=t8bnsfohNUyqpkNO33mJjjFNmhcl3il4eDZP6yNO7pvD0uLE4Ko8bIgOIGp6+ia4/usJ3g0onHLPqxhszZ5d4aosEIyerC7y8DvtQlgb9Ow7HsYwDN5qoPoamqxyH35/G7G2Et/Rj917rOv153jEEiUswaPQdQTDwz5eG5RpESA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714312020; c=relaxed/simple;
	bh=YDduc+eKhwGtciAitQ824o01nS0wAlvW8mM2dYp14hc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFKjKnVAFVAVt6G3isknNCmYZvlB4Q28Pwv4M8UGm1SGujO8eKj0uSXnCKCHC6yp4RHl8MYfB/A894HG8fNmbJhL3mVo7nGWKEiSN7FgqePMSL62sUbZLmLjZFW/g2cDO2mNE0Kw1FO3iEBM7ddQ/2k0vCb92Hu3C8TzKAjkY90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OuUC0+eZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3534C113CC;
	Sun, 28 Apr 2024 13:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714312019;
	bh=YDduc+eKhwGtciAitQ824o01nS0wAlvW8mM2dYp14hc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OuUC0+eZZCcbMxaf2eSnsmMUSNGJBG2qeXj7T3a/KsR2b0QBMRO/30GTJafb3LJaF
	 qPqmpX/42N2DRzOin+nvcihd3rbYZ9ql+j58DlMTqRVIsYkqBm+ZhjXm+3qSLL6P3A
	 aXdF3DIjKVBsYi/t+pERXdnXqrpGSdzB1RCTO8K1T90dwREWC2oDBk4HLFZ60b2Tnp
	 3TyMBOFjIzFsGsDayl5oEdN4Jr98L6VenkPbDbCKtPrafrW+0rjxBvXnrVvHYzBuFH
	 msWi/hbgUeZhTVXOzgBCmzZmwZU/mzBu8BhmPJ6a5EI0IiiFGlg2lztNr/XbnJE9Ho
	 Pdk/A4TP7AOow==
Date: Sun, 28 Apr 2024 14:45:25 +0100
From: Simon Horman <horms@kernel.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <20240428134525.GW516117@kernel.org>
References: <20240427103558.161706-1-ryasuoka@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427103558.161706-1-ryasuoka@redhat.com>

On Sat, Apr 27, 2024 at 07:35:54PM +0900, Ryosuke Yasuoka wrote:
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

..

> @@ -1516,30 +1526,36 @@ static void nci_rx_work(struct work_struct *work)
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

Hi Yasuoka-san,

My reading is that this will jump to the label invalid_pkt_free,
which is intended.

>  			nci_rsp_packet(ndev, skb);
>  			break;

But this will exit the switch statement, which lands
at the label invalid_pkt_free, where skb is kfreed.
This doesn't seem to be intended.

>  
>  		case NCI_MT_NTF_PKT:
> +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> +				goto invalid_pkt_free;
>  			nci_ntf_packet(ndev, skb);
>  			break;
>  
>  		case NCI_MT_DATA_PKT:
> +			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
> +				goto invalid_pkt_free;
>  			nci_rx_data_packet(ndev, skb);
>  			break;
>  
>  		default:
>  			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
> -			kfree_skb(skb);
> -			break;
> +			goto invalid_pkt_free;
>  		}

If so, then one solution may be to add the following here:

		continue;

> +invalid_pkt_free:
> +		kfree_skb(skb);
> +		break;
>  	}
>  
>  	/* check if a data exchange timeout has occurred */
> -- 
> 2.44.0
> 
> 

