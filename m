Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B06E757A7D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjGRLbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGRLbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:31:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3095DE8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:31:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A9852F4;
        Tue, 18 Jul 2023 04:32:03 -0700 (PDT)
Received: from e109506.cambridge.arm.com (e109506.cambridge.arm.com [10.1.199.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14773F6C4;
        Tue, 18 Jul 2023 04:31:18 -0700 (PDT)
From:   Rahul Singh <rahul.singh@arm.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jane Malalane <jane.malalane@citrix.com>
Subject: [PATCH v3] xen/evtchn: Introduce new IOCTL to bind static evtchn
Date:   Tue, 18 Jul 2023 12:31:07 +0100
Message-Id: <ae7329bf1713f83e4aad4f3fa0f316258c40a3e9.1689677042.git.rahul.singh@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xen 4.17 supports the creation of static evtchns. To allow user space
application to bind static evtchns introduce new ioctl
"IOCTL_EVTCHN_BIND_STATIC". Existing IOCTL doing more than binding
that’s why we need to introduce the new IOCTL to only bind the static
event channels.

Static evtchns to be available for use during the lifetime of the
guest. When the application exits, __unbind_from_irq() ends up being
called from release() file operations because of that static evtchns
are getting closed. To avoid closing the static event channel, add the
new bool variable "is_static" in "struct irq_info" to mark the event
channel static when creating the event channel to avoid closing the
static evtchn.

Also, take this opportunity to remove the open-coded version of the
evtchn close in drivers/xen/evtchn.c file and use xen_evtchn_close().

Signed-off-by: Rahul Singh <rahul.singh@arm.com>
---
v3:
 * Remove the open-coded version of the evtchn close in drivers/xen/evtchn.c
v2:
 * Use bool in place u8 to define is_static variable.
 * Avoid closing the static evtchns in error path.
---
 drivers/xen/events/events_base.c | 16 +++++----------
 drivers/xen/evtchn.c             | 35 ++++++++++++++++++++++++--------
 include/uapi/xen/evtchn.h        |  9 ++++++++
 include/xen/events.h             | 11 +++++++++-
 4 files changed, 50 insertions(+), 21 deletions(-)

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index c7715f8bd452..3bdd5b59661d 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -112,6 +112,7 @@ struct irq_info {
 	unsigned int irq_epoch; /* If eoi_cpu valid: irq_epoch of event */
 	u64 eoi_time;           /* Time in jiffies when to EOI. */
 	raw_spinlock_t lock;
+	bool is_static;           /* Is event channel static */
 
 	union {
 		unsigned short virq;
@@ -815,15 +816,6 @@ static void xen_free_irq(unsigned irq)
 	irq_free_desc(irq);
 }
 
-static void xen_evtchn_close(evtchn_port_t port)
-{
-	struct evtchn_close close;
-
-	close.port = port;
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
-		BUG();
-}
-
 /* Not called for lateeoi events. */
 static void event_handler_exit(struct irq_info *info)
 {
@@ -982,7 +974,8 @@ static void __unbind_from_irq(unsigned int irq)
 		unsigned int cpu = cpu_from_irq(irq);
 		struct xenbus_device *dev;
 
-		xen_evtchn_close(evtchn);
+		if (!info->is_static)
+			xen_evtchn_close(evtchn);
 
 		switch (type_from_irq(irq)) {
 		case IRQT_VIRQ:
@@ -1574,7 +1567,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority)
 }
 EXPORT_SYMBOL_GPL(xen_set_irq_priority);
 
-int evtchn_make_refcounted(evtchn_port_t evtchn)
+int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static)
 {
 	int irq = get_evtchn_to_irq(evtchn);
 	struct irq_info *info;
@@ -1590,6 +1583,7 @@ int evtchn_make_refcounted(evtchn_port_t evtchn)
 	WARN_ON(info->refcnt != -1);
 
 	info->refcnt = 1;
+	info->is_static = is_static;
 
 	return 0;
 }
diff --git a/drivers/xen/evtchn.c b/drivers/xen/evtchn.c
index c99415a70051..9139a7364df5 100644
--- a/drivers/xen/evtchn.c
+++ b/drivers/xen/evtchn.c
@@ -366,10 +366,10 @@ static int evtchn_resize_ring(struct per_user_data *u)
 	return 0;
 }
 
-static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
+static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port,
+			       bool is_static)
 {
 	struct user_evtchn *evtchn;
-	struct evtchn_close close;
 	int rc = 0;
 
 	/*
@@ -402,14 +402,14 @@ static int evtchn_bind_to_user(struct per_user_data *u, evtchn_port_t port)
 	if (rc < 0)
 		goto err;
 
-	rc = evtchn_make_refcounted(port);
+	rc = evtchn_make_refcounted(port, is_static);
 	return rc;
 
 err:
 	/* bind failed, should close the port now */
-	close.port = port;
-	if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
-		BUG();
+	if (!is_static)
+		xen_evtchn_close(port);
+
 	del_evtchn(u, evtchn);
 	return rc;
 }
