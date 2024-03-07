Return-Path: <linux-kernel+bounces-95722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9088751BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88E7F1C21817
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050EB12EBCE;
	Thu,  7 Mar 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="KaI0YFnB"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C512DD9D;
	Thu,  7 Mar 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821434; cv=none; b=g47yxNeQ1np9TDMKLsdDV8TFIH1WuwgNCxX/TgJOxiEidhOeDxJ4tMtxiKyVeQsQqnJ2HporFi1tBmhFUXdHmXBDICxb+al95pmyQFSAFxVa/+Jr0hDbrT293IGH/otgHTHEl3unTw4KCLEOFuQyUw14rUzHisMdKZyFE4XyvWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821434; c=relaxed/simple;
	bh=ChQXRpwQELyvHAFX/iadZ4yeeIBqSARJLP39NfiniaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L7/yjUFtpNgo6rVPT8Ho3u5qSyJCQmUjRlAD+5Z5Zd1jabZBAcB2vQy2ZB1nuaDaWQ+S6JCo4h0iYfrEbb7tr/Bz38E116JlYalNp4DxAvh3lnUb/Lp4p+dYWTVx17XDpOhiHVNo5xZ4ixZ7BftuFz0O7PTHO5JNOkqiYl+cR/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=KaI0YFnB; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id C7DF914CD2A0;
	Thu,  7 Mar 2024 17:23:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru C7DF914CD2A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709821431; bh=JlK7qCntpJ/p8v06/wnF7QlyRzkrv0bD0v63q5kAbLQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=KaI0YFnBZFhtKtNC82wEzOLMnENDbn71eu2VlZYqsZUi/Fwd/XUUOf8Cq/RkxdL6j
	 vA6iIwOfzmHNwcaqMc2+bbPzw+Tr8c83faAcKg1m+7Ci3s6MlURQq/Cbnwr62tBGbP
	 Su8XlyTdaKq3p3y3NkmhUpv8M0KNW7NqQY/O7Dpc=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id C5CC431923B6;
	Thu,  7 Mar 2024 17:23:50 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: [PATCH net-next v2 3/6] ipmr: fix incorrect parameter validation in
 the ip_mroute_getsockopt() function
Thread-Topic: [PATCH net-next v2 3/6] ipmr: fix incorrect parameter validation
 in the ip_mroute_getsockopt() function
Thread-Index: AQHacJsTKFrMydi/2ECGLiuYnS8e1w==
Date: Thu, 7 Mar 2024 14:23:50 +0000
Message-ID: <20240307142030.2708698-4-Ilia.Gavrilov@infotecs.ru>
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

The 'olr' variable can't be negative when assigned the result of
'min_t' because all 'min_t' parameters are cast to unsigned int,
and then the minimum one is chosen.

To fix the logic, check 'olr' as read from 'optlen',
where the types of relevant variables are (signed) int.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
V2:
 - reword the patch description
 net/ipv4/ipmr.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index 362229836510..b53c36c473a5 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1603,9 +1603,11 @@ int ip_mroute_getsockopt(struct sock *sk, int optnam=
e, sockptr_t optval,
=20
 	if (copy_from_sockptr(&olr, optlen, sizeof(int)))
 		return -EFAULT;
-	olr =3D min_t(unsigned int, olr, sizeof(int));
 	if (olr < 0)
 		return -EINVAL;
+
+	olr =3D min_t(unsigned int, olr, sizeof(int));
+
 	if (copy_to_sockptr(optlen, &olr, sizeof(int)))
 		return -EFAULT;
 	if (copy_to_sockptr(optval, &val, olr))
--=20
2.39.2

