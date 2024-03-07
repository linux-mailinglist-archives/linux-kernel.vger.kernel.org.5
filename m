Return-Path: <linux-kernel+bounces-95720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9DF8751B8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7014C282EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C867A12E1F6;
	Thu,  7 Mar 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="OgaYGJi/"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5834712AAFD;
	Thu,  7 Mar 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821434; cv=none; b=TOcKhVQw0hgkJlpaXZMA5UimfLL9dMg/bIYYvZYSt/GrAV5NJwNz9RZiacPijoKNLiDcVaXwMtHlxKpiBWyv9vI4y2mUqlTOTecC9xtKrF8R1fvBG+grw7n2ZI/icKd0A1hQlPXdwkPYzOOLyvinioqeK3mM0eHmcGfEdxrnJz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821434; c=relaxed/simple;
	bh=58Vi20+IOZegSmkJsjvP31zlo1I+IWOSZUs2BECCUmQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7m7dM2SQ1oMrhyh3ga8zWk1aWAB0bMxYk0VqeT7pjqAHWqoWH81CffCgJZzJewJa6MfHJuriiwFCNndNOZP9WGCyNxZ0HAvFNJgRcjMobd/CWJUdQu4dIljnYbDO1x1khzeTIqLW6Gxg4WljtObqqOfdrlzXeqGVK3ZIm6oUSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=OgaYGJi/; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 6C74414B179F;
	Thu,  7 Mar 2024 17:23:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 6C74414B179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709821430; bh=nG3okypY+wh5+yhVmWkAdCJ6RNrt8IrH6LYqUsbjAY8=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=OgaYGJi/QVZsuV8RtAESMRsj/4a4eXdOvxZRdKDH9FnMWj2TH5gFp53+FHI13035R
	 cTCVJ9+9w1gfEFUIM3m3EmCTSU0JgkJeQBtKSrvwpJt3ynBvWR60VYQ+a7NCD31T/W
	 HMoLrHfbcgVH0CEWXa2w9IeQDLcZSfOwZYXE+ARk=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 69FEA31923A8;
	Thu,  7 Mar 2024 17:23:50 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Eric Dumazet <edumazet@google.com>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net-next v2 1/6] tcp: fix incorrect parameter validation in
 the do_tcp_getsockopt() function
Thread-Topic: [PATCH net-next v2 1/6] tcp: fix incorrect parameter validation
 in the do_tcp_getsockopt() function
Thread-Index: AQHacJsSTBdVqUkgdUuyCCq/rsgplw==
Date: Thu, 7 Mar 2024 14:23:49 +0000
Message-ID: <20240307142030.2708698-2-Ilia.Gavrilov@infotecs.ru>
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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
V2:
 - reword the patch description

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

