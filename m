Return-Path: <linux-kernel+bounces-95724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4998751BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364C32860E5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191BE12F584;
	Thu,  7 Mar 2024 14:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="BHDg436W"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C0912D745;
	Thu,  7 Mar 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821435; cv=none; b=KxQgsfD7QZlf2jOH6s3rGLdfJ9McvchUE13coP/kV9iwjkTlq8C7t0pEmAdrYhlKeoOaPZ6qQStlAj0qheswNM0tjo/exh2addlkMBV3ksSW0rQA4EZuDnjXChnB8GyltXOw/ZleDPtTG2zhGrbHjL5cr9IiWda+o2MXJhsVfaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821435; c=relaxed/simple;
	bh=CEXkOS+mriQWsWIUYob9llJ3dlmRIkZyGVNcMX66MRQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B4MGGbLbo1nDpGED9LGHD5fVdUOO0Ib2SeSG0q10y0P64KU+6GFn5knKLwr3pgwfM0XhorHMhNxASF2wtxGdkUoG/unmWjc66MATYz4juiwH1GAHh2k8k+JWkqh6hhnwnHAGefbcXCemt3scu4jxPJTRrNz3mbkdcs4pf23Grr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=BHDg436W; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 9E4EB14CD2A3;
	Thu,  7 Mar 2024 17:23:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 9E4EB14CD2A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709821430; bh=jwhtPOdDBSnbts5GSh1Hp50/yNRBHBaJHIGVXA5KGK0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=BHDg436WgP0hlp57M+1zZLDvLpDPdST9IJk9inpZGrX3QoU1kwxYrleLbqICi3gHL
	 QoEcogViHS5b3jihvPMxcSvvQah2x3IVQR3IncyCBLChMWIW8mkV3lThxCGtFeRFcB
	 zfKdKlkla7/N2Kan8Ym2UplTiwMxvq5/NX7CoPpA=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 9979431923B0;
	Thu,  7 Mar 2024 17:23:50 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
CC: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "Willem de
 Bruijn" <willemb@google.com>
Subject: [PATCH net-next v2 2/6] udp: fix incorrect parameter validation in
 the udp_lib_getsockopt() function
Thread-Topic: [PATCH net-next v2 2/6] udp: fix incorrect parameter validation
 in the udp_lib_getsockopt() function
Thread-Index: AQHacJsSjDbf8+7IiEaacwBYhQfFYA==
Date: Thu, 7 Mar 2024 14:23:50 +0000
Message-ID: <20240307142030.2708698-3-Ilia.Gavrilov@infotecs.ru>
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
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
V2:
 - reword the patch description
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

