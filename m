Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE33D80953D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444088AbjLGW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232173AbjLGW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:26:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56D9D4A;
        Thu,  7 Dec 2023 14:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1701988006; x=1702592806; i=w_armin@gmx.de;
        bh=MnUO2eCpHcRNIigISNlEI4luU9Ds7WfsIdhVMY51GBw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=pBj4b30HkNOjwopaKjz/TpjTXy/Y2S+mMH4Gs0lwRbojyJrI6+AHiDqzOEjO9fv0
         QRQ5ytwH1n8MOMXU6Px3+LR7ib2OUIbbblz0/I0InXw1HCGmFgwmVGgRoUkS44jbr
         gS2IzxApthbrFW3oKJ/nH1jVcFSA1rHLWAGPJlrVq28vpopR3or125AXFuZK01lfA
         A4UIZoud+v4VVVELV/mafh7Ldkq+1gkOI3mq8XsxbwT2uzukPfRm5ss1Mp10C7su7
         Tj9fbM/ooFtvT+UuhfX0Rwp++nEuLNIucx7/AhJe7QqTUFwLlxybkMfGEr+Pl/y2K
         wKc8kY2WDAMNvOkohA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MsHns-1rUgtr4AFW-00thG4; Thu, 07 Dec 2023 23:26:46 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] platform/x86: dell-smbios-wmi: Stop using WMI chardev
Date:   Thu,  7 Dec 2023 23:26:21 +0100
Message-Id: <20231207222623.232074-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231207222623.232074-1-W_Armin@gmx.de>
References: <20231207222623.232074-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uMW+ajDxQVUrTn75NdD8r7vsu6sJ0GR05zZ5AGuPswH/RdF0B64
 i7Z+cedGKgj/tfuMT9D5V1imqW+EGmtN/UZmfYaYQbXPcTA9s4oflHxhSg4N1GUKNELNgo6
 qnhh1imosWhOk8WTeDqJqbFxiFjOMyd3Ji8rIfwaJo8WtYo9lkONBrG6hx1xSXkfDOCyg3+
 3nE4S8F0uY9ONN9iflwzw==
UI-OutboundReport: notjunk:1;M01:P0:vyVUJwqyVBQ=;o4t0zqpF4O/QIj1D1hpu8mLFA0I
 5HnT/+40eWglt+OBtHXBDK6jTdfMZXoc4kF2zj/FbR4lm6cbE/6B2oiYzUB3EmH40dKc1XaFQ
 pNMJfFSLbNU3VIiOXxGJTEbKJ40QyIF33SsvQ+OUNzGw8uBnOkfBxarf1VFc789TvNxCt3Ry4
 aB2SqhTBi6B6lN/kLERXs574aXjw64ncCu6jQj21RyFT4a8VAiFnzbUKrzYg5VzU+jpfrf8/e
 E+1Ev/jBZz2L6vhN3HY7VBGo0jXs+LdfFP3K3SYdUwKX4+QcIyIC9l7WxLIfK2JDgqgz3QIwN
 rBwZQ9MmJZQOXIMs2EgK8OQV5ZY47BwaOphwN17TSxl1YVCx8nTUovMEfkPCbVrNNMfkJVmW1
 F012IMFeK2fO903f95A9mm3FbVwWac7TeZvr6aUxXy940WE0fJ4lz56gjlt38aM5xbpcPuo/j
 bJtIO7S0hLcuVDgE+QLFmNBC1byafbyLrbillHX1IP9xDN9FwOAJ3D6O+IorCJ6DeyREr/eFZ
 nWVV5rJyqNzXI/OVisHNDW28sCvGgswR6qEOLrqwxAJbwlE2KlNLswlFYiDnTUD0ujppMZFsn
 kHaw8phcKDebgJW2HT+uwyWqQnSNPWseaYFuudP2FIxBYBXu6Q6qMQBGdy/PNdGq7SUIGNNqr
 YD9F2N8JfPaFQVCluBqRrJ/9hLDbpNep+cUHwUAPGOlbNOO3mMB9mE17ez6kjhMDoy6EAMVqa
 7DYMWx8fCdotoTyzb82woUBGdL0JnkdPgV+QizJzABqALi/mWdFT3+jipwCatbk4LjN0ByHxH
 3taIsAVKV0Dg5EqJbhdouRTVXWty58PrL5InyC7phv1mqGvoOjBGe+k1dJK9d1qVdYLMmfks5
 1J2eMZaEMOU9yIaD83Nk4n8ltGZD1VJQ2YIPAUq3+qLzI1daNSCFdSgKcePiVb3tYVZHaYrGv
 NPGdxKXLJc8APHUt9ACs7sVnXQ0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WMI chardev API will be removed in the near future.
Reimplement the necessary bits used by this driver so
that userspace software depending on it does no break.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-smbios-wmi.c | 163 ++++++++++++++------
 1 file changed, 117 insertions(+), 46 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platfor=
