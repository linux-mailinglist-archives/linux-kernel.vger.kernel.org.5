Return-Path: <linux-kernel+bounces-15908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04B482358D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7631F24F87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712C71CF89;
	Wed,  3 Jan 2024 19:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="EYAcQcz6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082AA1CA9F;
	Wed,  3 Jan 2024 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1704310051; x=1704914851; i=w_armin@gmx.de;
	bh=mIHX7j8fEUd+Bx6DEm5FMjslE50yqHiQ75c9lG7NPSc=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=EYAcQcz68YHbGTvNWR0jkLo0zxNjzOR1Dojd1mo7u9HsuAUbZY+ychRQzSKdnvF8
	 L1eCy//+OCMiduw54zwJXodrMMe9JSmjLy1DMgwv/IcSldCJXlhGWHa3rFjw9IUEL
	 KyeZdVYf4g9fwsyo7CQei+BYtWw2/8lBwA4pMXdAqboPIL3E4t6QrM3zGelr1e1SI
	 2stQ17cNUT21N2/hk/mPAgol8Ish4f5ru9dkbF/QhH9dykwPDk0u7GLp//egbfPt7
	 HXgBovDlNUQuxzZRVu59uTuwQnC1CLAbfu6rXBm3uICrf7Umovp0/wbh/GfgEg7wc
	 GIp4nx+ThnjvgFkSAw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M3DO3-1rLwFT45PB-003eUr; Wed, 03 Jan 2024 20:27:31 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: wmi: Fix notify callback locking
Date: Wed,  3 Jan 2024 20:27:07 +0100
Message-Id: <20240103192707.115512-5-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240103192707.115512-1-W_Armin@gmx.de>
References: <20240103192707.115512-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ezw9sfKGvnBuc/nJwB1N5aPeICUYOeqsx2POT4RLIZN1+qslB+o
 EoZMjnTrOknTA5R66AUypebL1gB0RlYq8ErFAu5C5G+wDC32hVWrP5131mSwgWciHfQQ2SZ
 5odyMguMYQrYqRj1ZjhnSYL6vu6Yl7Nk0WftTZQOWj0vlqC1DOFqFK9yz8JdkTJuX9v4e97
 5r/TmF8RKDnK76i0xitMQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YsK1EHBHo34=;1OmhmvCDOjzZ/OQ/bkuQMBsWwip
 1Q6mcoSJLP9URaISfHpYiWL0m1/PdXhLnRDYS93CTmtkWO/dO5oSen7dLLBS3nL4/8Hy2kkBr
 2us0QNh/Ie8TWyF/PZg8zPteFVJ9F1o8mC0VB2YZVvAnpgU5LEDAwgLok4C3aUZkbmceiLdYj
 xbDVSODKpC0RVUCy811WKMobHHIMek6EpCtqOFKUZYLqG0fJ3ivG0oUw1+kLTWl72tR8gMfWw
 P5042PuE72ONWdOz8OQ+z+acpR/UUCLgfazzLFTsByd3H6zMG1vgs0Ak7NWZezFpocB0XYwwY
 2Stt54ellOJ45DnbOb6aTJI+36tHUkXxgd/Zsy7hiCJfu/COWpQOe8CKYre0l4pSnEiepU75U
 Z+CILvqu3jo6tPBMO3NHK8bwPr/7eq1pSQgdOKUMbJjaAZvXa/klTG2ht6XyoJ9f34UMM8t1p
 qmL5KRlDBmLLOQ99EvNJ3HxS5e5yL84VgiDQh8hSll+C3lnvBJaIrbqPlQmkB4g5sMVYC8NoI
 7VflSP2gEAGtQMxtqNIyaPRrg9/z+djYOpL276lxcffKWCQ3H5MmHbI2ZOOAKBMXP4zK/m6De
 ANF0z70XSmgA1HAynm6KFnN5rz00VtYrZK+DanFTi9IPoKXwFDXgfuYAEcDXYjHfTRm1N5TTk
 5D10Ai8/Y2mJA/LzUZt8RVxMAYxp6ygjnWHW7Q5TNrTw3Bo3ES48r6b/h5oRyoL5A/QiUDz6t
 NAx+BPt0AP7GjuncxPFIGRXjSMnwVQgO0VAnG3DYHInErqBB3o8cRotDxyz9IQ+Fc/JpK1lAY
 GNEWYzO3f0XIYKEWnXvAAprej5ZYEkWaorMPO5Mt/vSlR0AzjDgIw03vBuJFDKYVHmwD5tZw/
 Zz0hNwP0oQNR4KZ1ioJMC7l6RL3+xT5PFqZZ2HjHABeqXulwkOoWuQdVHvWq7YZMj9hycBkv5
 FUp8H+dtmqzNhWFlkNT9A5rr2ls=

When an legacy WMI event handler is removed, an WMI event could
have called the handler just before it was removed, meaning the
handler could still be running after wmi_remove_notify_handler()
returns.
Something similar could also happens when using the WMI bus, as
the WMI core might still call the notify() callback from an WMI
driver even if its remove() callback was just called.

Fix this by introducing a rw semaphore which ensures that the
event state of a WMI device does not change while the WMI core
is handling an event for it.

Tested on a Dell Inspiron 3505 and a Acer Aspire E1-731.

