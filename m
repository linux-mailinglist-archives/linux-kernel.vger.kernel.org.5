Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C259F7BC4CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 07:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343520AbjJGF3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 01:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjJGF3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 01:29:38 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3CABB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 22:29:37 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso5930a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696656576; x=1697261376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehXIAL9COr2p+SJpJYVkLUs7bLNsHpyoys6ti/OmwOI=;
        b=OiAMtXJ6tynmtPbNf0oVtLtakB4w672tZqGGFGc20uXHn8lXontrHzK4qP1tuSYiUH
         tLyVfpdQWpzYGzwjZLup748DMmHPLUY0ksXcxOjj6dbos+c/jnmf5EkjJbwz3Gu3KWHH
         AVIyMbQpxnTa7TxQTI48+P0ceptkAh4J9DuF5UzwMMQYVEa5StYB1tzsJPk89rOkYKit
         zMgtXb8LXQpzPCbwS5oZc+e3lFxRdXQIypFnvypgIbmnBl2YN8AGc6Rrt3m13xzJswBu
         6fCc/bjDt1sg5eUX7Eg1qQodtZkXA/rdY85AK+AP++rpClTfNPyuKDek3KS1PlhruFt+
         +NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696656576; x=1697261376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehXIAL9COr2p+SJpJYVkLUs7bLNsHpyoys6ti/OmwOI=;
        b=wI4Rip4wTe8HQ5vOeAjzfHfNxOeEf0HEPdbNXn2zY2sD3/8nRnI0WI7MObSmcjeBBX
         u9obmj3PDwVIJ3bzH++MDU4ilFwWrsJ/0AbyObkZNx6bh4eBVEfWri6SRbcnqbief3ap
         kFi8MlPuTayvtB7mJLnoAqJRQpzkpIJuwnDx/LH7blIW9NpfviD06OL0nWP+CTnK8rYe
         5iVAjJq1XeFN9cAkHcViy8BaG1gTdWuFNW4Z3Xm4J5+S95s0w1TQCx8kbuG4C6QT3RA+
         HvtDewuLrrc6pq8/4wfAfGnL9RM9OwShbf4ykHZBm2fSmtYugudGuQkZEgabfLJ6fFBI
         oyjw==
X-Gm-Message-State: AOJu0YzpSwht3aUHOyyXRDhsPnOJSJYXuZl7tjOF0ve++JXW8lEYyz6/
        bPqncjGrS5m6hpyqoBZZH+czI/RmVbDnFUkV21HNmg==
X-Google-Smtp-Source: AGHT+IE/hTkf8AkZ8ITlkwNVi2PQWbMg9VbCiFwnsi2YbVc9094IqpEkM9HeLWBd/UWOs4drgL5TpFtxUxnWyQHg7ME=
X-Received: by 2002:a50:bb67:0:b0:519:7d2:e256 with SMTP id
 y94-20020a50bb67000000b0051907d2e256mr268054ede.0.1696656575664; Fri, 06 Oct
 2023 22:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231007050621.1706331-1-yajun.deng@linux.dev>
In-Reply-To: <20231007050621.1706331-1-yajun.deng@linux.dev>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sat, 7 Oct 2023 07:29:24 +0200
Message-ID: <CANn89iL-zUw1FqjYRSC7BGB0hfQ5uKpJzUba3YFd--c=GdOoGg@mail.gmail.com>
Subject: Re: [PATCH net-next v7] net/core: Introduce netdev_core_stats_inc()
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 7:06=E2=80=AFAM Yajun Deng <yajun.deng@linux.dev> wr=
ote:
>
> Although there is a kfree_skb_reason() helper function that can be used t=
o
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>
...

> +
> +void netdev_core_stats_inc(struct net_device *dev, u32 offset)
> +{
> +       /* This READ_ONCE() pairs with the write in netdev_core_stats_all=
oc() */
> +       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_=
stats);
> +       unsigned long *field;
> +
> +       if (unlikely(!p))
> +               p =3D netdev_core_stats_alloc(dev);
> +
> +       if (p) {
> +               field =3D (unsigned long *)((void *)this_cpu_ptr(p) + off=
set);
> +               WRITE_ONCE(*field, READ_ONCE(*field) + 1);

This is broken...

As I explained earlier, dev_core_stats_xxxx(dev) can be called from
many different contexts:

1) process contexts, where preemption and migration are allowed.
2) interrupt contexts.

Adding WRITE_ONCE()/READ_ONCE() is not solving potential races.

I _think_ I already gave you how to deal with this ?

Please try instead:

+void netdev_core_stats_inc(struct net_device *dev, u32 offset)
+{
+       /* This READ_ONCE() pairs with the write in netdev_core_stats_alloc=
() */
+       struct net_device_core_stats __percpu *p =3D READ_ONCE(dev->core_st=
ats);
+       unsigned long __percpu *field;
+
+       if (unlikely(!p)) {
+               p =3D netdev_core_stats_alloc(dev);
+               if (!p)
+                       return;
+       }
+       field =3D (__force unsigned long __percpu *)((__force void *)p + of=
fset);
+       this_cpu_inc(*field);
+}
