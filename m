Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756BA7BCA83
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 01:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344204AbjJGXkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 19:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344168AbjJGXkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 19:40:01 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35DA5BC;
        Sat,  7 Oct 2023 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696721988; x=1697326788; i=w_armin@gmx.de;
 bh=x1THz+UVadBgvASSd3DL2MDkUZ8jlzu8RvUsxEiUFV8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=rU1wAa3tVgT30N8/cR8PZLhZWEpjOfJbrBuNuhwUTGr+YfxqEGbEN+YxCqAsZDVd94MwA1GUMw3
 CbpJBBm6kUqecNafhKAYl0McvJvecS0YElXEbZN8AeUW6bIE+ynRxE/mZAtpg/6vdrvumk1schRDd
 T6nyDdcbJuEnAN8xrFjmarBHI17PEHiRa3O9mDjnfDoXVXyPRyoFoQRUf6feygtRm7TwDjn8xzjAj
 GYlgcAICnQyifet23I5E2CHj9chCLTiNcQOJKBz/L+9/7/KqAkkdyw4OdiHDbAO2z1GTgIkObwUcR
 Pakz6Jow12GV0gdvm6LzcMHI960v7aO1UlBA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MIx3I-1r9XqA1yxO-00KU5C; Sun, 08 Oct 2023 01:39:48 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] platform/x86: wmi: Fix opening of char device
Date:   Sun,  8 Oct 2023 01:39:32 +0200
Message-Id: <20231007233933.72121-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231007233933.72121-1-W_Armin@gmx.de>
References: <20231007233933.72121-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mOK/zZxrBq1zuij9wGiY+7APjMNgMMyQ07Txqx8cpnsGO6OYvYn
 mYROyP8H0cW/DJz4i8b8ovoVjiXgxeLe1RR0grNqslMdKcEzu6yVk9DSachTlA0L9Bd1MU5
 cOTXnC+TG1xXM+1iD6k9nL0kCfAbGiy6I6o55AmtA0WY8Z61SZNE5P/FuD+wmhZvK84X3b+
 4usD3ZVlvqhDvuXJDIasA==
UI-OutboundReport: notjunk:1;M01:P0:qdfl4deJgvc=;pZDGz6DqR3H/O/ZZWbkPaHrYWUq
 4cfteMYsbvM+NZLJwcCsWxCjo/o+RCP78D7FlFB6bjdCYz6tCABvmaFsxW2EvPwpmtXDSoVCw
 wZB8Z6z2FmCqBPxnSC+21bapGdgPIs+PvGTth5uGxOVeZRSdZdK+mbp40U+6cHCP4fguzjiMV
 tCadcHqKBUi5n4Zl9zQyZsvKw3bKYMeKwC1APEU0wV6PhVJtZA1BRYkvfObFOw6mL54pqCOUK
 QO73RkmsTSMLgv3b7hgFD4PIDONNNp2uoIbFxvKKPCGLWIIdeIWKASarWS/zsT0LXgs9XFV3c
 uLv8LGGYAu6rpGJKPSdmXzruT7KlPY8uoM3wZujLwUN4oKSBSLcljDLUFFJry95I/l0Jm02cy
 XU/Mok23ZsGxQ0GU1dEajkJEYx5w+qsvs6pjvoQ5KltjO7hw6RbG7Gr9DGZBripKBTOG2dm0e
 51P88KxL7fF2uy43QQZtV6FDgzeFWONOksrrIXJTsYs2Pn3SZbghvhihGkIIDSHB5QWvkNW53
 7/IUwVoI8dcrOiX4nH/b472cyhR08zDwhR6JfeWty/3qFAuuStTJzb2RNzjIcId69nk79KNI2
 ocA1UGEuIKdJ6InU5qDmSMwimGyncJiVM8wbdLo6blf4D1+LWoIFNAdhXxMgaq/iveOgPj0EH
 jxfhLNX07/VdTOm3VcNEJRocHjG9D2rUoaFULFBt0n9SXV21/PscWL69DI1cxih64K9IiYcJz
 iC5SWBfW5uFOXHphy5HmFUfXju5/UYF/c0rykg5ZhWGqhPyJeVpj6kXDYiibiXEAOYJzbP2hr
 YYcedjapxJigb7zks3/YSb7QfHClzae1mhNpTEH+G0eiuC2PHffBjzEdKQny+wkPYYTAfPDkz
 SqibBjj7YOLgcdnWLf1uQf//tNiseZrYLi6mCbl8bylq6VgpEXJI02T3dYq67kYkjiYufNd/b
 LXLL6M8V571ROLAjtEHrkFfAkPY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

