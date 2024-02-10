Return-Path: <linux-kernel+bounces-60449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B29A0850514
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 17:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CEA2821AB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE295C5E4;
	Sat, 10 Feb 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="HwdmEO3+"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5BE5BADF;
	Sat, 10 Feb 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707581838; cv=none; b=oDDOoGIK5VGmldjOmIGgCyuyRC80CTkF/VlQJLRO4GpIcDeGjklFZInxVfS8s2GYJLwVyj0DgNHAZbVapUuOcrasfv8Cnonscf3Cxte1cpiN+ieiVLzOoq875Ix+7ad7kr5DwpsX1+KWD8qI6GhePHK9I5zi46c0EdntYWQjUdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707581838; c=relaxed/simple;
	bh=OfG4W2vrN+BKgpQ5aAwkOcwerxwIgHNq6byGUSl/zus=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QWoGudERsyxl7ldWNrMgDi/9gKdG/Z5I+2Eh/hsmguxABqxPQFOH6lbs9+qx4ypHDh8Piyq3ZRH/zz4jeKUo6cxUNGcr82w9TJQV1xCHvpgZdImICa62+QmlRcXaObefX3n2JCjnn/RpbBhva0CmTob1LZhODVqwa4KihRxICrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=HwdmEO3+; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707581794; x=1708186594; i=erick.archer@gmx.com;
	bh=OfG4W2vrN+BKgpQ5aAwkOcwerxwIgHNq6byGUSl/zus=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=HwdmEO3+DYeTsTAqBIyXHET63T44a1xtI3JB+T4mOHbfg3YRlN3eTrgisx6Qty6V
	 m5HZMB/jq0YStPEA8mzKn2U/ua2TXuKIq13sO+SCiyOSiH/vdvQsQpT4cw2nkWEAD
	 Iwk253BH4JQQKw/q+0ebaAq1gwIFUkSzXElwMDJgCdkQkH23FiHGFiJWqP7JYpFw9
	 OvJ8q9H+xTwTWBkZwKU0igZTiBE0vWz6bcwtqBySAt1L7/iKxEHBwLt9uUwzsHnOb
	 dfIKytswsBmRPRpLrRMkznLeh/zV5xBLR8q2p/7VWD8oqvkyTacM0gR8VD0oitcNO
	 EXtx4792DSfhgVXIWw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx104 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1Mv2xU-1qhyOQ2CRM-00qxEh; Sat, 10 Feb 2024 17:16:34 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Li Zetao <lizetao1@huawei.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mtd: rawnand: Prefer struct_size over open coded arithmetic
Date: Sat, 10 Feb 2024 17:16:19 +0100
Message-Id: <20240210161619.12656-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cE6WntWvcCnRVKbuPrflNE+LM0S/ZuMDnpLQs4Rt/3MVVPl0ZEl
 jh5hEvamdlnrlzQh+Xn/DyeW897UTiYJftyoSkjAModsgHBqwpZXASdUw2819ZPGgzRkdls
 5oA0So3/CI6eU9lLpwToSblgBUGrk9KUtHno4oEtREQCIdpgxpQCMTxcS50WDCFkI7cs+s/
 N5Or+HfzYjxl5q9qB/RFw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VGFqzc3IIRc=;tUTDQhueCO0tu5eV2hl+d2qyQIF
 pcv/rPJ95xWai1+wm5czTvEb7E0H/FESByeA7Ej+E3BTUzPmw0Nj22QMPpbKGJ1tAc8sDZBSO
 PksapTUJlV/kbeH4Q2zzfKza2kHoLVkGdPn9lNy/sb2AUqbg7UXxdf7qSBJUcI2zc1dc/BFfg
 MtmfeF8ylN+cHz73T+ot3OImAt0ZfhowAmQaQU9IYvlP2C8nvsPx5VcdnQUlPFQ9Yf2T4SAcX
 Q9aLURNa0/5Om+lIbtsXGinBhu/gTsUasgZpQVDx9rsZ1C8rODomycnmispx7smtN5NIrG/kn
 UWgonq3mGlpChY6+CfhBgiUpkPzLlEodMp/PD/IFFe/B/znTawbueGIUvvApbMcL+m+S9dMjv
 CWHTULkg52xeaCydt7jKNATDiGTo6N8CJOH3LuGTvS09d1yvXv7hG6aBnzwZ8EhzQqiQXW7hZ
 ZGEYJgk4d/zh3t7CW8iHyLrgxnJCdeunR94Ps3PPKQm/ilHTylzD8xaHDoQpkCL58nsPVXOkL
 vr+M0GJnh97M/1d0TiZ6AceirrQlLEFLZ34A3Xl/sQKK/eU4FJ7MkD52jIOmd8OPnzlh3ILl9
 ugP+Bzef/0UxqC4p+oWhlGU8Psn8xQtMvmQP0kLNX7+tfiyv3Eoq84tVZz/kQwf3Z5Gqh3bvX
 pCaiUdkRp1edJ68x+OtgzmkYxqP4DHIFzgEK/mUjFbptOLCO5sMzQhaDQr/2lvkGJB2EfhIS4
 /BBlCdMvH5rPcxUQ0w4XOkXrAxaVTna6JEI+hw24C4h8VPIi1CvGOre9MM3mtkj1QST/wuOe7
 IOEWJHRkQJsTjnfNWBspSQmSmm7H5sa4Fx1/2kDycu4eg=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

As the "chip" variable is a pointer to "struct mtk_nfc_nand_chip" and
this structure ends in a flexible array:

struct mtk_nfc_nand_chip {
	[...]
	u8 sels[] __counted_by(nsels);
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the argument "size + count * size" in the
devm_kzalloc() function.

This way, the code is more readable and more safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/mtd/nand/raw/mtk_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_na=
nd.c
index 60198e33d2d5..17477bb2d48f 100644
=2D-- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -1356,7 +1356,7 @@ static int mtk_nfc_nand_chip_init(struct device *dev=
, struct mtk_nfc *nfc,
 		return -EINVAL;
 	}

-	chip =3D devm_kzalloc(dev, sizeof(*chip) + nsels * sizeof(u8),
+	chip =3D devm_kzalloc(dev, struct_size(chip, sels, nsels),
 			    GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
=2D-
2.25.1


