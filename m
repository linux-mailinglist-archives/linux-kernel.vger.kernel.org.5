Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFB77E027D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:06:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346472AbjKCMGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjKCMGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:06:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277F0D4F
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:06:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBB7C433C8;
        Fri,  3 Nov 2023 12:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699013167;
        bh=wsHxf5jxICYqrLoOGY14dOWNKEgq8vHFBOAB3ro9jv0=;
        h=Date:From:To:Cc:Subject:From;
        b=s51XFr3/yge34GxHqsrZu1E00OuP2stMFnz4NqRn5dQGvNd5+wafZ9CiJnk6XK5nl
         rguYxvBl4qW1OcYbVvMWjH4hnrLlwSXg/HergMrbNCrH4ZOxDPwJpbjpaCeG5JjZ9w
         PY0fnDdXrCouberyhF3ATOZLRtmT43ACA6jheaMc=
Date:   Fri, 3 Nov 2023 13:06:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [GIT PULL] Staging driver updates for 6.7-rc1
Message-ID: <ZUTiKqLbWEPTVZCf@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git tags/staging-6.7-rc1

for you to fetch changes up to a4000df5300fdbe10d84e3b70e2d6a98686310a9:

  Revert "staging: octeon: remove typedef in enum cvmx_spi_mode_t" (2023-10-30 09:56:27 +0100)

----------------------------------------------------------------
Staging driver updates for 6.7-rc1

Here is the big set of staging driver updates for 6.7-rc1.  A bit bigger
than 6.6 this time around, as it coincided with the Outreachy and
mentorship application process, so we got a bunch of new developers
sending in their first changes, which is nice to see.

Also in here is a removal of the qlge ethernet driver, and the rtl8192u
wireless driver.  Both of these were very old and no one was maintaining
them, the wireless driver removal was due to no one using it anymore,
and no hardware to be found, and is part of a larger effort to remove
unused and old wifi drivers from the system.

The qlge ethernet driver did have one user pop up after it was dropped,
and we are working with the network mainainers to figure out what tree
it will come back in from and who will be responsible for it, and if it
really is being used or not.  Odds are it will show up in a network
subsystem pull request after -rc1 is out, but we aren't sure yet.

Other smaller changes in here are:
  - Lots of vc04_services work by Umang to clean up the mess created by
    the rpi developers long ago, bringing it almost into good enough
    shape to get out of staging, hopefully next major release, it's
    getting close.
  - rtl8192e variable cleanups and removal of unused code and structures
  - vme_user coding style cleanups
  - other small coding style cleanups to lots of the staging drivers
  - octeon typedef removals, and then last-minute revert when it was
    found to break the build in some configurations (it's a hard driver
    to build properly, none of the normal automated testing catches it.)

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexon Oliveira (4):
      staging: vme_user: fix check alignment of open parenthesis in vme_fake.c
      staging: vme_user: fix check lines not ending with '(' in vme_fake.c
      staging: vme_user: fix check unnecessary blank lines in vme_fake.c
      staging: vme_user: fix check unnecessary space after a cast in vme_fake.c

Arnd Bergmann (1):
      staging: rtl8192e: remove bogus __packed annotations

Benjamin Poirier (2):
      staging: qlge: Update TODO
      staging: qlge: Retire the driver

Bragatheswaran Manickavel (1):
      staging: rtl8723bs: hal: Fix codespell-reported spelling mistakes

Calvince Otieno (9):
      staging: wlan-ng: remove unused function prototypes
      staging: wlan-ng: remove unnecessary helper function
      staging: wlan-ng: remove undefined function
      staging: wlan-ng: replace strncpy() with strscpy()
      staging: wlan-ng: replace pr_debug() with netdev_dbg()
      staging: wlan-ng: use netdev_dbg over pr_debug
      staging: wlan-ng: remove function prism2sta_ev_txexc
      staging: vme_user: replace strcpy with strscpy
      staging: bcm2835-audio: remove function snd_bcm2835_new_ctl()

Chengfeng Ye (1):
      staging: ks7010: disable bh on tx_dev_lock

Dorcas AnonoLitunya (6):
      Staging: sm750fb: Rename displayControlAdjust_SM750E
      Staging: sm750fb: Rename pModeParam
      Staging: sm750fb: Rename dispControl
      Staging: sm750fb: Rename programModeRegisters
      Staging: sm750fb: Rename ddk750_setModeTiming
      staging: sm750fb: Remove unused return variable in program_mode_registers()

