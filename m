Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D420D768815
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjG3UqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG3UqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:46:05 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05710C2;
        Sun, 30 Jul 2023 13:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690749955; x=1691354755; i=w_armin@gmx.de;
 bh=OHiBItOOoRVvdzRbZEFrTfef1epBD6WyUoDTx7C3Ghk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=IKybR+WNJOQKc/aG8BwCeXjatw5zIg2Y3O2zP9gJH1F2NYHsIQE+MU5NhrMSo+vysYRyH3X
 E3e+GN7Z1S8bSHEnUQjEx3rKk6TElzpbw/CM4VbHW0DSnS/hQkOuVL0aL4MQ0oM9DAXp4wstd
 M9AjGf4hIpLWuAE6sTpyWxV6hy0rXv0a8Bc/xc6Rl4w1C3KMX5iHRnGQpuA9CT8JQc1sK8NYP
 6InzxmmXY0e6Zi9iZbnFgXbbFbAv1DBhHAkwDJaA51K3xeu+spUoFRuvlXDWM3Fxmp1stirXg
 O8CM27TaNfc7IMbmgIBiQwEXIgsRiNlB98dN3vleCKygLqRpUTRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MxUnp-1pg60221iz-00xrH8; Sun, 30 Jul 2023 22:45:55 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] platform/x86: wmi-bmof: Simplify read_bmof()
Date:   Sun, 30 Jul 2023 22:45:49 +0200
Message-Id: <20230730204550.3402-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730204550.3402-1-W_Armin@gmx.de>
References: <20230730204550.3402-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RIq5S3aLWtkYI0xsHrO1jSJmOv5Q9oS1vDYGh8VaEmCVVT+Txr9
 C44oSTSPb3zkqwQ3GSnK9a0Dgj4f2j8ZUbQ2pXhYPdcB+4ZCj1PqvEoK+Jrw9ylgK11OREy
 XUa6dioYGfD3KrSmd6dgwDqkxOh3r4rUTc6XtgIqFRIebyey413Jn38HuSRIW7uJuXsAowQ
 1CbXIcc3J2ANvLMJ7TCzg==
UI-OutboundReport: notjunk:1;M01:P0:8RCZ0gKoDbk=;aIacZXI5yfzmafkD/YwTLQlAON/
 EUg7z0dWypBlFJx8zDWuXR6oHvrRqg5tNMyr5Vh94JhHxvtDh8XaBYFvZ0pDd7s1tzS+7TIya
 6f9ZawTaHZFuncQNTSzp93JtvCbkIk/ZC62rzlko+CkfkaWu4Pizsyi7vUIF9f381wUwEDmul
 UPGh+NrNHS7SBT6sFyEOMZ9WWJQqu4vunr6FjSiaSHnayfAR1FQteEAtNMirnfjXgy4qpGjwx
 0urt2fzsqhNl9sRiekS6J0bCc3BbwpwNxKMbhtTuhVNCl1s+iXfk5qa2QFz0jqrNajlX3fyHa
 NqvKnLYYbxj2eHDum+sFCEA2Lox6FXQaNu02WMDOszDXeGLCwNHBg1+yGNDEGGF3ZDn1qH1KA
 JeXijk2bam/fw1XuOrl/CoycYDas7pqYSwmS93LRfjUKssll6mNnG+SQkAU3BBCzkl3pzw1dO
 1sKDgbMG/SPyEdifBm9JW3Rg6HPtl/9IuQOcBmqDRsF3OUM5TTOS3eqes3Ws47etPdAhGaQvS
 7wRyl1gJTUEWIOvGe8QWL/oowbsGZPbmljfWLtabzxlppyeO3OrX7jE6QJHd6jMuOcOhQboj6
 zsb0QvH4vZzL7fv36yZ7iP8BfDTdw8lNCwctJyXcJ6FgF4zeFtcXKXBuaAsI4L08THJQlGIlJ
 CxLlxZoSYnTUkTpAg4WFOWlVQRZ0tIGHbPIfLy8ubEq0yu62IIzs4PvulQ/i7S3aBPvRpxUDS
 uqNFdXPsHe125y1rKZFxOKcfYwYf9gr3QVGZpHlL0kbW2vFNvBTgNCTP8J03LmkunNli1fcUZ
 xM03CZbuFjOMO76iQQ+oYVZehuSAGF484Ml/WAHRiS5A8wswnw7WooC1mg5lCkomMZ8rtDIyp
 3iI0SHttOyS+BUIiyB/rDFqw9g7nre+zsKCSgNC5Mf1PtGK3rnuyeb+g8uCJLHaebrp8NCPPc
 LvisZ6xe3GsWqForJbAOIOYOl4M=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace offset handling code with a single call
to memory_read_from_buffer() to simplify read_bmof().

Tested on a ASUS PRIME B650-PLUS.

Reviewed-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Tested-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- add Reviewed-by and Tested-by tags
=2D--
 drivers/platform/x86/wmi-bmof.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/x86/wmi-bm=
of.c
index d0516cacfcb5..644d2fd889c0 100644
=2D-- a/drivers/platform/x86/wmi-bmof.c
+++ b/drivers/platform/x86/wmi-bmof.c
@@ -25,25 +25,13 @@ struct bmof_priv {
 	struct bin_attribute bmof_bin_attr;
 };

-static ssize_t
-read_bmof(struct file *filp, struct kobject *kobj,
-	 struct bin_attribute *attr,
-	 char *buf, loff_t off, size_t count)
+static ssize_t read_bmof(struct file *filp, struct kobject *kobj, struct =
bin_attribute *attr,
+			 char *buf, loff_t off, size_t count)
 {
-	struct bmof_priv *priv =3D
-		container_of(attr, struct bmof_priv, bmof_bin_attr);
+	struct bmof_priv *priv =3D container_of(attr, struct bmof_priv, bmof_bin=
_attr);

-	if (off < 0)
-		return -EINVAL;
-
-	if (off >=3D priv->bmofdata->buffer.length)
-		return 0;
-
-	if (count > priv->bmofdata->buffer.length - off)
-		count =3D priv->bmofdata->buffer.length - off;
-
-	memcpy(buf, priv->bmofdata->buffer.pointer + off, count);
-	return count;
+	return memory_read_from_buffer(buf, count, &off, priv->bmofdata->buffer.=
pointer,
+				       priv->bmofdata->buffer.length);
 }

 static int wmi_bmof_probe(struct wmi_device *wdev, const void *context)
=2D-
2.39.2

