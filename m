Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63E76BEBB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjHAUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232694AbjHAUtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:49:09 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB201FC7;
        Tue,  1 Aug 2023 13:49:04 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 371JNB2C018227;
        Tue, 1 Aug 2023 20:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding;
 s=qcppdkim1; bh=/272EWVeecoFd9pLzhFifLqoGD03Tuja359dQxvnk1s=;
 b=hdlIHTuwGN+W3CAPEBch1W9PAUtlzJFsygZZp24xxPKk08A3oysN/gCdDlf3X00WTdH5
 yCVCXnRQQiYrZk+YbSg7bZM2bmRBwPh4KbEn9QkFPIiyXTp6O06cZGC2Efy1SjO0cIws
 KfbScjdN3BTUut0SUv3xWf+4FWubXqkjukYTqz7niTb+FqQ6tKGBcn+/JeL4Xn+J/bnN
 LPfHMNJK2LiUq4QB3Wv52o/TjJJHL2x/j1CKMatMndBkBDipkiTWQdxAS4yj8F5j+d9L
 Q3/IY9hL46K3/YNV6MnBbfg4ktVpn/XEpaZunsClZTKYst9WXZwoudJepRHzIPGpRNz9 7g== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6yq49dqs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Aug 2023 20:48:36 +0000