Gary Rookard (1):
      staging: rtl8192e: renamed variable HTUpdateDefaultSetting

Gilbert Adikankwu (9):
      staging: vt6655: Rename variable bUpdateBBVGA
      staging: vt6655: Rename variable byCurrentCh
      staging: vt6655: Rename variable byCurPwr
      staging: vt6655: Rename variable byBBPreEDRSSI
      staging: vt6655: Rename variable byCWMaxMin
      staging: vt6655: Rename variable bySlot
      staging: vt6655: Rename variable bySIFS
      staging: vt6655: Rename variable byDIFS
      staging: vt6655: Rename variable byEIFS

Greg Kroah-Hartman (13):
      staging: fieldbus: make controller_class constant
      staging: vme_user: make vme_user_sysfs_class constant
      staging: pi433: make pi433_class constant
      staging: greybus: raw: make raw_class constant
      staging: greybus: authentication: make cap_class constant
      staging: greybus: fw-management: make fw_mgmt_class constant
      staging: rtl8192u: remove entry from Makefile
      Revert "staging: octeon: remove typedef in structs cvmx_pip_port_status_t and cvmx_pko_port_status_t"
      Revert "staging: octeon: remove typedef in enum cvmx_pko_status_t"
      Revert "staging: octeon: remove typedef in struct cvmx_pko_lock_t"
      Revert "staging: octeon: remove typedef in enum cvmx_pow_wait_t"
      Revert "staging: octeon: remove typedef in enum cvmx_helper_interface_mode_t"
      Revert "staging: octeon: remove typedef in enum cvmx_spi_mode_t"

Gustavo A. R. Silva (1):
      staging: greybus: Add __counted_by for struct apr_rx_buf and use struct_size()

Heiner Kallweit (1):
      staging: olpc_dcon: Remove I2C_CLASS_DDC support

Jinjie Ruan (1):
      staging: vme_user: Use list_for_each_entry() helper

Jonathan Bergh (3):
      staging: vme_user: Remove unused (commented) code causing unnecessary checkpatch warning
      staging: vme_user: Remove spurious newlines between define statements
      staging: vme_user: Fix various comment formatting issues including comment content

Michael Straube (2):
      staging: rtl8192e: clean up comparisons to NULL
      staging: vme_user: prefer strscpy over strcpy

Nandha Kumar Singaram (5):
      staging: qlge: Replace the occurrences of (1<<x) by BIT(x)
      staging: greybus: Modify lines end with a '('
      staging: greybus: camera: Alignment should match open parenthesis
      staging: greybus: camera: Modify lines end with a '('
      staging: greybus: bootrom: fixed prefer using ftrace warning

Oliver Crumrine (6):
      staging: octeon: remove typedef in enum cvmx_spi_mode_t
      staging: octeon: remove typedef in enum cvmx_helper_interface_mode_t
      staging: octeon: remove typedef in enum cvmx_pow_wait_t
      staging: octeon: remove typedef in struct cvmx_pko_lock_t
      staging: octeon: remove typedef in enum cvmx_pko_status_t
      staging: octeon: remove typedef in structs cvmx_pip_port_status_t and cvmx_pko_port_status_t

Pavan Bobba (15):
      staging: vt6655: Type encoding info dropped from array name "byVT3253B0_"
      staging: vt6655: Type encoding info dropped from variable "byRFType"
      staging: vt6655: Type encoding info dropped from array name "abyBBVGA"
      staging: vt6655: Type encoding info dropped from variable name "byBBVGACurrent"
      staging: vt6655: Type encoding info dropped from variable name "byBBVGANew"
      staging: vt6655: Type encoding info dropped from array name "cwRXBCNTSFOff"
      staging: vt6655: Type encoding info dropped from function name "s_vCalculateOFDMRParameter"
      staging: vt6655: Type encoding info dropped from variable name "pbyTxRate"
      staging: vt6655: Type encoding info dropped from variable name "pbyRsvTime"
      staging: vt6655: Type encoding info dropped from function name "CARDbSetPhyParameter"
      staging: vt6655: Type encoding info dropped from variable name "byPacketType"
      staging: vt6655: Type encoding info dropped from function name "CARDbyGetPktType"
      staging: vt6655: Type encoding info dropped from function name "CARDvSetRSPINF"
      staging: vt6655: Type encoding info dropped from function name "CARDbUpdateTSF"
      staging: vt6655: Type encoding info dropped from variable name "byRxRate"

