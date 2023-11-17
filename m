Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF1E7EF6F5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbjKQR31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKQR30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:29:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0508890
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:29:23 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40837124e1cso95135e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 09:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700242161; x=1700846961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNX5vSn4trFssKgOhtnpJClEAgcyxOvOwHdl3OyYifg=;
        b=KBqn4DQsWEAbn271fd2Xx0QfbuuF6nlpMdCjEHyP8CKuga5GQhnzq2kRgVdYBGDSVG
         OVO/Waqp6LGymP6q2qrQnOyeq8MQR2LReI3NxYueBQFY991U0eJnzOr/wBeDvJPKLtaE
         kheSEzsaG8CxZNECYtI4+8ZH5pCDvnuAKQTsaJv/C9p5sKAXH0UrwVlVXjV54NugzxAL
         7c4KCZ/1DWItqFWSwunBbkP+6L5RIF2aa1GsS8lrjlypeIVpILNLki47C8x+bxHbzOu1
         OLKqR4SMqnXOdmxOHVXp+EsuRds+H+nwjL+uqyY1IL3YHB0vsrDRJ6ARE8jOsr20sAxp
         LqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700242161; x=1700846961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNX5vSn4trFssKgOhtnpJClEAgcyxOvOwHdl3OyYifg=;
        b=I6+Ax2tavdC10JGSuqrlOGLU9IjADm4kbe94L/+zqFOsRSyuroCiMfDnTdV7GkkGLs
         7iVhPdZ4UknUhX92uH+NpBSh8s7hVErekDuWcjmYP+NsJvIYOq5NaIqWKkVM718yEIRY
         WyjTk/EAZC2/jekTuG7dgGomTzR0bosNp00nFT3Sk64xaxyIOHmuODqUcf/2rCE4KTh8
         EnIcqTmu2x9eMn5eCLHK5ApdegoXa3CbL5JPgXSFPQ6K659p3kro9rCXGPO8Q4/uHzDq
         nI0HrTyrDPichge3DODNBZ35i4k31CNezMxYf5BMqHDkTEvmRDek0B3DV1dGmeWGlTPj
         sVwQ==
X-Gm-Message-State: AOJu0YyU3hjYyrnT1e83OPi8hMiZtMgJnrp4wiLcNOn7gRokAHnPR0Qc
        EcrmDIcnAR7uYsMG2AfiDM0cKD0xuDj6Ag1ZoXi1dw==
X-Google-Smtp-Source: AGHT+IHZqKyWH2HNr9y7AtGf0eJxIce50Dug2CDO7QDkXuoh+B16qm3v+4PTfiSFawj5mE80S2Hn3+GdWACHh3DVNfs=
X-Received: by 2002:a05:6402:c41:b0:544:e249:be8f with SMTP id
 cs1-20020a0564020c4100b00544e249be8fmr14129edb.1.1700242161208; Fri, 17 Nov
 2023 09:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20231117154831.2518110-1-chentao@kylinos.cn>
In-Reply-To: <20231117154831.2518110-1-chentao@kylinos.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 17 Nov 2023 18:29:10 +0100
Message-ID: <CANn89iKJ=Na2hWGv9Dau36Ojivt-icnd1BRgke033Z=a+E9Wcw@mail.gmail.com>
Subject: Re: [PATCH] ipv6: Correct/silence an endian warning in ip6_multipath_l3_keys
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        pabeni@redhat.com, kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 6:06=E2=80=AFPM Kunwu Chan <chentao@kylinos.cn> wro=
te:
>
> net/ipv6/route.c:2332:39: warning: incorrect type in assignment (differen=
t base types)
> net/ipv6/route.c:2332:39:    expected unsigned int [usertype] flow_label
> net/ipv6/route.c:2332:39:    got restricted __be32
>
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Same remark, we need a Fixes: tag

> ---
>  net/ipv6/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index b132feae3393..692c811eb786 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2329,7 +2329,7 @@ static void ip6_multipath_l3_keys(const struct sk_b=
uff *skb,
>         } else {
>                 keys->addrs.v6addrs.src =3D key_iph->saddr;
>                 keys->addrs.v6addrs.dst =3D key_iph->daddr;
> -               keys->tags.flow_label =3D ip6_flowlabel(key_iph);
> +               keys->tags.flow_label =3D be32_to_cpu(ip6_flowlabel(key_i=
ph));
>                 keys->basic.ip_proto =3D key_iph->nexthdr;
>         }

This is not consistent with line 2541 doing:

hash_keys.tags.flow_label =3D (__force u32)flowi6_get_flowlabel(fl6);
