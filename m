Return-Path: <linux-kernel+bounces-103208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D3687BC69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C62728833F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B326F08C;
	Thu, 14 Mar 2024 11:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs73pob8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5558F6CDB5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710417506; cv=none; b=CDKqpt1N6eSmaeRy1VVOj7ziZ7wojayu4H7UdXQWzxg0q6lsGwkstAph24aEdHgf/ubWvrnze0HWVrVw8ENs5h9Mmqzf7vbisXfaVNrQFFhQqj4QwHj9gUngYZl3NRNW9i3t2Lk/FaJS1Cocu2U0OoRHienbN5sIBZwYuMKFLh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710417506; c=relaxed/simple;
	bh=cPIjq/ioWJX7GDmxr9rJ3pUkOnGvdI9f73h5WuUl6/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWATttozBydOhNFKjYU6UbMZ9mOt1LCxGY3TICnTdGaurH20ifYCL+DdtT78Id1XIs6Yfr/WvAG+2QzVSw77ExUAzvfR7reG+gcXvI49oKym/tIXO3ldvP12p5JdtCY88AbjutLYNgje70E6UM4bp3ZAmgxFhQKYoEoqviHozPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vs73pob8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710417501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=V1bvhAW4rdS6r2kMFQdSoz5dIF43oV8/RehNP32Fs+Q=;
	b=Vs73pob8fssaPfDo9IxsxkCz+LRtJ8qvLw+iYL3muSCaUpyo/YUfOJ8vZP376ncHlS3L8T
	ds8R90QQ7hr6r6DB3EvgZtnkNaQMn8nWwly2oMCJh249jR9Q6lumuObzE3Cr5PyTjXwiVo
	zQMe7JE7YvIwxIu8k/jW/bYLhjF/gWk=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-pw4_DqJXNEiymNTD-9JNig-1; Thu, 14 Mar 2024 07:58:17 -0400
X-MC-Unique: pw4_DqJXNEiymNTD-9JNig-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-513ceb6904fso275735e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 04:58:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710417496; x=1711022296;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1bvhAW4rdS6r2kMFQdSoz5dIF43oV8/RehNP32Fs+Q=;
        b=aM66729GDkaYu38e8XKH1Lp4F+PNj+G2LTEVTbFJn2kjEEn3QP7BLMUUrzATDB6OLW
         FOu3CAPCPfNL3kT5idgbuOp6XBP6tZLiiODmZ+CO625uax+bOrp2wgLMWZK5SM5BlBlm
         uEa9+yU3TTZChULuKVAQgha8T3dSNrGV0x3nrvC90NIvmgDs8FCN4bZxlCCgFes+jiHR
         9OYLwXa4pA1afsECCEW/M4N+d0regmr5TayWyy7DGxkClRQHFWxpNdqdFspy0haInyFl
         C7Ij7tXVFolxI8S/5Wy2ydJPwN/fNkrBsSIECpzt/Xi9ZjSKYOymX0fIwzgvMeastGhw
         W10g==
X-Forwarded-Encrypted: i=1; AJvYcCUI93NGf0lly/FZ7SFLEPv/x3Gt+dnii1jFtCUAOsOUxbcZ6XVK7YbHk8QZUTZe24CVd/ZVtRwdYwLuJum+TT2ZxuL78UPjry3mBaiF
X-Gm-Message-State: AOJu0YzPNtMiyaZFUFMaRqfmbcUZTdU1WJF6F+CsaPlx03kDyyWzuQHl
	DdyGDfyn9516LUteEvh+hvTK5ILnpnuW8u0tw7AcaxRVZx+b3VSgwm2hM/tLNORmamQc/FiUjNY
	z0IQS6uKW1iZWmZxxvQlNRVq8oGwMOBI0mMKMNpuDMiTy+TabcErcaODTWI14HA==
X-Received: by 2002:a19:5e5e:0:b0:513:c5db:c770 with SMTP id z30-20020a195e5e000000b00513c5dbc770mr973564lfi.1.1710417496397;
        Thu, 14 Mar 2024 04:58:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5EBBxFEKSG5awbbFcJ0uBR0JJqY2xM71PRWRN2jsOSJ08tLdUwmKBlNEfwv94EIODDdeG9w==
