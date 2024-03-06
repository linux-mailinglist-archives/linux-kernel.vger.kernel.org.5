Return-Path: <linux-kernel+bounces-93684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE98F873341
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0319BB217CA
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9576D5F57B;
	Wed,  6 Mar 2024 09:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="RxzsiQcT"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D8E5C5E9;
	Wed,  6 Mar 2024 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719094; cv=none; b=fdrhYE+YnLIzRk0mi5JgsrTeAaSnnWMWl7qzmiECXp7jiShasjjwRB8wt/0M7rjzg7CsETkHaTRJ66yBCzaVJUOoTZQSap8xPKDET51bCn2qYrkEkahBavf5lKG8+2f9jHKh/8BOZUkozun8HTmEeMWwxVZ8wKdv4Rsfo52/0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719094; c=relaxed/simple;
	bh=5G5VVo+1qgps5vD0NkS0x+fbwZcUY7UCIqfaMshKfJE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=teoS2PAdF3O1i2C1cNKnF1g5zjhR3wVaZIbUkkzAJyiOYrnWSJKAHIhZeAWmDBa/T5L35jit3WcMA8UlQbttCseqRJTqCaCEGMMBeD9i/d7RKDVJUI6A0Lu+FB4JlhB4fIsqZEVVxzLqD+WyjtoLJvTZkT93SACgwMPafzAk8gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=RxzsiQcT; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id BDE7E14772FA;
	Wed,  6 Mar 2024 12:58:10 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru BDE7E14772FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709719091; bh=3aN6hOzMHHvZ08urKVgYpVNXHUvmRS1ZAth2j/iI0FM=;
	h=From:To:CC:Subject:Date:From;
	b=RxzsiQcT4y87SaCcj7gIVUo6Yr7otrGOiTntmBR2I837yEjN67WjYZlmTK4HEvXFp
	 fsrtLIU1HNDn/DMIvrKQjAqouwlZwu5m2GxObLqLBV392ul3HfT0Brq3NnN19JUDX0
	 +NNmMA//Q7yYB3U+Yv+aCvOHB8tSsewGYeGYCoLI=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id BC14D31359F8;
	Wed,  6 Mar 2024 12:58:10 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: James Chapman <jchapman@katalix.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next] l2tp: fix incorrect parameter validation in the
 pppol2tp_getsockopt() function
Thread-Topic: [PATCH net-next] l2tp: fix incorrect parameter validation in the
 pppol2tp_getsockopt() function
Thread-Index: AQHab6zLxDpNeRGzJEWak6j8scMaKQ==
Date: Wed, 6 Mar 2024 09:58:10 +0000
Message-ID: <20240306095449.1782369-1-Ilia.Gavrilov@infotecs.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/06 07:48:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/06 02:14:00 #24008090
X-KLMS-AntiVirus-Status: Clean, skipped

The 'len' variable can't be negative because all 'min_t' parameters
cast to unsigned int, and then the minimum one is chosen.

To fix it, move the if statement higher.

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/l2tp/l2tp_ppp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index f011af6601c9..6146e4e67bbb 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1356,11 +1356,11 @@ static int pppol2tp_getsockopt(struct socket *sock,=
 int level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
=20
-	len =3D min_t(unsigned int, len, sizeof(int));
-
 	if (len < 0)
 		return -EINVAL;
=20
+	len =3D min_t(unsigned int, len, sizeof(int));
+
 	err =3D -ENOTCONN;
 	if (!sk->sk_user_data)
 		goto end;
--=20
2.39.2

