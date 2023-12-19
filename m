Return-Path: <linux-kernel+bounces-5243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF3818867
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB541C2450C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2716D18E23;
	Tue, 19 Dec 2023 13:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2H1oJpGl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DF71A72F;
	Tue, 19 Dec 2023 13:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F30C433C7;
	Tue, 19 Dec 2023 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702991598;
	bh=v/l7Tz3WkZWoGMvQIFLXKklRO1xjzZXrrk79+f7YK2g=;
	h=From:To:Cc:Subject:Date:From;
	b=2H1oJpGlf0u5/mAaZT+36o9+aDmNO5+vf87ZPBBb8Fg//ouU3wNc1kP5Oqq5Pi8JA
	 BQ9fnOhtPwaAjF00hPfoQreLHvcqbgiXxhWSi6liYVVdTbLage9m9xEYrFkTC/alE9
	 A0VT+vwH7KfP8wHR5neKfRPEOy0DxLdG813LVhxY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: bp@alien8.de,
	tony.luck@intel.com
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	James Morse <james.morse@arm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Robert Richter <rric@kernel.org>,
	linux-edac@vger.kernel.org
Subject: [PATCH] EDAC: constantify the struct bus_type usage
Date: Tue, 19 Dec 2023 14:13:10 +0100
Message-ID: <2023121909-tribute-punctuate-4b22@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 105
X-Developer-Signature: v=1; a=openpgp-sha256; l=3630; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=v/l7Tz3WkZWoGMvQIFLXKklRO1xjzZXrrk79+f7YK2g=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmN055K3I7lV6/gNXhx8dfH6SV32o6cYIiTDf8xYYFB4 o0k+7u+HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRxXUM85135ilObMg96Pfh xc6/IXHfd2yN4WWYn3Bzwzy9EOGdbiyJdwIy0+Iq3k3+AgA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

In many places in the edac code, struct bus_type pointers are passed
around and then eventually sent to the driver core, which can handle a
constant pointer.  So constantify all of the edac usage of these as well
because the data in them is never modified by the edac code either.

Cc: Borislav Petkov <bp@alien8.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: James Morse <james.morse@arm.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Robert Richter <rric@kernel.org>
Cc: linux-edac@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/edac/edac_device.h       | 2 +-
 drivers/edac/edac_device_sysfs.c | 2 +-
 drivers/edac/edac_module.c       | 4 ++--
 drivers/edac/edac_pci_sysfs.c    | 2 +-
 include/linux/edac.h             | 4 ++--
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/edac_device.h b/drivers/edac/edac_device.h
index 3f44e6b9d387..7db22a4c83ef 100644
--- a/drivers/edac/edac_device.h
+++ b/drivers/edac/edac_device.h
@@ -176,7 +176,7 @@ struct edac_device_ctl_info {
 	struct edac_dev_sysfs_attribute *sysfs_attributes;
 
 	/* pointer to main 'edac' subsys in sysfs */
-	struct bus_type *edac_subsys;
+	const struct bus_type *edac_subsys;
 
 	/* the internal state of this controller instance */
 	int op_state;
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 010c26be5846..237a542e045a 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -229,7 +229,7 @@ static struct kobj_type ktype_device_ctrl = {
 int edac_device_register_sysfs_main_kobj(struct edac_device_ctl_info *edac_dev)
 {
 	struct device *dev_root;
-	struct bus_type *edac_subsys;
+	const struct bus_type *edac_subsys;
 	int err = -ENODEV;
 
 	edac_dbg(1, "\n");
diff --git a/drivers/edac/edac_module.c b/drivers/edac/edac_module.c
index 32a931d0cb71..1c9f62382666 100644
--- a/drivers/edac/edac_module.c
+++ b/drivers/edac/edac_module.c
@@ -67,7 +67,7 @@ char *edac_op_state_to_string(int opstate)
  * sysfs object: /sys/devices/system/edac
  *	need to export to other files
  */
-static struct bus_type edac_subsys = {
+static const struct bus_type edac_subsys = {
 	.name = "edac",
 	.dev_name = "edac",
 };
@@ -90,7 +90,7 @@ static void edac_subsys_exit(void)
 }
 
 /* return pointer to the 'edac' node in sysfs */
-struct bus_type *edac_get_sysfs_subsys(void)
+const struct bus_type *edac_get_sysfs_subsys(void)
 {
 	return &edac_subsys;
 }
diff --git a/drivers/edac/edac_pci_sysfs.c b/drivers/edac/edac_pci_sysfs.c
index 287cc51dbc86..e823e4da086a 100644
--- a/drivers/edac/edac_pci_sysfs.c
+++ b/drivers/edac/edac_pci_sysfs.c
@@ -338,7 +338,7 @@ static struct kobj_type ktype_edac_pci_main_kobj = {
 static int edac_pci_main_kobj_setup(void)
 {
 	int err = -ENODEV;
-	struct bus_type *edac_subsys;
+	const struct bus_type *edac_subsys;
 	struct device *dev_root;
 
 	edac_dbg(0, "\n");
diff --git a/include/linux/edac.h b/include/linux/edac.h
index fa4bda2a70f6..ccaf2ae0801d 100644
--- a/include/linux/edac.h
+++ b/include/linux/edac.h
@@ -30,7 +30,7 @@ struct device;
 
 extern int edac_op_state;
 
-struct bus_type *edac_get_sysfs_subsys(void);
+const struct bus_type *edac_get_sysfs_subsys(void);
 
 static inline void opstate_init(void)
 {
@@ -492,7 +492,7 @@ struct edac_raw_error_desc {
  */
 struct mem_ctl_info {
 	struct device			dev;
-	struct bus_type			*bus;
+	const struct bus_type		*bus;
 
 	struct list_head link;	/* for global list of mem_ctl_info structs */
 
-- 
2.43.0


