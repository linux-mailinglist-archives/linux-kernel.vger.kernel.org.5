Return-Path: <linux-kernel+bounces-139836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EECE48A0849
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 520DCB24C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E6E13D254;
	Thu, 11 Apr 2024 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QO7s/u85"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533A13C806
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712816203; cv=none; b=coVlXUKJcCBka7WTlzL1ujBMw0YuqYLeITt7FbquGawUZ81dtEQt6ZVePGyLw76vYAS7o9NlR9kuZTfotrMWNKLO4GgeqoWniYUZCqU2YvcVIgLMsMWmLJTp8F6V4nXw4/PHZjAJUUuWCfNh10gB2rxEW89Gvh9fj6GHFQp4jbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712816203; c=relaxed/simple;
	bh=ozAyKmyvxlkPWGys6MkUnJuOr77XH88cGlOzyHsC+qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c3QiiwBHZqhMCD57WDYwt91iwSke1dqBgfaEeREsn9wdmIl5v9/3elX28epmZraBo52TthwtPf1RyUkgstaYPC9Vr3Ru5nhXF7ntXZ3cXphuyoJ6oUIKV1j/Egj6DPX/lGAVbGxdjw4HKxHQs+chzPKP2ATHc2xuJL4mz2MT5RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QO7s/u85; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712816200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cx2Kk+ucdj8fUgOBSkqmCMv7qTcccw+VPTWaRW+FoUY=;
	b=QO7s/u85JpQGBjuQTx3k2CQfvOCE8W68j4oAVVDwxmlnkgXsy9928WVrivfEbBwy7jo1vb
	ssdTBBibs4OwV+FFWkSQTgB77HEHiLm0Qs5m/kwDtPntDvqbqwVhxse/5EG9CmTo5P/ExM
	8rr2WXOpRUWoW5pEt/RW5GQi3lB4+nc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-khSpMSLkNOyKuMsVV05_eQ-1; Thu, 11 Apr 2024 02:16:37 -0400
X-MC-Unique: khSpMSLkNOyKuMsVV05_eQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e211c27bdeso62401365ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712816197; x=1713420997;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx2Kk+ucdj8fUgOBSkqmCMv7qTcccw+VPTWaRW+FoUY=;
        b=LMzYp/1azmxxIhZlsrtHiZtdL3yPSTBmKw5rVlibbGA3mLc5KeAN7LMTTu+/p3TLcM
         YI3Qpzljvo3dbna0HcP8/amHTM4fyPzaX4KoRGJhwSXZzVs6tXl2Aaib2FMNUrp2zjqu
         HleQhyKoaaJTHD2nc8CmJ9f8xTqBZnRBdRGabsikrweEJCGpH2SmPiPy9F8zMZjv+J8v
         P7o+ttcMtFWsPx7vFFdsU9Z81C0S7c2uui2F1QsMZ97/UGQ+9VQ4JBgXWGIItl/R0amv
         wuTCgDjuqOZDxv3TpRWoxsfnzlx96nY/chHkSP+j7E10btuC/fiFCH/1k+voTi8B0FL5
         Ir4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXm/6mFaB+KFI0rsZaFMXiSCMU3qDpr0M1CWE9KCC6ppqMFhZRuMRIFfhRf91zPBFX98NRQJ6VGWlQNJgQAigroglh9P8NeEl5wYinY
X-Gm-Message-State: AOJu0Yx/XHb5fEVVaVwMRICQsM7CQDgBPJ/2+q70/n0zLLZM3WPNxMja
	+kfZi7qegjLK3t74gYpiWrFKqiO/7IoHdwQWuI7B0xcMP+cbnl2eNUhDSK3rmP86XsbU92qT61x
	lmtnQ/+2k0iQibXJ9kUpF/fk7UqjSS48uVG2dMMpJiz6MyAXFDDgAhbV24QtDeg==
X-Received: by 2002:a17:902:ea0c:b0:1e2:23b9:ead3 with SMTP id s12-20020a170902ea0c00b001e223b9ead3mr5561090plg.24.1712816196925;
        Wed, 10 Apr 2024 23:16:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH46Yc3pzmajDvu8kIM6rfqzcQePT5ZmOP2QZ1lVDtdbV7+zn4ocPcuwNm3nOhZizG2+HqCIg==
