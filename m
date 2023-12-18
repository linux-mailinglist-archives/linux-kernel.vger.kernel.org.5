Return-Path: <linux-kernel+bounces-4042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E83817710
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 652AF1F269A5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6E942379;
	Mon, 18 Dec 2023 16:11:56 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE95B3D56F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0AA5C21FDE;
	Mon, 18 Dec 2023 16:11:50 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E839C13BD5;
	Mon, 18 Dec 2023 16:11:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 7/GGNkVvgGUVBQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 16:11:49 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 17/17] nvmet-fc: add extensive debug logging
Date: Mon, 18 Dec 2023 16:31:05 +0100
Message-ID: <20231218153105.12717-18-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
References: <20231218153105.12717-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 0AA5C21FDE
X-Spam-Flag: NO

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/configfs.c |   4 +
 drivers/nvme/target/core.c     |  13 ++++
 drivers/nvme/target/fc.c       | 132 +++++++++++++++++++++++++++++----
 3 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e307a044b1a1..ea05e8c62d4b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -965,6 +965,7 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 			goto out_free_link;
 	}
 
+	pr_info("%s: %s\n", __func__, subsys->subsysnqn);
 	if (list_empty(&port->subsystems)) {
 		ret = nvmet_enable_port(port);
 		if (ret)
@@ -1050,6 +1051,7 @@ static int nvmet_allowed_hosts_allow_link(struct config_item *parent,
 		if (!strcmp(nvmet_host_name(p->host), nvmet_host_name(host)))
 			goto out_free_link;
 	}
+	pr_info("%s: adding hostnqn %s\n", __func__, nvmet_host_name(host));
 	list_add_tail(&link->entry, &subsys->hosts);
 	nvmet_subsys_disc_changed(subsys, host);
 
@@ -1879,6 +1881,8 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	u16 portid;
 	u32 i;
 
+	pr_info("%s\n", __func__);
+
 	if (kstrtou16(name, 0, &portid))
 		return ERR_PTR(-EINVAL);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165048e7..4d5a9e4fcc9d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -308,8 +308,11 @@ void nvmet_port_del_ctrls(struct nvmet_port *port, struct nvmet_subsys *subsys)
 {
 	struct nvmet_ctrl *ctrl;
 
+	pr_info("%s: subsys %s port %p\n", __func__, subsys->subsysnqn, port);
+
 	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		pr_info("%s: ctrl %p ctrl->port %p\n", __func__, ctrl, ctrl->port);
 		if (ctrl->port == port)
 			ctrl->ops->delete_ctrl(ctrl);
 	}
@@ -1458,6 +1461,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	mutex_unlock(&subsys->lock);
 
 	*ctrlp = ctrl;
+
+	pr_info("%s: ctrl %p, subsysnqn %s hostnqn %s\n", __func__, ctrl, subsysnqn, hostnqn);
 	return 0;
 
 out_free_sqs:
@@ -1477,6 +1482,8 @@ static void nvmet_ctrl_free(struct kref *ref)
 	struct nvmet_ctrl *ctrl = container_of(ref, struct nvmet_ctrl, ref);
 	struct nvmet_subsys *subsys = ctrl->subsys;
 
+	pr_info("%s: ctrl %p %s\n", __func__, ctrl, ctrl->subsysnqn);
+
 	mutex_lock(&subsys->lock);
 	nvmet_release_p2p_ns_map(ctrl);
 	list_del(&ctrl->subsys_entry);
@@ -1550,6 +1557,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	char serial[NVMET_SN_MAX_SIZE / 2];
 	int ret;
 
+	pr_info("%s\n", __func__);
+
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return ERR_PTR(-ENOMEM);
@@ -1620,6 +1629,8 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	WARN_ON_ONCE(!xa_empty(&subsys->namespaces));
 
+	pr_info("%s\n", __func__);
+
 	xa_destroy(&subsys->namespaces);
 	nvmet_passthru_subsys_free(subsys);
 
@@ -1633,6 +1644,8 @@ void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys)
 {
 	struct nvmet_ctrl *ctrl;
 
+	pr_info("%s\n", __func__);
+
 	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		ctrl->ops->delete_ctrl(ctrl);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 455d35ef97eb..d50ff29697fc 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -242,6 +242,31 @@ static LIST_HEAD(nvmet_fc_target_list);
 static DEFINE_IDA(nvmet_fc_tgtport_cnt);
 static LIST_HEAD(nvmet_fc_portentry_list);
 
+static void __nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static int __nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
+
+#if 1
+#define nvmet_fc_tgtport_put(p)						\
+({									\
+	pr_info("nvmet_fc_tgtport_put: %p %d %s:%d\n",	\
+		p, atomic_read(&p->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	__nvmet_fc_tgtport_put(p);					\
+})
+
+#define nvmet_fc_tgtport_get(p)						\
+({									\
+	int ___r = __nvmet_fc_tgtport_get(p);				\
+									\
+	pr_info("nvmet_fc_tgtport_get: %p %d %s:%d\n",			\
+		p, atomic_read(&p->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	___r;								\
+})
+#else
+#define nvmet_fc_tgtport_put(p) __nvmet_fc_tgtport_put(p)
+#define nvmet_fc_tgtport_get(p) __nvmet_fc_tgtport_get(p)
+#endif
 
 static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
 static void nvmet_fc_fcp_rqst_op_defer_work(struct work_struct *work);
@@ -252,12 +277,84 @@ static void nvmet_fc_put_tgtport_work(struct work_struct *work)
 
 	nvmet_fc_tgtport_put(tgtport);
 }
-static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
-static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
-static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
-static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
-static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
-static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
+static void __nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
+static int __nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
+
+#if 1
+#define nvmet_fc_tgt_a_put(a)						\
+({									\
+	pr_info("nvmet_fc_tgt_a_put: %d %d %s:%d \n",			\
+		a->a_id, atomic_read(&a->ref.refcount.refs),		\
+		__func__, __LINE__);					\
+	__nvmet_fc_tgt_a_put(a);					\
+})
+
+#define nvmet_fc_tgt_a_get(a)						\
+({									\
+	int ___r = __nvmet_fc_tgt_a_get(a);				\
+									\
+	pr_info("nvmet_fc_tgt_a_get: %d %d %s:%d\n",			\
+		a->a_id, atomic_read(&a->ref.refcount.refs),		\
+		__func__, __LINE__);					\
+	___r;								\
+})
+#else
+#define nvmet_fc_tgt_a_put(a) __nvmet_fc_tgt_a_put(a)
+#define nvmet_fc_tgt_a_get(a) __nvmet_fc_tgt_a_get(a)
+#endif
+
+static void __nvmet_fc_hostport_put(struct nvmet_fc_hostport *hostport);
+static int __nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport);
+
+#if 0
+#define nvmet_fc_hostport_put(p)					\
+({									\
+	pr_info("nvmet_fc_hostport_put: %p %d %s:%d\n",			\
+		p, atomic_read(&p->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	__nvmet_fc_hostport_put(p);					\
+})
+
+#define nvmet_fc_hostport_get(p)					\
+({									\
+	int ___r = __nvmet_fc_hostport_get(p);				\
+									\
+	pr_info("nvmet_fc_hostport_get: %p %d %s:%d\n",			\
+		p, atomic_read(&p->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	___r;								\
+})
+#else
+#define nvmet_fc_hostport_put(p) __nvmet_fc_hostport_put(p)
+#define nvmet_fc_hostport_get(p) __nvmet_fc_hostport_get(p)
+#endif
+
+static void __nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
+static int __nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
+
+#if 0
+#define nvmet_fc_tgt_q_put(q)						\
+({									\
+	pr_info("nvmet_fc_tgt_q_put: %p %d %s:%d\n",			\
+		q, atomic_read(&q->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	__nvmet_fc_tgt_q_put(q);					\
+})
+
+#define nvmet_fc_tgt_q_get(q)						\
+({									\
+	int ___r = __nvmet_fc_tgt_q_get(q);				\
+									\
+	pr_info("nvmet_fc_tgt_q_get: %p %d %s:%d\n",			\
+		q, atomic_read(&q->ref.refcount.refs),			\
+		__func__, __LINE__);					\
+	___r;								\
+})
+#else
+#define nvmet_fc_tgt_q_put(q) __nvmet_fc_tgt_q_put(q)
+#define nvmet_fc_tgt_q_get(q) __nvmet_fc_tgt_q_get(q)
+#endif
+
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 					struct nvmet_fc_fcp_iod *fod);
 static void nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc);
@@ -864,13 +961,13 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
 }
 
 static void
-nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue)
+__nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue)
 {
 	kref_put(&queue->ref, nvmet_fc_tgt_queue_free);
 }
 
 static int
-nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue)
+__nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue)
 {
 	return kref_get_unless_zero(&queue->ref);
 }
@@ -1000,13 +1097,13 @@ nvmet_fc_hostport_free(struct kref *ref)
 }
 
 static void
-nvmet_fc_hostport_put(struct nvmet_fc_hostport *hostport)
+__nvmet_fc_hostport_put(struct nvmet_fc_hostport *hostport)
 {
 	kref_put(&hostport->ref, nvmet_fc_hostport_free);
 }
 
 static int
-nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport)
+__nvmet_fc_hostport_get(struct nvmet_fc_hostport *hostport)
 {
 	return kref_get_unless_zero(&hostport->ref);
 }
