Return-Path: <linux-kernel+bounces-79797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CB38626E2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 534701C20D05
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A090D481BD;
	Sat, 24 Feb 2024 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WhUedBj"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276E2907
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 19:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708801693; cv=none; b=rHK9elwCKSZTpmlGKhWtvAmyX2rNNgNK13oaQQLV/Tql1k71lDPcX41wN9sdqw1Na0FBTIe4QrmhibgpvH2hwO7dUPnkLcyrtN27ngyyoAPK1OguZQlFTjeVknNiRhevyQj5M/lgNoosncGtfMgdMJXHws1GucYm+6nbi+uYCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708801693; c=relaxed/simple;
	bh=ywTdtlsxaTGNOg/0ykAO9vIS5LDXi2sRHe/FWPBh5EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIOfjZMXNqO6+15m5WGUb+BwJco/93TByxRnR0wiEyoPpQkHWOuqWT2uaigIIB8Wah9vgKT+zsVuowv4CSkLtTELAupagint2WEBcJI8kY2mrrZs0qHNPlncoCtTL03/T8x/o0MVXBm+VyTI5dfQ2dSghdoWRKYBwTfxwOXjXPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WhUedBj; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso8129a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 11:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708801690; x=1709406490; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITGZMfMCrb1CACtG+hsG+yIMHew98TIZDUao5iyuYr0=;
        b=3WhUedBjqzEaV+GIc8Fo0weNfdmcJDXzJFnHJ/4JjZ99UIM9f8svwzDI0Os/HqaX61
         r5CHUYUXX1ETICr/sXoFFNfqb4EA/xA26FeLHoRbgTD+TjT0HgzsjpGXDsB0LWWEDuj0
         GeASO1S64GfNx7IXcYNanQTDbGE5+PVIwvP/xuq4rP9bn4L5ZE4LGCyegiINKlHBQNYo
         2SsDYAiDFAOWYXJURfgODaYQqlgmGEUdICcyPQssSZ46/AnD7pJZa6+ynMS0+6G9dcQU
         HRQT7RA4F+4qPYm9KIYtMS3k7U+WTya05JlbovrUQhVlKDCfolDQH1tvrq/zAy+OvM2y
         WqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708801690; x=1709406490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITGZMfMCrb1CACtG+hsG+yIMHew98TIZDUao5iyuYr0=;
        b=XUTuYLNuI8iEQasgr4bVyeH/OGhVNoIOjpnfikeX8HUxa8IOhx5dlNwlrtktmVulg2
         7KRt/926Zj3Jl3BvGzabTlxfXh0XyfVud8RcncLFzHoqowZ7aWXiRGXPg7gY+xTrPI8+
         ptgl4yB0hg2uKePzU66LXLMA8NGenl7etDwSrAlmxNaXdE8GkY6Z9HOgJelC3RgIU5OW
         wSqjtA5pcUBTDrDxxRSd3lx4dbQ2P1LLgAOoLNeOAI/5X0rWW1NmkrfJ9+8N3gPpbS7r
         UhAXgoJi0FC6UuWIEf4ZhJfJtHZ3GBPgLI/uL3r7ozWYDFL6MMGT0pQ7pFp6bJM0kM5+
         zERA==
X-Forwarded-Encrypted: i=1; AJvYcCWOZlY6sK7D/l3nECR9z4KycD4bIEuJ+Nf9F1kqJ5U9byqM/Z8uN4xu1SA7Vpq7nXMgwPPG2QAsj8MHUB31SaDIybmUerz2BVgWA0Nj
X-Gm-Message-State: AOJu0YzSIRJtMJnNpUeRxR3OMTzQ4HYG9BS5q9/2yZBiFRYl2KOIUejB
	C7/+fhqfqqyXlLi6xxJS1pLYEg2C0GEPZZ/K/PxoFW0jK+Artn5fw+tfKSagAPNiZfXUETOf5yT
	38Gwk7CidZNq7HttMkNx0AFPlqqKWdcvEmB2+
