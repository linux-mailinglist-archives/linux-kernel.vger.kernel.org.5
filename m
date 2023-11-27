Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A61F87FAE22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 00:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjK0XAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 18:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjK0XAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 18:00:09 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47019D;
        Mon, 27 Nov 2023 15:00:12 -0800 (PST)
Received: from [192.168.68.112] (ppp118-210-131-38.adl-adc-lon-bras33.tpg.internode.on.net [118.210.131.38])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DC2FB200EF;
        Tue, 28 Nov 2023 07:00:02 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1701126006;
        bh=jeaVBZ61hYUULmiG4P1ndu1Q2m319cZm4MzoynyxVlQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=GcF5S01D0K9OrzUP0huZxWEqVkzKv+ALVQNJLjU286ml3+TWPtHI2Zc8t6o8wULQk
         KqmZkOUx0cGc5393b6urtjElVwWj3lGCg4obKPoov+MkKuHgNZZMKJV/ofccGs7cFX
         RFwEHtRS1QEG1fEyjt7aZe/h33NCJjvIcqSNRTRoHy2/N4rEquFYON9Y1iqm0rzJEv
         C5nfRoagxZnIgxEWBCdb1IL9THFhXkg6oGh70riVnXa5jPtyduaH/9GenlWyUlxYKi
         kIKcmX/4E5/YnNDHVydkF6JAVm+AICdzgHsd4IY2w2/68iom6sRDaqwziTv7BzQsrw
         JBe2POQtO3KnA==
Message-ID: <d0773df55a6fe8a5c9b1a3d7c8dd2e1343643272.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i2c: aspeed: Acknowledge Tx ack late when in
 SLAVE_READ_PROCESSED
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     Quan Nguyen <quan@os.amperecomputing.com>,
        Cosmo Chou <chou.cosmo@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, jae.hyun.yoo@linux.intel.com,
        andi.shyti@kernel.org, linux-aspeed@lists.ozlabs.org,
        openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wsa@kernel.org, brendan.higgins@linux.dev, cosmo.chou@quantatw.com,
        joel@jms.id.au, linux@roeck-us.net, linux-i2c@vger.kernel.org
Date:   Tue, 28 Nov 2023 09:30:01 +1030
In-Reply-To: <854762fb-1767-4208-a7fc-10580730c1f3@os.amperecomputing.com>
References: <20231120091746.2866232-1-chou.cosmo@gmail.com>
         <fdd884426497486c6b17795b4edc66243bdc7350.camel@codeconstruct.com.au>
         <CAOeEDyumVdi-3O3apMUFJ695V3YcZqZQ7wvzYL2YfU88XJ3Dxw@mail.gmail.com>
         <854762fb-1767-4208-a7fc-10580730c1f3@os.amperecomputing.com>
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

On Mon, 2023-11-27 at 15:08 +0700, Quan Nguyen wrote:
>=20
> On 27/11/2023 14:04, Cosmo Chou wrote:
> > Andrew Jeffery <andrew@codeconstruct.com.au> wrote on Mon, 2023-11-27
> > at 11:23 AM:
> > >=20
> > > On Mon, 2023-11-20 at 17:17 +0800, Cosmo Chou wrote:
> > > > commit 2be6b47211e1 ("i2c: aspeed: Acknowledge most interrupts earl=
y
> > > > in interrupt handler") moved most interrupt acknowledgments to the
> > > > start of the interrupt handler to avoid race conditions. However,
> > > > slave Tx ack status shouldn't be cleared before SLAVE_READ_PROCESSE=
D
> > > > is handled.
> > > >=20
> > > > Acknowledge Tx ack status after handling SLAVE_READ_PROCESSED to fi=
x
> > > > the problem that the next byte is not sent correctly.
> > >=20
> > > What does this mean in practice? Can you provide more details? It
> > > sounds like you've seen concrete problems and it would be nice to
> > > capture what it was that occurred.
> > >=20
> > > Andrew
> >=20
> > For a normal slave transaction, a master attempts to read out N bytes
> > from BMC: (BMC addr: 0x20)
> > [S] [21] [A] [1st_B] [1_ack] [2nd_B] [2_ack] ... [Nth_B] [N] [P]
> >=20
> > T1: when [21] [A]: Both INTR_SLAVE_MATCH and INTR_RX_DONE rise,
> > INTR_RX_DONE is not cleared until BMC is ready to send the 1st_B:
> > https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-as=
peed.c#L294
> > That is, BMC stretches the SCL until ready to send the 1st_B.
> >=20
> > T2: when [1_ack]: INTR_TX_ACK rises, but it's cleared at the start of
> > the ISR, so that BMC does not stretch the SCL, the master continues
> > to read 2nd_B before BMC is ready to send the 2nd_B.
> >=20
> > To fix this, do not clear INTR_TX_ACK until BMC is ready to send data:
> > https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/i2c-as=
peed.c#L302
> >=20
>=20
> This looks like the same issue, but we chose to ack them late. Same with=
=20
> INTR_RX_DONE.
>=20
> https://lore.kernel.org/all/20210616031046.2317-3-quan@os.amperecomputing=
.com/

From a brief inspection I prefer the descriptions in your series Quan.
Looks like we dropped the ball a bit there though on the review - can
you resend your series based on 6.7-rc1 or so and Cc Cosmo?

Cheers,

Andrew