Philipp Hortmann (107):
      staging: rtl8192e: Remove unsupported mode IW_MODE_ADHOC
      staging: rtl8192e: Remove useless equation in debug output
      staging: rtl8192e: Use standard ieee80211 function in rtllib_rx_mgt()
      staging: rtl8192e: Use standard function in rtllib_process_probe_response()
      staging: rtl8192e: Use standard function in rtllib_rx_check_duplicate()
      staging: rtl8192e: Use standard function in softmac_mgmt_xmit()
      staging: rtl8192e: Replace rtl92e_disable_irq with rtl92e_irq_disable
      staging: rtl8192e: Replace rtl92e_enable_irq with rtl92e_irq_enable
      staging: rtl8192e: Remove rtllib_get_payload()
      staging: rtl8192e: Replace struct rtllib_hdr_1addr with ieee80211_hdr
      staging: rtl8192e: Replace struct rtllib_hdr_3addr in rtllib_rx.c
      staging: rtl8192e: Replace struct rtllib_hdr_3addr in rtl819x_BAProc.c
      staging: rtl8192e: Replace struct rtllib_hdr_3addr in rtllib_softmac.c
      staging: rtl8192e: Replace struct rtllib_hdr_3addr in r8192E_dev.c
      staging: rtl8192e: Replace struct rtllib_hdr_3addr in structs of rtllib.h
      staging: rtl8192e: Remove unused struct rtllib_hdr and two enums
      staging: rtl8192e: Replace struct rtllib_hdr_4addr in rtllib_crypt*.c
      staging: rtl8192e: Remove struct rtllib_hdr_4addr
      staging: rtl8192e: Remove struct rtllib_hdr_3addrqos
      staging: rtl8192e: Remove struct rtllib_hdr_4addrqos
      staging: rtl8192e: Remove struct rtllib_pspoll_hdr
      staging: rtl8192e: Replace management subframe types with IEEE80211_STYPE_*
      staging: rtl8192e: Replace control subframe types with IEEE80211_STYPE_*
      staging: rtl8192e: Replace usage of RTLLIB_FCTL_DSTODS with function
      staging: rtl8192e: Replace frame control constants with IEEE80211_FCTL_*
      staging: rtl8192e: Fix alignment of structs in rtllib.h to two
      staging: rtl8192e: Fix compiler warning truncated writing of iwe.u.name
      staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtllib_tx.c
      staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtllib_rx.c
      staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtl_core.c
      staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtl_cam.c
      staging: rtl8192e: Remove mode IW_MODE_ADHOC from rtllib_softmac.c
      staging: rtl8192e: Remove delayed_work start_ibss_wq
      staging: rtl8192e: Remove rtllib_stop_send_beacons
      staging: rtl8192e: Put kfree() to end of rtllib_softmac_free()
      staging: rtl8192e: Remove mutex from rtllib_softmac_free()
      staging: rtl8192e: Unlock mutex for one line in rtllib_stop_protocol()
      staging: rtl8192e: Resolve circular locking with rx_pkt_pending_timer
      staging: rtl8192e: Remove ibss_maxjoin_chal
      staging: rtl8192e: Remove dead code from _rtl92e_if_check_reset()
      staging: rtl8192e: Remove RESET_TYPE_NORMAL
      staging: rtl8192e: Remove broken function _rtl92e_if_silent_reset()
      staging: rtl8192e: Remove unused variable rst_progress
      staging: rtl8192e: Remove unused variable reset_in_progress
      staging: rtl8192e: Remove unused parameter from _rtl92e_sta_up()
      staging: rtl8192e: Remove unused parameter from _rtl92e_up()
      staging: rtl8192e: Remove unused variable is_silent_reset
      staging: rtl8192e: Remove unused variables priv->reset_count and reset_cnt
      staging: rtl8192e: Remove r8192_private_handler _rtl92e_wx_force_reset()
      staging: rtl8192e: Remove unused function rtl92e_dm_backup_state()
      staging: rtl8192e: Remove unused function rtl92e_dm_restore_state()
      staging: rtl8192e: Remove unused function rtl92e_cam_restore()
      staging: rtl8192e: Remove unused variable last_ratr
      staging: rtl8192e: Remove unused variable rate_adaptive_disabled
      staging: rtl8192e: Remove unused variable rfc_txpowertrackingindex
      staging: rtl8192e: Remove unused/constant parameter mesh_flag and shutdown
      staging: rtl8192e: Remove constant parameter from rtllib_stop_protocol()
      staging: rtl8192e: Remove function _rtl92e_wx_set_rawtx()
      staging: rtl8192e: Remove equation in function rtllib_xmit_inter()
      staging: rtl8192e: Remove function rtllib_start_monitor_mode()
      staging: rtl8192e: Remove unused variable raw_tx
      staging: rtl8192e: Remove unused parameter mesh_flag
      staging: rtl8192e: Remove function _rtl92e_wx_set_promisc_mode()
      staging: rtl8192e: Remove function _rtl92e_wx_get_promisc_mode()
      staging: rtl8192e: Remove constant variable fltr_src_sta_frame
      staging: rtl8192e: Remove constant variable promiscuous_on
      staging: rtl8192e: Remove constant variable net_promiscuous_md
      staging: rtl8192e: Remove constant variable bToOtherSTA
      staging: rtl8192e: Remove function _rtl92e_wx_set_force_lps()
      staging: rtl8192e: Remove function _rtl92e_wx_set_lps_awake_interval()
      staging: rtl8192e: Remove constant variable reg_max_lps_awake_intvl
      staging: rtl8192e: Remove function _rtl92e_wx_adapter_power_status()
      staging: rtl8192e: Remove constant variable ps_force
      staging: rtl8192e: Remove function _rtl92e_wx_set_scan_type()
      staging: rtl8192e: Remove unchanged variable active_scan
      staging: rtl8192e: Remove function _rtl92e_wx_set_debug()
      staging: rtl8192e: Remove unused variable rt_global_debug_component
      staging: rtl8192e: Remove unused file rtllib_debug.h
      staging: rtl8192u: Remove broken driver
      staging: rtl8192e: Remove unchanged variable dig_enable_flag
      staging: rtl8192e: Remove unchanged variable dig_algorithm
      staging: rtl8192e: Remove _rtl92e_dm_ctrl_initgain_byrssi_false_alarm()
      staging: rtl8192e: Remove unchanged variable dig_algorithm_switch
      staging: rtl8192e: Remove unused variable dig_state
      staging: rtl8192e: Remove unused enums dm_dig_sta and dm_dig_alg
      staging: rtl8192e: Replace BIT0 to BIT9 with BIT(0) to BIT(9)
      staging: rtl8192e: Replace BIT10 to BIT31 with BIT(10) to BIT(31)
      staging: rtl8192e: Remove unused variables ucReserved and friends
      staging: rtl8192e: Remove written but unevaluated variable ucUP
      staging: rtl8192e: Remove unused variables from union tspec_body
      staging: rtl8192e: Replace union tspec_body including embedded struct
      staging: rtl8192e: Replace union qos_tsinfo with embedded struct
      staging: rtl8192e: Remove unused struct acm
      staging: rtl8192e: Remove last three parameters of MakeTSEntry()
      staging: rtl8192e: Remove unused union qos_tclas
      staging: rtl8192e: Remove unused variables TClasProc and TClasNum
      staging: rtl8192e: Remove HTIOTActIsDisableMCS14()
      staging: rtl8192e: Remove HTIOTActIsDisableMCS15()
      staging: rtl8192e: Remove HTIOTActIsDisableMCSTwoSpatialStream()
      staging: rtl8192e: Remove HTIOTActIsDisableEDCATurbo()
      staging: rtl8192e: Remove loops with constant MAX_RX_QUEUE
      staging: rtl8192e: Convert array rx_ring[] to variable rx_ring
      staging: rtl8192e: Convert array rx_buf[][] to array rx_buf[]
      staging: rtl8192e: Convert array rx_ring_dma[] to variable rx_ring_dma
      staging: rtl8192e: Convert array rx_idx[] to variable rx_idx
      staging: rtl8192e: Remove unused constants starting with MAX_RX_QUEUE
      staging: rtl8192e: Fix line break issue at priv->rx_buf[priv->rx_idx]