m/x86/dell/dell-smbios-wmi.c
index 931cc50136de..61f40f462eca 100644
=2D-- a/drivers/platform/x86/dell/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
@@ -7,11 +7,14 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

 #include <linux/dmi.h>
+#include <linux/fs.h>
 #include <linux/list.h>
+#include <linux/miscdevice.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/uaccess.h>
 #include <linux/wmi.h>
+#include <uapi/linux/wmi.h>
 #include "dell-smbios.h"
 #include "dell-wmi-descriptor.h"

@@ -32,7 +35,9 @@ struct wmi_smbios_priv {
 	struct list_head list;
 	struct wmi_device *wdev;
 	struct device *child;
-	u32 req_buf_size;
+	u64 req_buf_size;
+	u32 hotfix;
+	struct miscdevice char_dev;
 };
 static LIST_HEAD(wmi_list);

@@ -108,48 +113,106 @@ static int dell_smbios_wmi_call(struct calling_inte=
rface_buffer *buffer)
 	return ret;
 }

-static long dell_smbios_wmi_filter(struct wmi_device *wdev, unsigned int =
cmd,
-				   struct wmi_ioctl_buffer *arg)
+static int dell_smbios_wmi_open(struct inode *inode, struct file *filp)
 {
 	struct wmi_smbios_priv *priv;
-	int ret =3D 0;
-
-	switch (cmd) {
-	case DELL_WMI_SMBIOS_CMD:
-		mutex_lock(&call_mutex);
-		priv =3D dev_get_drvdata(&wdev->dev);
-		if (!priv) {
-			ret =3D -ENODEV;
-			goto fail_smbios_cmd;
-		}
-		memcpy(priv->buf, arg, priv->req_buf_size);
-		if (dell_smbios_call_filter(&wdev->dev, &priv->buf->std)) {
-			dev_err(&wdev->dev, "Invalid call %d/%d:%8x\n",
-				priv->buf->std.cmd_class,
-				priv->buf->std.cmd_select,
-				priv->buf->std.input[0]);
-			ret =3D -EFAULT;
-			goto fail_smbios_cmd;
-		}
-		ret =3D run_smbios_call(priv->wdev);
-		if (ret)
-			goto fail_smbios_cmd;
-		memcpy(arg, priv->buf, priv->req_buf_size);
-fail_smbios_cmd:
-		mutex_unlock(&call_mutex);
-		break;
-	default:
-		ret =3D -ENOIOCTLCMD;
+
+	priv =3D container_of(filp->private_data, struct wmi_smbios_priv, char_d=
ev);
+	filp->private_data =3D priv;
+
+	return nonseekable_open(inode, filp);
+}
+
+static ssize_t dell_smbios_wmi_read(struct file *filp, char __user *buffe=
r, size_t length,
+				    loff_t *offset)
+{
+	struct wmi_smbios_priv *priv =3D filp->private_data;
+
+	return simple_read_from_buffer(buffer, length, offset, &priv->req_buf_si=
ze,
+				       sizeof(priv->req_buf_size));
+}
+
+static long dell_smbios_wmi_do_ioctl(struct wmi_smbios_priv *priv,
+				     struct dell_wmi_smbios_buffer __user *arg)
+{
+	long ret;
+
+	if (get_user(priv->buf->length, &arg->length))
+		return -EFAULT;
+
+	if (priv->buf->length < priv->req_buf_size)
+		return -EINVAL;
+
+	/* if it's too big, warn, driver will only use what is needed */
+	if (priv->buf->length > priv->req_buf_size)
+		dev_err(&priv->wdev->dev, "Buffer %llu is bigger than required %llu\n",
+			priv->buf->length, priv->req_buf_size);
+
+	if (copy_from_user(priv->buf, arg, priv->req_buf_size))
+		return -EFAULT;
+
+	if (dell_smbios_call_filter(&priv->wdev->dev, &priv->buf->std)) {
+		dev_err(&priv->wdev->dev, "Invalid call %d/%d:%8x\n",
+			priv->buf->std.cmd_class,
+			priv->buf->std.cmd_select,
+			priv->buf->std.input[0]);
+
+		return -EINVAL;
 	}
+
+	ret =3D run_smbios_call(priv->wdev);
+	if (ret)
+		return ret;
+
+	if (copy_to_user(arg, priv->buf, priv->req_buf_size))
+		return -EFAULT;
+
+	return 0;
+}
+
+static long dell_smbios_wmi_ioctl(struct file *filp, unsigned int cmd, un=
signed long arg)
+{
+	struct dell_wmi_smbios_buffer __user *input =3D (struct dell_wmi_smbios_=
buffer __user *)arg;
+	struct wmi_smbios_priv *priv =3D filp->private_data;
+	long ret;
+
+	if (cmd !=3D DELL_WMI_SMBIOS_CMD)
+		return -ENOIOCTLCMD;
+
+	mutex_lock(&call_mutex);
+	ret =3D dell_smbios_wmi_do_ioctl(priv, input);
+	mutex_unlock(&call_mutex);
+
 	return ret;
 }

+static const struct file_operations dell_smbios_wmi_fops =3D {
+	.owner		=3D THIS_MODULE,
+	.open		=3D dell_smbios_wmi_open,
+	.read		=3D dell_smbios_wmi_read,
+	.unlocked_ioctl	=3D dell_smbios_wmi_ioctl,
+	.compat_ioctl	=3D compat_ptr_ioctl,
+};
+
+static int dell_smbios_wmi_register_chardev(struct wmi_smbios_priv *priv)
+{
+	priv->char_dev.minor =3D MISC_DYNAMIC_MINOR;
+	priv->char_dev.name =3D "wmi/dell-smbios";
+	priv->char_dev.fops =3D &dell_smbios_wmi_fops;
+	priv->char_dev.mode =3D 0444;
+
+	return misc_register(&priv->char_dev);
+}
+
+static void dell_smbios_wmi_unregister_chardev(struct wmi_smbios_priv *pr=
iv)
+{
+	misc_deregister(&priv->char_dev);
+}
+
 static int dell_smbios_wmi_probe(struct wmi_device *wdev, const void *con=
text)
 {
-	struct wmi_driver *wdriver =3D
-		container_of(wdev->dev.driver, struct wmi_driver, driver);
 	struct wmi_smbios_priv *priv;
-	u32 hotfix;
+	u32 buffer_size;
 	int count;
 	int ret;

@@ -162,39 +225,44 @@ static int dell_smbios_wmi_probe(struct wmi_device *=
wdev, const void *context)
 	if (!priv)
 		return -ENOMEM;

+	priv->wdev =3D wdev;
+	dev_set_drvdata(&wdev->dev, priv);
+
 	/* WMI buffer size will be either 4k or 32k depending on machine */
-	if (!dell_wmi_get_size(&priv->req_buf_size))
+	if (!dell_wmi_get_size(&buffer_size))
 		return -EPROBE_DEFER;

+	priv->req_buf_size =3D buffer_size;
+
 	/* some SMBIOS calls fail unless BIOS contains hotfix */
-	if (!dell_wmi_get_hotfix(&hotfix))
+	if (!dell_wmi_get_hotfix(&priv->hotfix))
 		return -EPROBE_DEFER;
-	if (!hotfix) {
+
+	if (!priv->hotfix)
 		dev_warn(&wdev->dev,
 			"WMI SMBIOS userspace interface not supported(%u), try upgrading to a =
newer BIOS\n",
-			hotfix);
-		wdriver->filter_callback =3D NULL;
-	}
+			priv->hotfix);

 	/* add in the length object we will use internally with ioctl */
 	priv->req_buf_size +=3D sizeof(u64);
-	ret =3D set_required_buffer_size(wdev, priv->req_buf_size);
-	if (ret)
-		return ret;

 	count =3D get_order(priv->req_buf_size);
 	priv->buf =3D (void *)__get_free_pages(GFP_KERNEL, count);
 	if (!priv->buf)
 		return -ENOMEM;

+	if (priv->hotfix) {
+		ret =3D dell_smbios_wmi_register_chardev(priv);
+		if (ret)
+			goto fail_chardev;
+	}
+
 	/* ID is used by dell-smbios to set priority of drivers */
 	wdev->dev.id =3D 1;
 	ret =3D dell_smbios_register_device(&wdev->dev, &dell_smbios_wmi_call);
 	if (ret)
 		goto fail_register;

-	priv->wdev =3D wdev;
-	dev_set_drvdata(&wdev->dev, priv);
 	mutex_lock(&list_mutex);
 	list_add_tail(&priv->list, &wmi_list);
 	mutex_unlock(&list_mutex);
@@ -202,6 +270,9 @@ static int dell_smbios_wmi_probe(struct wmi_device *wd=
ev, const void *context)
 	return 0;

 fail_register:
+	if (priv->hotfix)
+		dell_smbios_wmi_unregister_chardev(priv);
+fail_chardev:
 	free_pages((unsigned long)priv->buf, count);
 	return ret;
 }
@@ -211,6 +282,7 @@ static void dell_smbios_wmi_remove(struct wmi_device *=
wdev)
 	struct wmi_smbios_priv *priv =3D dev_get_drvdata(&wdev->dev);
 	int count;

+	dell_smbios_wmi_unregister_chardev(priv);
 	mutex_lock(&call_mutex);
 	mutex_lock(&list_mutex);
 	list_del(&priv->list);
@@ -256,7 +328,6 @@ static struct wmi_driver dell_smbios_wmi_driver =3D {
 	.probe =3D dell_smbios_wmi_probe,
 	.remove =3D dell_smbios_wmi_remove,
 	.id_table =3D dell_smbios_wmi_id_table,
-	.filter_callback =3D dell_smbios_wmi_filter,
 };

 int init_dell_smbios_wmi(void)
=2D-
2.39.2

