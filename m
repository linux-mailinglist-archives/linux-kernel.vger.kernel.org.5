Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF77F85BC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 23:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjKXWCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 17:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKXWCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 17:02:12 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83F6C6;
        Fri, 24 Nov 2023 14:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=s31663417; t=1700863323; x=1701468123; i=wahrenst@gmx.net;
        bh=RJpH4xQXxjQDL3eLxsO2HiDV2EJzu1pu3W5oYW1MvnU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
         In-Reply-To;
        b=bbbJFFc+AF1SMr0oe90UIh4VTdhz6+E1AettNSAW41oKt79PeUYmFkjKrdXD0onl
         taptHmE3kOVRX80H37FxS7asl4O02r8nZCwuUqS2IgeK85EpvJf/LNdJTCM3G/oMS
         t0WJ8aWJ0WtODycstd5vGfuRYya8/T6EQAzXC0/p//P8YmSkyB39Nsl1tw+x5f/Dq
         YnqmL6+ep659DtkdOxFeWtQdBS5/qPNpAqxk6P2nnMaEdnb0vipKCG9F72ynXdExY
         G/dOkcHT6UYieZVyZJNvgN+Fng8I2Eu/Qp1TPuIYXdd7rzji79v5yn/IUIukV4DWR
         MqyxMP7c+bQ97koaYQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.129] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MrQJ5-1rcyOj3M63-00oYgP; Fri, 24
 Nov 2023 23:02:02 +0100
Message-ID: <fb134c01-59ac-4781-99cc-03104845fe9c@gmx.net>
Date:   Fri, 24 Nov 2023 23:02:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4 net] qca_spi: Fix SPI IRQ handling
Content-Language: en-US
To:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231121163004.21232-1-wahrenst@gmx.net>
 <20231121163004.21232-3-wahrenst@gmx.net>
 <a24433f86e39cbb45a9606621e01446e7ad6fa53.camel@redhat.com>
 <bf3dd03e-a1f2-4586-8f00-7003848016aa@gmx.net>
 <9e2bba3c98cd24ebf1b6d9fde2e0b9229ad6b99f.camel@redhat.com>
From:   Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <9e2bba3c98cd24ebf1b6d9fde2e0b9229ad6b99f.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xxrzt6WI4hPd4V+8RaLfaDk+Zbtb3DKAQXpOEk/cQJggrJUlsKl
 YDJfn78SZhYrz4mc1krMI7ELSgHRAHmvminMGyfEzxapFFskeoJOrMal9KA8iiUnxXUCcq8
 NXQ2bFUtYCD/Ks/rhRVJDmY/bWbqqlBO00RgC+NnsXaRQeKUYJCeYjUohdC2aB527nVzY8O
 OIETr72wVau2ivYCaG0sw==
UI-OutboundReport: notjunk:1;M01:P0:te/CiKATKSg=;3Dm+CDClnjryo0icj2kTWLhCBja
 Z+2lBujMmjmbzZIdrB2UhlRZpCVvLdqYe1zaC7alqR9BXhr+n9RyY0BCr7Mgnb2WN1nS932Dw
 6U/cYE+KOxWhFU73WHTZQ7200b1/L4SbyF2nRRazwcoibS/4L/zbICAlNTlVRdTe90VBmh8oP
 eEzWKm8L/LifclLzKZYqFmYymN4Rv535/ruGaRc29rYwoKlFTK4OSZeyn/F04S9PYBxbaeD7E
 bVapEspDeUK70tJHmB7r2X0XvbfgNKqtHOBIA9OzyrMrBmb/x4ZGDyxfqv/Sr1nCjozGFX/xN
 fEatiQ5TjyWpy8M09RJKKWTwjfqmP0oq857cr74/svdjueRilhVMB6bJx9ifZ4StmLIP48OJv
 b2U6vG/+1yrmI8Ru8z6waPT/gajDpg+Sfb8pJR1Zltt102iISB6SfL0yhdqBOtljous9OkdeJ
 F/ij8DoH8vOcx2WP4EXEBxubaCblze7LD2q4nnIhmMvmpIbYwiYOoCmdNxocL2M2hRlilScT4
 8W8xNstRmrfo+EL2QtzABufHO7PEnrh5ojpyrIFMfXAkANFILEw+2rD00xvnez7VGowwFCsGk
 /TlncxlmGQmVNgndhqyG1l4aj31z1nZD+gn5s6F7lj/P66p9lPxMh4oI3Z+Nm+BFMQoahHwgs
 jzBqrio0B2R7us9obu/fu+cD/WlkBLhhOJ1CCkshrF8ZCBzXmIIJtJ9HAXziofm+tytQFfRMJ
 rTSQNk+qO3HoVtq1uz4Lq63s+f4/RX5WbhlRkMl+bzN00LIgpzizTIYFYsSZstU1EMMfTzu8L
 +67YSPkfvQ+hlVKTCfd2r+WcDwqU2rvMafYdYg+U/W+TC9KLZu2u+rew0ZSvjGUPwc8uBDaQy
 Jz3H6CJ04N041uq3TU/4eBYtoHlck/5ihJhvOx2E2Z0rT5YGeA9etiUbCMjuroG26SIY83naA
 EOj/7J5GY/2/ph1Xo9lNC2+Nz+4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paolo,