X-Google-Smtp-Source: AGHT+IH+MnlNwa+mKfnYWerJnvT+05mEc77N4U0sR7aT0piVfxvgGgL3543LPKu18wSlD+rtznF7C60YsTeC8sBQrKY=
X-Received: by 2002:a50:c355:0:b0:565:123a:ccec with SMTP id
 q21-20020a50c355000000b00565123accecmr139505edb.3.1708801689070; Sat, 24 Feb
 2024 11:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
 <CANn89i+1uMAL_025rNc3C1Ut-E5S8Nat6KhKEzcFeC1xxcFWaA@mail.gmail.com> <c2bd73b6-b21f-4ad8-a176-eec677bc6cf3@amperemail.onmicrosoft.com>
In-Reply-To: <c2bd73b6-b21f-4ad8-a176-eec677bc6cf3@amperemail.onmicrosoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 20:07:55 +0100
Message-ID: <CANn89i+Cr1Tbdxqy6fB-sOLca+AHFc-3-0xGktVUsQFFMVsC0A@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
	patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
	ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:37=E2=80=AFAM Shijie Huang
<shijie@amperemail.onmicrosoft.com> wrote:
>
>
> =E5=9C=A8 2024/2/20 16:17, Eric Dumazet =E5=86=99=E9=81=93:
> > On Tue, Feb 20, 2024 at 7:26=E2=80=AFAM Shijie Huang
> > <shijie@amperemail.onmicrosoft.com> wrote:
> >>
> >> =E5=9C=A8 2024/2/20 13:32, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Tue, Feb 20, 2024 at 3:18=E2=80=AFAM Huang Shijie
> >>> <shijie@os.amperecomputing.com> wrote:
> >>>> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
> >>>> it may creates fclone SKB in remote NUMA node.
> >>> This is intended (WAI)
> >> Okay. thanks a lot.
> >>
> >> It seems I should fix the issue in other code, not the networking.
> >>
> >>> What about the NUMA policies of the current thread ?
> >> We use "numactl -m 0" for memcached, the NUMA policy should allocate
> >> fclone in
> >>
> >> node 0, but we can see many fclones were allocated in node 1.
> >>
> >> We have enough memory to allocate these fclones in node 0.
> >>
> >>> Has NUMA_NO_NODE behavior changed recently?
> >> I guess not.
> >>> What means : "it may creates" ? Please be more specific.
> >> When we use the memcached for testing in NUMA, there are maybe 20% ~ 3=
0%
> >> fclones were allocated in
> >>
> >> remote NUMA node.
> > Interesting, how was it measured exactly ?
>
> I created a private patch to record the status for each fclone allocation=
.
>
>
> > Are you using SLUB or SLAB ?
>
> I think I use SLUB. (CONFIG_SLUB=3Dy,
> CONFIG_SLAB_MERGE_DEFAULT=3Dy,CONFIG_SLUB_CPU_PARTIAL=3Dy)
>

A similar issue comes from tx_action() calling __napi_kfree_skb() on
arbitrary skbs
including ones that were allocated on a different NUMA node.

This pollutes per-cpu caches with not optimally placed sk_buff :/

Although this should not impact fclones, __napi_kfree_skb() only ?

commit 15fad714be86eab13e7568fecaf475b2a9730d3e
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Mon Feb 8 13:15:04 2016 +0100

    net: bulk free SKBs that were delay free'ed due to IRQ context

What about :

diff --git a/net/core/dev.c b/net/core/dev.c
index c588808be77f563c429eb4a2eaee5c8062d99582..63165138c6f690e14520f11e32d=
c16f2845abad4
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5162,11 +5162,7 @@ static __latent_entropy void
net_tx_action(struct softirq_action *h)
                                trace_kfree_skb(skb, net_tx_action,
                                                get_kfree_skb_cb(skb)->reas=
on);

-                       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE)
-                               __kfree_skb(skb);
-                       else
-                               __napi_kfree_skb(skb,
-                                                get_kfree_skb_cb(skb)->rea=
son);
+                       __kfree_skb(skb);
                }
        }

