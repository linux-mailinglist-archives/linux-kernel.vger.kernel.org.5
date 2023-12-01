Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168708005E2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 09:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377891AbjLAIih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 03:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377890AbjLAIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 03:38:31 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265B51713;
        Fri,  1 Dec 2023 00:38:36 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E4D562014F;
        Fri,  1 Dec 2023 16:38:29 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1701419911;
        bh=+KSs+S6XcLMSAulP0SuGmY2oifnKHSYDKmvztsfn43M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=V2jdfQrP6FJNnJhX557yHgaxcphbnWagtP61AzZRcHnwAuHr0u8+WR6znCpndlsdN
         p34DBEct2U1bFfiubxx5AzSQnwCNIPKqbBCP1VdA/DJnSvEYxKjTgZO6ITNqaWeMKW
         eqMlYPOGoVviI/IK4C66EdgPVBkqX3r1BAJb5fdlAXHpFtpbS3K6wDw2+vmztRJ/aH
         5MRTheUJIY8AuIUMMRGqrFhp5KBaVC9ZgoYo55nGImbRj4o4e+OaTZoWIiLJ9yVK5d
         kBl+3TYVHcOlt/n3P0J+QGkkWa2A7DLonMy7l34r53azZ5pvtCkGsuhDcBqo4yB35m
         U9gj+4RF0Eing==
Message-ID: <10491ca5819563f98e2f4414836fd4da0c84c753.camel@codeconstruct.com.au>
Subject: Re: [PATCH] mctp i2c: Requeue the packet when arbitration is lost
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Matt Johnston <matt@codeconstruct.com.au>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>
Cc:     Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>,
        Dung Cao <dung@os.amperecomputing.com>
Date:   Fri, 01 Dec 2023 16:38:29 +0800
In-Reply-To: <3e8b18e6-673c-4ee6-a56b-08641c605efc@os.amperecomputing.com>
References: <20231130075247.3078931-1-quan@os.amperecomputing.com>
         <473048522551f1cae5273eb4cd31b732d6e33e53.camel@codeconstruct.com.au>
         <706506b7-a89c-4dfc-b233-be7822eb056e@os.amperecomputing.com>
         <852eaa7b5040124049e51ceba2d13a5799cb6748.camel@codeconstruct.com.au>
         <3e8b18e6-673c-4ee6-a56b-08641c605efc@os.amperecomputing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quan,

> As per [1], __i2c_transfer() will retry for adap->retries times=20
> consecutively (without any wait) within the amount of time specified
> by adap->timeout.
>=20
> So as per my observation, once it loses the arbitration, the next
> retry is most likely still lost as another controller who win the
> arbitration may still be using the bus.

In general (and specifically with your hardware setup), the controller
should be waiting for a bus-idle state before attempting the
retransmission. You may well hit another arbitration loss after that,
but it won't be from the same bus activity.

> Especially for upper layer protocol message like PLDM or SPDM, which
> size is far bigger than SMBus, usually ends up to queue several MCTP
> packets at a time. But if to requeue the packet, it must wait to
> acquire the lock

... you're relying on the delay of acquiring a spinlock? The only
contention on that lock is from local packets being sent to the device
(and, in heavy TX backlogs, the netif queue will be stopped, so that
lock will be uncontended).

That sounds fairly fragile, and somewhat disconnected from the goal of
waiting for a bus idle state.

> before actually queueing that packet, and that is
> more likely to increase the chance to win the arbitration than to
> retry it right away as on the i2c core.
>=20
> Another reason is that, as i2c is widely used for many other=20
> applications, fixing the retry algorithm within the i2c core seems=20
> impossible.

What needs fixing there? You haven't identified any issue with it.

> The other fact is that the initial default value of these two
> parameters=20
> depends on each type of controller; I'm not sure why yet.
>=20
> + i2c-aspeed: =C2=A0 =C2=A0 retries=3D0 timeout=3D1 sec [2]
> + i2c-cadence: =C2=A0 =C2=A0retries=3D3 timeout=3D1 sec [3]
> + i2c-designware: retries=3D3 timeout=3D1 sec [4], [5]
> + i2c-emev2: =C2=A0 =C2=A0 =C2=A0retries=3D5 timeout=3D1 sec [6]
> + ...
>=20
> Unfortunately, in our case, we use i2c-aspeed, and there is only one
> try (see [2]), and that means we have only one single shot. I'm not
> sure why i2c-aspeed chose to set retries=3D0 by default, but I guess
> there must be a reason behind it.

I would suggest that the actual fix you want here is to increase that
retry count, rather than working-around your "not sure" points above
with a duplication of the common retry mechanism.

> And yes, I agree, as per [7], these two parameters could be adjusted
> via ioctl() from userspace if the user wishes to change them. But,
> honestly, forcing users to change these parameters is not a good way,
> as I might have to say.

But now you're forcing users to use your infinite-retry mechanism
instead.

We already have a retry mechanism, which is user-configurable, and we
can set per-controller defaults. If you believe the defaults (present in
the aspeed driver) are not suitable, and it's too onerous for users to
adjust, then I would suggest proposing a change to the default.

Your requeue approach has a problem, in that there is no mechanism for
recovery on repeated packet contention. In a scenario where a specific
packet always causes contention (say, a faulty device on the bus
attempts to respond to that packet too early), then the packet is never
dequeued; other packets already queued will be blocked behind this one
packet. The only way to make forward progress from there is to fill the
TX queue completely.

You could address that by limiting the retries and/or having a timeout,
but then you may as well just use the existing retry mechanism that we
already have, which already does that.

> To avoid that, requeueing the packet in the MCTP layer was kind of
> way better choice, and it was confirmed via our case.

Your earlier examples showed a max of one retry was needed for recovery.
I would suggest bumping the i2c-aspeed driver default to suit the other
in-tree controllers would be a much more appropriate fix.

Cheers,


Jeremy
