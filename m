Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717E2781114
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378848AbjHRQ5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378841AbjHRQ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:57:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C79A3A8B
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:57:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5254f9eda36so1447741a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692377831; x=1692982631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsyKfMya3T2IG5CsphBG2f1KZVRfw1A44jYZYuUf32w=;
        b=OSdk3FCzOMhI/OH7Tx/fJFVN5dScVuA5+lhY8Dc6KTAzM4L5hXxr6R/t/iwM+s+RFY
         maDf4UXSEsRxmrgqNcb81xU3eXxOknhsm05Gle6GtYgOVq4kW22Ca9olD1KVqEQEGjBU
         SmVjGgqXpugx1FudR52ylhevyrJnGveMBDoVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692377831; x=1692982631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsyKfMya3T2IG5CsphBG2f1KZVRfw1A44jYZYuUf32w=;
        b=c2zFfyGFtRiNOmVEzbSDxPZ8nsNLnyZYwnK7Nna/ZjUxU9kQgwsLas41pJiPUq32dQ
         8osvAKHI4VcTCfa4YfZCzfPZRS6Sb0+edqij8sY12auXWJD5UndJUf//n47h1onIKlMu
         Mp1bPGb6nuM8+mrkyQvsZGPcv+9YwxWHrVKuSwcj0euh3FHbGIt6FV3GKMB88bpWMBld
         Lx6d+Ka/p8G43al6Qd07j4SHEgfd9vYXU7zlrZHqIVcZjh2HMUPsaY1HQIzVq4wWeU4t
         bR1Xc/XEYP/3s4br+pxM2oJa+Wm/pDN2zUtI8tlKNybjV3r+u+Yjyr9tExpVMZHuUg7f
         oVVQ==
X-Gm-Message-State: AOJu0Yx8FIl2SOWL+a/WCADqzqHbXthO+SHtpT9euOhH62t035MLmpxn
        yc1+xT53IO4QYC3AxLK+6tUILYYBRoXwp31DjjT2vg==
X-Google-Smtp-Source: AGHT+IHuOU5N11Lk5NSSYlDBPWcuphNEBeKr4AafLZ//Dqr/oS4Z1OLTqRF+Ba0oQRXzsmr48VWP6veE7DkGlw9yygo=
X-Received: by 2002:aa7:c58c:0:b0:522:2a0c:d254 with SMTP id
 g12-20020aa7c58c000000b005222a0cd254mr2605082edq.33.1692377830908; Fri, 18
 Aug 2023 09:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org> <20230817131612.M_wwTr7m@linutronix.de>
 <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com> <20230818145734.OgLYhPh1@linutronix.de>
In-Reply-To: <20230818145734.OgLYhPh1@linutronix.de>
From:   Yan Zhai <yan@cloudflare.com>
Date:   Fri, 18 Aug 2023 11:56:59 -0500
Message-ID: <CAO3-Pbr4u8+UsmmN+kHF4Yv+-THAnUxSgROLyK3Tvjb9W5gHZQ@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 9:57=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2023-08-18 09:43:08 [-0500], Yan Zhai wrote:
> > > Looking at the cloudflare ppl here in the thread, I doubt they use
> > > backlog but have proper NAPI so they might not need this.
> > >
> > Cloudflare does have backlog usage. On some veths we have to turn GRO
>
> Oh. Okay.
>
> > off to cope with multi-layer encapsulation, and there is also no XDP
> > attached on these interfaces, thus the backlog is used. There are also
> > other usage of backlog, tuntap, loopback and bpf-redirect ingress.
> > Frankly speaking, making a NAPI instance "threaded" itself is not a
> > concern. We have threaded NAPI running on some veth for quite a while,
> > and it performs pretty well. The concern, if any, would be the
> > maturity of new code. I am happy to help derisk with some lab tests
> > and dogfooding if generic agreement is reached to proceed with this
> > idea.
>
> If you have threaded NAPI for veth then you wouldn't be affected by this
> code. However, if you _are_ affected by this and you use veth it would
> be helpful to figure out if you have problems as of net-next and if this
> helps or makes it worse.
>
yes we are still impacted on non-NAPI veths and other scenarios. But
net-next sounds good, still plenty of time to evaluate if it has any
negative impact.

Yan

> As of now Jakub isn't eager to have it and my testing/ convincing is
> quite limited. If nobody else yells that something like that would be
> helpful I would simply go and convince PeterZ/tglx to apply 2/2 of this
> series.
>
> > Yan
>
> Sebastian
