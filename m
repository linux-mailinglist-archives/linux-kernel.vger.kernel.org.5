Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739747910B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352033AbjIDFGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351892AbjIDFGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:06:39 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2200DED;
        Sun,  3 Sep 2023 22:06:35 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383KNQpV022733;
        Sun, 3 Sep 2023 22:06:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=pfpt0220; bh=ceM/v5/jwALpnAb8Ft4eRURyD1lk3R+Lf4JfY7xUI5w=;
 b=h+6Di9ljSA8ldMw20shyhGyMP52f0MkBqv9sI++hcImimdoTjqjzWvgKUyutFtj7Dmin
 vbd6ijKMX4eLCdXwBkTJ5tO9/V+YBRvQCKoSZy3Iu8GsLd9bt6j3n1nFQzXsDkQGUbi3
 tUzkBt3iboiNJChRuMsXtKiR/zkZJ7m209xDo2sd25QfR3HdQOJLy0i+tj8w/saxrkFk
 fD7J9ACl2MppMWtyZuIWTyMt8Bp7dgDe01ajEhJuXFlRW7EdB05HJ94EH0CJna5RIdMX
 fhCiBItv6/kCRueHbwY5ibGruOibvs3bic4lhK7Mqc74QID55nHBSILeVNKaWtK70oPg iw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3sv2dp4hqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 22:06:12 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Sep
 2023 22:06:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 3 Sep 2023 22:06:10 -0700
