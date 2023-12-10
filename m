Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3FC80BCFA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 21:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjLJUZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 15:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjLJUZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 15:25:02 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4005CD8;
        Sun, 10 Dec 2023 12:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1702239895; x=1702844695; i=w_armin@gmx.de;
        bh=FXptV17hEQfrk/SdFKWK5/BHx6pY5MLIQJDt8cM6pCk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=N+smmKKyhXs3UJovrNIdjaQjGUWRB5Ai1g8B+CxwvZ79mvlaKjuiozhtep615gVW
         TY53yvlGRFW9DW2hYtC3wHFIMYUVm09Ldr9shdIF6pHyT1ICjyv1g8IXrM8nsE1hv
         bIHkoIGW2+jmEsICzJXcIEbZpRggweRkJ5D33LaQ5BDZ96GND2xoQ4uoC4JWznQ5h
         Mb66Vd36AOda5hlNZ/OGtLTycQyUpgsTmY60Ja/9zPGzohV4BjLxEHQGiTmmuyHcm
         Oe0iq23mwfVWd2qhQWJFDsLSNMXUgfB6s8X5Sz9rCqHfnhWI0TR2A8+dIjmMRoBp8
         Jl1T51Hd8gWE8IcK6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MmDEg-1rczgN1JtA-00iFNB; Sun, 10 Dec 2023 21:24:55 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, corbet@lwn.net
Cc:     Dell.Client.Kernel@dell.com, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] platform/x86: dell-smbios-wmi: Stop using WMI chardev
Date:   Sun, 10 Dec 2023 21:24:42 +0100
Message-Id: <20231210202443.646427-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231210202443.646427-1-W_Armin@gmx.de>
References: <20231210202443.646427-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XC4EOXkjV5iFFakqAqxeHDjqFAxWM4zLLG2pWJIWJy25P26olbU
 fpESgLJr3zjXRCrQ9EmXnFDZwHxPSZSwncbwokHtSf/3wghUOUSJYT5Sxz5uLUGRyKS1cca
 QPgpFpgyrS6P0/HOvjOKKBLaPShT5LirHpcPm8560TAbzSCBorh75AuHG5M2W4DB2HnioyJ
 q+ivM4vJ9VSczV7q8J0bQ==
UI-OutboundReport: notjunk:1;M01:P0:HfBKhUUs1wM=;VYVakxdyaAU789AdpI6gSnAVQJ1
 scl/R93vdpv4HbrPpMPuwioSUkkoj31XcDfiJdqK8tFY1O086u7wtCFRYq5/r74yfr0OWerXT
 LcCEysf7TKj4tiiDoBoStiqnPYkvyBGz5Wy4Ah84sJRA2h5DL5MFsEiBsKE6JaCpx1ETae8LZ
 BgBg1obqrTA4f6Lu1qKoyFGy2Ty7mLpRjIM9ttIcrufApaO6RLbiyvLDUEMdtu1LK3ZFMjSsH
 77ndDQ2D2dD2SORxZRGYzIioFH+n4uadi/ekoGNhQEkjz1w7vJ/WrsMbeGIBg4bcNT6Zh16lp
 s1RPRGWva1tbapaDDiegP88YU41nZkqB2ErEn2bLvgsHIX64Fpt74wlQDLJ+yiIcsokSkCy1B
 0Uch8soz+Kqf/LOT46Snb/pJkEC2xQ21ipXXUSPufI9XRU3gY/F6eg9FefAhuokPX/zh6vR52
 tsvazQNX0OVlm4D9S7tWs2uXIvubxOx/n8hqANmyV+OS5H2ACs4ZV1CuTLneaCLdfRp+w9EOz
 xVlb/ckMchhvhWnxlS37Jan/KbgpvFbc0GjgAeYqXdhJkFGrKU6pAYZ9388cCEGPQWX/mpYRk
 D5m0hGkmewJPh1BfPsAygVVBde1U/yDRKWCR2sQCX1i0aW11/U3JCeLoa177yAtYoLpRys2uy
 ZFXbTS8asKO1K3pu7j2UM7FM2FTVwo6FIlqir71NQLqj/NBR10gMJOGDVhDEdfLInS1ZoxYFB
 BUEbsCDgvGkWysxalItxcMn9Gcc2nSORFQ4IcxFTUT8p1w+lfJ/y3K9y6BPRqjeDm1QCDGX7k
 As2fxD/p4AHrzzvZGNecsq8R9eDq4Sf2ye8d44x9Syk7nCU8+wjmm031Fe8GR+L3jdkhpuKQ6
 scyNItjunrQY88uOftF9LA7vNbMToirHp3ULX5bvpniqmJ2T/FYAMCq6XoBvNx/yYtoYb1MFL
 kMUMemk3kXfp2/CgoCL9mATrKjQ=
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
 drivers/platform/x86/dell/dell-smbios-wmi.c | 161 ++++++++++++++------
 1 file changed, 117 insertions(+), 44 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-wmi.c b/drivers/platfor=
