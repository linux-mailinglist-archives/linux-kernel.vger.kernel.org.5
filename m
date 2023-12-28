Return-Path: <linux-kernel+bounces-12498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC3C81F5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 08:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8235D1F21C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595626129;
	Thu, 28 Dec 2023 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ptxRr5i8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCA55666;
	Thu, 28 Dec 2023 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703750200; x=1704355000; i=markus.elfring@web.de;
	bh=q8LQkX8WL0q3ovc2/HmVfjQfSvCey/AWBJG2oLVNE7I=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=ptxRr5i80CUS53R4ILu8PrPgbo46hMHfZ/sA+iaCGr9Su33ztPyQ+z4Dpn/WzIRY
	 kvhyiQXULXMpUnKZKXr1uFq4o0eGvRip4Wd8YCuzgFL77mswS4WhsOipzIeFU2CRt
	 2O1FWjCpO+zHzQDVvU7hrM213LBWbR858Rc/QdDas0nM0s5k47DJ5341VaCc2qHH3
	 tVtnskOnfrwIwEagqXZXQhGPN5PYw7c52k7jna+GFpQeZ2Hr2kxd6LajbzQ65k4/y
	 QYqh9AT8JwqGXiDoLas5rQT1IaE3pu/LbJMXmpFQbouxxTk4wapUxttHt5FoL8LdA
	 Gs88uK2PSl4qc+2OpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGQGF-1rSMgn2cqT-00GzyC; Thu, 28
 Dec 2023 08:56:40 +0100
Message-ID: <5db36d2b-afe0-4027-b22e-ded163a409be@web.de>
Date: Thu, 28 Dec 2023 08:56:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: chrome-platform@lists.linux.dev, kernel-janitors@vger.kernel.org,
 Benson Leung <bleung@chromium.org>, =?UTF-8?B?R8O8bnRlciBSw7Zjaw==?=
 <groeck@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] platform/chrome: cros_ec_i2c: Less function calls in
 cros_ec_cmd_xfer_i2c() after error detection
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i3MXYHdK2HPaWLop5uSkw24RVPcYPI6DyUco+noAgA7fgxbj0ZP
 vPWTFh4o8cLcjZkOlDl7OmmTnwkkAhL8Oey3a5GSdD9nuEccMJFBXp7RG53Jp1m66mr8LTU
 yvyYJda07b4I0Ooj+ZBt2OtGDK/rN6lNCPteRh2x2AgErC6u3VhSmCsJUDkm0UUhgB87wqq
 /vzHvHZOqrtbQT9HhNZcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mA7BOUGQ7iA=;EGuXqaI3Y1WHScJysMcyY4dztiV
 1x9BrZAZgJ7f6W9OqI4alz5YS4wk9bqfDCL4AEgml+vEplXy9NFNLxmrKpjc6+p9DOfwEHT5S
 2o7X9SaPf1neB5JX9DdOLGoNS4BnOhb1MSRm2PBLAexz4yoVgYK8HoLO7ROxYVorxGJMfXUid
 v8H5JCSE5tNBGNeWiRryZ6zlxCvLdnmdG0VxMyf7j7pUkaGJXbADDeJRgXLAp84OnFldTnGzC
 7EMMAlVk8rdm4DnunYDQ23uUe7F9MybNtE713N9YoilRrb+Wvg2P3+VRMjpFyDwlkvGzJ0R8C
 FNUl8fGTGtPvxnK/buJWtPLgTmUVfz8DItiffW7PA8ucqNVeuMEL9fRFeWF9IeJwPxvduDKLg
 6uPSPEQNei74EkzSSuJgnkYieTXAUy5yfQVejOFroYvIxydj/6p4727nF56IRL9njZzzqusoH
 jmNfzbt/hHePXqhee/K9RezM6RMtyG6sdQKtl/NOHefIYSZ4pX+TrqpXlCURn+kYufyEmO6r9
 aa+IvagxEyiYZu7NJN6m8lsPvyfyIlX0IZt5DJfUjFZ4HAwyFKup3boHZpUupuoq8WXSxAZ2p
 gh5uMz5QjUkrkeERkGLenAR7PlOaYkVguGIKaJTd7ncCTHVYlS5jCt0uxMlC9vhJhyvah+CYM
 HwJ12PZ5sQ/1avh1wEiKQc3FyDpGAa0SLLBGyXM4tZxGwHxcgrgPwrwTFczThCEkFIZ+iHTJQ
 Mlc+e8oKQ1Ksk1lGAO7J9XzQvB52hu4tI+GLVbFtkq+YdXVF4KgJKE44HrU17vpUYQedDV2o0
 mzLw4Tr+IvLUWMB3uSfm0yQ+AfQos4lKzw7UT/ogqlHfLZeKbuWA+FZ49IN1AZxJDxtAguY+7
 4cKz9/X1WqLE3WqZAUYYoxSV71xoHjkJNX2L2J9VpMoQ6E444P7/wG5txNlIk5RU+9BEFDfSt
 HeaAetIoK2IJnjLXL7OcrTxzRIY=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 28 Dec 2023 08:36:49 +0100

The kfree() function was called in up to two cases by
the cros_ec_cmd_xfer_i2c() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Adjust jump targets.

* Delete two initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/platform/chrome/cros_ec_i2c.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_i2c.c b/drivers/platform/chro=
me/cros_ec_i2c.c
index e29c51cbfd71..2a6ec623e352 100644
=2D-- a/drivers/platform/chrome/cros_ec_i2c.c
+++ b/drivers/platform/chrome/cros_ec_i2c.c
@@ -193,8 +193,7 @@ static int cros_ec_cmd_xfer_i2c(struct cros_ec_device =
*ec_dev,
 	int i;
 	int len;
 	int packet_len;
-	u8 *out_buf =3D NULL;
-	u8 *in_buf =3D NULL;
+	u8 *in_buf, *out_buf;
 	u8 sum;
 	struct i2c_msg i2c_msg[2];

@@ -210,7 +209,8 @@ static int cros_ec_cmd_xfer_i2c(struct cros_ec_device =
*ec_dev,
 	packet_len =3D msg->insize + 3;
 	in_buf =3D kzalloc(packet_len, GFP_KERNEL);
 	if (!in_buf)
-		goto done;
+		goto check_command;
+
 	i2c_msg[1].len =3D packet_len;
 	i2c_msg[1].buf =3D (char *)in_buf;

@@ -221,7 +221,8 @@ static int cros_ec_cmd_xfer_i2c(struct cros_ec_device =
*ec_dev,
 	packet_len =3D msg->outsize + 4;
 	out_buf =3D kzalloc(packet_len, GFP_KERNEL);
 	if (!out_buf)
-		goto done;
+		goto free_in_buf;
+
 	i2c_msg[0].len =3D packet_len;
 	i2c_msg[0].buf =3D (char *)out_buf;

@@ -278,8 +279,10 @@ static int cros_ec_cmd_xfer_i2c(struct cros_ec_device=
 *ec_dev,

 	ret =3D len;
 done:
-	kfree(in_buf);
 	kfree(out_buf);
+free_in_buf:
+	kfree(in_buf);
+check_command:
 	if (msg->command =3D=3D EC_CMD_REBOOT_EC)
 		msleep(EC_REBOOT_DELAY_MS);

=2D-
2.43.0


