Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E2D7850D4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 08:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjHWGv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 02:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbjHWGvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 02:51:55 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C241CD9;
        Tue, 22 Aug 2023 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Rso0/YrRm8azXXC9bkct7gjLBjuUhaYe+rBIcO0EVH0=; b=gKlwgIZHFpqud+27+9dwsIX86/
        9e6wRUDUVWH1cKt00PNRu+0i/hbBud7Cl3iSvhKFhJAbAKeLYQ2CApMiQcbMl+iUwmRNG80+oZwCB
        2XBOo8effYl7wkXXRdSh8/Eqk66jceqS0b+MMVEL2ROzDsPmdwoqLLoYwafU1gftFZ2bdU4o3/GNZ
        g46A5BnSLus09TuZBPkughUhbTkk8MgxbAViftiFUZlflf1MgB5Q1KGzGlHZxQluAHCEKnrL5o/eu
        +Ur4oWJ5KFXDhVDMUmx9bStJ7TpRf1Fd0GJUEb6nMVFCQiZyf5c0V9vvLqmHp57KUVeP6O687ATMh
        bda3W3Zg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qYhiY-000Fgq-1w; Wed, 23 Aug 2023 08:51:49 +0200
Received: from [85.184.138.13] (helo=[192.168.8.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qYhiX-00066l-2U; Wed, 23 Aug 2023 08:51:49 +0200
Message-ID: <108a41e492dcfa4a7c59e44aac7dfb502e595962.camel@geanix.com>
Subject: Re: [PATCH v5 00/12] can: m_can: Optimizations for m_can/tcan part 2
From:   Martin =?ISO-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>
Cc:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julien Panis <jpanis@baylibre.com>
Date:   Wed, 23 Aug 2023 08:51:48 +0200
In-Reply-To: <20230718075708.958094-1-msp@baylibre.com>
References: <20230718075708.958094-1-msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27008/Tue Aug 22 09:39:05 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-07-18 at 09:56 +0200, Markus Schneider-Pargmann wrote:
> Hi Marc, Simon and everyone,
>=20
> v5 got a rebase on v6.5 with some small style fixes as pointed out in
> v4.
>=20
> It is tested on tcan455x but I don't have hardware with mcan on the
> SoC
> myself so any testing is appreciated.
>=20
> The series implements many small and bigger throughput improvements
> and
> adds rx/tx coalescing at the end.
>=20
> Based on v6.5-rc1. Also available at
> https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.=
5?ref_type=3Dheads

For the whole series:
Tested-by: Martin Hundeb=C3=B8ll <martin@geanix.com>

Thanks,
Martin

> Changes in v5:
> - Add back parenthesis in m_can_set_coalesce(). This will make
> =C2=A0 checkpatch unhappy but gcc happy.
> - Remove unused fifo_header variable in m_can_tx_handler().
> - Rebased to v6.5-rc1
>=20
> Changes in v4:
> - Create and use struct m_can_fifo_element in m_can_tx_handler
> - Fix memcpy_and_pad to copy the full buffer
> - Fixed a few checkpatch warnings
> - Change putidx to be unsigned
> - Print hard_xmit error only once when TX FIFO is full
>=20
> Changes in v3:
> - Remove parenthesis in error messages
> - Use memcpy_and_pad for buffer copy in 'can: m_can: Write transmit
> =C2=A0 header and data in one transaction'.
> - Replace spin_lock with spin_lock_irqsave. I got a report of a
> =C2=A0 interrupt that was calling start_xmit just after the netqueue was
> =C2=A0 woken up before the locked region was exited. spin_lock_irqsave
> should
> =C2=A0 fix this. I attached the full stack at the end of the mail if
> someone
> =C2=A0 wants to know.
> - Rebased to v6.3-rc1.
> - Removed tcan4x5x patches from this series.
>=20
> Changes in v2:
> - Rebased on v6.2-rc5
> - Fixed missing/broken accounting for non peripheral m_can devices.
>=20
> previous versions:
> v1 -
> https://lore.kernel.org/lkml/20221221152537.751564-1-msp@baylibre.com
> v2 -
> https://lore.kernel.org/lkml/20230125195059.630377-1-msp@baylibre.com
> v3 -
> https://lore.kernel.org/lkml/20230315110546.2518305-1-msp@baylibre.com/
> v4 -
> https://lore.kernel.org/lkml/20230621092350.3130866-1-msp@baylibre.com/
>=20
> Markus Schneider-Pargmann (12):
> =C2=A0 can: m_can: Write transmit header and data in one transaction
> =C2=A0 can: m_can: Implement receive coalescing
> =C2=A0 can: m_can: Implement transmit coalescing
> =C2=A0 can: m_can: Add rx coalescing ethtool support
> =C2=A0 can: m_can: Add tx coalescing ethtool support
> =C2=A0 can: m_can: Use u32 for putidx
> =C2=A0 can: m_can: Cache tx putidx
> =C2=A0 can: m_can: Use the workqueue as queue
> =C2=A0 can: m_can: Introduce a tx_fifo_in_flight counter
> =C2=A0 can: m_can: Use tx_fifo_in_flight for netif_queue control
> =C2=A0 can: m_can: Implement BQL
> =C2=A0 can: m_can: Implement transmit submission coalescing
>=20
> =C2=A0drivers/net/can/m_can/m_can.c | 517 +++++++++++++++++++++++++------=
-
> --
> =C2=A0drivers/net/can/m_can/m_can.h |=C2=A0 35 ++-
> =C2=A02 files changed, 418 insertions(+), 134 deletions(-)
>=20
>=20
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5

