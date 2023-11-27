Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB77C7F982B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjK0EOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:14:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0EOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:14:01 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E710F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:14:06 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c72e275d96so49763231fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701058444; x=1701663244; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RzQZ284vAULDdWuNNryNGfeCLiqZkRUQeGO/HDxqGwM=;
        b=iK4+h/yRreTrZpifC1jVkUlarpzkwFi2AzbVlIQXBAqAC62vlgPcmkCRN2Pspz4hAL
         DnniezXRc7zj027Idv3DNBBKi9dbgLhzF9/Fty2qyLJi9wbLdRYx818x4WEkQ5klVwMk
         jjFhs8df66u9cw123ngNTVk9H9u5qDsTl7Aho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701058444; x=1701663244;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RzQZ284vAULDdWuNNryNGfeCLiqZkRUQeGO/HDxqGwM=;
        b=T5JLiaR3dYbeWZHWFXIUaLN11dOirN585D3XOKUmJpVKN8HYHV11iJekPjE8Lje3Ef
         Nza6CplZXbXAZ8vrtc2aGor2z8zDHTRVrdfFsNMTY/B8QpwV7GK6CKikwJcdQQOgIIyY
         AEslWIkwWk5TMqKnZPtJQjpHHKkFe9BG5nTqG+G2auRQQd4sAxXXjtIvjuSaOdqX5IE5
         lzGjeBrDhtxb55MWE97Zzg1wrrsyV3P5OXkU61QeRcbrgtAanAVLyFdBo30fqdG13NqY
         3CpMEHBjVO1CeQBFokbiSshHQxjiNC60PmnpPBamIcJy9BgrLg1oOkx67ynvRwHNgZf0
         h6kQ==
X-Gm-Message-State: AOJu0Yxx6GjBhoTD5A9VLDy6ReqvHE4LHRcjtB3biyQXJ9AG3SrygsRb
        KD6wkzhmmiZBvYzbSfUjHtUqL1b8y9vPZ629KhZWYmUG
X-Google-Smtp-Source: AGHT+IHsSCHSzmwb0507lNGL4kSFnqQuhIUacnn09BDXF0tdPzh93GEqx9WlLHWOQ1ejTgm2RIp9oQ==
X-Received: by 2002:a2e:8884:0:b0:2c8:8189:911 with SMTP id k4-20020a2e8884000000b002c881890911mr7240485lji.3.1701058444168;
        Sun, 26 Nov 2023 20:14:04 -0800 (PST)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id j2-20020a2e3c02000000b002c17fc97071sm1204098lja.87.2023.11.26.20.14.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 20:14:03 -0800 (PST)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2c997447ff9so17208051fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:14:03 -0800 (PST)
X-Received: by 2002:a05:651c:98e:b0:2c9:9242:b155 with SMTP id
 b14-20020a05651c098e00b002c99242b155mr4391475ljq.40.1701058443009; Sun, 26
 Nov 2023 20:14:03 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Nov 2023 20:13:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj1q-Ek=VTzcKT42q8QJqYfmEzDvu-wpCc_oSERq+naWg@mail.gmail.com>
Message-ID: <CAHk-=wj1q-Ek=VTzcKT42q8QJqYfmEzDvu-wpCc_oSERq+naWg@mail.gmail.com>
Subject: Linux 6.7-rc3
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The diffstat here is dominated by a couple of reverts of some Realtek
phy code (accounting for almost a third of the diff).

But ignoring that, it's mostly fairly small, and all over the place.
Ethernet drivers, smb client fixes, bpf selftests stand out as bigger
areas, but we have random small driver updates (block, gpu, nvme, hid,
usb) and some arch fixes (x86, parisc, loongarch, arm64) too. Some
misc filesystem fixes.

Shortlog appended, and gives some flavor of what was going on last week.

               Linus

---

Abel Vesa (1):
      drm/msm/dp: don't touch DP subconnector property in eDP case

Alex Elder (1):
      net: ipa: fix one GSI register field width

Alexander Stein (1):
      usb: dwc3: Fix default mode initialization

Andrzej Hajda (1):
      drm/i915: do not clean GT table on error path

Andy Shevchenko (1):
      platform/x86: intel_telemetry: Fix kernel doc descriptions

Ani Sinha (1):
      hv/hv_kvp_daemon: Some small fixes for handling NM keyfiles

Aoba K (1):
      HID: multitouch: Add quirk for HONOR GLO-GXXX touchpad

Arnd Bergmann (3):
      nvme: target: fix nvme_keyring_id() references
      nvme: target: fix Kconfig select statements
      nvme: tcp: fix compile-time checks for TLS mode