m/x86/dell/dell-smbios-wmi.c
index 7eb7c61bb27d..ae9012549560 100644
=2D-- a/drivers/platform/x86/dell/dell-smbios-wmi.c
+++ b/drivers/platform/x86/dell/dell-smbios-wmi.c
@@ -8,11 +8,14 @@

 #include <linux/device.h>
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

@@ -33,7 +36,8 @@ struct wmi_smbios_priv {
 	struct list_head list;
 	struct wmi_device *wdev;
 	struct device *child;
-	u32 req_buf_size;
+	u64 req_buf_size;
+	struct miscdevice char_dev;
 };
 static LIST_HEAD(wmi_list);

@@ -109,48 +113,115 @@ static int dell_smbios_wmi_call(struct calling_inte=
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
+static void dell_smbios_wmi_unregister_chardev(void *data)
+{
+	struct miscdevice *char_dev =3D data;
+
+	misc_deregister(char_dev);
+}
+
+static int dell_smbios_wmi_register_chardev(struct wmi_smbios_priv *priv)
+{
+	int ret;
+
+	priv->char_dev.minor =3D MISC_DYNAMIC_MINOR;
+	priv->char_dev.name =3D "wmi/dell-smbios";
+	priv->char_dev.fops =3D &dell_smbios_wmi_fops;
+	priv->char_dev.mode =3D 0444;
+
+	ret =3D misc_register(&priv->char_dev);
+	if (ret < 0)
+		return ret;
+
+	return devm_add_action_or_reset(&priv->wdev->dev, dell_smbios_wmi_unregi=
ster_chardev,
+					&priv->char_dev);
+}
+
 static int dell_smbios_wmi_probe(struct wmi_device *wdev, const void *con=
text)
 {
-	struct wmi_driver *wdriver =3D
-		container_of(wdev->dev.driver, struct wmi_driver, driver);
 	struct wmi_smbios_priv *priv;
-	u32 hotfix;
+	u32 buffer_size, hotfix;
 	int count;
 	int ret;

@@ -163,39 +234,42 @@ static int dell_smbios_wmi_probe(struct wmi_device *=
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
 	if (!dell_wmi_get_hotfix(&hotfix))
 		return -EPROBE_DEFER;
-	if (!hotfix) {
+
+	if (!hotfix)
 		dev_warn(&wdev->dev,
 			"WMI SMBIOS userspace interface not supported(%u), try upgrading to a =
newer BIOS\n",
 			hotfix);
-		wdriver->filter_callback =3D NULL;
-	}

 	/* add in the length object we will use internally with ioctl */
 	priv->req_buf_size +=3D sizeof(u64);
-	ret =3D set_required_buffer_size(wdev, priv->req_buf_size);
-	if (ret)
-		return ret;

 	count =3D get_order(priv->req_buf_size);
 	priv->buf =3D (void *)devm_get_free_pages(&wdev->dev, GFP_KERNEL, count)=
;
 	if (!priv->buf)
 		return -ENOMEM;

+	ret =3D dell_smbios_wmi_register_chardev(priv);
+	if (ret)
+		return ret;
+
 	/* ID is used by dell-smbios to set priority of drivers */
 	wdev->dev.id =3D 1;
 	ret =3D dell_smbios_register_device(&wdev->dev, &dell_smbios_wmi_call);
 	if (ret)
 		return ret;

-	priv->wdev =3D wdev;
-	dev_set_drvdata(&wdev->dev, priv);
 	mutex_lock(&list_mutex);
 	list_add_tail(&priv->list, &wmi_list);
 	mutex_unlock(&list_mutex);
@@ -250,7 +324,6 @@ static struct wmi_driver dell_smbios_wmi_driver =3D {
 	.probe =3D dell_smbios_wmi_probe,
 	.remove =3D dell_smbios_wmi_remove,
 	.id_table =3D dell_smbios_wmi_id_table,
-	.filter_callback =3D dell_smbios_wmi_filter,
 };

 int init_dell_smbios_wmi(void)
=2D-
2.39.2

