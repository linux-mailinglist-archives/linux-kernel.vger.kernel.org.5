Return-Path: <linux-kernel+bounces-93700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59146873389
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5965E1C23011
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4B35FB9D;
	Wed,  6 Mar 2024 10:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="mi4Yy9F5"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0D85FB8C;
	Wed,  6 Mar 2024 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719502; cv=none; b=UAJ/sNzDMcFMVCyebJl4Ddfif3IitXiAksnZ5kb6nHVvelSGnfasze/otuBKm2uHcAiXallXb0eVSTgk/LXSJm0YQHSRvrHZ1kcLskVEVt/3ELQtebRliuUxLv2x6ZdkiYTzxF7WJQ+lHDwcDXSSsYIDVNmIO7HBqrYCYGX0S6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719502; c=relaxed/simple;
	bh=Xx6fuMijWmbCZ68HGYxzw2XFhSveMJbNuQ55fTD8vyM=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jy8K7dUu1urXGN65F7xomN+Y/g/HZhaIefUORxgfqCgpNNK5XmQbjlIiKZHggCdXfzGpZSU3LKlviPiRNojZoRwUucLMJf3Ru+Ovjv+nIJ4vjehbTSNCgsANAzgoMwbN2PLFEdPiVT2YB4WJdy/D0dK8DX4ReceQE3OvJHAHIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=mi4Yy9F5; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id DEC201423784;
	Wed,  6 Mar 2024 12:57:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru DEC201423784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709719071; bh=MO5pj3YzaettEmio8Z6W3c3zdCICCzph1tchXffqFi0=;
	h=From:To:CC:Subject:Date:From;
	b=mi4Yy9F5aiqk54JaClW5h6c9Gec/kRoaj7FXX9qxryuWIghOXRki8XdrSsz5LVMBN
	 EXog8AwH911oOB229tNkwriQu9b6EEzuzBmEMcHVES2XReqknLywhd9xJzA7s2/yEK
	 u7mVLQD73atAokkuKX9UHUtm9dciPepvwaYCI2LY=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id DB8FD318FDDC;
	Wed,  6 Mar 2024 12:57:50 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
Thread-Topic: [PATCH net-next] tcp: fix incorrect parameter validation in the
 do_tcp_getsockopt() function
Thread-Index: AQHab6y/ymlnx20eHUyJFqMhxuWaSg==
Date: Wed, 6 Mar 2024 09:57:50 +0000
Message-ID: <20240306095430.1782163-1-Ilia.Gavrilov@infotecs.ru>
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
 net/ipv4/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c82dc42f57c6..a4f418592314 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4010,11 +4010,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
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
 	case TCP_MAXSEG:
 		val =3D tp->mss_cache;
--=20
2.39.2