@@ -456,7 +456,7 @@ static long evtchn_ioctl(struct file *file,
 		if (rc != 0)
 			break;
 
-		rc = evtchn_bind_to_user(u, bind_virq.port);
+		rc = evtchn_bind_to_user(u, bind_virq.port, false);
 		if (rc == 0)
 			rc = bind_virq.port;
 		break;
@@ -482,7 +482,7 @@ static long evtchn_ioctl(struct file *file,
 		if (rc != 0)
 			break;
 
-		rc = evtchn_bind_to_user(u, bind_interdomain.local_port);
+		rc = evtchn_bind_to_user(u, bind_interdomain.local_port, false);
 		if (rc == 0)
 			rc = bind_interdomain.local_port;
 		break;
@@ -507,7 +507,7 @@ static long evtchn_ioctl(struct file *file,
 		if (rc != 0)
 			break;
 
-		rc = evtchn_bind_to_user(u, alloc_unbound.port);
+		rc = evtchn_bind_to_user(u, alloc_unbound.port, false);
 		if (rc == 0)
 			rc = alloc_unbound.port;
 		break;
@@ -536,6 +536,23 @@ static long evtchn_ioctl(struct file *file,
 		break;
 	}
 
+	case IOCTL_EVTCHN_BIND_STATIC: {
+		struct ioctl_evtchn_bind bind;
+		struct user_evtchn *evtchn;
+
+		rc = -EFAULT;
+		if (copy_from_user(&bind, uarg, sizeof(bind)))
+			break;
+
+		rc = -EISCONN;
+		evtchn = find_evtchn(u, bind.port);
+		if (evtchn)
+			break;
+
+		rc = evtchn_bind_to_user(u, bind.port, true);
+		break;
+	}
+
 	case IOCTL_EVTCHN_NOTIFY: {
 		struct ioctl_evtchn_notify notify;
 		struct user_evtchn *evtchn;
diff --git a/include/uapi/xen/evtchn.h b/include/uapi/xen/evtchn.h
index 7fbf732f168f..aef2b75f3413 100644
--- a/include/uapi/xen/evtchn.h
+++ b/include/uapi/xen/evtchn.h
@@ -101,4 +101,13 @@ struct ioctl_evtchn_restrict_domid {
 	domid_t domid;
 };
 
+/*
+ * Bind statically allocated @port.
+ */
+#define IOCTL_EVTCHN_BIND_STATIC			\
+	_IOC(_IOC_NONE, 'E', 7, sizeof(struct ioctl_evtchn_bind))
+struct ioctl_evtchn_bind {
+	unsigned int port;
+};
+
 #endif /* __LINUX_PUBLIC_EVTCHN_H__ */
diff --git a/include/xen/events.h b/include/xen/events.h
index ac1281c5ead6..95970a2f7695 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -69,7 +69,7 @@ int xen_set_irq_priority(unsigned irq, unsigned priority);
 /*
  * Allow extra references to event channels exposed to userspace by evtchn
  */
-int evtchn_make_refcounted(evtchn_port_t evtchn);
+int evtchn_make_refcounted(evtchn_port_t evtchn, bool is_static);
 int evtchn_get(evtchn_port_t evtchn);
 void evtchn_put(evtchn_port_t evtchn);
 
@@ -141,4 +141,13 @@ void xen_init_IRQ(void);
 
 irqreturn_t xen_debug_interrupt(int irq, void *dev_id);
 
+static inline void xen_evtchn_close(evtchn_port_t port)
+{
+	struct evtchn_close close;
+
+	close.port = port;
+	if (HYPERVISOR_event_channel_op(EVTCHNOP_close, &close) != 0)
+		BUG();
+}
+
 #endif	/* _XEN_EVENTS_H */

base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
-- 
2.25.1

