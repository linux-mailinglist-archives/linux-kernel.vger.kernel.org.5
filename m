Return-Path: <linux-kernel+bounces-88415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243186E148
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 13:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2211D1F21757
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12E140859;
	Fri,  1 Mar 2024 12:47:25 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970E7E1;
	Fri,  1 Mar 2024 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709297245; cv=none; b=cbwJZklosJBHmaQGSu3gsL0VS+khS7+bzzn9yCGtA9R0ZPdRrQOkW8GU/7pTDS6I3WH9hJkrYXNNpO53dhJkParSnBRTNeJhpZWYaz6RvSOayVGu+0ZYrncAnLfndJl2JfQpFHzoppQylpthUz6j3nS8nZ6o7Rz6qiUTDbsom+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709297245; c=relaxed/simple;
	bh=xmtt/dJqJpEhHTRjQVG1J/CP+alT6/cJsmAw7/JRl/I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GRrjH4TKJWAk9P02JU/KVhrA97W0losTQzHHYSrvpTESltrjomCYX8vz1NiEQ+mX143gI8r2J/LNaPdtBuk47l2XVFty2lCifMiILFo9X7C6HlFTfJ5eTS85BW5Qk62w1g2coWvWrgPZdifxocGHj/IqKbPTdGnTGLmAnm36etk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id 7AE30520252;
	Fri,  1 Mar 2024 13:47:16 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 1 Mar
 2024 13:47:16 +0100
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: <gregkh@linuxfoundation.org>, <michael@allwinnertech.com>,
	<quic_linyyuan@quicinc.com>, <quic_ugoswami@quicinc.com>,
	<brauner@kernel.org>, <sfr@canb.auug.org.au>, <quic_kriskura@quicinc.com>,
	<axboe@kernel.dk>, <jlayton@kernel.org>
CC: <hgajjar@de.adit-jv.com>, <hardik.gajjar@bosch.com>,
	<eugeniu.rosca@bosch.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: gadget: f_fs: Add the missing get_alt callback
Date: Fri, 1 Mar 2024 13:47:08 +0100
Message-ID: <20240301124708.120394-1-hgajjar@de.adit-jv.com>
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

The Apple CarLife iAP gadget has a descriptor in userspace with two
alternate settings. The host sends the set_alt request to configure
alt_setting 0 or 1, and this is verified by the subsequent get_alt
request.

This patch implements and sets the get_alt callback. Without the
get_alt callback, composite.c abruptly concludes the
USB_REQ_GET/SET_INTERFACE request, assuming only one alt setting
for the endpoint.

unlike the uvc and ncm, f_fs gadget is fully implemented in userspace,
and driver just reset the eps and generate the event. so no additional
adaptaion associated with this change is not required in set_alt callback

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
---
 drivers/usb/gadget/function/f_fs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 6bff6cb93789..a3e8cf7963e7 100644
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
@@ -3231,6 +3234,15 @@ static void ffs_reset_work(struct work_struct *work)
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
@@ -3238,6 +3250,9 @@ static int ffs_func_set_alt(struct usb_function *f,
 	struct ffs_data *ffs = func->ffs;
 	int ret = 0, intf;
 
+	if (alt > MAX_ALT_SETTINGS)
+		return -EINVAL;
+
 	if (alt != (unsigned)-1) {
 		intf = ffs_func_revmap_intf(func, interface);
 		if (intf < 0)
@@ -3265,8 +3280,10 @@ static int ffs_func_set_alt(struct usb_function *f,
 
 	ffs->func = func;
 	ret = ffs_func_eps_enable(func);
-	if (ret >= 0)
+	if (ret >= 0) {
 		ffs_event_add(ffs, FUNCTIONFS_ENABLE);
+		func->cur_alt[interface] = alt;
+	}
 	return ret;
 }
 
@@ -3573,6 +3590,7 @@ static struct usb_function *ffs_alloc(struct usb_function_instance *fi)
 	func->function.bind    = ffs_func_bind;
 	func->function.unbind  = ffs_func_unbind;
 	func->function.set_alt = ffs_func_set_alt;
+	func->function.get_alt = ffs_func_get_alt;
 	func->function.disable = ffs_func_disable;
 	func->function.setup   = ffs_func_setup;
 	func->function.req_match = ffs_func_req_match;
-- 
2.17.1


