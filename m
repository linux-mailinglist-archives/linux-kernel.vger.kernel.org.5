Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A3278C444
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235386AbjH2MaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235350AbjH2M3o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:29:44 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CB8B9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:29:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c0ecb9a075so15081915ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693312180; x=1693916980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALfabch9X4dxgSREM5zC4IQrwsjRCPNJ2ui8ADwmtgo=;
        b=NegsCixfRE+Ea0B3C+RIDmscZI98ukn3SGyReUGF3xRHEopZPPsiSGQfkBCqpt4kb4
         BhYJgdMAAEFLNJIO4wMi2gqfEsfmTZoL3c9N+eL8/J+Yuu9o8KHQu4GrL60R3QQ5G5TO
         jMgwGm4APsiQx1Xxu2yNs8SJ2h/F9Nc0j/A1ss5XUqz5/lUXRuleZry24uRI8IDuJ0SI
         ov/S9+RLH4CjRNNMfkj6CiUkcIvc+vHkmbz8+80jWgCfpnq5aVCE5VLEn+9v1/F2ewf4
         pfMagqMk70r3eOiqRYXkDzp5bBdLHAJxIoPbGJDh5rJuq3GbBwtnbXmS/SQd1c4KzPZP
         759Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693312180; x=1693916980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALfabch9X4dxgSREM5zC4IQrwsjRCPNJ2ui8ADwmtgo=;
        b=PYSHW7pfTdU8IU/gokTROxFbdPXO9mRK/JOKMV+VHzdUQc2QUfSlL9zhpbgN4hDixS
         /4BWila9QnKa6iBVGqKHURrnqq/tyNVA3W0rLYLAy/pIRe4+QPPyNKlZgpy9dac3GNlc
         5bO8gwOWdmHKnolBOvQWTiLH/N9oTLVPhrltVOOr1KRnX4qWyp0qxqgh5t5Zs8Qe+sE/
         0ibugwdsa7CwG8Rx4d5huYBs1ABLPOiG7b9hyM0yAlobE7jAchhHU8mQ46tyIujQderK
         qLsUA9NT1v538fyfvjHMjdBq3b81bAJf5tOfp6TA5E/Sv59KIZdzkkvjK37IGpIzLwlg
         mDdw==
X-Gm-Message-State: AOJu0YxT1cZVzwVhauLzzXPYQJCXhzZuJ5QJIMboTufRFfYHE9dF06j9
        HqFb9BcdTBTYt64YptqVXOonow==
X-Google-Smtp-Source: AGHT+IEwfZSITHXQdGHIk2dhtzabWBiJuMdWiGfI357aRfJBRCRpY2kq5ax9OsLbGhBGvFinZAoKLQ==
X-Received: by 2002:a17:903:32ce:b0:1c0:ce0f:ab54 with SMTP id i14-20020a17090332ce00b001c0ce0fab54mr11229979plr.61.1693312180111;
        Tue, 29 Aug 2023 05:29:40 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902c94900b001bdb85291casm9265719pla.208.2023.08.29.05.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 05:29:39 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: [PATCH 2/2] xen: privcmd: Add support for ioeventfd
Date:   Tue, 29 Aug 2023 17:59:05 +0530
Message-Id: <52b07a3861a34fb0deb6251bae8bd885815c6944.1693311370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1693311370.git.viresh.kumar@linaro.org>
References: <cover.1693311370.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio guests send VIRTIO_MMIO_QUEUE_NOTIFY notification when they need
to notify the backend of an update to the status of the virtqueue. The
backend or another entity, polls the MMIO address for updates to know
when the notification is sent.

It works well if the backend does this polling by itself. But as we move
towards generic backend implementations, we end up implementing this in
a separate user-space program.

Generally, the Virtio backends are implemented to work with the Eventfd
based mechanism. In order to make such backends work with Xen, another
software layer needs to do the polling and send an event via eventfd to
the backend once the notification from guest is received. This results
in an extra context switch.

This is not a new problem in Linux though. It is present with other
hypervisors like KVM, etc. as well. The generic solution implemented in
the kernel for them is to provide an IOCTL call to pass the address to
poll and eventfd, which lets the kernel take care of polling and raise
an event on the eventfd, instead of handling this in user space (which
involves an extra context switch).

This patch adds similar support for xen.

Inspired by existing implementations for KVM, etc..

