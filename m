Return-Path: <linux-kernel+bounces-93701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE2887338B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39BB31C23880
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1AF5FDB2;
	Wed,  6 Mar 2024 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="iqN75l99"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E635FB8E;
	Wed,  6 Mar 2024 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719502; cv=none; b=bT+It/fJKP2uDQ3fywjgvqCO0AD909jUw2LVRMUCzZ4opBMXgdIXsqwrtheH9ZGT+OIna8AGHFGtfXATrRSOSjWqYaPnAndnrc+9nwMUaRQxi5m922f+nY3Nqp2A8zRs/g6WfvzthFgy2sQPrG+8RBs5FMJNn1p6ScjyFBweywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719502; c=relaxed/simple;
	bh=EWA4DLGnGdG+5TPbOBKZ5Nq7PebMpaY+EX9+K4hAu3U=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tNnuWhXSkmGJnOcxpHrhpJZLiOaoTVRI/QYucmGLqGrWhejbTH39eRjvCN8R29q35VLKFc4enW2X8uVzD7QFCjQCuN+KI3awajvz7SlRwo7x/eGdRkvRMGseQQkJZuW7VG5k56dRzk6lMk77AiYLQxFxHia6DitRRghAvuP52mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=iqN75l99; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 57A63146F491;
	Wed,  6 Mar 2024 12:57:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 57A63146F491
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709719077; bh=gPbzrGqFAouR5hcLlY+gaWABmi/r7e8R71W/dDRlrQo=;
	h=From:To:CC:Subject:Date:From;
	b=iqN75l99x7FQJ+5q5qvplWjk4gb5A7O4j4tg7R5dfJ7F133VobzoPJsIDGxCreiJH
	 Lqwndu6/so9GDDTIcWEVpwIM6ZRbMjWY1INeH3QAbvRtCrIWzkiXEHugkJXvrRTw+Q
	 0ASiAj9E2P23k0Gy98XzagN8kEqgqXjaCAFJ8nh4=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 54DF3318FDDC;
	Wed,  6 Mar 2024 12:57:57 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net-next] udp: fix incorrect parameter validation in the
 udp_lib_getsockopt() function
Thread-Topic: [PATCH net-next] udp: fix incorrect parameter validation in the
 udp_lib_getsockopt() function
Thread-Index: AQHab6zDS4CyiiE6UEiU3tkyNekepQ==
Date: Wed, 6 Mar 2024 09:57:57 +0000
Message-ID: <20240306095436.1782250-1-Ilia.Gavrilov@infotecs.ru>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/ipv4/udp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index e474b201900f..17231c0f8830 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2792,11 +2792,11 @@ int udp_lib_getsockopt(struct sock *sk, int level, =
int optname,
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
 	switch (optname) {
 	case UDP_CORK:
 		val =3D udp_test_bit(CORK, sk);
--=20
2.39.2