Arseniy Krasnov (1):
      vsock/test: fix SEQPACKET message bounds test

Asuna Yang (1):
      USB: serial: option: add Luat Air72*U series products

Badhri Jagan Sridharan (2):
      usb: typec: tcpm: Skip hard reset when in error recovery
      usb: typec: tcpm: Fix sink caps op current check

Bibo Mao (1):
      LoongArch: Implement constant timer shutdown interface

Bjorn Andersson (1):
      drm/msm/dpu: Add missing safe_lut_tbl in sc8280xp catalog

Borislav Petkov (AMD) (2):
      x86/microcode: Remove the driver announcement and version
      x86/microcode: Rework early revisions reporting

Brett Raye (1):
      HID: glorious: fix Glorious Model I HID report

Charles Mirabile (1):
      io_uring/fs: consider link->flags when getting path for LINKAT

Charles Yi (1):
      HID: fix HID device resource race between HID core and debugging supp=
ort

Chen Ni (1):
      ata: pata_isapnp: Add missing error check for devm_ioport_map()

Chengming Zhou (1):
      block/null_blk: Fix double blk_mq_start_request() warning

Christoph Hellwig (5):
      filemap: add a per-mapping stable writes flag
      block: update the stable_writes flag in bdev_add
      xfs: clean up FS_XFLAG_REALTIME handling in xfs_ioctl_setattr_xflags
      xfs: respect the stable writes flag on the RT device
      nvmet: nul-terminate the NQNs passed in the connect command

Christophe JAILLET (1):
      USB: typec: tps6598x: Fix a memory leak in an error handling path

Chuck Lever (1):
      libfs: getdents() should return 0 after reaching EOD

Chunfeng Yun (1):
      usb: xhci-mtk: fix in-ep's start-split check failure

Colin Ian King (1):
      bcache: remove redundant assignment to variable cur_idx

Coly Li (5):
      bcache: avoid oversize memory allocation by small stripe_size
      bcache: check return value from btree_node_alloc_replacement()
      bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in
btree_gc_coalesce()
      bcache: add code comments for bch_btree_node_get() and
__bch_btree_node_alloc()
      bcache: avoid NULL checking to c->root in run_cache_set()

Cong Yang (1):
      drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP and H=
BP

D. Wythe (1):
      net/smc: avoid data corruption caused by decline

Damien Le Moal (1):
      block: Remove blk_set_runtime_active()

Dan Carpenter (1):
      drm/msm: remove unnecessary NULL check

Daniel Borkmann (6):
      net, vrf: Move dstats structure to core
      net: Move {l,t,d}stats allocation to core and convert veth & vrf
      netkit: Add tstats per-CPU traffic counters
      bpf, netkit: Add indirect call wrapper for fetching peer dev
      selftests/bpf: De-veth-ize the tc_redirect test case
      selftests/bpf: Add netkit to tc_redirect selftest

Dapeng Mi (1):
      perf/x86/intel: Correct incorrect 'or' operation for PMU capabilities

Darrick J. Wong (2):
      xfs: clean up dqblk extraction
      xfs: dquot recovery does not validate the recovered dquot

Dave Airlie (1):
      nouveau/gsp: allocate enough space for all channel ids.

David Howells (8):
      rxrpc: Fix some minor issues with bundle tracing
      rxrpc: Fix RTT determination to use any ACK as a source
      rxrpc: Defer the response to a PING ACK until we've parsed it
      afs: Fix afs_server_list to be cleaned up with RCU
      afs: Make error on cell lookup failure consistent with OpenAFS
      afs: Return ENOENT if no cell DNS record can be found
      afs: Fix file locking on R/O volumes to operate in local mode
      afs: Mark a superblock for an R/O or Backup volume as SB_RDONLY

David Woodhouse (2):
      ACPI: processor_idle: use raw_safe_halt() in acpi_idle_play_dead()
      PM: tools: Fix sleepgraph syntax error

Denis Benato (2):
      HID: hid-asus: add const to read-only outgoing usb buffer
      HID: hid-asus: reset the backlight brightness level on resume

Dmitry Baryshkov (2):
      drm/msm: remove exra drm_kms_helper_poll_init() call
      drm/msm/dp: attach the DP subconnector property

Eduard Zingerman (11):
      selftests/bpf: track tcp payload offset as scalar in xdp_synproxy
      selftests/bpf: track string payload offset as scalar in strobemeta
      selftests/bpf: fix bpf_loop_bench for new callback verification schem=
