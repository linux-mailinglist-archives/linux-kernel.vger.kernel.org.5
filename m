Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14351754284
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbjGNSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjGNSY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 14:24:29 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3F7109;
        Fri, 14 Jul 2023 11:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689359062;
        bh=zyddbWsWsH/bWWKD3kEOS3zX/AYDVI0rVNZzmcL6tVM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=mEKLjJ8v1BZSelVPPJkBUTbNk719XIjPkpeJppHrHDM/fMC75rJLomp9E0H8MyzpQ
         yBlzf2OuMOnzqoiEaS+lmpb3oey/W3WNcirD4k8X5PnK45fOvxr5tCJym+rgcrty+9
         waBSSkdFWt/11u+Yk8B+uHqI6judeBV6THi+MegU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D3E6212860C6;
        Fri, 14 Jul 2023 14:24:22 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id NEGJklfxk07a; Fri, 14 Jul 2023 14:24:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1689359062;
        bh=zyddbWsWsH/bWWKD3kEOS3zX/AYDVI0rVNZzmcL6tVM=;
        h=Message-ID:Subject:From:To:Date:From;
        b=mEKLjJ8v1BZSelVPPJkBUTbNk719XIjPkpeJppHrHDM/fMC75rJLomp9E0H8MyzpQ
         yBlzf2OuMOnzqoiEaS+lmpb3oey/W3WNcirD4k8X5PnK45fOvxr5tCJym+rgcrty+9
         waBSSkdFWt/11u+Yk8B+uHqI6judeBV6THi+MegU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 270F812860BF;
        Fri, 14 Jul 2023 14:24:22 -0400 (EDT)
Message-ID: <256ab3441824d3c22930c3341492119ccfc1b701.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.5-rc1
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 14 Jul 2023 14:24:20 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a bunch of small driver fixes and a larger rework of zone disk
handling (which reaches into blk and nvme).  The aacraid array-bounds
fix is now critical since the security people turned on -Werror for
some build tests, which now fail without it.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Arnd Bergmann (1):
      scsi: aacraid: Avoid -Warray-bounds warning

Arthur Simchaev (1):
      scsi: ufs: core: Add support for qTimestamp attribute

Can Guo (1):
      scsi: ufs: core: Update contact email for monitor sysfs nodes

Damien Le Moal (5):
      scsi: block: Improve checks in blk_revalidate_disk_zones()
      scsi: block: virtio_blk: Set zone limits before revalidating zones
      scsi: block: nullblk: Set zone limits before revalidating zones
      scsi: nvme: zns: Set zone limits before revalidating zones
      scsi: sd_zbc: Set zone limits before revalidating zones

Dan Carpenter (2):
      scsi: qla2xxx: Fix error code in qla2x00_start_sp()
      scsi: qla2xxx: Silence a static checker warning

Julia Lawall (2):
      scsi: qla2xxx: Use vmalloc_array() and vcalloc()
      scsi: fnic: Use vmalloc_array() and vcalloc()

Maurizio Lombardi (1):
      scsi: scsi_debug: Remove dead code

Michael Kelley (1):
      scsi: storvsc: Handle SRB status value 0x30

Randy Dunlap (1):
      scsi: ufs: ufs-mediatek: Add dependency for RESET_CONTROLLER

Tuo Li (1):
      scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()

And the diffstat:

 Documentation/ABI/testing/sysfs-driver-ufs | 76 +++++++++++++-------------
 block/blk-zoned.c                          | 86 +++++++++++++++++-------------
 drivers/block/null_blk/zoned.c             | 16 ++----
 drivers/block/virtio_blk.c                 | 34 ++++++------
 drivers/nvme/host/zns.c                    |  9 ++--
 drivers/scsi/aacraid/aacraid.h             |  2 +-
 drivers/scsi/fnic/fnic_trace.c             |  2 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c           |  2 +
 drivers/scsi/qla2xxx/qla_def.h             |  1 -
 drivers/scsi/qla2xxx/qla_init.c            |  4 +-
 drivers/scsi/qla2xxx/qla_iocb.c            |  5 +-
 drivers/scsi/scsi_debug.c                  |  8 ---
 drivers/scsi/sd_zbc.c                      | 12 ++---
 drivers/scsi/storvsc_drv.c                 |  2 +
 drivers/ufs/core/ufshcd.c                  | 38 +++++++++++++
 drivers/ufs/host/Kconfig                   |  1 +
 include/uapi/scsi/scsi_bsg_ufs.h           | 25 +++++++++
 include/ufs/ufs.h                          |  1 +
 18 files changed, 193 insertions(+), 131 deletions(-)

With full diff below.

James

---

