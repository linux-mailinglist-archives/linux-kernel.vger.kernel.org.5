Return-Path: <linux-kernel+bounces-162702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6E78B5F45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56FE328113C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC5386158;
	Mon, 29 Apr 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc+/Xx8I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE56385C6C;
	Mon, 29 Apr 2024 16:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408884; cv=none; b=QAw5IUNHCkxfP3uJwm60YdDTAjoCECgBr16AE3dmkHlRnHyt5uRuyFPUjdai5u5gd08E5QTxCmHThUZUfsDpN+LJIl53vLeJUVpc6sjMmbrZywJyk9B0XfwuWf4WiW0ziuO1s1XRWMJlM0fZ921Gqep7jVVdMsApmwDSUo4vMDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408884; c=relaxed/simple;
	bh=RspDC4859kGMgSkyYFyIkNCEccqvD+abVhafD7M8wy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dpGEt2mfU0kJYe8ttTlV+bWGKuzWJcfXW86+d3FCWX4ZanUyQgSm8YTX/2MW59ofROQYs37N8YspsxkK5uxUsCMu2ScYvPZgS99OvkYkPBfSloKcbw2lpp8HJk9OoXBCwmKwr0jUYhmG4PuT65e6DbQbECZLxLna/Fuob82hRxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc+/Xx8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C58C113CD;
	Mon, 29 Apr 2024 16:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714408883;
	bh=RspDC4859kGMgSkyYFyIkNCEccqvD+abVhafD7M8wy0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cc+/Xx8IIGyKgtBMl4bG4Ih1tCcNRVJTTPfaKFVN51WfCPGtwvpMU1UO6qmcBy3jS
	 VT+hvaMR03E+9tFtgilqBDfx+zLSZ9poMbUu4kfFiYa9WWX84PTbTOYmcqLLgPnh1D
	 uQd7SHLnbQMXz/GdLFE1WVJmG2fE6ZpBJgC+gfXbV2uwR4qQ+bxUzz9GrzhbPBJde/
	 Mc3Kc1JhdAN64mOj8KVYOCrHwRe7ZmihmlngOX+zrTvjYalZS8Y4UY7dO2zpv/m6Ze
	 o08PwTne6oTnmo4C2Xq5exlSR7uLLyWEXz5Jj2r5ocEmADF8LohY6N0GOhqquRT4dp
	 i2eI04VoSUvTw==
Date: Mon, 29 Apr 2024 17:41:18 +0100
From: Simon Horman <horms@kernel.org>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <20240429164118.GB516117@kernel.org>
References: <20240427103558.161706-1-ryasuoka@redhat.com>
 <20240428134525.GW516117@kernel.org>
 <Zi-vGH1ROjiv1yJ2@zeus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi-vGH1ROjiv1yJ2@zeus>

On Mon, Apr 29, 2024 at 11:30:48PM +0900, Ryosuke Yasuoka wrote:
> On Sun, Apr 28, 2024 at 02:45:25PM +0100, Simon Horman wrote:
> > On Sat, Apr 27, 2024 at 07:35:54PM +0900, Ryosuke Yasuoka wrote:

..

> Thank you for your comment, Simon.
> 
> Yes, if it handles packets correctly in nci_{rsp,ntf,rx_data}_packet(),
> it should not reach invalid_pkt_free and it should continue to work in
> the for statement. Sorry, it is my mistake and need to fix it.
> 
> BTW, in the current implementation, if the payload is zero, it will free
> the skb and exit the for statement. I wonder it is intended. 
> 
> > > -		if (!nci_plen(skb->data)) {
> > > -			kfree_skb(skb);
> > > -			break;
> > > -		}
> 
> When the packet is invalid, it should be discarded but it should not
> exit the for statement by break. Instead, the skb should just free and
> it should handle the subsequent packet by continue. If yes, then it 
> may be like below,
> 
> 	for (; (skb = skb_dequeue(&ndev->rx_q)); kcov_remote_stop()) {
> 		kcov_remote_start_common(skb_get_kcov_handle(skb));
> 
> 		/* Send copy to sniffer */
> 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
> 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
> 
> 		if (!skb->len)
> 			goto invalid_pkt_free;
> 
> 		/* Process frame */
> 		switch (nci_mt(skb->data)) {
> 		case NCI_MT_RSP_PKT:
> 			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> 				goto invalid_pkt_free;
> 			nci_rsp_packet(ndev, skb);
> 			continue;   <<<---
> 
> 		case NCI_MT_NTF_PKT:
> 			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> 				goto invalid_pkt_free;
> 			nci_ntf_packet(ndev, skb);
> 			continue;   <<<---
> 
> 		case NCI_MT_DATA_PKT:
> 			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
> 				goto invalid_pkt_free;
> 			nci_rx_data_packet(ndev, skb);
> 			continue;   <<<---
> 
> 		default:
> 			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
> 			goto invalid_pkt_free;
> 		}
> invalid_pkt_free:
> 		kfree_skb(skb);
> 	}
> 
> Could I hear your opinion?

Hi Yasuoka-san,

Thanks for pointing this out.

I agree that it is not good to 'break' after kfree_skb() for two reasons:

1. As you mention, the loop should keep going and process other skbs
2. kcov_remote_stop() needs to be called for each skb

I might have used a 'continue' above the invalid_pkt_free label.
But I think your suggestion - using 'continue' inside the switch statement
- is also correct, and seems fine to me.

Please post a v3 when you are ready.

-- 
pw-bot: changes-requested