Ricardo B. Marliere (1):
      staging: vc04_services: use snprintf instead of sprintf

Ricardo Lopes (1):
      staging: qlge: Replace strncpy with strscpy

Soumya Negi (12):
      staging: rts5208: Refactor macros to static inline functions
      staging: rts5208: Remove macros scsi_lock(), scsi_unlock()
      staging: vme_user: Correct spelling mistakes in comments
      staging: vme_user: Fix unbalanced {} in if-else blocks
      staging: vme_user: Add spaces around '*'
      staging: vme_user: Add spaces around '<<' operator
      staging: gdm724x: Add blank line after declaration
      staging: vme_user: Replace printk() with dev_*()
      staging: vme_user: Use __func__ instead of function name
      staging: vme_user: Remove printk() in find_bridge()
      staging: vme_user: Remove NULL-checks
      staging: vme_user: Use dev_err() in vme_check_window()

Tree Davies (34):
      Staging: rtl8192e: Rename variable pRxTs in function rx_ts_delete_ba()
      Staging: rtl8192e: Rename variable pTS in function rtllib_rx_ADDBAReq()
      Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_DELBA()
      Staging: rtl8192e: Rename variable pRxTs in function rtllib_ts_init_del_ba()
      Staging: rtl8192e: Rename variable pRxTs in function rtllib_rx_ba_inact_timeout()
      Staging: rtl8192e: Rename variable pRxTs in function RxPktPendingTimeout()
      Staging: rtl8192e: Rename variable pTS in function ResetRxTsEntry()
      Staging: rtl8192e: Rename variable pRxTS in function TSInitialize()
      Staging: rtl8192e: Rename variable tmp in function GetTs()
      Staging: rtl8192e: Rename variable pRxTS in function RemoveTsEntry()
      Staging: rtl8192e: Rename variable pTS in function prototype rtllib_FlushRxTsPendingPkts()
      Staging: rtl8192e: Rename variable pTS in function AddReorderEntry()
      Staging: rtl8192e: Rename variable pTS in function rtllib_FlushRxTsPendingPkts()
      Staging: rtl8192e: Rename variable pTS in function RxReorderIndicatePacket()
      Staging: rtl8192e: Rename variable pRxTS in function rtllib_rx_check_duplicate()
      Staging: rtl8192e: Rename variable pTS in function rtllib_rx_InfraAdhoc()
      Staging: rtl8192e: Rename variable Time
      Staging: rtl8192e: Rename variable pAdmittedBa
      Staging: rtl8192e: Rename variable pPendingBa
      Staging: rtl8192e: Rename variable Dst
      Staging: rtl8192e: Rename variable pPendingBA
      Staging: rtl8192e: Rename variable Addr
      Staging: rtl8192e: Rename variable pStatusCode
      Staging: rtl8192e: Rename variable Policy
      Staging: rtl8192e: Rename function GetTs()
      Staging: rtl8192e: Rename function TSInitialize
      Staging: rtl8192e: Rename variable StatusCode
      Staging: rtl8192e: Rename variable pTSInfo
      Staging: rtl8192e: Rename variable bCurrentHTSupport
      Staging: rtl8192e: Rename variable pBA
      Staging: rtl8192e: Rename variable pBa
      Staging: rtl8192e: Rename variable TSInfo
      Staging: rtl8192e: Rename variable ReasonCode
      Staging: rtl8192e: Rename variable pTS

