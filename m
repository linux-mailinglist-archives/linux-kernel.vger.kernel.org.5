Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45377DF263
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347201AbjKBM2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346867AbjKBM2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:28:36 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC4192;
        Thu,  2 Nov 2023 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698928093;
        bh=JhDM0hHkclBCyhKAbHGTgT35pK4WkuV0h1e8icW7lWY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=A6KPJeDbI0brYXWj4F0zSmDPgA7/QbJS5fOgxvEpk6zd67XM7ACk321xUQ4f228Bs
         1VHA6j/FA05S8ITzzSL/z1mSHdltjcKn3C5YNUGOYk3nn2oelAJABZ/wDP1H2xIuYp
         4JJJ4FPOZeqivVGwRBU23B8bLHQIPwZmh9QXNrrU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 45A7F1286171;
        Thu,  2 Nov 2023 08:28:13 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FQKm8ciW8mHk; Thu,  2 Nov 2023 08:28:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1698928093;
        bh=JhDM0hHkclBCyhKAbHGTgT35pK4WkuV0h1e8icW7lWY=;
        h=Message-ID:Subject:From:To:Date:From;
        b=A6KPJeDbI0brYXWj4F0zSmDPgA7/QbJS5fOgxvEpk6zd67XM7ACk321xUQ4f228Bs
         1VHA6j/FA05S8ITzzSL/z1mSHdltjcKn3C5YNUGOYk3nn2oelAJABZ/wDP1H2xIuYp
         4JJJ4FPOZeqivVGwRBU23B8bLHQIPwZmh9QXNrrU=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 96A7512819F3;
        Thu,  2 Nov 2023 08:28:12 -0400 (EDT)
Message-ID: <4e8e9b1fd477b46139a77cb57323df5a7476b1b9.camel@HansenPartnership.com>
Subject: [GIT PULL] first round of SCSI updates for the 6.4+ merge window
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Thu, 02 Nov 2023 08:28:10 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updates to the usual drivers (ufs, megaraid_sas, lpfc, target, ibmvfc,
scsi_debug) plus the usual assorted minor fixes and updates.  The major
change this time around is a prep patch for rethreading of the driver
reset handler API not to take a scsi_cmd structure which starts to
reduce various drivers' dependence on scsi_cmd in error handling.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Alex Henrie (1):
      scsi: imm: Add a module parameter for the transfer mode

Alice Chao (1):
      scsi: ufs: core: Fix race between force complete and ISR

Andy Shevchenko (1):
      scsi: ufs: ufs-pci: Switch to use acpi_evaluate_dsm_typed()

Bart Van Assche (6):
      scsi: ufs: core: Set the Command Priority (CP) flag for RT requests
      scsi: ufs: core: Simplify ufshcd_comp_scsi_upiu()
      scsi: ufs: core: Move the 4K alignment code into the Exynos driver
      scsi: ufs: core: Remove request tag range checks
      scsi: target: Remove the references to http://www.linux-iscsi.org/
      scsi: ufs: core: Include the SCSI ID in UFS command tracing output

Bragatheswaran Manickavel (1):
      scsi: ufs: core: Conversion to bool not necessary

Chandrakanth patil (4):
      scsi: megaraid_sas: Revision of Maintainer List
      scsi: megaraid_sas: Driver version update to 07.727.03.00-rc1
      scsi: megaraid_sas: Log message when controller reset is requested but not issued
      scsi: megaraid_sas: Increase register read retry rount from 3 to 30 for selected registers

Damien Le Moal (12):
      scsi: pm8001: Remove PM8001_READ_VPD
      scsi: pm8001: Remove PM8001_USE_TASKLET
      scsi: pm8001: Remove PM8001_USE_MSIX
      scsi: pm8001: Remove pm80xx_chip_intx_interrupt_enable/disable()
      scsi: pm8001: Simplify pm8001_chip_interrupt_enable/disable()
      scsi: pm8001: Introduce pm8001_handle_irq()
      scsi: pm8001: Introduce pm8001_kill_tasklet()
      scsi: pm8001: Introduce pm8001_init_tasklet()
      scsi: pm8001: Introduce pm8001_free_irq()
      scsi: libsas: Declare sas_discover_end_dev() static
      scsi: libsas: Declare sas_set_phy_speed() static
      scsi: libsas: Move local functions declarations to sas_internal.h

