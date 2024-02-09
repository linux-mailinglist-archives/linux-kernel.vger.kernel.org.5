Return-Path: <linux-kernel+bounces-59781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE6584FBB2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3846FB2898B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8482862;
	Fri,  9 Feb 2024 18:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="IIYKIEn7"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF67EF01;
	Fri,  9 Feb 2024 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502590; cv=none; b=srvkTR+Bq9YDV6KMx0q6zzGQ0NkA9vn6eOREK8TG5cA5oYPmGLfHz2t5HFRpxrob7cTtCLI8WTBM5iq3OZVNLuMAazA57ZHCjQXLO+fwrgKeWPS5ZJpkWKUj8BqVdiQYOWpoWt07XwJlRWE8x6qVokFim9ql/odDBv5G6f2vM4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502590; c=relaxed/simple;
	bh=u/+mamvkYDCKLesPvuKRL6yvdtZU9jml8Gn9lLU7IJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WWtwM1fm7qdpBlgXB+al1rc/LGuOU8coizRUebcvHk/Z99ZDV4zdokIsc49p9fHAip5KX+D6NEQw41ylwoK/+Yv39kA9cSuGMTwrdR5+sTzVXEj7o+dF056bgwjJW3nRYC9LmuIGvCdWtTsjA/vcY+H8XHRFHBNsXB7unoXL4hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=IIYKIEn7; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707502571; x=1708107371; i=erick.archer@gmx.com;
	bh=u/+mamvkYDCKLesPvuKRL6yvdtZU9jml8Gn9lLU7IJM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=IIYKIEn76pGklB2IYjyfVqB+XzKK5wwOW0N25/eSUmMDxMNIwT0ykGizOAD/HuhW
	 wb+vxhH230PJBUX8bhB6Qj2u7xrPye1RR/j0cO95sxy4EFk8lhI4NcsnycZuiHDxM
	 cid85mnkvbEA1+3PrhRkE2QQUT4/aDZ73xrKUuCAf/+VoqorJjKjV0Ey54lc8Fr/I
	 kE3BsDtrlMqqYnb9fikb0CJQboUczOacXSywUT2MKad1MfIHntK/r3Ed69LjygCrU
	 aTAH7uaJzMRV7Amz40d2zd/384k+96yxBi5+O0ZkIGXJt8H5VycHkRyhRA0F/qYcs
	 I9F3792NsAkmBtAPBw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N0X8u-1ql6AJ153E-00wRMl; Fri, 09 Feb 2024 19:16:11 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-hardening@vger.kernel.org
Subject: [PATCH] irqchip/bcm-6345-l1: Prefer struct_size over open coded arithmetic
Date: Fri,  9 Feb 2024 19:16:00 +0100
Message-Id: <20240209181600.9472-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u1gbdPqo40pzzsxg9YAssHdCgHua5dHv8uONUIE0zsQpDdHbcJo
 DXmpcISBaX2Kx1qZRyDe7/soOjpoh9vEzZs0Hrnw8Y4fZzWZiBRmZklJhPEsBxPajfso1Ge
 2lHe7lcfufgmhcRZkX4QYAGwXTU8d/36wlOrCQYBGBVpm9RKWce2nrTvJUf1bybRcNexyxK
 MiUFfgJqkqy2ypRnB5Wsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:eRBeWGsJ3AA=;6EyRXc6+97zXC3KQwK8ZeqglePm
 LjqPy1vh8oGvge93Mk9RUWq/PGEIWogA62AJgjvt/67WYN2rYiUMuYtE++Ao+VkSLHDeXgiv1
 4wIIxcHaPpFo4vEmIZX+FXPymb0k4Vz7fO4bP+A2aHdJZRGJ8xAlt7RW6VfcGMv9K2WEGYOXF
 HzqJi83Lfh7bwLRSQ2ENAt0jTs0nd1u1Lf/GlNmsTvFRxoH92yp3nNDWx0mizc9lgYUy7bctF
 HpxXtvkgZVHmYdOaXq/JCiuO/AmXwFTZTRlRnGVpuUz/Oxi7OXd1eTjqqhtcNJl7NdvArQGmd
 2WS1bQ7b076ixu5APi2ZoGJliVssJl4ue8bMOjeiUrC9M0jVHWiEoYDlCE0PT+LjuBGEIknqm
 cGyqkWNl76YdVfG0L/dRQcskXz3A0/DO+RzAo4xh3O4uDOBzM1FcSO/0oTguu5cyG0XBQuXVT
 SwVlr9g3YnJc1FW4obmGRhdUBmLzyOloHizEvA1dKJUxmmYErtdbfR6JQVHVO/eWBvl0VMpLq
 CM1meE9P3flDulErmUMnqJfo2Fzi2XT20H60nm9fOrTRJEJpVonoUcVgiIKgkCk9pVW9lWt9U
 HLaT0Qu1ZhQ+hQxvE7v6hFVL8dzWjc2GycCpzHjM1N9HgwDatlaD3DyZc6x+dlaynzQOWM7nJ
 UJV86Zd+JS9N9I1AhA1r7xp9J3OYbcDsrS3hH/utDGqfAob9fJzJplnFfLzyHLXpXm81vC0VI
 /+2tIe8rFeM2eCvWvlygpGT5foYvPwFVnoY+/3abbAR8JIv/7J25VzsFt+UF7x6ziMZc2X4ha
 7C5FPjFG9nZbJBsnO8fdt1Zfx6eUhHl9dxvhPGEm0OMGA=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

As the cpu variable is a pointer to "struct bcm6345_l1_cpu" and this
structure ends in a flexible array:

struct bcm6345_l1_cpu {
	[...]
	u32	enable_cache[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the argument "size + count * size" in the
kzalloc() function.

This way, the code is more readable and more safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162 [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/irqchip/irq-bcm6345-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm6345-l1.c b/drivers/irqchip/irq-bcm634=
5-l1.c
index 9745a119d0e6..eb02d203c963 100644
=2D-- a/drivers/irqchip/irq-bcm6345-l1.c
+++ b/drivers/irqchip/irq-bcm6345-l1.c
@@ -242,7 +242,7 @@ static int __init bcm6345_l1_init_one(struct device_no=
de *dn,
 	else if (intc->n_words !=3D n_words)
 		return -EINVAL;

-	cpu =3D intc->cpus[idx] =3D kzalloc(sizeof(*cpu) + n_words * sizeof(u32)=
,
+	cpu =3D intc->cpus[idx] =3D kzalloc(struct_size(cpu, enable_cache, n_wor=
ds),
 					GFP_KERNEL);
 	if (!cpu)
 		return -ENOMEM;
=2D-
2.25.1


