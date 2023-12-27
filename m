Return-Path: <linux-kernel+bounces-12099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1178F81F001
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 434C91C2179D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BB45C06;
	Wed, 27 Dec 2023 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nXKyQupF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F446534;
	Wed, 27 Dec 2023 16:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703692924; x=1704297724; i=markus.elfring@web.de;
	bh=16Blx+9N7z4bjqF+m7XVewE8iR9w3Nt9BYK+5r91TuE=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=nXKyQupFmo4m64oK7Py/UPodRNB3Pkrvj3shcnAfO2VQxs7d9/u5Ag3vc20ym/GO
	 8T6B/pCtyLiaT5LUVgZpD4AZTmoi5L4QF/bVf+xqET27S5e0ACm6PY7Q0x6+/TSBK
	 kDuqYBwr9jiHYPXH+AE7bTapOzwThYXh/HBJZcPMmkLc2OhLVtBRuwxKTAVSqQw/E
	 92xQqq93cZhiQs0MwCQ6Jg5yLqlRraQceUdCULwYzPX1QxZoe14Ox4NOaGhLcJx9q
	 uR0Y9PwZ7HvjZGNlGtUdNhcHC6kA9bqmOqQENrZIgCtAgawxp1/WaH1GBZD+ZyORm
	 ucvyUHan+B2/NBlxzg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1rBDIP0ksn-017MNO; Wed, 27
 Dec 2023 17:02:04 +0100
Message-ID: <0a98d3b6-e0ec-408a-aa2d-f2b23dcff26f@web.de>
Date: Wed, 27 Dec 2023 17:02:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] nfc: mei_phy: Return directly after a failed kzalloc() in
 mei_nfc_send()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
In-Reply-To: <9a683f73-c5a2-4b80-af1b-01540834a3dd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W/Z8o/ebT8qpjn7mjOZHqGDXLydJr/iUnte/oPoN9Zad6aSwnd7
 oNHLsGSs4G2L5LWejGRz55i4BzHmghDJS26wD0kCFK1fQ14uOyh5V6eysxyvezJtsDqZqhT
 6+h7hUlmjX5oCaUBtQ2wH6Kg/wQU58+EWPUZlz1eVHEY5APPwLTiKJtgKflCal6fhmnODBd
 2m9sNG/OAtgrng0ux2Gfg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RwLqXCnTS9U=;WB/CrvRL8cCZcbwoyAyBMq31xJZ
 Yh+p0YHY2Z9lkWI3ozXZwEXCOK6KYLocBXOlpsf6A9hcfX0vbGz36Cj4t3JnValiIhhFNk/lK
 g4L7ZpP8o6aIpEo44fl/Nm25vBrgBWCPxX4Lu4csC8mlkblRhsPSoXhAPDSxyaiJPVFzr9R8r
 5lV6YA43DJi9v4OMdT5DuqAReYNWrEVDq8bXAP8Hy9sFbM0712pW8ub5Hf0CZejYH1vdG8zNC
 755xYwVuODj+XXWrAt+ENVw6l6RXWF/qPbGQlVoN6TGRpjLkOMhb+kLir/LXOIeb7HYnB7xb6
 nhYkHXsaZhZFMIU63pt+J8ALoqgnht36er8APhCQAyh+0slogvBcXMDa1bU0X7aDSGPfqIyhH
 bwwnARIiu7SGKCpAjtOhYNg31qDzZDm2pKxS7DGO/KolIUNKlpl4G7aPOSVsl925Z8MvMSMql
 OFfgm5+GzmxWd9PsyJnxQk0OlZ9Qy73VAEo8jH+w3NO9BAqMtTycWPjGTQVAjgg44D9l2oLJl
 oY5VtNRIg+RDXBxOLj8FVYl1kDcpWqPyDQRZJZs7PYKhef4BzjzMV4PAe0bX7OGB66/TsVheC
 BSQeq+v8mWQdk76d/KHRwkYXdoKG76K1cmVnb+aMcgpuxF5Zb+jn73CJbK3FEFD/BKT5OIkGP
 n3aE98Gj68goGUmdKgQUyLbX8URiTlB1hoDtGUiBIXkB6kgjtXI8T+8AuYxVZnnsnAxyGtKI8
 6tOi9yLiKQl1FADwfc78SCEMRUSot4ao5aaZx4a/qqa8ToDGXUzH1WiPt6DZCiix9Tea3T6/A
 rttbihdh3TuZe8kA7MUkAaTVgZ/UtUi/yBNtELjRnysQqOkJCEdXKc1khazNnOCPrZ8jZ6BBo
 DS9RxW15Ishhxbz/azlCMVLuCJVigNJzWo/GEvSbj+Q9xBr6lrKoK1Dhk2H+7Verwpruq6fdY
 wfcTXw==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 16:30:20 +0100

The kfree() function was called in one case by
the mei_nfc_send() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus return directly after a call of the function =E2=80=9Ckzalloc=E2=80=
=9D failed
at the beginning.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/nfc/mei_phy.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nfc/mei_phy.c b/drivers/nfc/mei_phy.c
index f9cca885beec..937f229f4646 100644
=2D-- a/drivers/nfc/mei_phy.c
+++ b/drivers/nfc/mei_phy.c
@@ -208,10 +208,9 @@ static int mei_nfc_send(struct nfc_mei_phy *phy, cons=
t u8 *buf, size_t length)
 	u8 *mei_buf;
 	int err;

-	err =3D -ENOMEM;
 	mei_buf =3D kzalloc(length + MEI_NFC_HEADER_SIZE, GFP_KERNEL);
 	if (!mei_buf)
-		goto out;
+		return -ENOMEM;

 	hdr =3D (struct mei_nfc_hdr *)mei_buf;
 	hdr->cmd =3D MEI_NFC_CMD_HCI_SEND;
=2D-
2.43.0


