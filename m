Return-Path: <linux-kernel+bounces-60674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A90C8850848
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 479D5B22759
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F10F59163;
	Sun, 11 Feb 2024 09:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="P8Np99p/"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0661E168B7;
	Sun, 11 Feb 2024 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707643052; cv=none; b=ARKX5efoPIfDk/hE5GpkNy6k4NihrhzPZQFpYHWHKLQ0nZMYAGEO7zL+5lkvOUTy/JzoLnt8d57tE6MHygGa7tM7enMzCFueGpaGA9EGwSVBt+iLe84TgUIlYEySsgDf3WeBuW2Y66B3k8i/GxB9Otei0B7XovVrStx3OiwYKnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707643052; c=relaxed/simple;
	bh=rSHYS9qHk/jwImtw4+JVwsbnbAy0pXklABl265nds1E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=XSLjJTk/6uI70VfEMrrswDqxQ3rw5bZ/yUVqgv2l3/wUVVOpb7ktWN61SMbiHCsFBDyETW4G2jDq7D1c/HuO1FFdMQ5DUmaA2BxaZvyVybI+0ZGroASMBDuKbEPBYIYxJNn8tAbe5VrHhw2xppm3P7bH5vQPFqdt1mMJVlzMP8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=P8Np99p/; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707643010; x=1708247810; i=erick.archer@gmx.com;
	bh=rSHYS9qHk/jwImtw4+JVwsbnbAy0pXklABl265nds1E=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=P8Np99p/+p9ERHHFhS7PD/pOfT2dBBXJIHtsDOJ8QeWuiL8RS4wg58MC1tDUtF3I
	 GIJgL1Qv1ogbXlkXsE3dLCbmWzBs5EYt8Dkotr82zFA2LN59zWfIoZ+t3loKmIc2U
	 VM47LRH4J8VPJ4aBZaxmaFbDghDcda92em6l6ER4JIcQVsWgfIFUsA+Vg2oh/MRvA
	 hDeJ0yHCkdzrL2Nml9oj9ophK1f/0V2WnyODJze/8qIdeHvm9ubBEGsZTEdOJrAjG
	 ewiseXCZxU2EY5Lhqc/U8Akb5/fG1+xNt+UnWY/xBAAhkMkR2pZcFxX+1hFJTSzIL
	 E4dl311syDfFl6Mc9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MDQeK-1rjaLv3tI6-00ATNc; Sun, 11 Feb 2024 10:16:50 +0100
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
Subject: [PATCH v2] mtd: rawnand: Prefer struct_size over open coded arithmetic
Date: Sun, 11 Feb 2024 10:16:33 +0100
Message-Id: <20240211091633.4545-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:T+hTP+nIP/OHyAruT5vbyzud6ys/lN69HGWrX4oTcE/i2FVhsLb
 KB1+1LMkHVn67DYnshciNkLlvXJBH7PrHaD6kPazuidAQ3uf7+ILEuHn5Zug3nf5IWR0uLP
 dQ8jOMugei9vxKq8tNZK0YEo3hnZmFtY2P9kqlssEl7RsuygsGmnYzSjBGSbzhdIDw837pK
 wZXnBXQy57CiHMIASp4JA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NSjmnwszXxk=;Cbh7RAxypTb5l0v+Ku1wyOW3xX4
 2FZLp9I9qGqFp+d8FikX8Mb/wxlht9YG9qt1CThsj//a/h5HF++hqJyWvp8s8bpQ1DCp7h2J4
 bvHP/orYTs1qm1TyPc2oSzxWu2lwQTwO0mIpQ17idfrdOcnVdOqp2Sj3uqtGa3p+aUEhdg7HR
 qyazQNUAnNw+Rm3a1izZTMDwjK//gpp9KwThVr/fd00ZMlO4KNWTEGzS2uYtqdwc+7k+0eskv
 TazVSmv5nzuEmGxT5/enrL9wluwpJzdudwgZEsnRs2vW5zxs4pR8JpaGQe2SwfPzxDehLsOWU
 Rz+m4X7qrsoUXkwjEqRDjwJc5/zyG28dABjemoW9LPKWaHnbfCqc20rAcT70EDjM9JSBOxdP7
 8Suh84GDpLmXFSY2va1VIUEDWcAETfS5YhfsbmB+wMi5VMKlEYSLk1uJ58rVPfN1q+Zozz8Z5
 lpDMnHVIga52kjN1m+nj30z4AVhsXwE9R8ck/N3UuiLD+UOs8fIhAEcOjobLbu9KsJkPToVgR
 OQPs9w1hJn2lU+kVkpea+Q0aVOSDMQafkDwQu4RYWBH6D3IWTrFq724+a8uEb9cKRwLhTb/h8
 DTRKlGw0Z49mn5o3qdVIqL8zB0+hsAlN0MkjVoj8KuWQnZQUdODeeraM/8Gjjaq6b9+H8cUdO
 WVT8/ytmHjbeDcCSVNEp0qJyNCu9M/iaNm3bzGR37WcuSTqKA+15SX7YfHWv/nCjnLb1i5gr1
 MA0ctpGc1u24wlGJ4YCxupldxRrbxhpJJRKhweMz3StESKeJtnOiu5Q8YCuPL9mKzAMFa0nCg
 cINxvhCxkLxbckyyyVzNI/VQJHstAhTQpdn02cGmDVikI=

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

This way, the code is more readable and safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-=
coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Changes in v2:
- Add the "Reviewed-by:" tag.
- Fix a spelling error in the commit message. Change "more safer" for
  "safer" (Uwe Kleine-K=C3=B6nig)
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


