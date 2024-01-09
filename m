Return-Path: <linux-kernel+bounces-21332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66597828DC1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45B31F2734B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19293FB3A;
	Tue,  9 Jan 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bnceqlAr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662A83EA60;
	Tue,  9 Jan 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 409IeRwr005755;
	Tue, 9 Jan 2024 19:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=4qiqaM4jJd8zGHPZYjmgu0l1JblGJ6sPIsRdN2U0BMc
	=; b=bnceqlAru+3cNJwcaW3SUuwQZe81XenMVLM7ojxK3lszLcFa1xlkT9yQg6f
	wg/5uHBN6NJspj68vcNUgNeKW//jAVUQOh9ca6OTkR3M6ESp2mixPzDovwar7YXE
	3I5jV+1sRTXyFL8Hv0Nx4DV+yVmo6IIeg3eTEub2W5RZQnJ0pv6rEbCmP4Pj8+1I
	DoiPWetPG+dUQUnTmi4CgMuepnHvjOTjvhkcAdo26tZUg1B9DoRikGB2Mig9C8Cb
	ln4fpxDbwd9cg/8Em4p19BmwLo7tOJz346lmRnWzdFIZGNEiXmDTS+2VyXhxTfBq
	zCyOppkUcOSdqKVdIloy47IzoDw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vh98m8hqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 19:37:58 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 409Jbv3C030413
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jan 2024 19:37:57 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 9 Jan 2024 11:37:56 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 9 Jan 2024 11:37:50 -0800
Subject: [PATCH v16 12/34] virt: gunyah: Add resource tickets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240109-gunyah-v16-12-634904bf4ce9@quicinc.com>
References: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
In-Reply-To: <20240109-gunyah-v16-0-634904bf4ce9@quicinc.com>
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -_URcr59O8AG3f6gWqPnDYkWBNleK7zF
X-Proofpoint-GUID: -_URcr59O8AG3f6gWqPnDYkWBNleK7zF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401090158

Some VM functions need to acquire Gunyah resources. For instance, Gunyah
vCPUs are exposed to the host as a resource. The Gunyah vCPU function
will register a resource ticket and be able to interact with the
hypervisor once the resource ticket is filled.

Resource tickets are the mechanism for functions to acquire ownership of
Gunyah resources. Gunyah functions can be created before the VM's
resources are created and made available to Linux. A resource ticket
identifies a type of resource and a label of a resource which the ticket
holder is interested in.

Resources are created by Gunyah as configured in the VM's devicetree
configuration. Gunyah doesn't process the label and that makes it
possible for userspace to create multiple resources with the same label.
Resource ticket owners need to be prepared for populate to be called
multiple times if userspace created multiple resources with the same
label.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 drivers/virt/gunyah/vm_mgr.c | 128 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/virt/gunyah/vm_mgr.h |   7 +++
 include/linux/gunyah.h       |  39 +++++++++++++
 3 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
index f6e6b5669aae..65badcf6357b 100644
--- a/drivers/virt/gunyah/vm_mgr.c
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -15,6 +15,106 @@
 #include "rsc_mgr.h"
 #include "vm_mgr.h"
 
