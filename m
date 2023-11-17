Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF87EF6DA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346151AbjKQRP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346147AbjKQRP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:15:27 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B150D73
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:15:24 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-545557de8e6so16416a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700241322; x=1700846122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgyNHLwb0dCQ1IvlWod8L7reerP9hkPsOGuvcVTdywg=;
        b=mBSzlkdVuTTDp0sbH//yk/Df5seSktt1cKvsclg01h8kgKOuaGQDTsdPta6wd10z7j
         ipeM1Wp4IQP7QqWzpdjIxCagToQ1y8FbW9cAbluhIizqfS1heYRdEEJ+mq4TpQTlEK7S
         tIdOx0husrVAC66FtscwTBAj/p26nDMMzOb5tqbzf40UxCHymXGP3aXSkLBpfM4y7R0z
         wtleBuPqm3eBgJIQJ3P9OqcJwSFHD/ZVsIK4VlALNTG8m+NQ68VbW4mxA7K0wItL0vkG
         fk/mPsbs1es6oaasxQuXweTRq+RD3c5h4XpElSM/3WoGxy1VAn2dWMpVUxnsC16Ni5DE
         548g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700241322; x=1700846122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgyNHLwb0dCQ1IvlWod8L7reerP9hkPsOGuvcVTdywg=;
        b=j2xD7zHT1Na8PxzoUMOctnv68jv/FYNqL8lsGcAbIKHAHUgQvTy1MulzXLTPGFGHQ8
         D923cx06K4hFR7R4NW0wINrhSKLjVCDe8Odg2ktfLrGPq6jtni6FrMKV0sy1R1XFtwbd
         E5UOLK2j8lhEheLrVpJlBBu+KjKRj9VpM23NUF2R3/wSMVzhiYFPJ8BwxewTFiOB0TBQ
         dI+0zPCfcHueZfK+6KPnkMn1l0WvFlPktABbZhFc16eobnPIYaZ7IEc8MNp22XX45Cem
         erxdOTPF+MU6O/hiEy3iWU5Apt5RXXAkVns2i+5Pz5OhUM/29Yz/uEkQhe0nDRcnRpca
         KYmw==
X-Gm-Message-State: AOJu0Yz9/LSKJzWE8PkldPLpUXdNw1gwIW57554HAy89X9/I+kZ8EFHI
        ZnhpvPxmJ0CiHTDhYoBZG/QG7oFR9XBHmzmOlE9MYQ==
X-Google-Smtp-Source: AGHT+IGHaoxd6OBoU/9H58wg8QaFcYeqOGKdluo8DNtBVbnfVOwOK02JJAT/4aIMsyxVMxrNja0cakOcyd6K3U/OEpY=
X-Received: by 2002:aa7:c954:0:b0:545:279:d075 with SMTP id
 h20-20020aa7c954000000b005450279d075mr142936edt.1.1700241322418; Fri, 17 Nov
 2023 09:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20231117152728.2286551-1-chentao@kylinos.cn>
In-Reply-To: <20231117152728.2286551-1-chentao@kylinos.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Nov 2023 18:15:08 +0100
Message-ID: <CANn89iLHd9oxO6yXmZMfO5cTsnSzqa==ZBCnNEySKpiH86q54Q@mail.gmail.com>
Subject: Re: [PATCH] ipv4: Correct/silence an endian warning in __ip_do_redirect
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 6:07=E2=80=AFPM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> net/ipv4/route.c:783:46: warning: incorrect type in argument 2 (different=
 base types)
> net/ipv4/route.c:783:46:    expected unsigned int [usertype] key
> net/ipv4/route.c:783:46:    got restricted __be32 [usertype] new_gw
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

We need Fixes: tag for networking patches.

> ---
>  net/ipv4/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 3290a4442b4a..e8a542c6b031 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -780,7 +780,7 @@ static void __ip_do_redirect(struct rtable *rt, struc=
t sk_buff *skb, struct flow
>                         goto reject_redirect;
>         }
>
> -       n =3D __ipv4_neigh_lookup(rt->dst.dev, new_gw);
> +       n =3D __ipv4_neigh_lookup(rt->dst.dev, be32_to_cpu(new_gw));
>         if (!n)
>                 n =3D neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
>         if (!IS_ERR(n)) {
> --
> 2.34.1
>

How was this patch tested ?

You are 'fixing' sparse warnings by replacing them with real bugs.

be32_to_cpu() is going to swap bytes on x86, so the lookup will fail horrib=
ly.

Here, if you must silence sparse, you want (__force u32)new_gw

Look at this commit for a template.

commit 3c42b2019863b327caa233072c50739d4144dd16
