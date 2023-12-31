Return-Path: <linux-kernel+bounces-13634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B29F78209C1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 06:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C881F21C95
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 05:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4438F52;
	Sun, 31 Dec 2023 05:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="d53RqzNm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30BB8C19
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 05:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703999044; x=1704258244;
	bh=NmMPrf58wJ+F6E+Z9exyRV+1aoIrZhkWoXl0KSFnTL8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=d53RqzNmwVXdT0sdMUyczQg3vCLBYpudkcdSeDv2z9O8kr5RRNoxoeSN0wIM4Wu55
	 s0Mjy/VXwTgV9ZdLes4EFNC5/6uoqz4A3RX20LoSHmj7TkfWfJa1WJPjA1guCSQQzR
	 Tr+4bt6qNyftRGhw+9+ZKoi9/N2UilHADgG+vRVTovZpIe8PvQYTlTWK+atiMf8LFb
	 5NIJbjbGjhJ0J4D1uDbMFw2Vuov+d081qOkg8FaZIj4lUpQY604ePhQqG6em1T1+yz
	 26U/ebp18KHovz6W0yN8gSiq3t6P2ZfabKCChawC5WOC3qmhaofHeQG6X2tUEZpJfS
	 R4LwqPKYCoi/w==
Date: Sun, 31 Dec 2023 05:03:51 +0000
To: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>, Julian Calaby <julian.calaby@gmail.com>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless v2 3/4] wifi: b43: Stop correct queue in DMA worker when QoS is disabled
Message-ID: <20231231050300.122806-4-sergeantsagara@protonmail.com>
In-Reply-To: <20231231050300.122806-1-sergeantsagara@protonmail.com>
References: <20231231050300.122806-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

When QoS is disabled, the queue priority value will not map to the correct
ieee80211 queue since there is only one queue. Stop queue 0 when QoS is
disabled to prevent trying to stop a non-existent queue and failing to stop
the actual queue instantiated.

Fixes: bad691946966 ("b43: avoid packet losses in the dma worker code.")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---

Notes:
    Changes:
   =20
        v1->v2:
            - Refactored logic with helpers (suggested by Larry Finger
              <Larry.Finger@lwfinger.net>)
   =20
    Issue Details:
   =20
        When QoS was first introduced to the b43 driver in commit
        e6f5b934fba8 ("b43: Add QOS support"), four rings were allocated fo=
r
        different QoS priorities for video, voice, best effort, and backgro=
und.
        The core networking stack maps these priorities in the skb, and the=
se
        mappings are noted in the ring's queue_prio member. When disabling =
QoS
        in the driver, the skb will still contain the mapping for the core
        stack while only one queue is actually considered active (the best
        effort queue). In the situation that QoS is disabled, b43 needs to =
pass
        0 to ieee80211 queue functions since the number of queues is set to=
 1
        in the struct ieee80211_hw queues member. This issue was then exten=
ded
        to the changes in commit bad691946966 ("b43: avoid packet losses in=
 the
        dma worker code.").

 drivers/net/wireless/broadcom/b43/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireles=
s/broadcom/b43/main.c
index 92ca0b2ca286..97d8bdeaa06c 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -3603,7 +3603,7 @@ static void b43_tx_work(struct work_struct *work)
 =09=09=09=09err =3D b43_dma_tx(dev, skb);
 =09=09=09if (err =3D=3D -ENOSPC) {
 =09=09=09=09wl->tx_queue_stopped[queue_num] =3D true;
-=09=09=09=09ieee80211_stop_queue(wl->hw, queue_num);
+=09=09=09=09b43_stop_queue(dev, queue_num);
 =09=09=09=09skb_queue_head(&wl->tx_queue[queue_num], skb);
 =09=09=09=09break;
 =09=09=09}
@@ -3627,6 +3627,7 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 =09=09      struct sk_buff *skb)
 {
 =09struct b43_wl *wl =3D hw_to_b43_wl(hw);
+=09u16 skb_queue_mapping;
=20
 =09if (unlikely(skb->len < 2 + 2 + 6)) {
 =09=09/* Too short, this can't be a valid frame. */
@@ -3635,12 +3636,12 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 =09}
 =09B43_WARN_ON(skb_shinfo(skb)->nr_frags);
=20
-=09skb_queue_tail(&wl->tx_queue[skb->queue_mapping], skb);
-=09if (!wl->tx_queue_stopped[skb->queue_mapping]) {
+=09skb_queue_mapping =3D skb_get_queue_mapping(skb);
+=09skb_queue_tail(&wl->tx_queue[skb_queue_mapping], skb);
+=09if (!wl->tx_queue_stopped[skb_queue_mapping])
 =09=09ieee80211_queue_work(wl->hw, &wl->tx_work);
-=09} else {
-=09=09ieee80211_stop_queue(wl->hw, skb->queue_mapping);
-=09}
+=09else
+=09=09b43_stop_queue(wl->current_dev, skb_queue_mapping);
 }
=20
 static void b43_qos_params_upload(struct b43_wldev *dev,
--=20
2.42.0



