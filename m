Return-Path: <linux-kernel+bounces-13696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 422E8820B49
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 12:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7901F21C51
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 11:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035414699;
	Sun, 31 Dec 2023 11:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="WvLW7K1U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32D33D3;
	Sun, 31 Dec 2023 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704022236; x=1704627036; i=markus.elfring@web.de;
	bh=nbY6QmFmNQ+E2mdJ5exz4FGfT6XhL01ROUuaUkZePiA=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=WvLW7K1U+fUm7eSlkrEmXhbDm/eJLthpAbQRMwoFBOJuc0vLSyoYpO4gB8xvsPB3
	 84e4rm8eQxm8zX0hFTPtumwO5ACPIEFF/i8yzslprqard+YCfFB+UsO1q2/0p5/9w
	 zZlJwDJJWnwFmHaEM8/tJAi9O/jZcqUOd++pRILvSRPDAaVDGG+PrpBuz0OnV0+l6
	 DqtopD2D25ESuNS5gzvbLLd19NijKL9ymKb07ycedhP0/ALMCLpPxnpUd+TiMAhKA
	 mnRjrsCk2rHd9+SI7NWev3sCfQOlRGo7Yp5pfWPl7EQ5Gzeuat22eol1N917bMsEF
	 h0TMW4dvvVz7Zp5YyQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIyeU-1reC1u2Ozq-00KrK4; Sun, 31
 Dec 2023 12:30:36 +0100
Message-ID: <b9646b4a-61a2-41fb-8fea-ba63e08996f3@web.de>
Date: Sun, 31 Dec 2023 12:30:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: tipc-discussion@lists.sourceforge.net, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jon Maloy <jmaloy@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Ying Xue <ying.xue@windriver.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] tipc: Improve exception handling in tipc_bcast_init()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7eSsDxH83otSo60n2ilX+f33/N7QzAImV6PhRy6CnGPK57balpY
 3FgRNv746DviRyDa7CFwrqNhMjriXC8sVt57C/+aa7UEuatXbF2+CDvtO9Wl6KfXvgLLskQ
 5t55KLC/WozCe/xxS+ZqUFJYVXTNvLBpfet4LgoT/CpP0Lf1p6vsmrX/mriT0TgytPEyExg
 MMhhSXRfA7wPIbnOSifTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YTPF1jvdTGs=;zJ3xJemRZiorgjWTtMXD5gJdx2g
 oT8ysAYylDZ4b5aGJymiTYpVJpus0zE6vTVAE/hPhx45M1uJcczl71C8o+PXAMg+ECxOJa78S
 lnIS08Bw+6lSF2wap4PJeOIH2LqZGd0u/vcF2glXDtuzhKIG+EWUc8apkUMb8HPMouRV7q3/O
 oIOhtM7M9NmsZP8FihiJIWF2bTyy6tnmdHpZ0xA2ZWHuDyIbBPGAYf76EP6TiGbM+ZDpym6jL
 moIC2Zpa8LeOhiQ9pkutaD68l1RsfmxYFGosSE5IXaHQepnFozk4qt8RdW7aV9iALQSM3L/y0
 ou3D/PYEbY02TFXweCR2cnJRUs6QK9AIjWfKWCpAcqJnq3LHTZ1lGQOgxTE5/B4OiTsQHUhUV
 +cQByw9piIm0a5lELAuIv8Cdj8j7zAZhRrD/e4eOWEtvKV6yuQsFky9CbxLRk5c++PQBC3pzc
 4jJ9wzn86OB8Xeabc/0nIgVuH1x5k9uZb6Rn52hjkfyqedeq7nLGyEeWc5B9ZnGNJPEs95lKO
 SKHagYEn8/SUz9GS3cUVkMjeEpfbkX7RKEVo106UcaX0qlhOZdw6YokZIsbNQoFVHucm5YLHS
 rjhrnHeQ5hNV5etRAchpLtaFmz0Lx46s9Myx/C2nOxh9xOyxDzZj49KdQf42yyuQiNhkfPH0l
 bdEWGL3cDwsQv84lyKEAZgIqHi5Pq3xGha5lUCk+y88P92Mx8HGyTfMebPsacLqi3Lw/+yvmE
 boU0Jl4qLK8lOr7vW6mZlVrtaL5DeWJgsoUz5SCjAZdgCLkWQE6cPKKlZwgXfe+HGql9F1HB2
 wSyG0SLjCEa2T5SZPtmfNi6JmffL3z9JpFDNX8bZZdy0jMKcC8JhuJB1+lZ4l9Xd7o+vaniZz
 XTqblTdfi68eqDKitvoh1JRolfH6HBgNKTwFvkM3LSPJLaa4lf0XdLFgOh3TuWXMyDBhBDwkc
 0G/M2A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 12:20:06 +0100

The kfree() function was called in two cases by
the tipc_bcast_init() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
  at the beginning.

* Move one assignment for the variable =E2=80=9Ctn=E2=80=9D closer to the =
place
  where this pointer is used.

* Delete a redundant kfree() call.

* Omit initialisations (for the local variables)
  which became unnecessary with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/tipc/bcast.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index 593846d25214..631aef2dde45 100644
=2D-- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -688,13 +688,15 @@ int tipc_nl_bc_link_set(struct net *net, struct nlat=
tr *attrs[])

 int tipc_bcast_init(struct net *net)
 {
-	struct tipc_net *tn =3D tipc_net(net);
-	struct tipc_bc_base *bb =3D NULL;
-	struct tipc_link *l =3D NULL;
+	struct tipc_net *tn;
+	struct tipc_bc_base *bb;
+	struct tipc_link *l;

 	bb =3D kzalloc(sizeof(*bb), GFP_KERNEL);
 	if (!bb)
-		goto enomem;
+		return -ENOMEM;
+
+	tn =3D tipc_net(net);
 	tn->bcbase =3D bb;
 	spin_lock_init(&tipc_net(net)->bclock);

@@ -715,7 +717,6 @@ int tipc_bcast_init(struct net *net)
 	return 0;
 enomem:
 	kfree(bb);
-	kfree(l);
 	return -ENOMEM;
 }

=2D-
2.43.0