Fixes: 1686f5444546 ("platform/x86: wmi: Incorporate acpi_install_notify_h=
andler")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 71 +++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 6a886635689a..1aa097d34690 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -25,6 +25,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/rwsem.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -56,7 +57,6 @@ static_assert(__alignof__(struct guid_block) =3D=3D 1);

 enum {	/* wmi_block flags */
 	WMI_READ_TAKES_NO_ARGS,
-	WMI_PROBED,
 };

 struct wmi_block {
@@ -64,8 +64,10 @@ struct wmi_block {
 	struct list_head list;
 	struct guid_block gblock;
 	struct acpi_device *acpi_device;
+	struct rw_semaphore notify_lock;	/* Protects notify callback add/remove =
*/
 	wmi_notify_handler handler;
 	void *handler_data;
+	bool driver_ready;
 	unsigned long flags;
 };

@@ -602,6 +604,8 @@ acpi_status wmi_install_notify_handler(const char *gui=
d,
 		return AE_ERROR;

 	wblock =3D container_of(wdev, struct wmi_block, dev);
+
+	down_write(&wblock->notify_lock);
 	if (wblock->handler) {
 		status =3D AE_ALREADY_ACQUIRED;
 	} else {
@@ -613,6 +617,7 @@ acpi_status wmi_install_notify_handler(const char *gui=
d,

 		status =3D AE_OK;
 	}
+	up_write(&wblock->notify_lock);

 	wmi_device_put(wdev);

@@ -639,6 +644,8 @@ acpi_status wmi_remove_notify_handler(const char *guid=
)
 		return AE_ERROR;

 	wblock =3D container_of(wdev, struct wmi_block, dev);
+
+	down_write(&wblock->notify_lock);
 	if (!wblock->handler) {
 		status =3D AE_NULL_ENTRY;
 	} else {
@@ -650,6 +657,7 @@ acpi_status wmi_remove_notify_handler(const char *guid=
)

 		status =3D AE_OK;
 	}
+	up_write(&wblock->notify_lock);

 	wmi_device_put(wdev);

@@ -895,7 +903,9 @@ static int wmi_dev_probe(struct device *dev)
 		}
 	}

-	set_bit(WMI_PROBED, &wblock->flags);
+	down_write(&wblock->notify_lock);
+	wblock->driver_ready =3D true;
+	up_write(&wblock->notify_lock);

 	return 0;
 }
@@ -905,7 +915,9 @@ static void wmi_dev_remove(struct device *dev)
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
 	struct wmi_driver *wdriver =3D drv_to_wdrv(dev->driver);

-	clear_bit(WMI_PROBED, &wblock->flags);
+	down_write(&wblock->notify_lock);
+	wblock->driver_ready =3D false;
+	up_write(&wblock->notify_lock);

 	if (wdriver->remove)
 		wdriver->remove(dev_to_wdev(dev));
@@ -1018,6 +1030,8 @@ static int wmi_create_device(struct device *wmi_bus_=
dev,
 		wblock->dev.setable =3D true;

  out_init:
+	init_rwsem(&wblock->notify_lock);
+	wblock->driver_ready =3D false;
 	wblock->dev.dev.bus =3D &wmi_bus_type;
 	wblock->dev.dev.parent =3D wmi_bus_dev;

@@ -1190,6 +1204,26 @@ acpi_wmi_ec_space_handler(u32 function, acpi_physic=
al_address address,
 	}
 }

+static void wmi_notify_driver(struct wmi_block *wblock)
+{
+	struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
+	struct acpi_buffer data =3D { ACPI_ALLOCATE_BUFFER, NULL };
+	acpi_status status;
+
+	if (!driver->no_notify_data) {
+		status =3D get_event_data(wblock, &data);
+		if (ACPI_FAILURE(status)) {
+			dev_warn(&wblock->dev.dev, "Failed to get event data\n");
+			return;
+		}
+	}
+
+	if (driver->notify)
+		driver->notify(&wblock->dev, data.pointer);
+
+	kfree(data.pointer);
+}
+
 static int wmi_notify_device(struct device *dev, void *data)
 {
 	struct wmi_block *wblock =3D dev_to_wblock(dev);
@@ -1198,28 +1232,17 @@ static int wmi_notify_device(struct device *dev, v=
oid *data)
 	if (!(wblock->gblock.flags & ACPI_WMI_EVENT && wblock->gblock.notify_id =
=3D=3D *event))
 		return 0;

-	/* If a driver is bound, then notify the driver. */
-	if (test_bit(WMI_PROBED, &wblock->flags) && wblock->dev.dev.driver) {
-		struct wmi_driver *driver =3D drv_to_wdrv(wblock->dev.dev.driver);
-		struct acpi_buffer evdata =3D { ACPI_ALLOCATE_BUFFER, NULL };
-		acpi_status status;
-
-		if (!driver->no_notify_data) {
-			status =3D get_event_data(wblock, &evdata);
-			if (ACPI_FAILURE(status)) {
-				dev_warn(&wblock->dev.dev, "failed to get event data\n");
-				return -EIO;
-			}
-		}
-
-		if (driver->notify)
-			driver->notify(&wblock->dev, evdata.pointer);
-
-		kfree(evdata.pointer);
-	} else if (wblock->handler) {
-		/* Legacy handler */
-		wblock->handler(*event, wblock->handler_data);
+	down_read(&wblock->notify_lock);
+	/* The WMI driver notify handler conflicts with the legacy WMI handler.
+	 * Because of this the WMI driver notify handler takes precedence.
+	 */
+	if (wblock->dev.dev.driver && wblock->driver_ready) {
+		wmi_notify_driver(wblock);
+	} else {
+		if (wblock->handler)
+			wblock->handler(*event, wblock->handler_data);
 	}
+	up_read(&wblock->notify_lock);

 	acpi_bus_generate_netlink_event(wblock->acpi_device->pnp.device_class,
 					dev_name(&wblock->dev.dev), *event, 0);
=2D-
2.39.2


