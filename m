Return-Path: <linux-kernel+bounces-1874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8D8815514
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CD3D1C24813
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4631E6FCD;
	Sat, 16 Dec 2023 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ho5R1vYp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D9C2564;
	Sat, 16 Dec 2023 00:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BG0DSPq008061;
	Sat, 16 Dec 2023 00:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=UMQK/jqI+zZBCX1hsbfmt3S4BKDtl7KD+PCoeHmQrA8
	=; b=Ho5R1vYppdUkY6bpGHzifHG49ABnTX81t3d2r5jmAvFZQeL8nOtfH/BlNLV
	nOFtfBKmdcdZwBLwFF6HZYAl4o/qgg2TbAmOi4ysT84N/YLF3/i4UsfZ0m8AwYTY
	Ohdmga8sxOlUlpahSMCfk+GTjQibi+2hb/b33yYYjZZvCGm2X/SDRoWPgvg8VtY0
	QY6LdzOhwGAiRrEv8lRzudo5Ay80hzUxMXqv9MaHKZbFVta7ZF104hruFAiaNDOl
	WQe4XISJb312apLLlp80sdD6w3SJ79Poq0gGyL8/ZkEn392otyNYGRzNVlAhdq6y
	YdIE9aQ+dzVJxRBSEafrIy5rQdg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0k90t5ea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0L67r016515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:06 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:05 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:20:50 -0800
Subject: [PATCH RFC v15 09/30] gunyah: vm_mgr: Introduce basic VM Manager
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-9-192a5d872a30@quicinc.com>
References: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
In-Reply-To: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
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
        Sean Christopherson <seanjc@google.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vh0_MAp-vZpZcMm-i162IpOByC_-xZqr
X-Proofpoint-GUID: vh0_MAp-vZpZcMm-i162IpOByC_-xZqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

Gunyah VM manager is a kernel moduel which exposes an interface to
Gunyah userspace to load, run, and interact with other Gunyah virtual
machines. The interface is a character device at /dev/gunyah.

Add a basic VM manager driver. Upcoming patches will add more ioctls
into this driver.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-by: Alex Elder <elder@linaro.org>
Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst |  1 +
 drivers/virt/gunyah/Makefile                       |  2 +-
 drivers/virt/gunyah/rsc_mgr.c                      | 51 ++++++++++++
 drivers/virt/gunyah/vm_mgr.c                       | 94 ++++++++++++++++++++++
 drivers/virt/gunyah/vm_mgr.h                       | 22 +++++
 include/uapi/linux/gunyah.h                        | 23 ++++++
 6 files changed, 192 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index d8b6cb1a3636..91e01925a41b 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -137,6 +137,7 @@ Code  Seq#    Include File                                           Comments
 'F'   DD     video/sstfb.h                                           conflict!
 'G'   00-3F  drivers/misc/sgi-gru/grulib.h                           conflict!
 'G'   00-0F  xen/gntalloc.h, xen/gntdev.h                            conflict!
+'G'   00-0F  linux/gunyah.h                                          conflict!
 'H'   00-7F  linux/hiddev.h                                          conflict!
 'H'   00-0F  linux/hidraw.h                                          conflict!
 'H'   01     linux/mei.h                                             conflict!
diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
index b1bdf3e84155..47f1fae5419b 100644
--- a/drivers/virt/gunyah/Makefile
+++ b/drivers/virt/gunyah/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o vm_mgr.o
 
 obj-$(CONFIG_GUNYAH) += gunyah.o gunyah_rsc_mgr.o
diff --git a/drivers/virt/gunyah/rsc_mgr.c b/drivers/virt/gunyah/rsc_mgr.c
index 2f9afe167aa6..052b3f072a85 100644
--- a/drivers/virt/gunyah/rsc_mgr.c
+++ b/drivers/virt/gunyah/rsc_mgr.c
@@ -15,8 +15,10 @@
 #include <linux/completion.h>
 #include <linux/gunyah_rsc_mgr.h>
 #include <linux/platform_device.h>
