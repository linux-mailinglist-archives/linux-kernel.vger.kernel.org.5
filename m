Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C37A648D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbjISNOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjISNOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:14:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ABB6EC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695129220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2RckHjxKJ/DBwzz6iC1sFaYDrVOyjnLoFmkRy7jkyvQ=;
        b=jRLMS/wPCacC/wQHCj7gFWzgIa4dt0Vp+miDbcvbsjj16bACG60f5rP1wRBDkPB0ki0RhE
        73OWaFjTi21mxqH8g+tkYuehJCRF4QC7Own3Urry5U2yCvVsUGGLvkYmZTtyaLMUI5Cyih
        VqnR1/aD45fRbrVxC5195SavUzmdvX0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-oZXK3DCgMw6VsoO9oR6ltA-1; Tue, 19 Sep 2023 09:13:38 -0400
X-MC-Unique: oZXK3DCgMw6VsoO9oR6ltA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-9adcb9ecc16so105065866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 06:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695129217; x=1695734017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RckHjxKJ/DBwzz6iC1sFaYDrVOyjnLoFmkRy7jkyvQ=;
        b=N6c5VV3XPgxEejVKKcDKqtkYc+BV2IqT0oU1AzI38rGaY+iKiALutje3oaEsRw1RgA
         yY7wBtacSbyE/upO5YOLrs5XJp2IPExkQ8+IGw13N9vXKikmSw6Nto6YMJTgBkVJ3+ZD
         gtTTu1DMJ0xKaTlMPHXosZ/gcFWg3qKYbdG9vd/rQRYAuUpRFj9jMR858KNmp3ma7VYo
         BVY8iSySkcfj/rTDFo8nlKOkvpm+/N1lkRE282+WXQOh5yJHu0zBR0VnzLaCFPrLNgeF
         u5ktiseEGYWg6xBo5HDEs3pNGI+2xc9w0kUfYbwN5XyG4o7UyVQyyxcWS9xrgSAvIC8S
         nLbw==
X-Gm-Message-State: AOJu0YzQuWqBTo6usHM4eXz/9CvGbXjpRCZx22tNvulx6iav8vfbfHYt
        prHgbXTDpm4hpU6mnSR3ww0m9LNOi1ssr/bClfcSVt62ObaejTWGHbWzQLorrMhKqT1VB+EcHzj
        w6uXsCA431VAuxtDuV2UckW4y
X-Received: by 2002:a17:906:5341:b0:9ad:e66a:413f with SMTP id j1-20020a170906534100b009ade66a413fmr7926876ejo.3.1695129217560;
        Tue, 19 Sep 2023 06:13:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOjZRtj5oGUym5VCX6sEBFHCi1p8R7yHSbCfnhmWdHIxrPoDeN11gLmXKuoL1heM5zbA5+kw==
X-Received: by 2002:a17:906:5341:b0:9ad:e66a:413f with SMTP id j1-20020a170906534100b009ade66a413fmr7926845ejo.3.1695129217203;
        Tue, 19 Sep 2023 06:13:37 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-241-221.dyn.eolo.it. [146.241.241.221])
        by smtp.gmail.com with ESMTPSA id jx10-20020a170906ca4a00b009ae3e6c342asm145816ejb.111.2023.09.19.06.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 06:13:36 -0700 (PDT)
Message-ID: <ad0a961c523aa50f25380b339e1cb6f50109a5fe.camel@redhat.com>
Subject: Re: [PATCH v3] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
From:   Paolo Abeni <pabeni@redhat.com>
To:     Roger Quadros <rogerq@kernel.org>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 19 Sep 2023 15:13:35 +0200
In-Reply-To: <20230918095346.91592-1-rogerq@kernel.org>
References: <20230918095346.91592-1-rogerq@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-09-18 at 12:53 +0300, Roger Quadros wrote:
> Add driver support for viewing / changing the MAC Merge sublayer
> parameters and seeing the verification state machine's current state
> via ethtool.
>=20
> As hardware does not support interrupt notification for verification
> events we resort to polling on link up. On link up we try a couple of
> times for verification success and if unsuccessful then give up.
>=20
> The Frame Preemption feature is described in the Technical Reference
> Manual [1] in section:
> 	12.3.1.4.6.7 Intersperced Express Traffic (IET =E2=80=93 P802.3br/D2.0)
>=20
> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124=
.
>=20
> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pd=
f
>=20
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++++++++
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 240 ++++++++++++++++----
>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 104 +++++++++
>  5 files changed, 454 insertions(+), 47 deletions(-)
>=20
> Changelog:
>=20
> v3:
> - Rebase on top of v6.6-rc1 and mqprio support [1]

I'm unsure if this will require a rebase for the next revision of the
mqprio support. Anyhow the two patches are related, it's probably
better bundle them in a series so that the dep is straight-forward.

When reposting, please insert the target tree in the subject profix
(net-next in this case).

Thanks!

Paolo

