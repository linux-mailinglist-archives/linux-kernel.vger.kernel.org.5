Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B477E9D12
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjKMNZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjKMNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:25:49 -0500
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEB69D;
        Mon, 13 Nov 2023 05:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=MIME-Version:Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=xGevJoU/LGbbT9JM0H4VL7scynMrfGdIdqkbL+FY9fo=; b=XEwwj7sVEfb7CZUCj+wEgh1lz6
        rHFnqJUOdPXTqAM2NsXeUFPbTh+UeQRs8bSQUPmX14yL2FR/te7a5IQsdODcAMeX1Zow+7bx/YC33
        oO2IznDLHIl/52vxrRX0xlrXfw4loYRA9QJfUm7fhxcUaUVo2WOJjB5KWJ0N72Z0zEyUthOTYpn3I
        hxURky7tX0tGCCGa7oTPf0fko0WBLknjrykcVLpVEZAs2epzqQhdNyel2vc5cUYGNoI3rCsGi90cv
        8tt4jAVxkLI5HSBu0ZY/7Oh1k16N9euBn5CfWsO9diLV2gGW9DOe0H8GsWW4axbUgLZ+m1BHaEr7b
        4w1R+p6A==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1r2Wwc-0009n4-QV; Mon, 13 Nov 2023 14:25:38 +0100
Received: from [85.184.138.13] (helo=[192.168.8.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1r2Wwb-000CSt-QV; Mon, 13 Nov 2023 14:25:37 +0100
Message-ID: <0c14d3d4372a29a9733c83af4c4254d5dfaf17c2.camel@geanix.com>
Subject: Re: [PATCH v6 00/14] can: m_can: Optimizations for m_can/tcan part 2
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
        Julien Panis <jpanis@baylibre.com>, Judith Mendez <jm@ti.com>
Date:   Mon, 13 Nov 2023 14:25:37 +0100
In-Reply-To: <20230929141304.3934380-1-msp@baylibre.com>
References: <20230929141304.3934380-1-msp@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
MIME-Version: 1.0
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27092/Mon Nov 13 09:38:20 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-09-29 at 16:12 +0200, Markus Schneider-Pargmann wrote:
> Hi Marc, Simon, Martin and everyone,
>=20
> v6 is a rebase on v6.6. As there was a conflicting change merged for
> v6.6 which introduced irq polling, I had to modify the patches that
> touch the hrtimer.
>=20
> @Simon: I removed a couple of your reviewed-by tags because of the
> changes.
>=20
> @Martin: as the functionality changed, I did not apply your Tested-by
> tag as I may have introduced new bugs with the changes.
>=20
> The series implements many small and bigger throughput improvements
> and
> adds rx/tx coalescing at the end.
>=20
> Based on v6.6-rc2. Also available at
> https://gitlab.baylibre.com/msp8/linux/-/tree/topic/mcan-optimization/v6.=
6?ref_type=3Dheads

For the whole series:
Tested-by: Martin Hundeb=C3=B8ll <martin@geanix.com>

Thanks,
Martin

> Changes in v6:
> - Rebased to v6.6-rc2
> - Added two small changes for the newly integrated polling feature
> - Reuse the polling hrtimer for coalescing as the timer used for
> =C2=A0 coalescing has a similar purpose as the one for polling. Also
> polling
> =C2=A0 and coalescing will never be active at the same time.
>=20
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
> v5 -
> https://lore.kernel.org/lkml/20230718075708.958094-1-msp@baylibre.com
>=20
> Markus Schneider-Pargmann (14):
> =C2=A0 can: m_can: Start/Cancel polling timer together with interrupts
> =C2=A0 can: m_can: Move hrtimer init to m_can_class_register
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
> =C2=A0drivers/net/can/m_can/m_can.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 559 ++++++++++++++++++-----
> --
> =C2=A0drivers/net/can/m_can/m_can.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 34 +-
> =C2=A0drivers/net/can/m_can/m_can_platform.c |=C2=A0=C2=A0 4 -
> =C2=A03 files changed, 447 insertions(+), 150 deletions(-)
>=20
>=20
> base-commit: ce9ecca0238b140b88f43859b211c9fdfd8e5b70

