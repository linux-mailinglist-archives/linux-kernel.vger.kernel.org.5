Return-Path: <linux-kernel+bounces-145020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFF28A4E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 271D31F211BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71FFB6A352;
	Mon, 15 Apr 2024 12:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="Efmw0K4K"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED9D6773D;
	Mon, 15 Apr 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713182416; cv=none; b=O2yBaEpFeo+O+MhNTzsDtofygdgM+SYYvrX+kbDcZLfnosLQ1Wjy1l3NVGoXym5B/kXUDbSMdFywWj0q0Qfa+VpMKu68VCAaOqCmSCTb6fI62LmuciSnIJSUz8YDKOU/ERVEuRHVzVgjTHXbLhveV0ecuNufRMf5TyK4nbCE/Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713182416; c=relaxed/simple;
	bh=xdkXLTjX4qL3edwOuO8rfLWQ63xxlhDmf1ajv6sg25w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LRmnsHREWF6jtEd/B/XLfc+KYQ/hRPIoFA6PDKoqR0ckT09KuVMuS1nG0JSmBCU1ZpDhGMT873xFQ264Soob8BdxP0ZsWfY9emf+X//1CaGuQTG+F8/2L+iPkTH2AduELLDX30SngQ39A+UaAzH1GL5Ax8TxXBJKpeZy4SIVf4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=Efmw0K4K; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 5DB7210762CC;
	Mon, 15 Apr 2024 14:50:19 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 5DB7210762CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1713181819; bh=a33yPWb/C33fBYRJJep/1wpeJxiDK13njMNqRF39n+k=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=Efmw0K4K6yko4zvTC1vf2LccubAJAwlL0iIkFRRjNEJdkq59iGGIjzL3+ttep7KPB
	 6lzXS1wk7ERr74Y3G78ISvXoythx9Ivy5PKhD09DTas9tcRDdIhfhl0BcqcLyEqRVE
	 jrF8JyOhvxPO64YDKmtwEz3H7Rkm73BUBSsO5TFc=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id 5AD3A3006661;
	Mon, 15 Apr 2024 14:50:19 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Michal Ostrowski <mostrows@earthlink.net>, Guillaume Nault
	<gnault@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com"
	<syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>
Subject: [PATCH 5.15/5.10/5.4/4.19 1/1] pppoe: Fix memory leak in
 pppoe_sendmsg()
Thread-Topic: [PATCH 5.15/5.10/5.4/4.19 1/1] pppoe: Fix memory leak in
 pppoe_sendmsg()
Thread-Index: AQHajysWcvyWTlXZLk6c3r3cyxKdeQ==
Date: Mon, 15 Apr 2024 11:50:18 +0000
Message-ID: <20240415115015.3913760-2-Ilia.Gavrilov@infotecs.ru>
References: <20240415115015.3913760-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240415115015.3913760-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2024/04/15 08:48:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/04/15 09:42:00 #24801259
X-KLMS-AntiVirus-Status: Clean, skipped

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

commit dc34ebd5c018b0edf47f39d11083ad8312733034 upstream.

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
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Link: https://lore.kernel.org/r/20240214085814.3894917-1-Ilia.Gavrilov@info=
tecs.ru
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ppp/pppoe.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index d7f50b835050..70e29e1ac4c8 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -983,27 +983,22 @@ static int pppoe_recvmsg(struct socket *sock, struct =
msghdr *m,
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
 	skb =3D skb_recv_datagram(sk, flags & ~MSG_DONTWAIT,
 				flags & MSG_DONTWAIT, &error);
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