diff --git a/Documentation/ABI/testing/sysfs-driver-ufs b/Documentation/ABI/testing/sysfs-driver-ufs
index d5f44fc5b9dc..e487f969a15e 100644
--- a/Documentation/ABI/testing/sysfs-driver-ufs
+++ b/Documentation/ABI/testing/sysfs-driver-ufs
@@ -994,7 +994,7 @@ Description:	This file shows the amount of physical memory needed
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_lvl
 What:		/sys/bus/platform/devices/*.ufs/rpm_lvl
 Date:		September 2014
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry could be used to set or show the UFS device
 		runtime power management level. The current driver
 		implementation supports 7 levels with next target states:
@@ -1021,7 +1021,7 @@ Description:	This entry could be used to set or show the UFS device
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_target_dev_state
 What:		/sys/bus/platform/devices/*.ufs/rpm_target_dev_state
 Date:		February 2018
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry shows the target power mode of an UFS device
 		for the chosen runtime power management level.
 
@@ -1030,7 +1030,7 @@ Description:	This entry shows the target power mode of an UFS device
 What:		/sys/bus/platform/drivers/ufshcd/*/rpm_target_link_state
 What:		/sys/bus/platform/devices/*.ufs/rpm_target_link_state
 Date:		February 2018
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry shows the target state of an UFS UIC link
 		for the chosen runtime power management level.
 
@@ -1039,7 +1039,7 @@ Description:	This entry shows the target state of an UFS UIC link
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_lvl
 What:		/sys/bus/platform/devices/*.ufs/spm_lvl
 Date:		September 2014
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry could be used to set or show the UFS device
 		system power management level. The current driver
 		implementation supports 7 levels with next target states:
@@ -1066,7 +1066,7 @@ Description:	This entry could be used to set or show the UFS device
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_target_dev_state
 What:		/sys/bus/platform/devices/*.ufs/spm_target_dev_state
 Date:		February 2018
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry shows the target power mode of an UFS device
 		for the chosen system power management level.
 
@@ -1075,7 +1075,7 @@ Description:	This entry shows the target power mode of an UFS device
 What:		/sys/bus/platform/drivers/ufshcd/*/spm_target_link_state
 What:		/sys/bus/platform/devices/*.ufs/spm_target_link_state
 Date:		February 2018
-Contact:	Subhash Jadavani <subhashj@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This entry shows the target state of an UFS UIC link
 		for the chosen system power management level.
 
@@ -1084,7 +1084,7 @@ Description:	This entry shows the target state of an UFS UIC link
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/monitor_enable
 What:		/sys/bus/platform/devices/*.ufs/monitor/monitor_enable
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the status of performance monitor enablement
 		and it can be used to start/stop the monitor. When the monitor
 		is stopped, the performance data collected is also cleared.
@@ -1092,7 +1092,7 @@ Description:	This file shows the status of performance monitor enablement
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/monitor_chunk_size
 What:		/sys/bus/platform/devices/*.ufs/monitor/monitor_chunk_size
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file tells the monitor to focus on requests transferring
 		data of specific chunk size (in Bytes). 0 means any chunk size.
 		It can only be changed when monitor is disabled.
@@ -1100,7 +1100,7 @@ Description:	This file tells the monitor to focus on requests transferring
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_total_sectors
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_total_sectors
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how many sectors (in 512 Bytes) have been
 		sent from device to host after monitor gets started.
 
@@ -1109,7 +1109,7 @@ Description:	This file shows how many sectors (in 512 Bytes) have been
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_total_busy
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_total_busy
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how long (in micro seconds) has been spent
 		sending data from device to host after monitor gets started.
 
@@ -1118,7 +1118,7 @@ Description:	This file shows how long (in micro seconds) has been spent
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_nr_requests
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_nr_requests
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how many read requests have been sent after
 		monitor gets started.
 
@@ -1127,7 +1127,7 @@ Description:	This file shows how many read requests have been sent after
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_max
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_max
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the maximum latency (in micro seconds) of
 		read requests after monitor gets started.
 
@@ -1136,7 +1136,7 @@ Description:	This file shows the maximum latency (in micro seconds) of
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_min
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_min
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the minimum latency (in micro seconds) of
 		read requests after monitor gets started.
 
@@ -1145,7 +1145,7 @@ Description:	This file shows the minimum latency (in micro seconds) of
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_avg
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_avg
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the average latency (in micro seconds) of
 		read requests after monitor gets started.
 
@@ -1154,7 +1154,7 @@ Description:	This file shows the average latency (in micro seconds) of
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/read_req_latency_sum
 What:		/sys/bus/platform/devices/*.ufs/monitor/read_req_latency_sum
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the total latency (in micro seconds) of
 		read requests sent after monitor gets started.
 
@@ -1163,7 +1163,7 @@ Description:	This file shows the total latency (in micro seconds) of
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_total_sectors
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_total_sectors
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how many sectors (in 512 Bytes) have been sent
 		from host to device after monitor gets started.
 
@@ -1172,7 +1172,7 @@ Description:	This file shows how many sectors (in 512 Bytes) have been sent
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_total_busy
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_total_busy
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how long (in micro seconds) has been spent
 		sending data from host to device after monitor gets started.
 
@@ -1181,7 +1181,7 @@ Description:	This file shows how long (in micro seconds) has been spent
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_nr_requests
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_nr_requests
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows how many write requests have been sent after
 		monitor gets started.
 
@@ -1190,7 +1190,7 @@ Description:	This file shows how many write requests have been sent after
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_max
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_max
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the maximum latency (in micro seconds) of write
 		requests after monitor gets started.
 
@@ -1199,7 +1199,7 @@ Description:	This file shows the maximum latency (in micro seconds) of write
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_min
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_min
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the minimum latency (in micro seconds) of write
 		requests after monitor gets started.
 
@@ -1208,7 +1208,7 @@ Description:	This file shows the minimum latency (in micro seconds) of write
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_avg
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_avg
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the average latency (in micro seconds) of write
 		requests after monitor gets started.
 
@@ -1217,7 +1217,7 @@ Description:	This file shows the average latency (in micro seconds) of write
 What:		/sys/bus/platform/drivers/ufshcd/*/monitor/write_req_latency_sum
 What:		/sys/bus/platform/devices/*.ufs/monitor/write_req_latency_sum
 Date:		January 2021
-Contact:	Can Guo <cang@codeaurora.org>
+Contact:	Can Guo <quic_cang@quicinc.com>
 Description:	This file shows the total latency (in micro seconds) of write
 		requests after monitor gets started.
 
@@ -1226,7 +1226,7 @@ Description:	This file shows the total latency (in micro seconds) of write
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_presv_us_en
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_presv_us_en
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows if preserve user-space was configured
 
 		The file is read only.
@@ -1234,7 +1234,7 @@ Description:	This entry shows if preserve user-space was configured
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_shared_alloc_units
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_shared_alloc_units
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the shared allocated units of WB buffer
 
 		The file is read only.
@@ -1242,7 +1242,7 @@ Description:	This entry shows the shared allocated units of WB buffer
 What:		/sys/bus/platform/drivers/ufshcd/*/device_descriptor/wb_type
 What:		/sys/bus/platform/devices/*.ufs/device_descriptor/wb_type
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the configured WB type.
 		0x1 for shared buffer mode. 0x0 for dedicated buffer mode.
 
@@ -1251,7 +1251,7 @@ Description:	This entry shows the configured WB type.
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_buff_cap_adj
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_buff_cap_adj
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the total user-space decrease in shared
 		buffer mode.
 		The value of this parameter is 3 for TLC NAND when SLC mode
@@ -1262,7 +1262,7 @@ Description:	This entry shows the total user-space decrease in shared
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_max_alloc_units
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_max_alloc_units
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the Maximum total WriteBooster Buffer size
 		which is supported by the entire device.
 
@@ -1271,7 +1271,7 @@ Description:	This entry shows the Maximum total WriteBooster Buffer size
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_max_wb_luns
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_max_wb_luns
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the maximum number of luns that can support
 		WriteBooster.
 
@@ -1280,7 +1280,7 @@ Description:	This entry shows the maximum number of luns that can support
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_sup_red_type
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_sup_red_type
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	The supportability of user space reduction mode
 		and preserve user space mode.
 		00h: WriteBooster Buffer can be configured only in
@@ -1295,7 +1295,7 @@ Description:	The supportability of user space reduction mode
 What:		/sys/bus/platform/drivers/ufshcd/*/geometry_descriptor/wb_sup_wb_type
 What:		/sys/bus/platform/devices/*.ufs/geometry_descriptor/wb_sup_wb_type
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	The supportability of WriteBooster Buffer type.
 
 		===  ==========================================================
@@ -1310,7 +1310,7 @@ Description:	The supportability of WriteBooster Buffer type.
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_enable
 What:		/sys/bus/platform/devices/*.ufs/flags/wb_enable
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the status of WriteBooster.
 
 		== ============================
@@ -1323,7 +1323,7 @@ Description:	This entry shows the status of WriteBooster.
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_flush_en
 What:		/sys/bus/platform/devices/*.ufs/flags/wb_flush_en
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows if flush is enabled.
 
 		== =================================
@@ -1336,7 +1336,7 @@ Description:	This entry shows if flush is enabled.
 What:		/sys/bus/platform/drivers/ufshcd/*/flags/wb_flush_during_h8
 What:		/sys/bus/platform/devices/*.ufs/flags/wb_flush_during_h8
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	Flush WriteBooster Buffer during hibernate state.
 
 		== =================================================
@@ -1351,7 +1351,7 @@ Description:	Flush WriteBooster Buffer during hibernate state.
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_avail_buf
 What:		/sys/bus/platform/devices/*.ufs/attributes/wb_avail_buf
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the amount of unused WriteBooster buffer
 		available.
 
@@ -1360,7 +1360,7 @@ Description:	This entry shows the amount of unused WriteBooster buffer
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_cur_buf
 What:		/sys/bus/platform/devices/*.ufs/attributes/wb_cur_buf
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the amount of unused current buffer.
 
 		The file is read only.
@@ -1368,7 +1368,7 @@ Description:	This entry shows the amount of unused current buffer.
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_flush_status
 What:		/sys/bus/platform/devices/*.ufs/attributes/wb_flush_status
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the flush operation status.
 
 
@@ -1385,7 +1385,7 @@ Description:	This entry shows the flush operation status.
 What:		/sys/bus/platform/drivers/ufshcd/*/attributes/wb_life_time_est
 What:		/sys/bus/platform/devices/*.ufs/attributes/wb_life_time_est
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows an indication of the WriteBooster Buffer
 		lifetime based on the amount of performed program/erase cycles
 
@@ -1399,7 +1399,7 @@ Description:	This entry shows an indication of the WriteBooster Buffer
 
 What:		/sys/class/scsi_device/*/device/unit_descriptor/wb_buf_alloc_units
 Date:		June 2020
