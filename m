Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0240976AA4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbjHAHvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjHAHvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:51:43 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD1D1BF2
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:51:41 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-40c72caec5cso220961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 00:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690876300; x=1691481100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/W1Bm9fAQmPCctHEmx+9krGOwdheTJeGpcAF1GiQb/8=;
        b=DtuZq5iSCkvuEd2bHHOIg0sceaYNHEbJT6Thk8u2Rq4t2dwZghPeQfyErzd4jBB/BV
         j9YqxyHg1SjCXmLu8o4iKF45r8n2s2UMl4wRKhe2KwfsOFLlQ47w3r5VvP0B3Vaxpqw9
         ShZbEyfQn4CkgZkmlLietqTe8qTJdhP+qsd8PTYdiPNbWi4T33Zyt1mNW3GMeDSIZDL5
         3Jbi9GJ/ese2TjuW5kCQUg3ZHIwyZV6er0yIZIcfs3UBaN1Wuy++KIyeeSQw7K2xYZge
         YcMvmnHgc6ONYFi4gP1UmPwYxAFW7TnghAvZWrmbM13ruqO4MMf2pH3KuVdYZU4QuTFy
         song==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690876300; x=1691481100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/W1Bm9fAQmPCctHEmx+9krGOwdheTJeGpcAF1GiQb/8=;
        b=FHnVux5hCtt4BZxuXfZ/i0jtztj3SCkitndWrMc3fClORPHN6Weaan2c53TP1DW555
         XG9HxCmSRcd1F8sfA6BSbirreWUMlRU5xlY9Hdz/5YfKoRlbXVpDaELAuNOoRrWr3b/F
         wKiUc/M+KuHhFg2IezTunNgVGD7dySZsKUgvjOrCo7pEZQx6uYPbuiwZmdKWFVNZxSwz
         Qdf9pol1LHxILD4sT6q92f5kojmNb4SvwLmLSUEsd4vfWr8fZ96YvH1LrND6Hxn7E2V6
         NvOeb4qN18EDVVSsTvsFO00s20PeWsXEe468/a3a1YnQfq5nNrVjnT1AjeOjPYpK7jYq
         dVkw==
X-Gm-Message-State: ABy/qLawZ3Fo4ukgMwDBpgJVq0sG3SHTzlyWqfKhsu1kTeahSIOcftcz
        sxMLb8pJIrAoteLpJrQoO2z6lSrUieZRUD38/Xp19g==
X-Google-Smtp-Source: APBJJlH9G4vGeDSnD4rykuinEyoa6UwkVAZdYiFuBFX8ENckeLwnn26dcexs1ztlEjN+jP3HARaEWm+4OETQfF1RxGg=
X-Received: by 2002:a05:622a:19a4:b0:3f8:5b2:aef2 with SMTP id
 u36-20020a05622a19a400b003f805b2aef2mr649047qtc.26.1690876300384; Tue, 01 Aug
 2023 00:51:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230801064318.34408-1-yuehaibing@huawei.com>
In-Reply-To: <20230801064318.34408-1-yuehaibing@huawei.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Aug 2023 09:51:29 +0200
Message-ID: <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
To:     Yue Haibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, simon.horman@corigine.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 8:45=E2=80=AFAM Yue Haibing <yuehaibing@huawei.com> =
wrote:
>
>  skbuff: skb_under_panic: text:ffffffff88771f69 len:56 put:-4
>  head:ffff88805f86a800 data:ffff887f5f86a850 tail:0x88 end:0x2c0 dev:pim6=
reg
>

> When setup a vlan device on dev pim6reg, DAD ns packet may sent on reg_vi=
f_xmit().
> reg_vif_xmit()
>     ip6mr_cache_report()
>         skb_push(skb, -skb_network_offset(pkt));//skb_network_offset(pkt)=
 is 4
> And skb_push declared as:
>         void *skb_push(struct sk_buff *skb, unsigned int len);
>                 skb->data -=3D len;
>                 //0xffff88805f86a84c - 0xfffffffc =3D 0xffff887f5f86a850
> skb->data is set to 0xffff887f5f86a850, which is invalid mem addr, lead t=
o skb_push() fails.
>
> Fixes: 14fb64e1f449 ("[IPV6] MROUTE: Support PIM-SM (SSM).")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
> v3: drop unnecessary nhoff change
> v2: Use __skb_pull() and fix commit log.
> ---
>  net/ipv6/ip6mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
> index cc3d5ad17257..67a3b8f6e72b 100644
> --- a/net/ipv6/ip6mr.c
> +++ b/net/ipv6/ip6mr.c
> @@ -1073,7 +1073,7 @@ static int ip6mr_cache_report(const struct mr_table=
 *mrt, struct sk_buff *pkt,
>                    And all this only to mangle msg->im6_msgtype and
>                    to set msg->im6_mbz to "mbz" :-)
>                  */
> -               skb_push(skb, -skb_network_offset(pkt));
> +               __skb_pull(skb, skb_network_offset(pkt));
>
>                 skb_push(skb, sizeof(*msg));
>                 skb_reset_transport_header(skb);

Presumably this code has never been tested :/

Reviewed-by: Eric Dumazet <edumazet@google.com>
