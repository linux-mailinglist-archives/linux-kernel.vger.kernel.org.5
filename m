Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD47CA48C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbjJPJx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjJPJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:53:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D69AD;
        Mon, 16 Oct 2023 02:53:25 -0700 (PDT)
Date:   Mon, 16 Oct 2023 11:53:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697450003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZwQf1eErlCBg5WbOcq8pGfvcWHlytZnteUJdOl47Zg=;
        b=iekvbj8nVBgBKHp54JDJ2zdV2IRrA92G5gtS46afyKZUREHU8rn/OLoYpqleDGokq+RxCH
        6K3uRMFn2cxMzHOMARpqpWW4ZT0ggN9PbFzHZDz1BImwRdKTUTXlwqpQeAd5v0Ls/cBBTb
        cOIX8e0ScosNFsXHkpdhjVZ2pxPVw9mgFA2xP+K7EMf2ryRUezN3EW+1edGwZ8wh0th4QP
        cBi47q7LL3o/MeuIs9SzzEtfIsEQBDV9OqhKPMWsx1YqmvpXi3CmlGIpM1pLljm6lkG4uN
        bzc7lZ9kVVnlqy+WjHEbFdSyk5WbOH015rhgyH4Hr7ld8gKklpf5VtHEP3bMYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697450003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZwQf1eErlCBg5WbOcq8pGfvcWHlytZnteUJdOl47Zg=;
        b=31v1lpj1/2JCjhus7e1WwxJik7R7Wh0QYy/24EY//Rdz6CtSoqh+TG7t2rP0cQjaZ2PEVT
        rLodbOX8XIga3yBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wander Lairson Costa <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231016095321.4xzKQ5Cd@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
 <20231004154609.6007f1a0@kernel.org>
 <20231007155957.aPo0ImuG@linutronix.de>
 <20231009180937.2afdc4c1@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231009180937.2afdc4c1@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, getting back that late, I was traveling the last two weeks=E2=80=A6

On 2023-10-09 18:09:37 [-0700], Jakub Kicinski wrote:
> On Sat, 7 Oct 2023 17:59:57 +0200 Sebastian Andrzej Siewior wrote:
> > Apologies if I misunderstood. You said to make it optional which I did
> > with the static key in the second patch of this series. The first patch
> > is indeed not what we talked about I just to show what it would look
> > like now that there is no "delay" for backlog-NAPI on the local CPU.
> >=20
> > If the optional part is okay then I can repost only that patch against
> > current net-next.
>=20
> Do we have reason to believe nobody uses RPS?

Not sure what you relate to. I would assume that RPS is used in general
on actual devices and not on loopback where backlog is used. But it is
just an assumption.
The performance drop, which I observed with RPS and stress-ng --udp, is
within the same range with threads and IPIs (based on memory). I can
re-run the test and provide actual numbers if you want.

Sebastian
