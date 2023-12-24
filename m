Return-Path: <linux-kernel+bounces-10816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D8381DC3E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AEFB212F9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE20BDF63;
	Sun, 24 Dec 2023 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="QoZIYXi9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C4CDDB3;
	Sun, 24 Dec 2023 19:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703447762; x=1704052562; i=markus.elfring@web.de;
	bh=cm+fIZLlDlbOzuqZGb6TsofPaKLKFGH0UKkUeJ6PVQI=;
	h=X-UI-Sender-Class:Date:To:From:Subject:Cc;
	b=QoZIYXi9cZqtNGtvF4UCvUpoCNwOxR8e3FLbju/ydTYgpkVlGSLCy5MC8nVGT41d
	 eResBJliME/ri5g5oXcpGtQd7eN/tTvbli+mycPuwFfAAEpCYPv8bFFpmcWBLUZ+A
	 M1E4tfznDYRUXyX/fTG/K//nt3lCGAOz2gskuUMd+dPhYyRfMbOgIT5O8xlvrpe9j
	 kj1gTCRZ1uGzPVOtzG7VUm8SuIOZuY32IdW8pcMq8q59rfsq76B94swfYIVlX4K4S
	 0RObHdyPjK6Jfb4r07GwvwAVFrg3aDQw6uV3QIzkWhBmAhK8U6JXyFXDEdAkt+G82
	 REFyZpZ7q9FVI2T+tw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7xeZ-1rDu1x2ZpT-014bII; Sun, 24
 Dec 2023 20:56:02 +0100
Message-ID: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
Date: Sun, 24 Dec 2023 20:55:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: virtualization@lists.linux.dev, linux-crypto@vger.kernel.org,
 kernel-janitors@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Gonglei <arei.gonglei@huawei.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:js4ydb7183jogO2zNXAOsnmwRjTJkFts4230ojusF5s86M+AW5+
 R5GJtNhXdNtM4tEDbq+iQg1RPiFfkUqzLSGBlTwOtVrdN81X0QdPgkZwQOUuzk5G6JgcA2/
 a9bXWU4zIOkvteJDFZzgqHxnSoSM5vjhMP+WvH/mLObV2o2cMeoKp3S7dg2xNq5LAjTBtMO
 gxGXiKX2GEOup1Ii5BzbA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:WbQ2yg1lmBc=;3P3aWHeDFAyqdOaqJJeKgIAbuWq
 IaQuiX66fOG4HO1fbgWMKF56zCIYOlf1AD/+aEXdGYWKqhXFP09cN9kpPPdfEShTApKnr6BWB
 OBGdTNc/CPS36kVuShgdvl6opR6/xO359mXEID+rkcOltIguEUYU2CITRnsfLCRZSQ0E//dKh
 IXtHvmiBcN6iEiektNZQDOKynYCUCBBps2/cHdgz0qtl3KxEgKhbyrPRSZeQMFybO2F/5xFtt
 p0y2gz506LIVL0Z+76Fyr/WQAUqwFVBvqylEhEJaWnhlg7tjc8JHXoLkfqazE8//fxucj0rzd
 9C2tARpcByUWLK1rMuufdESRp6PZi+WnZXuJb+hQiWvcnPtZ4tmVIRs5TnZi0tFfuC/euHMRo
 NraWgvInU3jVsmCI//aiVaC8snV1L/ZY7i9A14A30bQoxtgao3NIR0ONSAqE95d04LblUro1d
 hRzksKgd17O0eknBO6fIbO+He7glZ8dbMZQGmX7yrMKEZT6PRYtc2mLJP2LbHorzed4YXR+1d
 IYpBsO7e65qV7dpR739Wo4SO+I14ReGMPJzC1dflQ/hmg8jwpUkiHkt/njIbGAKLKx/9wFgKS
 EjSVQ5YZ1iVI39XMUnPUcNaog3hVm4xnsZLJR32H9Od9xyY6upJ5/eex2a6SCLGBq5pthhaJA
 rKkFNI0hbwchKG59NklNFDR6FOBOESDr9TjazPDUTtrY1BxFQr9Mf6l6R9vZ+ckSZyyzp6aDA
 JktyzBrAQlO6KNOQUYxLkUdPYWigCLlRRvz45mv+vYTHm4WsnRQPoYfX7wVRbOsdr4cwWlaJ5
 SvB5fkElpx88XTzd8X0oPqsrZ81am9pzI4lThisgJXALB4sD1xBBYOCdfkPZpw5NlLSdmo8yI
 MsvPcbhr2uh59j20gkLG3pcXm9dQ7ixm67c1pklP9d9ccELRpnpWxsmdEq7JPbQliKyiT9syi
 20AXhQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 24 Dec 2023 20:42:19 +0100

The kfree() function was called in up to two cases by the
__virtio_crypto_akcipher_do_req() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Adjust jump targets.

* Delete two initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers=
/crypto/virtio/virtio_crypto_akcipher_algs.c
index 2621ff8a9376..15dbe67f0d31 100644
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
+free_src;
+	kfree(src_buf);
 	return -ENOMEM;
 }

=2D-
2.43.0