+int gunyah_vm_add_resource_ticket(struct gunyah_vm *ghvm,
+				  struct gunyah_vm_resource_ticket *ticket)
+{
+	struct gunyah_vm_resource_ticket *iter;
+	struct gunyah_resource *ghrsc, *rsc_iter;
+	int ret = 0;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry(iter, &ghvm->resource_tickets, vm_list) {
+		if (iter->resource_type == ticket->resource_type &&
+		    iter->label == ticket->label) {
+			ret = -EEXIST;
+			goto out;
+		}
+	}
+
+	if (!try_module_get(ticket->owner)) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	list_add(&ticket->vm_list, &ghvm->resource_tickets);
+	INIT_LIST_HEAD(&ticket->resources);
+
+	list_for_each_entry_safe(ghrsc, rsc_iter, &ghvm->resources, list) {
+		if (ghrsc->type == ticket->resource_type &&
+		    ghrsc->rm_label == ticket->label) {
+			if (ticket->populate(ticket, ghrsc))
+				list_move(&ghrsc->list, &ticket->resources);
+		}
+	}
+out:
+	mutex_unlock(&ghvm->resources_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_add_resource_ticket);
+
+void gunyah_vm_remove_resource_ticket(struct gunyah_vm *ghvm,
+				      struct gunyah_vm_resource_ticket *ticket)
+{
+	struct gunyah_resource *ghrsc, *iter;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry_safe(ghrsc, iter, &ticket->resources, list) {
+		ticket->unpopulate(ticket, ghrsc);
+		list_move(&ghrsc->list, &ghvm->resources);
+	}
+
+	module_put(ticket->owner);
+	list_del(&ticket->vm_list);
+	mutex_unlock(&ghvm->resources_lock);
+}
+EXPORT_SYMBOL_GPL(gunyah_vm_remove_resource_ticket);
+
+static void gunyah_vm_add_resource(struct gunyah_vm *ghvm,
+				   struct gunyah_resource *ghrsc)
+{
+	struct gunyah_vm_resource_ticket *ticket;
+
+	mutex_lock(&ghvm->resources_lock);
+	list_for_each_entry(ticket, &ghvm->resource_tickets, vm_list) {
+		if (ghrsc->type == ticket->resource_type &&
+		    ghrsc->rm_label == ticket->label) {
+			if (ticket->populate(ticket, ghrsc))
+				list_add(&ghrsc->list, &ticket->resources);
+			else
+				list_add(&ghrsc->list, &ghvm->resources);
+			/* unconditonal -- we prevent multiple identical
+			 * resource tickets so there will not be some other
+			 * ticket elsewhere in the list if populate() failed.
+			 */
+			goto found;
+		}
+	}
+	list_add(&ghrsc->list, &ghvm->resources);
+found:
+	mutex_unlock(&ghvm->resources_lock);
+}
+
+static void gunyah_vm_clean_resources(struct gunyah_vm *ghvm)
+{
+	struct gunyah_vm_resource_ticket *ticket, *titer;
+	struct gunyah_resource *ghrsc, *riter;
+
+	mutex_lock(&ghvm->resources_lock);
+	if (!list_empty(&ghvm->resource_tickets)) {
+		dev_warn(ghvm->parent, "Dangling resource tickets:\n");
+		list_for_each_entry_safe(ticket, titer, &ghvm->resource_tickets,
+					 vm_list) {
+			dev_warn(ghvm->parent, "  %pS\n", ticket->populate);
+			gunyah_vm_remove_resource_ticket(ghvm, ticket);
+		}
+	}
+
+	list_for_each_entry_safe(ghrsc, riter, &ghvm->resources, list) {
+		gunyah_rm_free_resource(ghrsc);
+	}
+	mutex_unlock(&ghvm->resources_lock);
+}
+
 static int gunyah_vm_rm_notification_status(struct gunyah_vm *ghvm, void *data)
 {
 	struct gunyah_rm_vm_status_payload *payload = data;
@@ -92,13 +192,18 @@ static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
 	init_rwsem(&ghvm->status_lock);
 	init_waitqueue_head(&ghvm->vm_status_wait);
 	ghvm->vm_status = GUNYAH_RM_VM_STATUS_NO_STATE;
+	mutex_init(&ghvm->resources_lock);
+	INIT_LIST_HEAD(&ghvm->resources);
+	INIT_LIST_HEAD(&ghvm->resource_tickets);
 
 	return ghvm;
 }
 
 static int gunyah_vm_start(struct gunyah_vm *ghvm)
 {
-	int ret;
+	struct gunyah_rm_hyp_resources *resources;
+	struct gunyah_resource *ghrsc;
+	int ret, i, n;
 
 	down_write(&ghvm->status_lock);
 	if (ghvm->vm_status != GUNYAH_RM_VM_STATUS_NO_STATE) {
@@ -134,6 +239,25 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
 	}
 	ghvm->vm_status = GUNYAH_RM_VM_STATUS_READY;
 
+	ret = gunyah_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
+	if (ret) {
+		dev_warn(ghvm->parent,
+			 "Failed to get hypervisor resources for VM: %d\n",
+			 ret);
+		goto err;
+	}
+
+	for (i = 0, n = le32_to_cpu(resources->n_entries); i < n; i++) {
+		ghrsc = gunyah_rm_alloc_resource(ghvm->rm,
+						 &resources->entries[i]);
+		if (!ghrsc) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		gunyah_vm_add_resource(ghvm, ghrsc);
+	}
+
 	ret = gunyah_rm_vm_start(ghvm->rm, ghvm->vmid);
 	if (ret) {
 		dev_warn(ghvm->parent, "Failed to start VM: %d\n", ret);
@@ -209,6 +333,8 @@ static int gunyah_vm_release(struct inode *inode, struct file *filp)
 	if (ghvm->vm_status == GUNYAH_RM_VM_STATUS_RUNNING)
 		gunyah_vm_stop(ghvm);
 
+	gunyah_vm_clean_resources(ghvm);
+
 	if (ghvm->vm_status != GUNYAH_RM_VM_STATUS_NO_STATE &&
 	    ghvm->vm_status != GUNYAH_RM_VM_STATUS_LOAD &&
 	    ghvm->vm_status != GUNYAH_RM_VM_STATUS_RESET) {
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
index e6cc9aead0b6..0d291f722885 100644
--- a/drivers/virt/gunyah/vm_mgr.h
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -26,6 +26,9 @@ long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
  * @vm_status: Current state of the VM, as last reported by RM
  * @vm_status_wait: Wait queue for status @vm_status changes
  * @status_lock: Serializing state transitions
+ * @resource_lock: Serializing addition of resources and resource tickets
+ * @resources: List of &struct gunyah_resource that are associated with this VM
+ * @resource_tickets: List of &struct gunyah_vm_resource_ticket
  * @auth: Authentication mechanism to be used by resource manager when
  *        launching the VM
  *
@@ -39,9 +42,13 @@ struct gunyah_vm {
 	enum gunyah_rm_vm_status vm_status;
 	wait_queue_head_t vm_status_wait;
 	struct rw_semaphore status_lock;
+	struct mutex resources_lock;
+	struct list_head resources;
+	struct list_head resource_tickets;
 
 	struct device *parent;
 	enum gunyah_rm_vm_auth_mechanism auth;
+
 };
 
 #endif
diff --git a/include/linux/gunyah.h b/include/linux/gunyah.h
index ede8abb1b276..001769100260 100644
--- a/include/linux/gunyah.h
+++ b/include/linux/gunyah.h
@@ -10,6 +10,7 @@
 #include <linux/errno.h>
 #include <linux/interrupt.h>
 #include <linux/limits.h>
+#include <linux/list.h>
 #include <linux/types.h>
 
 /* Matches resource manager's resource types for VM_GET_HYP_RESOURCES RPC */
@@ -34,6 +35,44 @@ struct gunyah_resource {
 	u32 rm_label;
 };
 
+struct gunyah_vm;
+
+/**
+ * struct gunyah_vm_resource_ticket - Represents a ticket to reserve access to VM resource(s)
+ * @vm_list: for @gunyah_vm->resource_tickets
+ * @resources: List of resource(s) associated with this ticket
+ *             (members are from @gunyah_resource->list)
+ * @resource_type: Type of resource this ticket reserves
+ * @label: Label of the resource from resource manager this ticket reserves.
+ * @owner: owner of the ticket
+ * @populate: callback provided by the ticket owner and called when a resource is found that
+ *            matches @resource_type and @label. Note that this callback could be called
+ *            multiple times if userspace created mutliple resources with the same type/label.
+ *            This callback may also have significant delay after gunyah_vm_add_resource_ticket()
+ *            since gunyah_vm_add_resource_ticket() could be called before the VM starts.
+ * @unpopulate: callback provided by the ticket owner and called when the ticket owner should no
+ *              longer use the resource provided in the argument. When unpopulate() returns,
+ *              the ticket owner should not be able to use the resource any more as the resource
+ *              might being freed.
+ */
+struct gunyah_vm_resource_ticket {
+	struct list_head vm_list;
+	struct list_head resources;
+	enum gunyah_resource_type resource_type;
+	u32 label;
+
+	struct module *owner;
+	bool (*populate)(struct gunyah_vm_resource_ticket *ticket,
+			 struct gunyah_resource *ghrsc);
+	void (*unpopulate)(struct gunyah_vm_resource_ticket *ticket,
+			   struct gunyah_resource *ghrsc);
+};
+
+int gunyah_vm_add_resource_ticket(struct gunyah_vm *ghvm,
+				  struct gunyah_vm_resource_ticket *ticket);
+void gunyah_vm_remove_resource_ticket(struct gunyah_vm *ghvm,
+				      struct gunyah_vm_resource_ticket *ticket);
+
 /******************************************************************************/
 /* Common arch-independent definitions for Gunyah hypercalls                  */
 #define GUNYAH_CAPID_INVAL U64_MAX

-- 
2.34.1