Am 24.11.23 um 16:33 schrieb Paolo Abeni:
> On Fri, 2023-11-24 at 15:01 +0100, Stefan Wahren wrote:
>> Hi Paolo,
>>
>> Am 23.11.23 um 12:37 schrieb Paolo Abeni:
>>> On Tue, 2023-11-21 at 17:30 +0100, Stefan Wahren wrote:
>>>> The functions qcaspi_netdev_open/close are responsible of request &
>>>> free of the SPI interrupt, which wasn't the best choice. Currently
>>>> it's possible to trigger a double free of the interrupt by calling
>>>> qcaspi_netdev_close() after qcaspi_netdev_open() has failed.
>>>> So let us split IRQ allocation & enabling, so we can take advantage
>>>> of a device managed IRQ and also fix the issue.
>>>>
>>>> Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for=
 QCA7000")
>>>> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
>>> The change makes sense, but the changelog is confusing.
>>>
>>> qcaspi_netdev_close() and qcaspi_netdev_open() are invoked only via
>>> ndo_open and ndo_close(), right? So qcaspi_netdev_close() will never b=
e
>>> invoked qcaspi_netdev_open(), failure - that is when IFF_UP is not set=
.
>> sorry, i missed to mention an important part. This issue is partly
>> connected to patch 3.
>> Please look at qcaspi_set_ringparam() which also call ndo_close() and
>> ndo_open().
> Ah, I see it now. IMHO root cause of the problem is there. The ethtool
> op should not flip the device state.
>
> A more narrow fix would be to park/unpark the thread inside
> set_ringparam() - instead of the whole patch 1 && 2 I suspect.

before i send a complete new version of this series, could you please
have a look at this replacement for patch 1 & 2:

qca_debug: Prevent crash on TX ring changes

The qca_spi driver stop and restart the SPI kernel thread
(via ndo_stop & ndo_open) in case of TX ring changes. This is
a big issue because it allows userspace to prevent restart of
the SPI kernel thread (via signals). A subsequent change of
TX ring wrongly assume a valid spi_thread pointer which result
in a crash.

So prevent this by stopping the network queue and temporary park
the SPI thread. Because this could happen during transmission
we also need to call qcaspi_flush_tx_ring().

