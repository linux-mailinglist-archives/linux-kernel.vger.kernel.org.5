Return-Path: <linux-kernel+bounces-162444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691938B5B45
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71F371C21629
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F9535A2;
	Mon, 29 Apr 2024 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAwXhnNw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F85A205E1D
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401060; cv=none; b=YQ5O62nX0JCcnqPmN59EzYt2D5H69XwO2Ns3yPiBsDf/HumjsoRZIRf70PViUPBksByYOTaPkzFYP3RRxKnXsWZ18hrsHANwxKAG2S3Q85RyKmfOLBH9FrzCC74/2ntWqYY6GkGsVlfnKae7y1TJPMguRCwSAq/VPeH+5m8G/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401060; c=relaxed/simple;
	bh=oYIzb5bXiT0btuHE7Rvi0W6A36FwygO503CUerNZiz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUbHoYhjrLGQMaxsQKSn0BzJvPAdFwG9QHxaegS2LSf5SyYSt7po+mWa2Mh+g04bJTZpHSJU6r4nvfUalhPZajvyWWM1WTUvr756qnHGqkxsenb2pGBJe8S+aN3npc/soD5EHLa00pRmQXZKdGlIxCKX0SpWkP44eCBAwNnzmuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CAwXhnNw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714401057;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f9bY8Ll9oQ6IR9DHuROsI2DP39lzpeUexS6Phh7yYVE=;
	b=CAwXhnNwHUa3O0CzXIhHVuLNhFt2V9fSk034f2+hT4aXz+kYnfNcX3CYgH2oZSLnX0fzZs
	tHXF73aJdaBg8fS+D34QBtJdJ6H8S4jfFAJGhPCKAHkepTeo4xtORwC5YOyx25GBpiNZHA
	pIgjf30nH8Y54iGtOLQZUglfKq0tRLI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-DdtI6FqzOkm1OZXmXDpt2g-1; Mon, 29 Apr 2024 10:30:54 -0400
X-MC-Unique: DdtI6FqzOkm1OZXmXDpt2g-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2a4fc4cf54dso5448646a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714401053; x=1715005853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9bY8Ll9oQ6IR9DHuROsI2DP39lzpeUexS6Phh7yYVE=;
        b=POp5du83FSf3C/TkoXWVW8MN3sdEW4VLLo8KfRQKgUfaZEIwaXEB227zSBoTOkdNXv
         K76vfM+yLHD6IKSHc28++LWmj0Dy6wGpUf7gJejEmimhsWTyewwIjX6APkNLx5EoiRwL
         9lZBPnZnzP96qiU8kihGqfZzo3Qwzxx3l0b9MOsld+ekPhGRKf0uj+QyW0GnrVQT6p6z
         IuNtLWEbhn9M8Kxk0gx75FER1wTnAkhcvukTuEQCM/mhWKmWXLPexQbEaCweHKbH2dyT
         QdlKvoMr//T4UeLqK5FjxfaAJixGOS2tdRbwhRc7vOfW7FyDACmQwV2nX5w1s5WGu0K9
         YDQA==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3ZM57WcBZH16dm/7yAqdRhEtRVjcI0ncnFvSBKztlSpSk3NsshCg1o5aPYrRL132UBQ+bxom89BEAh2iSCaY+8BMY8tV2rv2YEYy
X-Gm-Message-State: AOJu0YyhWp6EWMKxbB+KQG09IH2gIMxKLS7U3omFO9ggY74biAotfCe0
	bsvLtGlktAeKR7BWmhRwAWI84ahotW1B5NWywEowklw7uwnUHmLw14XV/UuiKte2l1agxGIP/uK
	ylFvTsZ9XDODtMdaPgPXz6k3Vv3U54q5FD2ZeS6glaTBCtXQKCvwHw7/U/rk5yw==
X-Received: by 2002:a17:90a:c302:b0:2ae:72a3:2ed4 with SMTP id g2-20020a17090ac30200b002ae72a32ed4mr10361919pjt.15.1714401053525;
        Mon, 29 Apr 2024 07:30:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFa1iFwK9a8Zfq3hxj2/6l/xfm7hk0Jp3nCMo7lzvLfSTOnADr0QRRxDygYcLTwMtVltRkcOA==
X-Received: by 2002:a17:90a:c302:b0:2ae:72a3:2ed4 with SMTP id g2-20020a17090ac30200b002ae72a32ed4mr10361889pjt.15.1714401053101;
        Mon, 29 Apr 2024 07:30:53 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090ace1600b002a47e86fd5esm19351297pju.4.2024.04.29.07.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 07:30:52 -0700 (PDT)
