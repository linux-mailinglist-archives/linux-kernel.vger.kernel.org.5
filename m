Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2527A9DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjIUTp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjIUTpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:45:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A8CD8AB7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:09:11 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-414ba610766so73311cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695323350; x=1695928150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLlJX9huq9ej0iAVLAlYlRkGYLAh3a+BqLGjUG3BDUo=;
        b=gCwpbrpBnjCkHBljVLlGxCiWkWTVNtBSPV5VAb4PvGI0wTP+FzNG5/5rlRqC7DGYpP
         K2u62JW4+rzn8B5xgUrxbiQqz7lc0tCRJ6dKspc8RbRc+C1NJakVwfT6gNPnB08ybSYn
         +TLEhhvBgZ2JHcje25VDiNg8OQXf1nP5qo9I4wQKFXbfU8UqHH4CnunyEy7qwUoSUFhT
         CA8QzHunt3xwPX67pd9DED3sK8OOboRag0sSTj2XnYeIKGGs3EwXmnS80mmUvytKo2Az
         nlB3WVKseGQWKOs7pKcZz37g3sBt0kqkyXhy5tPHvwhW6didaGgqLqXKjkbIAenneVSg
         FEtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695323350; x=1695928150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLlJX9huq9ej0iAVLAlYlRkGYLAh3a+BqLGjUG3BDUo=;
        b=wh/FH//NiYlLwklswYZeN5Ufo5V3BrR+pNem4CfnGBwHc2ugBRG46hH1I7m7WF0q/e
         YJRncBhM6QGJGOn+fAWgIukziGHLVAqsDybvp3Zpt1hVgu/MKqXCY+DjK82KruRpLIbl
         Ue/IzD/9unVgBqtVXvx+FRPDZqfZUVos6k0yXQ+3A66OBUgpFDGYtDfFtloFtGUat6aW
         BvsyCgmqI89/J4kH2v/q+lGCDrA0eBJQ7qSCYLiHc+xptsBWtpHq+6fIUZL4HRJvYzZe
         YTrJRKJilADQZb7it+otoRrDYCbV2HwHAlz6AmOh3rXR2gkCledLVm+6wgq7oo8eMYqa
         ZJXw==
X-Gm-Message-State: AOJu0YzZUcxegE7ty7M82xXB0vUEjRn+v+7/sQxuXU1u9mht/JkHgYzb
        r8uX+pZUcZXqOMFq14PUYjiFrT2lx6IRIuO45J6/QQ==
X-Google-Smtp-Source: AGHT+IFaC8NIJjQt0QoTmTynybk6RbTtja9Lkkg5vf8GHyAoht+PdhqbPUUlFvAA29EGIPq5KyWh7IwVg+3+0xP7sCA=
X-Received: by 2002:a05:622a:24b:b0:410:9855:ac6 with SMTP id
 c11-20020a05622a024b00b0041098550ac6mr333593qtx.14.1695323349892; Thu, 21 Sep
 2023 12:09:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230921190429.1970766-1-i.maximets@ovn.org>
In-Reply-To: <20230921190429.1970766-1-i.maximets@ovn.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 21 Sep 2023 21:08:58 +0200
Message-ID: <CANn89iJeAFBKF=5=VjO4pZWT0-o5GrTZhZvDD4OGBt5U27P+LA@mail.gmail.com>
Subject: Re: [PATCH net-next] openvswitch: reduce stack usage in do_execute_actions
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        dev@openvswitch.org, Pravin B Shelar <pshelar@ovn.org>,
        Eelco Chaudron <echaudro@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 21, 2023 at 9:03=E2=80=AFPM Ilya Maximets <i.maximets@ovn.org> =
wrote:
>
> do_execute_actions() function can be called recursively multiple
> times while executing actions that require pipeline forking or
> recirculations.  It may also be re-entered multiple times if the packet
> leaves openvswitch module and re-enters it through a different port.
>
> Currently, there is a 256-byte array allocated on stack in this
> function that is supposed to hold NSH header.  Compilers tend to
> pre-allocate that space right at the beginning of the function:
>
>      a88:       48 81 ec b0 01 00 00    sub    $0x1b0,%rsp
>
> NSH is not a very common protocol, but the space is allocated on every
> recursive call or re-entry multiplying the wasted stack space.
>
> Move the stack allocation to push_nsh() function that is only used
> if NSH actions are actually present.  push_nsh() is also a simple
> function without a possibility for re-entry, so the stack is returned
> right away.
>
> With this change the preallocated space is reduced by 256 B per call:
>
>      b18:       48 81 ec b0 00 00 00    sub    $0xb0,%rsp
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  net/openvswitch/actions.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index 5f8094acd056..80cc5c512d7b 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -312,10 +312,16 @@ static int push_eth(struct sk_buff *skb, struct sw_=
flow_key *key,
>  }
>
>  static int push_nsh(struct sk_buff *skb, struct sw_flow_key *key,
> -                   const struct nshhdr *nh)
> +                   const struct nlattr *a)

Presumably this function should be inlined. (one caller only)

I would add noinline_for_stack to make sure the compiler will not play
games with this attempt.

>  {
> +       u8 buffer[NSH_HDR_MAX_LEN];
> +       struct nshhdr *nh =3D (struct nshhdr *)buffer;
>         int err;
>
> +       err =3D nsh_hdr_from_nlattr(a, nh, NSH_HDR_MAX_LEN);
> +       if (err)
> +               return err;
> +
>         err =3D nsh_push(skb, nh);
>         if (err)
>                 return err;
> @@ -1439,17 +1445,9 @@ static int do_execute_actions(struct datapath *dp,=
 struct sk_buff *skb,
>                         err =3D pop_eth(skb, key);
>                         break;
>
> -               case OVS_ACTION_ATTR_PUSH_NSH: {
> -                       u8 buffer[NSH_HDR_MAX_LEN];
> -                       struct nshhdr *nh =3D (struct nshhdr *)buffer;
> -
> -                       err =3D nsh_hdr_from_nlattr(nla_data(a), nh,
> -                                                 NSH_HDR_MAX_LEN);
> -                       if (unlikely(err))
> -                               break;
> -                       err =3D push_nsh(skb, key, nh);
> +               case OVS_ACTION_ATTR_PUSH_NSH:
> +                       err =3D push_nsh(skb, key, nla_data(a));
>                         break;
> -               }
>
>                 case OVS_ACTION_ATTR_POP_NSH:
>                         err =3D pop_nsh(skb, key);
> --
> 2.41.0
>
