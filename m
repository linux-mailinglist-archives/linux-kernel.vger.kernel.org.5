Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1567BA217
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjJEPNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJEPMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB19EE3
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696516984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHM0xHF2kv3BLjLoSwriKAoHSAm/JAv+ui/sTdWa+9U=;
        b=T9PhZ/m+s7jLKFTBAvB6Q4+6ChGyzBdclVHrm8M5tpvf5T4paiQ9j0QvCZhlmWLlV98x46
        7A1H2e42FIk3VSqxEIYJWN+Nac5FwB3eNuyQDL+jLLxSvR6KYh0NB97qrY+K+TIABuPc+l
        efD+HmZu154zyHV6s2K5nmj76BqKRdQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-aqeGIM6iMrWDArgiBGZpQQ-1; Thu, 05 Oct 2023 03:37:25 -0400
X-MC-Unique: aqeGIM6iMrWDArgiBGZpQQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ae6afce33fso17550766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 00:37:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696491444; x=1697096244;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHM0xHF2kv3BLjLoSwriKAoHSAm/JAv+ui/sTdWa+9U=;
        b=gkPbp/CcucLzfdvEAVwi8oPTvrRpxTxLMAzDMj5rpVwMqtHL+bF0FVHQzbecandJCn
         5B7DZfZ3oZ0FOd72L6rtWFCzSPWOI39Mm3IKlASuv/NS0KH6G4R6cNAZEbu9B+FHW1ed
         ozYdPH/I76CG6xwADFkj1snX5NyeXDS4yW+fyglOczD8Yj4uDFRJmtGLoc4WlFB+/8m7
         4fi49joQApwwbnPdFJ02gxi1poo9uqSyu9ARKzF24tNvT0kJIX6YV0BzVP1pp2ISSygq
         4MLF+DqBPSMTsZNwEx7I28vCdzkELNmexPU5lmBf/AVV96cr2SIxh5Y8bvIQBslo8SZM
         AATA==
X-Gm-Message-State: AOJu0Yz1g2HsbBuMQSDU4s+XXOeNDKFn2/oEyuLPpnjrB8+Sx9OwkfDn
        k70fvwfwmOIKZisdu3dGta0FHUrwf7rrDfAUxoWR84V5Vx7GNVMaRN1poQ+gj1Y17LMWC1ghMN4
        uTWU6vVXjEwALwmoc+DK8jlFT
X-Received: by 2002:a17:906:7389:b0:9ae:2f35:442a with SMTP id f9-20020a170906738900b009ae2f35442amr4002373ejl.5.1696491444122;
        Thu, 05 Oct 2023 00:37:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGdFCAAdCKfZyRjyhsGRK+djz3pK0cRwljeBcUUAtdaOoJFV7XbegYiGlFskH2Ho7U/h+CKg==
X-Received: by 2002:a17:906:7389:b0:9ae:2f35:442a with SMTP id f9-20020a170906738900b009ae2f35442amr4002357ejl.5.1696491443781;
        Thu, 05 Oct 2023 00:37:23 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-237-55.dyn.eolo.it. [146.241.237.55])
        by smtp.gmail.com with ESMTPSA id lr5-20020a170906fb8500b009adcb6c0f0esm689732ejb.193.2023.10.05.00.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 00:37:23 -0700 (PDT)
Message-ID: <0c0b0fade091a701624379d91813cfb9f30a5111.camel@redhat.com>
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
From:   Paolo Abeni <pabeni@redhat.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        patchwork-bot+netdevbpf@kernel.org
Cc:     khalasa@piap.pl, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 05 Oct 2023 09:37:21 +0200
In-Reply-To: <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
         <169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
         <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-03 at 23:54 +0200, Linus Walleij wrote:
> On Tue, Oct 3, 2023 at 11:40=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
>=20
> > This patch was applied to netdev/net-next.git (main)
> > by Paolo Abeni <pabeni@redhat.com>:
>=20
> Sorry Paolo, this is the latest version of this patch, which sadly change=
d
> Subject in the process:
> https://lore.kernel.org/netdev/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@=
linaro.org/

Ouch, my bad :(

The change of subject baffled both me and patchwork. As I process the
backlog fifo, and was unable to reach the most recent versions due to
the backlog size, I missed the newer revisions.

In the future, please try to avoid subject change. If the subject chane
is needed, please explicitly mark the old version as superseded, it
will help us a lot, thanks!

Paolo