Fixes: 291ab06ecf67 ("net: qualcomm: new Ethernet over SPI driver for
QCA7000")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 =C2=A0drivers/net/ethernet/qualcomm/qca_debug.c | 17 ++++++++++++-----
 =C2=A0drivers/net/ethernet/qualcomm/qca_spi.c=C2=A0=C2=A0 |=C2=A0 7 +++++=
+-
 =C2=A0drivers/net/ethernet/qualcomm/qca_spi.h=C2=A0=C2=A0 |=C2=A0 2 ++
 =C2=A03 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_debug.c
b/drivers/net/ethernet/qualcomm/qca_debug.c
index f62c39544e08..478ab3ce949d 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_debug.c
+++ b/drivers/net/ethernet/qualcomm/qca_debug.c
@@ -263,22 +263,29 @@ qcaspi_set_ringparam(struct net_device *dev,
struct ethtool_ringparam *ring,
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct kernel_ethtool_ringparam *kernel_ring,
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0 stru=
ct netlink_ext_ack *extack)
 =C2=A0{
-=C2=A0=C2=A0=C2=A0 const struct net_device_ops *ops =3D dev->netdev_ops;
 =C2=A0=C2=A0=C2=A0=C2=A0 struct qcaspi *qca =3D netdev_priv(dev);
+=C2=A0=C2=A0=C2=A0 bool queue_active =3D !netif_queue_stopped(dev);

 =C2=A0=C2=A0=C2=A0=C2=A0 if ((ring->rx_pending) ||
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (ring->rx_mini_pending) ||
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 (ring->rx_jumbo_pending))
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -EINVAL;

-=C2=A0=C2=A0=C2=A0 if (netif_running(dev))
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ops->ndo_stop(dev);
+=C2=A0=C2=A0=C2=A0 if (queue_active)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 netif_stop_queue(dev);

+=C2=A0=C2=A0=C2=A0 if (qca->spi_thread)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 kthread_park(qca->spi_thread);
+
+=C2=A0=C2=A0=C2=A0 qcaspi_flush_tx_ring(qca);
 =C2=A0=C2=A0=C2=A0=C2=A0 qca->txr.count =3D max_t(u32, ring->tx_pending, =
TX_RING_MIN_LEN);
 =C2=A0=C2=A0=C2=A0=C2=A0 qca->txr.count =3D min_t(u16, qca->txr.count, TX=
_RING_MAX_LEN);

-=C2=A0=C2=A0=C2=A0 if (netif_running(dev))
-=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ops->ndo_open(dev);
+=C2=A0=C2=A0=C2=A0 if (qca->spi_thread)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 kthread_unpark(qca->spi_thread);
+
+=C2=A0=C2=A0=C2=A0 if (queue_active)
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 netif_wake_queue(dev);

 =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
 =C2=A0}
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c
b/drivers/net/ethernet/qualcomm/qca_spi.c
index d0578530dfbc..2ebe9834a1d3 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -468,7 +468,7 @@ qcaspi_tx_ring_has_space(struct tx_ring *txr)
 =C2=A0 *=C2=A0=C2=A0 call from the qcaspi_spi_thread.
 =C2=A0 */

-static void
+void
 =C2=A0qcaspi_flush_tx_ring(struct qcaspi *qca)
 =C2=A0{
 =C2=A0=C2=A0=C2=A0=C2=A0 int i;
@@ -581,6 +581,11 @@ qcaspi_spi_thread(void *data)
 =C2=A0=C2=A0=C2=A0=C2=A0 netdev_info(qca->net_dev, "SPI thread created\n"=
);
 =C2=A0=C2=A0=C2=A0=C2=A0 while (!kthread_should_stop()) {
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 set_current_state(TASK_INTERR=
UPTIBLE);
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (kthread_should_park()) {
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 kthread_parkme()=
;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 continue;
+=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 }
+
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if ((qca->intr_req =3D=3D qca=
->intr_svc) &&
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 !qca->txr.=
skb[qca->txr.head])
 =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 schedule()=
;
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.h
b/drivers/net/ethernet/qualcomm/qca_spi.h
index 3067356106f0..95d7306e58e9 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_spi.h
+++ b/drivers/net/ethernet/qualcomm/qca_spi.h
@@ -107,4 +107,6 @@ struct qcaspi {
 =C2=A0=C2=A0=C2=A0=C2=A0 u16 burst_len;
 =C2=A0};

+void qcaspi_flush_tx_ring(struct qcaspi *qca);
+
 =C2=A0#endif /* _QCA_SPI_H */
=2D-
2.34.1


>
> IMHO the changes in this still make sense - a refactor for net-next.
>
> Cheers,
>
> Paolo
>

