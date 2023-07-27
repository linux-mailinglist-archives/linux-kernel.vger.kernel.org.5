Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF1764DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233398AbjG0IqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjG0Ipw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:45:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442EB83CC
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690446438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGeV47pO7s8gps9ksu/4+lDYD8FHRHT3YEWZYPUU9kM=;
        b=N2tcRLMao8GCSz3YHJm/KILK4kuQLXceKHs8MkcCfl1Epwdqsk8Nm7T2TZ4oXtxu55u0u1
        8zwAQ7NfTksHYMiFt2YNjNPtiLfRv6Qb8GIn/UiTOHvzYa3+LfyUYV5wri5inroI6p3Jv2
        ryJGILZfJIoDADj4VBUjw6ch+qpX9XQ=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-6oNo8XWcMt2fZDwVQhUQAA-1; Thu, 27 Jul 2023 04:21:13 -0400
X-MC-Unique: 6oNo8XWcMt2fZDwVQhUQAA-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-767b80384a3so16379285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446073; x=1691050873;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RGeV47pO7s8gps9ksu/4+lDYD8FHRHT3YEWZYPUU9kM=;
        b=bT0zKYWGngcN15M4dd2fR/hBwFhWS47QY8XbMExkW5GWmFOgTexSoJxBvmIZXEclWD
         haVS5bwd3kn+k+2FKrsH7BYmeYJQcomve+/H/vMQmatXXxe/tAN4o50JZjotfaGXUCKy
         nNVyOU00gOgxQ2kMP3OEQbAjNgcbR87Xp2jV4mjNIKP8kUigeX4A8OT1vhRi3e5eqgdm
         Xu8JkIWYJnfOAYXOBYGnTQ1uLgl2MZLzOdNzjrDoA2UPL0eBVb4VrB/XHrIsj3s6dDS1
         qxjE4FFoZLJ7vzVKWpwcSP61yu4ENEluTu+MymOsO8ltGplhJYsaGjSuYeR60MMSSu55
         t9WA==
X-Gm-Message-State: ABy/qLaqA+7BV1+J2y3aeFPWHseRBR2nInWwmd5unTgCz1j5M/0vQo4O
        Ts8vjgcOJf+S+qBYAOt5Fky3SoimegnVhCORrytdpzNS5RHDlmjqB5PnCVtPZEFM0jZ5jCS9jrX
        SRYoOg6YTxR9eUo5CcHWoVsMI
X-Received: by 2002:a05:620a:31a1:b0:75b:23a1:69ee with SMTP id bi33-20020a05620a31a100b0075b23a169eemr4576177qkb.5.1690446073024;
        Thu, 27 Jul 2023 01:21:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHs3zPOBeUj9ojGrgUE/X3gQH8r73DGALfDrJ+7Y3EtRQm+q4OZUXkV2TRkziNvYTa7JtMfZA==
X-Received: by 2002:a05:620a:31a1:b0:75b:23a1:69ee with SMTP id bi33-20020a05620a31a100b0075b23a169eemr4576160qkb.5.1690446072769;
        Thu, 27 Jul 2023 01:21:12 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-238-55.dyn.eolo.it. [146.241.238.55])
        by smtp.gmail.com with ESMTPSA id j4-20020a05620a000400b00767d8663b3asm253886qki.53.2023.07.27.01.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:21:12 -0700 (PDT)
Message-ID: <9cfa70cca3cb1dd20bb2cab70a213e5a4dd28f89.camel@redhat.com>
Subject: Re: [PATCH v4] net: ravb: Fix possible UAF bug in ravb_remove
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>, Zheng Wang <zyytlz.wz@163.com>
Cc:     s.shtylyov@omp.ru, lee@kernel.org, linyunsheng@huawei.com,
        davem@davemloft.net, edumazet@google.com, richardcochran@gmail.com,
        p.zabel@pengutronix.de, geert+renesas@glider.be,
        magnus.damm@gmail.com, yoshihiro.shimoda.uh@renesas.com,
        biju.das.jz@bp.renesas.com, wsa+renesas@sang-engineering.com,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
Date:   Thu, 27 Jul 2023 10:21:07 +0200
In-Reply-To: <20230725201952.2f23bb3b@kernel.org>
References: <20230725030026.1664873-1-zyytlz.wz@163.com>
         <20230725201952.2f23bb3b@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-25 at 20:19 -0700, Jakub Kicinski wrote:
> On Tue, 25 Jul 2023 11:00:26 +0800 Zheng Wang wrote:
> > diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/eth=
ernet/renesas/ravb_main.c
> > index 4d6b3b7d6abb..ce2da5101e51 100644
> > --- a/drivers/net/ethernet/renesas/ravb_main.c
> > +++ b/drivers/net/ethernet/renesas/ravb_main.c
> > @@ -2885,6 +2885,9 @@ static int ravb_remove(struct platform_device *pd=
ev)
> >  	struct ravb_private *priv =3D netdev_priv(ndev);
> >  	const struct ravb_hw_info *info =3D priv->info;
> > =20
> > +	netif_carrier_off(ndev);
> > +	netif_tx_disable(ndev);
> > +	cancel_work_sync(&priv->work);
>=20
> Still racy, the carrier can come back up after canceling the work.

I must admit I don't see how/when this driver sets the carrier on ?!?

> But whatever, this is a non-issue in the first place.

Do you mean the UaF can't happen? I think that is real.=20

> The fact that ravb_tx_timeout_work doesn't take any locks seems much
> more suspicious.

Indeed! But that should be a different patch, right?

Waiting a little more for feedback from renesas.

/P

