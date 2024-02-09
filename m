Return-Path: <linux-kernel+bounces-59805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B22F84FBE6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E99B1B2BF50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FB42E3F7;
	Fri,  9 Feb 2024 18:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="IjUxgM1K"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1842D5478B;
	Fri,  9 Feb 2024 18:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707503524; cv=none; b=VpCFGtC4oYGfnYGBQyH2ZOpQooci5z8CORgE5UoETg3kSdv8nubLZzTm25OGCOgJPR4oAVp6kS8ecOWyq9oKBc54nhO+fTVFnimnGyW5WT9Unnestpjs3yQei1JMzS1toL+9EuVEjSfDY9dKeuN6GW5Lan5qUvrsFlUu6pu0sO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707503524; c=relaxed/simple;
	bh=Lm6QEmxYFtHMAzQ013WgLkguXgBWkgyz8h5irU3s7uk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bIV34MBImjLgXQ0ggiSfoWqJ5Oi2h8BIwZKkVnFHBdp3WOsDBlUAbnGc7BYFOIcKdKHuVPCPSuWcR1pnF36eVrFD20byUJnz2WKXxnGU5qt5gYmmBW7ygqKy8bY4DxYneRQjvEUkFLBpWCf0uI2Y/de7wAkATJwbQkqlHCCG9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=IjUxgM1K; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707503503; x=1708108303; i=erick.archer@gmx.com;
	bh=Lm6QEmxYFtHMAzQ013WgLkguXgBWkgyz8h5irU3s7uk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=IjUxgM1KUEA4+SU/oU9vYEvsUSF5P1uUmsqB/zO1mJUdY/RDcF7J9EZKrO/SMsXV
	 X6G8iPpPThxtYswAbSlMmyVhn8/sMxxcfRPHi+8xVls2ZuR6HtygWdkNgdE1gbxqa
	 W/zhKX53UV7mulnMLeNP/Qh6YT+nvHyunaCkzwddL3jXeezPaF0xICRRveQfuRhIk
	 36KB43DxddnP10FmErLekxV12FixzvJS19FwQmjJXO/oVCpCuO0fSzxzo0dFRN02t
	 UBp1wfqFGN25PU6ceNcdHjpOmZBEThXOHafTOvH0CEYE48Uq75gZlcL+SWHwAwYIq
	 idEEbLGbe4Uu3pD2Ww==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mof57-1rF61e0PM1-00p27r; Fri, 09 Feb 2024 19:31:43 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] irqchip/irq-bcm7038-l1: Prefer struct_size over open coded arithmetic
Date: Fri,  9 Feb 2024 19:31:28 +0100
Message-Id: <20240209183128.10273-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HHE2RklMAgct5mWgoo5roJAE0JNG1ajQPkAW3/w0TU9s7QMGYgc
 lJppmFsPQYybduHX/bzeNYbj5G4Jt1opcVxoboa+zy5EijRyvzU2sNMr6g8OnyasblpGe0/
 NGfu19G/ZifHfDH7yN5YgoW2GJP13JUug+Toed+qXU3eOpPRQ7Udu+DGUDZIIviO+LpRlI8
 CurrQGSZ3Uz135e/IeOwQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aiXGABC/NJE=;4XdU1nSuxoQ18FFKIQEs4U+lHlc
 hnrMxh53rZP5AGJs/zAZa4gPYCJJ6CZAO1PNSQO6fWONDxbmN4sMcnUAmeeK7mxs0riAVEb6N
 +L3qsDbnW3rpyXtcPGXT6VOJv6bie+CyfGmPHYeR15B7g5siFCDLCuFcSXq28Qcil2vEz9uv/
 y9xsLOFDrxfhtP6UuJhXum9NLbuTjVbE2U7juaIMj7rSKNL01m7c/uFdqO1UJlRVj21FZbZm+
 wQYIj3TnTyRSkZwFdXDYKYvTdtoDd9GSgdt23Aft+z8mMwdaYS09wLqHe6ITSZbbZiJ7kKKF+
 Hrhk5TwalPX1bQA1mLOmJLRsL4pzRipkBOUVNuqqRYzN2cpHT6X8yWtlhfQZQpAmvHkd0LOKj
 QK7iuiIrJ1UjUdH4wNwMXSaM6908KrPR24S3uK+Yc5Fz07JwyENal/qJ3GXGYpBiQpnDKNstY
 yENOkSpspL8S3fcXdxW/VT2YIZhPjhtXz+/yYIIAp7+e6Yxxn70glGZCJIqr9qORbsV+hYMpG
 Yi6qC2ljuDrr45DUNVSFjjftmGl8JxVLsL6azqLeF3SydEAhrQbxa1oYCpXiLcdDgdIdZV+RC
 ud86Xow3FZSyL/SwMpZy0a+zu4RuLKjKNtz7CMwSKw8Dgl702quBQQmvCiCJk9SxowOjLHEZV
 PcrTNjEP/8vc0YMsSXD5CwcbI481OdAmt6nlkL54O0K0+N8Oxx7B0+8L1YeQdE7qeP0YbxPrk
 1at286ZydYRlE1FBe18hqvblFXsRQrL2V35i9HggNLoz3CGRsPLBjfPtZTK/sB4113VMCB9JP
 Nan18YywG4/5JieXd8VJG1jpKerA5Xy11E1pmMrnadea0=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

As the cpu variable is a pointer to "struct bcm7038_l1_cpu" and this
structure ends in a flexible array:

struct bcm7038_l1_cpu {
	void __iomem	*map_base;
	u32		mask_cache[];
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
 drivers/irqchip/irq-bcm7038-l1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm703=
8-l1.c
index 24ca1d656adc..36e71af054e9 100644
=2D-- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -249,7 +249,7 @@ static int __init bcm7038_l1_init_one(struct device_no=
de *dn,
 		return -EINVAL;
 	}

-	cpu =3D intc->cpus[idx] =3D kzalloc(sizeof(*cpu) + n_words * sizeof(u32)=
,
+	cpu =3D intc->cpus[idx] =3D kzalloc(struct_size(cpu, mask_cache, n_words=
),
 					GFP_KERNEL);
 	if (!cpu)
 		return -ENOMEM;
=2D-
2.25.1


