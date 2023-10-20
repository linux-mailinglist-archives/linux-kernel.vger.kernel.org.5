Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218947D17DA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjJTVKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjJTVK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:10:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2C2D65;
        Fri, 20 Oct 2023 14:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1697836214; x=1698441014; i=w_armin@gmx.de;
        bh=x1THz+UVadBgvASSd3DL2MDkUZ8jlzu8RvUsxEiUFV8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
         References;
        b=n8QzveMImcNnHcqodKE/XJLMhtQN8Ex15sLt14wVH0IFbseGCi8drMBvhSabVOmV
         KDjGPqnlwKYcBwjDw6x0YU6Bc5xWJzvMxbWAU+4IyNAXT98pjo8MIx6UBRAJhSZ3O
         Y6tg1NyXEE5HBvxZKlvU3uBb084WQj7ttmRFvidDCqokNyO23z2nlGbPf9/wZ5HEl
         jrCie7oM+KJ7O1QUPZaO1Kbppp6PDg/7Ebep3MDXCNg3pjOG/IbLzlZeQgVeNQ9+C
         sxI1Nw+T7wHFC8fHmrpCVIllkByko0CtzFrvch/lpx5dY9GtUNFwwwDKZTd5Uejcm
         JfUNgczlZ+prsFp64A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N4hzZ-1rcWig404F-011jbW; Fri, 20 Oct 2023 23:10:14 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] platform/x86: wmi: Fix opening of char device
Date:   Fri, 20 Oct 2023 23:10:04 +0200
Message-Id: <20231020211005.38216-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020211005.38216-1-W_Armin@gmx.de>
References: <20231020211005.38216-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E8bKXzrd7tJH35+RfczawE7+cx7xJspEAesMdRP4NLE93ueV3LO
 ySNdVqap2OFF+MpWW02dwhCsMLbd5OB88956XLkUVW8gVmYGBXa7RymkCuS6PcSrrnpwOvN
 rYXUDkL2qKgrEE4dR6LJ5lhvvtvOZPNRIkkw+6eQRZwMa/lr5YutFVbQ5IDNB6S975yNILe
 JK3fzaKrNW68LFoKX8ZYQ==
UI-OutboundReport: notjunk:1;M01:P0:WMWOP31tJm4=;cDbpF9TxXrOlFEY3HGfLd8VH1h8
 Q3hoq44eRaygm3VdWU6MPXWksyExzdrIzTkQpcYdOilRgTn3IfVx/XHO2poPXqW8ajwOg8+Pu
 qg++H2LKv1z/oDwG969U1vNYHfC4YvYGEgeHmFizdntJLaGgbBuXGTfGjcMzPZORM3fLV29jk
 ZBRvVFgBXAUerJ6iYSBekSL9EoKXG3gVI3sQ84EbXlvKn1u7AVjWzxLERL1R6UvtVimr8d1fc
 T5My08CfLq7u2SzW5zI2tqqhNmrr5V3SzGvQaHXVFerWh65CrXsiygCBgTHQpuA9xmHxDCrOh
 YmqjNHM/GSArbz+QrtVw367UzUZ7ZmXcm6zVyrqtrMvoGnBzoD4qNfG4+oBDIgBra32tM8vIi
 B50Urts/tvaA5/TMaQAPEYS28ANle1njUu6yOg4K7+1j0oAhlAk1p8kXj9iCw/D0TLXrg2UFt
 hRXzoLTVNPq9hc4diaGGhyAJLwIkX66UwFWLralmuevPNkZWSVcR0yPrjfutNzC5+AStB9hXd
 vsVm4j7+9tIW3LGbVguBtGAtn9vPyrrce7jCK+M+MEHkCn4wTeLxQMFr1S4TnOx1Vrdow2pY1
 vEJwULYObcj17wfeAS0uFw0BrROVJQdjOmiiI9BWdj+2NyHC3GSPM+PojnxGe1ET/91zvzAam
 27SSfaDTsOmRNNMiqMC6V9IkdjHoNv876RsHVwofBMVBSOC0muEzRcVpZqLAKtMdb7E/uox3C
 KK5gq+VijDtFmzVpZfWnz45/DXH+xfBG+UX+uIvjPxuUO8SoLBz0uesaN6/V96fMVvG/9ZZZX
 qen6lrkNZuIATBg6E6t8fYLDg4jLgHLJ80yQhwPgUoYPqJmR1V/bj9dVoKERuLU5xXkCPMo5Z
 VU/oxBdqBg1+qiBjFr6lOSwVRST+qr8/+ErQ7amPc0MkN62mE5rI25QrM+vTO6Zugw5ZRHrgy
 uZr/q0cfLWBHrl0GnqKmlQcHtTg=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit fa1f68db6ca7 ("drivers: misc: pass miscdevice pointer via
file private data"), the miscdevice stores a pointer to itself inside
filp->private_data, which means that private_data will not be NULL when
wmi_char_open() is called. This might cause memory corruption should
wmi_char_open() be unable to find its driver, something which can happen
when the associated WMI device is deleted in wmi_free_devices().
Fix this by using the miscdevice pointer to retrieve the WMI device data
associated with a char device using container_of(). This also avoids
wmi_char_open() picking a wrong WMI device bound to a driver with the
same name as the original driver.

Fixes: 44b6b7661132 ("platform/x86: wmi: create userspace interface for dr=
ivers")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index ab24ea9ffc9a..6b3b2fe464d2 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -958,21 +958,13 @@ static int wmi_dev_match(struct device *dev, struct =
device_driver *driver)
 }
 static int wmi_char_open(struct inode *inode, struct file *filp)
 {
-	const char *driver_name =3D filp->f_path.dentry->d_iname;
-	struct wmi_block *wblock;
-	struct wmi_block *next;
-
-	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		if (!wblock->dev.dev.driver)
-			continue;
-		if (strcmp(driver_name, wblock->dev.dev.driver->name) =3D=3D 0) {
-			filp->private_data =3D wblock;
-			break;
-		}
-	}
+	/*
+	 * The miscdevice already stores a pointer to itself
+	 * inside filp->private_data
+	 */
+	struct wmi_block *wblock =3D container_of(filp->private_data, struct wmi=
_block, char_dev);

-	if (!filp->private_data)
-		return -ENODEV;
+	filp->private_data =3D wblock;

 	return nonseekable_open(inode, filp);
 }
=2D-
2.39.2