Received: from localhost.localdomain (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 399003F7062;
        Sun,  3 Sep 2023 22:06:05 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [RFC PATCH v3 0/8] Coresight for Kernel panic and watchdog reset 
Date:   Mon, 4 Sep 2023 10:35:40 +0530
Message-ID: <20230904050548.28047-1-lcherian@marvell.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Xw0KzPK7YEx1j_hA66poDHt7cA-19fAk
X-Proofpoint-GUID: Xw0KzPK7YEx1j_hA66poDHt7cA-19fAk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_02,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC v3 patch series is rebased on v6.5-rc7 and is dependent
on the below two patches.
- coresight: tmc: Make etr buffer mode user configurable from sysfs[1]
- coresight: Fix run time warnings while reusing ETR buffer[2]

Changelog from v2:
* ETR reserved buffer mode can be selected only through the new sysfs buffer
   mode and not by default. This would avoid any conflicts with normal usage.
* ETR buffer size in reserved mode is now always fixed to the maximum size of
  the reserved buffer and not user configurable. This avoids any conflicts with
  the default buffer size used in other ETR buffer modes.
* Introduced new ops called prevboot_ops to factor out common code in 
  tmc_etr_prepare_prevboot() and tmc_etb_prepare_prevboot().
  spin_lock/unlock invocations tmc_read_prepare_* are now in a single function.
* Added more stringent checks for selecting READ_PREVBOOT mode

Other misc changes: 
* Added more details to DT bindings documentation  
* Fixed unhandled case error in etm4_disable with CONFIG_WERROR 
* TMC register saving now uses standard accessor functions
* Added panic notifier unregistration
* memremap of reserved and metadata buffers are now with _WB attributes
* Cover letter title has been shortened.

Changelog from v1:
* V2 is a complete patchset with kernel panic trace tested on Linux 6.4.
  Details on testing with relevant console logs has been added for reference. 
* Two additional patches(patch 6 & 7) has been included to manage stopping of trace
  at the time of kernel panic.
* Few bug fixes.


RFC v1 is posted here:
https://lists.linaro.org/archives/list/coresight@lists.linaro.org/thread/6FANLYCCSZROLJMERS2MVCKFBBZOMGHJ/

  
Using Coresight for Kernel panic and Watchdog reset
===================================================
This RFC is about extending Linux coresight driver support to address
kernel panic and watchdog reset scenarios. This would help coresight
users to debug kernel panic and watchdog reset with the help of coresight
trace data.

Coresight trace capture: Kernel panic
-------------------------------------
From the coresight driver point of view, addressing the kernel panic
situation has four main requirements.

a. Support for allocation of trace buffer pages from reserved memory area.
   Platform can advertise this using a new device tree property added to
   relevant coresight nodes.

b. Support for stopping coresight blocks at the time of panic

c. Saving required metadata in the specified format

d. Support for reading trace data captured at the time of panic

Allocation of trace buffer pages from reserved RAM
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A new optional device tree property "memory-region" is added to the
ETR/ETF device nodes, that would give the base address and size of trace
buffer.

Static allocation of trace buffers would ensure that both IOMMU enabled
and disabled cases are handled. Also, platforms that support persistent
RAM will allow users to read trace data in the subsequent boot without
booting the crashdump kernel.  

Note:
For ETR sink devices, this reserved region will be used for both trace
capture and trace data retrieval.
For ETF sink devices, internal SRAM would be used for trace capture,
and they would be synced to reserved region for retrieval.

Note: Patches 1 & 2 adds support for this.

Disabling coresight blocks at the time of panic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
In order to avoid the situation of losing relevant trace data after a
kernel panic, it would be desirable to stop the coresight blocks at the
time of panic.

This can be achieved by configuring the comparator, CTI and sink
devices as below,  

Comparator(triggers on kernel panic) --->External out --->CTI --
								|	
		 ETR/ETF stop <------External In <--------------
Note:

* Patch 6 provides the necessary ETR configuration.
* Patch 7 provides the necessary ETM configuration.

Saving metadata at the time of kernel panic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Coresight metadata involves all additional data that are required for a 
successful trace decode in addition to the trace data. This involves
ETR/ETF, ETE register snapshot etc.

A new optional device property "memory-region" is added to
the ETR/ETF/ETE device nodes for this. 

Note: Patches 3 & 4 adds support for this.

Reading trace data captured at the time of panic
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Trace data captured at the time of panic, can be read from rebooted kernel
or from crashdump kernel using the below mentioned interface. 

Note: Patch 5 adds support for this.

Steps for reading trace data captured in previous boot
++++++++++++++++++++++++++++++++++++++++++++++++++++++
1. cd /sys/bus/coresight/devices/tmc_etrXX/

2. Change to special mode called, read_prevboot.

   #echo 1 > read_prevboot

3. Dump trace buffer data to a file,

   #dd if=/dev/tmc_etrXX of=~/cstrace.bin

4. Reset back to normal mode

   #echo 0 > read_prevboot

General flow of trace capture and decode incase of kernel panic 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1. Enable source and sink on all the cores using the sysfs interface.
   ETR sink will have trace buffers allocated from reserved memory,
   by selecting "resrv" buffer mode from sysfs.

2. Run relevant tests.

3. On a kernel panic, all coresight blocks are disabled, necessary 
   metadata is synced by kernel panic handler.

   System would eventually reboot or boot a crashdump kernel.

4. For  platforms that supports crashdump kernel, raw trace data can be
   dumped using the coresight sysfs interface from the crashdump kernel
   itself. Persistent RAM is not a requirement in this case.

5. For platforms that supports persistent RAM, trace data can be dumped
   using the coresight sysfs interface in the subsequent Linux boot.
   Crashdump kernel is not a requirement in this case. Persistent RAM
   ensures that trace data is intact across reboot.

Coresight trace capture: Watchdog reset 
---------------------------------------
The main difference between addressing the watchdog reset and kernel panic
case are below,

a. Saving coresight metadata need to be taken care by the
   SCP(system control processor) firmware in the specified format,
   instead of kernel.

b. Reserved memory region given by firmware for trace buffer and metadata
   has to be in persistent RAM. 
   Note: This is a requirement for watchdog reset case but optional 
   in kernel panic case.

Watchdog reset can be supported only on platforms that meet the above
two requirements.

Testing Kernel panic on Linux 6.5
---------------------------------
1. Configure CTI using sysfs interface 


  #./cti_setup.sh

  #cat cti_setup.sh 
cd /sys/bus/coresight/devices/

ap_cti_config () {
#ETM trig out[0] trigger to Channel 0
echo 0 4 > channels/trigin_attach
}

etf_cti_config () {
#ETF Flush in trigger from Channel 0
echo 0 1 > channels/trigout_attach
echo 1 > channels/trig_filter_enable
}

etr_cti_config () {
#ETR Flush in from Channel 0 
echo 0 1 > channels/trigout_attach
echo 1 > channels/trig_filter_enable
}

ctidevs=`find . -name "cti*"`

for i in $ctidevs
do
        cd $i

        connection=`find . -name "ete*"`
        if [ ! -z "$connection" ]
        then
                echo "AP CTI config for $i"
                ap_cti_config
        fi

        connection=`find . -name "tmc_etf*"`
        if [ ! -z "$connection" ]
        then
                echo "ETF CTI config for $i"
                etf_cti_config
        fi

        connection=`find . -name "tmc_etr*"`
        if [ ! -z "$connection" ]
        then
                echo "ETR CTI config for $i"
                etr_cti_config
        fi

        cd ..
done

Note: CTI connections are SOC specific and hence the above script is
added just for reference. 

2. Start Coresight tracing on cores 1 and 2 using sysfs interface

3. Run some application on core 1 
 #taskset -c 1 dd if=/dev/urandom of=/dev/null &

4. Invoke kernel panic on core 2
 #echo 1 > /proc/sys/kernel/panic
 #taskset -c 2 echo c > /proc/sysrq-trigger

5. From rebooted kernel, enable previous boot mode

 #echo 1 > /sys/bus/coresight/devices/tmc_etr0/read_prevboot 

6. Read trace data
 #dd if=/dev/tmc_etr0 of=/trace/cstrace.bin 

7. Run opencsd decoder tools/scripts to generate the instruction trace.

   Core 1 instruction trace dump:
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   >>
A                                  etm4_enable_hw: ffff800008ae1dd4
CONTEXT EL2                        etm4_enable_hw: ffff800008ae1dd4
I                                  etm4_enable_hw: ffff800008ae1dd4:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1dd8:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1ddc:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1de0:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1de4:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1de8:
d503233f   paciasp
I                                  etm4_enable_hw: ffff800008ae1dec:
a9be7bfd   stp     x29, x30, [sp, #-32]!
I                                  etm4_enable_hw: ffff800008ae1df0:
910003fd   mov     x29, sp
I                                  etm4_enable_hw: ffff800008ae1df4:
a90153f3   stp     x19, x20, [sp, #16]
I                                  etm4_enable_hw: ffff800008ae1df8:
2a0003f4   mov     w20, w0
I                                  etm4_enable_hw: ffff800008ae1dfc:
900085b3   adrp    x19, ffff800009b95000 <reserved_mem+0xc48>
I                                  etm4_enable_hw: ffff800008ae1e00:
910f4273   add     x19, x19, #0x3d0
I                                  etm4_enable_hw: ffff800008ae1e04:
f8747a60   ldr     x0, [x19, x20, lsl #3]
E                                  etm4_enable_hw: ffff800008ae1e08:
b4000140   cbz     x0, ffff800008ae1e30 <etm4_starting_cpu+0x50>
I    149.039572921                 etm4_enable_hw: ffff800008ae1e30:
a94153f3   ldp     x19, x20, [sp, #16]
I    149.039572921                 etm4_enable_hw: ffff800008ae1e34:
52800000   mov     w0, #0x0                        // #0
I    149.039572921                 etm4_enable_hw: ffff800008ae1e38:
a8c27bfd   ldp     x29, x30, [sp], #32

..snip

    149.052324811           chacha_block_generic: ffff800008642d80:
9100a3e0   add     x0,
I    149.052324811           chacha_block_generic: ffff800008642d84:
b86178a2   ldr     w2, [x5, x1, lsl #2]
I    149.052324811           chacha_block_generic: ffff800008642d88:
8b010803   add     x3, x0, x1, lsl #2
I    149.052324811           chacha_block_generic: ffff800008642d8c:
b85fc063   ldur    w3, [x3, #-4]
I    149.052324811           chacha_block_generic: ffff800008642d90:
0b030042   add     w2, w2, w3
I    149.052324811           chacha_block_generic: ffff800008642d94:
b8217882   str     w2, [x4, x1, lsl #2]
I    149.052324811           chacha_block_generic: ffff800008642d98:
91000421   add     x1, x1, #0x1
I    149.052324811           chacha_block_generic: ffff800008642d9c:
f100443f   cmp     x1, #0x11


   Core 2 instruction trace dump(kernel panic triggered core):
   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
A                                  etm4_enable_hw: ffff800008ae1dd4
CONTEXT EL2                        etm4_enable_hw: ffff800008ae1dd4
I                                  etm4_enable_hw: ffff800008ae1dd4:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1dd8:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1ddc:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1de0:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1de4:
d503201f   nop
I                                  etm4_enable_hw: ffff800008ae1de8:
d503233f   paciasp
I                                  etm4_enable_hw: ffff800008ae1dec:
a9be7bfd   stp     x29, x30, [sp, #-32]!
I                                  etm4_enable_hw: ffff800008ae1df0:
910003fd   mov     x29, sp
I                                  etm4_enable_hw: ffff800008ae1df4:
a90153f3   stp     x19, x20, [sp, #16]
I                                  etm4_enable_hw: ffff800008ae1df8:
2a0003f4   mov     w20, w0
I                                  etm4_enable_hw: ffff800008ae1dfc:
900085b3   adrp    x19, ffff800009b95000 <reserved_mem+0xc48>
I                                  etm4_enable_hw: ffff800008ae1e00:
910f4273   add     x19, x19, #0x3d0
I                                  etm4_enable_hw: ffff800008ae1e04:
f8747a60   ldr     x0, [x19, x20, lsl #3]
E                                  etm4_enable_hw: ffff800008ae1e08:
b4000140   cbz     x0, ffff800008ae1e30 <etm4_starting_cpu+0x50>
I    149.046243445                 etm4_enable_hw: ffff800008ae1e30:
a94153f3   ldp     x19, x20, [sp, #16]
I    149.046243445                 etm4_enable_hw: ffff800008ae1e34:
52800000   mov     w0, #0x0                        // #0
I    149.046243445                 etm4_enable_hw: ffff800008ae1e38:
a8c27bfd   ldp     x29, x30, [sp], #32
I    149.046243445                 etm4_enable_hw: ffff800008ae1e3c:
d50323bf   autiasp
E    149.046243445                 etm4_enable_hw: ffff800008ae1e40:
d65f03c0   ret
A                                ete_sysreg_write: ffff800008adfa18

..snip

I     149.05422547                          panic: ffff800008096300:
a90363f7   stp     x23, x24, [sp, #48]
I     149.05422547                          panic: ffff800008096304:
6b00003f   cmp     w1, w0
I     149.05422547                          panic: ffff800008096308:
3a411804   ccmn    w0, #0x1, #0x4, ne  // ne = any
N     149.05422547                          panic: ffff80000809630c:
540001e0   b.eq    ffff800008096348 <panic+0xe0>  // b.none
I     149.05422547                          panic: ffff800008096310:
f90023f9   str     x25, [sp, #64]
E     149.05422547                          panic: ffff800008096314:
97fe44ef   bl      ffff8000080276d0 <panic_smp_self_stop>
A                                           panic: ffff80000809634c
I     149.05422547                          panic: ffff80000809634c:
910102d5   add     x21, x22, #0x40
I     149.05422547                          panic: ffff800008096350:
52800020   mov     w0, #0x1                        // #1
E     149.05422547                          panic: ffff800008096354:
94166b8b   bl      ffff800008631180 <bust_spinlocks>
N    149.054225518                 bust_spinlocks: ffff800008631180:
340000c0   cbz     w0, ffff800008631198 <bust_spinlocks+0x18>
I    149.054225518                 bust_spinlocks: ffff800008631184:
f000a321   adrp    x1, ffff800009a98000 <pbufs.0+0xbb8>
I    149.054225518                 bust_spinlocks: ffff800008631188:
b9405c20   ldr     w0, [x1, #92]
I    149.054225518                 bust_spinlocks: ffff80000863118c:
11000400   add     w0, w0, #0x1
I    149.054225518                 bust_spinlocks: ffff800008631190:
b9005c20   str     w0, [x1, #92]
E    149.054225518                 bust_spinlocks: ffff800008631194:
d65f03c0   ret
A                                           panic: ffff800008096358


TODO
----
* Change ETM configuration done in patch #7 to new system configuration
  manager profile
* Change CTI sysfs script to system configuration manager profile
* Reading tracedata from crashdump kernel is not tested.
* Perf based trace capture and decode is not tested. 
 

Linu Cherian (8):
  dt-bindings: arm: coresight-tmc: Add "memory-region" property
  coresight: tmc-etr: Add support to use reserved trace memory
  coresight: core: Add provision for panic callbacks
  coresight: tmc: Enable panic sync handling
  coresight: tmc: Add support for reading tracedata from previous boot
  coresight: tmc: Stop trace capture on FlIn
  coresight: etm4x: Configure ETM to trigger on panic
  coresight: cti: Add CTI id for Neoverse N2 core CTI

 .../bindings/arm/arm,coresight-tmc.yaml       |  13 +
 drivers/hwtracing/coresight/coresight-core.c  |  32 ++
 .../hwtracing/coresight/coresight-cti-core.c  |   1 +
 .../coresight/coresight-etm4x-core.c          |  18 +-
 drivers/hwtracing/coresight/coresight-etm4x.h |  26 ++
 .../hwtracing/coresight/coresight-tmc-core.c  | 146 +++++++++-
 .../hwtracing/coresight/coresight-tmc-etf.c   | 126 +++++++-
 .../hwtracing/coresight/coresight-tmc-etr.c   | 274 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.h   |  48 +++
 include/linux/coresight.h                     |  25 ++
 10 files changed, 701 insertions(+), 8 deletions(-)

Links:
1. https://lore.kernel.org/linux-arm-kernel/20230818082112.554638-1-anshuman.khandual@arm.com/
2. https://lore.kernel.org/linux-arm-kernel/20230823042948.12879-1-lcherian@marvell.com/T/ 

-- 
2.41.0

