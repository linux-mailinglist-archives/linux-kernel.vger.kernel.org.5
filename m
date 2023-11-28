Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DEA7FC11D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346106AbjK1PpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346061AbjK1PpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:45:12 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC610FB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:45:18 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b35199f94so55725e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701186317; x=1701791117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMlTXLe3YT0HN8OLrVDdKacmpyuKedWEwgUQDcdRML0=;
        b=bGDAMmLzhchCXdh3satbTP1wvUf90PxCT8GYdxw9Uxx1xvBHtoochoAkNsUpldhRV2
         lwSfqf2EDOR6PzPdRd6DATlbksDOntILc0JwP2zseoUHKv1x47/ArmKzM9zDl/fUvnoV
         1AUuFdW10Y9jarOkygvGweNvw6SPYn13M7D8QhdWB6wQ7x3dJ5k84NOGD57Bswwiezx8
         J97PDo2X8SoONsdkk341ZuUtuMQVEkwXSbUibOir8oiflgs3GII/ljTddHF1b5kD2UvD
         W2ifK9es8vHMwGBIjoONzHAXTStM2oQ/NA7V4btclEseM/iPRO90HB7QGxwOmucUJV1b
         SZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186317; x=1701791117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMlTXLe3YT0HN8OLrVDdKacmpyuKedWEwgUQDcdRML0=;
        b=h4SvdCu73mVabf1ye7IyBEe2wDJDvJvGP3Wo1HdALi9nGp+3p+ynbPVLTWEPufDUmM
         MSO8v6RxbJh0p2N658P9I/o4gC9RYVRb9bN5Qgf0hPTdH7ejLJX/KXeBk8r8GosFLvqa
         tRY3MFk9622gr37qs7F+hw9z9qTcumIUHmBglKE/zt2Gg2xHHkxv/q/QVGHXgqbtqwpe
         qJy/B8ppwWBkExzODeTtgAP42n3AHFC0b6FplttiY7N6qPWfqxV9oV3oWAt4+XByXPOJ
         74Eo4oF8uNx7fi8RSd0pZzjob4oiVt4j6M8OIlb8NIPR8g8Risn7Jym8L0PG0sBoYH9J
         vmhA==
X-Gm-Message-State: AOJu0Yw4oLxg0BnC+TXvd/Bxi5jwHn9LH/g4t1tNquTKD/zylMMeaRht
        6EhEpJiaXXG6rikz7QGxUUojaWR4AdRJCdFMxZnp5A==
X-Google-Smtp-Source: AGHT+IF+9oitYNKpBeMPvzm+CiIMJPvo97+FEfqii/v/7kE9+U7pvcoMnIMSNamP9TDr6yY1OhIUHSpu+5W3Fp7VSxE=
X-Received: by 2002:a05:600c:3c83:b0:40b:2ec6:2a87 with SMTP id
 bg3-20020a05600c3c8300b0040b2ec62a87mr781446wmb.5.1701186316610; Tue, 28 Nov
 2023 07:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20231126151652.372783-1-syoshida@redhat.com>
In-Reply-To: <20231126151652.372783-1-syoshida@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 28 Nov 2023 16:45:05 +0100
Message-ID: <CANn89iKcstKYWoqUCXHO__7PfVRMFNnN5nRQVCTAADvFbcJRww@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in ipgre_xmit()
To:     Shigeru Yoshida <syoshida@redhat.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2023 at 4:17=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.co=
m> wrote:
>
> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
> true. For example, applications can create a malformed packet that causes
> this problem with PF_PACKET.
>
> This patch fixes the problem by dropping skb and returning from the
> function if skb_pull() fails.
>
> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/ipv4/ip_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 22a26d1d29a0..95efa97cb84b 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>                 /* Pull skb since ip_tunnel_xmit() needs skb->data pointi=
ng
>                  * to gre header.
>                  */
> -               skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> +               if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr)))
> +                       goto free_skb;
>                 skb_reset_mac_header(skb);
>
>                 if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> --


I have syszbot reports with an actual repro for this one.

I do not think your patch is correct, something should be fixed
earlier (before we hit this point)
