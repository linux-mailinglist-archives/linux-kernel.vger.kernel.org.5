Return-Path: <linux-kernel+bounces-91257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05457870BD4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE2671F23480
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F6F11185;
	Mon,  4 Mar 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="aYPA7vlp"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07362FC1B;
	Mon,  4 Mar 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585428; cv=none; b=sBWZ63rQ1xj3lhQ8KJeTbbHCLq8W9afDJd2Y8ZloqGytKmuG5/S2iWYstRhLln4y+NcTfU+fousKHahoy0ObN5lS419WE/LIQmcG/acHrUwjp6c27ypvM10W5oaPkB8A+X4VJiOgK+EnPHT/TwWTBOrBt096isZpztKWWmnZqKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585428; c=relaxed/simple;
	bh=InnDeg4KpYAOhrHNOuqCqXKDex+tZ6eqIRBXCC4IeJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aNL0TAUW93dCOJVOzShRYuFfIIzatXjc8HSRqrdBiuVtYgwIp4rGb2pEoGTpYI4qXWXcnOCNAHxSyeFU0XUn44U6vqimmPtUUvlJJPP7LFH2ZlDh489hyRIQZbQO2nTNzSfyyuvvUhLV1lysUYU+BF3Sdt5t6a2hm1LM2/ASkKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=aYPA7vlp; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709585416; x=1710190216; i=w_armin@gmx.de;
	bh=InnDeg4KpYAOhrHNOuqCqXKDex+tZ6eqIRBXCC4IeJk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=aYPA7vlp5PqwyVMA3XGFOTxV/ZK7dFHxvJNZNRRPRPNTvRfGc4HDaSclKzr7nrD3
	 PKAaYyBAxfz5qeQSOXeo7crd15X3HNS0r1uTWpy++pU6AdLvjbxUk7kJJ8I7alkzM
	 OGZ0Q0RPYG3dRUrQ9V9Djas0UuYr06mKb+6AWKFXNRphRVYjHo0yKPpYZqfe8tEbM
	 pGfd8zSXzd0J/TwrXiR6/FyJTuXQHfSHqW8B90nVkVTzCHtoIIhfK4wVVTZfV32zz
	 rxjUSmgNQG6lniEWG7RT9l5CGlGme9jZfySEPXvgSXEZxNCTXG8l9GT/5pNNQ9e4I
	 zMh4XERlQ7vhRDSf/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MO9zH-1rWaAb190z-00OZ9r; Mon, 04 Mar 2024 21:50:16 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] platform/x86/amd/pmf: Do not use readl() for policy buffer access
Date: Mon,  4 Mar 2024 21:50:03 +0100
Message-Id: <20240304205005.10078-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304205005.10078-1-W_Armin@gmx.de>
References: <20240304205005.10078-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c2SyZgQJ6gZfFEESo8W5Hr/xN00pZOAEr2Hvs0hHw7vJMBllFb3
 1izj5y7Je4SPe3ofpwh74FL3lU+oYPhJEKZbtlxXp6+grOnPZQv+/UbUUYEHiPQU5Gknz0M
 zagUELqKKq3cZ8GEbTeiNe0v19S/xg3/93MxoeP86l39ygZA7zSay7MpqXiDnqTUzQQ8t2I
 uMgGGMzQ5sKwxhD5VpSwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pEZeRv1Hvlg=;sLZliRcOysRVcz3Z6ioV6gdLwn1
 R6SQr/rVYPqlRjppHHhsXuPS3k3Evq40qI8pcqDRPrQBovIVu+j+6x134v4m5iQmZ4JEy2bm2
 cdSXuyoAyvQCvr+87Um7XO/8lfPcNJEkEjOAO0dpVpbsAK5XHk3JTuN5HOo+9+4tEm6/TBc30
 eEtTsmQh8cGWQaR2S/9GQm+3+neh4DDsWo5WtuLyOy8WPKtHt1WiXOU4EDwmHIrZi53RsZpUX
 PMadGfDsrXakY/eshIMHuxz9veYXu1YuaBse+1MQCtcJznoBNaMI25dzKrwadwwV4gUDwGmJT
 TfzLs9Hp2I9EbVq7zQ1oi6Kxbv9bJpJ5SdSJ6xyIi0MeqzOWwtTm5G8BHZPtRwPGL/j4EZDDR
 xqD2SNk2O0PDcymDa1NqqKt3opF/n4kLxE7srHgvTD0/cma8Ik3iEPzi2o+5kDZf1IriadPP6
 5bLuXTcOIhIzjAfG3C1uf+Do87lm7atIhIzLWcT+gvi63PM3IGyfWVOhPav1PHu0ZL+i15Ihz
 efx5QCD5mrIL+a2Ot91ej4TgKT9qmpnXznASngfiT6bFAWqyrDUif+dcZS6tg3u1ypZh9Grwx
 i2NzfmIzheouhdA+HflkGA7M6Eh9760KFngbwUElR8wPQ83Kewxepm5TTHBp+uLpDo6zJSAl1
 vuxchguwgh5S4NLRAyQX1ipwCIvbGE13L2h72AvJYVvK0MDQneRk7fobepeD6OM6fio39sLlK
 1DZ5yFvWC4sEx2zR0qno4QHE9/Vsi3yBMmYXNZ5kOYeQrPDgyegis2urRi4CnitQfZwfYy+yT
 Q7KPjHqSyrXAbXFT76Szqm5QwrOFu4u3qtvwsF/bwbnWs=

The policy buffer is allocated using normal memory allocation
functions, so readl() should not be used on it.

Compile-tested only.

Fixes: 7c45534afa44 ("platform/x86/amd/pmf: Add support for PMF Policy Bin=
ary")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/tee-if.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index 13dd4462e1e3..58ec2c9606e1 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -249,8 +249,8 @@ static int amd_pmf_start_policy_engine(struct amd_pmf_=
dev *dev)
 	u32 cookie, length;
 	int res;

-	cookie =3D readl(dev->policy_buf + POLICY_COOKIE_OFFSET);
-	length =3D readl(dev->policy_buf + POLICY_COOKIE_LEN);
+	cookie =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
+	length =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);

 	if (cookie !=3D POLICY_SIGN_COOKIE || !length)
 		return -EINVAL;
=2D-
2.39.2


