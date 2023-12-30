Return-Path: <linux-kernel+bounces-13331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF18282039F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED3DCB2151D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BCB23CF;
	Sat, 30 Dec 2023 04:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="njDNIiTL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC792187E;
	Sat, 30 Dec 2023 04:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703911916; x=1704171116;
	bh=caRSz9JKsn3mBdUsKSY4AOfcZFf54zv3YQQgaKNP9h8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=njDNIiTL3IF6x3x/pXq0Ry8quqaGuG+CzH54ahHsfyz+W9qccrydDwGbmqrzrCiXb
	 sqqjDsPkSodTUlwTgtcdPPGNbJrE9btj76ixqdc1ueE8oAiKqZmfCDvpsApMDQ8SIr
	 qY3kJpQ1H3auM0Q4I11P/ro6ivWXDDREHKOjhfLNxCCyfiLBxt4zs9M7TW1sK+hA9+
	 nbNckCWKvkDxJtTd61NfF16H77lrJRY9s4D3nv83TCFJ9Qv+jomqj5cxVQICc/3O2w
	 sCVU66WXaT+qO4m+PXOrw9D8sUWiWn5fRgY9rDhBQkVmMXDVBJCimasNFRzENUls95
	 mIhtexoqM3YLQ==
Date: Sat, 30 Dec 2023 04:51:40 +0000
To: Kalle Valo <kvalo@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless 3/5] wifi: b43: Stop/wake correct queue in PIO Tx path when QoS is disabled
Message-ID: <20231230045105.91351-4-sergeantsagara@protonmail.com>
In-Reply-To: <20231230045105.91351-1-sergeantsagara@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
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
 drivers/net/wireless/broadcom/b43/pio.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/pio.c b/drivers/net/wireless=
/broadcom/b43/pio.c
index 0cf70fdb60a6..7168fe50af5b 100644
--- a/drivers/net/wireless/broadcom/b43/pio.c
+++ b/drivers/net/wireless/broadcom/b43/pio.c
@@ -525,7 +525,11 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *=
skb)
 =09if (total_len > (q->buffer_size - q->buffer_used)) {
 =09=09/* Not enough memory on the queue. */
 =09=09err =3D -EBUSY;
-=09=09ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+=09=09if (dev->qos_enabled)
+=09=09=09ieee80211_stop_queue(dev->wl->hw,
+=09=09=09=09=09     skb_get_queue_mapping(skb));
+=09=09else
+=09=09=09ieee80211_stop_queue(dev->wl->hw, 0);
 =09=09q->stopped =3D true;
 =09=09goto out;
 =09}
@@ -552,7 +556,11 @@ int b43_pio_tx(struct b43_wldev *dev, struct sk_buff *=
skb)
 =09if (((q->buffer_size - q->buffer_used) < roundup(2 + 2 + 6, 4)) ||
 =09    (q->free_packet_slots =3D=3D 0)) {
 =09=09/* The queue is full. */
-=09=09ieee80211_stop_queue(dev->wl->hw, skb_get_queue_mapping(skb));
+=09=09if (dev->qos_enabled)
+=09=09=09ieee80211_stop_queue(dev->wl->hw,
+=09=09=09=09=09     skb_get_queue_mapping(skb));
+=09=09else
+=09=09=09ieee80211_stop_queue(dev->wl->hw, 0);
 =09=09q->stopped =3D true;
 =09}
=20
@@ -587,7 +595,10 @@ void b43_pio_handle_txstatus(struct b43_wldev *dev,
 =09list_add(&pack->list, &q->packets_list);
=20
 =09if (q->stopped) {
-=09=09ieee80211_wake_queue(dev->wl->hw, q->queue_prio);
+=09=09if (dev->qos_enabled)
+=09=09=09ieee80211_wake_queue(dev->wl->hw, q->queue_prio);
+=09=09else
+=09=09=09ieee80211_wake_queue(dev->wl->hw, 0);
 =09=09q->stopped =3D false;
 =09}
 }
--=20
2.42.0



