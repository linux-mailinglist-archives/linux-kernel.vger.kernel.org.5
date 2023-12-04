Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC5E803EE4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbjLDUBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjLDUBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:01:07 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC77CD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:01:13 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-54c79cca895so2559a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 12:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701720071; x=1702324871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4qUKdBMoTlxHYFiskzAv8nyrsjpTSREfKpRVBZmhZs=;
        b=Th5CH+blKchcjlPg5H0iQyaw1E0Dc6XFMO2YZGfDy/gegzdrJV9MY8HsyBFSbVjkWz
         xIvwuBOxwzs4NCh1XZsISIxN6XSp/hwQ/yNkKH5ZzIa3P6OqFmKeR0AXsH81/VticX6q
         ebKskBIOZYmDj2stBTe5yvR/Df2u2U2Y+5fZJ7ekCrll2c7pFe1xnMSB7NeEfFBC9a+i
         CxcNx2DzT5xhZ/0dpNcALRJUAspvjlEto6HOiYiVy3NZtfIz9vVRo5Qn8rDv2Qjc6uzG
         51g4/5VW6vzAeY0+VWfJD+bJe6RMgYiZB2YcDn+IGedSlNmdGSHpBdlJAJY1fWjaSJAk
         9Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701720071; x=1702324871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4qUKdBMoTlxHYFiskzAv8nyrsjpTSREfKpRVBZmhZs=;
        b=EJkZSUfq2/wGjYI3H6u6FSPLMfTXxYfhXdC3u/pPlWuJlzqocvKrdS8QGxv21qU9YC
         nx5p0vB+nkSABKTgKlwlJIhn0/S/6ZhPxzAfNn8aaKhJR9sGNkI5Cy7oT+J7vu2cCYIF
         NPmsf4eF/QZBDM7RG4esYgofq72SHWwrCh0vZmxeWZFT79Cm4ksJ3a2jl46XVpw0omzH
         tR876qw4nA28vY1DPzln8aZ9b/rictzcnTYmXIAgOAecv/inQ7zsdQUfffDmhajIptqb
         hEmbKk/so5x0AHa+A25w6XJHe0x7h494RlXnX2YFOnVhelkmH9bs/5pm3MxZHMYJsboR
         STIQ==
X-Gm-Message-State: AOJu0YwlOsNt5mPF2NqGnHb2TmOBjW/spkjGpzrtdmy4sPfU+3IExsN5
        26pkOaHbv6vn48KFuppGeAPBc8ZURudF0St/4llefA==
X-Google-Smtp-Source: AGHT+IGCev6DWYvqpogCA90ucI81NLgaEa0nJpCTgU96onBY6t9QMetZ9gl1hjVPETCRlrC77Ev8Q3QIKkavLVKHwOQ=
X-Received: by 2002:a50:99de:0:b0:54a:ee8b:7a99 with SMTP id
 n30-20020a5099de000000b0054aee8b7a99mr332954edb.0.1701720071324; Mon, 04 Dec
 2023 12:01:11 -0800 (PST)
MIME-Version: 1.0
References: <ZW4piNbx3IenYnuw@debian.debian>
In-Reply-To: <ZW4piNbx3IenYnuw@debian.debian>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 4 Dec 2023 21:01:00 +0100
Message-ID: <CANn89iLww-JGAuyD4XFvpn1gy52hgHQwHE1o-UvHu6sU3-6ygw@mail.gmail.com>
Subject: Re: [PATCH v4 net-next] packet: add a generic drop reason for receive
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@cloudflare.com,
        Jesper Brouer <jesper@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 8:33=E2=80=AFPM Yan Zhai <yan@cloudflare.com> wrote:
>
> Commit da37845fdce2 ("packet: uses kfree_skb() for errors.") switches
> from consume_skb to kfree_skb to improve error handling. However, this
> could bring a lot of noises when we monitor real packet drops in
> kfree_skb[1], because in tpacket_rcv or packet_rcv only packet clones
> can be freed, not actual packets.
>
> Adding a generic drop reason to allow distinguish these "clone drops".
>
> [1]: https://lore.kernel.org/netdev/CABWYdi00L+O30Q=3DZah28QwZ_5RU-xcxLFU=
K2Zj08A8MrLk9jzg@mail.gmail.com/
> Fixes: da37845fdce2 ("packet: uses kfree_skb() for errors.")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
