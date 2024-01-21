Return-Path: <linux-kernel+bounces-32117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629E88356B4
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 17:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56A1F1C213BE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07BA374ED;
	Sun, 21 Jan 2024 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="plKXPz+Q"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378A381B9;
	Sun, 21 Jan 2024 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705855314; cv=none; b=Nl3epM2FUZqzoOeJR4/fad2Od8/uKvqfv2ADubx/AdSpXGE0XEWy6BKDjohSCTtRCIvBl8VfNP2s3gk4Aa7FWXu8ckisYn2KzXKts6yT9H4sxUJzBkXppeA4B9A0+SlJ4UytIWWjSCLQtEz6in+Nz2qjIAYjh/PeidnOLzsOJ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705855314; c=relaxed/simple;
	bh=45wkP8U/iOWMDIyqAxusjLpXiYYeRC8CCOH80xeHkDo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rS/8px1zQuBX7SKDtfKEWM33Io7QF1jTugrtS2Rx8rr5rHN5JVI4zRgT3j4aVRSL6NR/0JJZO+h1k6tuL4gxZeyd6TLepZN5vXo2h+Toha1+raIt5xetSUUCO6c3O0Zu640sRDI4wwf8Eg7d3aq6gpOB1mIewiL0sQuCQiFQGKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=plKXPz+Q; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705855259; x=1706460059; i=erick.archer@gmx.com;
	bh=45wkP8U/iOWMDIyqAxusjLpXiYYeRC8CCOH80xeHkDo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=plKXPz+QWbQqY9/sF1zxo0lX6nUYj8vpdb4wgbzCv4Mwwj9Ad2dgnxR3kK5sbxv6
	 +sK3E3RACXGzf03EKFCzBtAqZZRRmzhDn9GnjcRATuUXR7oeiM+VrLYza6cIWDCGl
	 GrWwYnK0Y765jpyipUrOQTVvp9/lt4CpoMEXeQ8ot9PzXSHHYbSAgVyPRYtNKZOey
	 DInj7c7CfUZsiXfdfgvFzVjwdGg4eiD918B+twb/oXs81mxcIUwIRr49a0D0BrvIG
	 lNV8bV7rrKr+yiQVNHTnSXE5f5hNQx5mWHZovxGovt52HO9pTqEizx7ubMnoYdM47
	 LCM79y63HG0PfPusig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MpDJX-1ql9r21ePP-00qfvG; Sun, 21 Jan 2024 17:40:59 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Erick Archer <erick.archer@gmx.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] crypto: qat - use kcalloc_node() instead of kzalloc_node()
Date: Sun, 21 Jan 2024 17:40:43 +0100
Message-Id: <20240121164043.11222-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:X86R2S6O3Nk0sqc1AIm7SPvLRWYkmOew4svoTCxiKwDfMQakNbj
 z/VDlvAyiB0sKKvMrEs5N6V5M/Afkll3REGU0PxSx4oW+rM0LZnyBYGovxm0fp7oK4yznKm
 ZpxO2sPpFtJBRNK+ckGs5bW4nGrqQrNLRQktmeX2h32BzQUa8i9UbX0gK1GcW87bGYKJyG0
 1uVhbOx5z1014E+1PF/iA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LNvvB4XfrQE=;xm4iJMqcqcW3z9pKqpfiRjQ8hgI
 Rq3/8Yg4GQXoma4V9C/vYZsiydDrsdDVkPtyhi1dBGAp+fW6+jS4zsLh+/2TTUrcbtx1sisC2
 YK6Lus7q+ZZxBwmk2gRc3UwlKLYwPubAZvQW5yGeGvXU4jsarDhPtZiUCJUizu3wU4+DmGTLH
 qkq4UE4zv0LRJ7fp3mG9mAcXFQORPegM3Ig2I2IX3/c7HBfOkEhcGduRThA5seorzjI/xFCf5
 NIM6R9OQMTbs0RzuNd0blNsyhbiUb9u2eHIXtm6h6dXE0jo0mqcz7p/GNNsXL1PJsuatjw4Xh
 q/Sl/RcPMw8zEUwiQd+kTC8+hjI8YZl3ugcs6U2YDep/9Flxyp8XfyiFkqdOuAOGaVLUfsOLv
 2IxgOt8LeUEqc4W6AE1hBgFvKqGLt8nL3IOxB+zS7YxadpQoi8zsrc+ZIWurVluJhVPrfvbj0
 h/WyWnrBYi7CqYYYUu8/KigZ+8VD9BPpdkO/tn6HGDNBPlKr5IJgOswKlgNgPr53k+38MoHrU
 VlHVk1y+kgfyMDPvG3yj5bAJf40iAq6UccIrmdS2wkyTzcSAWdxeEHbyd++7nmYl6hXbxAlJL
 auRbtW5pPwKsEVHtCkT45EWRyM4eQpISoqraF20YaZN8QoXf1A0KG6L34XWFQDELirAgTf7Si
 TKszUHhbfcM4agL+t+IkjhT6gL0SsxsUuamxarMjxt20oIKA5fx1HFWBBOV7a8W2uoxEdEsJx
 T8Ao4m4WBm875WIwsOUT7/U6F1ALJqrD42ON/fTTn+kZLDv5DUozay/ANNQ+lBV/3vk4gxWfY
 x7vklLuVYfXcxMk8hEU+JkKSQ24/bWuMhgKqb4+GqFwytu/TqVzJz/+oW4InB07jR62HXy8qg
 IqNH3JW5MWCuHWnX2nA0uSIqRjn61CF0wDI45RTXoOnOfgYuyYYOXuB2V07mCjRC8DjZ907bJ
 Iw9VSum+LtFnAgB+957SAQ30vFw=

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc_node() function instead of the
argument count * size in the kzalloc_node() function.

Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/crypto/intel/qat/qat_common/adf_isr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_isr.c b/drivers/crypt=
o/intel/qat/qat_common/adf_isr.c
index 3557a0d6dea2..a13d9885d60f 100644
=2D-- a/drivers/crypto/intel/qat/qat_common/adf_isr.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_isr.c
@@ -272,7 +272,7 @@ static int adf_isr_alloc_msix_vectors_data(struct adf_=
accel_dev *accel_dev)
 	if (!accel_dev->pf.vf_info)
 		msix_num_entries +=3D hw_data->num_banks;

-	irqs =3D kzalloc_node(msix_num_entries * sizeof(*irqs),
+	irqs =3D kcalloc_node(msix_num_entries, sizeof(*irqs),
 			    GFP_KERNEL, dev_to_node(&GET_DEV(accel_dev)));
 	if (!irqs)
 		return -ENOMEM;
=2D-
2.25.1


