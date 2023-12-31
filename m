Return-Path: <linux-kernel+bounces-13632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CBC8209BD
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 06:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C0602831F1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 05:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4B33E5;
	Sun, 31 Dec 2023 05:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="jr2j+Kfc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410CD258F
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 05:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703999034; x=1704258234;
	bh=nMmY4lgSrVOhiGZvska8zO0P9lepPYf3Fiw+Sy4tIfM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jr2j+Kfc4KlGvnS8FgkLquzWm38h6gO/Dm8FrvOU5KyM+gSPjvfkFr8EZeaFjVD7A
	 6DewXceSr5rOj+JqkZVDf+yg14Ni5d0eYG/fKz1k/v1q7lMtOohYm8qdT+QQZrj3yw
	 /jdIYshMvSabOI9FoE4/OjKXnfkpfLijeXzfCTcjjDIcuIn2fR0opr1WIgp0yO48BQ
	 gDY2ccGLeCOwtReCvzlF2e663WorzVNdWrA+/sGbm9xQlIbcnRldTxZNvAMnGYj/g2
	 sI4vLxBF/E1b2YaCxb2gyImD6HGSrXltHyUCTa8JJAqGowJbg1zY01+wJBtJGsio7q
	 QEPjXlt3CPUoA==
Date: Sun, 31 Dec 2023 05:03:45 +0000
To: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>, Julian Calaby <julian.calaby@gmail.com>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless v2 2/4] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Message-ID: <20231231050300.122806-3-sergeantsagara@protonmail.com>
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
ieee80211 queue since there is only one queue. Stop/wake queue 0 when QoS
is disabled to prevent trying to stop/wake a non-existent queue and failing
to stop/wake the actual queue instantiated.

Fixes: 5100d5ac81b9 ("b43: Add PIO support for PCMCIA devices")
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
        When PIO support was first introduced to the b43 driver in commit
        5100d5ac81b9 ("b43: Add PIO support for PCMCIA devices"), four queu=
es
        were allocated for different QoS priorities for video, voice, best
        effort, and background. This was modelled after commit
        e6f5b934fba8 ("b43: Add QOS support"), which has the following issu=
e.
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
        in the struct ieee80211_hw queues member.

 drivers/net/wireless/broadcom/b43/pio.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/pio.c b/drivers/net/wireless=
/broadcom/b43/pio.c
index 0cf70fdb60a6..e41f2f5b4c26 100644
--- a/drivers/net/wireless/broadcom/b43/pio.c
+++ b/drivers/net/wireless/broadcom/b43/pio.c
@@ -525,7 +525,7 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *s=
kb)
 =09if (total_len > (q->buffer_size - q->buffer_used)) {
 =09=09/* Not enough memory on the queue. */
 =09=09err =3D -EBUSY;
-=09=09ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+=09=09b43_stop_queue(dev, skb_get_queue_mapping(skb));
 =09=09q->stopped =3D true;
 =09=09goto out;
 =09}
@@ -552,7 +552,7 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *s=
kb)
 =09if (((q->buffer_size - q->buffer_used) < roundup(2 + 2 + 6, 4)) ||
 =09    (q->free_packet_slots =3D=3D 0)) {
 =09=09/* The queue is full. */
-=09=09ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+=09=09b43_stop_queue(dev, skb_get_queue_mapping(skb));
 =09=09q->stopped =3D true;
 =09}
=20
@@ -587,7 +587,7 @@ void b43_pio_handle_txstatus(struct b43_wldev *dev,
 =09list_add(&pack->list, &q->packets_list);
=20
 =09if (q->stopped) {
-=09=09ieee80211_wake_queue(dev->wl->hw, q->queue_prio);
+=09=09b43_wake_queue(dev, q->queue_prio);
 =09=09q->stopped =3D false;
 =09}
 }
--=20
2.42.0