-Contact:	Asutosh Das <asutoshd@codeaurora.org>
+Contact:	Asutosh Das <quic_asutoshd@quicinc.com>
 Description:	This entry shows the configured size of WriteBooster buffer.
 		0400h corresponds to 4GB.
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0f9f97cdddd9..619ee41a51cc 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -442,7 +442,6 @@ struct blk_revalidate_zone_args {
 	unsigned long	*conv_zones_bitmap;
 	unsigned long	*seq_zones_wlock;
 	unsigned int	nr_zones;
-	sector_t	zone_sectors;
 	sector_t	sector;
 };
 
@@ -456,38 +455,34 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
 	struct gendisk *disk = args->disk;
 	struct request_queue *q = disk->queue;
 	sector_t capacity = get_capacity(disk);
+	sector_t zone_sectors = q->limits.chunk_sectors;
+
+	/* Check for bad zones and holes in the zone report */
+	if (zone->start != args->sector) {
+		pr_warn("%s: Zone gap at sectors %llu..%llu\n",
+			disk->disk_name, args->sector, zone->start);
+		return -ENODEV;
+	}
+
+	if (zone->start >= capacity || !zone->len) {
+		pr_warn("%s: Invalid zone start %llu, length %llu\n",
+			disk->disk_name, zone->start, zone->len);
+		return -ENODEV;
+	}
 
 	/*
 	 * All zones must have the same size, with the exception on an eventual
 	 * smaller last zone.
 	 */