This also copies ioreq.h header file (only struct ioreq and related
macros) from Xen's source tree (Top commit 5d84f07fe6bf ("xen/pci: drop
remaining uses of bool_t")).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/xen/Kconfig               |   8 +-
 drivers/xen/privcmd.c             | 385 +++++++++++++++++++++++++++++-
 include/uapi/xen/privcmd.h        |  18 ++
 include/xen/interface/hvm/ioreq.h |  51 ++++
 4 files changed, 456 insertions(+), 6 deletions(-)
 create mode 100644 include/xen/interface/hvm/ioreq.h

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index d43153fec18e..d5989871dd5d 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -269,12 +269,12 @@ config XEN_PRIVCMD
 	  disaggregated Xen setups this driver might be needed for other
 	  domains, too.
 
-config XEN_PRIVCMD_IRQFD
-	bool "Xen irqfd support"
+config XEN_PRIVCMD_EVENTFD
+	bool "Xen Ioeventfd and irqfd support"
 	depends on XEN_PRIVCMD && XEN_VIRTIO && EVENTFD
 	help
-	  Using the irqfd mechanism a virtio backend running in a daemon can
-	  speed up interrupt injection into a guest.
+	  Using the ioeventfd / irqfd mechanism a virtio backend running in a
+	  daemon can speed up interrupt delivery from / to a guest.
 
 config XEN_ACPI_PROCESSOR
 	tristate "Xen ACPI processor"
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 120af57999fc..4b18c51b6b2e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -29,15 +29,18 @@
 #include <linux/seq_file.h>
 #include <linux/miscdevice.h>
 #include <linux/moduleparam.h>
+#include <linux/virtio_mmio.h>
 
 #include <asm/xen/hypervisor.h>
 #include <asm/xen/hypercall.h>
 
 #include <xen/xen.h>
+#include <xen/events.h>
 #include <xen/privcmd.h>
 #include <xen/interface/xen.h>
 #include <xen/interface/memory.h>
 #include <xen/interface/hvm/dm_op.h>
+#include <xen/interface/hvm/ioreq.h>
 #include <xen/features.h>
 #include <xen/page.h>
 #include <xen/xen-ops.h>
@@ -782,6 +785,7 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 			goto out;
 
 		pages = vma->vm_private_data;
+
 		for (i = 0; i < kdata.num; i++) {
 			xen_pfn_t pfn =
 				page_to_xen_pfn(pages[i / XEN_PFN_PER_PAGE]);
@@ -838,7 +842,7 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 	return rc;
 }
 
-#ifdef CONFIG_XEN_PRIVCMD_IRQFD
+#ifdef CONFIG_XEN_PRIVCMD_EVENTFD
 /* Irqfd support */
 static struct workqueue_struct *irqfd_cleanup_wq;
 static DEFINE_MUTEX(irqfds_lock);
@@ -1079,6 +1083,369 @@ static void privcmd_irqfd_exit(void)
 
 	destroy_workqueue(irqfd_cleanup_wq);
 }
