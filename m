Return-Path: <linux-kernel+bounces-95723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF48751BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 15:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68F4285EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A7D12F36F;
	Thu,  7 Mar 2024 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="E1JahAPK"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EF12DD9F;
	Thu,  7 Mar 2024 14:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821434; cv=none; b=gxCGHrKtCw2+SvUT0vVKHfWO3LH2XwPVR84R93gvbabRhq0OqH/pF/t65mwkSkDh0tps+24lUcE+PkRPbcnCqdWCZR788+pvoL6bFsURW8/DHf1zikGL1Fy9KSPsuFIruqMq614g+n5nR5BY4sNrePGdQHnj8cdb1GA0UNZ/6zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821434; c=relaxed/simple;
	bh=g4ZkBhJpsWE0qSkIlEwHDqZ9TzttHbtsGqgkmkuhIn4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HwZLJ9yO+NCCqAYubsdVIduqMTXnFTcyyCUeoWhnHMgXQB6O7XBwUeURxScdsuKlx57Vxp0VpxjxpTVQLgWoxlNxDFhBhTt15qA4ZNBJY/REZt34dEdsjvUA1RvwA7m2a7feMUP7fRA77mCJQOnoPZS5dIKlQ+NDVARxl14fo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=E1JahAPK; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id 089A914B178F;
	Thu,  7 Mar 2024 17:23:51 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru 089A914B178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709821431; bh=O5iwhDlAepukVWY+P4hL2O/eL/fnQyj+EFmoAC/Re8A=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=E1JahAPK0CqY8DUAK4d2ZSsy2OsZvwR6STJZaWb5Gjnaphk+4VGix8nhPhXN376Qb
	 tHZK/9bByO4t+GOXk58zi3BtsCcaj/cXrx8T3dkpglThq7pmFbBhdnhamV75HDQMOh
	 WF4Mhi/7/xctG9d27cuw4kUNItsENqjFt1b8jgmU=
Received: from msk-exch-02.infotecs-nt (msk-exch-02.infotecs-nt [10.0.7.192])
	by mx0.infotecs-nt (Postfix) with ESMTP id 026C531923B0;
	Thu,  7 Mar 2024 17:23:51 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: James Chapman <jchapman@katalix.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, Tom Parkin
	<tparkin@katalix.com>
Subject: [PATCH net-next v2 4/6] l2tp: fix incorrect parameter validation in
 the pppol2tp_getsockopt() function
Thread-Topic: [PATCH net-next v2 4/6] l2tp: fix incorrect parameter validation
 in the pppol2tp_getsockopt() function
Thread-Index: AQHacJsTzWqvqc9TOk22k8aDbIup9w==
Date: Thu, 7 Mar 2024 14:23:50 +0000
Message-ID: <20240307142030.2708698-5-Ilia.Gavrilov@infotecs.ru>
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

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")
Reviewed-by: Tom Parkin <tparkin@katalix.com>
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
---
V2:
 - reword the patch description
 net/l2tp/l2tp_ppp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index f011af6601c9..6146e4e67bbb 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -1356,11 +1356,11 @@ static int pppol2tp_getsockopt(struct socket *sock,=
 int level, int optname,
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
 	err =3D -ENOTCONN;
 	if (!sk->sk_user_data)
 		goto end;
--=20
2.39.2

