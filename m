Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40ABD7FDEF8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjK2R72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2R71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:59:27 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C1595
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:59:33 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so554a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 09:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701280772; x=1701885572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/jSiKm5mFkB2ZNc7YYsPmOJjp6MJIABZm4Gv8dPzkk=;
        b=PH46EBt/ap/QWNe506pDAOitZBC8BKClHJLixqd45kpMk+oeWEcx3AXcfvfFjxRJC+
         ptbVAWs5mI+ugyVbBm9ILXXTbFbSx2NF6OP5WxFWSpuj+tsZopqj6sYB3qdNIJeZwtJr
         Z1gLUAQYms0/WClHZQZzdt2L5+r0vLt+hac/iwJrYD1YZbumJhSOewhyADdHfcwVtLbV
         eHfz5lvUSVjvWmWZiIfzda6g1dSPK7s7odMzF36gJvPvU1om9RqfuyChZdnnJnisSGp+
         rW76K2BjwAAWsfCq+eYQITl5P5h65pGrZEzDO786+jmdfhhIwhtBEyv5RH0Ve9vduH02
         iwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701280772; x=1701885572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/jSiKm5mFkB2ZNc7YYsPmOJjp6MJIABZm4Gv8dPzkk=;
        b=X4gJUE/xvISqcztOgT8C6TbEmdOC3IiVDLsZXcaZ72qjVsEqeb6vREJNcze9Vvrwo/
         5CQ84e0H2whufbpsbOKKnaKHYbV8BekI8cTyaJapmPkP3xkLySSamxDGNNaxYVsKYMDJ
         KIN8LPIq3TK8Pzf2kTo/Odbczc+RDuLO0jfKmuP2oWd9IlpbLOTiyTXmnEdm1ER4wV5k
         5P/MWA1ugCCcnr4OdPXzJgc6INSIMuv2FSo9F4ze2NT7pzmMPRrSZ1g7yjiZTVr/Czfv
         hNpWZagJfspReOvMDkPeC6clsKncKqn3OKuiQuCQOmutTxbA8gufVo3KPIx2Tg90tK7f
         /U3Q==
X-Gm-Message-State: AOJu0YxzhS80bf9bY/q+9giz+7t2BhLVLkMsUCPKRxtcLqrQrArSif0Q
        C0exjzP+qnWfKWWXVXkKR51tAcQM0aiYz6bsxhd/Ng==
X-Google-Smtp-Source: AGHT+IFubBI3AdUyh37+c03u4Vq4LdQHkQzxaQl5Tp48/hIuT++8ht4v/IrYluW4g2LWpq9S4266Hf8CDfRrNFtOrTY=
X-Received: by 2002:a05:6402:430e:b0:54b:67da:b2f with SMTP id
 m14-20020a056402430e00b0054b67da0b2fmr632179edc.7.1701280771486; Wed, 29 Nov
 2023 09:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-6-dima@arista.com>
In-Reply-To: <20231129165721.337302-6-dima@arista.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 29 Nov 2023 18:59:20 +0100
Message-ID: <CANn89iLLsTUu1k0pBDYNX8LX0z+JGr12OaC-zu94WcR8WbErUA@mail.gmail.com>
Subject: Re: [PATCH v4 5/7] net/tcp: Don't add key with non-matching VRF on
 connected sockets
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> If the connection was established, don't allow adding TCP-AO keys that
> don't match the peer. Currently, there are checks for ip-address
> matching, but L3 index check is missing. Add it to restrict userspace
> shooting itself somewhere.
>
> Yet, nothing restricts the CAP_NET_RAW user from trying to shoot
> themselves by performing setsockopt(SO_BINDTODEVICE) or
> setsockopt(SO_BINDTOIFINDEX) over an established TCP-AO connection.
> So, this is just "minimum effort" to potentially save someone's
> debugging time, rather than a full restriction on doing weird things.
>
> Fixes: 248411b8cb89 ("net/tcp: Wire up l3index to TCP-AO")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
