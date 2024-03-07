Return-Path: <linux-kernel+bounces-95726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E28038751C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7213CB2657E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E8012FF84;
	Thu,  7 Mar 2024 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="CSKC6bon"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18F412F398;
	Thu,  7 Mar 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821437; cv=none; b=WJzlJUUEl/OH+mHmMmZ/vAplUwQvv3TlSmTceJTlqViv3VPpFXwSSlCvHetjdy0Ck69iiEaLdxnaf908+C7aDpoQhgDo9Psf6+4BbBm+xvW+9V3qT0WmbHvtVPhRt0szabn015U5QvjsnrcQbkLlUrVvYh6TrCIuAw9bh50DThg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821437; c=relaxed/simple;
	bh=vtO1NLo5DUmetb6YbznmKN592S3ILscEX8TxvmHk+mM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JhoV89O2m5DPjF2IyHNii1qKoTKDe3DX4Shy+lBv2g2MvJ40qvXWAOblkBRZAGVeSH0a7/uwrBMBkHDG6dpFxgnzt9eY2M9gMf54WRruOg8Z4SiDKBkvcDhr55aumHBPB01tKEZjYYRJODR5AZEZtKLWBTubLs8E/mCjkB47bbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=CSKC6bon; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 645FA14CD2C1;
	Thu,  7 Mar 2024 17:23:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 645FA14CD2C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709821431; bh=TH5DEcHLIXFsRrfmZsIlzESb7JbDicH3qRJLGnlj6io=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=CSKC6bonPljDwT3yx3aRwX2VOnIFebvFMfc8W3Je1y75GndH5uCu9+Qm5tULHif98
	 ExnPzMWxYYjLPEmSQoo6dgI5+fwQSyGVs4XIJ+wuVLyob84qrQZOuCh6ysmRF50htN
	 zM/YIQMiAvcFzinAbhKliDCNSXfMk2LeMLlf3INw=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 60E2231923B0;
	Thu,  7 Mar 2024 17:23:51 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Martin Schiller <ms@dev.tdt.de>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: [PATCH net-next v2 6/6] net/x25: fix incorrect parameter validation
 in the x25_getsockopt() function
Thread-Topic: [PATCH net-next v2 6/6] net/x25: fix incorrect parameter
 validation in the x25_getsockopt() function
Thread-Index: AQHacJsTcTQB2aBL6kWXuOtcpnTzVg==
Date: Thu, 7 Mar 2024 14:23:50 +0000
Message-ID: <20240307142030.2708698-7-Ilia.Gavrilov@infotecs.ru>
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
 net/x25/af_x25.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index f7a7c7798c3b..d18d51412cc0 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -460,12 +460,12 @@ static int x25_getsockopt(struct socket *sock, int le=
vel, int optname,
 	if (get_user(len, optlen))
 		goto out;
=20
-	len =3D min_t(unsigned int, len, sizeof(int));
-
 	rc =3D -EINVAL;
 	if (len < 0)
 		goto out;
=20
+	len =3D min_t(unsigned int, len, sizeof(int));
+
 	rc =3D -EFAULT;
 	if (put_user(len, optlen))
 		goto out;
--=20
2.39.2

