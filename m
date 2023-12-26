Return-Path: <linux-kernel+bounces-11473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B74D81E6DE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1521F214A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6CA4E1BA;
	Tue, 26 Dec 2023 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="qctTj9H1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0429E4E1A0;
	Tue, 26 Dec 2023 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703585548; x=1704190348; i=markus.elfring@web.de;
	bh=dPv4vm2V0dtNM9i6ea9tTX3+xLFfWPWmI5QeWJPTnZk=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=qctTj9H1YVuIc3m8+kAdWWGMz52a5nerjKipKUSb6X8ybQ8HqLI6Fm7K+JOA1q/j
	 chiHL60LtJaQG8B58YOM4rEr9Xx+MEj4DQLXr80xtHmwVA+t2Lzh4Juxb/xXQLn/8
	 JUBotIqKsiDzTLSsPto/n+/GwCINXYPM13DmwzXE3nBTKZ+uqlOqTu4ESJcHDKrKB
	 o/oPJWLn42XMytEJk9QA5fSpUPH3u+Ga9weIjWDsGTDlmxjN/45/L3ayhy8ZxKW7l
	 NbMKFMb2jaAQxa7Z6K9Os2ldxslTommCScCEiAI7p6J++Oe1zU6KUu5yMo0Y+dwts
	 Ih+seoMJWTukJthKvw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgzaR-1qmKZd2f09-00h0gW; Tue, 26
 Dec 2023 11:12:28 +0100
Message-ID: <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>
Date: Tue, 26 Dec 2023 11:12:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Content-Language: en-GB
To: kernel test robot <lkp@intel.com>, virtualization@lists.linux.dev,
 linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Gonglei <arei.gonglei@huawei.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
 <202312260852.0ge5O8IL-lkp@intel.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <202312260852.0ge5O8IL-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YN0MO2vfA1atqF0nbfqn3SUIOjqrjmmzVaCGbVBzhr1uK75lo+t
 Z+XanIEq02qD07l7cGh0qCNmrpZhVE1z34Lyp8XzjJZz1NMCNGi0WvNA0YgL+CUCd3AkrUH
 u4m7w4Ne71OdUv3nbMx76OomPu4ThXd6ZHN3zMk7meKGBNwTcpJaMKYb1ZhMM9nhYIGQd72
 CDypDzv2I327qYKzDGLtg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:8nuqnBAmzpc=;fggNP23Hu6H5jAMVog3j6WuwsVy
 SNSPoYpjKMwrNPMQKvNUF2W2BCNiSMXM6+szPZlgk5czdie42gPPZHtJ7lVD+Ve9gzqracOJ/
 vJ5Nm0XtiPrhTYtne9KKJkgViiSJ9VRdwEOQg6qSSh0Mb6GF61My09Xu6t5blbdrTD8JCW+hi
 ZTyonCXTwrNSC5ybEZGjj1n1oSG7o6W0ZyXTEGYjlWq1Uw0g/0LYWTSyw0Ul4AyVOp9mf5bar
 LyyuaOfeY/6x8vmc4qN2V+wcRolHAdWvCkMblNmdfH5VNDTOO/6vgqOkQJ+4I+RmhODXe5aEk
 zcSDuO/zOLanNfFuqFZDqVUBziTSeoqXMdbMmvR+VbZse1YRLch5Kgaddv1kU57k/LvAdCeV/
 jITnam948vgtGL4CSq8sG+SNxwq7haNKwfXVlqMV0PvdcaZKULiS7OwcIu+JAjAExqHxn9VhC
 sQxEIQsHz0Vros/asQqPXaV9By64fZ4xZV9YTcYW9kYUMzFbACzWecX2MxryUt7VZdNL0hAKD
 h8b9hiub2b7uHr2lWE6sgLF0Lza1HRxLQE4P1gx/2/FK+TdMtwfi6fdlCUq0YAtkVAjhJ3Itc
 7IQDzC6bKhG423ry4K5JJNPQrTieQVnchifFCJs9ji2RXXV7XAHJXJVTFsCMbvMSzqAYgrCjE
 ju2Lwc6iP4UF7ZT3PH1U5EkOjtkCUdjCEKcUxI9LG/RG9IQd4xrfJgOvxzxFRAa0hNFbco+mU
 3K0PdeaQhY/3yQPOjtIfTCJAM0mn9o5LiJ/TwzfQnF6fBQgzwjZPllvg7PJdAgRahw1GDP0AU
 4q0P9MY9OqRHgjCkBcqICAHF0Pb6L3gb166r70ry43nveXIZQuABdfP9ZVueBQ6dIV4gzclr9
 T3QMf/bkPp2VN9TN5sd/4dEflY8gfYX/vQqODRKtrK+Izhm70lJna8tRR0QH1TcGjBgoTUfi3
 VOtIf1J/PSAE+RJkUJCU2HoAB14=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 26 Dec 2023 11:00:20 +0100

The kfree() function was called in up to two cases by the
__virtio_crypto_akcipher_do_req() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Adjust jump targets.

* Delete two initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--

v2:
A typo was fixed for the delimiter of a label.

 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers=
/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2621ff8a9376..057da5bd8d30 100644
=2D-- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -224,11 +224,11 @@ static int __virtio_crypto_akcipher_do_req(struct vi=
rtio_crypto_akcipher_request
 	struct virtio_crypto *vcrypto =3D ctx->vcrypto;
 	struct virtio_crypto_op_data_req *req_data =3D vc_req->req_data;
 	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
-	void *src_buf =3D NULL, *dst_buf =3D NULL;
+	void *src_buf, *dst_buf =3D NULL;
 	unsigned int num_out =3D 0, num_in =3D 0;
 	int node =3D dev_to_node(&vcrypto->vdev->dev);
 	unsigned long flags;
-	int ret =3D -ENOMEM;
+	int ret;
 	bool verify =3D vc_akcipher_req->opcode =3D=3D VIRTIO_CRYPTO_AKCIPHER_VE=
RIFY;
 	unsigned int src_len =3D verify ? req->src_len + req->dst_len : req->src=
_len;

@@ -239,7 +239,7 @@ static int __virtio_crypto_akcipher_do_req(struct virt=
io_crypto_akcipher_request
 	/* src data */
 	src_buf =3D kcalloc_node(src_len, 1, GFP_KERNEL, node);
 	if (!src_buf)
-		goto err;
+		return -ENOMEM;

 	if (verify) {
 		/* for verify operation, both src and dst data work as OUT direction */
@@ -254,7 +254,7 @@ static int __virtio_crypto_akcipher_do_req(struct virt=
io_crypto_akcipher_request
 		/* dst data */
 		dst_buf =3D kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
 		if (!dst_buf)
-			goto err;
+			goto free_src;

 		sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
 		sgs[num_out + num_in++] =3D &dstdata_sg;
@@ -277,9 +277,9 @@ static int __virtio_crypto_akcipher_do_req(struct virt=
io_crypto_akcipher_request
 	return 0;

 err:
-	kfree(src_buf);
 	kfree(dst_buf);
-
+free_src:
+	kfree(src_buf);
 	return -ENOMEM;
 }

=2D-
2.43.0