X-Received: by 2002:a17:902:ea0c:b0:1e2:23b9:ead3 with SMTP id s12-20020a170902ea0c00b001e223b9ead3mr5561078plg.24.1712816196526;
        Wed, 10 Apr 2024 23:16:36 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id f18-20020a170902ce9200b001e4008127a7sm519594plg.137.2024.04.10.23.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:16:35 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:16:32 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, syoshida@redhat.com
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <ZheAQACKb82PkWkn@zeus>
References: <ZhJTu7qmOtTs9u2c@zeus>
 <CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJrQevxPFLCj2P=U+XSisYD0jqrUQpa=zWMXTjj5+RriA@mail.gmail.com>

Thank you for your review, Eric.

On Mon, Apr 08, 2024 at 11:55:54AM +0200, Eric Dumazet wrote:
> On Sun, Apr 7, 2024 at 10:05 AM Ryosuke Yasuoka <ryasuoka@redhat.com> wrote:
> >
> > syzbot reported the following uninit-value access issue [1]
> >
> > nci_rx_work() parses received packet from ndev->rx_q. It should be
> > checked skb->len is non-zero to verify if it is valid before processing
> > the packet. If skb->len is zero but skb->data is not, such packet is
> > invalid and should be silently discarded.
> >
> > Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
> > Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
> > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > ---
> >  net/nfc/nci/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> > index 0d26c8ec9993..b7a020484131 100644
> > --- a/net/nfc/nci/core.c
> > +++ b/net/nfc/nci/core.c
> > @@ -1516,7 +1516,7 @@ static void nci_rx_work(struct work_struct *work)
> >                 nfc_send_to_raw_sock(ndev->nfc_dev, skb,
> >                                      RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
> >
> > -               if (!nci_plen(skb->data)) {
> > +               if (!skb->len || !nci_plen(skb->data)) {
> 
> #define nci_plen(hdr)           (__u8)((hdr)[2])
> 
> So your patch will not help if skb->len is 1 or 2.

Exactly. I've reviewed my patch and here's a draft. I'd like to hear
your and all member's opinion. Note this code currently redundant. Let
me explain why I've written it this way. I'll refine it before sending
the v2 patch.

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index b7a020484131..89bdb959080c 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1516,7 +1516,22 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!skb->len || !nci_plen(skb->data)) {
+		// FIXME: hardcoded
+		if (skb->len < 3) {
+			/* packet is too small */
+			kfree_skb(skb);
+			break;
+		}
+
+		if (!nci_plen(skb->data)) {
+			/* payload should not be zero */
+			kfree_skb(skb);
+			break;
+		}
+
+		// FIXME: hardcoded
+		if (skb->len < 3 + nci_plen(skb->data)) {
+			/* packet length is not match with actual packet size */
 			kfree_skb(skb);
 			break;
 		}

Before refering to message type in nci_mt(skb->data), we need to check a
couple of things below.

1. check if skb->len is larger than 3 Octets, which is header size of
NCI packet. Since the payload size is in 3rd octet of header, We should
check in advance.
2. check if nci packet payload is non zero as my previous fix
(03456156).
3. check if skb->len is match with actual NCI packet size

Could you check if these conditions are reasonable? If yes, then I need to
remove hardcorded "3", which represents the header size of NCI packet.
Now we can use NCI_CTRL_HDR_SIZE and NCI_DATA_HDR_SIZE instead of the
hardcorded value. However, we have no way to know if this NCI packet 
is data or ctrl packet before refering to message type in nci_mt(skb->data). 
In the current specification, since both of header sizes are the same, we can
check like this. 

-		if (skb->len < 3) {
+		if (skb->len < NCI_CTRL_HDR_SIZE ||
+		    skb->len < NCI_DATA_HDR_SIZE) {

But it has potential bug that packet will drop unexpectedly if either 
ctrl or data header size become larger.

Do you have any good idea to implement this condition?

Regards,
Ryosuke


