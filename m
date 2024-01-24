Return-Path: <linux-kernel+bounces-37750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F4883B4C6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82529288A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D509813AA38;
	Wed, 24 Jan 2024 22:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="RN9y/4ct"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9D2136651;
	Wed, 24 Jan 2024 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135600; cv=none; b=lUppW+Ol0mS+dsDx3yoISzBX7xG+LNRZ1RQC6KwQcUtwy8vDdvYYLKq/3GlhSQLPuoNYElLviQo7TqMhRc+uy9+0KwbMVMr5hG8M1JPkWM+Rv0rmhtWTTyV6ziRX5GJ1fZZ4bvwwaxKP+YqHaIrEhwcxtBqGfofpgBXggj4SLLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135600; c=relaxed/simple;
	bh=qomwzeZ0+VdI6mZ2yu+WT993r+YiIAfvdX9TkSDmq08=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LvtE096BYOxyLAYFJStrEx3Ga1t3t2CjXrULx/NCH3E+klbUmrHjYEf9qoIbb/uAJ755q3zqh4DuvNElconqPf3qPOoDMZmLeFbPJ6laX6voES+jYalz6jFrFLGxavQ5Xw9jvcmQm8D41puGRDUdSTVj3WQWxus8KgxNNI7phyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=RN9y/4ct; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135563; x=1706740363; i=wahrenst@gmx.net;
	bh=qomwzeZ0+VdI6mZ2yu+WT993r+YiIAfvdX9TkSDmq08=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=RN9y/4ctJFpF3bqorIIKKoX6tEIqUXGLM65tihxfggrHmF8H7xqotvmpsYbz5yXO
	 p9EC+WsSbHBkPeLNIswS0emRMyMb9xyLKrP1l4j3HwG+jMmS5NggF0JniRGaoNgcL
	 6sCyfM16zmkYXUZ+uispQrE1mYZZmHIAlhoPZ/vaIFYlkE4ZXuhSOEnuXBzZ877hG
	 f/2XJn7zvG0zy9y6v4mlVXmr2Gi05SblwcBW8H9qqrGD43y2jpzCoHfpQwc4NMdcx
	 fpWLN+acuxmDoB7EWhHxU1NhDq9oaKS0ioyTb8TO8bLfXdIqwIpXe8/lX43CLwU2t
	 GGQisCIG3j8i+Fdg4A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6lpG-1rSDZN0LNu-008InS; Wed, 24
 Jan 2024 23:32:43 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V3 13/14 next] mailmap: add entry for Stefan Wahren
Date: Wed, 24 Jan 2024 23:32:10 +0100
Message-Id: <20240124223211.4687-14-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124223211.4687-1-wahrenst@gmx.net>
References: <20240124223211.4687-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YvVG3RKT34IC/0QHC/pRgLRH4saf1SaSfj6zVwL6L1JmhH6unri
 KwWjTh4rmzviK1sL6EgRECqznvz7eH0BQ1w4/unCD3WEHP/H8sJdF70IMyqZae91g75/LZD
 W9ZL4Z5j/ZL7Nd5eFuKBw0kythuKEL7yQVT2vVVMLr/wlF0nGs+lf/2Zszya667dxCcQoVt
 wBpOaUh72q9X0eRVXFmmQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iBC/vrINn5k=;FX0F+DH5/dJMmVAgy8RdOCzM5Ou
 fr9OnPM62P+9dcLlnlFSjQ1kSxCstegu7cXaFY2bAKDshHvWQr/wniARP4LlRKevGF3dp93SL
 C0spCZRugw5SOIu3K7XQITA56PEYc1PgaRU7EaoEkgkthcSAc7iUpnlKu2sovCUvZEmzm/MiN
 TG1gL3heJCXLrU4uFF9pEDijW+fhbTQDgW4iIlGr3MYsBz00YMpgqS/GjMoz+VHJEKQ1YZ6JD
 Ur6dqv+sB7ebYBG2Qlwz0cPeNgx6yoZ0CdZXC9ECoOhkWtGKFxP/afLBSDnOrZajqQC9yj3h6
 Q7LRZSdVUUOiMVIZCgZ9ihf4iLqy3ij4uRs6NJoNgqq59moYZOa/A7TSga9OZNwKZGppL7NkK
 uApVIukrr+2MjIa6/O2KE2Y5J3wLM54QLUS++EZGRRzB0unXwsGIF/BFt7CXLQzbELdcpPSld
 8BIcWt0//VrsspyjI6WSyP9aYnbBKEYSDJnpqs72im1gPM89FYbezpxAO8B4LaSm+s7AJO8nk
 rOMd316h6y3Ef63j41fo8UCYG9CH6GyxrKLZ/ocjKPZYGnNWps+1C305Xyl1T2LGrpv0Xffwh
 XsB43UII1sb7SMjIJ1wQBmTBOIeOmw3gezB3m/bMgj7Twwblgagq+jY4ui0bRmC/osAdQE+5t
 RULFvpEtYoW7tyL0y/poUNDDCHypDVEq94u/sqP8uIDxjei2xAAWFbcVRdp7s3KvELxewNQAB
 hQT0PyV+ST8gwFQXLJN/k1W9O6Kh0byduegAMJBUCx5LOd4PcZ6pSjfF6LnsL5KmQDfhbmrJI
 w22GXVqG73/aQdnhb06VjFm70MxajN7CYc4FEfkshcghgOuWmDIEgtA4v3vui6Hbze9FgGQ7A
 n70fFGgOlLY/GTfLu0m7VroMNMZwsLAvB3mvuNSMR+WgDvi9xuPm2UPyvMTNsnuKxJfDRAh8z
 ysO1oA==

Add a .mailmap entry because my old i2se.com address will be
deactivated in the near future.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 04998f7bda81..95b4fe465cc6 100644
=2D-- a/.mailmap
+++ b/.mailmap
@@ -568,6 +568,7 @@ Simon Kelley <simon@thekelleys.org.uk>
 Sricharan Ramabadhran <quic_srichara@quicinc.com> <sricharan@codeaurora.o=
rg>
 Srinivas Ramana <quic_sramana@quicinc.com> <sramana@codeaurora.org>
 Sriram R <quic_srirrama@quicinc.com> <srirrama@codeaurora.org>
+Stefan Wahren <wahrenst@gmx.net> <stefan.wahren@i2se.com>
 St=C3=A9phane Witzmann <stephane.witzmann@ubpmes.univ-bpclermont.fr>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@linux-foundati=
on.org>
 Stephen Hemminger <stephen@networkplumber.org> <shemminger@osdl.org>
=2D-
2.34.1


