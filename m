Return-Path: <linux-kernel+bounces-75594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B215385EBB1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C337282AE0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2698A128826;
	Wed, 21 Feb 2024 22:14:56 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674561272CB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708553695; cv=none; b=cIN/EM3sCQK/nlj3jUaFXjy0hbMjcmnQM54q/odl5m6GmCIi0OYk9ZayB3pkR5Xc1gryt7DiMhleet56iH0Xw5YAmmVB+7GKJVEJ3z15qHK5ze33Z7yjWRlR0Uv5lAdKBxWseIla+1/gYazuaR++o6ybWhdp6ztYIG5hQQM08qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708553695; c=relaxed/simple;
	bh=1oQWrGTi5mMIcITVxCwIP8oSyvgMhztHKAB9MI/QJQw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=vBZiSm6MuES5yE8eHhgyq/7yHtlabHeGmQ3qApeB8OmjKY9PobeRp4AfyAriSqJ0IJRpokPmB8MyVcxfxNgsumwgsZyXahe5JfIVivBEvTGZL1YiCCaUz3EJ1+a+gbTzBfbuwG/BT9F/1xMahDIm1VTmAvqHHBVTxli0GhnVEhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rcurb-0000mo-5L; Wed, 21 Feb 2024 23:14:51 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rcura-0027Pf-LV; Wed, 21 Feb 2024 23:14:50 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rcura-009zC6-1y;
	Wed, 21 Feb 2024 23:14:50 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Wed, 21 Feb 2024 23:14:47 +0100
Subject: [PATCH] usb: gadget: uvc: configfs: ensure guid to be valid before
 set
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-uvc-gadget-configfs-guid-v1-1-f0678ca62ebb@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIANZ11mUC/x2NSwrDMAwFrxK0rsARaSC9SunCH9kRBKdYdSiE3
 L2iy3kwb05QbsIKj+GExoeo7NVgvA0QV18LoyRjIEeTIxqxHxGLT4U/GPeapWTF0iVhZrcs8z1
 MxDOYHrwyhuZrXO2g9m2z8d04y/ffe76u6weQaV7PfwAAAA==
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1946;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=1oQWrGTi5mMIcITVxCwIP8oSyvgMhztHKAB9MI/QJQw=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl1nXaTRuMVbRpksnsBjg2K/mAIwx5jTcQ8HJz4
 uij9BwZRteJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZdZ12gAKCRC/aVhE+XH0
 qwA3D/kBQru6J9nZI3jpOu0Dzw9QLaDU+Z2NYHrOrGCHURnmZfaXjvZ9Rtw9m5WOhU6zHCgrs+q
 8bZE2dc/dmoZt9rIQc0oSgb5GnR8qM+IBnqmL/XpfVopUuJlynS064zrYE2Swo6lsy/1xgQErPm
 PKSPVljBiRjuf7/WplZ945aDuvB3zLTkkC2kO4MeWYUZKlcuOf015gNkDRiCKQg8RXMUjABkg8u
 t+WetI3Zj7vkXnQn96m6ddDlUBKDOjNd6bSWwXHLf8dQFYlFEjwGSpjcEcyhUbm0zsBU1pmP78f
 8BhpXgmkoSq4bZZx/CDO+e9Vm1bLt/ricAsaFLG2FF0CXWR8W8lZdb5fse/h1NCWZhULUpU/o4R
 f6QCBEGSuALeTL7WNsMHp5CnyarNfXvgFl2Evvp2GC+jTtgALXyVGduAt6Xk0DN1xMRbGvEsiXl
 naehvFuOt6b4m4WvX+6+MonslpLiEooo2D0oz6TZO+tSTEu9ZeSOE+YzBOM1nuWyGjrSKhN42GZ
 Q1teNHvTqAsyDyd+rIvZyMk2pePEi/Xa2yW++Diw2Dr69JHwDAOaENTS4T2Waf1KSBqRbpkmiay
 XwySpYzBGreQ8j0z+GIq+L/55jU1baIBQYRydGmDUZ9/zU+lcP5MKeogwWa2tkMWc8dvlkf5g1t
 UtQV4jUpSs54osg==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

When setting the guid via configfs it is possible to test if
its value is one of the kernel supported ones by calling
uvc_format_by_guid on it. If the result is NULL, we know the
guid is unsupported and can be ignored.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/usb/gadget/function/uvc_configfs.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 7e704b2bcfd1c..6535e5948b2ef 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -13,6 +13,7 @@
 #include "uvc_configfs.h"
 
 #include <linux/sort.h>
+#include <linux/usb/uvc.h>
 #include <linux/usb/video.h>
 
 /* -----------------------------------------------------------------------------
@@ -2260,6 +2261,8 @@ static ssize_t uvcg_uncompressed_guid_format_store(struct config_item *item,
 	struct f_uvc_opts *opts;
 	struct config_item *opts_item;
 	struct mutex *su_mutex = &ch->fmt.group.cg_subsys->su_mutex;
+	const struct uvc_format_desc *format;
+	u8 tmpguidFormat[sizeof(ch->desc.guidFormat)];
 	int ret;
 
 	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
@@ -2273,7 +2276,16 @@ static ssize_t uvcg_uncompressed_guid_format_store(struct config_item *item,
 		goto end;
 	}
 
-	memcpy(ch->desc.guidFormat, page,
+	memcpy(tmpguidFormat, page,
+	       min(sizeof(tmpguidFormat), len));
+
+	format = uvc_format_by_guid(tmpguidFormat);
+	if (!format) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	memcpy(ch->desc.guidFormat, tmpguidFormat,
 	       min(sizeof(ch->desc.guidFormat), len));
 	ret = sizeof(ch->desc.guidFormat);
 

---
base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
change-id: 20240221-uvc-gadget-configfs-guid-fe09965b42e6

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


