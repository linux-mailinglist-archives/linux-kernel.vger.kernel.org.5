Return-Path: <linux-kernel+bounces-64923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F778544B3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CD128D2BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A810A35;
	Wed, 14 Feb 2024 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="CGcJ/42F"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F68379C0;
	Wed, 14 Feb 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901840; cv=none; b=OFk2fKEaOpspfDYgCmE2jT1FcGQcIt2d3eHD6pvByCa/T/oUCmfpcMay8vA8elZ0TdXHEfeVI+tK72eqKxezIwLxdEUpVINcE68l+fPxCoU0NxyxIJKCToreH508Ohj9rel33CPF9G0UG25i+4Lu2q56yG8wzr9VaN90jFMh8f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901840; c=relaxed/simple;
	bh=fhaQc5uReQDosB0thOz5f3cBKN3ZqzcXRvj2QlSbfMg=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=K//Ye3DZoVUdzDNyJwGf21ybWbXfjuxsaBKpmAWIBf4tUxuRIh8kKsKCQMbFORcfXiSLhVPl1hLOU1a4oSWjLuSGYOJ8bax/JN6ULDxQ9NRXPwxED0NGS0QFHe+ySQ+hhIWVDc0zsmIZfBU50j+44VYGs/Nl/D/3AZx/Noo6zyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=CGcJ/42F; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 76927115F000;
	Wed, 14 Feb 2024 12:01:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 76927115F000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1707901310; bh=a5ajpumwk1I+jMeP7Lj73hpNOSeE7RGR+9+ywHTrOTo=;
	h=From:To:CC:Subject:Date:From;
	b=CGcJ/42FpqGYYm5ISrgn3MFoi4SQpwsdJWtP9fzPI4w1nPGztt3RpYS1DWWvFIVTO
	 Ww32DsRQWnW/W9qNQA9aJ/gQEao6Bsplc3lP0HlMBfxrDHa1V1sX8INfHczCmngyGd
	 6CJ1MUHNMC2lVw0/2NDflooZWE0NiGgt7jtsARrk=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 72B92310CF51;
	Wed, 14 Feb 2024 12:01:50 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Michal Ostrowski <mostrows@earthlink.net>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com"
	<syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>
Subject: [PATCH net] pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Topic: [PATCH net] pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Index: AQHaXyRy75DQaIgJRUS4Y1xFlKXgFA==
Date: Wed, 14 Feb 2024 09:01:50 +0000
Message-ID: <20240214085814.3894917-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2024/02/14 08:31:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/02/14 07:41:00 #23598261
X-KLMS-AntiVirus-Status: Clean, skipped

syzbot reports a memory leak in pppoe_sendmsg [1].

The problem is in the pppoe_recvmsg() function that handles errors
in the wrong order. For the skb_recv_datagram() function, check
the pointer to skb for NULL first, and then check the 'error' variable,
because the skb_recv_datagram() function can set 'error'
to -EAGAIN in a loop but return a correct pointer to socket buffer
after a number of attempts, though 'error' remains set to -EAGAIN.

skb_recv_datagram
      __skb_recv_datagram          // Loop. if (err =3D=3D -EAGAIN) then
                                   // go to the next loop iteration
          __skb_try_recv_datagram  // if (skb !=3D NULL) then return 'skb'
                                   // else if a signal is received then
                                   // return -EAGAIN

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with Syzkaller.

Link: https://syzkaller.appspot.com/bug?extid=3D6bdfd184eac7709e5cc9 [1]

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3D6bdfd184eac7709e5cc9
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 drivers/net/ppp/pppoe.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 8e7238e97d0a..2ea4f4890d23 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -1007,26 +1007,21 @@ static int pppoe_recvmsg(struct socket *sock, struc=
t msghdr *m,
 	struct sk_buff *skb;
 	int error =3D 0;
=20
-	if (sk->sk_state & PPPOX_BOUND) {
-		error =3D -EIO;
-		goto end;
-	}
+	if (sk->sk_state & PPPOX_BOUND)
+		return -EIO;
=20
 	skb =3D skb_recv_datagram(sk, flags, &error);
-	if (error < 0)
-		goto end;
+	if (!skb)
+		return error;
=20
-	if (skb) {
-		total_len =3D min_t(size_t, total_len, skb->len);
-		error =3D skb_copy_datagram_msg(skb, 0, m, total_len);
-		if (error =3D=3D 0) {
-			consume_skb(skb);
-			return total_len;
-		}
+	total_len =3D min_t(size_t, total_len, skb->len);
+	error =3D skb_copy_datagram_msg(skb, 0, m, total_len);
+	if (error =3D=3D 0) {
+		consume_skb(skb);
+		return total_len;
 	}
=20
 	kfree_skb(skb);
-end:
 	return error;
 }
=20
--=20
2.39.2

