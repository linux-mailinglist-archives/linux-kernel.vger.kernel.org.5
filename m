Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02457FDE89
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:39:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjK2Ri4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:38:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2Riy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:38:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B748FF4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:39:00 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54b0c368d98so12690a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701279539; x=1701884339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujQjK1ILR+2hLI6PlT06tIQvStPdR3UqqG1p8t5orBQ=;
        b=ro/PLRKkE8LWnXJks1ZNTl1ynGKa1l6+lyH3Rq2Q7wznfNbSHjozi+1i4V7kjOp5Ru
         GwphosNpDpSs6tBo+ou3GRA5nb8bvXilZkCzczVfFSyg+xJ0AgR+y/ZKZm+o7wZDP7U0
         /LALdwPSYeif02FY4l48R4wvfjMBeDKDX6cegYcqHOrPFow+Qh1CxAEiFs2qiO1inKA6
         iF37i4TooYRVR8EnJlXTMKegTbVRrISULSwM4BYt1NhjZDvQClqwpj4QawPWyJn4yPkG
         b0Ydr0PWjsyinbLzXeWWMJG5KuGFGYs0JvCKQy9r4SZZMuX/V8sb8S353gJ5rRJZOWYJ
         XE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701279539; x=1701884339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujQjK1ILR+2hLI6PlT06tIQvStPdR3UqqG1p8t5orBQ=;
        b=wbqzmgA4MJ7Y9nUqUAB8j6j37PVZIVfq3hkXEZeJNnLpbry5dLffXdn3bNp9gJiCwc
         Et3IbMNn3dZcM9LA7FmiFma8aZctIAAPJVSD/FYpwf9Ixr0g0K3+fanXVS/Q4DvJiFpi
         ESI6lOJon42OyJKnF8siKWg/h4jilwCyVpt1LpP+XAOh00ZnJUh3S9c9DnRCV9AqiIqV
         LZ4GsUJfnvdSq99Je9yiP7OZlG+Zu28A6dWQ4JbCRvWlJhcoPiy+zSvugYqv4/s7JKaU
         Yxai46gtOueJtDDw59TtHeO05TaGJ2PKTOFykuRvZySKZ/OF9WtYeum81F/9w5vVsUtW
         n5zQ==
X-Gm-Message-State: AOJu0YyZsd6J4dDrd7akJrwpwcL8xsVlk84Zim/N/J//vW1DlsNUvZRk
        lWKIVODkoGv0fgj3c0ovP3JgC4IC39Wrez9v90YyPw==
X-Google-Smtp-Source: AGHT+IHx4n14Y0RUSfoYhS/h78Pu9QPJUaL5NPKWAuMAIy41gkXMgUXTd60p842ZCzc7mCUvwN651yAGwkDia4bXWqU=
X-Received: by 2002:a05:6402:540a:b0:545:279:d075 with SMTP id
 ev10-20020a056402540a00b005450279d075mr1069425edb.1.1701279539029; Wed, 29
 Nov 2023 09:38:59 -0800 (PST)
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-4-dima@arista.com>
In-Reply-To: <20231129165721.337302-4-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 18:38:45 +0100
Message-ID: <CANn89iKXEmdz6HTGuMs_02=0e0q7LfLPE7hMovwhQa46=j36gQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
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

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Listen socket is not an established TCP connection, so
> setsockopt(TCP_AO_REPAIR) doesn't have any impact.
>
> Restrict this uAPI for listen sockets.
>
> Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
