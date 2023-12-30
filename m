Return-Path: <linux-kernel+bounces-13332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA6B8203A2
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC2931C2127F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1C58BFA;
	Sat, 30 Dec 2023 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="BMA6j+KP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0C258B;
	Sat, 30 Dec 2023 04:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703911924; x=1704171124;
	bh=rgfZsgOJu+BPxq6BKookU94qgH8Sx+gD893GO289ygE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BMA6j+KPHs0BKzmnYdHabhNlX82XaPT4Vs19q/lBXsgjVM5tM/MqSixLrmxuXd/QX
	 MmfJ18Ces8sM86qOBw+PaZdvO4Hdh/48gGhzydD/7XQ3NPwsApCx7JuhWJyLrdvp3t
	 EtX4C1LCu3qb/S0lxxS5hZIy8HMmZPxwpK5FDeLzBRBl8SpJOyarHn4dqy1upWEcAe
	 2+U32hBm/eofBgVW/6gXQw9ev2QTGv+SmA4m+mVglTTbOunDEZ9nD4gBarsMavVf4y
	 PSXFpQNOP8Tv1Pmuaj6z46XZabqljZJEz7px+Xo9Y1EZWZ/SLOn3TGLhIGcfc5jgOu
	 Y/HslpOMx/o1g==
Date: Sat, 30 Dec 2023 04:51:45 +0000
To: Kalle Valo <kvalo@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless 4/5] wifi: b43: Stop correct queue in DMA worker when QoS is disabled
Message-ID: <20231230045105.91351-5-sergeantsagara@protonmail.com>
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
ieee80211 queue since there is only one queue. Stop queue 0 when QoS is
disabled to prevent trying to stop a non-existent queue and failing to stop
the actual queue instantiated.

Fixes: bad691946966 ("b43: avoid packet losses in the dma worker code.")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---
 drivers/net/wireless/broadcom/b43/main.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireles=
s/broadcom/b43/main.c
index c81117a22ebf..b6ac1526c0e8 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -3603,7 +3603,10 @@ static void b43_tx_work(struct work_struct *work)
 =09=09=09=09err =3D b43_dma_tx(dev, skb);
 =09=09=09if (err =3D=3D -ENOSPC) {
 =09=09=09=09wl->tx_queue_stopped[queue_num] =3D true;
-=09=09=09=09ieee80211_stop_queue(wl->hw, queue_num);
+=09=09=09=09if (dev->qos_enabled)
+=09=09=09=09=09ieee80211_stop_queue(wl->hw, queue_num);
+=09=09=09=09else
+=09=09=09=09=09ieee80211_stop_queue(wl->hw, 0);
 =09=09=09=09skb_queue_head(&wl->tx_queue[queue_num], skb);
 =09=09=09=09break;
 =09=09=09}
@@ -3636,11 +3639,12 @@ static void b43_op_tx(struct ieee80211_hw *hw,
 =09B43_WARN_ON(skb_shinfo(skb)->nr_frags);
=20
 =09skb_queue_tail(&wl->tx_queue[skb->queue_mapping], skb);
-=09if (!wl->tx_queue_stopped[skb->queue_mapping]) {
+=09if (!wl->tx_queue_stopped[skb->queue_mapping])
 =09=09ieee80211_queue_work(wl->hw, &wl->tx_work);
-=09} else {
+=09else if (wl->current_dev->qos_enabled)
 =09=09ieee80211_stop_queue(wl->hw, skb->queue_mapping);
-=09}
+=09else
+=09=09ieee80211_stop_queue(wl->hw, 0);
 }
=20
 static void b43_qos_params_upload(struct b43_wldev *dev,
--=20
2.42.0



