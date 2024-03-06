Return-Path: <linux-kernel+bounces-93683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A56A287333B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 452861F2185E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC95EE84;
	Wed,  6 Mar 2024 09:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="f2HS95sC"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05E5C5E9;
	Wed,  6 Mar 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719088; cv=none; b=HqhCB4+0phtsbPYshMfYL7vgNIQ1w0nZCoJZZJ9AB97u9PO/DhsJNDbZVZEg/9BEsBiR923H9HS7c9rEM4gp6j7904tsPJLTmrWvKKD1kK0XySsMlwDL0yY1SrDOMQQaWgYVPycGOnLBzmoiQsrTI3g3L0EVkoFwhvRefoOhIdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719088; c=relaxed/simple;
	bh=4ioKQ/nOp6xyo04Xsr4UDWEtOzPFwtdXdGx2dvifl/0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WL63ZsflncI3XsrvjlUlo9HIep4ooCHb47v1FbG3Xp+kW+bpb2h/nhyvCoW1bFnGzW0tOA2uYIMuuQhTh90Kzs1b/ahC0ABDALPhbHKS1HGcOWSzRg2BANI7K/1rsUQqmtWNoL+MAjjUevf99sd4LR62OF1SFUv72Bvp9hrR7NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=f2HS95sC; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id DF7E71477314;
	Wed,  6 Mar 2024 12:58:03 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru DF7E71477314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709719084; bh=6Fzre7itsivmwf2v31gzP1S9pau16wLWG4JK2e8cN+c=;
	h=From:To:CC:Subject:Date:From;
	b=f2HS95sCPu8ow0zWXnO2CFzUsRUj3RnLgmqcvd+uwyRI6dJ3Ai7pwLMRyPRsm/5tp
	 pZjdmnVFw8WaXJ5ZfRGMqtNs97GJSyIHiak35PKqoC3OB2urAebw9LCxN6F4DRhvOc
	 U2vdmHho6hRxNSA3GAB+f/du8XFVKWhqK7mKnRhA=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id DC10631359F8;
	Wed,  6 Mar 2024 12:58:03 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: "David S. Miller" <davem@davemloft.net>
CC: David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next] ipmr: fix incorrect parameter validation in the
 ip_mroute_getsockopt() function
Thread-Topic: [PATCH net-next] ipmr: fix incorrect parameter validation in the
 ip_mroute_getsockopt() function
Thread-Index: AQHab6zH42aqoKeJKUqv8HJLea1PvQ==
Date: Wed, 6 Mar 2024 09:58:03 +0000
Message-ID: <20240306095443.1782307-1-Ilia.Gavrilov@infotecs.ru>
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

The 'olr' variable can't be negative because all 'min_t' parameters
cast to unsigned int, and then the minimum one is chosen.

To fix it, move the if statement higher.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
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

