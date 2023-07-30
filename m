Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E0C7683AD
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 06:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjG3Eio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 00:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjG3Eik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 00:38:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EBD990;
        Sat, 29 Jul 2023 21:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690691911; x=1691296711; i=w_armin@gmx.de;
 bh=ppZ3N9xbXVQLye/TUgXN3mwxwN5QaCrAO8Uykzqp8q4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=pFl/p/Dt4DxVqMTrTnSH42fxc4PSZv1+qaSusQc9jC31/O4+ud7nRvNtY8g5uDpb6WItQMJ
 5nWcGOULIJ6kDVX+9BdgNtARA9MTVBAzfFz/gS/1UQ0dd1tVSGIyBrcVUe1i/bwXR91lNakmW
 RtMCl0azIC98yOfWayNWcAEVzmd6zo/3wLf1IjRm3XSGx/ISWdC5qUw30yyINsm7UuzPAiqFT
 2mIvbU8PbhT4/NWTdP1WhQ2tmt+hsnwmmub1Ic8WED4CUm1sAyEWcsJ1wwR4m0s8kHKu+ZiG5
 hJQ6tyMoAX1tZtU1paltLpdsEfW2yJf3Pg5E6U4Jzcjtv6kAfwmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mlw3X-1pzg0K04VH-00j3ru; Sun, 30 Jul 2023 06:38:31 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] platform/x86: wmi-bmof: Simplify read_bmof()
Date:   Sun, 30 Jul 2023 06:38:16 +0200
Message-Id: <20230730043817.12888-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730043817.12888-1-W_Armin@gmx.de>
References: <20230730043817.12888-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:d13USs0sWiOCl1mSrpyTf2Drqr0gR2u6MQjVGh5ZCFreA14nqSC
 ml6n8OBXwJDu+CTRtifJ7KPQ/bUs+v2ShhPJBBdjiCHkWJa7L3oAW/CiIp1s02oUPfGx0wr
 HWM/zPn2qtPlvzqynnK9eIUfkaTNZaPmArjXol9iRJBQDqDj8a7PYLhTFzBdunFb/rza+cP
 HKGn5HAws2b217tusRBNA==
UI-OutboundReport: notjunk:1;M01:P0:j/wGR76xZV4=;D2fJ32ernuagQWbQZCbkikelh5f
 020Y5sVkRbkgZKJIfsuzTj7hmlvQO6vj4z/qrVdgJvK0N+QtJwjYlOXE/9ZH76Rod0IrTs9MC
 Ra49hvCy9/aAW5xGo+i4+qYW96d8xxG4XXErDodyVVCry4HXLPxi9DSrplXl0XFvC9wRLKSQb
 /qNsa//8XJ64MJDDxar78B53I/X9AtKxCdVtU31Qz0bkqwyQrxfV8C+nXeAApQS+Us7gMp6J8
 0ve2zz4d8x0q28emBfjzPnEOW+bAW4OofPCxgFORk/+v+bhR6w3+R4gWquv2aEmJPvbkhBrpt
 AeG2sL2vOV51yF/qAkSvQXf/5cnrcZN7mdc4uTP3UafPf1Zqc8sNwJkdr5cts/PGokd+bCom/
 W8s+vwuITfCGyV4mOxWJeNFCNyeelD4IJakFG7Qhdj9KWQXtwnXF/efTdv4pZtfE7DyZtBaAM
 ibA/Q1zkM8B64+3OQNEEnnR0Dz3szlt60OxetJhG88TLpjkrZTp+s3D8RsrXYW7f6UgSxNbnr
 p/s6xUdb7fTaYO8qTJmv2U319CdfOqRvKW+MwM92FAAB/F8eZBL3pzGID1uJPOvEfr6zvBrvU
 4LTi4tkxe1R4JKvxjOTSw6wLTW0MvShZ/hBuyxzuei2eXqAd0NkLqOIwRlKKAoTvj2TnIiwD6
 8k2f/660ogNdJi53ArtIxk3FrW+fk8okxyWHPqs+ucRvtDBJ5LU7MepAkQLaa11ZP9Odel/i1
 9Zo6GAjAi6RR6Z0ERAQ/WxSzByCjtexfP7XWJO+ReUMqgabVLG9ihQjjYji8KHu/zB99T2Kk9
 Bf7eD01+MLpQRyRNUx48T4gOS/otfWpK4i3KZcC52/3cyEjYGVp7Sen8P9hNYWiVn4ffntzhe
 uTzQF3roh1GUMHSiVP2FUTJZyAZijSl9RDTZR5hE8tiLgAcicovOznd3iSi3YomQAZ3uc4QFY
 13bTWUz/QyJMKAZyd+Epm7fwdmU=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
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

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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