+
+/* Ioeventfd Support */
+#define QUEUE_NOTIFY_VQ_MASK 0xFFFF
+
+static DEFINE_MUTEX(ioreq_lock);
+static LIST_HEAD(ioreq_list);
+
+/* per-eventfd structure */
+struct privcmd_kernel_ioeventfd {
+	struct eventfd_ctx *eventfd;
+	struct list_head list;
+	unsigned long long addr;
+	unsigned int addr_len;
+	unsigned int vq;
+};
+
+/* per-guest CPU / port structure */
+struct ioreq_port {
+	int vcpu;
+	unsigned int port;
+	struct privcmd_kernel_ioreq *kioreq;
+};
+
+/* per-guest structure */
+struct privcmd_kernel_ioreq {
+	domid_t dom;
+	unsigned int vcpus;
+	void __user *uioreq;
+	struct ioreq *ioreq;
+	struct mutex lock; /* Protects ioeventfds list */
+	struct list_head ioeventfds;
+	struct list_head list;
+	struct ioreq_port *ports;
+};
+
+static irqreturn_t ioeventfd_interrupt(int irq, void *dev_id)
+{
+	struct ioreq_port *port = dev_id;
+	struct privcmd_kernel_ioreq *kioreq = port->kioreq;
+	struct ioreq *ioreq = &kioreq->ioreq[port->vcpu];
+	struct privcmd_kernel_ioeventfd *kioeventfd;
+	unsigned int state = STATE_IOREQ_READY;
+
+	if (ioreq->state != STATE_IOREQ_READY ||
+	    ioreq->type != IOREQ_TYPE_COPY || ioreq->dir != IOREQ_WRITE)
+		return IRQ_NONE;
+
+	smp_mb();
+	ioreq->state = STATE_IOREQ_INPROCESS;
+
+	mutex_lock(&kioreq->lock);
+	list_for_each_entry(kioeventfd, &kioreq->ioeventfds, list) {
+		if (ioreq->addr == kioeventfd->addr + VIRTIO_MMIO_QUEUE_NOTIFY &&
+		    ioreq->size == kioeventfd->addr_len &&
+		    (ioreq->data & QUEUE_NOTIFY_VQ_MASK) == kioeventfd->vq) {
+			eventfd_signal(kioeventfd->eventfd, 1);
+			state = STATE_IORESP_READY;
+			break;
+		}
+	}
+	mutex_unlock(&kioreq->lock);
+
+	smp_mb();
+	ioreq->state = state;
+
+	if (state == STATE_IORESP_READY) {
+		notify_remote_via_evtchn(port->port);
+		return IRQ_HANDLED;
+	}
+
+	return IRQ_NONE;
+}
+
+static void ioreq_free(struct privcmd_kernel_ioreq *kioreq)
+{
+	struct ioreq_port *ports = kioreq->ports;
+	int i;
+
+	lockdep_assert_held(&ioreq_lock);
+
+	if (!list_empty(&kioreq->ioeventfds))
+		return;
+
+	list_del(&kioreq->list);
+
+	for (i = kioreq->vcpus - 1; i >= 0; i--)
+		unbind_from_irqhandler(irq_from_evtchn(ports[i].port), &ports[i]);
+
+	kfree(kioreq);
+}
+
+static
+struct privcmd_kernel_ioreq *alloc_ioreq(struct privcmd_ioeventfd *ioeventfd)
+{
+	struct privcmd_kernel_ioreq *kioreq;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+	struct page **pages;
+	unsigned int *ports;
+	int ret, size, i;
+
+	lockdep_assert_held(&ioreq_lock);
+
+	size = sizeof(*kioreq) + sizeof(*kioreq->ports) * ioeventfd->vcpus;
+	kioreq = kzalloc(size, GFP_KERNEL);
+	if (!kioreq)
+		return ERR_PTR(-ENOMEM);
+	kioreq->ports = (struct ioreq_port *)(kioreq + 1);
+
+	kioreq->dom = ioeventfd->dom;
+	kioreq->vcpus = ioeventfd->vcpus;
+	kioreq->uioreq = ioeventfd->ioreq;
+	mutex_init(&kioreq->lock);
+	INIT_LIST_HEAD(&kioreq->ioeventfds);
+
+	/* The memory for ioreq server must have been mapped earlier */
+	mmap_write_lock(mm);
+	vma = find_vma(mm, (unsigned long)ioeventfd->ioreq);
+	if (!vma) {
+		pr_err("Failed to find vma for ioreq page!\n");
+		mmap_write_unlock(mm);
+		ret = -EFAULT;
+		goto error_kfree;
+	}
+
+	pages = vma->vm_private_data;
+	kioreq->ioreq = (struct ioreq *)(page_to_virt(pages[0]));
+	mmap_write_unlock(mm);
+
+	size = sizeof(*ports) * kioreq->vcpus;
+	ports = kzalloc(size, GFP_KERNEL);
+	if (!ports) {
+		ret = -ENOMEM;
+		goto error_kfree;
+	}
+
+	if (copy_from_user(ports, ioeventfd->ports, size)) {
+		ret = -EFAULT;
+		goto error_kfree_ports;
+	}
+
+	for (i = 0; i < kioreq->vcpus; i++) {
+		kioreq->ports[i].vcpu = i;
+		kioreq->ports[i].port = ports[i];
+		kioreq->ports[i].kioreq = kioreq;
+
+		ret = bind_evtchn_to_irqhandler_lateeoi(ports[i],
+				ioeventfd_interrupt, IRQF_SHARED, "ioeventfd",
+				&kioreq->ports[i]);
+		if (ret < 0)
+			goto error_unbind;
+	}
+
+	kfree(ports);
+
+	list_add_tail(&kioreq->list, &ioreq_list);
+
+	return kioreq;
+
+error_unbind:
+	while (--i >= 0)
+		unbind_from_irqhandler(irq_from_evtchn(ports[i]), &kioreq->ports[i]);
+error_kfree_ports:
+	kfree(ports);
+error_kfree:
+	kfree(kioreq);
+	return ERR_PTR(ret);
+}
+
+static struct privcmd_kernel_ioreq *
+get_ioreq(struct privcmd_ioeventfd *ioeventfd, struct eventfd_ctx *eventfd)
+{
+	struct privcmd_kernel_ioreq *kioreq;
+
+	list_for_each_entry(kioreq, &ioreq_list, list) {
+		struct privcmd_kernel_ioeventfd *kioeventfd;
+
+		/*
+		 * kioreq fields can be accessed here without a lock as they are
+		 * never updated after being added to the ioreq_list.
+		 */
+		if (kioreq->uioreq != ioeventfd->ioreq) {
+			continue;
+		} else if (kioreq->dom != ioeventfd->dom ||
+			   kioreq->vcpus != ioeventfd->vcpus) {
+			pr_err("Invalid ioeventfd configuration mismatch, dom (%u vs %u), vcpus (%u vs %u)\n",
+			       kioreq->dom, ioeventfd->dom, kioreq->vcpus,
+			       ioeventfd->vcpus);
+			return ERR_PTR(-EINVAL);
+		}
+
+		/* Look for a duplicate eventfd for the same guest */
+		mutex_lock(&kioreq->lock);
+		list_for_each_entry(kioeventfd, &kioreq->ioeventfds, list) {
+			if (eventfd == kioeventfd->eventfd) {
+				mutex_unlock(&kioreq->lock);
+				return ERR_PTR(-EBUSY);
+			}
+		}
+		mutex_unlock(&kioreq->lock);
+
+		return kioreq;
+	}
+
+	/* Matching kioreq isn't found, allocate a new one */
+	return alloc_ioreq(ioeventfd);
+}
+
+static void ioeventfd_free(struct privcmd_kernel_ioeventfd *kioeventfd)
+{
+	list_del(&kioeventfd->list);
+	eventfd_ctx_put(kioeventfd->eventfd);
+	kfree(kioeventfd);
+}
+
+static int privcmd_ioeventfd_assign(struct privcmd_ioeventfd *ioeventfd)
+{
+	struct privcmd_kernel_ioeventfd *kioeventfd;
+	struct privcmd_kernel_ioreq *kioreq;
+	struct fd f;
+	int ret;
+
+	/* Check for range overflow */
+	if (ioeventfd->addr + ioeventfd->addr_len < ioeventfd->addr)
+		return -EINVAL;
+
+	/* Vhost requires us to support length 1, 2, 4, and 8 */
+	if (!(ioeventfd->addr_len == 1 || ioeventfd->addr_len == 2 ||
+	      ioeventfd->addr_len == 4 || ioeventfd->addr_len == 8))
+		return -EINVAL;
+
+	kioeventfd = kzalloc(sizeof(*kioeventfd), GFP_KERNEL);
+	if (!kioeventfd)
+		return -ENOMEM;
+
+	f = fdget(ioeventfd->event_fd);
+	if (!f.file) {
+		ret = -EBADF;
+		goto error_kfree;
+	}
+
+	kioeventfd->eventfd = eventfd_ctx_fileget(f.file);
+	fdput(f);
+
+	if (IS_ERR(kioeventfd->eventfd)) {
+		ret = PTR_ERR(kioeventfd->eventfd);
+		goto error_kfree;
+	}
+
+	kioeventfd->addr = ioeventfd->addr;
+	kioeventfd->addr_len = ioeventfd->addr_len;
+	kioeventfd->vq = ioeventfd->vq;
+
+	mutex_lock(&ioreq_lock);
+	kioreq = get_ioreq(ioeventfd, kioeventfd->eventfd);
+	if (IS_ERR(kioreq)) {
+		mutex_unlock(&ioreq_lock);
+		ret = PTR_ERR(kioreq);
+		goto error_eventfd;
+	}
+
+	mutex_lock(&kioreq->lock);
+	list_add_tail(&kioeventfd->list, &kioreq->ioeventfds);
+	mutex_unlock(&kioreq->lock);
+
+	mutex_unlock(&ioreq_lock);
+
+	return 0;
+
+error_eventfd:
+	eventfd_ctx_put(kioeventfd->eventfd);
+
+error_kfree:
+	kfree(kioeventfd);
+	return ret;
+}
+
+static int privcmd_ioeventfd_deassign(struct privcmd_ioeventfd *ioeventfd)
+{
+	struct privcmd_kernel_ioreq *kioreq, *tkioreq;
+	struct eventfd_ctx *eventfd;
+	int ret = 0;
+
+	eventfd = eventfd_ctx_fdget(ioeventfd->event_fd);
+	if (IS_ERR(eventfd))
+		return PTR_ERR(eventfd);
+
+	mutex_lock(&ioreq_lock);
+	list_for_each_entry_safe(kioreq, tkioreq, &ioreq_list, list) {
+		struct privcmd_kernel_ioeventfd *kioeventfd, *tmp;
+		/*
+		 * kioreq fields can be accessed here without a lock as they are
+		 * never updated after being added to the ioreq_list.
+		 */
+		if (kioreq->dom != ioeventfd->dom ||
+		    kioreq->uioreq != ioeventfd->ioreq ||
+		    kioreq->vcpus != ioeventfd->vcpus)
+			continue;
+
+		mutex_lock(&kioreq->lock);
+		list_for_each_entry_safe(kioeventfd, tmp, &kioreq->ioeventfds, list) {
+			if (eventfd == kioeventfd->eventfd) {
+				ioeventfd_free(kioeventfd);
+				mutex_unlock(&kioreq->lock);
+
+				ioreq_free(kioreq);
+				goto unlock;
+			}
+		}
+		mutex_unlock(&kioreq->lock);
+		break;
+	}
+
+	pr_err("Ioeventfd isn't already assigned, dom: %u, addr: %llu\n",
+			ioeventfd->dom, ioeventfd->addr);
+	ret = -ENODEV;
+
+unlock:
+	mutex_unlock(&ioreq_lock);
+	eventfd_ctx_put(eventfd);
+
+	return 0;
+}
+
+static long privcmd_ioctl_ioeventfd(struct file *file, void __user *udata)
+{
+	struct privcmd_data *data = file->private_data;
+	struct privcmd_ioeventfd ioeventfd;
+
+	if (copy_from_user(&ioeventfd, udata, sizeof(ioeventfd)))
+		return -EFAULT;
+
+	/* No other flags should be set */
+	if (ioeventfd.flags & ~PRIVCMD_IOEVENTFD_FLAG_DEASSIGN)
+		return -EINVAL;
+
+	/* If restriction is in place, check the domid matches */
+	if (data->domid != DOMID_INVALID && data->domid != ioeventfd.dom)
+		return -EPERM;
+
+	if (ioeventfd.flags & PRIVCMD_IOEVENTFD_FLAG_DEASSIGN)
+		return privcmd_ioeventfd_deassign(&ioeventfd);
+
+	return privcmd_ioeventfd_assign(&ioeventfd);
+}
+
+static void privcmd_ioeventfd_exit(void)
+{
+	struct privcmd_kernel_ioreq *kioreq, *tmp;
+
+	mutex_lock(&ioreq_lock);
+	list_for_each_entry_safe(kioreq, tmp, &ioreq_list, list) {
+		struct privcmd_kernel_ioeventfd *kioeventfd, *tmp;
+
+		mutex_lock(&kioreq->lock);
+		list_for_each_entry_safe(kioeventfd, tmp, &kioreq->ioeventfds, list)
+			ioeventfd_free(kioeventfd);
+		mutex_unlock(&kioreq->lock);
+
+		ioreq_free(kioreq);
+	}
+	mutex_unlock(&ioreq_lock);
+}
 #else
 static inline long privcmd_ioctl_irqfd(struct file *file, void __user *udata)
 {
@@ -1093,7 +1460,16 @@ static inline int privcmd_irqfd_init(void)
 static inline void privcmd_irqfd_exit(void)
 {
 }
-#endif /* CONFIG_XEN_PRIVCMD_IRQFD */
+
+static inline long privcmd_ioctl_ioeventfd(struct file *file, void __user *udata)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void privcmd_ioeventfd_exit(void)
+{
+}
+#endif /* CONFIG_XEN_PRIVCMD_EVENTFD */
 
 static long privcmd_ioctl(struct file *file,
 			  unsigned int cmd, unsigned long data)
@@ -1134,6 +1510,10 @@ static long privcmd_ioctl(struct file *file,
 		ret = privcmd_ioctl_irqfd(file, udata);
 		break;
 
+	case IOCTL_PRIVCMD_IOEVENTFD:
+		ret = privcmd_ioctl_ioeventfd(file, udata);
+		break;
+
 	default:
 		break;
 	}
@@ -1278,6 +1658,7 @@ static int __init privcmd_init(void)
 
 static void __exit privcmd_exit(void)
 {
+	privcmd_ioeventfd_exit();
 	privcmd_irqfd_exit();
 	misc_deregister(&privcmd_dev);
 	misc_deregister(&xen_privcmdbuf_dev);
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index 375718ba4ab6..ce71390f0024 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -110,6 +110,22 @@ struct privcmd_irqfd {
 	__u8 pad[2];
 };
 
+/* For privcmd_ioeventfd::flags */
+#define PRIVCMD_IOEVENTFD_FLAG_DEASSIGN (1 << 0)
+
+struct privcmd_ioeventfd {
+	void __user *ioreq;
+	unsigned int __user *ports;
+	__u64 addr;
+	__u32 addr_len;
+	__u32 event_fd;
+	__u32 vcpus;
+	__u32 vq;
+	__u32 flags;
+	domid_t dom;
+	__u8 pad[2];
+};
+
 /*
  * @cmd: IOCTL_PRIVCMD_HYPERCALL
  * @arg: &privcmd_hypercall_t
@@ -139,5 +155,7 @@ struct privcmd_irqfd {
 	_IOC(_IOC_NONE, 'P', 7, sizeof(struct privcmd_mmap_resource))
 #define IOCTL_PRIVCMD_IRQFD					\
 	_IOC(_IOC_NONE, 'P', 8, sizeof(struct privcmd_irqfd))
+#define IOCTL_PRIVCMD_IOEVENTFD					\
+	_IOC(_IOC_NONE, 'P', 9, sizeof(struct privcmd_ioeventfd))
 
 #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
diff --git a/include/xen/interface/hvm/ioreq.h b/include/xen/interface/hvm/ioreq.h
new file mode 100644
index 000000000000..b02cfeae7eb5
--- /dev/null
+++ b/include/xen/interface/hvm/ioreq.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * ioreq.h: I/O request definitions for device models
+ * Copyright (c) 2004, Intel Corporation.
+ */
+
+#ifndef __XEN_PUBLIC_HVM_IOREQ_H__
+#define __XEN_PUBLIC_HVM_IOREQ_H__
+
+#define IOREQ_READ      1
+#define IOREQ_WRITE     0
+
+#define STATE_IOREQ_NONE        0
+#define STATE_IOREQ_READY       1
+#define STATE_IOREQ_INPROCESS   2
+#define STATE_IORESP_READY      3
+
+#define IOREQ_TYPE_PIO          0 /* pio */
+#define IOREQ_TYPE_COPY         1 /* mmio ops */
+#define IOREQ_TYPE_PCI_CONFIG   2
+#define IOREQ_TYPE_TIMEOFFSET   7
+#define IOREQ_TYPE_INVALIDATE   8 /* mapcache */
+
+/*
+ * VMExit dispatcher should cooperate with instruction decoder to
+ * prepare this structure and notify service OS and DM by sending
+ * virq.
+ *
+ * For I/O type IOREQ_TYPE_PCI_CONFIG, the physical address is formatted
+ * as follows:
+ *
+ * 63....48|47..40|39..35|34..32|31........0
+ * SEGMENT |BUS   |DEV   |FN    |OFFSET
+ */
+struct ioreq {
+	uint64_t addr;          /* physical address */
+	uint64_t data;          /* data (or paddr of data) */
+	uint32_t count;         /* for rep prefixes */
+	uint32_t size;          /* size in bytes */
+	uint32_t vp_eport;      /* evtchn for notifications to/from device model */
+	uint16_t _pad0;
+	uint8_t state:4;
+	uint8_t data_is_ptr:1;  /* if 1, data above is the guest paddr
+				 * of the real data to use. */
+	uint8_t dir:1;          /* 1=read, 0=write */
+	uint8_t df:1;
+	uint8_t _pad1:1;
+	uint8_t type;           /* I/O type */
+};
+
+#endif /* __XEN_PUBLIC_HVM_IOREQ_H__ */
-- 
2.31.1.272.g89b43f80a514

