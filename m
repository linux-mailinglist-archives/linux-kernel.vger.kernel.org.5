Return-Path: <linux-kernel+bounces-95725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8F58751C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7127EB26628
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAFD12FF89;
	Thu,  7 Mar 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="oGEL0RdJ"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDE12F38E;
	Thu,  7 Mar 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821437; cv=none; b=DZNC0OW55ozbiWPa81mW+zhxRcAZRnIhI81vTLuvetzqwdTIz7EW/EuhznNJilwvOb58wpUtgW7uJn/Su80bIyjumEC1fZA0BOn++sdx2NAbRJoKCBzpbwZWk5sOkZq9wEpy/vQi0kKDSx5o2MDZffbmFCtQB2NQepguSDrOeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821437; c=relaxed/simple;
	bh=ik4mZx5M3IIhRc3Lmc3wxa3pGWHfYhX4OQNjFJzgBtw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k4S9tz7xtXfWHFmoutkoyc70YXFbXdLZGhmPPPJCIvFb56nkTwp8Jb1UkdCnCQAQ/ipsCsuJcQ+vxDJriOC1h0/LqmDbiDco/UjieaLVcdF/+EQ4CfWebYyQ9VwdD2NldRGs7sQAGA21T4G5rowXHO7SxP07RGqVDcYZzXvwaM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=oGEL0RdJ; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 45FAD148BC8D;
	Thu,  7 Mar 2024 17:23:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 45FAD148BC8D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709821431; bh=wLBmuF843sLrgBGQEjfgUIwkJeOumtJJVkyPbV28dCU=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=oGEL0RdJXnZ2QgcH7GThdeDY4Ws4sAGVkwJ3hwANuvMK6nKdFIsz/9n9qq7fetTkx
	 Zrb77yOGtxB4a7BTa6LJ3CEQRXtUY/8AmAQDql8H7JCu+TUNmi4/nG4iPXkrUgpUcE
	 zMVrjPWkoI8L4NDz5IIAsQZdNQHrQ4LSKUm+Xe78=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 43BE831923A8;
	Thu,  7 Mar 2024 17:23:51 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, David Howells <dhowells@redhat.com>,
	"Shigeru Yoshida" <syoshida@redhat.com>, Mina Almasry
	<almasrymina@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Tom Herbert
	<tom@herbertland.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next v2 5/6] net: kcm: fix incorrect parameter validation
 in the kcm_getsockopt) function
Thread-Topic: [PATCH net-next v2 5/6] net: kcm: fix incorrect parameter
 validation in the kcm_getsockopt) function
Thread-Index: AQHacJsTlBzhET07pkKLeUDmE/Hj1w==
Date: Thu, 7 Mar 2024 14:23:50 +0000
Message-ID: <20240307142030.2708698-6-Ilia.Gavrilov@infotecs.ru>
References: <20240307142030.2708698-1-Ilia.Gavrilov@infotecs.ru>
In-Reply-To: <20240307142030.2708698-1-Ilia.Gavrilov@infotecs.ru>
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
X-KLMS-AntiPhishing: Clean, bases: 2024/03/07 13:22:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/07 10:14:00 #24028863
X-KLMS-AntiVirus-Status: Clean, skipped

The 'len' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'len' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: ab7ac4eb9832 ("kcm: Kernel Connection Multiplexor module")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
 net/kcm/kcmsock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 1184d40167b8..eda933c09792 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -1152,10 +1152,11 @@ static int kcm_getsockopt(struct socket *sock, int =
level, int optname,
 	if (get_user(len, optlen))
 		return -EFAULT;
=20
-	len =3D min_t(unsigned int, len, sizeof(int));
 	if (len < 0)
 		return -EINVAL;
=20
+	len =3D min_t(unsigned int, len, sizeof(int));
+
 	switch (optname) {
 	case KCM_RECV_DISABLE:
 		val =3D kcm->rx_disabled;
--=20
2.39.2