X-Received: by 2002:a19:5e5e:0:b0:513:c5db:c770 with SMTP id z30-20020a195e5e000000b00513c5dbc770mr973542lfi.1.1710417495995;
        Thu, 14 Mar 2024 04:58:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-230-217.dyn.eolo.it. [146.241.230.217])
        by smtp.gmail.com with ESMTPSA id du18-20020a0560000d5200b0033b7ce8b496sm576423wrb.108.2024.03.14.04.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 04:58:15 -0700 (PDT)
Message-ID: <498dc99d25965877f7d15592dcbb340f97d803b4.camel@redhat.com>
Subject: Re: [PATCH net] nfc: nci: Fix uninit-value in nci_dev_up
From: Paolo Abeni <pabeni@redhat.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>, Krzysztof Kozlowski
	 <krzysztof.kozlowski@linaro.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com
Date: Thu, 14 Mar 2024 12:58:14 +0100
In-Reply-To: <ZfLKjD6aMrGPEgHh@zeus>
References: <20240312145658.417288-1-ryasuoka@redhat.com>
	 <413249a5-13b0-4a06-9819-650eb4e82b37@linaro.org> <ZfLKjD6aMrGPEgHh@zeus>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-03-14 at 18:59 +0900, Ryosuke Yasuoka wrote:
> On Wed, Mar 13, 2024 at 10:01:27AM +0100, Krzysztof Kozlowski wrote:
> > On 12/03/2024 15:56, Ryosuke Yasuoka wrote:
> >=20
> > > CPU: 1 PID: 5012 Comm: syz-executor935 Not tainted 6.7.0-syzkaller-00=
562-g9f8413c4a66f #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 11/17/2023
> >=20
> > These two lines are not really relevant, it's a virtual platform, so
> > whether this is Google or Amazon it does not matter, and your log paste
> > is already quite long. If there is going to be any resend, I propose to
> > drop.
>=20
> OK. Do you mean all these log messages that syzbot reported should be
> dropped or I should leave only relavant messages?

It's not a big deal either way, but there is a quite established
practice of including the whole splat.

> > > Fixes: 6a2968aaf50c ("NFC: basic NCI protocol implementation")
> > > Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspot=
mail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=3D7ea9413ea6749baf557=
4 [1]
> > > Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
> > > ---
> > >  net/nfc/nci/ntf.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
> > > index 994a0a1efb58..56624387e253 100644
> > > --- a/net/nfc/nci/ntf.c
> > > +++ b/net/nfc/nci/ntf.c
> > > @@ -765,6 +765,9 @@ void nci_ntf_packet(struct nci_dev *ndev, struct =
sk_buff *skb)
> > >  		 nci_opcode_oid(ntf_opcode),
> > >  		 nci_plen(skb->data));
> > > =20
> > > +	if (!nci_plen(skb->data))
> > > +		goto end;
> >=20
> > Looks reasonable, however wouldn't there be the same issue in
> > nci_rsp_packet() and other cases from nci_rx_work()? I wonder why only
> > NTF packets could be constructed without payload.
>=20
> Yes, I can reproduced very similar bug reported by syzbot [2] in my lab.
> When the MT is NCI_MT_RSP_PKT (0x2), KMSAN detects the following bug in
> nci_rsp_packet().

[...]

> So it means we should check the payload length in not >
nci_ntf_packet()
> but in nci_rx_work(). Like this. (Note that it has not tested.)
>=20
> diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
> index 6c9592d05120..f9880d6ad2b2 100644
> --- a/net/nfc/nci/core.c
> +++ b/net/nfc/nci/core.c
> @@ -1512,6 +1512,11 @@ static void nci_rx_work(struct work_struct *work)
>                 nfc_send_to_raw_sock(ndev->nfc_dev, skb,
>                                      RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
>=20
> +               if (!nci_plen(skb->data)) {
> +                       skb(free);
> +                       break;
> +               }
> +
>                 /* Process frame */
>                 switch (nci_mt(skb->data)) {
>                 case NCI_MT_RSP_PKT:
>=20
> Let me know if you have any idea.
>=20
> https://syzkaller.appspot.com/bug?extid=3D7ea9413ea6749baf5574 [1]
> https://syzkaller.appspot.com/bug?extid=3D685805de744584f4d24b [2]

I think addressing the issue early in the code path would be better -
unless there is some functional issue with that I can't foresee.

Thanks,

Paolo


