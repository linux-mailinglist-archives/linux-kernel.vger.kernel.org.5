Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67408768807
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjG3Uho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjG3Uhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:37:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6940E78;
        Sun, 30 Jul 2023 13:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690749450; x=1691354250; i=w_armin@gmx.de;
 bh=OHiBItOOoRVvdzRbZEFrTfef1epBD6WyUoDTx7C3Ghk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qChqEIyp5BPwswbnVVqJZUGwXcTJ8qjTlBl/bmSZfvh26bQpZO6c4y63MDgLmGSJplMxd+U
 xFJIHXoZp6aXlR5QXk2unyPIyncDsYgIi7NVp+SJW4IP1KKQenL1uj/nKtQOODiJXyYeojy7U
 MW9D/MSNLs2WogU1ADAdJWv5gohRxuwRaXQcJdCDLJxg3nXYGFm2vIS9ua7QWV1kuU3oYmz/d
 WumCO+qpJ3E4rtUPHxbcwxMlr/HVr4AsNd9OuKjeRdNKHawcV4yPttbrdO3NQPmGq/lXzV2Do
 3orwm0ZJYrk3ca9mu9LuRUKZ7kICwB7IK1n7FX/xYTwQDJc4jLkg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1McYCl-1psFSZ1JDZ-00cxed; Sun, 30 Jul 2023 22:37:30 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] platform/x86: wmi-bmof: Simplify read_bmof()
Date:   Sun, 30 Jul 2023 22:37:22 +0200
Message-Id: <20230730203723.8882-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230730203723.8882-1-W_Armin@gmx.de>
References: <20230730203723.8882-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+jEY729e0a0EDFLX/WhlWcj1P0nEjB3vk7ox0uUuhU111ghutn1
 106dAHOv+az6LaTIWKTAgjb/Ib31fmCvb0YJz0UxLI+d/sZq3fIEaKQ9TKUtFf3vSIlxwB/
 iGwKrlV+zLXdgrgqqmtX4WF0+PmFJyXlyuA/x7NTx3e6lfwWXzdVquPEYRmY1ZdseQDJiyN
 ikVJ4oYQ6Vpd7trEuZDgQ==
UI-OutboundReport: notjunk:1;M01:P0:JuG2dx9mxfY=;KHB0ZeQJ2kTc7/U0mYkH1F6AFA5
 Edm45XN0TAdkrmHEA3asaX0TCBvTc3tG4Z5FTxaQZqJ86u310FuE+05tRdZHReYi7QvKqt3Fd
 tjbGfIMPLdraKBnPXKch97A7CkhxBTAsB9K113sjAYnJlRcBa1If4I6Luvn3chrrtIw/imuPT
 4Fou2IpziAcwPVWz6jNsopqfAN6Otje4wjzqIU/d0nrpg75m7hDXQHhhphdVkznnl3hgy5SPC
 k+JEmU5eEqYk9e5En1svTVmzmGarB9Ws0lc5OV5yDfSXwZWXLQKfTXsknQqFjDup7MDTx6c7O
 bqTBbCDF9au7DCl1NaDX4KH2IMs9sGLXgsOPcVFcshxdY0k9HOqXfUa6lEB04zuskc6YcsIWY
 MLj1OvPQTaui9MOaOonhhZL7AmM39ja5yrNhkmg46RP8GkHu/w3f25Y7Rsj6XlCOe5uBGtUXy
 leXnlraynTiqHnJoZi8hbZUMYG02oI09KDX81gzvcbcG2JSwNOwWj8KegfPXMpXCYj0/S8rCp
 8pI6kcg96/uF81NSqzeC97o+zModmFcJ4aWFAk8wpHDabwqI6uC9LleMWJ2Tq5ztLwLSbWVRk
 hdJYeJU+BLDC/LtVpUdFEbWkpsKbsKrRTwmffZpZsJa6YgmKGULraePJX6MJN7cAPuutmEg/v
 RuKlCqNJatEq28eyI6B9kv2r9Rd7lE2u0omfP1oGf6SBkrkGTaF2wPZzmuqTu+7pFpDLnDZ8Y
 gg8VVzuBhERPCFQ+jezo1gTQVfVO46gsTl6ypU0bVf3u0EEI6la3SvtVfaGMc2CQRtxRun71b
 0xLXWYz2ByFwcu1qJ3LgabfX2HWbbOTo4KgLkrmpFq+SpdwFbj+ZeC796L52ug4/WzlN281Xz
 T+VmlskKYXV3TPc3h8UoAbQ6pnqMyLlHZWu0GUObne3NnUJy6LS5v4U890DKb4jburajB/esF
 cNfy7dL+twhohXECCJrUztSuDX8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

