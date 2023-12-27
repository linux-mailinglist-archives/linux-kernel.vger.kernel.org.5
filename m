Return-Path: <linux-kernel+bounces-12057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE8281EF86
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2BA0B21315
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4434594D;
	Wed, 27 Dec 2023 14:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="H/m2q2Kb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F5845033;
	Wed, 27 Dec 2023 14:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703688317; x=1704293117; i=markus.elfring@web.de;
	bh=t84TSl+EluuPPFuJEer5T9HrQmpz9O6xB+/yns+xpbg=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
	 In-Reply-To;
	b=H/m2q2Kb4PMC5SWfgWh4y4kWC1MkytkybccUGoogQu06U4j8fAwIBnZ2sg28HD28
	 Rry7HheBp8jVcB8aTAfBgqAlYxIFLOjEil5Jyn4jynQJWHjWZ5D7mzjvypV3Zbeb2
	 muVERTBMDAtTQ9CtIuWNCcBXbJxtBAZFJrQCp8Z6svtTKI3+cmRptxaWjEqK6sBot
	 AVdbVW+T0lWyUDntX9U2rVd3mNrYD9O86cB8oSn76sfUfsai1LaxxCmvBz1JwNv4s
	 sgmJb7nrkD8phbu8Fxg0n4xN5Zi8Y3hMBiLBDoK9akN5GaY1ZY0mlOsCmzc0Rgdes
	 CrSAV/zXrqnPYeNs7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MDe2F-1rR0020xc7-00AbzV; Wed, 27
 Dec 2023 15:45:17 +0100
Message-ID: <56d92e42-db9e-4767-bcb1-9686bdf34a03@web.de>
Date: Wed, 27 Dec 2023 15:45:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/3] mtd: ssfdc: One function call less in ssfdcr_add_mtd()
 after error detection
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
In-Reply-To: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DsSL0eMHaC2Rk2bw2q1D0zcazt2/fVc+/haL7c/aRJkCieBC1tt
 0AXAwa47Os+poIspl2AHdEo5Z2KI+HFZ8C+kWvuMOXzmUi04y27MTHCaZ4S63IVf3/kQf3Z
 ae89RkE7EPfLGSuhxATXgiCcaIb7MRxaSo2mNdZwiFjvT9gfysj/3ZTtLca3OMFUHxbJkBE
 0DH7shC3T+uLv9aVTo7Dw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:43YQzShyX3A=;Ym3MFRhSF+BgUSwIX1xJPMjb5eg
 OrUoJO8pr+zYBSTiBAAl7M1mwf/bpo/+kf4cCjuVBVsl/YRMGD9TNV0W4T776DTorY4brh61U
 KYwd6aAmS8KQ6N02Ucm4EXPyAX4qprD66QosY55lm/+2S6Yo464UbbDVYPrtDWxqUDUJ39Q57
 bc66AUAd+5hHxQaaqoKhfO2zXFJjtUAoiIDNnVzvkz3Ip+eomd3i9vvKW6kGY8Uy9Gb6x49qy
 MYQS8cN/4ShzTEJ2+GAVbrE/y/caS6k/5+mWH3JobIXgJRy0zhCSnu0ugZmRiZhiXSapFv144
 gvF2thSS4OiixNpQjohoLsCBC/mbjKUwuODFmhUuRIg99GU1rQFCR0rj4WwdoGTdJqW37lcVZ
 MmP2uhpY9YMS0K6ifMVQAEOMS+LThmtvMZJLzQM9vwiAEcIBLo+cg0pqUJIsqu2lVj3o6NbHY
 BED9msOL9wWM21z4YBe8QV1RrOXlKAgUidWGjFLG1u5nfCKa2xkxjQozsXWIxLMlCNiZZgI7J
 yg55oNgrWQwEvLI1AjX3svQ5dYFxK1uFQD8FwcsK17HX4WEIpBD4d9U8lAtPflEgVwx0ltuJW
 gznDq6fOUGvIRQ1gOfhLH0F04ZQSXmHGlFrRpoflaO9d6XAb1aQGPARd+diDnTko8kFeTbOZO
 IVwoLEvvuy2dW0DYQm+G8rAJYEXiGXnAWY+PtGBROxQcVlIPEqo1R4Kko2PjP7hZrU12FsrAK
 X6iTVqHqbRM900sJZBork0oNaiktsUPFW8ct62gnKrMU7/XSTB5UYZhmDScxQyl2Oe95csP+u
 bsduiDeYiwJZvOCTKqWSHpKLfzuAM7DzxBEpMBYJTkKBLz16ibxjz2b+n7IvERUF4EycU1B+2
 kSkzyfVRW+M0GNoF12PsGlEtLixSxOW0gXe+SRa3G35q9BNoCvEVRy/V/y8tWCBRivhR4u3tB
 2TuarK8cb68v5enFWHzhNPEB5oc=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 27 Dec 2023 13:21:52 +0100

The kfree() function was called in one case by
the ssfdcr_add_mtd() function during error handling
even if the passed data structure member contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/mtd/ssfdc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 211f279a33a9..3ee8535d4515 100644
=2D-- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -332,7 +332,7 @@ static void ssfdcr_add_mtd(struct mtd_blktrans_ops *tr=
, struct mtd_info *mtd)
 		kmalloc_array(ssfdc->map_len,
 			      sizeof(ssfdc->logic_block_map[0]), GFP_KERNEL);
 	if (!ssfdc->logic_block_map)
-		goto out_err;
+		goto out_free_ssfdc;
 	memset(ssfdc->logic_block_map, 0xff, sizeof(ssfdc->logic_block_map[0]) *
 		ssfdc->map_len);

@@ -350,6 +350,7 @@ static void ssfdcr_add_mtd(struct mtd_blktrans_ops *tr=
, struct mtd_info *mtd)

 out_err:
 	kfree(ssfdc->logic_block_map);
+out_free_ssfdc:
         kfree(ssfdc);
 }

=2D-
2.43.0


