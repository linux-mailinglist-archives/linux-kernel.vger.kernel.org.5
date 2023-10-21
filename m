Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034397D1DC8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjJUPFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjJUPFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:05:36 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E00E7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:05:30 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9b70b9671so84545ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 08:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697900730; x=1698505530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8KjYiWmBScABIuDtiMMncZnICHnoOPuW6DFu0n03Co=;
        b=SDlIfAu3s6+n8hsKGnhmsqC8Br5Oyt13S1ImxgsR2tqN/MNMJB1vC633Vm3HhS1io1
         aUuoH+7k+uQ0R2FrFTejqwmL6Qhx+Av8ZCaF6Zvt6tiTUc8RR1G3LjR2B410BHSekSnc
         6Lej37Yce3nzEJACeUN7NSKOEoBM3bHvmr8xc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697900730; x=1698505530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8KjYiWmBScABIuDtiMMncZnICHnoOPuW6DFu0n03Co=;
        b=vlYxXeUsVGQJ05JNjNjD8y8xVYlbmudjEomP9FJzEvL2rvfFus1C/FTX4SZe+4GAoO
         qXWR+ier17dBPLvAyZKnDWnI1Dyt1wKgxGdMkeZoU8iYsEXxYxTexKhAm/+jlGz27X7Q
         cbt4mLcK6SiP/WiUA7eZL549lrLi3+GoRrwYHQhFLAoJYTNsUWDDK2t57igDSTdRIj7A
         bcCv7LvTQg/EFijdhxZixU5j5ltxd9UWLcqcZA261BPdUgMraS0mUd/uV4FUloVNEWeb
         NNhePQQ2fyOnBUPllf4Inri9kiUhnQODXV0MbNlyhmL8/w3SJ7CgxvoGuaIRf2Abx6vm
         o87A==
X-Gm-Message-State: AOJu0YxRN9Yzii7UtQvgyj7dAVFTjrQM09EKV3ZDTRx4h/VcROyCwEgQ
        fkTW7xinb36Xt8WeyUDX3lDm/qP3sALhXr8ZWyeKFQ==
X-Google-Smtp-Source: AGHT+IFZM53rLwdSL4zLJjFCgja09RLXFY4PbcwJmF4VO64lGjKNAOvBSbN9z57Vmt/saKmcBQTSDgpDDrsTUJkcJPI=
X-Received: by 2002:a17:902:f70d:b0:1c9:c480:1797 with SMTP id
 h13-20020a170902f70d00b001c9c4801797mr383690plo.11.1697900729915; Sat, 21 Oct
 2023 08:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20231020210751.3415723-1-dianders@chromium.org> <20231020140655.v5.6.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
In-Reply-To: <20231020140655.v5.6.I6405b1587446c157c6d6263957571f2b11f330a7@changeid>
From:   Grant Grundler <grundler@chromium.org>
Date:   Sat, 21 Oct 2023 08:05:18 -0700
Message-ID: <CANEJEGudwc1=f69L5TAB4+Bdv0aa+y6BQCfLwoDgQ8dizx2=5A@mail.gmail.com>
Subject: Re: [PATCH v5 6/8] r8152: Check for unplug in r8153b_ups_en() / r8153c_ups_en()
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>,
        "David S . Miller" <davem@davemloft.net>,
        Edward Hill <ecgh@chromium.org>,
        Laura Nao <laura.nao@collabora.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Simon Horman <horms@kernel.org>, linux-usb@vger.kernel.org,
        Grant Grundler <grundler@chromium.org>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 2:08=E2=80=AFPM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> If the adapter is unplugged while we're looping in r8153b_ups_en() /
> r8153c_ups_en() we could end up looping for 10 seconds (20 ms * 500
> loops). Add code similar to what's done in other places in the driver
> to check for unplug and bail.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Grant Grundler <grundler@chromium.org>

> ---
>
> (no changes since v2)
>
> Changes in v2:
> - ("Check for unplug in r8153b_ups_en() / r8153c_ups_en()") new for v2.
>
>  drivers/net/usb/r8152.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 9888bc43e903..982f9ca03e7a 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -3663,6 +3663,8 @@ static void r8153b_ups_en(struct r8152 *tp, bool en=
able)
>                         int i;
>
>                         for (i =3D 0; i < 500; i++) {
> +                               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +                                       return;
>                                 if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_B=
OOT_CTRL) &
>                                     AUTOLOAD_DONE)
>                                         break;
> @@ -3703,6 +3705,8 @@ static void r8153c_ups_en(struct r8152 *tp, bool en=
able)
>                         int i;
>
>                         for (i =3D 0; i < 500; i++) {
> +                               if (test_bit(RTL8152_UNPLUG, &tp->flags))
> +                                       return;
>                                 if (ocp_read_word(tp, MCU_TYPE_PLA, PLA_B=
OOT_CTRL) &
>                                     AUTOLOAD_DONE)
>                                         break;
> --
> 2.42.0.758.gaed0368e0e-goog
>
