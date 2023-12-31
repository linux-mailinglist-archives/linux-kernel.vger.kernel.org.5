Return-Path: <linux-kernel+bounces-13765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C81C5820C40
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 18:43:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69123B2103A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F031A9444;
	Sun, 31 Dec 2023 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="MmcXPIWe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E33CB64A;
	Sun, 31 Dec 2023 17:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704044552; x=1704649352; i=markus.elfring@web.de;
	bh=JTm3C27oEmXwy+9ZEDfsHFYIJneiCYqbeqijD6uJ37k=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=MmcXPIWeNAfwkK8WSFqMaljDRekebWDuOCgrpba98mRloXOdAUycq1EShMEeHQ7w
	 u0qmqZXhmLWhFaxmVqrhhcxkpNIWc/kbWjpMMJqg+egVSbB9uNYvRI9HnSbWpT1KX
	 b+IOZDQzFX1NhJA8SGi+6R2XV5/qyrT7cqFWWvURgmPPK4z1iHr3AopuTyGzWfmEF
	 GUDYVnz7ImlKk8JaWDwYD2wH4mlhopiyVbmGUTQjXsb27keHeBRfnucLApW8PSN9o
	 bTsVCqoViYImdseY6boXBXEIfjk5cu7ttl2mszF32n1S+taSLhKsN2oIckNeQ7Umo
	 oklQjkWiK2AQw1THwA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuSe-1qhNpL3bTI-00ez7h; Sun, 31
 Dec 2023 18:42:31 +0100
Message-ID: <477e5649-87e3-44d9-8226-010b9822e649@web.de>
Date: Sun, 31 Dec 2023 18:42:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] netlink: Improve exception handling in
 __netlink_kernel_create()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Anjali Kulkarni <anjali.k.kulkarni@oracle.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
In-Reply-To: <90679f69-951c-47b3-b86f-75fd9fde3da3@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yf4+QQ0av02wwVtpjkWq8Ru9GvaAdfgW05J6UG8fDitW5nCncT+
 MuP3vsdf+ej1i1qlEV2MP6EHuj7aLxMwoossO3sDhnKcOy0VWK/SCW4CqibzRSCKs0TgWKf
 Q4qZzqhVt16NuVAp4Inu4u2e8zre43VfDePggFIgo1EJEo6O4KDAtIDiHdYIXTJ2U2GgiW4
 ARuiz5tZGDPIuCjBLY2hQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uL3bqpCvN40=;f5sfi6UEwM8NowNjnPPmo4TDgUO
 1vSsX6wf89Mjla0suxg0Qs2mRe5zOHMqj9UVOlNJ8xthxIk1tjemi4JFjN0nNKUyF89dxQmpt
 J3LPYp5fCmcn/j1DuHHV00W1xsAtpu9uSrGVg+2QomIIhD6fvkcc82ZaonDz3X/ghB9QscoGz
 JAO7aSrnN8BJjT08rI8UbqI/lt0NZxhaN2Cahdsewz/qkYNJn1KJkMqSXmCZ0kG5160qF3kWX
 ZP+f4b5BI2XEaRYl1Knyy7qRhm7hup5nizx+WVsuSoontTxx/DRPbLzmJ9lfqdyf4cJR5XxmZ
 vJjAbwAoT1zGiEBhTZoPVmR0rEAcIEPLZiW7qKDMgUM4755/n8Ue+EpueRRfYQ4TKiI64AEZU
 H9RFwprov86CVEk0Qiv9pQSO60XUNLjpaHKXk9nzYxp4Ow1XKrlyq9bWfgqMrXooYKBsHrqGg
 ttIAQeaqIkPR+POJxwYe3VONoq5xaTi8bVcenIPhaCkhxDD9Sp/TACx3Z253AzaI+UEsRE2PI
 ANuEQ1qNoz+0H1H0aWjjuhdswrBTA5TkWu2wjWyiYIiWI0c471tqfTnvpQ6IuKLLV4/op0IXL
 ZDka2t9SgLrJy/BwKY19SoK+6LtxGe9ZfyMQUbY9kMg74KT4PdoHhsYT0xoS73mCUTpMEI48s
 o4YyePdnbOtyYD7GT4lIENU/QDnG5soyYuwuFdZmA6u1SfNJO2JJj4O1QIn8BSa7fCXxUiFSg
 LSw/YZzMdUOfsXfeFqtcQiJjMQMT7NUzUu7JdJu2rXcQmMKbowl2MjlN1dKm0Ptny1ksQ7M8+
 pAUkfj0DGr1eaX9gL4H5vHMA/OTFzASJCPuZ+w8/lifC+4s9A15s1iAdIsha4CT4pkoJJh7vQ
 51wRRojg1EejQ67CTcdxOOjjjj8H9fRYgRC3ttMV3Nasr/0AZtO38Z+XtP0FbzroKmh0JiF6y
 UbSh7A==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 31 Dec 2023 17:26:41 +0100

The kfree() function was called in one case by
the __netlink_kernel_create() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 net/netlink/af_netlink.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4ed8ffd58ff3..c3f88015cacf 100644
=2D-- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2042,7 +2042,7 @@ __netlink_kernel_create(struct net *net, int unit, s=
truct module *module,

 	listeners =3D kzalloc(sizeof(*listeners) + NLGRPSZ(groups), GFP_KERNEL);
 	if (!listeners)
-		goto out_sock_release;
+		goto out_netlink_release_sock;

 	sk->sk_data_ready =3D netlink_data_ready;
 	if (cfg && cfg->input)
@@ -2076,6 +2076,7 @@ __netlink_kernel_create(struct net *net, int unit, s=
truct module *module,

 out_sock_release:
 	kfree(listeners);
+out_netlink_release_sock:
 	netlink_kernel_release(sk);
 	return NULL;

=2D-
2.43.0


