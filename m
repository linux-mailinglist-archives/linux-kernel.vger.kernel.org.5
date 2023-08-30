Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE2578E0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240072AbjH3Unt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbjH3Unb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:43:31 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72FAC59CA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:32:31 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99bf3f59905so3467066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693427183; x=1694031983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=41hvAPL8iDSd2F9dx5AwXqTXvkVERKd19eESU0aBFm0=;
        b=eelMkT38Kunnc0lxEOs9wE2IgOpg06pLSYgpBb1hVs/TpoJogTz7jPzF7sYeffe5vj
         UuE8j7LxJ9BUTR7s0Uhh47wi1GbWaUoJdcfVbeUe43kUYZmuQ7HPuBDb7PD2x4iUzSbi
         FspONGA9WrdBIGEbDiQjvtxNhTTqXe8MnvkwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427183; x=1694031983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=41hvAPL8iDSd2F9dx5AwXqTXvkVERKd19eESU0aBFm0=;
        b=JLK4+72f9BcbdeYmbKQAnkMM03MxB3yW3EY9KUJz1hXkUOPW85osERR4sFVZOSOlhC
         tRd0oBUEZ9qLgNG+6nQ/BSbdq0QfWWY1scna1AZXbvUEAyB4zZA7Twp7aQZgFbbaRz+P
         WMkS222NX4+8btMo2JjAG1iX5zamVaislbHDbIYj67uXkjW4zBZDWk4D3nbX9wkGX4lo
         z+wPHv5JO0TxOI3SfQfSO8w0zAK7b1xpHqowu5JdkVJvFazLKYKRfn5i8CENDc6HhhuU
         PNZp2UAsNay3BH3d3Aru/wVkRuKyiPRj62zAQ+QRl1tMjU2W1nMRwlr1XehDmpJ0YMjL
         QCyQ==
X-Gm-Message-State: AOJu0YyBLld0n+LS6Tl4H54hT4mb3BwJJHBj+t5I6Iwv64wzrQcXBvGn
        iarXSt53YdOiZI03Zf2DrMOW/GgvawljnCzp4URk0cgZ
X-Google-Smtp-Source: AGHT+IGTNU/FRauQ7PN7ccol3ArHop3oKSgsxq6+1g6sH472+bA7iHZc1+5XZGmjVQYvE2vru1afUQ==
X-Received: by 2002:aa7:cd7a:0:b0:525:4d3d:c6ba with SMTP id ca26-20020aa7cd7a000000b005254d3dc6bamr2634392edb.37.1693425198773;
        Wed, 30 Aug 2023 12:53:18 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id ay25-20020a056402203900b0052576969ef8sm7137903edb.14.2023.08.30.12.53.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 12:53:18 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso1185e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 12:53:18 -0700 (PDT)
X-Received: by 2002:a05:600c:3d89:b0:400:46db:1bf2 with SMTP id
 bi9-20020a05600c3d8900b0040046db1bf2mr31256wmb.2.1693425197923; Wed, 30 Aug
 2023 12:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230830170819.309269-1-biju.das.jz@bp.renesas.com> <20230830170819.309269-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230830170819.309269-4-biju.das.jz@bp.renesas.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 12:53:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=ULqAZ=7ArRmoeY_=V7mYOhZK1UeJrPPJ8X1LmrATD_vw@mail.gmail.com>
Message-ID: <CAD=FV=ULqAZ=7ArRmoeY_=V7mYOhZK1UeJrPPJ8X1LmrATD_vw@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] drm/bridge/analogix/anx78xx: Drop conditionals
 around of_node pointers
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Zhu Wang <wangzhu9@huawei.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 30, 2023 at 10:08=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.c=
om> wrote:
>
> Having conditional around the of_node pointers turns out to make driver
> code use ugly #ifdef and #if blocks. So drop the conditionals.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v5:
>  * Split from patch#2
> ---
>  drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

My current plan, assuming no objections, will be to apply all 3
patches to drm-misc-next in about a week. I'd also be fine if someone
else wanted to apply then. ;-)
