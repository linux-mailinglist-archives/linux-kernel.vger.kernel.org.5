Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D516C7E9586
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbjKMD3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbjKMD3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:29:09 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC72F171B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:29:05 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7ba6a0bada9so1467262241.2
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699846145; x=1700450945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2dGyXj5qPWx8L/oD7d/kJ2B1kSBzAWVgjHl9+VbT5g=;
        b=CSrHsh9BqDX/+zONieAXevR7NLb18gQCuO78q5RU/ltdr9vQOM6ranCrMqhyi32jaL
         s2UzxX2G44i/g9AwnqRS7KMooFi8rKcU407idcCYkgZgfyIaHJXjIViF1Vf6QgXBhLXp
         TAFJPZ3A5m0olNiegRJtM4hoU/mm7At7ggx1gOSdH2+fi+NDLdLpauJljnDMQBkOHVbg
         l3Q0iMNuJn+Ciz9hUm+CN0g31WPchNENDrmiOz29CF7d1aAI4Os1ZmfxJMukV+0rx6GG
         33ED0ficMpON3UfmQaf2mWdIaNurZPD2uU4wSUJVQ03HqG3Nvg3A5DDiVjVZp5HvN++k
         aJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699846145; x=1700450945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2dGyXj5qPWx8L/oD7d/kJ2B1kSBzAWVgjHl9+VbT5g=;
        b=C+N7c4ftJQvOhJITM8SqKejZ1huV3W9uXUmR2qHxYUjcx6b7pOktStT6nwPLfkzFmL
         FL/8q1DAHkAbmuygL42yDMjGAVGbTwyyQqF3DdnyI/tJGF3dQ/lHQtUmEVA9VOIGtTv5
         KnEFxDchjaq7NbXgiMzZ1XCy9ss+y89ehnJ+C4Yq+b+6T7evYaYqVyid3Jiwn33Iaslp
         2D5YfgROWNek+udQh840Nd2qlg4+gnMZ+vXk/gVDqPKUUabeJV+ezZXnCp9NIpLRkj6B
         bn79AGZgTW9pMzBr81TeYDQ5oe/dP2c+YoiePwVoAZxTS2G9jH+S6poiB682qdNggS0i
         TthA==
X-Gm-Message-State: AOJu0YyzvsVClSLvuTu6xHM8nJUrWoCsFTkhjCHPInRdqqTxrQPOeSpF
        jNEyX9WpMaagmqYpUiZYO87n/t4bYcI1U3AA1tKg+w==
X-Google-Smtp-Source: AGHT+IHF2Jct5wlvc5iEDA5CXatiC4I+LjFNu9wrknK+tB6gu0XrkZJBw+kq39swHZW/DhuGkGJI2Nhu4+A/S+uBIBE=
X-Received: by 2002:a05:6102:23cd:b0:45d:989b:da4a with SMTP id
 x13-20020a05610223cd00b0045d989bda4amr4899045vsr.22.1699846144896; Sun, 12
 Nov 2023 19:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-3-almasrymina@google.com> <20231110151907.023c61cd@kernel.org>
In-Reply-To: <20231110151907.023c61cd@kernel.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Sun, 12 Nov 2023 19:28:52 -0800
Message-ID: <CAHS8izPKRh7ukRytXaweKcY_76sE7F_3s1sYVgsUXYGrypK93Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 02/12] net: page_pool: create hooks for custom page providers
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>
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

On Fri, Nov 10, 2023 at 3:19=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun,  5 Nov 2023 18:44:01 -0800 Mina Almasry wrote:
> > diff --git a/include/net/page_pool/types.h b/include/net/page_pool/type=
s.h
> > index 6fc5134095ed..d4bea053bb7e 100644
> > --- a/include/net/page_pool/types.h
> > +++ b/include/net/page_pool/types.h
> > @@ -60,6 +60,8 @@ struct page_pool_params {
> >       int             nid;
> >       struct device   *dev;
> >       struct napi_struct *napi;
> > +     u8              memory_provider;
> > +     void            *mp_priv;
> >       enum dma_data_direction dma_dir;
> >       unsigned int    max_len;
> >       unsigned int    offset;
>
> you should rebase on top of net-next
>
> More importantly I was expecting those fields to be gone from params.
> The fact that the page pool is configured to a specific provider
> should be fully transparent to the driver, driver should just tell
> the core what queue its creating the pool from and if there's a dmabuf
> bound for that queue - out pops a pp backed by the dmabuf.
>

My issue with this is that if the driver doesn't support dmabuf then
the driver will accidentally use the pp backed by the dmabuf, allocate
a page from it, then call page_address() on it or something, and
crash.

Currently I avoid that by having the driver be responsible for picking
up the dmabuf from the netdev_rx_queue and giving it to the page pool.
What would be the appropriate way to check for driver support in the
netlink API? Perhaps adding something to ndo_features_check?

--=20
Thanks,
Mina