Date: Mon, 29 Apr 2024 23:30:48 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com,
	syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <Zi-vGH1ROjiv1yJ2@zeus>
References: <20240427103558.161706-1-ryasuoka@redhat.com>
 <20240428134525.GW516117@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240428134525.GW516117@kernel.org>

On Sun, Apr 28, 2024 at 02:45:25PM +0100, Simon Horman wrote:
> On Sat, Apr 27, 2024 at 07:35:54PM +0900, Ryosuke Yasuoka wrote:
> > syzbot reported the following uninit-value access issue [1]
> > 
> > nci_rx_work() parses received packet from ndev->rx_q. It should be
> > validated header size, payload size and total packet size before
> > processing the packet. If an invalid packet is detected, it should be
> > silently discarded.
> > 
> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> 
> ...
> 
> > @@ -1516,30 +1526,36 @@ static void nci_rx_work(struct work_struct *work)
> >  		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
> >  				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
> >  
> > -		if (!nci_plen(skb->data)) {
> > -			kfree_skb(skb);
> > -			break;
> > -		}
> > +		if (!skb->len)
> > +			goto invalid_pkt_free;
> >  
> >  		/* Process frame */
> >  		switch (nci_mt(skb->data)) {
> >  		case NCI_MT_RSP_PKT:
> > +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> > +				goto invalid_pkt_free;
> 
> Hi Yasuoka-san,
> 
> My reading is that this will jump to the label invalid_pkt_free,
> which is intended.
> 
> >  			nci_rsp_packet(ndev, skb);
> >  			break;
> 
> But this will exit the switch statement, which lands
> at the label invalid_pkt_free, where skb is kfreed.
> This doesn't seem to be intended.
> 
> >  
> >  		case NCI_MT_NTF_PKT:
> > +			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
> > +				goto invalid_pkt_free;
> >  			nci_ntf_packet(ndev, skb);
> >  			break;
> >  
> >  		case NCI_MT_DATA_PKT:
> > +			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
> > +				goto invalid_pkt_free;
> >  			nci_rx_data_packet(ndev, skb);
> >  			break;
> >  
> >  		default:
> >  			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
> > -			kfree_skb(skb);
> > -			break;
> > +			goto invalid_pkt_free;
> >  		}
> 
> If so, then one solution may be to add the following here:
> 
> 		continue;
> 
> > +invalid_pkt_free:
> > +		kfree_skb(skb);
> > +		break;
> >  	}
> >  
> >  	/* check if a data exchange timeout has occurred */
> > -- 
> > 2.44.0
> > 
> > 
> 

Thank you for your comment, Simon.

Yes, if it handles packets correctly in nci_{rsp,ntf,rx_data}_packet(),
it should not reach invalid_pkt_free and it should continue to work in
the for statement. Sorry, it is my mistake and need to fix it.

BTW, in the current implementation, if the payload is zero, it will free
the skb and exit the for statement. I wonder it is intended. 

> > -		if (!nci_plen(skb->data)) {
> > -			kfree_skb(skb);
> > -			break;
> > -		}

When the packet is invalid, it should be discarded but it should not
exit the for statement by break. Instead, the skb should just free and
it should handle the subsequent packet by continue. If yes, then it 
may be like below,

	for (; (skb = skb_dequeue(&ndev->rx_q)); kcov_remote_stop()) {
		kcov_remote_start_common(skb_get_kcov_handle(skb));

		/* Send copy to sniffer */
		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);

		if (!skb->len)
			goto invalid_pkt_free;

		/* Process frame */
		switch (nci_mt(skb->data)) {
		case NCI_MT_RSP_PKT:
			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
				goto invalid_pkt_free;
			nci_rsp_packet(ndev, skb);
			continue;   <<<---

		case NCI_MT_NTF_PKT:
			if (!nci_valid_size(skb, NCI_CTRL_HDR_SIZE))
				goto invalid_pkt_free;
			nci_ntf_packet(ndev, skb);
			continue;   <<<---

		case NCI_MT_DATA_PKT:
			if (!nci_valid_size(skb, NCI_DATA_HDR_SIZE))
				goto invalid_pkt_free;
			nci_rx_data_packet(ndev, skb);
			continue;   <<<---

		default:
			pr_err("unknown MT 0x%x\n", nci_mt(skb->data));
			goto invalid_pkt_free;
		}
invalid_pkt_free:
		kfree_skb(skb);
	}

Could I hear your opinion?


