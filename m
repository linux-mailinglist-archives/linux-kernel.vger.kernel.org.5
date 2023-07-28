Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19615766E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 15:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbjG1N0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 09:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbjG1NZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 09:25:47 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC213C0E;
        Fri, 28 Jul 2023 06:25:41 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36S9Kvwh008893;
        Fri, 28 Jul 2023 13:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=EQfSBwVm5bdEIOc5Ahjtgrz9Ih3JfIovxU7G0xvUu18=;
 b=FsYInNXQypkopB+ZI3wp3aExoFWvbSF7DdD+W8FDC8IUPy4x/d4zlWFzViOGKAoJE1PE
 CyNQBlfu9LW5Rbj3cK8+mNuQc8sUM5WLAxN6kfALfqlS1dhMHs3fWLB4ehSzOfV75VsA
 7hX+ewZeTj55k4XzqlkpO2loeefbtZGUdIAobOvclBKuisSMBzuepuGZtvq4F0c850A5
 V7NUewwnIEGjCzsejpSS8U7sUO/j4UT6aaKVhlD9CUUS9W/n/0h0pJwuXERccuGDkupd
 je1HMyw3B2z1OWCljDlc18MWhdx0kxo2I44/f/ipciNOMzatEAju0wB1ShacRMoQ23y3 nA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s447kh7t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:25:32 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36SDPVfl013529
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jul 2023 13:25:31 GMT
Received: from hu-vgarodia-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 28 Jul 2023 06:25:28 -0700
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
To:     <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Subject: [PATCH 06/33] iris: vidc: define video core and instance context
Date:   Fri, 28 Jul 2023 18:53:17 +0530
Message-ID: <1690550624-14642-7-git-send-email-quic_vgarodia@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zplgZJDMlLmfsWwq9FCnM2yhVC1yfXfU
X-Proofpoint-GUID: zplgZJDMlLmfsWwq9FCnM2yhVC1yfXfU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280124
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements video core and instance context structure and
associated core and session ops.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
---
 .../platform/qcom/iris/vidc/inc/msm_vidc_core.h    | 165 ++++++++++++++++
 .../platform/qcom/iris/vidc/inc/msm_vidc_inst.h    | 207 +++++++++++++++++++++
 2 files changed, 372 insertions(+)
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_core.h
 create mode 100644 drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_inst.h

diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_core.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_core.h
new file mode 100644
index 0000000..cd8804ff
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_core.h
@@ -0,0 +1,165 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _MSM_VIDC_CORE_H_
+#define _MSM_VIDC_CORE_H_
+
+#include <linux/platform_device.h>
+
+#include "msm_vidc_internal.h"
+#include "msm_vidc_state.h"
+#include "resources.h"
+#include "venus_hfi_queue.h"
+
+#define MAX_EVENTS   30
+
+#define call_iris_op(d, op, ...)			\
+	(((d) && (d)->iris_ops && (d)->iris_ops->op) ? \
+	((d)->iris_ops->op(__VA_ARGS__)) : 0)
+
+struct msm_vidc_iris_ops {
+	int (*boot_firmware)(struct msm_vidc_core *core);
+	int (*raise_interrupt)(struct msm_vidc_core *core);
+	int (*clear_interrupt)(struct msm_vidc_core *core);
+	int (*prepare_pc)(struct msm_vidc_core *core);
+	int (*power_on)(struct msm_vidc_core *core);
+	int (*power_off)(struct msm_vidc_core *core);
+	int (*watchdog)(struct msm_vidc_core *core, u32 intr_status);
+};
+
+struct msm_vidc_mem_addr {
+	u32 align_device_addr;
+	u8 *align_virtual_addr;
+	u32 mem_size;
+	struct msm_vidc_mem mem;
+};
+
+struct msm_vidc_iface_q_info {
+	void *q_hdr;
+	struct msm_vidc_mem_addr q_array;
+};
+
+struct msm_video_device {
+	enum msm_vidc_domain_type              type;
+	struct video_device                    vdev;
+	struct v4l2_m2m_dev                   *m2m_dev;
+};
+
+struct msm_vidc_core_power {
+	u64 clk_freq;
+	u64 bw_ddr;
+	u64 bw_llcc;
+};
+
+/**
+ * struct msm_vidc_core - holds core parameters valid for all instances
+ *
+ * @pdev: refernce to platform device structure
+ * @vdev: a reference to video device structure for encoder & decoder instances
+ * @v4l2_dev : a holder for v4l2 device structure
+ * @instances: a list_head of all instances
+ * @dangling_instances : a list_head of all dangling instances
+ * @debugfs_parent: debugfs node for msm_vidc
+ * @debugfs_root: debugfs node for core info
+ * @fw_version: a holder for fw version
+ * @state: a structure of core states
+ * @state_handle: a handler for core state change
+ * @sub_state: enumeration of core substate
+ * @sub_state_name: holder for core substate name
+ * @lock: a lock for this strucure
+ * @resources: a structure for core resources
+ * @platform: a structure for platform data
+ * @intr_status: interrupt status
+ * @spur_count: counter for spurious interrupt
+ * @reg_count: counter for interrupts
+ * @enc_codecs_count: encoder codec count
+ * @dec_codecs_count: decoder codec count
+ * @capabilities: an array for supported core capabilities
+ * @inst_caps: a pointer to supported instance capabilities
+ * @sfr: SFR register memory
+ * @iface_q_table: Interface queue table memory
+ * @iface_queues: a array of interface queues info
+ * @pm_work: delayed work to handle power collapse
+ * @pm_workq: workqueue for power collapse work
+ * @batch_workq: workqueue for batching
+ * @fw_unload_work: delayed work for fw unload
+ * @power: a sturture for core power
+ * @skip_pc_count: a counter for skipped power collpase
+ * @last_packet_type: holder for last packet type info
+ * @packet: pointer to packet from driver to fw
+ * @packet_size: size of packet
+ * @response_packet: a pointer to response packet from fw to driver
+ * @v4l2_file_ops: a pointer to v4l2 file ops
+ * @v4l2_ioctl_ops_enc: a pointer to v4l2 ioctl ops for encoder
+ * @v4l2_ioctl_ops_dec: a pointer to v4l2 ioclt ops for decoder
+ * @v4l2_ctrl_ops: a pointer to v4l2 control ops
+ * @vb2_ops: a pointer to vb2 ops
+ * @vb2_mem_ops: a pointer to vb2 memory ops
+ * @v4l2_m2m_ops: a pointer to v4l2_mem ops
+ * @iris_ops: a pointer to iris ops
+ * @res_ops: a pointer to resource management ops
+ * @session_ops: a pointer to session level ops
+ * @mem_ops: a pointer to memory management ops
+ * @header_id: id of packet header
+ * @packet_id: id of packet
+ * @sys_init_id: id of sys init packet
+ */
+
+struct msm_vidc_core {
+	struct platform_device                *pdev;
+	struct msm_video_device                vdev[2];
+	struct v4l2_device                     v4l2_dev;
+	struct list_head                       instances;
+	struct list_head                       dangling_instances;
+	struct dentry                         *debugfs_parent;
+	struct dentry                         *debugfs_root;
+	char                                   fw_version[MAX_NAME_LENGTH];
+	enum msm_vidc_core_state               state;
+	int                                  (*state_handle)(struct msm_vidc_core *core,
+							     enum msm_vidc_core_event_type type,
+							     struct msm_vidc_event_data *data);
+	enum msm_vidc_core_sub_state           sub_state;
+	char                                   sub_state_name[MAX_NAME_LENGTH];
+	struct mutex                           lock; /* lock for core structure */
+	struct msm_vidc_resource              *resource;
+	struct msm_vidc_platform              *platform;
+	u32                                    intr_status;
+	u32                                    spur_count;
+	u32                                    reg_count;
+	u32                                    enc_codecs_count;
+	u32                                    dec_codecs_count;
+	struct msm_vidc_core_capability        capabilities[CORE_CAP_MAX + 1];
+	struct msm_vidc_inst_capability       *inst_caps;
+	struct msm_vidc_mem_addr               sfr;
+	struct msm_vidc_mem_addr               iface_q_table;
+	struct msm_vidc_iface_q_info           iface_queues[VIDC_IFACEQ_NUMQ];
+	struct delayed_work                    pm_work;
+	struct workqueue_struct               *pm_workq;
+	struct workqueue_struct               *batch_workq;
+	struct delayed_work                    fw_unload_work;
+	struct msm_vidc_core_power             power;
+	u32                                    skip_pc_count;
+	u32                                    last_packet_type;
+	u8                                    *packet;
+	u32                                    packet_size;
+	u8                                    *response_packet;
+	struct v4l2_file_operations           *v4l2_file_ops;
+	const struct v4l2_ioctl_ops                 *v4l2_ioctl_ops_enc;
+	const struct v4l2_ioctl_ops                 *v4l2_ioctl_ops_dec;
+	const struct v4l2_ctrl_ops                  *v4l2_ctrl_ops;
+	const struct vb2_ops                        *vb2_ops;
+	struct vb2_mem_ops                    *vb2_mem_ops;
+	struct v4l2_m2m_ops                   *v4l2_m2m_ops;
+	struct msm_vidc_iris_ops              *iris_ops;
+	const struct msm_vidc_resources_ops   *res_ops;
+	struct msm_vidc_session_ops           *session_ops;
+	const struct msm_vidc_memory_ops      *mem_ops;
+	u32                                    header_id;
+	u32                                    packet_id;
+	u32                                    sys_init_id;
+};
+
+#endif // _MSM_VIDC_CORE_H_
diff --git a/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_inst.h b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_inst.h
new file mode 100644
index 0000000..96c8903
--- /dev/null
+++ b/drivers/media/platform/qcom/iris/vidc/inc/msm_vidc_inst.h
@@ -0,0 +1,207 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _MSM_VIDC_INST_H_
+#define _MSM_VIDC_INST_H_
+
+#include "hfi_property.h"
+#include "msm_vidc_internal.h"
+#include "msm_vidc_memory.h"
+#include "msm_vidc_state.h"
+
+#define call_session_op(c, op, ...)			\
+	(((c) && (c)->session_ops && (c)->session_ops->op) ? \
+	((c)->session_ops->op(__VA_ARGS__)) : 0)
+
+struct msm_vidc_session_ops {
+	u64 (*calc_freq)(struct msm_vidc_inst *inst, u32 data_size);
+	int (*calc_bw)(struct msm_vidc_inst *inst,
+		       struct vidc_bus_vote_data *vote_data);
+	int (*decide_work_route)(struct msm_vidc_inst *inst);
+	int (*decide_work_mode)(struct msm_vidc_inst *inst);
+	int (*decide_quality_mode)(struct msm_vidc_inst *inst);
+	int (*buffer_size)(struct msm_vidc_inst *inst, enum msm_vidc_buffer_type type);
+	int (*min_count)(struct msm_vidc_inst *inst, enum msm_vidc_buffer_type type);
+	int (*extra_count)(struct msm_vidc_inst *inst, enum msm_vidc_buffer_type type);
+	int (*ring_buf_count)(struct msm_vidc_inst *inst, u32 data_size);
+};
+
+struct msm_vidc_mem_list_info {
+	struct msm_vidc_mem_list        bin;
+	struct msm_vidc_mem_list        arp;
+	struct msm_vidc_mem_list        comv;
+	struct msm_vidc_mem_list        non_comv;
+	struct msm_vidc_mem_list        line;
+	struct msm_vidc_mem_list        dpb;
+	struct msm_vidc_mem_list        persist;
+	struct msm_vidc_mem_list        vpss;
+};
+
+struct msm_vidc_buffers_info {
+	struct msm_vidc_buffers        input;
+	struct msm_vidc_buffers        output;
+	struct msm_vidc_buffers        read_only;
+	struct msm_vidc_buffers        bin;
+	struct msm_vidc_buffers        arp;
+	struct msm_vidc_buffers        comv;
+	struct msm_vidc_buffers        non_comv;
+	struct msm_vidc_buffers        line;
+	struct msm_vidc_buffers        dpb;
+	struct msm_vidc_buffers        persist;
+	struct msm_vidc_buffers        vpss;
+};
+
+struct buf_queue {
+	struct vb2_queue *vb2q;
+};
+
+/**
+ * struct msm_vidc_inst - holds per instance parameters
+ *
+ * @list: used for attach an instance to the core
+ * @lock: lock for this structure
+ * @ctx_q_lock:  lock to serialize ioctls calls related to queues
+ * @client_lock: lock to serialize ioctls
+ * @state: instnace state
+ * @event_handle: handler for different v4l2 ioctls
+ * @sub_state: substate of instance
+ * @sub_state_name: substate name
+ * @domain: domain type: encoder or decoder
+ * @codec: codec type
+ * @core: pointer to core structure
+ * @kref: instance reference
+ * @session_id: id of current session
+ * @debug_str: debug string
+ * @packet: HFI packet
+ * @packet_size: HFI packet size
+ * @fmts: structure of v4l2_format
+ * @ctrl_handler: reference of v4l2 ctrl handler
+ * @fh: reference of v4l2 file handler
+ * @m2m_dev: m2m device handle
+ * @m2m_ctx: m2m device context
+ * @num_ctrls: supported number of controls
+ * @hfi_rc_type: type of HFI rate control
+ * @hfi_layer_type: type of HFI layer encoding
+ * @bufq: array of vb2 queue
+ * @crop: structure of crop info
+ * @compose: structure of compose info
+ * @power: structure of power info
+ * @bus_data: structure of bus data
+ * @pool: array of memory pool of buffers
+ * @buffers: structure of buffer info
+ * @mem_info: structure of memory info
+ * @timestamps: structure of timestamp related info
+ * @subcr_params: array of subscription params which driver subscribes to fw
+ * @hfi_frame_info: structure of frame info
+ * @decode_batch: strtucre of decode batch
+ * @decode_vpp_delay: structure for vpp delay related info
+ * @session_idle: structure of idle session related info
+ * @stats_work: delayed work for buffer stats
+ * @workq: pointer to workqueue
+ * @enc_input_crs: list head of input compression rations
+ * @dmabuf_tracker: list head of dambuf tracker
+ * @input_timer_list: list head of input timer
+ * @caps_list: list head of capability
+ * @children_list: list head of children list of caps
+ * @firmware_list: list head of fw list of cap which will be set to cap
+ * @buffer_stats_list: list head of buffer stats
+ * @once_per_session_set: boolean to set once per session property
+ * @ipsc_properties_set: boolean to set ipsc properties to fw
+ * @opsc_properties_set: boolean to set opsc properties to fw
+ * @caps_list_prepared: boolean to prepare capability list
+ * @debugfs_root: root of debugfs
+ * @debug_count: count for ETBs, EBDs, FTBs and FBDs
+ * @stats: structure for bw stats
+ * @capabilities: array of supported instance capabilities
+ * @completions: structure of signal completions
+ * @active: boolean for active instances
+ * @last_qbuf_time_ns: time of last qbuf to driver
+ * @initial_time_us: start timestamp
+ * @max_input_data_size: max size of input data
+ * @dpb_list_payload: array of dpb buffers
+ * @input_dpb_list_enabled: boolean for input dpb buffer list
+ * @output_dpb_list_enabled: boolean for output dpb buffer list
+ * @max_rate: max input rate
+ * @has_bframe: boolean for B frame
+ * @ir_enabled: boolean for intra refresh
+ * @iframe: boolean for I frame
+ * @fw_min_count: minimnum count of buffers needed by fw
+ */
+
+struct msm_vidc_inst {
+	struct list_head                   list;
+	struct mutex                       lock; /* instance lock */
+	/* lock to serialize IOCTL calls related to queues */
+	struct mutex                       ctx_q_lock;
+	struct mutex                       client_lock; /* lock to serialize IOCTLs */
+	enum msm_vidc_state                state;
+	int                              (*event_handle)(struct msm_vidc_inst *inst,
+							 enum msm_vidc_event event, void *data);
+	enum msm_vidc_sub_state            sub_state;
+	char                               sub_state_name[MAX_NAME_LENGTH];
+	enum msm_vidc_domain_type          domain;
+	enum msm_vidc_codec_type           codec;
+	void                              *core;
+	struct kref                        kref;
+	u32                                session_id;
+	u8                                 debug_str[24];
+	void                              *packet;
+	u32                                packet_size;
+	struct v4l2_format                 fmts[MAX_PORT];
+	struct v4l2_ctrl_handler           ctrl_handler;
+	struct v4l2_fh                     fh;
+	struct v4l2_m2m_dev               *m2m_dev;
+	struct v4l2_m2m_ctx               *m2m_ctx;
+	u32                                num_ctrls;
+	enum hfi_rate_control              hfi_rc_type;
+	enum hfi_layer_encoding_type       hfi_layer_type;
+	struct buf_queue                   bufq[MAX_PORT];
+	struct msm_vidc_rectangle          crop;
+	struct msm_vidc_rectangle          compose;
+	struct msm_vidc_power              power;
+	struct vidc_bus_vote_data          bus_data;
+	struct msm_memory_pool             pool[MSM_MEM_POOL_MAX];
+	struct msm_vidc_buffers_info       buffers;
+	struct msm_vidc_mem_list_info      mem_info;
+	struct msm_vidc_timestamps         timestamps;
+	struct msm_vidc_subscription_params       subcr_params[MAX_PORT];
+	struct msm_vidc_hfi_frame_info     hfi_frame_info;
+	struct msm_vidc_decode_batch       decode_batch;
+	struct msm_vidc_decode_vpp_delay   decode_vpp_delay;
+	struct msm_vidc_session_idle       session_idle;
+	struct delayed_work                stats_work;
+	struct workqueue_struct           *workq;
+	struct list_head                   enc_input_crs;
+	struct list_head                   dmabuf_tracker; /* struct msm_memory_dmabuf */
+	struct list_head                   input_timer_list; /* struct msm_vidc_input_timer */
+	struct list_head                   caps_list;
+	struct list_head                   children_list; /* struct msm_vidc_inst_cap_entry */
+	struct list_head                   firmware_list; /* struct msm_vidc_inst_cap_entry */
+	struct list_head                   buffer_stats_list; /* struct msm_vidc_buffer_stats */
+	bool                               once_per_session_set;
+	bool                               ipsc_properties_set;
+	bool                               opsc_properties_set;
+	bool                               caps_list_prepared;
+	struct dentry                     *debugfs_root;
+	struct debug_buf_count             debug_count;
+	struct msm_vidc_statistics         stats;
+	struct msm_vidc_inst_cap           capabilities[INST_CAP_MAX + 1];
+	struct completion                  completions[MAX_SIGNAL];
+	bool                               active;
+	u64                                last_qbuf_time_ns;
+	u64                                initial_time_us;
+	u32                                max_input_data_size;
+	u32                                dpb_list_payload[MAX_DPB_LIST_ARRAY_SIZE];
+	bool                               input_dpb_list_enabled;
+	bool                               output_dpb_list_enabled;
+	u32                                max_rate;
+	bool                               has_bframe;
+	bool                               ir_enabled;
+	bool                               iframe;
+	u32                                fw_min_count;
+};
+
+#endif // _MSM_VIDC_INST_H_
-- 
2.7.4

