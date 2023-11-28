Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D89A7FC2C5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbjK1PvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346220AbjK1PvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:51:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F0512A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701186674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4h4K1ccbQslEI6CdDcMlauekllahJXsz5FTmnurJLoU=;
        b=bjs0f/mYwiLUBREsuEF4KX692+u5LQZmNOr/jJIP8NqTseNQCakFYPuS3FtX9NDYNnsxm2
        XrZDS+bmaZR4MH1X1aXuiR8qH43ymgI6r4/YOIzVvDKnpwH9l1pnA+w97nWZbhrHew5eQQ
        KyIbsFWMBnEY04CNGIOhqgzBvUobaNg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-DdnSqRwwPKS5rBn5PejAMA-1; Tue, 28 Nov 2023 10:51:13 -0500
X-MC-Unique: DdnSqRwwPKS5rBn5PejAMA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-332e4030884so784142f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186672; x=1701791472;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4h4K1ccbQslEI6CdDcMlauekllahJXsz5FTmnurJLoU=;
        b=LphjsC2akkI1xTfW9M3+r49dTFmNtu0cQ5yCh4pw1vqjUzusyrtYnKPSM7bcC898i8
         +iI/cq7FDABHltCG1ZmpChyRn1hvat+V3+79kz4GvpGfD0KsLnLi5Rk+zz9KakFY18nP
         2GsM0iYl2S1FGR8rhH23iztg7hK3ksgq9GeRzAhXWpNBEQAjiHqbjik3TXfOTA55auP0
         TmKzp1TtQrUqMYuXE/+tclzK7V3AKL+OESQVo7qUSAwCtQJ6FTQmyBLwwrqmcD6loK5/
         uIQ+Pr0fYCptCWtuYxPDulVNlSNOMUOAeZOAafKCaPSbgRDHTHmtmXZhHr7Nak+2CepU
         +9Lg==
X-Gm-Message-State: AOJu0YwL3YXAiAdp7Etgozng0YwOdVxaEjkQq+SPDCH01qQ6WfsCgZII
        iBTYUA5oItWZthNMQX2/j7dgRTfRjMyfqCyFRQQyMmrRVCISwPC7g2AdQMCVd4XcrwerSSc32xx
        gcM2ZaUNqzW1xOrMGrLlCpw/M
X-Received: by 2002:a05:6000:1b85:b0:333:980:c388 with SMTP id r5-20020a0560001b8500b003330980c388mr1939161wru.5.1701186672056;
        Tue, 28 Nov 2023 07:51:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfMnj/2FNTGqvThbUF/4m8o1l2cbXNDZ7gJ4fjNtdMGR7oHS66wq+o/saOJAuM68jSexVxLQ==
X-Received: by 2002:a05:6000:1b85:b0:333:980:c388 with SMTP id r5-20020a0560001b8500b003330980c388mr1939149wru.5.1701186671709;
        Tue, 28 Nov 2023 07:51:11 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-156.dyn.eolo.it. [146.241.249.156])
        by smtp.gmail.com with ESMTPSA id q4-20020adfea04000000b003296b488961sm15260012wrm.31.2023.11.28.07.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:51:11 -0800 (PST)
Message-ID: <9daf8509e39cd20d9d806afdb425ad43af037f8d.camel@redhat.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Dumazet <edumazet@google.com>,
        Shigeru Yoshida <syoshida@redhat.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Nov 2023 16:51:09 +0100
In-Reply-To: <CANn89iKcstKYWoqUCXHO__7PfVRMFNnN5nRQVCTAADvFbcJRww@mail.gmail.com>
References: <20231126151652.372783-1-syoshida@redhat.com>
         <CANn89iKcstKYWoqUCXHO__7PfVRMFNnN5nRQVCTAADvFbcJRww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-11-28 at 16:45 +0100, Eric Dumazet wrote:
> On Sun, Nov 26, 2023 at 4:17=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.=
com> wrote:
> >=20
> > In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() retur=
ns
> > true. For example, applications can create a malformed packet that caus=
es
> > this problem with PF_PACKET.
> >=20
> > This patch fixes the problem by dropping skb and returning from the
> > function if skb_pull() fails.
> >=20
> > Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> > Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> > ---
> >  net/ipv4/ip_gre.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> > index 22a26d1d29a0..95efa97cb84b 100644
> > --- a/net/ipv4/ip_gre.c
> > +++ b/net/ipv4/ip_gre.c
> > @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
> >                 /* Pull skb since ip_tunnel_xmit() needs skb->data poin=
ting
> >                  * to gre header.
> >                  */
> > -               skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> > +               if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr))=
)
> > +                       goto free_skb;
> >                 skb_reset_mac_header(skb);
> >=20
> >                 if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> > --
>=20
>=20
> I have syszbot reports with an actual repro for this one.

Could you please share them? I could not find easily the reports in
https://syzkaller.appspot.com/upstream

Thanks,

Paolo

