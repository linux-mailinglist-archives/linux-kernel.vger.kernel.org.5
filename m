Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928707A269D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 20:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbjIOSxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 14:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbjIOSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 14:53:44 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5674231;
        Fri, 15 Sep 2023 11:52:08 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d8195078f69so2030067276.3;
        Fri, 15 Sep 2023 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694803927; x=1695408727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aasqqb01RTyUvRyGC6hxJdfWHqT4CxMFKON4c77kp3M=;
        b=eAz7InM8FPLZNPX83zSor/LTfCch4SPDxaF7/5g0GCb/CkAJSiNes5OVKBf3mvn4Hi
         cL5ktYfvmyPEKDZKHQ/ujWEuY3ekGtkzPJRcohE2m7f2RsDg2oSIWxnkjqgUbFYymwqj
         FJWuUAmI9+DuOEToqhVa4kTrHUE/7iIRV9dJuYtttqLRY+xFQKYANDFXrEDceUyz+lIM
         5s/9xOA0WVk8fPG/JtLpJhToKWJhg2NBnOo7vsAqyzvSoYwVqvU1NGowqhGXK/cw0ser
         WkIiqh10O5hQgsNpqsHShT4b/m8JWOfjvKnwYJxNr8YI7wn2enKo1XWLwKBIVW/5Fbls
         zo6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694803927; x=1695408727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aasqqb01RTyUvRyGC6hxJdfWHqT4CxMFKON4c77kp3M=;
        b=TgRJznptYtkkvgd+LJMdpasG6RFeDYyNaXT/F/G5o4WrVUPg3TMrK8gNeEpxjxykbr
         9D7SNrhQ2WAt0PWL+5KvuDhUpNMrYHtB+Mxb4dsrHXIggh5j85FLJrpmHl0UQvwMuPEN
         EQI3vLgeIdOrr0miSmb51d1fQvWhwLEJix27EeIvQo6YE9mw41rhYv0Ucaym74SXzCvT
         NuqhvdygKBHsnODolMwsETHISXCvmH5foPdZRZ5d1p54gq7B1qMxAS9cbjMlIzgPLKD/
         gVcZ/SgkAFgNxkQK0KGHaZ1uQiZcHItxgSc2bHsGHFz5RWTawQB15ALDDHwsNxTWRB+c
         +i1Q==
X-Gm-Message-State: AOJu0Yx6yVo+3muBFl7lGIJprQS+TS+oWvQLkGxl8pD4ue1YCSSchE6h
        YRiTEmu9y5/muyeekLsVKaUIffTHhP4Gao/btw6oSew8zK4=
X-Google-Smtp-Source: AGHT+IFtViUcwHB63JJGkZ0dOZUaLMuKX4K2XDKAxy3Vzcd5o8VKqSzB0gfqFM1bWruYU8ouo8UKJDeyIzIObrYoOaE=
X-Received: by 2002:a25:b51:0:b0:d80:1604:f6e9 with SMTP id
 78-20020a250b51000000b00d801604f6e9mr2276156ybl.44.1694803927437; Fri, 15 Sep
 2023 11:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <1694776841-30837-1-git-send-email-zhangchangzhong@huawei.com>
In-Reply-To: <1694776841-30837-1-git-send-email-zhangchangzhong@huawei.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Fri, 15 Sep 2023 14:51:56 -0400
Message-ID: <CADvbK_euiOKytyFd6KYgNoM5SbDcyz92Li=K7P48H35q1AFxYg@mail.gmail.com>
Subject: Re: [PATCH net] xfrm6: fix inet6_dev refcount underflow problem
To:     Zhang Changzhong <zhangchangzhong@huawei.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 6:54=E2=80=AFAM Zhang Changzhong
<zhangchangzhong@huawei.com> wrote:
>
> There are race conditions that may lead to inet6_dev refcount underflow
> in xfrm6_dst_destroy() and rt6_uncached_list_flush_dev().
>
> One of the refcount underflow bugs is shown below:
>         (cpu 1)                 |       (cpu 2)
> xfrm6_dst_destroy()             |
>   ...                           |
>   in6_dev_put()                 |
>                                 |  rt6_uncached_list_flush_dev()
>   ...                           |    ...
>                                 |    in6_dev_put()
>   rt6_uncached_list_del()       |    ...
>   ...                           |
>
> xfrm6_dst_destroy() calls rt6_uncached_list_del() after in6_dev_put(),
> so rt6_uncached_list_flush_dev() has a chance to call in6_dev_put()
> again for the same inet6_dev.
>
> Fix it by moving in6_dev_put() after rt6_uncached_list_del() in
> xfrm6_dst_destroy().
>
> Fixes: 510c321b5571 ("xfrm: reuse uncached_list to track xdsts")
> Signed-off-by: Zhang Changzhong <zhangchangzhong@huawei.com>
> ---
>  net/ipv6/xfrm6_policy.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
> index 41a680c..42fb6996 100644
> --- a/net/ipv6/xfrm6_policy.c
> +++ b/net/ipv6/xfrm6_policy.c
> @@ -117,10 +117,10 @@ static void xfrm6_dst_destroy(struct dst_entry *dst=
)
>  {
>         struct xfrm_dst *xdst =3D (struct xfrm_dst *)dst;
>
> -       if (likely(xdst->u.rt6.rt6i_idev))
> -               in6_dev_put(xdst->u.rt6.rt6i_idev);
>         dst_destroy_metrics_generic(dst);
>         rt6_uncached_list_del(&xdst->u.rt6);
> +       if (likely(xdst->u.rt6.rt6i_idev))
> +               in6_dev_put(xdst->u.rt6.rt6i_idev);
>         xfrm_dst_destroy(xdst);
>  }
>
> --
> 2.9.5
>
Reviewed-by: Xin Long <lucien.xin@gmail.com>
Thanks.
