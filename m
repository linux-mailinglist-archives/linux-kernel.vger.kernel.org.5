Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CA976AE9D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233345AbjHAJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjHAJjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 05:39:54 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3059319BD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 02:37:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbd33a1819so48505e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690882659; x=1691487459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3M62lzMT5M72GxSXvEGzGefCfJz1y5FFBC42WxQiRug=;
        b=Vb8cFPoJb2P0ZwPLqiNLSgQaAng02a45/GY4JR1Pxif45PUI+o75l36LyoVfmsACr7
         Ka2pa1g2ANFFVJ1g1nbyNcVuo1VXmwhCrC5n9y7/PpD10hn/VwNgY4/Bta3E+ioc8sUD
         rb/O6ElNeClwTaU6dhtthc29U+Y+xlZbokIoeoOhNiQ16FJ/QgUuIqGmqAJEvxXfD8Go
         lW9x26DElmw/Yu1UJWK3yjYPczwlvFH0LxvpvlnYkBRtRy0/pe4Y41uDlnhU67dyPI7C
         HVZFDlduORA2AAJevm8Vb+nhwFP0kMfG8X+BfVjJzFDGJa4a3oeYvHZjOhwX385/Hasx
         Jggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690882659; x=1691487459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3M62lzMT5M72GxSXvEGzGefCfJz1y5FFBC42WxQiRug=;
        b=BPpwZzDr7z7yqpkzK+hCdIqxS9w0NVpiERt/QlQ62sghNEB9Jigk0sYjxHP9VG8Q//
         kUWLsWikHXIu1+s2Je4d9c2IIDUnxxpodc25A5YvQs3tlarV7FHaFQBggjtfO1SqJq8f
         vmGyI/dv4CFAgHfHgr1TQ83AXc3EbGy2oqVeVk6H/wnSi1ZLOdPoW6MJgXGjAvTefAxh
         NxlzXEMtcANAT3ATUcAmLZ/OUMfzz2Xaco7TS5E2AZFuBU9P9YLE5yt6wQTRu+vbIz4z
         NTJPz0xYHChi/GU5tRHDnZsAudKxmONerBrGWuq68wcm/9OWA9gXyIYoidSCAPG8M6oL
         ScVw==
X-Gm-Message-State: ABy/qLZJrYVQ4cmD4q7ZTTcRTT85TwIxJRN/IardFx2pUI55dHPGN42v
        Dwou+7qgrJm6sDBilpg6aetp5Pp0CBgPOJwT7COclg==
X-Google-Smtp-Source: APBJJlH4ZnN9CuymbZd5SjWQ7VukNUlycKzANvGo/BKrgrjAwCHW6tOHt810QbdF94ncNyVp96NaRDmZnIwYqTfw9Ng=
X-Received: by 2002:a05:600c:1c90:b0:3f1:6fe9:4a95 with SMTP id
 k16-20020a05600c1c9000b003f16fe94a95mr239758wms.4.1690882659519; Tue, 01 Aug
 2023 02:37:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230731230736.109216-1-trdgn@amazon.com>
In-Reply-To: <20230731230736.109216-1-trdgn@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 1 Aug 2023 11:37:27 +0200
Message-ID: <CANn89iLV0iEeQy19wn+Vfmhpgr6srVpf3L+oBvuDyLRQXfoMug@mail.gmail.com>
Subject: Re: [PATCH v2] tun: avoid high-order page allocation for packet header
To:     Tahsin Erdogan <trdgn@amazon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 1, 2023 at 1:07=E2=80=AFAM Tahsin Erdogan <trdgn@amazon.com> wr=
ote:
>
> When GSO is not enabled and a packet is transmitted via writev(), all
> payload is treated as header which requires a contiguous memory allocatio=
n.
> This allocation request is harder to satisfy, and may even fail if there =
is
> enough fragmentation.
>
> Note that sendmsg() code path limits the linear copy length, so this chan=
ge
> makes writev() and sendmsg() more consistent.
>
> Signed-off-by: Tahsin Erdogan <trdgn@amazon.com>
> ---

I will have to tweak one existing packetdrill test, nothing major.

Tested-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