e
      bpf: extract __check_reg_arg() utility function
      bpf: extract setup_func_entry() utility function
      bpf: verify callbacks as if they are called unknown number of times
      selftests/bpf: tests for iterating callbacks
      bpf: widening for callback iterators
      selftests/bpf: test widening for iterating callbacks
      bpf: keep track of max number of bpf_loop callback iterations
      selftests/bpf: check if max number of bpf_loop iterations is tracked

Eric Dumazet (1):
      wireguard: use DEV_STATS_INC()

Ferry Meng (1):
      erofs: simplify erofs_read_inode()

Gao Xiang (1):
      MAINTAINERS: erofs: add EROFS webpage

Gerd Bayer (1):
      s390/ism: ism driver implies smc protocol

Gil Fine (1):
      thunderbolt: Set lane bonding bit only for downstream port

Gustavo A. R. Silva (1):
      xen: privcmd: Replace zero-length array with flex-array member
and use __counted_by

Haiyang Zhang (2):
      hv_netvsc: fix race of netvsc and VF register_netdevice
      hv_netvsc: Fix race of register_netdevice_notifier and VF register

Hamish Martin (2):
      HID: mcp2221: Set driver data before I2C adapter add
      HID: mcp2221: Allow IO to start during probe

Hannes Reinecke (5):
      nvme-tcp: only evaluate 'tls' option if TLS is selected
      nvme: catch errors from nvme_configure_metadata()
      nvme: blank out authentication fabrics options if not configured
      nvmet-tcp: always initialize tls_handshake_tmo_work
      nvme: move nvme_stop_keep_alive() back to original position

Hans de Goede (5):
      ACPI: PM: Add acpi_device_fix_up_power_children() function
      ACPI: video: Use acpi_device_fix_up_power_children()
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA
      MAINTAINERS: Drop Mark Gross as maintainer for x86 platform drivers
      usb: misc: ljca: Fix enumeration error on Dell Latitude 9420

Hao Ge (1):
      dpll: Fix potential msg memleak when genlmsg_put_reply failed

Harshit Mogalapalli (4):
      platform/x86: hp-bioscfg: Simplify return check in
hp_add_other_attributes()
      platform/x86: hp-bioscfg: move mutex_lock() down in
hp_add_other_attributes()
      platform/x86: hp-bioscfg: Fix error handling in hp_add_other_attribut=
es()
      platform/x86: hp-bioscfg: Remove unused obj in hp_add_other_attribute=
s()

Heikki Krogerus (1):
      usb: typec: tipd: Supply also I2C driver data

Heiko Carstens (2):
      s390: remove odd comment
      scripts/checkstack.pl: match all stack sizes for s390

Heiner Kallweit (1):
      Revert "net: r8169: Disable multicast filter for RTL8168H and RTL8107=
E"

Helge Deller (9):
      parisc: Mark ex_table entries 32-bit aligned in assembly.h
      parisc: Mark ex_table entries 32-bit aligned in uaccess.h
      parisc: Mark altinstructions read-only and 32-bit aligned
      parisc: Mark jump_table naturally aligned
      parisc: Mark lock_aligned variables 16-byte aligned on SMP
      parisc: Ensure 32-bit alignment on parisc unwind section
      parisc: Use natural CPU alignment for bug_table
      parisc: Drop the HP-UX ENOSYM and EREMOTERELEASE error codes
      parisc: Reduce size of the bug_table on 64-bit kernel by half

Huacai Chen (3):
      LoongArch: Add __percpu annotation for __percpu_read()/__percpu_write=
()
      LoongArch: Silence the boot warning about 'nokaslr'
      LoongArch: Mark {dmw,tlb}_virt_to_page() exports as non-GPL

Ian Kent (1):
      autofs: add: new_inode check in autofs_fill_super()

Imre Deak (1):
      drm/i915/dp_mst: Fix race between connector registration and setup

Ivan Vecera (1):
      i40e: Fix adding unsupported cloud filters

Jacek Lawrynowicz (1):
      accel/ivpu/37xx: Fix hangs related to MMIO reset

Jacob Keller (3):
      ice: remove ptp_tx ring parameter flag
      ice: unify logic for programming PFINT_TSYN_MSK
      ice: restore timestamp configuration after device reset

Jakub Kicinski (4):
      net: fill in MODULE_DESCRIPTION()s for SOCK_DIAG modules
      docs: netdev: try to guide people on dealing with silence
      tools: ynl: fix header path for nfsd
      tools: ynl: fix duplicate op name in devlink