Umang Jain (19):
      staging: vc04_services: bcm2835-camera: Explicitly set DMA mask
      staging: vc04_services: bcm2835-audio: Explicitly set DMA mask
      staging: vc04_services: vchiq_arm: Add new bus type and device type
      staging: vc04_services: vchiq_arm: Register vchiq_bus_type
      staging: bcm2835-camera: Register bcm2835-camera with vchiq_bus_type
      staging: bcm2835-audio: Register bcm2835-audio with vchiq_bus_type
      staging: vc04_services: vchiq_bus: Do not kfree device
      staging: vc04_services: Support module autoloading using MODULE_DEVICE_TABLE
      staging: vc04_services: bcm2835-audio: Drop MODULE_ALIAS
      staging: vc04_services: bcm2835-camera: Drop MODULE_ALIAS
      staging: vc04_services: Pass struct device to vchiq_log_dump_mem()
      staging: vc04_services: Pass struct device to vchiq_init_slots()
      staging: vc04: Convert vchiq_log_error() to use dynamic debug
      staging: vc04: Convert vchiq_log_warning() to use dynamic debug
      staging: vc04: Convert(and rename) vchiq_log_info() to use dynamic debug
      staging: vc04: Convert vchiq_log_trace() to use dynamic debug
      staging: vc04_services: Drop VCHIQ_LOG_PREFIX macro
      staging: vc04_services: Drop log level mechanisms
      staging: vc04_services: Use %p4cc format modifier to print FourCC codes

