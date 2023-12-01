Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5055800698
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbjLAJKP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:10:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjLAJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:10:14 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D489A12A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:10:18 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54c52baaa59so5018a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701421817; x=1702026617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kw0R1IIry/oGs15Umww96Xqt0mM/p6UWTCuyWlkeb9Y=;
        b=q4K0dUSh3w8QQibbWbfK98RVLkHIWDUm0ekqC8AWVUP6BXk4zwUOvZWVeCS61xMTXr
         HWfBEE6Oi/mWaZSEDT/MGMWxwtX3XPtG1eaQbikcboQwqbItWFT+N/jjoXtQzd69XNhC
         lCx9enLGLD/UxJbZaPJw6VAwFVSYCHGSPlJyhjjlZc/7tcf/AR1tN379JHr/TGEjJdJm
         Qf5FwYc+KzQeAYPkPjh6e02rEM8h9keW7pdEBNOwzBYhn2zQkjOS2fNIzGA+PmJp9mwP
         nOquSwZp3mm4GiuDHN00G2qiR0T/teBx/8aUN+GzOkTHjlcScN+Ef4cbQbxXqGM5UvMN
         HiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701421817; x=1702026617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kw0R1IIry/oGs15Umww96Xqt0mM/p6UWTCuyWlkeb9Y=;
        b=uAYV/AjUQ0qPLBVO7RZ3rV8UkwKSpLpQg4E1bDWRw5KWMQfSZWwisIp6oqAJZRIjbU
         5s+SY5LKwW0PojFy+560ty8NuZWj+SBtri7/RX5ZOKzPdxfdQOwFe95QjfmTA05gxcN6
         eCIcZVFk0CHpfXrXI7Ye+ZomHjEXpGV6xz4iahfAx6lPtHwjhqkf9xynYktdLfTIMqcV
         SEdGNzfA2yx/R25wJhaC3uBkhGGdWZweUyz49XvWUOrU9jO5wERAPuyntERNEqkX6DJ2
         ObS0qxXsuFBj5QTEgx2SCjyk5bf/qujIABOlIj9F6lIJzgPF4w8nGqyxH+ndxEKSrH7F
         /hfw==
X-Gm-Message-State: AOJu0YzanUV9Z4ynBqkI09ECtJkhRdGmYe1KVUqJf1hYLBS8m9jCydDQ
        R4uwCjX9pWFMz6ovCE8T0gTDjRqgoS+dMfuJkShxmA==
X-Google-Smtp-Source: AGHT+IExbRrWsp/ALGMSgBAjAOP8RAHd/kQdgaIgWgrQColA+WI75KYK5BOYWUTq2i3Pbl9xQdJ0dUtK+Dp8pi1e3BU=
X-Received: by 2002:a50:d49c:0:b0:543:fb17:1a8 with SMTP id
 s28-20020a50d49c000000b00543fb1701a8mr47255edi.3.1701421817064; Fri, 01 Dec
 2023 01:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
In-Reply-To: <20231201083926.1817394-1-judyhsiao@chromium.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 1 Dec 2023 10:10:03 +0100
Message-ID: <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To:     Judy Hsiao <judyhsiao@chromium.org>
Cc:     David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
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

On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromium.org> =
wrote:
>
> We are seeing cases where neigh_cleanup_and_release() is called by
> neigh_forced_gc() many times in a row with preemption turned off.
> When running on a low powered CPU at a low CPU frequency, this has
> been measured to keep preemption off for ~10 ms. That's not great on a
> system with HZ=3D1000 which expects tasks to be able to schedule in
> with ~1ms latency.

This will not work in general, because this code runs with BH blocked.

jiffies will stay untouched for many more ms on systems with only one CPU.

I would rather not rely on jiffies here but ktime_get_ns() [1]

Also if we break the loop based on time, we might be unable to purge
the last elements in gc_list.
We might need to use a second list to make sure to cycle over all
elements eventually.


[1]
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6e75d23ef=
09bb4b0db53b4
100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
 {
        int max_clean =3D atomic_read(&tbl->gc_entries) -
                        READ_ONCE(tbl->gc_thresh2);
+       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
        unsigned long tref =3D jiffies - 5 * HZ;
        struct neighbour *n, *tmp;
        int shrunk =3D 0;
+       int loop =3D 0;

        NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);

@@ -279,10 +281,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
                        if (shrunk >=3D max_clean)
                                break;
                }
+               if (++loop =3D=3D 16) {
+                       if (ktime_get_ns() > tmax)
+                               goto unlock;
+                       loop =3D 0;
+               }
        }

        WRITE_ONCE(tbl->last_flush, jiffies);

+unlock:
        write_unlock_bh(&tbl->lock);

        return shrunk;
