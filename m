Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F52676FEA7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjHDKnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjHDKnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:43:01 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF4946BB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:43:00 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-40a47e8e38dso196311cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 03:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691145779; x=1691750579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOJqrwX6eBicRAoTwudqPPw7DL3KcgjyNYI7qHOK9jg=;
        b=tlDzk8p3Qd9BVW31GLzRyv7ZUcMDB7K713VYP+7kXiputkHlQwiVDYUvytqQGIfBEr
         wbu6z7qPS0jGXDpZHsGjn1/qIr0Gf6TQ8o+iAVGfZjBtaRo4IWQYLaavW6VxGV+5NEw8
         IxWKqgrg+d1tqij+SWc8kCIJ0vrVzJMFyPt87YDo1FsVaP3rjl/qhtn0Y6mUKgUZECwh
         ur1HjcQqWFG+0rJUeOxaMEcaSa/Hz9J7WZaOoP+VomunEFcbhhuv08S8B6Gps3ZsiSf8
         FsHdkK+ccYJdcTueG2B9B0K1H3T/fp01FB/EeMAB24UK6fJXgWjhz/zQFXjCzb/8dUK+
         K7bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691145779; x=1691750579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOJqrwX6eBicRAoTwudqPPw7DL3KcgjyNYI7qHOK9jg=;
        b=kiAv4mQ+U59fKro/NoSoILRaZhWIKIV49UAe9z/7tHbiflFhMq8GKdqOiuW6Dv00fS
         /isnR7th/yNgahT1GPiHqmHKxQxRJiMVAKS5/04+PwsONPu5Ggp/gclb4xuAHR0bdoh8
         GOgzTIaroB8tI+FrJfloIU7Z4HgwN0op5wPYYAaMKo8SUWvM6rOodIxgSzooQpuBV/6/
         /70580T4oK9prTuJA3BxUXpqkRJdCjC2e6L9+VAnQJH1lPhqaxVbtIHhSCdpU7GRYobJ
         2oubqrSW1QSIP+5lA0AV6xeoyO0AGNEsERGHnaKLWtfOAga4GK6K7o1i/swP/joF+hvr
         gdzg==
X-Gm-Message-State: AOJu0YzQiwic9bT9xZOjvr5rNQcpB/p7upHXBRG8OjRzfo7SKDx2wdr5
        MgZbFNy+g8dpqW+2FGKAat30A0HfYjjeq6htElOMXQ==
X-Google-Smtp-Source: AGHT+IFrBg8TcAuKoTvcaWHA2QYZfg6pTqYF4x1vjZo0zej0AbfU2Xw2p0Mm2/elqdxoiA0GmcgX0loLYmVkvwMJ9XE=
X-Received: by 2002:ac8:5902:0:b0:403:b6ff:c0b with SMTP id
 2-20020ac85902000000b00403b6ff0c0bmr186859qty.6.1691145779225; Fri, 04 Aug
 2023 03:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <202308041649468563730@zte.com.cn>
In-Reply-To: <202308041649468563730@zte.com.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 4 Aug 2023 12:42:48 +0200
Message-ID: <CANn89i+FTKRkgVodoQaCXH632rXx04AEe2_dJkqPiCEdtG0zQA@mail.gmail.com>
Subject: Re: [PATCH] udp_tunnel_nic: add net device refcount tracker
To:     yang.yang29@zte.com.cn
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 10:50=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> Add net device refcount tracker to udp_tunnel_nic.c.
>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
> ---
>  net/ipv4/udp_tunnel_nic.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/udp_tunnel_nic.c b/net/ipv4/udp_tunnel_nic.c
> index 029219749785..ce8f5c82b0a1 100644
> --- a/net/ipv4/udp_tunnel_nic.c
> +++ b/net/ipv4/udp_tunnel_nic.c
> @@ -55,6 +55,9 @@ struct udp_tunnel_nic {
>   */
>  static struct workqueue_struct *udp_tunnel_nic_workqueue;
>
> +/* To track netdev_hold and netdev_put */
> +static netdevice_tracker udp_tunnel_nic_devtracker;

This looks wrong.

> +
>  static const char *udp_tunnel_nic_tunnel_type_name(unsigned int type)
>  {
>         switch (type) {
> @@ -825,7 +828,7 @@ static int udp_tunnel_nic_register(struct net_device =
*dev)
>         }
>
>         utn->dev =3D dev;
> -       dev_hold(dev);
> +       netdev_hold(dev, &udp_tunnel_nic_devtracker, GFP_KERNEL);

This is wrong. You need a separate netdevice_tracker per netdev_hold()

For instance, this would need to be in "(struct udp_tunnel_nic)->dev_tracke=
r"


>         dev->udp_tunnel_nic =3D utn;
>
>         if (!(info->flags & UDP_TUNNEL_NIC_INFO_OPEN_ONLY))
> @@ -879,7 +882,7 @@ udp_tunnel_nic_unregister(struct net_device *dev, str=
uct udp_tunnel_nic *utn)
>         udp_tunnel_nic_free(utn);
>  release_dev:
>         dev->udp_tunnel_nic =3D NULL;
> -       dev_put(dev);
> +       netdev_put(dev, &udp_tunnel_nic_devtracker);
>  }
>
>  static int
> --
> 2.15.2