Jan H=C3=B6ppner (1):
      s390/dasd: protect device queue against concurrent access

Jann Horn (1):
      tls: fix NULL deref on tls_sw_splice_eof() with empty record

Jean Delvare (1):
      stmmac: dwmac-loongson: Add architecture dependency

Jiawen Wu (1):
      net: wangxun: fix kernel panic due to null pointer

Jingbo Xu (1):
      erofs: fix NULL dereference of dif->bdev_handle in fscache mode

Jiri Kosina (1):
      Revert "HID: logitech-dj: Add support for a new lightspeed
receiver iteration"

Jithu Joseph (1):
      MAINTAINERS: Remove stale entry for SBL platform driver

Johan Hovold (11):
      Revert "phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY=
"
      Revert "phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY=
"
      Revert "usb: phy: add usb phy notify port status API"
      dt-bindings: usb: hcd: add missing phy name to example
      USB: xhci-plat: fix legacy PHY double init
      dt-bindings: usb: qcom,dwc3: fix example wakeup interrupt types
      USB: dwc3: qcom: fix wakeup after probe deferral
      USB: dwc3: qcom: simplify wakeup interrupt setup
      USB: dwc3: qcom: fix resource leaks on probe deferral
      USB: dwc3: qcom: fix software node leak on probe errors
      USB: dwc3: qcom: fix ACPI platform device leak

Jonas Karlman (1):
      drm/rockchip: vop: Fix color for RGB888/BGR888 format on VOP full

Jonathan Marek (1):
      drm/msm/dsi: use the correct VREG_CTRL_1 value for 4nm cphy

Jose Ignacio Tornos Martinez (1):
      net: usb: ax88179_178a: fix failed operations during ax88179_reset

Kees Cook (1):
      MAINTAINERS: Add netdev subsystem profile link

Keith Busch (2):
      swiotlb-xen: provide the "max_mapping_size" method
      io_uring: fix off-by one bvec index

Kunwu Chan (1):
      ipv4: Correct/silence an endian warning in __ip_do_redirect

Lech Perczak (2):
      USB: serial: option: don't claim interface 4 for ZTE MF290
      net: usb: qmi_wwan: claim interface 4 for ZTE MF290

Li Nan (4):
      nbd: fold nbd config initialization into nbd_alloc_config()
      nbd: factor out a helper to get nbd_config without holding 'config_lo=
ck'
      nbd: fix null-ptr-dereference while accessing 'nbd->config'
      nbd: pass nbd_sock to nbd_read_reply() instead of index

Linus Torvalds (2):
      asm-generic: qspinlock: fix queued_spin_value_unlocked() implementati=
on
      Linux 6.7-rc3

Long Li (1):
      hv_netvsc: Mark VF as slave before exposing it to user-mode

Lorenzo Bianconi (1):
      net: veth: fix ethtool stats reporting

Marek Vasut (2):
      drm/panel: simple: Fix Innolux G101ICE-L01 bus flags
      drm/panel: simple: Fix Innolux G101ICE-L01 timings

Mark Brown (1):
      kselftest/arm64: Fix output formatting for za-fork

Mark O'Donovan (2):
      nvme-auth: unlock mutex in one place only
      nvme-auth: set explanation code for failure2 msgs

Masahiro Yamada (2):
      LoongArch: Add dependency between vmlinuz.efi and vmlinux.efi
      arm64: add dependency between vmlinuz.efi and Image

Mathieu Desnoyers (1):
      MAINTAINERS: TRACING: Add Mathieu Desnoyers as Reviewer

Mika Westerberg (2):
      thunderbolt: Send uevent after asymmetric/symmetric switch
      thunderbolt: Only add device router DP IN to the head of the DP
resource list

Mikhail Zaslonko (1):
      s390/ipl: add missing IPL_TYPE_ECKD_DUMP case to ipl_init()

Ming Lei (3):
      blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read
lock required!"
      blk-cgroup: avoid to warn !rcu_read_lock_held() in blkg_lookup()
      blk-cgroup: bypass blkcg_deactivate_policy after destroying

Mingzhe Zou (3):
      bcache: fixup init dirty data errors
      bcache: fixup lock c->root error
      bcache: fixup multi-threaded bch_sectors_dirty_init() wake-up race

Muhammad Muzammil (1):
      s390/dasd: resolve spelling mistake

Nguyen Dinh Phi (1):
      nfc: virtual_ncidev: Add variable to check if ndev is running

Niklas Neronin (1):
      usb: config: fix iteration issue in 'usb_get_bos_descriptor()'

