Return-Path: <linux-kernel+bounces-60905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202F850ACD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2AA1C20B23
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9975D490;
	Sun, 11 Feb 2024 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="VX8k2fNx"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746CD28E7;
	Sun, 11 Feb 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707675806; cv=none; b=bpSfNz0tfBSHl+Ni/4fXzYFEhw5u6zWY3jZJNrHbLxJddrIz13biLUOgeNZkchwxCNCRx1m8szW1sN3Md1ekYTZ/5dcMqzXEwgRXRQh3k4AHTF2XHBy1KGoXaIqSplyzV5OLl+fJ8w7knxuiUnMQRlGiaBs5dMpP0wukrnRJ2Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707675806; c=relaxed/simple;
	bh=8GQafSlGPnQY/t9m9DNP9+Zxh0hpH+K9l9+g+B8VtaY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LaFmck9wFwXv3PfMONRrRjFBbUZ4aPm85MYNK9hSK8CvG54U+FQZjE7VBSho5TtnWpY8p4wRiGR07dA1c5ISaeVrERUi3xhTuxnHNl7WsHuKNssjJ+3MxNMnv7TkMsxxyATFD208pwlmJvLwjXvfyfroWHhyY5JICsxvDdLD7II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=VX8k2fNx; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707675784; x=1708280584; i=erick.archer@gmx.com;
	bh=8GQafSlGPnQY/t9m9DNP9+Zxh0hpH+K9l9+g+B8VtaY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=VX8k2fNxmrOmLLl6kJnUNUe8QuMMSL7iIvDI5o/x9P/MoP/HnUpjBpNbOhDfA9Jy
	 jYwxQcxomiQJFiesUZHyP55Sh/A5nk+G4NQ4VKfvf9HMgtvpslCTSv/MKgDwbSpEA
	 cf1mDqYBKHfTTwueURc8JRADZy51az7dafEEKUUucy8g2T1HQExyGq5/zX77V2X7l
	 i3OKbwwtrx0qwFKTdfyiIrQVbNoCGzMWrd98PCm60RaUrxtIiI6gclXLZpUAAC0lD
	 ynNdsmSh/t5l74FOFhA+otkcd5gFrl7eJ/x9oEBM3clufp3uewTtCxOVKnU384BVr
	 wZmmxS4tsj+J0Teciw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1N49lJ-1qrCa90jg1-01043l; Sun, 11 Feb 2024 19:23:04 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Yong Wu <yong.wu@mediatek.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	iommu@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] iommu/mtk_iommu: Use devm_kcalloc() instead of devm_kzalloc()
Date: Sun, 11 Feb 2024 19:22:50 +0100
Message-Id: <20240211182250.12656-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bDSAOtg6FsNP9YYaZTSNaLZ2g5j8GZd3d2N4gKNDAwoTaPqmEod
 2bbeOM/6uy9fuP/3ydp8vmjLMvh0E85ERwQx9lpjAbvZ8TQk7+v5uILNY5ucI16I+Iq8XEq
 1s/8u1t0XapUv5XwfXWwJa1L8ntCg1A62CcRF9YEZORlVLh6jUTUNn5DT6NEeVYnE/LCljO
 ucZ+YiM8crkWwB/xBhBCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o3jWEHTQHVQ=;NCZwAbRYj8bmZU7ifsIQVagRrDl
 Tm98TDTcEdnNg37iIFdp1PW65Sz3RWBhyyeXkZYVPqj6KzKWs5c8WiQ59S9zHFhI8XfEnBEzO
 Zc7XhjHLuP/as7sY4NCJfkmjhPcol2e65/N9g2y4+8JCHT854AeUpz0WPw/CvkROf9MLYy1kD
 OjqVwO/bBB/GZALtZilb+esHU/4vnrMaxYEmTcajPX74XOdfyvZUxp69MhlNA/JD9OvuZzrzB
 XzTkY7YgrUZ8e6oC+x9okRNTK0U/nBYZFulZ/FtoomgKPBmGoJdJCDbun1Z36z46gdMRbEQRA
 WV6UemSwg8hOydPISuwRToN9dGFwv08C159HwcL+cTs9s17UjrHybdv2/RXokXag9486slcbz
 FN3xgjxztRN62gy3H0A+iqCnk6Q8dhfk7/ZG6BE0YVQavd6A69f2plhockcFzgbj5MBqzBKce
 I16gPorwaxb5KCFQdzGoopvcQeMYfGzKsdDMECkzq2oa60WI/rz5nTEAzfeGVTPtl2cjD4XeY
 lAZewgOhspCaybmQUfdyc6+FTka++zYUbSm9h3ri3Q19Cf7Jbi6Q5S0a6Ej1o/ULp2ftISodo
 p9SMiOm+sUFg6ED+33cPJJn56MvZlHJNKGreh4gU54KIgV+C8CdEH5317swOuJNC/67fCAFe3
 ryGrBW1BSi5c4pLr/Ca6Vlnmrk1DgpNVNCeY9ruIPjVRz1fdArCybjnJq10mWiXgAJQufxpOE
 ebwNkc9m8ps//WM5oVULXqKR85GQpOUH3N0nCDoJCRHxBHMF/IXa5exAUcy699vUg+18+i3mG
 cMzqFyvb1KThjs6UrHtYFl6UvKIjhxBm0zXucMXMEiZhs=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

Here the multiplication is obviously safe because MTK_PROTECT_PA_ALIGN
is defined as a literal value of 256 or 128.

For the "mtk_iommu.c" file: 256
For the "mtk_iommu_v1.c" file: 128

However, using devm_kcalloc() is more appropriate [2] and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/iommu/mtk_iommu.c    | 2 +-
 drivers/iommu/mtk_iommu_v1.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 7abe9e85a570..9aae6eb604b1 100644
=2D-- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1264,7 +1264,7 @@ static int mtk_iommu_probe(struct platform_device *p=
dev)
 	data->plat_data =3D of_device_get_match_data(dev);

 	/* Protect memory. HW will access here while translation fault.*/
-	protect =3D devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2, GFP_KERNEL);
+	protect =3D devm_kcalloc(dev, 2, MTK_PROTECT_PA_ALIGN, GFP_KERNEL);
 	if (!protect)
 		return -ENOMEM;
 	data->protect_base =3D ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN=
);
diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 25b41222abae..45cd845d153f 100644
=2D-- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -621,8 +621,8 @@ static int mtk_iommu_v1_probe(struct platform_device *=
pdev)
 	data->dev =3D dev;

 	/* Protect memory. HW will access here while translation fault.*/
-	protect =3D devm_kzalloc(dev, MTK_PROTECT_PA_ALIGN * 2,
-			GFP_KERNEL | GFP_DMA);
+	protect =3D devm_kcalloc(dev, 2, MTK_PROTECT_PA_ALIGN,
+			       GFP_KERNEL | GFP_DMA);
 	if (!protect)
 		return -ENOMEM;
 	data->protect_base =3D ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN=
);
=2D-
2.25.1