+#include <linux/miscdevice.h>
 
 #include "rsc_mgr.h"
+#include "vm_mgr.h"
 
 /* clang-format off */
 #define RM_RPC_API_VERSION_MASK		GENMASK(3, 0)
@@ -126,6 +128,7 @@ struct gunyah_rm_message {
  * @send_lock: synchronization to allow only one request to be sent at a time
  * @send_ready: completion to send messages again
  * @nh: notifier chain for clients interested in RM notification messages
+ * @miscdev: /dev/gunyah
  */
 struct gunyah_rm {
 	struct device *dev;
@@ -142,6 +145,8 @@ struct gunyah_rm {
 	struct mutex send_lock;
 	struct completion send_ready;
 	struct blocking_notifier_head nh;
+
+	struct miscdevice miscdev;
 };
 
 /**
@@ -618,6 +623,36 @@ int gunyah_rm_notifier_unregister(struct gunyah_rm *rm,
 }
 EXPORT_SYMBOL_GPL(gunyah_rm_notifier_unregister);
 
+struct device *gunyah_rm_get(struct gunyah_rm *rm)
+{
+	return get_device(rm->miscdev.this_device);
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_get);
+
+void gunyah_rm_put(struct gunyah_rm *rm)
+{
+	put_device(rm->miscdev.this_device);
+}
+EXPORT_SYMBOL_GPL(gunyah_rm_put);
+
+static long gunyah_dev_ioctl(struct file *filp, unsigned int cmd,
+			     unsigned long arg)
+{
+	struct miscdevice *miscdev = filp->private_data;
+	struct gunyah_rm *rm = container_of(miscdev, struct gunyah_rm, miscdev);
+
+	return gunyah_dev_vm_mgr_ioctl(rm, cmd, arg);
+}
+
+static const struct file_operations gunyah_dev_fops = {
+	/* clang-format off */
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= gunyah_dev_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
+	.llseek		= noop_llseek,
+	/* clang-format on */
+};
+
 static int gunyah_platform_probe_capability(struct platform_device *pdev,
 					    int idx,
 					    struct gunyah_resource *ghrsc)
@@ -703,9 +738,24 @@ static int gunyah_rm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	rm->miscdev.name = "gunyah";
+	rm->miscdev.minor = MISC_DYNAMIC_MINOR;
+	rm->miscdev.fops = &gunyah_dev_fops;
+
+	ret = misc_register(&rm->miscdev);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
+static void gunyah_rm_remove(struct platform_device *pdev)
+{
+	struct gunyah_rm *rm = platform_get_drvdata(pdev);
+
+	misc_deregister(&rm->miscdev);
+}
+
 static const struct of_device_id gunyah_rm_of_match[] = {
 	{ .compatible = "gunyah-resource-manager" },
 	{}
@@ -714,6 +764,7 @@ MODULE_DEVICE_TABLE(of, gunyah_rm_of_match);
 
 static struct platform_driver gunyah_rm_driver = {
 	.probe = gunyah_rm_probe,
+	.remove_new = gunyah_rm_remove,
 	.driver = {
 		.name = "gunyah_rsc_mgr",
 		.of_match_table = gunyah_rm_of_match,
diff --git a/drivers/virt/gunyah/vm_mgr.c b/drivers/virt/gunyah/vm_mgr.c
new file mode 100644
index 000000000000..b4d44379e5ce
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#define pr_fmt(fmt) "gunyah_vm_mgr: " fmt
+
+#include <linux/anon_inodes.h>
+#include <linux/file.h>
+#include <linux/gunyah_rsc_mgr.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+
+#include <uapi/linux/gunyah.h>
+
+#include "vm_mgr.h"
+
+static __must_check struct gunyah_vm *gunyah_vm_alloc(struct gunyah_rm *rm)
+{
+	struct gunyah_vm *ghvm;
+
+	ghvm = kzalloc(sizeof(*ghvm), GFP_KERNEL);
+	if (!ghvm)
+		return ERR_PTR(-ENOMEM);
+
+	ghvm->parent = gunyah_rm_get(rm);
+	ghvm->rm = rm;
+
+	return ghvm;
+}
+
+static int gunyah_vm_release(struct inode *inode, struct file *filp)
+{
+	struct gunyah_vm *ghvm = filp->private_data;
+
+	gunyah_rm_put(ghvm->rm);
+	kfree(ghvm);
+	return 0;
+}
+
+static const struct file_operations gunyah_vm_fops = {
+	.owner = THIS_MODULE,
+	.release = gunyah_vm_release,
+	.llseek = noop_llseek,
+};
+
+static long gunyah_dev_ioctl_create_vm(struct gunyah_rm *rm, unsigned long arg)
+{
+	struct gunyah_vm *ghvm;
+	struct file *file;
+	int fd, err;
+
+	/* arg reserved for future use. */
+	if (arg)
+		return -EINVAL;
+
+	ghvm = gunyah_vm_alloc(rm);
+	if (IS_ERR(ghvm))
+		return PTR_ERR(ghvm);
+
+	fd = get_unused_fd_flags(O_CLOEXEC);
+	if (fd < 0) {
+		err = fd;
+		goto err_destroy_vm;
+	}
+
+	file = anon_inode_getfile("gunyah-vm", &gunyah_vm_fops, ghvm, O_RDWR);
+	if (IS_ERR(file)) {
+		err = PTR_ERR(file);
+		goto err_put_fd;
+	}
+
+	fd_install(fd, file);
+
+	return fd;
+
+err_put_fd:
+	put_unused_fd(fd);
+err_destroy_vm:
+	gunyah_rm_put(ghvm->rm);
+	kfree(ghvm);
+	return err;
+}
+
+long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
+			     unsigned long arg)
+{
+	switch (cmd) {
+	case GUNYAH_CREATE_VM:
+		return gunyah_dev_ioctl_create_vm(rm, arg);
+	default:
+		return -ENOTTY;
+	}
+}
diff --git a/drivers/virt/gunyah/vm_mgr.h b/drivers/virt/gunyah/vm_mgr.h
new file mode 100644
index 000000000000..434a510e360f
--- /dev/null
+++ b/drivers/virt/gunyah/vm_mgr.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _GUNYAH_VM_MGR_PRIV_H
+#define _GUNYAH_VM_MGR_PRIV_H
+
+#include <linux/device.h>
+#include <linux/gunyah_rsc_mgr.h>
+
+#include <uapi/linux/gunyah.h>
+
+long gunyah_dev_vm_mgr_ioctl(struct gunyah_rm *rm, unsigned int cmd,
+			     unsigned long arg);
+
+struct gunyah_vm {
+	struct gunyah_rm *rm;
+	struct device *parent;
+};
+
+#endif
diff --git a/include/uapi/linux/gunyah.h b/include/uapi/linux/gunyah.h
new file mode 100644
index 000000000000..ac338ec4b85d
--- /dev/null
+++ b/include/uapi/linux/gunyah.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _UAPI_LINUX_GUNYAH_H
+#define _UAPI_LINUX_GUNYAH_H
+
+/*
+ * Userspace interface for /dev/gunyah - gunyah based virtual machine
+ */
+
+#include <linux/types.h>
+#include <linux/ioctl.h>
+
+#define GUNYAH_IOCTL_TYPE 'G'
+
+/*
+ * ioctls for /dev/gunyah fds:
+ */
+#define GUNYAH_CREATE_VM _IO(GUNYAH_IOCTL_TYPE, 0x0) /* Returns a Gunyah VM fd */
+
+#endif

-- 
2.43.0


