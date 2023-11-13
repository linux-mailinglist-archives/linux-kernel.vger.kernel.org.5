Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECA67E943D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 02:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjKMBpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 20:45:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjKMBpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 20:45:41 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 61B10D7A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 17:45:37 -0800 (PST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 59BFD60327047;
        Mon, 13 Nov 2023 09:45:35 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From:   Li zeming <zeming@nfschina.com>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] misc: ocxl: link: Remove unnecessary (void*) conversions
Date:   Mon, 13 Nov 2023 09:45:33 +0800
Message-Id: <20231113014533.11064-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The link pointer does not need to cast the type.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/misc/ocxl/link.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/ocxl/link.c b/drivers/misc/ocxl/link.c
index c06c699c0e7b1..03402203cacdb 100644
--- a/drivers/misc/ocxl/link.c
+++ b/drivers/misc/ocxl/link.c
@@ -188,7 +188,7 @@ static void xsl_fault_handler_bh(struct work_struct *fault_work)
 
 static irqreturn_t xsl_fault_handler(int irq, void *data)
 {
-	struct ocxl_link *link = (struct ocxl_link *) data;
+	struct ocxl_link *link = data;
 	struct spa *spa = link->spa;
 	u64 dsisr, dar, pe_handle;
 	struct pe_data *pe_data;
@@ -483,7 +483,7 @@ static void release_xsl(struct kref *ref)
 
 void ocxl_link_release(struct pci_dev *dev, void *link_handle)
 {
-	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+	struct ocxl_link *link = link_handle;
 
 	mutex_lock(&links_list_lock);
 	kref_put(&link->ref, release_xsl);
@@ -540,7 +540,7 @@ int ocxl_link_add_pe(void *link_handle, int pasid, u32 pidr, u32 tidr,
 		void (*xsl_err_cb)(void *data, u64 addr, u64 dsisr),
 		void *xsl_err_data)
 {
-	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+	struct ocxl_link *link = link_handle;
 	struct spa *spa = link->spa;
 	struct ocxl_process_element *pe;
 	int pe_handle, rc = 0;
@@ -630,7 +630,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_add_pe);
 
 int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
 {
-	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+	struct ocxl_link *link = link_handle;
 	struct spa *spa = link->spa;
 	struct ocxl_process_element *pe;
 	int pe_handle, rc;
@@ -666,7 +666,7 @@ int ocxl_link_update_pe(void *link_handle, int pasid, __u16 tid)
 
 int ocxl_link_remove_pe(void *link_handle, int pasid)
 {
-	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+	struct ocxl_link *link = link_handle;
 	struct spa *spa = link->spa;
 	struct ocxl_process_element *pe;
 	struct pe_data *pe_data;
@@ -752,7 +752,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_remove_pe);
 
 int ocxl_link_irq_alloc(void *link_handle, int *hw_irq)
 {
-	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+	struct ocxl_link *link = link_handle;
 	int irq;
 
 	if (atomic_dec_if_positive(&link->irq_available) < 0)
@@ -771,7 +771,7 @@ EXPORT_SYMBOL_GPL(ocxl_link_irq_alloc);
 
 void ocxl_link_free_irq(void *link_handle, int hw_irq)
 {
-	struct ocxl_link *link = (struct ocxl_link *) link_handle;
+	struct ocxl_link *link = link_handle;
 
 	xive_native_free_irq(hw_irq);
 	atomic_inc(&link->irq_available);
-- 
2.18.2

