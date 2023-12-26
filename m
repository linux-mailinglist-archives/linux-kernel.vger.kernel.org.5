Return-Path: <linux-kernel+bounces-11688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B7B81EA0B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 21:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 978091C21F9E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 20:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19A24C8B;
	Tue, 26 Dec 2023 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="wSZwN0u9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8C4C6D;
	Tue, 26 Dec 2023 20:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703623343; x=1704228143; i=markus.elfring@web.de;
	bh=T6cDnr5hFtFbP2etPVzAZk5zoBQrCmisolCMkj0IYRQ=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=wSZwN0u9XxH3EuhHZr1KPy3ie4ZT3Qn0DIysbF/Sa9XZGwNtKE1rs3T3+MG6NzuK
	 N2Al1s1JXw04IVBYIhznOBCZyCl21qKgRzbT6vc0EEftw8kFHSo3JfZ6y/fFgcJQz
	 Jk0TxvJvgVgWmAx9+fS+dId4OuA/GowQE+FJKUgZU46Rjt7dA8sVLMBw6QNCuyKz/
	 wf3lSwD3ws2wrdxHcPPGsC3kmOt8ii1TXKVA3hrpXMO0xM5hVVbfqOcVwMMfkZaY+
	 NFz/Meask2Zjv22UKBytb9JBNOvlTatOTLtxb7ZbMQzZqGwFtcm6cMb/t/tyL/Va5
	 u1AFXvk6qyDj1wic/A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjPPs-1qpAkn1qvK-00kp31; Tue, 26
 Dec 2023 21:42:23 +0100
Message-ID: <71aebecb-ab59-4835-9320-10e849c04a5c@web.de>
Date: Tue, 26 Dec 2023 21:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-riscv@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] irqchip/sifive-plic: One function call less in __plic_init()
 after error detection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:PL5C36CURHSbdroEInCd+9jbMmVEKNPmO+AYoHaevTf15uMeyKZ
 pFuMaYZ1hpPtHyJWRqw7Vpd3q78MRXTrhGpFM23XLG6kHqPYd28ngv/y4hXj6yL6C1cKnV9
 Kg02EGUbMSdde9WK314m5C/vKNDR1/g+k6d4cgl8z4MPAN9EFiifXupWBYWn+NIykPuuSDD
 6tx9OomGmnXlsEZ+MhWug==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zp7bCe/dVQE=;Kkt8nPqdlTEUtkFKrL/qlAx2nv1
 37s4PQyHu3QGIQuaKUwPVN3YAK9tktu9wHjxGsiLjm3A3F+KbTkjXZ4GtyyLg2nl4bvOY/fLc
 CH1o8NMtikYMHkTjlh19DYB8VKH697WMO0zR2eh7qmAqikVFRrEjpX/7HfgcjL3zHLaQMic5Q
 ZIL4I9ZMJj7jV+omwPi1WtcpOLTvUXs7MwISG27j/u5Y6LNR8BHz1FINNV0ZglKq14BepGsMj
 p9gSv7zvog/1/FhnzR4DHzsqKd2dPaG3FiFeCBegh9Jmn4wejiceFYb+JloFq3RIXFZr5CT5I
 jrpHqFIaIeui1Bb5e4Umf3VAU8oXoY9zohAhBlTqyyEXVQUFpJ8m1tKG3dYa18IKhFbUFZJ3C
 y3ALcxHf+q+r3/90UJ/3UaubUwDokOm7xUehk8GHsrF5QKzUy8cvEbAH51a7Zd1UUIOY7ERuU
 +COfiPrIeiuPdR4sWAF34WP+CkASRfdY973K7iemppyW724cuLeGcWfpkBHep6t7rsKFqQ72W
 IcoAWflcJudax6UOKi0ZGWXNACZjFShr4jH84lGN0gy+6piuxjMfSS7R+najnobBr0ykLxc9H
 Oohz2c3xQypnJ9M6ssVpKk/z2zvi18l23A+UDEQccIdlI+OBdpWHzE7TgIwfv9hPPt7uRft9E
 2TDxLyVDIkvsXSq7HGLoRz/GoX1JwwsWXIrRU8CBCN9Ckz2r42/kBgC5n9XMHv87yhiZSO7W9
 boPyQ8D9XUtsi2Ry2edktzor3eevFGcdaOQAanvRlt3dZOEmxakquOECf/omKLvVlYgImqH0a
 vc/sxzE2+Q35JzulTFtL7IXHGhT01yqr1EoqONMauNO7z+nbpYNHw+PZh6+71sUqrc/4y2EJ+
 WViGnkKWh3swDh947xq+P3e7hcJvlqr0kCShBp/Fx86rdBcKyQ/tOfjjRdjDyIKjBGZGEvGOG
 vpvTzQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 21:34:47 +0100

The kfree() function was called in one case by the
__plic_init() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use an other label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/irqchip/irq-sifive-plic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifiv=
e-plic.c
index 5b7bc4fd9517..e9e3ee2d6440 100644
=2D-- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -437,7 +437,7 @@ static int __init __plic_init(struct device_node *node=
,

 	priv->prio_save =3D bitmap_alloc(nr_irqs, GFP_KERNEL);
 	if (!priv->prio_save)
-		goto out_free_priority_reg;
+		goto out_iounmap;

 	nr_contexts =3D of_irq_count(node);
 	if (WARN_ON(!nr_contexts))
=2D-
2.43.0


