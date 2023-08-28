Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F40578B1C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjH1N0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjH1N0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A756DA7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693229138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3lkVi8G9t3DhEUoFFRrWK8mrl/xbvzQsgW1UJs7JQLE=;
        b=eiUgsm9Aei+bdNbGnKoDM6BNlJku8/J5jrzeCBWA05G73sQLa99BOsrYRpW1FinG6/5xn0
        9tDzKX7U/wyaLXAN++HDiadS5gzThbqvjGdqIiDR/JaM++tztCMJ8fx+J1SNu5bVSLaajD
        8cLmhBaKvMMrSK4hG8f9/hNfTHkzqEM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-3-2wwMKEPvm-v-MKCcZCqA-1; Mon, 28 Aug 2023 09:25:37 -0400
X-MC-Unique: 3-2wwMKEPvm-v-MKCcZCqA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-412136f4706so32114231cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:25:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229136; x=1693833936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3lkVi8G9t3DhEUoFFRrWK8mrl/xbvzQsgW1UJs7JQLE=;
        b=Q4hcwbZeBjlFxqFOsECd9S4yzn1QCcAtciZENifTiXB4VTY2lmt7YpmHndPsU4o5hK
         MnhwnTAYCKpDvnPAFc15nRqLZEESNq48yPEFDECRUtxpZwmeaHVp32O328BO+RVCudpm
         6IsrmX34SLTbuLlLPsSKSHrA6NR/n0EIEH9sthVfJ542Dej3QVlo48gqNzttDIb1CZ9i
         ml5C1SomN45xIzi4vJcXpFybCApC5geJVvj1OwvZasxqz8brA/BXRPs0qVziS9dLXaEo
         HQUl5YKeobI4OBJI81ZPld3mXmo0mr23czv5W5oP3Oywqh5K144JaYUWurGjjzkLvCWd
         AmGw==
X-Gm-Message-State: AOJu0Yy+rCmjfGfmGm6YEFvXFVgwgFlSGfqvb97bNjFnAm7hVwAjYBKw
        CshrIFh83WGaMCRsTjjQXjtb0Lf+c+lG4EX5jSa0dz9dR2e0TjSBvaZG6PJFfU7QzAm8Deo3xEu
        bnO4yi8EEvaW9PRVx8a+aM1jWVYI6IXsqD67bC9L2
X-Received: by 2002:a05:622a:1a24:b0:411:f4fe:9ed9 with SMTP id f36-20020a05622a1a2400b00411f4fe9ed9mr16323493qtb.33.1693229136765;
        Mon, 28 Aug 2023 06:25:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBLr77o5uusum213XormNvFrxdCOcrOegbeF8tGFSkFqjJPSBRC5UPszDdYzg0ivfq4iMGUTGklyqa2fGqOrY=
X-Received: by 2002:a05:622a:1a24:b0:411:f4fe:9ed9 with SMTP id
 f36-20020a05622a1a2400b00411f4fe9ed9mr16323477qtb.33.1693229136556; Mon, 28
 Aug 2023 06:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230828132107.18376-1-wander@redhat.com>
In-Reply-To: <20230828132107.18376-1-wander@redhat.com>
From:   Wander Lairson Costa <wander@redhat.com>
Date:   Mon, 28 Aug 2023 10:25:25 -0300
Message-ID: <CAAq0SUkY=MfgJk+w8ZPtn=A5GEm_4BknPL-bgLn=77_fc3XX6Q@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter/xt_u32: validate user space input
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Patrick McHardy <kaber@trash.net>,
        Jan Engelhardt <jengelh@gmx.de>,
        "open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
        "open list:NETFILTER" <coreteam@netfilter.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+stable as I forgot to add it in the Cc section.

On Mon, Aug 28, 2023 at 10:21=E2=80=AFAM Wander Lairson Costa <wander@redha=
t.com> wrote:
>
> The xt_u32 module doesn't validate the fields in the xt_u32 structure.
> An attacker may take advantage of this to trigger an OOB read by setting
> the size fields with a value beyond the arrays boundaries.
>
> Add a checkentry function to validate the structure.
>
> This was originally reported by the ZDI project (ZDI-CAN-18408).
>
> Fixes: 1b50b8a371e9 ("[NETFILTER]: Add u32 match")
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> ---
>  net/netfilter/xt_u32.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/net/netfilter/xt_u32.c b/net/netfilter/xt_u32.c
> index 177b40d08098..117d4615d668 100644
> --- a/net/netfilter/xt_u32.c
> +++ b/net/netfilter/xt_u32.c
> @@ -96,11 +96,32 @@ static bool u32_mt(const struct sk_buff *skb, struct =
xt_action_param *par)
>         return ret ^ data->invert;
>  }
>
> +static int u32_mt_checkentry(const struct xt_mtchk_param *par)
> +{
> +       const struct xt_u32 *data =3D par->matchinfo;
> +       const struct xt_u32_test *ct;
> +       unsigned int i;
> +
> +       if (data->ntests > ARRAY_SIZE(data->tests))
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < data->ntests; ++i) {
> +               ct =3D &data->tests[i];
> +
> +               if (ct->nnums > ARRAY_SIZE(ct->location) ||
> +                   ct->nvalues > ARRAY_SIZE(ct->value))
> +                       return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static struct xt_match xt_u32_mt_reg __read_mostly =3D {
>         .name       =3D "u32",
>         .revision   =3D 0,
>         .family     =3D NFPROTO_UNSPEC,
>         .match      =3D u32_mt,
> +       .checkentry =3D u32_mt_checkentry,
>         .matchsize  =3D sizeof(struct xt_u32),
>         .me         =3D THIS_MODULE,
>  };
> --
> 2.41.0
>

