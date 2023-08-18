Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0BF1780E36
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377871AbjHROoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377931AbjHROnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:43:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA43449C
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:43:24 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-525bd0b2b48so1325197a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692369799; x=1692974599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI9ZQNzqe2W46MHEhQwh22zo1t4+PZrthdWYrt5Eodk=;
        b=lEMPxIe+SwoHD55SXzQjuumUhef+DSOxSuOl1NMigACxe7Fg/k3ximhHk8R6euFctL
         IyoPPpthixM/I7MHvOYNCpOkoLqCUtO7i1hcUhfODapb+9f6k7yxgqYUGs0JfQRTaJLh
         sS3oPKGwyjYTm00C1bsylGOGmAGyetzYzE578=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692369799; x=1692974599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dI9ZQNzqe2W46MHEhQwh22zo1t4+PZrthdWYrt5Eodk=;
        b=C6BFUlR+n2bud1ePlWrvaXePaT2UsZXj//OHTVVU0clst2oeklXVTSB6aVNcfmIx4F
         TjZeQrVn9Dssf6UW1eDxyEFR9NZNAQ5OhBBtiZu1k16f4TrTricq+EDYwhO42tFhld3a
         WqED1FivWQpDoKZCaSSnvRAQ2QSb+IVUdmLNkqy4Yc0/koJglH0EFBtbvBfTRzZREq19
         6NVNKlxPNBzpp+ruiyFmvEA0ioPsr324/l823cz4g9swnqjKGpjD9cfB6JXFhWrqULg5
         mFLCqUKuGrFWMcTM1dqsz8+O/PQmPDjxQz8XCsr5MC8bPt6xAKOUuzQoabwjxRgCiUUC
         4Vqw==
X-Gm-Message-State: AOJu0YwsJRVuIKps3R4wqCqBDKTEqkIa4bbY22ki0X2rsvAoCASnGIm2
        xR/RzYX58ab6dcY1wm7aEgtLEKvcezSBLMBd/9Qt21gw4BVhaePHp60=
X-Google-Smtp-Source: AGHT+IErHdVC7BYjFNhSlGtL/JSumk+79LBrrHCwUljiKbscXCNIYXKYIf9tkkXe3Ol1yvp/wSfzQfcwKfD1l4TAlaU=
X-Received: by 2002:aa7:d742:0:b0:525:45dc:40b7 with SMTP id
 a2-20020aa7d742000000b0052545dc40b7mr2170575eds.17.1692369799061; Fri, 18 Aug
 2023 07:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org> <20230817131612.M_wwTr7m@linutronix.de>
In-Reply-To: <20230817131612.M_wwTr7m@linutronix.de>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 18 Aug 2023 09:43:08 -0500
Message-ID: <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 8:16=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-08-14 11:24:21 [-0700], Jakub Kicinski wrote:
> > On Mon, 14 Aug 2023 11:35:26 +0200 Sebastian Andrzej Siewior wrote:
> > > The RPS code and "deferred skb free" both send IPI/ function call
> > > to a remote CPU in which a softirq is raised. This leads to a warning=
 on
> > > PREEMPT_RT because raising softiqrs from function call led to undesir=
ed
> > > behaviour in the past. I had duct tape in RT for the "deferred skb fr=
ee"
> > > and Wander Lairson Costa reported the RPS case.
> >
> > Could you find a less invasive solution?
> > backlog is used by veth =3D=3D most containerized environments.
> > This change has a very high risk of regression for a lot of people.
>
> Looking at the cloudflare ppl here in the thread, I doubt they use
> backlog but have proper NAPI so they might not need this.
>
Cloudflare does have backlog usage. On some veths we have to turn GRO
off to cope with multi-layer encapsulation, and there is also no XDP
attached on these interfaces, thus the backlog is used. There are also
other usage of backlog, tuntap, loopback and bpf-redirect ingress.
Frankly speaking, making a NAPI instance "threaded" itself is not a
concern. We have threaded NAPI running on some veth for quite a while,
and it performs pretty well. The concern, if any, would be the
maturity of new code. I am happy to help derisk with some lab tests
and dogfooding if generic agreement is reached to proceed with this
idea.

Yan

> There is no threaded NAPI for backlog and RPS. This was suggested as the
> mitigation for the highload/ DoS case. Can this become a problem or
> - backlog is used only by old drivers so they can move to proper NAPI if
>   it becomes a problem.
> - RPS spreads the load across multiple CPUs so it unlikely to become a
>   problem.
>
> Making this either optional in general or mandatory for threaded
> interrupts or PREEMPT_RT will probably not make the maintenance of this
> code any simpler.
>
> I've been looking at veth. In the xdp case it has its own NAPI instance.
> In the non-xdp it uses backlog. This should be called from
> ndo_start_xmit and user's write() so BH is off and interrupts are
> enabled at this point and it should be kind of rate-limited. Couldn't we
> bypass backlog in this case and deliver the packet directly to the
> stack?
>
> Sebastian



--=20

Yan
