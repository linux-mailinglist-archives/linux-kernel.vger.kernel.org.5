Return-Path: <linux-kernel+bounces-123704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A21890CF0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D136B237C3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8527B13BAC8;
	Thu, 28 Mar 2024 22:06:38 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCFA13B797;
	Thu, 28 Mar 2024 22:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711663598; cv=none; b=eXS09hxh77cOLxadU7/TF6k9IC28595pV5fMiOf7EXry/LwehSf1E9NZIuqxb2eaF4QI2TaKOpZqwq8AIYpMW2I7ZPzbALeP3cODTkg9rsr2VSCBgDn3ypSOIaM5tQvI0fesl7LZcRW7UUAoy71MivDKP0/4juGCLDVOx8KyAVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711663598; c=relaxed/simple;
	bh=zMTjyvCEvlFeTTRituomPy21UTqRPzPiKXunZu0j7qI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P+hZEmKyQb6X7juAN89FkKKrCAy831Rc6j+6GsXao0CrLvoScq/OTPEIlbX4fxofyNEKgpmwOxjGQK4Alje3MABG/sDNAGt/IZc2MW1L+bSvqVzuakyS/NYA1uuta+H88JvRcUUlQY6xrSuII8rXGzD9/14/eWvr7oTllg2MsAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A613C43390;
	Thu, 28 Mar 2024 22:06:35 +0000 (UTC)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 28 Mar 2024 23:05:39 +0100
Subject: [PATCH 01/52] USB: serial: store owner from modules with
 usb_serial_register_drivers()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-module-owner-usb-serial-v1-1-bc46c9ffbf56@linaro.org>
References: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
In-Reply-To: <20240328-module-owner-usb-serial-v1-0-bc46c9ffbf56@linaro.org>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3540;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=zMTjyvCEvlFeTTRituomPy21UTqRPzPiKXunZu0j7qI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmBem8ZjWaU0BWsrGTJJIOe8BTqy3yBqykUMje0
 6ctP4eLeh6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZgXpvAAKCRDBN2bmhouD
 1z47D/91NPYhquLrT3hprPgzvlrYZxLqq/QuKtBqz2iKJx42GL/QyK5LLiKkfXH6n4lVp4zQMYr
 RRbyB8ue0TzgbvTXEgcRYv7KQcNBB8duPJezGElWaz1VbOzAHW8Gk/St2LR0DH0YlaU7xHZNp16
 r1jFdYqgPcaBqb6KGili3yTXvl/q8D7t7AxS8qwHwCzd5kHrrcfep/0VqRJD5LkEgZDxAN/MTnb
 04d+KV89p7v88q/8BW3i+29d5e4pb5SS2y27fqk2CVyhncDGV2PIf3PV9/8F2YvpNaiFVK5MMjU
 Qt/LlGcqluabYBJikKYIrdjOgM+6zUiN9pNVsQl3Ia3dxAxnH/KVP1v0AfP9CBtmDvvuCqs/udZ
 EqoskQ1xBLlq+WZktr7QRz5iBW5Yva2f1Nb4lIHCHn+2eFWLXA9jmoFrJxlKjrFq9qqVuN5DvY7
 +bM70RhkAJ+k/qn8oQfngmViVXwWKENHfZFZAUVsJq9pW9nlMa9vKAgZoJmDEnJCWhcBPn9o2+l
 Xxwq8/rGicmG8VbA+CljdfB0KCMsAhhNDkSFD8vxxiw+opZQzzXJc77nFyaWo9ndZqrhKmveZHy
 ZNgVlIHj0rwracXYN2vUPfS/VCC2iTQ1Z/DuVgcFhI9D10ZES75tXoCNrB+8V9d3vfLUI+qZNNn
 hoGXz6/gb2LLr6w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Modules registering driver with usb_serial_register_drivers() might
forget to set .owner field.  The field is used by some of other kernel
parts for reference counting (try_module_get()), so it is expected that
drivers will set it.

Solve the problem by moving this task away from the drivers to the core
amba bus code, just like we did for platform_driver in
commit 9447057eaff8 ("platform_device: use a macro instead of
platform_driver_register").

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/usb/serial/usb-serial.c | 12 +++++++-----
 include/linux/usb/serial.h      |  7 +++++--
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f1e91eb7f8a4..a659f2096a1a 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1459,17 +1459,18 @@ static void usb_serial_deregister(struct usb_serial_driver *device)
 }
 
 /**
- * usb_serial_register_drivers - register drivers for a usb-serial module
+ * __usb_serial_register_drivers - register drivers for a usb-serial module
  * @serial_drivers: NULL-terminated array of pointers to drivers to be registered
+ * @owner: owning module/driver
  * @name: name of the usb_driver for this set of @serial_drivers
  * @id_table: list of all devices this @serial_drivers set binds to
  *
  * Registers all the drivers in the @serial_drivers array, and dynamically
  * creates a struct usb_driver with the name @name and id_table of @id_table.
  */
-int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[],
-				const char *name,
-				const struct usb_device_id *id_table)
+int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[],
+				  struct module *owner, const char *name,
+				  const struct usb_device_id *id_table)
 {
 	int rc;
 	struct usb_driver *udriver;
@@ -1514,6 +1515,7 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 
 	for (sd = serial_drivers; *sd; ++sd) {
 		(*sd)->usb_driver = udriver;
+		(*sd)->driver.owner = owner;
 		rc = usb_serial_register(*sd);
 		if (rc)
 			goto err_deregister_drivers;
@@ -1532,7 +1534,7 @@ int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[]
 	kfree(udriver);
 	return rc;
 }
-EXPORT_SYMBOL_GPL(usb_serial_register_drivers);
+EXPORT_SYMBOL_GPL(__usb_serial_register_drivers);
 
 /**
  * usb_serial_deregister_drivers - deregister drivers for a usb-serial module
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 1a0a4dc87980..75b2b763f1ba 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -311,8 +311,11 @@ struct usb_serial_driver {
 #define to_usb_serial_driver(d) \
 	container_of(d, struct usb_serial_driver, driver)
 
-int usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[],
-		const char *name, const struct usb_device_id *id_table);
+#define usb_serial_register_drivers(serial_drivers, name, id_table) \
+	__usb_serial_register_drivers(serial_drivers, THIS_MODULE, name, id_table)
+int __usb_serial_register_drivers(struct usb_serial_driver *const serial_drivers[],
+				  struct module *owner, const char *name,
+				  const struct usb_device_id *id_table);
 void usb_serial_deregister_drivers(struct usb_serial_driver *const serial_drivers[]);
 void usb_serial_port_softint(struct usb_serial_port *port);
 

-- 
2.34.1