Uwe Kleine-König (1):
      staging: fbtft: Convert to platform remove callback returning void

 Documentation/networking/device_drivers/index.rst  |    1 -
 .../networking/device_drivers/qlogic/index.rst     |   18 -
 .../networking/device_drivers/qlogic/qlge.rst      |  118 -
 MAINTAINERS                                        |    9 -
 arch/parisc/configs/generic-64bit_defconfig        |    1 -
 drivers/staging/Kconfig                            |    4 -
 drivers/staging/Makefile                           |    2 -
 drivers/staging/fbtft/fbtft.h                      |    5 +-
 drivers/staging/fieldbus/anybuss/arcx-anybus.c     |   17 +-
 drivers/staging/gdm724x/gdm_tty.c                  |    1 +
 drivers/staging/greybus/audio_manager_private.h    |    7 +-
 drivers/staging/greybus/authentication.c           |   19 +-
 drivers/staging/greybus/bootrom.c                  |    2 -
 drivers/staging/greybus/camera.c                   |   13 +-
 drivers/staging/greybus/fw-management.c            |   19 +-
 drivers/staging/greybus/raw.c                      |   23 +-
 drivers/staging/ks7010/ks7010_sdio.c               |    4 +-
 drivers/staging/olpc_dcon/olpc_dcon.c              |    2 +-
 drivers/staging/pi433/pi433_if.c                   |   21 +-
 drivers/staging/qlge/Kconfig                       |   11 -
 drivers/staging/qlge/Makefile                      |    8 -
 drivers/staging/qlge/TODO                          |   33 -
 drivers/staging/qlge/qlge.h                        | 2293 ---------
 drivers/staging/qlge/qlge_dbg.c                    | 1311 ------
 drivers/staging/qlge/qlge_devlink.c                |  167 -
 drivers/staging/qlge/qlge_devlink.h                |    9 -
 drivers/staging/qlge/qlge_ethtool.c                |  746 ---
 drivers/staging/qlge/qlge_main.c                   | 4845 --------------------
 drivers/staging/qlge/qlge_mpi.c                    | 1273 -----
 drivers/staging/rtl8192e/dot11d.c                  |    3 -
 drivers/staging/rtl8192e/rtl8192e/r8190P_def.h     |    2 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c     |  175 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_dev.h     |    3 -
 drivers/staging/rtl8192e/rtl8192e/r8192E_hw.h      |  104 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c     |   17 +-
 drivers/staging/rtl8192e/rtl8192e/r8192E_phyreg.h  |   60 -
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.c        |  120 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h        |    1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c       |  366 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h       |   18 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c         |  309 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.h         |   27 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.c        |    2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c         |    9 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_wx.c         |  273 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c          |  292 +-
 drivers/staging/rtl8192e/rtl819x_HT.h              |    2 +-
 drivers/staging/rtl8192e/rtl819x_HTProc.c          |  115 +-
 drivers/staging/rtl8192e/rtl819x_Qos.h             |  130 +-
 drivers/staging/rtl8192e/rtl819x_TS.h              |    8 +-
 drivers/staging/rtl8192e/rtl819x_TSProc.c          |  254 +-
 drivers/staging/rtl8192e/rtllib.h                  |  308 +-
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c       |   19 +-
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c       |   40 +-
 drivers/staging/rtl8192e/rtllib_crypt_wep.c        |    2 +-
 drivers/staging/rtl8192e/rtllib_debug.h            |   49 -
 drivers/staging/rtl8192e/rtllib_module.c           |    8 +-
 drivers/staging/rtl8192e/rtllib_rx.c               |  455 +-
 drivers/staging/rtl8192e/rtllib_softmac.c          |  489 +-
 drivers/staging/rtl8192e/rtllib_softmac_wx.c       |   51 +-
 drivers/staging/rtl8192e/rtllib_tx.c               |  569 ++-
 drivers/staging/rtl8192e/rtllib_wx.c               |    2 +-
 drivers/staging/rtl8192u/Kconfig                   |   12 -
 drivers/staging/rtl8192u/Makefile                  |   27 -
 drivers/staging/rtl8192u/TODO                      |   16 -
 drivers/staging/rtl8192u/authors                   |    1 -
 drivers/staging/rtl8192u/changes                   |    4 -
 drivers/staging/rtl8192u/ieee80211/dot11d.c        |  174 -
 drivers/staging/rtl8192u/ieee80211/dot11d.h        |   57 -
 drivers/staging/rtl8192u/ieee80211/ieee80211.h     | 2385 ----------
 .../staging/rtl8192u/ieee80211/ieee80211_crypt.c   |  235 -
 .../staging/rtl8192u/ieee80211/ieee80211_crypt.h   |   86 -
 .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      |  421 --
 .../rtl8192u/ieee80211/ieee80211_crypt_tkip.c      |  718 ---
 .../rtl8192u/ieee80211/ieee80211_crypt_wep.c       |  247 -
 .../staging/rtl8192u/ieee80211/ieee80211_module.c  |  287 --
 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c  | 2430 ----------
 .../staging/rtl8192u/ieee80211/ieee80211_softmac.c | 3056 ------------
 .../rtl8192u/ieee80211/ieee80211_softmac_wx.c      |  598 ---
 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c  |  839 ----
 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c  |  810 ----
 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h    |   54 -
 .../staging/rtl8192u/ieee80211/rtl819x_BAProc.c    |  700 ---
 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h    |  302 --
 .../staging/rtl8192u/ieee80211/rtl819x_HTProc.c    | 1295 ------
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h   |   82 -
 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h    |  102 -
 .../staging/rtl8192u/ieee80211/rtl819x_TSProc.c    |  534 ---
 drivers/staging/rtl8192u/r8180_93cx6.c             |  170 -
 drivers/staging/rtl8192u/r8180_93cx6.h             |   25 -
 drivers/staging/rtl8192u/r8190_rtl8256.c           |  294 --
 drivers/staging/rtl8192u/r8190_rtl8256.h           |   24 -
 drivers/staging/rtl8192u/r8192U.h                  | 1129 -----
 drivers/staging/rtl8192u/r8192U_core.c             | 4800 -------------------
 drivers/staging/rtl8192u/r8192U_debugfs.c          |  188 -
 drivers/staging/rtl8192u/r8192U_dm.c               | 2821 ------------
 drivers/staging/rtl8192u/r8192U_dm.h               |  176 -
 drivers/staging/rtl8192u/r8192U_hw.h               |  246 -
 drivers/staging/rtl8192u/r8192U_wx.c               |  943 ----
 drivers/staging/rtl8192u/r8192U_wx.h               |   24 -
 drivers/staging/rtl8192u/r819xU_cmdpkt.c           |  508 --
 drivers/staging/rtl8192u/r819xU_cmdpkt.h           |  190 -
 drivers/staging/rtl8192u/r819xU_firmware.c         |  340 --
 drivers/staging/rtl8192u/r819xU_firmware.h         |   19 -
 drivers/staging/rtl8192u/r819xU_firmware_img.c     |  549 ---
 drivers/staging/rtl8192u/r819xU_firmware_img.h     |   26 -
 drivers/staging/rtl8192u/r819xU_phy.c              | 1646 -------
 drivers/staging/rtl8192u/r819xU_phy.h              |   81 -
 drivers/staging/rtl8192u/r819xU_phyreg.h           |  143 -
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c    |    6 +-
 drivers/staging/rts5208/rtsx.c                     |   24 +-
 drivers/staging/rts5208/rtsx.h                     |   66 +-
 drivers/staging/sm750fb/ddk750_mode.c              |   94 +-
 drivers/staging/sm750fb/ddk750_mode.h              |    2 +-
 drivers/staging/sm750fb/sm750_hw.c                 |    2 +-
 drivers/staging/vc04_services/Makefile             |    1 +
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  |   32 +-
 .../staging/vc04_services/bcm2835-audio/bcm2835.h  |    1 -
 .../vc04_services/bcm2835-camera/bcm2835-camera.c  |   31 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  227 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.h  |    3 -
 .../vc04_services/interface/vchiq_arm/vchiq_bus.c  |   99 +
 .../vc04_services/interface/vchiq_arm/vchiq_bus.h  |   57 +
 .../interface/vchiq_arm/vchiq_connected.c          |    2 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.c |  405 +-
 .../vc04_services/interface/vchiq_arm/vchiq_core.h |   67 +-
 .../interface/vchiq_arm/vchiq_debugfs.c            |  103 -
 .../vc04_services/interface/vchiq_arm/vchiq_dev.c  |   66 +-
 drivers/staging/vme_user/vme.c                     |  256 +-
 drivers/staging/vme_user/vme.h                     |    6 +-
 drivers/staging/vme_user/vme_fake.c                |   77 +-
 drivers/staging/vme_user/vme_tsi148.c              |    9 +-
 drivers/staging/vme_user/vme_tsi148.h              |  692 ++-
 drivers/staging/vme_user/vme_user.c                |   26 +-
 drivers/staging/vt6655/baseband.c                  |   86 +-
 drivers/staging/vt6655/card.c                      |  194 +-
 drivers/staging/vt6655/card.h                      |   10 +-
 drivers/staging/vt6655/channel.c                   |   28 +-
 drivers/staging/vt6655/device.h                    |   28 +-
 drivers/staging/vt6655/device_main.c               |   46 +-
 drivers/staging/vt6655/dpc.c                       |    2 +-
 drivers/staging/vt6655/rf.c                        |   18 +-
 drivers/staging/vt6655/rf.h                        |    2 +-
 drivers/staging/wlan-ng/hfa384x_usb.c              |    2 +-
 drivers/staging/wlan-ng/p80211conv.c               |   12 +-
 drivers/staging/wlan-ng/p80211netdev.h             |    3 -
 drivers/staging/wlan-ng/prism2fw.c                 |    2 +-
 drivers/staging/wlan-ng/prism2mgmt.h               |   12 +-
 drivers/staging/wlan-ng/prism2sta.c                |  179 +-
 include/linux/mod_devicetable.h                    |    4 +
 scripts/mod/devicetable-offsets.c                  |    3 +
 scripts/mod/file2alias.c                           |    9 +
 152 files changed, 2683 insertions(+), 45389 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/qlogic/index.rst
 delete mode 100644 Documentation/networking/device_drivers/qlogic/qlge.rst
 delete mode 100644 drivers/staging/qlge/Kconfig
 delete mode 100644 drivers/staging/qlge/Makefile
 delete mode 100644 drivers/staging/qlge/TODO
 delete mode 100644 drivers/staging/qlge/qlge.h
 delete mode 100644 drivers/staging/qlge/qlge_dbg.c
 delete mode 100644 drivers/staging/qlge/qlge_devlink.c
 delete mode 100644 drivers/staging/qlge/qlge_devlink.h
 delete mode 100644 drivers/staging/qlge/qlge_ethtool.c
 delete mode 100644 drivers/staging/qlge/qlge_main.c
 delete mode 100644 drivers/staging/qlge/qlge_mpi.c
 delete mode 100644 drivers/staging/rtl8192e/rtllib_debug.h
 delete mode 100644 drivers/staging/rtl8192u/Kconfig
 delete mode 100644 drivers/staging/rtl8192u/Makefile
 delete mode 100644 drivers/staging/rtl8192u/TODO
 delete mode 100644 drivers/staging/rtl8192u/authors
 delete mode 100644 drivers/staging/rtl8192u/changes
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/dot11d.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/dot11d.h
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211.h
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt.h
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_tkip.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_wep.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_module.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_rx.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac_wx.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_tx.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/rtl819x_BA.h
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/rtl819x_BAProc.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/rtl819x_HT.h
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h
 delete mode 100644 drivers/staging/rtl8192u/ieee80211/rtl819x_TSProc.c
 delete mode 100644 drivers/staging/rtl8192u/r8180_93cx6.c
 delete mode 100644 drivers/staging/rtl8192u/r8180_93cx6.h
 delete mode 100644 drivers/staging/rtl8192u/r8190_rtl8256.c
 delete mode 100644 drivers/staging/rtl8192u/r8190_rtl8256.h
 delete mode 100644 drivers/staging/rtl8192u/r8192U.h
 delete mode 100644 drivers/staging/rtl8192u/r8192U_core.c
 delete mode 100644 drivers/staging/rtl8192u/r8192U_debugfs.c
 delete mode 100644 drivers/staging/rtl8192u/r8192U_dm.c
 delete mode 100644 drivers/staging/rtl8192u/r8192U_dm.h
 delete mode 100644 drivers/staging/rtl8192u/r8192U_hw.h
 delete mode 100644 drivers/staging/rtl8192u/r8192U_wx.c
 delete mode 100644 drivers/staging/rtl8192u/r8192U_wx.h
 delete mode 100644 drivers/staging/rtl8192u/r819xU_cmdpkt.c
 delete mode 100644 drivers/staging/rtl8192u/r819xU_cmdpkt.h
 delete mode 100644 drivers/staging/rtl8192u/r819xU_firmware.c
 delete mode 100644 drivers/staging/rtl8192u/r819xU_firmware.h
 delete mode 100644 drivers/staging/rtl8192u/r819xU_firmware_img.c
 delete mode 100644 drivers/staging/rtl8192u/r819xU_firmware_img.h
 delete mode 100644 drivers/staging/rtl8192u/r819xU_phy.c
 delete mode 100644 drivers/staging/rtl8192u/r819xU_phy.h
 delete mode 100644 drivers/staging/rtl8192u/r819xU_phyreg.h
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.c
 create mode 100644 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_bus.h