Dan Carpenter (1):
      scsi: ufs: qcom: Remove unnecessary check

Daniel Mentz (1):
      scsi: ufs: core: Leave space for '\0' in utf8 desc string

Douglas Gilbert (1):
      scsi: core: Handle depopulation and restoration in progress

Hannes Reinecke (22):
      scsi: megaraid: Fix up debug message in megaraid_abort_and_reset()
      scsi: aic79xx: Fix up NULL command in ahd_done()
      scsi: message: fusion: Initialize return value in mptfc_bus_reset()
      scsi: pmcraid: Add missing scsi_device_put() in pmcraid_eh_target_reset_handler()
      scsi: mpi3mr: Split off bus_reset function from host_reset
      scsi: pmcraid: Select device in pmcraid_eh_target_reset_handler()
      scsi: pmcraid: Select device in pmcraid_eh_bus_reset_handler()
      scsi: qla1280: Separate out host reset function from qla1280_error_action()
      scsi: sym53c8xx_2: Rework reset handling
      scsi: sym53c8xx_2: Split off bus reset from host reset
      scsi: ips: Do not try to abort command from host reset
      scsi: megaraid: Pass in NULL scb for host reset
      scsi: ibmvfc: Open-code reset loop for target reset
      scsi: aic79xx: Do not reference SCSI command when resetting device
      scsi: aic79xx: Make BUILD_SCSIID() a function
      scsi: aic7xxx: Do not reference SCSI command when resetting device
      scsi: aic7xxx: Make BUILD_SCSIID() a function
      scsi: bnx2fc: Do not rely on a SCSI command for LUN or target reset
      scsi: qedf: Use FC rport as argument for qedf_initiate_tmf()
      scsi: message: fusion: Open-code mptfc_block_error_handler() for bus reset
      scsi: message: fusion: Correct definitions for mptscsih_dev_reset()
      scsi: message: fusion: Simplify mptfc_block_error_handler()

Ilpo Järvinen (2):
      scsi: qla2xxx: Use FIELD_GET() to extract PCIe capability fields
      scsi: esas2r: Use FIELD_GET() to extract PCIe capability fields

Jiapeng Chong (1):
      scsi: fnic: Clean up some inconsistent indenting

Justin Stitt (2):
      scsi: message: fusion: Replace deprecated strncpy() with strscpy()
      scsi: message: fusion: Replace deprecated strncpy() with strscpy_pad()

Justin Tee (6):
      scsi: lpfc: Update lpfc version to 14.2.0.15
      scsi: lpfc: Introduce LOG_NODE_VERBOSE messaging flag
      scsi: lpfc: Validate ELS LS_ACC completion payload
      scsi: lpfc: Reject received PRLIs with only initiator fcn role for NPIV ports
      scsi: lpfc: Treat IOERR_SLI_DOWN I/O completion status the same as pci offline
      scsi: lpfc: Remove unnecessary zero return code assignment in lpfc_sli4_hba_setup

Kees Cook (1):
      scsi: target: tcmu: Annotate struct tcmu_tmr with __counted_by

Krzysztof Kozlowski (2):
      scsi: ufs: dt-bindings: common: Add OPP table
      scsi: ufs: core: Do not look for unsupported vdd-hba-max-microamp

Manivannan Sadhasivam (4):
      scsi: ufs: core: Add support for parsing OPP
      scsi: ufs: core: Add OPP support for scaling clocks and regulators
      scsi: ufs: qcom: Rename "hs_gear" to "phy_gear"
      scsi: ufs: qcom: Update PHY settings only when scaling to higher gears

