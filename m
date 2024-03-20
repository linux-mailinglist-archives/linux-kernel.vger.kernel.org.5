Return-Path: <linux-kernel+bounces-109019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1194988136D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E02281B45
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F864AEC1;
	Wed, 20 Mar 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="ZEqyDKdi"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EED482C2;
	Wed, 20 Mar 2024 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710945410; cv=none; b=QdgFTa/QZ6Z0yXF0QSvkqAXlSsYOLSXnR3NY62jXTff8yPJGAi3u4PkIn90ZkJIg4wU6jaJ5ccI0guETWD3GluVKjO8B1EELDHTiNNMtsReLFr79dZdlfJltAo6ETa6QeR0sU2bb9QklAMgCm4TxNtQ3uJnAeaNftBVTLnnfKys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710945410; c=relaxed/simple;
	bh=rKmkWc4e2EhEBiayogKPrTMTuUv8pY/OTgZiEvSpCqg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TnOJYFaIoEPj2bPq69wisQ5k8Rv3ErRqFjkGrFK/vUibTfFKyc0zTcbifnDIWAMlgTM6XZQfVCqvnaFIfzI6esAsBB6Ffi4QPzPjLDSMfHxSOMEcCgTjYhLiyqAQb3aN6P1YT5IeN0Sq3x8wWJj93OLKttI5bXvUn/hEb9S5E+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=ZEqyDKdi; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id A30BB10DD2A5;
	Wed, 20 Mar 2024 17:36:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru A30BB10DD2A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1710945399; bh=EUA97dIpRpSS5ssM3JPMExLE+bnjf2A0BRQL9P73M7M=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=ZEqyDKdiAanHARG3ItZDGA9sGP4gQa6W7cqU7/qNTtSpEAfurbtXd9F3AVnhLM19m
	 AAk+vkJt/mWZ2PPpgmk1LhXkz4f6YSD5cYEu2sGzFZbduhoNFlm9o6UlexiG0nCXGi
	 ji9V+2ibo33iJzsQ66n9LzrZVNpmLGhQyNgAU/9w=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id A0DFD30B3690;
	Wed, 20 Mar 2024 17:36:38 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Michal Ostrowski <mostrows@earthlink.net>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>,
	"syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com"
	<syzbot+6bdfd184eac7709e5cc9@syzkaller.appspotmail.com>, Guillaume Nault
	<gnault@redhat.com>
Subject: [PATCH 6.6/6.1 1/1] pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Topic: [PATCH 6.6/6.1 1/1] pppoe: Fix memory leak in pppoe_sendmsg()
Thread-Index: AQHaetQEkOAKLKqGI0iXqJKxr6PViQ==
Date: Wed, 20 Mar 2024 14:36:38 +0000
Message-ID: <20240320143637.2904385-2-Ilia.Gavrilov@infotecs.ru>
References: <20240320143637.2904385-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240320143637.2904385-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2024/03/20 07:32:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/20 12:55:00 #24319174
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
index ba8b6bd8233c..96cca4ee470a 100644
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

