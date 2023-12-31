Return-Path: <linux-kernel+bounces-13723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C491C820BA8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 15:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C1541F219E5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 14:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB12963CF;
	Sun, 31 Dec 2023 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qoRmw7rL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D709567E;
	Sun, 31 Dec 2023 14:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704034696; x=1704639496; i=markus.elfring@web.de;
	bh=gPeNin7ZI68tdFqinqaBy+vemPELROI0zDhtVnj5Qdk=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:
	 In-Reply-To;
	b=qoRmw7rLE3imcfRlnd7KwXnQQLZHBOwEuL6y2JV6TC0NvTcSKswMNa+IrSjil+wK
	 +vp/dzbL9DzPTevbILfI3Dbgj2oV0t3fSN/GF/fTn8psAFVA5v/Yfk5VYE3MBwLAW
	 FZWWC7zJRhRLZalVb4rZ3r7+ULFH5ua1tsF96QysMbk1/cc4chNxITWGnhKAg5a9G
	 7aVyHVZJhp2zxDw/adgNjcdUBPkzZ6Jyo7DtPVvCXO48VezS3D8c5mLsyFVeNUDij
	 aseSKK1+ibexNYRINIWJAQPrlvbrSxgvK2cx/H5MXiVoV7WT11kti7nAQgr3mTJyc
	 FWu+mF8WDOH1dLKXHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mt8kX-1r4DfF172v-00t0YO; Sun, 31
 Dec 2023 15:58:16 +0100
Message-ID: <f02303c3-5968-48c3-990b-be0be8a66521@web.de>
Date: Sun, 31 Dec 2023 15:58:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] net/smc: Return directly after a failed kzalloc() in
 smc_fill_gid_list()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 "D. Wythe" <alibuda@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jan Karcher <jaka@linux.ibm.com>,
 Paolo Abeni <pabeni@redhat.com>, Tony Lu <tonylu@linux.alibaba.com>,
 Wen Gu <guwen@linux.alibaba.com>, Wenjia Zhang <wenjia@linux.ibm.com>
References: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <8ba404fd-7f41-44a9-9869-84f3af18fb46@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NFasV8DHiXAdOQ2Yt1SU4XelxafXt3W/2zfsYc0p4Q+GDO3yPiS
 LLrJI+PyVtxxsmJ3RJ7FweRyjQdttD5guFeI4nnRM6rd6vkxykjF8fQnNrNZfhOFdU+WsV1
 5UvfAQLdQuqOtuE1v/BBq8c8c/A+V3qWWyjk/ugt9++mU+cDIslgqdco1vrtXyRXVDImZqd
 BIEcmNDCu+rK45VXeY4Eg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NRWMyYBZErQ=;lSeCc59AM4dR0tqYtgjUHNs80j1
 y7ia6cpPN1KXri4Ec9dhPWjXB3aJPVh8N2DtbVrRXmE5YaZMwDkoWz3J2PcYJHeekvWqQfAFg
 hwsyjaDxXbxRVQJk6oPvid5YDPLAwCSD49URlz2wFt7Rb8XSj66uicguPLQBnQBtoJeytf76z
 nGrV6V7jGB4k9IuBT9h43N3lfVXoo374ROHtfNmoN2L7kYTrKRYIAr/1Gr0vxYZy1xMMqn+k3
 qWGBS0zLMwzG+Wj8u2Jbm6k06BL4qvGeicsTG8zF/hx2qnvruQS5B8/CjrnBojLpfRzmKn7Y9
 WOvm9Uqs6vJphiUTL3Z0/FPlsL3rx2x6rrVLeFHTdLMHrzbfkuGHWsExj6HPgYu6rj1HzAIgy
 +vyGIAN8J9tDr+K7ureshkwoZ6xHeqmiJcnw0Hg+k8nf0OHTqDGrtxV1G/dyizPT1AEIv56L5
 QPSBd7tT6g2f3LQwvTIDBPKelYL/0lAFb94UvN7keSdJaij3G6UikDlFydv1x7cwe4MFWiwGW
 TGm/1xPgkB+GnWN96F6B/FlxfFojXPnRBmUMs2AzAw1oM20Y4qrvpqM0ikkF8IKCqcF4IpOns
 a0DvWrA2Vm/NUV7ITDU3lAxl4SDHYcR1bBfx12xN2p9iG7LFH0NtdYn8rQW+RqL+syBv+vHjB
 ABnYRNYOoEVxT9jCRm8Y0tY9Ac7DJN2GN4muEyEVQaBRTznbJjuFrsmAS7S0W85UIhU3oGhFo
 k+vEhBsRrWaG3fN/s4ZuU7yP29D25u41TyiQMb5CtrfO93S4ASfLFxP2qYLEFg+C5BBd7zwjn
 xUPzokc+tRP+UXjSNOlHJOTtXlSZWcHMZqh10/TO/nC3aHrIXu2ROFl07qyluolK9b0u7y+zF
 r1Ek+JkDuLQ0PlHtsr0BRbcZk5c5QIFEZiz5gVxSjW3NazmdksmG72JJIi0RvCpw4rkPcZyex
 DnoTC1eiyCeeTYwUdOPJgdSB6Ds=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 15:15:19 +0100

The kfree() function was called in one case by
the smc_fill_gid_list() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/smc/af_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 7fc2f3c6d248..a396a9977ba9 100644
=2D-- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1180,7 +1180,7 @@ void smc_fill_gid_list(struct smc_link_group *lgr,

 	alt_ini =3D kzalloc(sizeof(*alt_ini), GFP_KERNEL);
 	if (!alt_ini)
-		goto out;
+		return;

 	alt_ini->vlan_id =3D lgr->vlan_id;
 	alt_ini->check_smcrv2 =3D true;
=2D-
2.43.0


