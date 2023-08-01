Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E39B76BEB9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjHAUtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbjHAUtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:49:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7965419B7;
        Tue,  1 Aug 2023 13:48:59 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371Kehqs024310;
        Tue, 1 Aug 2023 20:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=qcppdkim1; bh=gQu+xJ9b2wewbPXTvV8WorriSxzvGoVmvD2FKbEEJMo=;
 b=DRFYyVHKtOuFXLg4/u1X2pQ/AY/61nbZTl7ICs+aeNOddm9FbqUltAnUgcCILmR48662
 neXurx+5ow2yxqm9KU5D1mjERsbfUOdDivh2CUhuFJx/AhUKfgby7pE2m2+MabhYuW57
 6B/zoQiGJ3F9OFsxEpzt422qP7ZzLZEgCXiMZmHNw0mLFpdJm8fCJRi3sf2LviNGBcpH
 t2r/ITfCy4PMNEE/8z+AujP6WZq10IlQvcrS5d4RQFHKTD18P+msJLIYxyM8Fp5/t3c3
 Jjf8QzpKZHZ1txm521aRc/2xQ/5wg3utv5UYbsDuoQzPT9P6D8o0Ax2JpyxuheivXv4o tw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b30hyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 20:48:39 +0000
Received: from pps.filterd (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 371Kf6Pm019361;
        Tue, 1 Aug 2023 20:48:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 3s776xs2us-1;
        Tue, 01 Aug 2023 20:48:38 +0000
Received: from NASANPPMTA02.qualcomm.com (NASANPPMTA02.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 371KmcXs027428;
        Tue, 1 Aug 2023 20:48:38 GMT
Received: from th-lint-014.qualcomm.com (th-lint-014.qualcomm.com [10.63.177.51])
        by NASANPPMTA02.qualcomm.com (PPS) with ESMTP id 371Kmc1Q027424;
        Tue, 01 Aug 2023 20:48:38 +0000
Received: by th-lint-014.qualcomm.com (Postfix, from userid 455663)
        id E43166846; Tue,  1 Aug 2023 13:48:37 -0700 (PDT)
From:   Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>
To:     "T . J . Alumbaugh" <talumbau@google.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        "mark . rutland @ arm . com" <mark.rutland@arm.com>,
        "will @ kernel . org" <will@kernel.org>,
        "virtualization @ lists . linux-foundation . org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-mm @ kvack . org" <linux-mm@kvack.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel @ lists . infradead . org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-arm-msm @ vger . kernel . org" <linux-arm-msm@vger.kernel.org>
Cc:     Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Sukadev Bhattiprolu <quic_sukadev@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Patrick Daly <quic_pdaly@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
Subject: [RFC PATCH 2/2] vmrd: add implementation of memory plugin interfaces
Date:   Tue,  1 Aug 2023 13:47:14 -0700
Message-Id: <cdc14134a947bfb4a667129bf8d3fecbd0816134.1690836010.git.quic_sudaraja@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1690836010.git.quic_sudaraja@quicinc.com>
References: <cover.1690836010.git.quic_sudaraja@quicinc.com>
In-Reply-To: <cover.1690836010.git.quic_sudaraja@quicinc.com>
References: <cover.1690836010.git.quic_sudaraja@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ke5VV3D8Y36hUICoVnv7TPsYPwCmpx9
X-Proofpoint-ORIG-GUID: 7ke5VV3D8Y36hUICoVnv7TPsYPwCmpx9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_19,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010185
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implementation of memory plugin interfaces such as memory_plug_request,
memory_unplug_request etc. using virtio_mem kernel driver.

The userspace daemon makes ioctl calls to kernel requesting for adding/
removing memory to the VM. The size request is aligned to virtio-mem
device size. Modified version of virtio-mem driver is used that supports
memory_on_hotplug feature and add/remove memory requests via ioctl calls.
Link to the ioctl handling function is below:
https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r33-rel/drivers/virtio/qti_virtio_mem.c#L185
modified virtio-mem driver: https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r33-rel/drivers/virtio/virtio_mem.c

We use a kernel driver called mem-buf for communication between the VMs.
The memory plug request by virtio-mem is made by calling mem_buf_alloc each of
virtio-mem block size iteratively to accommodate the requested size.
https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r33-rel/drivers/virtio/virtio_mem.c#L1373

The mem-buf driver uses to Linux Gunyah driver (mem_buf_map_mem_s2) to
communicate with Hypervisor requesting to map the memory into S2 page-tables.
This is currently tested only on Gunyah Hypervisor and not on other Hypervisors.
mem_buf_map_mem_s2: https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r33-rel/drivers/soc/qcom/mem_buf/mem-buf-dev-gh.c#L207

The daemon also gets virtio-mem device configuration details such as
device_bloc_size, max_threshold of resizing the VM etc. from the kernel
via sysfs nodes of virtio-mem device.
---
 vmrd.cpp | 129 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 117 insertions(+), 12 deletions(-)

diff --git a/vmrd.cpp b/vmrd.cpp
index 1bf5812..090f90a 100644
--- a/vmrd.cpp
+++ b/vmrd.cpp
@@ -19,11 +19,18 @@
 #include <sys/epoll.h>
 #include <sys/types.h>
 #include <sys/time.h>
+#include <sys/ioctl.h>
 #include <sys/syslog.h>
 #include <fcntl.h>
 #include <inttypes.h>
 #include <pthread.h>
+#include <cutils/memory.h>
 #include <atomic>
+#include <vector>
+#include <fcntl.h>
+
+/* qti_virtio_mem uapi header */
+#include <linux/qti_virtio_mem.h>
 
 #define SIZE_1MB    0x00100000
 #define SIZE_1KB    0x00000400
@@ -205,23 +212,71 @@ using namespace std;
  * are needed to support the functionality of vmrd.
  */
 
+/* qti_virtio_mem device fd */
+static int virtio_mem_fd = -1;
+
+/* mem_buf fds returned by virtio-mem driver */
+static vector<int> array_memfd;
+
+#define QVM_VIRTIO_MEM_DEV_PATH     "/dev/qti_virtio_mem"
+#define QVM_SYS_DEVICE_PATH         "/sys/devices/virtual/qti_virtio_mem/qti_virtio_mem"
+#define QVM_BLOCK_SIZE_PATH         QVM_SYS_DEVICE_PATH"/device_block_size"
+#define QVM_MAX_PLUGIN_THRES_PATH   QVM_SYS_DEVICE_PATH"/max_plugin_threshold"
+#define QVM_NUM_BLOCK_PLUGGED_PATH  QVM_SYS_DEVICE_PATH"/device_block_plugged"
+
+static int virtio_mem_plug_memory(int64_t size, const std::string& name)
+{
+    struct qti_virtio_mem_ioc_hint_create_arg arg = {};
+    int ret;
+
+    if (virtio_mem_fd < 0)
+        return -ENOTTY;
+
+    arg.size = size;
+    strlcpy(arg.name, name.c_str(), sizeof(arg.name));
+
+    ret = ioctl(virtio_mem_fd, QTI_VIRTIO_MEM_IOC_HINT_CREATE, &arg);
+    if (ret) {
+        LOGE("MemorySizeHint() failed");
+        return ret;
+    }
+
+    return arg.fd;
+}
+
 static int memory_plug_init(void) {
-    LOGE("memory plug request not supported");
-    return -ENOTTY;
+    virtio_mem_fd = open(QVM_VIRTIO_MEM_DEV_PATH, O_RDONLY | O_CLOEXEC);
+    if (virtio_mem_fd < 0) {
+        LOGE("Unable to open %s: %s", QVM_VIRTIO_MEM_DEV_PATH, strerror(errno));
+        return errno;
+    }
+
+    return 0;
 }
 
 static void memory_plug_deinit(void) {
-    LOGE("memory plug request not supported");
+    if (virtio_mem_fd >= 0)
+        close(virtio_mem_fd);
 }
 
 /*
  * Plugs in memory of given size into the system by requesting it from host VM.
  * This call is expected to be blocking call.
  */
+
 static int memory_plug_request(uint64_t size) {
-    (void) size;
-    LOGE("Memory plug request not supported");
-    return -ENOTTY;
+    int memfd;
+
+    memfd = virtio_mem_plug_memory(size * SIZE_1MB, "vmrd");
+    if (memfd < 0) {
+        LOGE("failed to suggest memory size hint");
+        return -1;
+    }
+
+    LOGI("Memory of size %lu MB plugged-in successfully", size);
+    array_memfd.push_back(memfd);
+
+    return 0;
 }
 
 /*
@@ -230,8 +285,18 @@ static int memory_plug_request(uint64_t size) {
  * his call is expected to be blocking call.
  */
 static int memory_unplug_request(uint64_t size) {
-    (void) size;
-    LOGE("Memory unplug request not supported");
+    int res;
+
+    if (array_memfd.size()) {
+        res = close(array_memfd.back());
+        array_memfd.pop_back();
+        if (res)
+            LOGE("Failed to unplug one memory chunk of size %lu MB", size);
+
+        return res;
+    }
+
+    LOGE("No memory available to unplug");
     return -ENOTTY;
 }
 
@@ -243,8 +308,32 @@ static int memory_unplug_request(uint64_t size) {
  * This call is expected to be blocking call.
  */
 static int __unused memory_unplug_all_request(void) {
-    LOGE("Memory unplug all request not supported");
-    return -ENOTTY;
+    uint64_t initial_count, unplugged_count = 0, res;
+
+    initial_count = array_memfd.size();
+    if (!initial_count) {
+        LOGE("No memory available to unplug");
+        return 0;
+    }
+
+    while (array_memfd.size()) {
+        LOGI("releasing one memory chunk to host VM");
+        res = close(array_memfd.back());
+        array_memfd.pop_back();
+        if (res)
+            LOGE("failed to unplug one memory chunk");
+        else
+            unplugged_count++;
+    }
+
+    if (unplugged_count < initial_count)
+        LOGI("not all memory chunks were unplugged. initial_count: %lu unplugged_count: %lu",
+                initial_count, unplugged_count);
+    else
+        LOGI("Successfully unplugged all memory chunks. unplugged_count: %lu",
+                unplugged_count);
+
+    return unplugged_count;
 }
 
 static int write_file(const char *file_path, char *s) {
@@ -305,7 +394,15 @@ static char *read_file(const char *file_path) {
  * Memory block size or resolution.
  */
 static int get_memory_plugin_resolution(uint64_t *plugin_resolution_mb) {
-    *plugin_resolution_mb = DEFAULT_PLUGIN_RESOLUTION_MB;
+    char *buf;
+
+    buf = read_file(QVM_BLOCK_SIZE_PATH);
+    if (!buf)
+        return -EINVAL;
+
+    *plugin_resolution_mb = strtoul(buf, 0, 10);
+    *plugin_resolution_mb /= SIZE_1MB;
+
     return 0;
 }
 
@@ -313,7 +410,15 @@ static int get_memory_plugin_resolution(uint64_t *plugin_resolution_mb) {
  * Total max memory that the system (guest VM) allows to be pluuged-in.
  */
 static int get_max_memory_plugin_allowed(uint64_t *max_memory_plugin_mb) {
-    *max_memory_plugin_mb = DEFAULT_MAX_MEMORY_PLUGIN_MB;
+    char *buf;
+
+    buf = read_file(QVM_MAX_PLUGIN_THRES_PATH);
+    if (!buf)
+        return -EINVAL;
+
+    *max_memory_plugin_mb = strtoul(buf, 0, 10);
+    *max_memory_plugin_mb /= SIZE_1MB;
+
     return 0;
 }
 
-- 
2.7.4