Mike Christie (19):
      scsi: sr: Fix sshdr use in sr_get_events
      scsi: sd: Fix sshdr use in cache_type_store
      scsi: Fix sshdr use in scsi_cdl_enable
      scsi: Fix sshdr use in scsi_test_unit_ready
      scsi: sd: Fix scsi_mode_sense caller's sshdr use
      scsi: spi: Fix sshdr use
      scsi: rdac: Fix sshdr use
      scsi: rdac: Fix send_mode_select retry handling
      scsi: hp_sw: Fix sshdr use
      scsi: sd: Fix sshdr use in sd_spinup_disk
      scsi: sd: Fix sshdr use in read_capacity_16
      scsi: target: Export fabric driver direct submit settings
      scsi: target: core: Unexport target_queue_submission()
      scsi: target: Allow userspace to request direct submissions
      scsi: target: core: Kill transport_handle_cdb_direct()
      scsi: target: core: Move buffer clearing hack
      scsi: target: core: Move core_alua_check_nonop_delay() call
      scsi: target: Have drivers report if they support direct submissions
      scsi: target: iscs: Make write_pending_must_be_called a bit field

Muhammad Muzammil (1):
      scsi: cxgbi: Fix 'generated' typo

Nathan Chancellor (1):
      scsi: ibmvfc: Use 'unsigned int' for single-bit bitfields in 'struct ibmvfc_host'

Nitin Rawat (5):
      scsi: ufs: qcom: Configure SYS1CLK_1US_REG for UFS V4 and above
      scsi: ufs: qcom: Align programing of unipro clk attributes
      scsi: ufs: qcom: Add support to configure PA_VS_CORE_CLK_40NS_CYCLES
      scsi: ufs: qcom: Add multiple frequency support for MAX_CORE_CLK_1US_CYCLES
      scsi: ufs: qcom: Update MAX_CORE_CLK_1US_CYCLES for UFS V4 and above

Peter Wang (5):
      scsi: ufs: core: Fix abnormal scale up after scale down
      scsi: ufs: core: Fix abnormal scale up after last cmd finish
      scsi: ufs: core: Only suspend clock scaling if scaling down
      scsi: ufs: core: Remove dev cmd clock scaling busy
      scsi: ufs: core: WLUN send SSU timeout recovery

Ranjan Kumar (1):
      scsi: mpt3sas: Fix loop logic

Su Hui (1):
      scsi: snic: Remove useless code in snic_dr_clean_pending_req()

Tyrel Datwyler (11):
      scsi: ibmvfc: Add protocol field to target structure
      scsi: ibmvfc: Make discovery buffer per protocol channel group
      scsi: ibmvfc: Add protocol field to ibmvfc_channels
      scsi: ibmvfc: Make channel allocation generic
      scsi: ibmvfc: Track max and desired queue size in ibmvfc_channels
      scsi: ibmvfc: Rename ibmvfc_scsi_channels to ibmvfc_channels
      scsi: ibmvfc: Use a bitfield for boolean flags
      scsi: ibmvfc: Fix erroneous use of rtas_busy_delay with hcall return code
      scsi: ibmvfc: Limit max hw queues by num_online_cpus()
      scsi: ibmvfc: Implement channel queue depth and event buffer accounting
      scsi: ibmvfc: Remove BUG_ON in the case of an empty event pool

Uwe Kleine-König (1):
      scsi: ufs: Convert all platform drivers to return void

Wenchao Hao (13):
      scsi: core: Add comment to target_destroy in scsi_host_template
      scsi: core: Clean up scsi_dev_queue_ready()
      scsi: scsi_debug: Add param to control sdev's allow_restart
      scsi: scsi_debug: Add debugfs interface to fail target reset
      scsi: scsi_debug: Add new error injection type: Reset LUN failed
      scsi: scsi_debug: Add new error injection type: Abort Failed
      scsi: scsi_debug: Set command result and sense data if error is injected
      scsi: scsi_debug: Return failed value if error is injected
      scsi: scsi_debug: Time out command if the error is injected
      scsi: scsi_debug: Define grammar to remove added error injection
      scsi: scsi_debug: Add interface to manage error injection for a single device
      scsi: scsi_debug: Create scsi_debug directory in the debugfs filesystem
      scsi: libfc: Fix potential NULL pointer dereference in fc_lport_ptp_setup()