@@ -1208,13 +1305,13 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 }
 
 static void
-nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc)
+__nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc)
 {
 	kref_put(&assoc->ref, nvmet_fc_target_assoc_free);
 }
 
 static int
-nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc)
+__nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc)
 {
 	return kref_get_unless_zero(&assoc->ref);
 }
@@ -1441,6 +1538,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
 
 	*portptr = &newrec->fc_target_port;
+	pr_info("%s: targetport %p\n", __func__, newrec);
 	return 0;
 
 out_free_newrec:
@@ -1484,13 +1582,13 @@ nvmet_fc_free_tgtport(struct kref *ref)
 }
 
 static void
-nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport)
+__nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport)
 {
 	kref_put(&tgtport->ref, nvmet_fc_free_tgtport);
 }
 
 static int
-nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport)
+__nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport)
 {
 	return kref_get_unless_zero(&tgtport->ref);
 }
@@ -1580,6 +1678,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 	unsigned long flags;
 	bool found_ctrl = false;
 
+	pr_info("%s: ctrl %p\n", __func__, ctrl);
+
 	/* this is a bit ugly, but don't want to make locks layered */
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	list_for_each_entry_safe(tgtport, next, &nvmet_fc_target_list,
@@ -1591,6 +1691,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		rcu_read_lock();
 		list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 			queue = rcu_dereference(assoc->queues[0]);
+			pr_info("%s: queue %p nvme_sq.ctrl %p\n",
+				__func__, queue, queue ? queue->nvme_sq.ctrl : NULL);
 			if (queue && queue->nvme_sq.ctrl == ctrl) {
 				if (nvmet_fc_tgt_a_get(assoc))
 					found_ctrl = true;
@@ -1628,6 +1730,8 @@ nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *target_port)
 {
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
 
+	pr_info("%s\n", __func__);
+
 	nvmet_fc_portentry_unbind_tgt(tgtport);
 
 	/* terminate any outstanding associations */
-- 
2.43.0


