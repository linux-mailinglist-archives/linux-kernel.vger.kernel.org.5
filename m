Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE887558A5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGPXXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 19:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPXXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 19:23:49 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EBEDF;
        Sun, 16 Jul 2023 16:23:48 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1b03ec2015fso2583171fac.3;
        Sun, 16 Jul 2023 16:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689549828; x=1692141828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4yytGRS+CQEs/+jmTTJDYXQvpm4WXNvWJVJlTlZI5mA=;
        b=Crx1m28LQXNW6sUjuoefYItFZqB17pkTPm4jxOJjC/vduKQ4vJq4DX/dX/hOiodeXn
         rVU9GFQE/MoJnHzyLc0tYbZ6kWDrUfFS8XuWrEXnNb4mIsUj8QFGfXiZRHkomSb0v+YC
         PCACzzF38jeoebqIwspeCnv/Bzg7sSso3LjyGuzo0vnvgFfVExjqSZH6QJ/8FmWy5tNd
         7XIj8Kmh7yLSl9WbmJ1MKuFuDLR8QVIUgaBx8yxiJUYk5EwOE8S9cGV7cwfrIPBZUy4E
         AwG+JQ+7eRKzm43HRCuH9KPhkj68LhW+lz9+hqajI9N0qgpLuisJcbX515J3jGng3uMn
         uSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689549828; x=1692141828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4yytGRS+CQEs/+jmTTJDYXQvpm4WXNvWJVJlTlZI5mA=;
        b=AbZXLguK1rizV0RTIS79ssLVIepQ0WBeqUSvJabodrQiM9UhT2DT+b556Wh/aVmWva
         pQlP64L7oP9ssA6nUwligSfBnxuiHqRb1EWw1zaCu45h3UCtcxrJOk5fKlcMX8UUXeoK
         n7PftjN8/12d2MaN4OWlX1fb43Np4ADjOTEbvPkkDwdocQuXwqz85WePXMtfukRhWPMY
         NV3V4qOpKBpoth+zxmE1/TkoJthPNl8P8RdAI6G/yynymCW7EEy6apgy3TWH4pffhRWE
         7jmshT2YYHhWzAZqYU4QUOMxLhHryZJhQWoPaI121usZNfAVZlQ6heJQatUOM8yxdw3S
         S5ZQ==
X-Gm-Message-State: ABy/qLb5t6cM4H9gWpLwE3ZTb+uN1KipuGk7J0UdHn8si3IJxkk0v6qV
        wROIMvUCq0vbGo5uLZoOHRAB65DsgfJiyxe6Nxo=
X-Google-Smtp-Source: APBJJlGZ7YeKMy93BxUuY4vsM9u1/SiDFU1/qhK9def0dOjmsTNnvyjS6Y4fygTqj7MniyyvAjIT55RHZAHzOsiqRZo=
X-Received: by 2002:a05:6808:f87:b0:3a0:6949:c884 with SMTP id
 o7-20020a0568080f8700b003a06949c884mr10602961oiw.34.1689549827645; Sun, 16
 Jul 2023 16:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <a35a5881c3280bd7a4fd1943a8b40b890e3bf280.1689316697.git.jamie.bainbridge@gmail.com>
 <30997.1689374702@famine>
In-Reply-To: <30997.1689374702@famine>
From:   Jamie Bainbridge <jamie.bainbridge@gmail.com>
Date:   Mon, 17 Jul 2023 09:23:36 +1000
Message-ID: <CAAvyFNgzqQgG7BEMd69h572ORtVqg_TuSND44sH20F6VTAk9tQ@mail.gmail.com>
Subject: Re: [PATCH] tcp: Add memory pressure flag to sockstat
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jul 2023 at 08:45, Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jamie Bainbridge <jamie.bainbridge@gmail.com> wrote:
>
> >When tuning a system it can be helpful to know whether the protocol is
> >in memory pressure state or not. This can be determined by corresponding
> >the number of pages in "net.ipv4.tcp_mem" with the current allocation,
> >but a global variable already tracks this as the source of truth.
> >
> >Expose that variable in sockstat where other protocol memory usage is
> >already reported.
> >
> >Add "pressure" which is 0 in normal state and 1 under pressure:
> >
> > # grep TCP /proc/net/sockstat
> > TCP: inuse 5 orphan 0 tw 0 alloc 7 mem 1 pressure 0
> >
> > # grep TCP /proc/net/sockstat
> > TCP: inuse 5 orphan 0 tw 0 alloc 7 mem 1 pressure 1
>
>         Isn't this already available in /proc/net/protocols?
>
> protocol  size sockets  memory press maxhdr  slab module     cl co di ac io in de sh ss gs se re sp bi br ha uh gp em
> [...]
> UDP       1472      7       6   NI       0   yes  kernel      y  y  y  n  y  y  y  n  y  y  y  y  y  n  n  y  y  y  n
> TCP       2512      5       1   no     320   yes  kernel      y  y  y  y  y  y  y  y  y  y  y  y  y  n  y  y  y  y  y

I was not aware of this, I was only looking for symbol usage of TCP
and not the generic.

This is perfect, thank you very much!

Jamie

> >Tested by writing a large value to global variable tcp_memory_pressure
> >(it usually stores jiffies when memory pressure was entered) and not
> >just by code review or editing example output.
> >
> >Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
> >---
> > net/ipv4/proc.c | 7 ++++---
> > 1 file changed, 4 insertions(+), 3 deletions(-)
> >
> >diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> >index eaf1d3113b62f7dc93fdc7b7c4041140ac63bf69..f4c5ced2de49d5c6d7f5d7ccdaa76c89dcf8c932 100644
> >--- a/net/ipv4/proc.c
> >+++ b/net/ipv4/proc.c
> >@@ -51,16 +51,17 @@
> > static int sockstat_seq_show(struct seq_file *seq, void *v)
> > {
> >       struct net *net = seq->private;
> >-      int orphans, sockets;
> >+      int orphans, sockets, tcp_pressure;
> >
> >       orphans = tcp_orphan_count_sum();
> >       sockets = proto_sockets_allocated_sum_positive(&tcp_prot);
> >+      tcp_pressure = READ_ONCE(tcp_memory_pressure) ? 1 : 0;
> >
> >       socket_seq_show(seq);
> >-      seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %ld\n",
> >+      seq_printf(seq, "TCP: inuse %d orphan %d tw %d alloc %d mem %ld pressure %d\n",
> >                  sock_prot_inuse_get(net, &tcp_prot), orphans,
> >                  refcount_read(&net->ipv4.tcp_death_row.tw_refcount) - 1,
> >-                 sockets, proto_memory_allocated(&tcp_prot));
> >+                 sockets, proto_memory_allocated(&tcp_prot), tcp_pressure);
> >       seq_printf(seq, "UDP: inuse %d mem %ld\n",
> >                  sock_prot_inuse_get(net, &udp_prot),
> >                  proto_memory_allocated(&udp_prot));
> >--
> >2.41.0
> >
> >
>
> ---
>         -Jay Vosburgh, jay.vosburgh@canonical.com