Yang Li (2):
      scsi: target: core: Fix kernel-doc comment
      scsi: pmcraid: Fix kernel-doc comment

Yihang Li (3):
      scsi: hisi_sas: Allocate DFX memory during dump trigger
      scsi: hisi_sas: Directly call register snapshot instead of using workqueue
      scsi: hisi_sas: Set debugfs_dir pointer to NULL after removing debugfs

And the diffstat:

 .../devicetree/bindings/ufs/ufs-common.yaml        |  35 +-
 MAINTAINERS                                        |   3 +-
 drivers/infiniband/ulp/srpt/ib_srpt.c              |   3 +
 drivers/message/fusion/mptctl.c                    |  19 +-
 drivers/message/fusion/mptfc.c                     |  94 ++--
 drivers/message/fusion/mptsas.c                    |  16 +-
 drivers/message/fusion/mptscsih.c                  |  55 +-
 drivers/message/fusion/mptscsih.h                  |   1 +
 drivers/scsi/Kconfig                               |  15 -
 drivers/scsi/aic7xxx/aic79xx_osm.c                 |  38 +-
 drivers/scsi/aic7xxx/aic7xxx_osm.c                 | 127 +++--
 drivers/scsi/bnx2fc/bnx2fc.h                       |   1 +
 drivers/scsi/bnx2fc/bnx2fc_hwi.c                   |  14 +-
 drivers/scsi/bnx2fc/bnx2fc_io.c                    |  94 ++--
 drivers/scsi/cxgbi/libcxgbi.c                      |   2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c        |  79 +--
 drivers/scsi/device_handler/scsi_dh_rdac.c         |  21 +-
 drivers/scsi/elx/efct/efct_lio.c                   |   5 +
 drivers/scsi/esas2r/esas2r_ioctl.c                 |  16 +-
 drivers/scsi/fnic/fnic_fcs.c                       |  11 +-
 drivers/scsi/hisi_sas/hisi_sas.h                   |   3 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c              |   7 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             | 116 ++---
 drivers/scsi/ibmvscsi/ibmvfc.c                     | 489 +++++++++++++-----
 drivers/scsi/ibmvscsi/ibmvfc.h                     |  50 +-
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c           |   3 +
 drivers/scsi/imm.c                                 |  70 +--
 drivers/scsi/imm.h                                 |   4 -
 drivers/scsi/ips.c                                 |  18 -
 drivers/scsi/libfc/fc_lport.c                      |   6 +
 drivers/scsi/libsas/sas_discover.c                 |   2 +-
 drivers/scsi/libsas/sas_init.c                     |   4 +-
 drivers/scsi/libsas/sas_internal.h                 |  12 +
 drivers/scsi/lpfc/lpfc_els.c                       |  23 +
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |   8 +-
 drivers/scsi/lpfc/lpfc_logmsg.h                    |   2 +-
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |  18 +-
 drivers/scsi/lpfc/lpfc_nvme.c                      |   6 +-
 drivers/scsi/lpfc/lpfc_sli.c                       |   4 +-
 drivers/scsi/lpfc/lpfc_version.h                   |   2 +-
 drivers/scsi/megaraid.c                            |  53 +-
 drivers/scsi/megaraid/megaraid_sas.h               |   4 +-
 drivers/scsi/megaraid/megaraid_sas_base.c          |   4 +-
 drivers/scsi/megaraid/megaraid_sas_fusion.c        |   3 +
 drivers/scsi/mpi3mr/mpi3mr_os.c                    |  57 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c                |   4 +-
 drivers/scsi/pm8001/pm8001_hwi.c                   |  89 +---
 drivers/scsi/pm8001/pm8001_init.c                  | 285 +++++-----
 drivers/scsi/pm8001/pm8001_sas.h                   |  11 +-
 drivers/scsi/pm8001/pm80xx_hwi.c                   |  59 +--
 drivers/scsi/pmcraid.c                             |  69 ++-
 drivers/scsi/qedf/qedf.h                           |   5 +-
 drivers/scsi/qedf/qedf_io.c                        |  75 +--
 drivers/scsi/qedf/qedf_main.c                      |  19 +-
 drivers/scsi/qla1280.c                             |  42 +-
 drivers/scsi/qla2xxx/qla_os.c                      |   5 +-
 drivers/scsi/qla2xxx/tcm_qla2xxx.c                 |   6 +
 drivers/scsi/scsi.c                                |   2 +-
 drivers/scsi/scsi_debug.c                          | 575 ++++++++++++++++++++-
 drivers/scsi/scsi_lib.c                            |  37 +-
 drivers/scsi/scsi_transport_spi.c                  |   4 +-
 drivers/scsi/sd.c                                  |  48 +-
 drivers/scsi/snic/snic_scsi.c                      |  14 +-
 drivers/scsi/sr.c                                  |   3 +-
 drivers/scsi/sym53c8xx_2/sym_glue.c                | 189 ++++---
 drivers/target/iscsi/Kconfig                       |   9 +-
 drivers/target/iscsi/iscsi_target.c                |   6 -
 drivers/target/iscsi/iscsi_target_configfs.c       |   5 +-
 drivers/target/iscsi/iscsi_target_erl1.c           |   2 +-
 drivers/target/iscsi/iscsi_target_tmr.c            |   2 +-
 drivers/target/loopback/tcm_loop.c                 |   4 +-
 drivers/target/sbp/sbp_target.c                    |   3 +
 drivers/target/target_core_alua.c                  |   1 -
 drivers/target/target_core_configfs.c              |  22 +
 drivers/target/target_core_device.c                |   1 +
 drivers/target/target_core_fabric_configfs.c       |  24 +
 drivers/target/target_core_transport.c             | 116 +++--
 drivers/target/target_core_user.c                  |   2 +-
 drivers/target/tcm_fc/tfc_conf.c                   |   3 +
 drivers/ufs/core/ufshcd.c                          | 268 +++++++---
 drivers/ufs/host/cdns-pltfrm.c                     |   5 +-
 drivers/ufs/host/tc-dwc-g210-pltfrm.c              |   6 +-
 drivers/ufs/host/ti-j721e-ufs.c                    |   6 +-
 drivers/ufs/host/ufs-exynos.c                      |  15 +-
 drivers/ufs/host/ufs-hisi.c                        |   5 +-
 drivers/ufs/host/ufs-mediatek.c                    |   7 +-
 drivers/ufs/host/ufs-qcom.c                        | 216 ++++++--
 drivers/ufs/host/ufs-qcom.h                        |  20 +-
 drivers/ufs/host/ufs-renesas.c                     |   6 +-
 drivers/ufs/host/ufs-sprd.c                        |   5 +-
 drivers/ufs/host/ufshcd-pci.c                      |   5 +-
 drivers/ufs/host/ufshcd-pltfrm.c                   |  93 +++-
 drivers/ufs/host/ufshcd-pltfrm.h                   |   2 +-
 drivers/usb/gadget/function/f_tcm.c                |   3 +
 drivers/vhost/scsi.c                               |   5 +-
 drivers/xen/xen-scsiback.c                         |   3 +
 include/scsi/libsas.h                              |  17 -
 include/scsi/scsi_host.h                           |   3 +
 include/target/target_core_base.h                  |  10 +
 include/target/target_core_fabric.h                |  19 +-
 include/trace/events/ufs.h                         |  15 +-
 include/ufs/ufs.h                                  |   3 +-
 include/ufs/ufshcd.h                               |  14 +-
 103 files changed, 2747 insertions(+), 1362 deletions(-)

James