-	if (zone->start == 0) {
-		if (zone->len == 0 || !is_power_of_2(zone->len)) {
-			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
-				disk->disk_name, zone->len);
-			return -ENODEV;
-		}
-
-		args->zone_sectors = zone->len;
-		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
-	} else if (zone->start + args->zone_sectors < capacity) {
-		if (zone->len != args->zone_sectors) {
+	if (zone->start + zone->len < capacity) {
+		if (zone->len != zone_sectors) {
 			pr_warn("%s: Invalid zoned device with non constant zone size\n",
 				disk->disk_name);
 			return -ENODEV;
 		}
-	} else {
-		if (zone->len > args->zone_sectors) {
-			pr_warn("%s: Invalid zoned device with larger last zone size\n",
-				disk->disk_name);
-			return -ENODEV;
-		}
-	}
-
-	/* Check for holes in the zone report */
-	if (zone->start != args->sector) {
-		pr_warn("%s: Zone gap at sectors %llu..%llu\n",
-			disk->disk_name, args->sector, zone->start);
+	} else if (zone->len > zone_sectors) {
+		pr_warn("%s: Invalid zoned device with larger last zone size\n",
+			disk->disk_name);
 		return -ENODEV;
 	}
 
@@ -526,11 +521,13 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
  * @disk:	Target disk
  * @update_driver_data:	Callback to update driver data on the frozen disk
  *
- * Helper function for low-level device drivers to (re) allocate and initialize
- * a disk request queue zone bitmaps. This functions should normally be called
- * within the disk ->revalidate method for blk-mq based drivers.  For BIO based
- * drivers only q->nr_zones needs to be updated so that the sysfs exposed value
- * is correct.
+ * Helper function for low-level device drivers to check and (re) allocate and
+ * initialize a disk request queue zone bitmaps. This functions should normally
+ * be called within the disk ->revalidate method for blk-mq based drivers.
+ * Before calling this function, the device driver must already have set the
+ * device zone size (chunk_sector limit) and the max zone append limit.
+ * For BIO based drivers, this function cannot be used. BIO based device drivers
+ * only need to set disk->nr_zones so that the sysfs exposed value is correct.
  * If the @update_driver_data callback function is not NULL, the callback is
  * executed with the device request queue frozen after all zones have been
  * checked.
@@ -539,9 +536,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 			      void (*update_driver_data)(struct gendisk *disk))
 {
 	struct request_queue *q = disk->queue;
-	struct blk_revalidate_zone_args args = {
-		.disk		= disk,
-	};
+	sector_t zone_sectors = q->limits.chunk_sectors;
+	sector_t capacity = get_capacity(disk);
+	struct blk_revalidate_zone_args args = { };
 	unsigned int noio_flag;
 	int ret;
 
@@ -550,13 +547,31 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	if (WARN_ON_ONCE(!queue_is_mq(q)))
 		return -EIO;
 
-	if (!get_capacity(disk))
-		return -EIO;
+	if (!capacity)
+		return -ENODEV;
+
+	/*
+	 * Checks that the device driver indicated a valid zone size and that
+	 * the max zone append limit is set.
+	 */
+	if (!zone_sectors || !is_power_of_2(zone_sectors)) {
+		pr_warn("%s: Invalid non power of two zone size (%llu)\n",
+			disk->disk_name, zone_sectors);
+		return -ENODEV;
+	}
+
+	if (!q->limits.max_zone_append_sectors) {
+		pr_warn("%s: Invalid 0 maximum zone append limit\n",
+			disk->disk_name);
+		return -ENODEV;
+	}
 
 	/*
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
 	 */
+	args.disk = disk;
+	args.nr_zones = (capacity + zone_sectors - 1) >> ilog2(zone_sectors);
 	noio_flag = memalloc_noio_save();
 	ret = disk->fops->report_zones(disk, 0, UINT_MAX,
 				       blk_revalidate_zone_cb, &args);
@@ -570,7 +585,7 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	 * If zones where reported, make sure that the entire disk capacity
 	 * has been checked.
 	 */
-	if (ret > 0 && args.sector != get_capacity(disk)) {
+	if (ret > 0 && args.sector != capacity) {
 		pr_warn("%s: Missing zones from sector %llu\n",
 			disk->disk_name, args.sector);
 		ret = -ENODEV;
@@ -583,7 +598,6 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	 */
 	blk_mq_freeze_queue(q);
 	if (ret > 0) {
-		blk_queue_chunk_sectors(q, args.zone_sectors);
 		disk->nr_zones = args.nr_zones;
 		swap(disk->seq_zones_wlock, args.seq_zones_wlock);
 		swap(disk->conv_zones_bitmap, args.conv_zones_bitmap);
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 635ce0648133..55c5b48bc276 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -162,21 +162,15 @@ int null_register_zoned_dev(struct nullb *nullb)
 	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
-
-	if (queue_is_mq(q)) {
-		int ret = blk_revalidate_disk_zones(nullb->disk, NULL);
-
-		if (ret)
-			return ret;
-	} else {
-		blk_queue_chunk_sectors(q, dev->zone_size_sects);
-		nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
-	}
-
+	blk_queue_chunk_sectors(q, dev->zone_size_sects);
+	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
 	blk_queue_max_zone_append_sectors(q, dev->zone_size_sects);
 	disk_set_max_open_zones(nullb->disk, dev->zone_max_open);
 	disk_set_max_active_zones(nullb->disk, dev->zone_max_active);
 
+	if (queue_is_mq(q))
+		return blk_revalidate_disk_zones(nullb->disk, NULL);
+
 	return 0;
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b47358da92a2..1fe011676d07 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -751,7 +751,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 {
 	u32 v, wg;
 	u8 model;
-	int ret;
 
 	virtio_cread(vdev, struct virtio_blk_config,
 		     zoned.model, &model);
@@ -806,6 +805,7 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 			vblk->zone_sectors);
 		return -ENODEV;
 	}
+	blk_queue_chunk_sectors(q, vblk->zone_sectors);
 	dev_dbg(&vdev->dev, "zone sectors = %u\n", vblk->zone_sectors);
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
@@ -814,26 +814,22 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
 		blk_queue_max_discard_sectors(q, 0);
 	}
 
-	ret = blk_revalidate_disk_zones(vblk->disk, NULL);
-	if (!ret) {
-		virtio_cread(vdev, struct virtio_blk_config,
-			     zoned.max_append_sectors, &v);
-		if (!v) {
-			dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
-			return -ENODEV;
-		}
-		if ((v << SECTOR_SHIFT) < wg) {
-			dev_err(&vdev->dev,
-				"write granularity %u exceeds max_append_sectors %u limit\n",
-				wg, v);
-			return -ENODEV;
-		}
-
-		blk_queue_max_zone_append_sectors(q, v);
-		dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
+	virtio_cread(vdev, struct virtio_blk_config,
+		     zoned.max_append_sectors, &v);
+	if (!v) {
+		dev_warn(&vdev->dev, "zero max_append_sectors reported\n");
+		return -ENODEV;
+	}
+	if ((v << SECTOR_SHIFT) < wg) {
+		dev_err(&vdev->dev,
+			"write granularity %u exceeds max_append_sectors %u limit\n",
+			wg, v);
+		return -ENODEV;
 	}
+	blk_queue_max_zone_append_sectors(q, v);
+	dev_dbg(&vdev->dev, "max append sectors = %u\n", v);
 
-	return ret;
+	return blk_revalidate_disk_zones(vblk->disk, NULL);
 }
 
 #else
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 12316ab51bda..ec8557810c21 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -10,12 +10,11 @@
 int nvme_revalidate_zones(struct nvme_ns *ns)
 {
 	struct request_queue *q = ns->queue;
-	int ret;
 
-	ret = blk_revalidate_disk_zones(ns->disk, NULL);
-	if (!ret)
-		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
-	return ret;
+	blk_queue_chunk_sectors(q, ns->zsze);
+	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
+
+	return blk_revalidate_disk_zones(ns->disk, NULL);
 }
 
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 7c6efde75da6..73b6ac0c01f5 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -2618,7 +2618,7 @@ struct aac_hba_info {
 struct aac_aifcmd {
 	__le32 command;		/* Tell host what type of notify this is */
 	__le32 seqnum;		/* To allow ordering of reports (if necessary) */
-	u8 data[1];		/* Undefined length (from kernel viewpoint) */
+	u8 data[];		/* Undefined length (from kernel viewpoint) */
 };
 
 /**
diff --git a/drivers/scsi/fnic/fnic_trace.c b/drivers/scsi/fnic/fnic_trace.c
index f3c3a26a1384..be0d7c57b242 100644
--- a/drivers/scsi/fnic/fnic_trace.c
+++ b/drivers/scsi/fnic/fnic_trace.c
@@ -465,7 +465,7 @@ int fnic_trace_buf_init(void)
 	fnic_max_trace_entries = (trace_max_pages * PAGE_SIZE)/
 					  FNIC_ENTRY_SIZE_BYTES;
 
-	fnic_trace_buf_p = (unsigned long)vzalloc(trace_max_pages * PAGE_SIZE);
+	fnic_trace_buf_p = (unsigned long)vcalloc(trace_max_pages, PAGE_SIZE);
 	if (!fnic_trace_buf_p) {
 		printk(KERN_ERR PFX "Failed to allocate memory "
 				  "for fnic_trace_buf_p\n");
diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 499849b58ee4..fdd7f69d87ef 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6944,7 +6944,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index d44c4d37b50b..4ae38305c15a 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4462,7 +4462,6 @@ struct qla_hw_data {
 
 	/* n2n */
 	struct fc_els_flogi plogi_els_payld;
-#define LOGIN_TEMPLATE_SIZE (sizeof(struct fc_els_flogi) - 4)
 
 	void            *swl;
 
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index c3dd8dd4f734..367fba27fe69 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -8434,7 +8434,7 @@ qla24xx_load_risc_flash(scsi_qla_host_t *vha, uint32_t *srisc_addr,
 		ql_dbg(ql_dbg_init, vha, 0x0163,
 		    "-> fwdt%u template allocate template %#x words...\n",
 		    j, risc_size);
-		fwdt->template = vmalloc(risc_size * sizeof(*dcode));
+		fwdt->template = vmalloc_array(risc_size, sizeof(*dcode));
 		if (!fwdt->template) {
 			ql_log(ql_log_warn, vha, 0x0164,
 			    "-> fwdt%u failed allocate template.\n", j);
@@ -8689,7 +8689,7 @@ qla24xx_load_risc_blob(scsi_qla_host_t *vha, uint32_t *srisc_addr)
 		ql_dbg(ql_dbg_init, vha, 0x0173,
 		    "-> fwdt%u template allocate template %#x words...\n",
 		    j, risc_size);
-		fwdt->template = vmalloc(risc_size * sizeof(*dcode));
+		fwdt->template = vmalloc_array(risc_size, sizeof(*dcode));
 		if (!fwdt->template) {
 			ql_log(ql_log_warn, vha, 0x0174,
 			    "-> fwdt%u failed allocate template.\n", j);
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index a1675f056a5c..730d8609276c 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -3073,7 +3073,8 @@ qla24xx_els_dcmd2_iocb(scsi_qla_host_t *vha, int els_opcode,
 	memset(ptr, 0, sizeof(struct els_plogi_payload));
 	memset(resp_ptr, 0, sizeof(struct els_plogi_payload));
 	memcpy(elsio->u.els_plogi.els_plogi_pyld->data,
-	    &ha->plogi_els_payld.fl_csp, LOGIN_TEMPLATE_SIZE);
+	       (void *)&ha->plogi_els_payld + offsetof(struct fc_els_flogi, fl_csp),
+	       sizeof(ha->plogi_els_payld) - offsetof(struct fc_els_flogi, fl_csp));
 
 	elsio->u.els_plogi.els_cmd = els_opcode;
 	elsio->u.els_plogi.els_plogi_pyld->opcode = els_opcode;
@@ -3911,7 +3912,7 @@ qla2x00_start_sp(srb_t *sp)
 
 	pkt = __qla2x00_alloc_iocbs(sp->qpair, sp);
 	if (!pkt) {
-		rval = EAGAIN;
+		rval = -EAGAIN;
 		ql_log(ql_log_warn, vha, 0x700c,
 		    "qla2x00_alloc_iocbs failed.\n");
 		goto done;
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 8c58128ad32a..9c0af50501f9 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -841,11 +841,6 @@ static int sdeb_zbc_nr_conv = DEF_ZBC_NR_CONV_ZONES;
 static int submit_queues = DEF_SUBMIT_QUEUES;  /* > 1 for multi-queue (mq) */
 static int poll_queues; /* iouring iopoll interface.*/
 
-static DEFINE_RWLOCK(atomic_rw);
-static DEFINE_RWLOCK(atomic_rw2);
-
-static rwlock_t *ramdisk_lck_a[2];
-
 static char sdebug_proc_name[] = MY_NAME;
 static const char *my_name = MY_NAME;
 
@@ -6818,9 +6813,6 @@ static int __init scsi_debug_init(void)
 	int k, ret, hosts_to_add;
 	int idx = -1;
 
-	ramdisk_lck_a[0] = &atomic_rw;
-	ramdisk_lck_a[1] = &atomic_rw2;
-
 	if (sdebug_ndelay >= 1000 * 1000 * 1000) {
 		pr_warn("ndelay must be less than 1 second, ignored\n");
 		sdebug_ndelay = 0;
diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index abbd08933ac7..a25215507668 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -831,7 +831,6 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	struct request_queue *q = disk->queue;
 	u32 zone_blocks = sdkp->early_zone_info.zone_blocks;
 	unsigned int nr_zones = sdkp->early_zone_info.nr_zones;
-	u32 max_append;
 	int ret = 0;
 	unsigned int flags;
 
@@ -876,6 +875,11 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 		goto unlock;
 	}
 
+	blk_queue_chunk_sectors(q,
+			logical_to_sectors(sdkp->device, zone_blocks));
+	blk_queue_max_zone_append_sectors(q,
+			q->limits.max_segments << PAGE_SECTORS_SHIFT);
+
 	ret = blk_revalidate_disk_zones(disk, sd_zbc_revalidate_zones_cb);
 
 	memalloc_noio_restore(flags);
@@ -888,12 +892,6 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 		goto unlock;
 	}
 
-	max_append = min_t(u32, logical_to_sectors(sdkp->device, zone_blocks),
-			   q->limits.max_segments << PAGE_SECTORS_SHIFT);
-	max_append = min_t(u32, max_append, queue_max_hw_sectors(q));
-
-	blk_queue_max_zone_append_sectors(q, max_append);
-
 	sd_zbc_print_zones(sdkp);
 
 unlock:
diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 659196a2f63a..7f12d931fe7c 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -318,6 +318,7 @@ enum storvsc_request_type {
 #define SRB_STATUS_INVALID_REQUEST	0x06
 #define SRB_STATUS_DATA_OVERRUN		0x12
 #define SRB_STATUS_INVALID_LUN		0x20
+#define SRB_STATUS_INTERNAL_ERROR	0x30
 
 #define SRB_STATUS(status) \
 	(status & ~(SRB_STATUS_AUTOSENSE_VALID | SRB_STATUS_QUEUE_FROZEN))
@@ -978,6 +979,7 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 	case SRB_STATUS_ERROR:
 	case SRB_STATUS_ABORTED:
 	case SRB_STATUS_INVALID_REQUEST:
+	case SRB_STATUS_INTERNAL_ERROR:
 		if (vm_srb->srb_status & SRB_STATUS_AUTOSENSE_VALID) {
 			/* Check for capacity change */
 			if ((asc == 0x2a) && (ascq == 0x9)) {
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 983fae84d9e8..129446775796 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8520,6 +8520,41 @@ static int ufshcd_device_params_init(struct ufs_hba *hba)
 	return ret;
 }
 
+static void ufshcd_set_timestamp_attr(struct ufs_hba *hba)
+{
+	int err;
+	struct ufs_query_req *request = NULL;
+	struct ufs_query_res *response = NULL;
+	struct ufs_dev_info *dev_info = &hba->dev_info;
+	struct utp_upiu_query_v4_0 *upiu_data;
+
+	if (dev_info->wspecversion < 0x400)
+		return;
+
+	ufshcd_hold(hba);
+
+	mutex_lock(&hba->dev_cmd.lock);
+
+	ufshcd_init_query(hba, &request, &response,
+			  UPIU_QUERY_OPCODE_WRITE_ATTR,
+			  QUERY_ATTR_IDN_TIMESTAMP, 0, 0);
+
+	request->query_func = UPIU_QUERY_FUNC_STANDARD_WRITE_REQUEST;
+
+	upiu_data = (struct utp_upiu_query_v4_0 *)&request->upiu_req;
+
+	put_unaligned_be64(ktime_get_real_ns(), &upiu_data->osf3);
+
+	err = ufshcd_exec_dev_cmd(hba, DEV_CMD_TYPE_QUERY, QUERY_REQ_TIMEOUT);
+
+	if (err)
+		dev_err(hba->dev, "%s: failed to set timestamp %d\n",
+			__func__, err);
+
+	mutex_unlock(&hba->dev_cmd.lock);
+	ufshcd_release(hba);
+}
+
 /**
  * ufshcd_add_lus - probe and add UFS logical units
  * @hba: per-adapter instance
@@ -8708,6 +8743,8 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
 	ufshcd_set_ufs_dev_active(hba);
 	ufshcd_force_reset_auto_bkops(hba);
 
+	ufshcd_set_timestamp_attr(hba);
+
 	/* Gear up to HS gear if supported */
 	if (hba->max_pwr_info.is_valid) {
 		/*
@@ -9749,6 +9786,7 @@ static int __ufshcd_wl_resume(struct ufs_hba *hba, enum ufs_pm_op pm_op)
 		ret = ufshcd_set_dev_pwr_mode(hba, UFS_ACTIVE_PWR_MODE);
 		if (ret)
 			goto set_old_link_state;
+		ufshcd_set_timestamp_attr(hba);
 	}
 
 	if (ufshcd_keep_autobkops_enabled_except_suspend(hba))
diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
index 16624ba08050..580c8d0bd8bb 100644
--- a/drivers/ufs/host/Kconfig
+++ b/drivers/ufs/host/Kconfig
@@ -72,6 +72,7 @@ config SCSI_UFS_QCOM
 config SCSI_UFS_MEDIATEK
 	tristate "Mediatek specific hooks to UFS controller platform driver"
 	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
+	depends on RESET_CONTROLLER
 	select PHY_MTK_UFS
 	select RESET_TI_SYSCON
 	help
diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_ufs.h
index 2801b65299aa..fd3f9e5ee241 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -70,6 +70,31 @@ struct utp_upiu_query {
 	__be32 reserved[2];
 };
 
+/**
+ * struct utp_upiu_query_v4_0 - upiu request buffer structure for
+ * query request >= UFS 4.0 spec.
+ * @opcode: command to perform B-0
+ * @idn: a value that indicates the particular type of data B-1
+ * @index: Index to further identify data B-2
+ * @selector: Index to further identify data B-3
+ * @osf4: spec field B-5
+ * @osf5: spec field B 6,7
+ * @osf6: spec field DW 8,9
+ * @osf7: spec field DW 10,11
+ */
+struct utp_upiu_query_v4_0 {
+	__u8 opcode;
+	__u8 idn;
+	__u8 index;
+	__u8 selector;
+	__u8 osf3;
+	__u8 osf4;
+	__be16 osf5;
+	__be32 osf6;
+	__be32 osf7;
+	__be32 reserved;
+};
+
 /**
  * struct utp_upiu_cmd - Command UPIU structure
  * @data_transfer_len: Data Transfer Length DW-3
diff --git a/include/ufs/ufs.h b/include/ufs/ufs.h
index 4e8d6240e589..198cb391f9db 100644
--- a/include/ufs/ufs.h
+++ b/include/ufs/ufs.h
@@ -170,6 +170,7 @@ enum attr_idn {
 	QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST    = 0x1E,
 	QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE        = 0x1F,
 	QUERY_ATTR_IDN_EXT_IID_EN		= 0x2A,
+	QUERY_ATTR_IDN_TIMESTAMP		= 0x30
 };
 
 /* Descriptor idn for Query requests */

