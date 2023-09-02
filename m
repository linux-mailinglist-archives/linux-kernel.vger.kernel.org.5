Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEC9790938
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbjIBSjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 14:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIBSjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 14:39:40 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291F59B;
        Sat,  2 Sep 2023 11:39:37 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bd045336c6so156832a34.2;
        Sat, 02 Sep 2023 11:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693679976; x=1694284776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I52uCB9WiHX/2+LVtJ9UgmcJ1WlYivqMlCC8cFuZ/n4=;
        b=piYtB8+sUkTeNsNNb3t1Pdyg/vY3m30yIxwEES4dRFxgPUWbOyegwOsjYQMpjd5FqA
         MtyPE8CRBkV1zq5XLTfMIVxcKe35aUZUvxRiujsByyMD3Eokiw8zV0oW4gotOeG9qKAF
         Rfi4nsh17QtoyzdXTBMknDOB4VYjoB11/TEvS0fDEMG08e+Is6Eygt7AV8Rw4P/VdZoM
         Hq9dWhvm2w9sejk/QPhWTifNv9BE4FX4kJcqT/avAnZCRyyoo//sa62xNr4jV08dkHnB
         R7pQTxGpAHIWBwufC1xWubdtysi28LaAR/V23aQ3o5SmP7V9XRAWWK0A0vAkVJ7th0mb
         XJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693679976; x=1694284776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I52uCB9WiHX/2+LVtJ9UgmcJ1WlYivqMlCC8cFuZ/n4=;
        b=AvwHpypxsOb+Xgp6/qI/rm8695n223srmm1WeMBapwsKajQW0+uKo3SYxRfzBpSSEv
         5ykniy7mn8FNdbSBnKGf0CnofSQ7OPIdamPAlW2Yx2+wtLZGSRY5AMSj+r6gmP43pAnd
         6oqr3aCHA6GJrfy7JLT3IRbnldad5lozikbZG2CwtjKKa556FihGjPlZvpU1mKuVJqNg
         4n0HAPspJI7U65/U0hO2ZcpOe6aETwyaB30Y8tlCKVEmcBQUdhdS6Z14XB9JZfrAUSYx
         2vZtjdbtD5ctK9ZhgBYTMFxa90dGAuVDe9WY0GLiq1imj4XDKlwLLp2DlEYFo565VJN+
         RL/A==
X-Gm-Message-State: AOJu0YzecPJxlQLYdIuKc3RPUtknk0EcNX73QAS0kKJNwiFg9tAZ7KxZ
        hm33V+7VF2AE0kPdCdRaNNpMTE1Dxkj9hsrlvV5gXcYkDak=
X-Google-Smtp-Source: AGHT+IGr4jp8rgTpvWSb3ElxNgg3lbjfE5ajdAHvRNKdJBXrJ+9mqCu1lBd6DqHRIvCSvIKb6X5YHY5uoDcHMEb1Znc=
X-Received: by 2002:a05:6870:4621:b0:1bf:77e2:95cc with SMTP id
 z33-20020a056870462100b001bf77e295ccmr6922972oao.17.1693679976380; Sat, 02
 Sep 2023 11:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <acb58c1adc02d0b949d8371933b2afe3c056c33f.1693583786.git.sylv@sylv.io>
In-Reply-To: <acb58c1adc02d0b949d8371933b2afe3c056c33f.1693583786.git.sylv@sylv.io>
From:   Eyal Birger <eyal.birger@gmail.com>
Date:   Sat, 2 Sep 2023 21:39:24 +0300
Message-ID: <CAHsH6Gv7m2Q=3sPZsRSMfqasay0P7j9zZT=DDwwgv7TuPX5agg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] xfrm: Use skb_mac_header_was_set() to check for
 MAC header presence
To:     Marcello Sylvester Bauer <email@web.codeaurora.org>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,

On Fri, Sep 1, 2023 at 7:15=E2=80=AFPM Marcello Sylvester Bauer
<email@web.codeaurora.org> wrote:
>
> From: Marcello Sylvester Bauer <sylv@sylv.io>
>
> Replace skb->mac_len with skb_mac_header_was_set() in
> xfrm4_remove_tunnel_encap() and xfrm6_remove_tunnel_encap() to detect
> the presence of a MAC header. This change prevents a kernel page fault
> that could occur when a MAC address is added to an L3 interface using
> xfrm.
>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>  net/xfrm/xfrm_input.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
> index d5ee96789d4b..afa1f1052065 100644
> --- a/net/xfrm/xfrm_input.c
> +++ b/net/xfrm/xfrm_input.c
> @@ -250,7 +250,7 @@ static int xfrm4_remove_tunnel_encap(struct xfrm_stat=
e *x, struct sk_buff *skb)
>
>         skb_reset_network_header(skb);
>         skb_mac_header_rebuild(skb);
> -       if (skb->mac_len)
> +       if (skb_mac_header_was_set(skb))
>                 eth_hdr(skb)->h_proto =3D skb->protocol;
>
>         err =3D 0;
> @@ -287,7 +287,7 @@ static int xfrm6_remove_tunnel_encap(struct xfrm_stat=
e *x, struct sk_buff *skb)
>
>         skb_reset_network_header(skb);
>         skb_mac_header_rebuild(skb);
> -       if (skb->mac_len)
> +       if (skb_mac_header_was_set(skb))
>                 eth_hdr(skb)->h_proto =3D skb->protocol;

I checked xfrm tunnels over both GRE and IPIP, and in both cases when reach=
ing
this code the skb->mac_len was 0, whereas skb_mac_header_was_set()
was 1.

So in both cases this suggested patch would make this condition true and
write to an Ethernet header location on these L3 devices.

Can you please share your reproduction scenario for this case?

Thanks,
Eyal.

>
>         err =3D 0;
> --
> 2.42.0
>
>