Received: from pps.filterd (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 371Kk95u006532;
        Tue, 1 Aug 2023 20:48:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTPS id 3s72crupbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 01 Aug 2023 20:48:35 +0000
Received: from NASANPPMTA03.qualcomm.com (NASANPPMTA03.qualcomm.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 371KmY3K008657;
        Tue, 1 Aug 2023 20:48:34 GMT
Received: from th-lint-014.qualcomm.com (th-lint-014.qualcomm.com [10.63.177.51])
        by NASANPPMTA03.qualcomm.com (PPS) with ESMTP id 371KmY4p008654;
        Tue, 01 Aug 2023 20:48:34 +0000
Received: by th-lint-014.qualcomm.com (Postfix, from userid 455663)
        id 9CACD6846; Tue,  1 Aug 2023 13:48:34 -0700 (PDT)
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
Subject: [RFC PATCH 1/2] vmrd: dynamic guest VM memory resizing daemon
Date:   Tue,  1 Aug 2023 13:47:13 -0700
Message-Id: <de49fa51b794d447acbd097e77b73a3e759f4ad7.1690836010.git.quic_sudaraja@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1690836010.git.quic_sudaraja@quicinc.com>
References: <cover.1690836010.git.quic_sudaraja@quicinc.com>
In-Reply-To: <cover.1690836010.git.quic_sudaraja@quicinc.com>
References: <cover.1690836010.git.quic_sudaraja@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: B6Id6mMeFiZGNreCe6FhIy4_UoU-lWqh
X-Proofpoint-GUID: B6Id6mMeFiZGNreCe6FhIy4_UoU-lWqh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_18,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010185
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VM Memory Resizing Daemon (vmrd).

Userspace daemon that registers to Linux kernel's PSI mechanism for
monitoring and detecting memory pressure events in the system, and
requests for adding/removing memory blocks from the host based on
real-time memory demands in system. This dynamic approach makes it
guest driven without need for intervention of an admin.
The virtio-mem interface is used for communicating with the host for
adding/removing memory blocks.

Detecting increase in memory demand – the daemon registers to certain
PSI events and monitors pressure building up when memory allocations
occurs. With set thresholds, even the slightest memory pressure triggers
the daemon to make an educated guess that a memory requiring use case
is active and requests additional memory.

Detecting decrease in memory pressure – the daemon monitors pressure
decay and psi averages (avg10, avg60, avg300) and along with other
memory stats. Based on these metrics, it  makes an educated guess that
the usecase has ended and frees up memory by releasing it back to host.
The process of tracking memory pressure going down and releasing memory
back to host is done in a separate thread.

The daemon takes proactive approach which ensures that system has extra
memory only when its needed. System wakelock is taken during pressure
tracking to ensure free memory isn't kept around before entering suspend.

Currently, the guest VM memory is resized by expanding Movable zone only,
since virtio-mem uses memory hotplug and only Movable zone guarantees
memory blocks to be isolated and offlined. Expanding Movable zone thus
increases headroom for any userspace memory.
---
 Makefile.am |   14 +
 vmrd.cpp    | 1154 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 1168 insertions(+)
 create mode 100644 Makefile.am
 create mode 100644 vmrd.cpp

diff --git a/Makefile.am b/Makefile.am
new file mode 100644
index 0000000..c42f491
--- /dev/null
+++ b/Makefile.am
@@ -0,0 +1,14 @@
+AM_CPPFLAGS := \
+    -W \
+    -Wall \
+    -Wextra \
+    -Wunused \
+    -Werror
+
+#Build vmrd binary
+bin_PROGRAMS := vmrd
+vmrd_SOURCES := vmrd.cpp
+vmrd_CPPFLAGS := $(AM_CPPFLAGS) @LIBBASE_CFLAGS@ @LIBCUTILS_CFLAGS@
+vmrd_LDFLAGS := -lbase -lpthread -lcutils
+
+pkgconfigdir := $(libdir)/pkgconfig
diff --git a/vmrd.cpp b/vmrd.cpp
new file mode 100644
index 0000000..1bf5812
--- /dev/null
+++ b/vmrd.cpp
@@ -0,0 +1,1154 @@
+/*
+ * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * Dynamic VM Memory Resizing Daemon (vmrd)
+ */
+
+#define LOG_TAG "vmrd"
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+#include <errno.h>
+#include <sstream>
+#include <time.h>
+#include <sys/epoll.h>
+#include <sys/types.h>
+#include <sys/time.h>
+#include <sys/syslog.h>
+#include <fcntl.h>
+#include <inttypes.h>
+#include <pthread.h>
+#include <atomic>
+
+#define SIZE_1MB    0x00100000
+#define SIZE_1KB    0x00000400
+
+#ifndef MS_PER_SEC
+#define MS_PER_SEC  (1000)
+#endif
+
+#define US_PER_SEC  1000000
+#define US_PER_MS   (US_PER_SEC / MS_PER_SEC)
+#define NS_PER_SEC  1000000000
+#define NS_PER_MS   (NS_PER_SEC / MS_PER_SEC)
+#define NS_PER_US   (NS_PER_SEC / US_PER_SEC)
+
+#define LOGI(fmt, arg...)   syslog (LOG_INFO, fmt, ##arg)
+#define LOGE(fmt, arg...)   syslog (LOG_ERR, fmt, ##arg)
+#define LOGD(fmt, arg...)   syslog (LOG_DEBUG, fmt, ##arg)
+
+#ifndef __unused
+#define __unused __attribute__((__unused__))
+#endif
+
+enum pressure_levels {
+    PRESSURE_INVALID = -2,
+    PRESSURE_NONE,
+    PRESSURE_MIN = 0,
+
+    PRESSURE_EVT_5 = PRESSURE_MIN,
+    PRESSURE_EVT_10,
+    PRESSURE_EVT_15,
+    PRESSURE_EVT_20,
+    PRESSURE_EVT_25,
+    PRESSURE_EVT_30,
+    PRESSURE_EVT_35,
+    PRESSURE_EVT_40,
+    PRESSURE_EVT_45,
+    PRESSURE_EVT_50,
+
+    PRESSURE_EVT_COUNT
+};
+
+enum zone_name {
+    ZONE_NORMAL = 0,
+    ZONE_MOVABLE,
+    ZONE_MAX
+};
+
+static size_t sys_page_size;
+
+static const char* const zone_names[ZONE_MAX] = {
+    "Normal",
+    "Movable",
+};
+
+#define MEMINFO_PATH    "/proc/meminfo"
+#define ZONEINFO_PATH   "/proc/zoneinfo"
+#define PSI_MEMORY_PATH "/proc/pressure/memory"
+
+#define WAKE_LOCK_PATH   "/sys/power/wake_lock"
+#define WAKE_UNLOCK_PATH "/sys/power/wake_unlock"
+#define WAKELOCK_STR     "vmrd_lock"
+#define WAKEUNLOCK_STR   WAKELOCK_STR
+
+/* memory plugin size defaults (in MBs)*/
+#define DEFAULT_PLUGIN_RESOLUTION_MB    (4)
+#define DEFAULT_MAX_MEMORY_PLUGIN_MB    (256)
+
+#define MAX_UNPLUG_RETRY                (2)
+
+enum psi_stall_type {
+    PSI_SOME,
+    PSI_FULL,
+    PSI_TYPE_COUNT
+};
+
+static const char* stall_type_name[] = {
+        "some",
+        "full",
+};
+
+struct psi_threshold {
+    enum psi_stall_type stall_type;
+    int threshold_ms;
+};
+
+struct memory_snapshot {
+    uint64_t sys_memfree_kb;
+    uint64_t normal_free_kb;
+    uint64_t movable_free_kb;
+    uint64_t movable_inactive_anon_kb;
+    uint64_t movable_inactive_file_kb;
+};
+
+struct psi_pressure {
+    float avg10;
+    float avg60;
+    float avg300;
+    uint64_t total;
+};
+
+struct psi_memory_pressure {
+    struct psi_pressure some;
+    struct psi_pressure full;
+};
+
+/* PSI threshold levels in milliseconds */
+static struct psi_threshold psi_thresholds[PRESSURE_EVT_COUNT] = {
+    { PSI_SOME, 5 },   { PSI_SOME, 10 },  { PSI_SOME, 15 },  { PSI_SOME, 20 },
+    { PSI_SOME, 25 },  { PSI_SOME, 30 },  { PSI_SOME, 35 },  { PSI_SOME, 40 },
+    { PSI_SOME, 45 },  { PSI_SOME, 50 }
+};
+
+/*
+ * we wait until memory pressure decays below certain
+ * threshold before unplugging memory.
+ */
+static bool enable_pressure_decay_wait = false;
+
+/* global buffer for file reads */
+static char* readfile_buf;
+static ssize_t readfile_buf_size;
+
+/* serialize fileread buffer accesses using mutex */
+static pthread_mutex_t fileread_buffer_mutex = PTHREAD_MUTEX_INITIALIZER;
+
+/* in MBs */
+static uint64_t resolution, max_plugged_memory;
+
+/* num of memory chunks plugged-in, each of resolution MB size */
+static std::atomic<uint64_t> mem_chunks_plugged{0};
+
+/* total plugged memory in VM system (in MBs) */
+static std::atomic<uint64_t> plugged_memory{0};
+
+/* fds of all registered PSI events */
+static int32_t event_fds[PRESSURE_EVT_COUNT];
+
+/* fd for main epoll_wait */
+static int32_t psi_epollfd = -1;
+
+/*
+ * used to calculate exponential decay time (in steps of 1 seconds)
+ * from one load_avg to another load_avg.
+ */
+#define EXP_1S_10S      0.9048F     /* 1/exp(1s/10s) */
+#define EXP_1S_60S      0.9834F     /* 1/exp(1s/60s) */
+#define EXP_1S_300S     0.9966F     /* 1/exp(1s/300s) */
+
+static pthread_mutex_t thread_execution_mutex = PTHREAD_MUTEX_INITIALIZER;
+static pthread_cond_t  thread_execution_cond;
+static pthread_condattr_t thread_execution_cond_attr;
+
+static std::atomic<bool> cancel_check(false);
+static std::atomic<bool> wait_in_progress(false);
+
+/* default wait time for pressure to be idle (in seconds) */
+#define IDLE_WAIT_TIME_S    10
+
+/* stall-tracking window size, 50ms*/
+static int PSI_WINDOW_SIZE_US = (50 * US_PER_MS);
+
+/* acceptable pressure during 60 sec window is 18 ms (0.03% of 60 sec) */
+#define AVG60_EXP_THRESHOLD     0.03F
+
+#define AVG10_EXP_THRESHOLD     0.00F
+
+#define TARGET_OOM_SCORE_ADJ    -1000
+
+#define LINE_MAX 250
+#define STRINGIFY(x) STRINGIFY_INTERNAL(x)
+#define STRINGIFY_INTERNAL(x) #x
+
+static char str_buf[LINE_MAX];
+
+using namespace std;
+
+/*
+ * Vendor-specific implementation of memory plug and unplug requests
+ * are needed to support the functionality of vmrd.
+ */
+
+static int memory_plug_init(void) {
+    LOGE("memory plug request not supported");
+    return -ENOTTY;
+}
+
+static void memory_plug_deinit(void) {
+    LOGE("memory plug request not supported");
+}
+
+/*
+ * Plugs in memory of given size into the system by requesting it from host VM.
+ * This call is expected to be blocking call.
+ */
+static int memory_plug_request(uint64_t size) {
+    (void) size;
+    LOGE("Memory plug request not supported");
+    return -ENOTTY;
+}
+
+/*
+ * Unplugs the memory of given size from the system and releases the memory
+ * back to host VM. Only memory that is previously added can be unplugged.
+ * his call is expected to be blocking call.
+ */
+static int memory_unplug_request(uint64_t size) {
+    (void) size;
+    LOGE("Memory unplug request not supported");
+    return -ENOTTY;
+}
+
+/*
+ * Releases all previously plugged memory back to the host VM.
+ * This can be done by unplugging all the memory by each block-by-block or
+ * by making a single request to unplug memory of size which is equal to
+ * total of all memory previously added.
+ * This call is expected to be blocking call.
+ */
+static int __unused memory_unplug_all_request(void) {
+    LOGE("Memory unplug all request not supported");
+    return -ENOTTY;
+}
+
+static int write_file(const char *file_path, char *s) {
+    int fd;
+    ssize_t len;
+
+    fd = open(file_path, O_WRONLY | O_CLOEXEC);
+
+    if (fd < 0) {
+        LOGE("%s open failed, err: %s", file_path, strerror(errno));
+        return -EINVAL;
+    }
+
+    len = write(fd, s, strlen(s));
+    if (len < (ssize_t)strlen(s)) {
+        LOGE("error writing to file: %s val %s", file_path, s);
+        close(fd);
+        return -EINVAL;
+    }
+
+    close(fd);
+    return 0;
+}
+
+static char *read_file(const char *file_path) {
+    int fd;
+    ssize_t readsize;
+    char *new_buf = NULL;
+
+    fd = open(file_path, O_RDONLY | O_CLOEXEC);
+    if (fd < 0) {
+        LOGE("%s open failed, err: %s", file_path, strerror(errno));
+        return NULL;
+    }
+
+    while ((readsize = pread(fd, readfile_buf,
+                readfile_buf_size, 0)) == readfile_buf_size) {
+        /*
+         * if file content is more than readfile buffer size, resize the buffer
+         * to double its previous size with realloc
+         */
+        readfile_buf_size *= 2;
+        new_buf = (char *)realloc(readfile_buf, readfile_buf_size);
+        if (new_buf == NULL) {
+            LOGE("resizing fileread buffer failed, errno: %s", strerror(errno));
+            close(fd);
+            return NULL;
+        }
+        readfile_buf = new_buf;
+    }
+
+    readfile_buf[readsize] = 0;
+    close(fd);
+    return readfile_buf;
+}
+
+/*
+ * Memory block size or resolution.
+ */
+static int get_memory_plugin_resolution(uint64_t *plugin_resolution_mb) {
+    *plugin_resolution_mb = DEFAULT_PLUGIN_RESOLUTION_MB;
+    return 0;
+}
+
+/*
+ * Total max memory that the system (guest VM) allows to be pluuged-in.
+ */
+static int get_max_memory_plugin_allowed(uint64_t *max_memory_plugin_mb) {
+    *max_memory_plugin_mb = DEFAULT_MAX_MEMORY_PLUGIN_MB;
+    return 0;
+}
+
+static inline char *nextln(char *buf)
+{
+    char *x;
+
+    x = (char *)memchr(buf, '\n', strlen(buf));
+    if (!x)
+        return buf + strlen(buf);
+    return x + 1;
+}
+
+/*** core functionality starts here ***/
+
+/*
+ * returns 0 on failure
+ */
+static unsigned int wake_lock_acquire()
+{
+    char str_val[LINE_MAX];
+
+    snprintf(str_val, sizeof(str_val), WAKELOCK_STR);
+    if (write_file(WAKE_LOCK_PATH, str_val)) {
+        LOGE("failed to write to %s errno: %s", WAKE_LOCK_PATH,
+                strerror(errno));
+        return 0;
+    }
+
+    return 1;
+}
+
+/*
+ * returns 0 on failure
+ */
+static unsigned int wake_unlock()
+{
+    char str_val[LINE_MAX];
+
+    snprintf(str_val, sizeof(str_val), WAKEUNLOCK_STR);
+    if (write_file(WAKE_UNLOCK_PATH, str_val)) {
+        LOGE("failed to write to %s errno: %s", WAKE_UNLOCK_PATH,
+                strerror(errno));
+        return 0;
+    }
+
+    return 1;
+}
+
+static int parse_field(char *buf, const char *field_name, uint64_t *val) {
+    std::istringstream sstr(buf);
+    std::string line;
+    int nargs;
+
+    if (field_name == NULL) {
+        LOGE("%s: field name for parsing is null", __func__);
+        goto err;
+    }
+
+    while (std::getline(sstr, line)) {
+        if(strstr(line.c_str(), field_name) == NULL)
+            continue;
+        /* found our line */
+        nargs = sscanf(line.c_str(), "%*[^0-9]%lu", val);
+        if (nargs != 1) {
+            LOGE("parsing field value  %s in line %s failed",
+                    field_name, line.c_str());
+            goto err;
+        }
+        return 0;
+    }
+
+    LOGE("%s: field name %s not found", __func__, field_name);
+err:
+    return -EINVAL;
+}
+
+/* must be used with fileread_buffer_mutex lock taken */
+static inline char *get_zoneinfo(void)
+{
+    return read_file(ZONEINFO_PATH);
+}
+
+static inline char *get_meminfo(void)
+{
+    return read_file(MEMINFO_PATH);
+}
+
+static int parse_zone_field(char *buf, const char *zone_name,
+        const char *field_name, uint64_t *val)
+{
+    char name[LINE_MAX + 1];    /* LINE_MAX + 1 to avoid sscanf overflow */
+    int nargs;
+
+    if (!buf)
+        return -EINVAL;
+
+    while (*buf) {
+        nargs = sscanf(buf, "Node %*u, zone %" STRINGIFY(LINE_MAX) "s", name);
+        buf = nextln(buf);
+        if (nargs == 1 && !strcmp(name, zone_name))
+            break;
+    }
+
+    if (!*buf)
+        return -EINVAL;
+
+    return parse_field(buf, field_name, val);
+}
+
+/*
+ * Take snapshot of system memory on the fields defined in
+ * struct memory_snapshot.
+ */
+static int system_memory_snapshot(struct memory_snapshot *mem_snap)
+{
+    char *buf;
+    int res = -1;
+
+    pthread_mutex_lock(&fileread_buffer_mutex);
+    buf = get_zoneinfo();
+    if (!buf)
+        goto err;
+
+    /*
+     * Some zone fields may not be present if zone is empty,
+     * so not necessarily parsing errors. Return 0 for fields
+     * that don't exist.
+     */
+
+    if (parse_zone_field(buf, zone_names[ZONE_NORMAL],
+            "pages free", &mem_snap->normal_free_kb))
+        mem_snap->normal_free_kb = 0;
+    mem_snap->normal_free_kb *= sys_page_size / SIZE_1KB;
+
+    if (parse_zone_field(buf, zone_names[ZONE_MOVABLE],
+            "pages free", &mem_snap->movable_free_kb))
+        mem_snap->movable_free_kb = 0;
+    mem_snap->movable_free_kb *= sys_page_size / SIZE_1KB;
+
+    if (parse_zone_field(buf, zone_names[ZONE_MOVABLE],
+            "nr_zone_inactive_anon", &mem_snap->movable_inactive_anon_kb))
+        mem_snap->movable_inactive_anon_kb = 0;
+    mem_snap->movable_inactive_anon_kb *= sys_page_size / SIZE_1KB;
+
+    if (parse_zone_field(buf, zone_names[ZONE_MOVABLE],
+            "nr_zone_inactive_file", &mem_snap->movable_inactive_file_kb))
+        mem_snap->movable_inactive_file_kb = 0;
+    mem_snap->movable_inactive_file_kb *= sys_page_size / SIZE_1KB;
+
+    buf = get_meminfo();
+    if (!buf)
+        goto err;
+
+    if(parse_field(buf, "MemFree", &mem_snap->sys_memfree_kb))
+        goto err;
+    res = 0;
+
+err:
+    if (res)
+        LOGE("failed to get memory snapshot");
+    pthread_mutex_unlock(&fileread_buffer_mutex);
+    return res;
+}
+
+/* gets the PSI averages for stall types PSI_SOME and PSI_FULL */
+static int parse_system_psi_memory(struct psi_memory_pressure *psi_memory)
+{
+    char *buf;
+    int nargs, res = -1;
+
+    pthread_mutex_lock(&fileread_buffer_mutex);
+    buf = read_file(PSI_MEMORY_PATH);
+    if (!buf)
+        goto err;
+
+    memset(psi_memory, 0, sizeof(struct psi_memory_pressure));
+
+    /* get memory pressure for PSI_SOME */
+    nargs = sscanf(buf, "some avg10=%f avg60=%f avg300=%f total=%lu",
+                &psi_memory->some.avg10,
+                &psi_memory->some.avg60,
+                &psi_memory->some.avg300,
+                &psi_memory->some.total);
+    if (nargs != 4) {
+        LOGE("line parse for PSI_SOME avgs failed");
+        goto err;
+    }
+
+    buf = nextln(buf);
+
+    /* get memory pressure for PSI_FULL */
+    nargs = sscanf(buf, "full avg10=%f avg60=%f avg300=%f total=%lu",
+                &psi_memory->full.avg10,
+                &psi_memory->full.avg60,
+                &psi_memory->full.avg300,
+                &psi_memory->full.total);
+    if (nargs != 4) {
+        LOGE("line parse for PSI_FULL avgs failed");
+        goto err;
+    }
+
+    res = 0;
+err:
+    pthread_mutex_unlock(&fileread_buffer_mutex);
+    return res;
+}
+
+/* registers the PSI events (thresholds) for a given stall type and window */
+static int register_psi_memory(enum psi_stall_type stall_type,
+             int threshold_us, int window_us) {
+    int fd;
+    int res;
+    char buf[LINE_MAX];
+
+    fd = open(PSI_MEMORY_PATH, O_WRONLY | O_CLOEXEC);
+    if (fd < 0) {
+        LOGE("no kernel psi monitor support, errno: %s", strerror(errno));
+        return -1;
+    }
+
+    /* monitor memory pressure for partial stall */
+    snprintf(buf, sizeof(buf), "%s %d %d",
+                stall_type_name[stall_type], threshold_us, window_us);
+
+    res = write(fd, buf, strlen(buf) + 1);
+    if (res < 0) {
+        LOGE("%s write failed for psi stall type '%s', errno: %s",
+                PSI_MEMORY_PATH, stall_type_name[stall_type], strerror(errno));
+        goto err;
+    }
+
+    return fd;
+
+err:
+    close(fd);
+    return -1;
+}
+
+static int register_epoll_events(int epollfd, int psi_event_fd, void *data) {
+    int res;
+    struct epoll_event epevent;
+
+    /* register for epoll with EPOLLPRI and EPOLLWAKEUP events */
+    epevent.events = EPOLLPRI | EPOLLWAKEUP;
+    epevent.data.ptr = data;
+    res = epoll_ctl(epollfd, EPOLL_CTL_ADD, psi_event_fd, &epevent);
+    if (res < 0) {
+        LOGE("epoll_ctl for psi monitor failed, errno: %s", strerror(errno));
+    }
+    return res;
+}
+
+static int unregister_epoll_events(int epollfd, int psi_event_fd) {
+    return epoll_ctl(epollfd, EPOLL_CTL_DEL, psi_event_fd, NULL);
+}
+
+static void unregister_psi_events() {
+    int num;
+
+    for (num = PRESSURE_MIN; num < PRESSURE_EVT_COUNT; num ++) {
+        if (event_fds[num] >= 0) {
+            unregister_epoll_events(psi_epollfd, event_fds[num]);
+            close(event_fds[num]);
+        }
+        event_fds[num] = -1;
+    }
+}
+
+static const char *psi_level_to_string(pressure_levels level) {
+    uint16_t num;
+
+    if (level == PRESSURE_NONE)
+        return "NONE";
+    if (level == PRESSURE_INVALID)
+        return "INVALID";
+
+    num = psi_thresholds[level].threshold_ms;
+    memset(str_buf, 0, sizeof(str_buf));
+    snprintf(str_buf, sizeof(str_buf), "EVENT_%dMS", num);
+
+    return str_buf;
+}
+
+static int init_and_register_psi_events() {
+
+    int num;
+
+    for (num = PRESSURE_MIN; num < PRESSURE_EVT_COUNT; num ++)
+        event_fds[num] = -1;
+
+    psi_epollfd = epoll_create(PRESSURE_EVT_COUNT);
+    if (psi_epollfd == -1) {
+        LOGE("epoll_create failed, errno: %s", strerror(errno));
+        return -1;
+    }
+
+    for (num = PRESSURE_MIN; num < PRESSURE_EVT_COUNT; num ++) {
+
+        /* register to psi moniters */
+        event_fds[num] = register_psi_memory(psi_thresholds[num].stall_type,
+                psi_thresholds[num].threshold_ms * US_PER_MS,
+                PSI_WINDOW_SIZE_US);
+
+        if (event_fds[num] < 0) {
+            LOGE("PSI init failed for event %s, fd %d",
+                    psi_level_to_string((enum pressure_levels)num),
+                    event_fds[num]);
+            goto fail;
+        }
+
+        /* initialize epoll events */
+        if (register_epoll_events(psi_epollfd, event_fds[num],
+                                 (void*)((uint64_t) num)) != 0) {
+            LOGE("PSI registration failed for event %s",
+                    psi_level_to_string((enum pressure_levels)num));
+            goto fail;
+        }
+    }
+
+    return 0;
+
+fail:
+    unregister_psi_events();
+    close(psi_epollfd);
+    psi_epollfd = -1;
+    return -1;
+
+}
+
+/*
+ * calculates the time it takes (in seconds) to go from one load_avg to another.
+ * This is used to determine how much time it would take for memory pressure to
+ * decay down from current PSI load_avg to the set thresholds.
+ */
+static int32_t calc_time_to_decay(struct psi_memory_pressure psi_memory)
+{
+    int32_t avg10_decay = 0, avg60_decay = 0;
+    float avg;
+
+    /* calc exponential time decay time for 10 seconds average */
+    avg = psi_memory.some.avg10 * EXP_1S_10S;
+    /*
+     * we need avg10 to be 0.00 and the least is 0.01 value. Calculate avg10
+     * time to decay until value is less than 0.009F to avoid floating
+     * point approximations.
+     */
+    while (avg > 0.009F) {
+        ++avg10_decay;
+        avg *= EXP_1S_10S;
+    }
+
+    /* calc exponential time decay time for 60 seconds average */
+    avg = psi_memory.some.avg60 * EXP_1S_60S;
+    /* acceptable pressure during 60 sec window is 18 ms (0.03% of 60 sec) */
+    while (avg > AVG60_EXP_THRESHOLD) {
+        ++avg60_decay;
+        avg *= EXP_1S_60S;
+    }
+
+    return (std::max(avg10_decay, avg60_decay));
+}
+
+static bool inline get_atomic_variable_bool(std::atomic<bool> &variable) {
+    return variable.load();
+}
+
+static void inline set_atomic_variable_bool(std::atomic<bool> &variable, bool val) {
+    variable.exchange(val);
+}
+
+/* conditionally sleep with timeout */
+static void wait_for_condition_timed(pthread_cond_t *condition,
+        pthread_mutex_t *mutex, const struct timespec *timeout_ts) {
+
+    if (!condition || !mutex)
+        return;
+
+    pthread_mutex_lock(mutex);
+    if (timeout_ts)
+        pthread_cond_timedwait(condition, mutex, timeout_ts);
+    else
+        /* timeout_ts = NULL means wait indefinitely with no timeout */
+        pthread_cond_wait(condition, mutex);
+    pthread_mutex_unlock(mutex);
+}
+
+/* wait until PSI averages decay to set thresholds */
+static void wait_until_pressure_decay(void)
+{
+    struct psi_memory_pressure pressure;
+    struct timespec timeout;
+    int32_t decay_time;
+    int res;
+
+    LOGD("waiting for pressure to decay...");
+
+    while(1) {
+        res = parse_system_psi_memory(&pressure);
+        if (res < 0) {
+            LOGE("parsing system psi memory failed, errno: %s",
+                    strerror(errno));
+            break;
+        }
+
+        /* check if we out of memory pressure thresholds */
+        if (pressure.some.avg10 == AVG10_EXP_THRESHOLD &&
+            pressure.some.avg60 <= AVG60_EXP_THRESHOLD) {
+            LOGD("PSI memory avgs are below the set thresholds");
+            break;
+        }
+
+        decay_time = calc_time_to_decay(pressure);
+
+        /* add another 2 seconds as extra cushion time for decay to settle */
+        decay_time += 2;
+
+        /* sleep until decay.. and break if CANCEL signal is sent */
+        clock_gettime(CLOCK_MONOTONIC, &timeout);
+        timeout.tv_sec += decay_time;
+
+        LOGI("sleeping for %d seconds for pressure to decay", decay_time);
+        wait_for_condition_timed(&thread_execution_cond,
+                &thread_execution_mutex, &timeout);
+
+        /* check if we recived new pressure event. If so, we may want to break
+         * from this pressure decay wait loop and return to pthread main loop.
+         */
+        if (get_atomic_variable_bool(cancel_check))
+            return;
+    }
+
+    LOGD("Out of pressure to decay");
+}
+
+/*
+ * Separate thread function that tracks psi pressure decay. This is done by
+ * taking system power wake_lock to make sure our sleep timers aren't freezed.
+ * Once PSI averages are decayed down below set thresholds, we go ahead checking
+ * for any free memory that can be given back to host VM.
+ *
+ * We can use CLOCK_BOOTTIME_ALARM clock type for this thread so that we can
+ * wakeup from suspend when we goto sleep. Bringing the system out from suspend
+ * could be power consuming. So maybe its best to hold wake_lock for certain
+ * perioid, do our job in reclaiming memory back to host and release wake_lock?
+ */
+static void* memtrack_thread_function(void *arg) {
+
+    (void)(arg);
+    struct timespec timeout;
+    uint64_t count = 0;
+    uint64_t mem_chunks_unplugged = 0;
+    uint64_t total_free = 0;
+    struct memory_snapshot mem_snap;
+    unsigned int wake_locked = 0;
+    int retry_count = 0;
+    int res;
+
+    while (1) {
+
+        /* lets wait for notify */
+        wait_for_condition_timed(&thread_execution_cond,
+                &thread_execution_mutex, NULL);
+
+startover:
+        if (!wake_locked && wake_lock_acquire())
+            wake_locked = 1;
+        mem_chunks_unplugged = 0;
+        clock_gettime(CLOCK_MONOTONIC, &timeout);
+        timeout.tv_sec += IDLE_WAIT_TIME_S;
+
+        set_atomic_variable_bool(wait_in_progress, true);
+
+        /* wait for IDLE_WAIT_TIME_S seconds of idle in memory pressure */
+        wait_for_condition_timed(&thread_execution_cond,
+                &thread_execution_mutex, &timeout);
+
+        /* check if we received any new memory pressure event during idle time wait */
+        if (get_atomic_variable_bool(cancel_check)) {
+            set_atomic_variable_bool(cancel_check, false);
+            set_atomic_variable_bool(wait_in_progress, false);
+            goto startover;
+        }
+
+        /*
+         * we have passed the IDLE_WAIT_TIME_S seconds of idle in memory pressure.
+         * its safe now to assume that no memory consuming usescases are running.
+         */
+
+        /* wait until pressure is decayed */
+        if (enable_pressure_decay_wait)
+            wait_until_pressure_decay();
+
+        /* check if we received any new memory pressure event during pressure decay wait */
+        if (get_atomic_variable_bool(cancel_check)) {
+            set_atomic_variable_bool(cancel_check, false);
+            set_atomic_variable_bool(wait_in_progress, false);
+            goto startover;
+        }
+
+        /* didn't receive any new memory pressure events, so time to release memory to host VM */
+
+        /* take snapshot of memory */
+        if (system_memory_snapshot(&mem_snap))
+            continue;
+
+        LOGI("MemFree before UNPLUG: %lu KB (Normal: %lu KB, Movable: %lu KB)",
+                mem_snap.sys_memfree_kb, mem_snap.normal_free_kb,
+                mem_snap.movable_free_kb);
+
+        LOGI("Movable inactive_file: %lu KB inactive_anon: %lu",
+                mem_snap.movable_inactive_file_kb,
+                mem_snap.movable_inactive_anon_kb);
+
+        total_free = mem_snap.movable_free_kb;
+
+        /*
+         * inactive_file pages can be reclaimed easily, and
+         * inactive_anon pages can be swapped and reused.
+         */
+        total_free += mem_snap.movable_inactive_file_kb +
+                mem_snap.movable_inactive_anon_kb;
+
+        count = (total_free / SIZE_1KB) / resolution;
+
+        LOGD("count: %lu mem_chunks_plugged %lu resolution %lu MB plugged_memory %lu MB",
+                count, mem_chunks_plugged.load(), resolution,
+                plugged_memory.load());
+
+        count = std::min(count, mem_chunks_plugged.load());
+
+        while(count-- > 0) {
+            res = memory_unplug_request(resolution);
+            if (res) {
+                LOGE("failed to unplug one memory chunk of %lu MB", resolution);
+                continue;
+            }
+            mem_chunks_unplugged++;
+        }
+
+        if (mem_chunks_unplugged)
+            LOGI("unplugged %lu memory chunks. Total memory unplugged: %lu MB",
+                    mem_chunks_unplugged, mem_chunks_unplugged * resolution);
+        plugged_memory -= (resolution * mem_chunks_unplugged);
+        mem_chunks_plugged -= mem_chunks_unplugged;
+
+        /* take memory snapshot after unplugging */
+        if (system_memory_snapshot(&mem_snap))
+            continue;
+
+        LOGD("MemFree after UNPLUG: %lu KB (Normal: %lu KB, Movable: %lu KB)",
+                mem_snap.sys_memfree_kb, mem_snap.normal_free_kb,
+                mem_snap.movable_free_kb);
+
+        if (mem_chunks_plugged && retry_count < MAX_UNPLUG_RETRY) {
+            ++retry_count;
+            LOGI("Retrying unplug after %d seconds (retry attempt: %d)",
+                    IDLE_WAIT_TIME_S, retry_count);
+            goto startover;
+        }
+        else {
+            if (retry_count == MAX_UNPLUG_RETRY)
+                LOGI("max retry attempt reached for unplugging!!");
+            if (!mem_chunks_plugged)
+                LOGI("unplugged all memory!!");
+            retry_count = 0;
+        }
+
+        /*
+         * TODO: should we keep checking until all plugged
+         * memory is unplugged? goto startover ?
+         */
+
+        if(wake_locked && !wake_unlock())
+            LOGE("failed to wake unlock");
+        else
+            wake_locked = 0;
+
+        /* now lets wait for notify again... */
+
+    }
+
+    LOGE("pthread exiting..");
+    return (void *)NULL;
+}
+
+/* epoll_wait for PSI events */
+static pressure_levels psi_wait_for_pressure(void) {
+
+    pressure_levels pressure_level = PRESSURE_NONE;
+    struct epoll_event events[PRESSURE_EVT_COUNT];
+    int nevents = 0;
+
+    do {
+        if (pressure_level == PRESSURE_NONE) {
+             /* Wait for events with no timeout */
+            nevents = epoll_wait(psi_epollfd, events, PRESSURE_EVT_COUNT, -1);
+        } else {
+            /* Assume that the memory pressure state will stay high for at least 1s.
+             * Within that 1s window, the memory pressure state can go up due to
+             * a different FD becoming available or it can go down when that window expires.
+             * Accordingly, there's no polling: just epoll_wait with a 1s timeout.
+             */
+            nevents = epoll_wait(psi_epollfd, events, PRESSURE_EVT_COUNT, 1000);
+            if (nevents == 0) {
+                pressure_level = PRESSURE_NONE;
+                return pressure_level;
+            }
+        }
+        /* keep waiting if interrupted */
+    } while (nevents == -1 && errno == EINTR);
+
+    if (nevents == -1) {
+        LOGE("epoll_wait failed while waiting for psi events, err: %s",
+                strerror(errno));
+        return PRESSURE_INVALID;
+    }
+    /* reset pressure_level and raise it based on received events */
+    pressure_level = PRESSURE_NONE;
+    for (int i = 0; i < nevents; i++) {
+        if (events[i].events & (EPOLLERR | EPOLLHUP)) {
+            /* should never happen unless psi got disabled in kernel */
+            LOGE("memory pressure events are not available anymore");
+            return PRESSURE_INVALID;
+        }
+
+        /* record the highest reported level */
+        if ((pressure_levels)events[i].data.u32 > pressure_level) {
+            pressure_level = (pressure_levels) events[i].data.u32;
+        }
+    }
+
+    return pressure_level;
+}
+
+static uint64_t get_timespec_delta_us(struct timespec start_tv, struct timespec end_tv) {
+    uint64_t start_us;
+    uint64_t end_us;
+
+    end_us = (end_tv.tv_nsec / NS_PER_US) + (end_tv.tv_sec * US_PER_SEC);
+    start_us = (start_tv.tv_nsec / NS_PER_US) + (start_tv.tv_sec * US_PER_SEC);
+
+    return (end_us - start_us);
+}
+
+/*
+ * PSI mainloop. Wait for PSI events and start adding memory blocks if free
+ * memory is below our set thresholds.
+ */
+static void psi_mainloop(void) {
+    pressure_levels pressure_level = PRESSURE_NONE;
+    struct timespec cur, start, end;
+    struct memory_snapshot mem_snap;
+    int res;
+
+    while (1) {
+        pressure_level = psi_wait_for_pressure();
+        clock_gettime(CLOCK_MONOTONIC, &cur);
+
+        if (pressure_level == PRESSURE_INVALID) {
+            LOGD("error waiting for PSI event");
+            break;
+        }
+
+        if (pressure_level == PRESSURE_NONE) {
+            LOGD("no PSI events received. epoll_wait again...");
+            continue;
+        }
+
+        LOGI("Received pressure event %s . TIME: %09ld.%09ld s",
+                psi_level_to_string(pressure_level),
+                cur.tv_sec, cur.tv_nsec/NS_PER_MS);
+
+        if (system_memory_snapshot(&mem_snap))
+            continue;
+
+        LOGI("MemFree : %lu KB (Normal: %lu KB, Movable: %lu KB)",
+                mem_snap.sys_memfree_kb, mem_snap.normal_free_kb,
+                mem_snap.movable_free_kb);
+
+        /*
+         * if memtrack pthread is waiting on pressure decay, notify to
+         * start over since we received new pressure event.
+         */
+        if (get_atomic_variable_bool(wait_in_progress))
+            set_atomic_variable_bool(cancel_check, true);
+
+        /* notify memtrack thread that we received new memory pressure event */
+        pthread_cond_signal(&thread_execution_cond);
+
+        /*
+         * TODO: add more checks for memory stats such as
+         * reclaimable memory, zram etc.
+         */
+        if ((pressure_level >= PRESSURE_EVT_5) &&        /* min threshold reached */
+            (plugged_memory.load() < (uint64_t)max_plugged_memory) &&    /* max memory boundary */
+            (mem_snap.movable_free_kb < ((uint64_t)resolution * SIZE_1KB) / 2)) {    /* only if movable < 1/2 * resolution */
+
+            LOGD("plugging-in %lu MB of memory", resolution);
+
+            clock_gettime(CLOCK_MONOTONIC, &start);
+            /*
+             * TODO: push memory_plug_request call onto separate thread
+             * so that the main thread can continue with PSI monitoring
+             */
+            res = memory_plug_request(resolution);
+            clock_gettime(CLOCK_MONOTONIC, &end);
+
+            if (res < 0) {
+                LOGE("memory plugin request for %lu MB failed", resolution);
+                continue;
+            }
+
+            plugged_memory += resolution;
+            mem_chunks_plugged++;
+
+            LOGD("plugged-in %lu MB of memory: SUCCESS", resolution);
+            LOGI("time taken to plug-in %lu MB: %lu us. TIME: %09ld.%09ld s",
+                    resolution, get_timespec_delta_us(start, end),
+                    end.tv_sec, end.tv_nsec/NS_PER_MS);
+
+            LOGI("Total memory pluged-in so far: %lu MB. Total memory chunks plugged-in: %lu",
+                    plugged_memory.load(), mem_chunks_plugged.load());
+
+            if (system_memory_snapshot(&mem_snap))
+                continue;
+
+            LOGD("MemFree after PLUG: %lu KB (Normal: %lu KB, Movable: %lu KB)",
+                    mem_snap.sys_memfree_kb, mem_snap.normal_free_kb,
+                    mem_snap.movable_free_kb);
+        }
+    }
+}
+
+/*
+ * vmrd could be treated as critical service which adds memory when needed, and
+ * must not be killed by oom-killer or any userspace memory killing daemon.
+ */
+static void set_oom_score_adj_self(int adj)
+{
+    char path[LINE_MAX] = "/proc/self/oom_score_adj";
+    char val[LINE_MAX];
+    int fd;
+
+    snprintf(val, sizeof(val), "%d", adj);
+
+    fd = open(path, O_WRONLY);
+    if (fd < 0) {
+        LOGE("couldn't open %s", path);
+        return;
+    }
+
+    if (write(fd, val, strlen(val)) < 0)
+        LOGE("Couldn't write %s to %s", val, path);
+
+    close(fd);
+}
+
+int main(void) {
+
+    int i;
+    pthread_t memtrack_thread;
+    std::string thresholds;
+    char str[LINE_MAX];
+    struct memory_snapshot mem_snap;
+
+    /* get system PAGE_SIZE */
+    sys_page_size = sysconf(_SC_PAGE_SIZE);
+    if (!sys_page_size) {
+        LOGE("getting system page size failed");
+        return -EINVAL;
+    }
+
+    readfile_buf_size = sys_page_size;
+
+    /* allocate buffer for file reads */
+    readfile_buf = (char *)calloc(readfile_buf_size, sizeof(*readfile_buf));
+    if (!readfile_buf) {
+        LOGE("buffer allocation for file reads failed");
+        return -ENOMEM;
+    }
+
+    if (memory_plug_init()) {
+        LOGE("memory plugin init failed");
+        return -EINVAL;
+    }
+
+    /* Initialize PSI monitors */
+    if (init_and_register_psi_events()) {
+        LOGE("registering to PSI events failed");
+        return -EINVAL;
+    }
+
+    pthread_condattr_init(&thread_execution_cond_attr);
+
+    /* set clock type to CLOCK_MONOTONIC */
+    pthread_condattr_setclock(&thread_execution_cond_attr, CLOCK_MONOTONIC);
+
+    /* initialize condition variable using the attribute */
+    pthread_cond_init(&thread_execution_cond, &thread_execution_cond_attr);
+
+    /* create pthread for downword memory pressure tracking */
+    if (pthread_create(&memtrack_thread, NULL, &memtrack_thread_function, NULL)) {
+        LOGE("error creating pthread for downward mem tracking");
+        return -EINVAL;
+    }
+
+    pthread_condattr_destroy(&thread_execution_cond_attr);
+
+    for (i = 0; i < PRESSURE_EVT_COUNT; i++) {
+        snprintf(str, sizeof(str), "%dMS ", psi_thresholds[i].threshold_ms);
+        thresholds.append(str);
+    }
+    LOGI("PSI init completed! Thresholds: %s", thresholds.c_str());
+
+    set_oom_score_adj_self(TARGET_OOM_SCORE_ADJ);
+
+    get_memory_plugin_resolution(&resolution);
+    get_max_memory_plugin_allowed(&max_plugged_memory);
+    LOGI("Memory plug-in resolution: %lu MB", resolution);
+    LOGI("Maximum memory plug-in allowed: %lu MB", max_plugged_memory);
+
+    if (system_memory_snapshot(&mem_snap))
+        return -EINVAL;
+
+    LOGI("MemFree : %lu KB (Normal: %lu KB, Movable: %lu KB)",
+            mem_snap.sys_memfree_kb, mem_snap.normal_free_kb,
+            mem_snap.movable_free_kb);
+
+    LOGI("Waiting for pressure events...");
+    psi_mainloop();
+
+    /* should not exit */
+    LOGE("Exiting...");
+
+    memory_plug_deinit();
+    return 0;
+}
-- 
2.7.4

