Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 315B2756980
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjGQQrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGQQrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:47:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7053CB3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:47:09 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40371070eb7so3231cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689612428; x=1692204428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+e3D526DKZcQ2/LAze/ywkjnh9HvcdhsT43CIzyhYY=;
        b=7e7AHSmKQjlPgGKaHQMt+n0aS+VVfmzs90QReaDQ30pWE3QbgvP4dlI/Eq6qWlom3Q
         tgsW7dq6VqsVnuMLzpC8HXpF6wS+Il45ekw6QnKdbZGn73Q7eC8/Yh5eD4nvIwav25k0
         YwOK6reB2bI0Y0MYUtSJ/3wNBcYbxZjtYl77R6rmYbgESIxXVNYbIJp4/9xZco/ph3Z3
         1xDkRJ7QPr6Fa+6zMY8s8mkIcRogUQTKMcJ07Y8d5d7u/ReENB0jfz9bAFol9ZrdAaHu
         0buWWeiD1Cvhwv2tcdjUP+4ZnYf/SgoRf9Rv7C8mTDJ9tYZGgzFtOaxKX7CzP9FWFygB
         24gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689612428; x=1692204428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+e3D526DKZcQ2/LAze/ywkjnh9HvcdhsT43CIzyhYY=;
        b=QEFRfGvIdo++/y9mN9x9F1fOKRYgD1JHd67MHFDWllQaL/hejJAuOMuYKhgvbuEv7l
         oLuLqtnL9ckpxqZao5QL5OXmdYJRVFt2c9VXwAQz7uX+UrLLK59XBOP1LUH50ULHqLa9
         Gpe4KvXVe8CriK+T9SYS1p0WT/nDYzuvpWCDkSznBce0fW6gIhdbA297cSyl2aSVeMAT
         eo9iKx6GavL7ruqFpzdl+sTQQcqQrstai/g93bsIVu01oVL6M8wOG0H/S8+71C2/brb7
         WqdpUD1DwUQsJ48uFR9np3I0zBvyTkFWMLI9xkif4hgEhAIQ9tKqPQ5EOszBg53O5U+T
         nV/w==
X-Gm-Message-State: ABy/qLbtXlnLHLCch7s61dxdDpiQ+CCZ6/MjthfSxsx0ztPBD7KCYoKn
        STP02tzgkPJGi2g6wq2cfi+lX5VUclMHwDoe7jgQ8Q==
X-Google-Smtp-Source: APBJJlGQHhjBTJOyR4ALML7m1VsuAIj3b+ZyvPRhX6Gs6PxHm6xVz7ix159HwbDQ9XiLkj/CyDwHvjJeQtoFD0rzAw0=
X-Received: by 2002:ac8:5b44:0:b0:403:96e3:4745 with SMTP id
 n4-20020ac85b44000000b0040396e34745mr1459522qtw.20.1689612428412; Mon, 17 Jul
 2023 09:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230713112404.2022373-1-imagedong@tencent.com>
In-Reply-To: <20230713112404.2022373-1-imagedong@tencent.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 17 Jul 2023 18:46:57 +0200
Message-ID: <CANn89iJMzChaDsB+bPAuCEDUHVApsYs8KtD3oEC+oU_Qvi1KvQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: tcp: support to probe tcp receiver OOM
To:     menglong8.dong@gmail.com
Cc:     ncardwell@google.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, dsahern@kernel.org,
        kuniyu@amazon.com, morleyd@google.com, imagedong@tencent.com,
        mfreemon@cloudflare.com, mubashirq@google.com,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Thu, Jul 13, 2023 at 1:24=E2=80=AFPM <menglong8.dong@gmail.com> wrote:
>
> From: Menglong Dong <imagedong@tencent.com>
>
> For now, skb will be dropped directly if rmem schedule fails, which means
> tcp_try_rmem_schedule() returns an error. This can happen on following
> cases:
>
> 1. The total memory allocated for TCP protocol is up to tcp_mem[2], and
>    the receive queue of the tcp socket is not empty.
> 2. The receive buffer of the tcp socket is full, which can happen on smal=
l
>    packet cases.
>
> If the user hangs and doesn't take away the packet in the receive queue
> with recv() or read() for a long time, the sender will keep
> retransmitting until timeout, and the tcp connection will break.
>
> In order to handle such case, we introduce the tcp protocol OOM detection
> in following steps, as Neal Cardwell suggested:
>

For the record, I dislike this patch. I am not sure what Neal had in mind.

I suggested instead to send an ACK RWIN 0, whenever we were under
extreme memory pressure,
and we only could queue one skb in the receive queue.

For details, look at the points we call sk_forced_mem_schedule().
This would be a matter of refactoring code around it, in tcp_data_queue()

The patch would be much simpler. Nothing changed at the sender side :/
