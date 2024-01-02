Return-Path: <linux-kernel+bounces-14353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11637821BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF6B1F227DA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A793FF9DE;
	Tue,  2 Jan 2024 12:41:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABDAF515;
	Tue,  2 Jan 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 5A472520254;
	Tue,  2 Jan 2024 13:34:33 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 2 Jan
 2024 13:34:33 +0100
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
	<john@keeping.me.uk>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<erosca@de.adit-jv.com>, <hgajjar@de.adit-jv.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
Subject: [PATCH v3] usb: gadget: f_fs: Add the missing get_alt callback
Date: Tue, 2 Jan 2024 13:34:19 +0100
Message-ID: <20240102123419.13491-1-hgajjar@de.adit-jv.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

The Apple CarLife iAP gadget has a descriptor with two alternate
settings. The host sends the set_alt request to configure alt_setting
0 or 1, and this is verified by the subsequent get_alt request.

This patch implements and sets the get_alt callback. Without the
get_alt callback, composite.c abruptly concludes the
USB_REQ_GET/SET_INTERFACE request, assuming only one alt setting
for the endpoint.

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
---
changes since version 1:
	- improve commit message to indicate why the get_alt callback
	  is necessary
	- Link to v1 - https://lore.kernel.org/all/20231124164435.74727-1-hgajjar@de.adit-jv.com/

changes since version 2:
	- Add the limit to allow set up to 2 alt settings.
	- Link to v2 - https://lore.kernel.org/all/20231201145234.97452-1-hgajjar@de.adit-jv.com/
---
 drivers/usb/gadget/function/f_fs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index efe3e3b85769..22200d618184 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -42,6 +42,7 @@
 #include "configfs.h"
 
 #define FUNCTIONFS_MAGIC	0xa647361 /* Chosen by a honest dice roll ;) */
+#define MAX_ALT_SETTINGS	2		  /* Allow up to 2 alt settings to be set. */
 
 /* Reference counter handling */
 static void ffs_data_get(struct ffs_data *ffs);
@@ -75,6 +76,7 @@ struct ffs_function {
 	short				*interfaces_nums;
 
 	struct usb_function		function;
+	int				cur_alt[MAX_CONFIG_INTERFACES];
 };
 
 
@@ -98,6 +100,7 @@ static int __must_check ffs_func_eps_enable(struct ffs_function *func);
 static int ffs_func_bind(struct usb_configuration *,
 			 struct usb_function *);
 static int ffs_func_set_alt(struct usb_function *, unsigned, unsigned);
+static int ffs_func_get_alt(struct usb_function *f, unsigned int intf);
 static void ffs_func_disable(struct usb_function *);
 static int ffs_func_setup(struct usb_function *,
 			  const struct usb_ctrlrequest *);
@@ -3232,6 +3235,15 @@ static void ffs_reset_work(struct work_struct *work)
 	ffs_data_reset(ffs);
 }
 
+static int ffs_func_get_alt(struct usb_function *f,
+			    unsigned int interface)
+{
+	struct ffs_function *func = ffs_func_from_usb(f);
+	int intf = ffs_func_revmap_intf(func, interface);
+
+	return (intf < 0) ? intf : func->cur_alt[interface];
+}
+
 static int ffs_func_set_alt(struct usb_function *f,
 			    unsigned interface, unsigned alt)
 {
@@ -3239,6 +3251,9 @@ static int ffs_func_set_alt(struct usb_function *f,
 	struct ffs_data *ffs = func->ffs;
 	int ret = 0, intf;
 
+	if (alt > MAX_ALT_SETTINGS)
+		return -EINVAL;
+
 	if (alt != (unsigned)-1) {
 		intf = ffs_func_revmap_intf(func, interface);
 		if (intf < 0)
@@ -3266,8 +3281,10 @@ static int ffs_func_set_alt(struct usb_function *f,
 
 	ffs->func = func;
 	ret = ffs_func_eps_enable(func);
-	if (ret >= 0)
+	if (ret >= 0) {
 		ffs_event_add(ffs, FUNCTIONFS_ENABLE);
+		func->cur_alt[interface] = alt;
+	}
 	return ret;
 }
 
@@ -3574,6 +3591,7 @@ static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
 	func->function.bind    = ffs_func_bind;
 	func->function.unbind  = ffs_func_unbind;
 	func->function.set_alt = ffs_func_set_alt;
+	func->function.get_alt = ffs_func_get_alt;
 	func->function.disable = ffs_func_disable;
 	func->function.setup   = ffs_func_setup;
 	func->function.req_match = ffs_func_req_match;
-- 
2.17.1