Oliver Neukum (3):
      usb: aqc111: check packet for fixup for true limit
      HID: add ALWAYS_POLL quirk for Apple kb
      USB: dwc2: write HCINT with INTMASK applied

Omar Sandoval (1):
      iov_iter: fix copy_page_to_iter_nofault()

Paolo Abeni (1):
      kselftest: rtnetlink: fix ip route command typo

Paulo Alcantara (4):
      smb: client: implement ->query_reparse_point() for SMB1
      smb: client: introduce ->parse_reparse_point()
      smb: client: set correct file type from NFS reparse points
      smb: client: introduce cifs_sfu_make_node()

Pawel Laszczak (1):
      usb: cdnsp: Fix deadlock issue during using NCM gadget

Peilin Ye (2):
      veth: Use tstats per-CPU traffic counters
      bpf: Fix dev's rx stats for bpf_redirect_peer traffic

Peter Zijlstra (1):
      lockdep: Fix block chain corruption

Puliang Lu (1):
      USB: serial: option: fix FM101R-GL defines

Raju Rangoju (3):
      amd-xgbe: handle corner-case during sfp hotplug
      amd-xgbe: handle the corner-case during tx completion
      amd-xgbe: propagate the correct speed and duplex status

Rand Deeb (1):
      bcache: prevent potential division by zero error

Ricardo Ribalda (1):
      usb: dwc3: set the dma max_seg_size

Ritvik Budhiraja (1):
      cifs: fix use after free for iface while disabling secondary channels

Samuel Holland (1):
      net: axienet: Fix check for partial TX checksum

Saurabh Sengar (1):
      x86/hyperv: Fix the detection of E820_TYPE_PRAM in a Gen2 VM

Shyam Sundar S K (1):
      platform/x86/amd/pmc: adjust getting DRAM size behavior

Simon Horman (1):
      MAINTAINERS: Add indirect_call_wrapper.h to NETWORKING [GENERAL]

Song Liu (1):
      md: fix bi_status reporting in md_end_clone_io

Stanley Chang (1):
      usb: dwc3: add missing of_node_put and platform_device_put

Stefan Berger (1):
      fs: Pass AT_GETATTR_NOSEC flag to getattr interface function

Stefan Eichenberger (2):
      dt-bindings: usb: microchip,usb5744: Add second supply
      usb: misc: onboard-hub: add support for Microchip USB5744

Stefano Stabellini (1):
      arm/xen: fix xen_vcpu_info allocation alignment

Steven Rostedt (Google) (6):
      eventfs: Remove expectation that ei->is_freed means ei->dentry =3D=3D=
 NULL
      eventfs: Do not invalidate dentry in create_file/dir_dentry()
      eventfs: Use GFP_NOFS for allocation when eventfs_mutex is held
      eventfs: Move taking of inode_lock into dcache_dir_open_wrapper()
      eventfs: Do not allow NULL parent to eventfs_start_creating()
      eventfs: Make sure that parent->d_inode is locked in creating files/d=
irs

Stuart Hayhurst (1):
      platform/x86: ideapad-laptop: Set max_brightness before using it

Suman Ghosh (2):
      octeontx2-pf: Fix memory leak during interface down
      octeontx2-pf: Fix ntuple rule creation to direct packet to VF
with higher Rx queue than its PF

Thomas Richter (1):
      s390/pai: cleanup event initialization

Thomas Zimmermann (1):
      drm/ast: Disconnect BMC if physical connector is connected

Uros Bizjak (1):
      x86/hyperv: Use atomic_try_cmpxchg() to micro-optimize hv_nmi_unknown=
()

Victor Fragoso (1):
      USB: serial: option: add Fibocom L7xx modules

WANG Rui (2):
      LoongArch: Explicitly set -fdirect-access-external-data for vmlinux
      LoongArch: Record pc instead of offset in la_abs relocation

Wentong Wu (1):
      usb: misc: ljca: Drop _ADR support to get ljca children devices

Will Deacon (1):
      arm64: mm: Fix "rodata=3Don" when CONFIG_RODATA_FULL_DEFAULT_ENABLED=
=3Dy

Xuxin Xiong (1):
      drm/panel: auo,b101uan08.3: Fine tune the panel power sequence

Yanteng Si (2):
      Docs/LoongArch: Update links in LoongArch introduction.rst
      Docs/zh_CN/LoongArch: Update links in LoongArch introduction.rst

Yihong Cao (1):
      HID: apple: add Jamesdonkey and A3R to non-apple keyboards list
