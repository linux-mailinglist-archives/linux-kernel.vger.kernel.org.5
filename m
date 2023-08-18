Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0E3780E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377918AbjHRO6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377832AbjHRO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72B63C20;
        Fri, 18 Aug 2023 07:57:39 -0700 (PDT)
Date:   Fri, 18 Aug 2023 16:57:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692370658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOwQQ0BPTC+PDHYiDUDtHcpcTB1NW9+8Ld9PAqkgYDE=;
        b=FNe5wH1BmMCD+MYpBezKbUNnxSJQwz+0juzDFjP1Ux27ZYt3zA95YnugM11pxLOdPuoL3p
        TReycNr5gM+zkPFkMeaRGaRGFDl/FoahCWrdnnFXjubbCSH/4QLxHZTuCCRKifFtPa3FjU
        YAvLbBjrFecDiL0ycfnLfBFQSXJ2onXzj6sq15KP6MmTNaIFQOKiZLY6eKMxyzh6QyoGMY
        fRRCFWIaHgibY0cBjHYHEEzT44P1wGzxk5izX0mm5SOWd081WZfbMZUKpzqYeAXSaP2bPg
        3k2Fk6KGq7Rr9cznBC8b5Eduma5I40oy7vHi1tvq8mk6tyHBPAs11c4mHJKTDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692370658;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mOwQQ0BPTC+PDHYiDUDtHcpcTB1NW9+8Ld9PAqkgYDE=;
        b=mlEiYqnAcq5FNW/cwFF73Qm56hxG4sEB5LfPKCvQS+VRaTzA9gk6QYzn8XkGWvISOlhFK8
        Fv4WpZNat8DP0TBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [RFC PATCH net-next 0/2] net: Use SMP threads for backlog NAPI.
Message-ID: <20230818145734.OgLYhPh1@linutronix.de>
References: <20230814093528.117342-1-bigeasy@linutronix.de>
 <20230814112421.5a2fa4f6@kernel.org>
 <20230817131612.M_wwTr7m@linutronix.de>
 <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO3-Pbo7q6Y-xzP=3f58Y3MyWT2Vruy6UhKiam2=mAKArxgMag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-18 09:43:08 [-0500], Yan Zhai wrote:
> > Looking at the cloudflare ppl here in the thread, I doubt they use
> > backlog but have proper NAPI so they might not need this.
> >
> Cloudflare does have backlog usage. On some veths we have to turn GRO

Oh. Okay.

> off to cope with multi-layer encapsulation, and there is also no XDP
> attached on these interfaces, thus the backlog is used. There are also
> other usage of backlog, tuntap, loopback and bpf-redirect ingress.
> Frankly speaking, making a NAPI instance "threaded" itself is not a
> concern. We have threaded NAPI running on some veth for quite a while,
> and it performs pretty well. The concern, if any, would be the
> maturity of new code. I am happy to help derisk with some lab tests
> and dogfooding if generic agreement is reached to proceed with this
> idea.

If you have threaded NAPI for veth then you wouldn't be affected by this
code. However, if you _are_ affected by this and you use veth it would
be helpful to figure out if you have problems as of net-next and if this
helps or makes it worse.

As of now Jakub isn't eager to have it and my testing/ convincing is
quite limited. If nobody else yells that something like that would be
helpful I would simply go and convince PeterZ/tglx to apply 2/2 of this
series.

> Yan

Sebastian
