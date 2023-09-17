Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2997A3E10
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 23:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbjIQV4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjIQV4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 17:56:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D575011D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:56:07 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bf5bf33bcdso65870101fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694987765; x=1695592565; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TNFrf0i8mXW5H55rC9O6OBnsQb1ko+itmFfVym5OqCY=;
        b=Ak5p1IzARQIdX/+NruiRo7nvDXZZgwBFtJAx4/rUUHYrHjwe5kRsQzmo6Q+fyIEEPg
         wqncdSYjn+3KgtWm+/xI3yFA4kxlSHAhk8bgzgxMJMmZNQcRHRbRGMEdo+zmsqtg5CLq
         nGybmR67UEURP2Hi0KCPfpZBdOsBzln8tG7zc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694987765; x=1695592565;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNFrf0i8mXW5H55rC9O6OBnsQb1ko+itmFfVym5OqCY=;
        b=nI47eXYFgx6WWxCwYVF4DfcS2Feoh7jqRZnlqFVrZl/s9dr8JyJjcXhGdo2iJ4fhic
         5WCXY//GrraxwvnCoS9PZaNVifOCbLfgr87orKSVg1wyDZYNaALQtQ4OBRz6sWZZ+tQV
         KUdZX7SC9api0QBr9BpsUyo7gCsBcgKTBzHGRiXGdFAD0yfZemk7r954EHs1gbVbeFSU
         0TZMDaYN4JNzU1t3HAuHnff3NA6e2PbgAZE1U2FG15qP1y8gi9n3Kpx4BTHAGMoMKVd5
         0hZmR+2N53WHciCff+fNSiSNtHFmarGC8MDMo8+0YhSPfS7sp/WRf15In8y/U1k1VvuO
         hC6A==
X-Gm-Message-State: AOJu0YwKBIytvsRlwzkjPsN7TMLOnXe1HgghDM9QRY5orWPw6MHmnMZg
        iSJZs+54EZ6jLexCehZQ8Re85+uHSKuCqrDnRB7R1v2w
X-Google-Smtp-Source: AGHT+IGWlmGiJsmc2ry6RGuJScAeDTP8uL3F9hrnzPioCL6UnZWn+YTm3SYWNhscs17utfgJ0XJQHA==
X-Received: by 2002:a2e:a17a:0:b0:2bc:ffe5:54a1 with SMTP id u26-20020a2ea17a000000b002bcffe554a1mr6290414ljl.32.1694987764909;
        Sun, 17 Sep 2023 14:56:04 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906698800b009a198078c53sm5435374ejr.214.2023.09.17.14.56.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Sep 2023 14:56:04 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so4917675a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 14:56:03 -0700 (PDT)
X-Received: by 2002:a05:6402:12cf:b0:522:3a89:a79d with SMTP id
 k15-20020a05640212cf00b005223a89a79dmr5988297edx.2.1694987763487; Sun, 17 Sep
 2023 14:56:03 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Sep 2023 14:55:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=whW=fV2tnAreSbtPVpJxq++pyBZa3g+cxX8_V__WSZzCg@mail.gmail.com>
Message-ID: <CAHk-=whW=fV2tnAreSbtPVpJxq++pyBZa3g+cxX8_V__WSZzCg@mail.gmail.com>
Subject: Linux 6.6-rc2
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another week, another -rc.

I think the most notable thing about 6.6-rc2 is simply that it's
exactly 32 years to the day since the 0.01 release. And that's a round
number if you are a computer person.

Because other than the random date, I don't see anything that really
stands out here. We've got random fixes all over, and none of it looks
particularly strange. The genpd -> pmdomain rename shows up in the
diffstat, but there's no actual code changes involved (make sure to
use "git diff -M" to see them as zero-line renames).

And other than that, things look very normal. Sure, the architecture
fixes happen to be mostly parisc this week, which isn't exactly the
usual pattern, but it's also not exactly a huge amount of changes.

Most of the (small) changes here are in drivers, with some tracing
fixes and just random things. The shortlog below is short enough to
scroll through and get a taste of what's been going on.

Please go test,

            Linus

---

Alex Deucher (3):
      drm/radeon: make fence wait in suballocator uninterrruptable
      drm/amdgpu/soc21: don't remap HDP registers for SR-IOV
      drm/amdgpu/nbio4.3: set proper rmmio_remap.reg_offset for SR-IOV

Alex Henrie (1):
      scsi: ppa: Fix accidentally reversed conditions for 16-bit and 32-bit=
 EPP

Amir Goldstein (2):
      ovl: fix failed copyup of fileattr on a symlink
      ovl: fix incorrect fdput() on aio completion

Andy Shevchenko (1):
      driver core: return an error when dev_set_name() hasn't happened

Ard Biesheuvel (3):
      efi/x86: Move EFI runtime call setup/teardown helpers out of line
      efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for kexec
      efi/unaccepted: Use ACPI reclaim memory for unaccepted memory table

Azeem Shaikh (1):
      scsi: target: Replace strlcpy() with strscpy()

Beau Belgrave (1):
      selftests/user_events: Fix failures when user_events is not installed

Bhaskar Chowdhury (1):
      MAINTAINERS: remove links to obsolete btrfs.wiki.kernel.org

Bhawanpreet Lakha (1):
      drm/amd/display: Add dirty rect support for Replay

Bj=C3=B6rn T=C3=B6pel (2):
      kselftest/runner.sh: Propagate SIGTERM to runner child
      selftests: Keep symlinks, when possible

Chen Yu (2):
      PM: hibernate: Rename function parameter from snapshot_test to exclus=
ive
      PM: hibernate: Fix the exclusive get block device in test_resume mode

Chengming Zhou (1):
      blk-mq: fix tags UAF when shrinking q->nr_hw_queues

Christophe JAILLET (1):
      ata: sata_mv: Fix incorrect string length computation in mv_dump_mem(=
)

Ciprian Regus (1):
      net:ethernet:adi:adin1110: Fix forwarding offload

Corinna Vinschen (1):
      igb: clean up in all error paths when enabling SR-IOV

Damien Le Moal (2):
      scsi: pm8001: Setup IRQs on resume
      ata: pata_parport: Fix code style issues

Dan Carpenter (1):
      drm/amdgpu: fix retry loop test

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: fix uninitialized variable

David Disseldorp (1):
      scsi: target: core: Fix target_cmd_counter leak

David Francis (2):
      drm/amdkfd: Checkpoint and restore queues on GFX11
      drm/amdgpu: Handle null atom context in VBIOS info ioctl

David Gow (1):
      kunit: test: Make filter strings in executor_test writable

David Thompson (1):
      platform/mellanox: mlxbf-bootctl: add NET dependency into Kconfig

Eric Dumazet (1):
      ipv6: fix ip6_sock_set_addr_preferences() typo

Filipe Manana (6):
      btrfs: fix race between finishing block group creation and its item u=
pdate
      btrfs: release path before inode lookup during the ino lookup ioctl
      btrfs: fix lockdep splat and potential deadlock after failure
running delayed items
      btrfs: improve error message after failure to add delayed dir index i=
tem
      btrfs: remove BUG() after failure to insert delayed dir index item
      btrfs: assert delayed node locked when removing delayed item

Geert Uytterhoeven (3):
      platform/mellanox: NVSW_SN2201 should depend on ACPI
      i2c: Make I2C_ATR invisible
      i2c: I2C_MLXCPLD on ARM64 should depend on ACPI

Guangguan Wang (2):
      net/smc: bugfix for smcr v2 server connect success statistic
      net/smc: use smc_lgr_list.lock to protect smc_lgr_list.list
iterate in smcr_port_add

Hamza Mahfooz (1):
      Revert "drm/amd: Disable S/G for APUs when 64GB or more host memory"

Hangyu Hua (3):
      net: ethernet: bcmasp: fix possible OOB write in
bcmasp_netfilt_get_all_active()
      net: ethernet: mvpp2_main: fix possible OOB write in
mvpp2_ethtool_get_rxnfc()
      net: ethernet: mtk_eth_soc: fix possible NULL pointer
dereference in mtk_hwlro_get_fdir_all()

Harish Kasiviswanathan (1):
      drm/amdkfd: Insert missing TLB flush on GFX10 and later

Hawking Zhang (1):
      drm/amdgpu: fallback to old RAS error message for aqua_vanjaram

Hayes Wang (1):
      r8152: check budget for r8152_poll()

Heikki Krogerus (1):
      usb: typec: ucsi: Fix NULL pointer dereference

Heinrich Schuchardt (1):
      efivarfs: fix statfs() on efivarfs

Helge Deller (14):
      parisc: sba_iommu: Fix build warning if procfs if disabled
      parisc: sba: Fix compile warning wrt list of SBA devices
      parisc: sba-iommu: Fix sparse warnigs
      parisc: ccio-dma: Fix sparse warnings
      parisc: iosapic.c: Fix sparse warnings
      parisc: drivers: Fix sparse warning
      parisc: irq: Make irq_stack_union static to avoid sparse warning
      parisc: shmparam.h: Document aliasing requirements of PA-RISC
      parisc: Prepare for Block-TLB support on 32-bit kernel
      parisc: BTLB: Clear possibly existing BTLB entries
      parisc: BTLB: Add BTLB insert and purge firmware function wrappers
      parisc: BTLB: _edata symbol has to be page aligned for BTLB support
      parisc: firmware: Simplify calling non-PA20 functions
      parisc: BTLB: Initialize BTLB tables at CPU startup

Ian Abbott (1):
      Revert "comedi: add HAS_IOPORT dependencies"

Icenowy Zheng (1):
      riscv: errata: fix T-Head dcache.cva encoding

Jan Kara (2):
      ext4: move setting of trimmed bit into ext4_try_to_trim_range()
      ext4: do not let fstrim block system suspend

Javed Hasan (1):
      scsi: qedf: Add synchronization between I/O completions and abort

Jeff Layton (1):
      nfsd: fix change_info in NFSv4 RENAME replies

Jens Axboe (1):
      dm: don't attempt to queue IO under RCU protection

Jinjie Ruan (9):
      drm: gm12u320: Fix the timeout usage for usb_bulk_msg()
      scsi: qla2xxx: Fix NULL vs IS_ERR() bug for debugfs_create_dir()
      kunit: Fix wild-memory-access bug in kunit_free_suite_set()
      kunit: Fix the wrong err path and add goto labels in kunit_filter_sui=
tes()
      kunit: Fix possible null-ptr-deref in kunit_parse_glob_filter()
      kunit: Fix possible memory leak in kunit_filter_suites()
      net: microchip: vcap api: Fix possible memory leak for vcap_dup_rule(=
)
      eventfs: Fix the NULL pointer dereference bug in eventfs_remove_rec()
      scsi: lpfc: Fix the NULL vs IS_ERR() bug for debugfs_create_file()

Josef Bacik (2):
      btrfs: do not block starts waiting on previous transaction commit
      btrfs: check for BTRFS_FS_ERROR in pending ordered assert

Josh Poimboeuf (1):
      objtool: Fix _THIS_IP_ detection for cold functions

Julia Lawall (2):
      net: bcmasp: add missing of_node_put
      thermal/of: add missing of_node_put()

Juntong Deng (1):
      selftests/net: Improve bind_bhash.sh to accommodate predictable
network interface names

Junxiao Bi (1):
      scsi: megaraid_sas: Fix deadlock on firmware crashdump

Justin M. Forbes (1):
      tpm: Fix typo in tpmrm class definition

Justin Tee (2):
      scsi: lpfc: Early return after marking final NLP_DROPPED flag in
dev_loss_tmo
      scsi: lpfc: Prevent use-after-free during rmmod with mapped NVMe rpor=
ts

Keith Busch (1):
      nvme: avoid bogus CRTO values

Kirill A. Shutemov (1):
      x86/boot/compressed: Reserve more memory for page tables

Kiwoong Kim (2):
      scsi: ufs: core: Move __ufshcd_send_uic_cmd() outside host_lock
      scsi: ufs: core: Poll HCS.UCRDY before issuing a UIC command

Krzysztof Kozlowski (1):
      nvme: host: hwmon: constify pointers to hwmon_channel_info

Kuniyuki Iwashima (7):
      tcp: Factorise sk_family-independent comparison in
inet_bind2_bucket_match(_addr_any).
      tcp: Fix bind() regression for v4-mapped-v6 wildcard address.
      tcp: Fix bind() regression for v4-mapped-v6 non-wildcard address.
      selftest: tcp: Fix address length in bind_wildcard.c.
      selftest: tcp: Move expected_errno into each test case in bind_wildca=
rd.c.
      selftest: tcp: Add v4-mapped-v6 cases in bind_wildcard.c.
      kcm: Fix error handling for SOCK_DGRAM in kcm_sendmsg().

Lee Jones (1):
      drm/drm_connector: Provide short description of param
'supported_colorspaces'

Li Zetao (1):
      jbd2: Fix memory leak in journal_init_common()

Liming Sun (2):
      platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no more descri=
ptors
      platform/mellanox: mlxbf-tmfifo: Drop jumbo frames

Linus Torvalds (3):
      vm: fix move_vma() memory accounting being off
      stat: remove no-longer-used helper macros
      Linux 6.6-rc2

Liu Jian (2):
      net: ipv4: fix one memleak in __inet_del_ifa()
      net/tls: do not free tls_rec on async operation in bpf_exec_tx_verdic=
t()

Lorenzo Bianconi (1):
      net: ethernet: mtk_eth_soc: fix pse_port configuration for MT7988

Lukas Wunner (1):
      panic: Reenable preemption in WARN slowpath

Luke D. Jones (1):
      platform/x86: asus-wmi: Support 2023 ROG X16 tablet mode

Mariusz Tkaczyk (1):
      md: Put the right device in md_seq_next

Masahiro Yamada (2):
      linux/export: fix reference to exported functions for parisc64
      kbuild: fix kernel-devel RPM package and linux-headers Deb package

Masami Hiramatsu (Google) (1):
      selftests: tracing: Fix to unmount tracefs for recovering environment

Matthew Wilcox (Oracle) (1):
      buffer: Make bh_offset() work for compound pages

Ma=C3=ADra Canal (1):
      Revert "drm/vkms: Fix race-condition between the hrtimer and the
atomic commit"

Michal Grzedzicki (2):
      scsi: pm80xx: Use phy-specific SAS address when sending PHY_START com=
mand
      scsi: pm80xx: Avoid leaking tags when processing
OPC_INB_SET_CONTROLLER_CONFIG command

Michal Kubecek (1):
      kbuild: avoid long argument lists in make modules_install

Mikulas Patocka (1):
      dm: fix a race condition in retrieve_deps

Mukul Joshi (5):
      drm/amdkfd: Fix reg offset for setting CWSR grace period
      drm/amdkfd: Fix unaligned 64-bit doorbell warning
      drm/amdgpu: Store CU info from all XCCs for GFX v9.4.3
      drm/amdkfd: Update cache info reporting for GFX v9.4.3
      drm/amdkfd: Update CU masking for GFX 9.4.3

Mustapha Ghaddar (2):
      drm/amd/display: Add DPIA Link Encoder Assignment Fix
      drm/amd/display: Fix 2nd DPIA encoder Assignment

Namjae Jeon (2):
      ksmbd: remove unneeded mark_inode_dirty in set_info_sec()
      ksmbd: fix passing freed memory 'aux_payload_buf'

Naresh Kamboju (1):
      selftests: user_events: create test-specific Kconfig fragments

Naveen N Rao (1):
      selftests/ftrace: Fix dependencies for some of the synthetic event te=
sts

NeilBrown (1):
      NFSD: fix possible oops when nfsd/pool_stats is closed.

Nigel Croxon (1):
      md/raid1: fix error: ISO C90 forbids mixed declarations

Nigel Kirkland (1):
      nvme-fc: Prevent null pointer dereference in nvme_fc_io_getuuid()

Niklas Cassel (4):
      ata: libata: disallow dev-initiated LPM transitions to unsupported st=
ates
      ata: libata-eh: do not clear ATA_PFLAG_EH_PENDING in ata_eh_reset()
      ata: libata-eh: do not thaw the port twice in ata_eh_reset()
      ata: libata-core: fetch sense data for successful commands iff CDL en=
abled

Nilesh Javali (2):
      scsi: qla2xxx: Correct endianness for rqstlen and rsplen
      scsi: qla2xxx: Use raw_smp_processor_id() instead of smp_processor_id=
()

Ondrej Mosnacek (1):
      selinux: fix handling of empty opts in selinux_fs_context_submount()

Palmer Dabbelt (1):
      Documentation: embargoed-hardware-issues.rst: Add myself for RISC-V

Pavel Begunkov (1):
      io_uring/net: fix iter retargeting for selected buf

Peter Zijlstra (2):
      x86/ibt: Suppress spurious ENDBR
      x86/ibt: Avoid duplicate ENDBR in __put_user_nocheck*()

Pratyush Yadav (1):
      nvme-pci: do not set the NUMA node of device if it has none

Qu Wenruo (1):
      btrfs: fix a compilation error if DEBUG is defined in btree_dirty_fol=
io

Rafael J. Wysocki (2):
      thermal: Constify the trip argument of the .get_trend() zone callback
      thermal: core: Fix disabled trip point check in handle_thermal_trip()

Randy Dunlap (1):
      drm/amd/display: fix replay_mode kernel-doc warning

Ratheesh Kannoth (1):
      octeontx2-pf: Fix page pool cache index corruption.

Ricardo B. Marliere (1):
      selftests: fix dependency checker script

Ricardo Neri (1):
      x86/sched: Restore the SD_ASYM_PACKING flag in the DIE domain

Ritesh Harjani (IBM) (1):
      jbd2: Remove page size assumptions

Sascha Hauer (1):
      net: macb: fix sleep inside spinlock

Shida Zhang (1):
      ext4: fix rec_len verify error

Shigeru Yoshida (1):
      kcm: Fix memory leak in error path of kcm_sendmsg()

Shravan Kumar Ramani (2):
      platform/mellanox: mlxbf-pmc: Fix potential buffer overflows
      platform/mellanox: mlxbf-pmc: Fix reading of unprogrammed events

Shrikanth Hegde (1):
      sched/fair: Optimize should_we_balance() for large SMT systems

Shubhrajyoti Datta (1):
      i2c: cadence: Fix the kernel-doc warnings

Simon Pilkington (1):
      drm/amd: Make fence wait in suballocator uninterruptible

Song Liu (1):
      x86/purgatory: Remove LTO flags

Song Shuai (1):
      riscv: kexec: Align the kexeced kernel entry

Steve French (3):
      smb3: move server check earlier when setting channel sequence number
      smb3: correct places where ENOTSUPP is used instead of preferred
EOPNOTSUPP
      smb3: fix some minor typos and repeated words

Steve Wahl (1):
      x86/platform/uv: Use alternate source for socket to node data

Steven Rostedt (Google) (15):
      tracefs: Add missing lockdown check to tracefs_create_dir()
      tracefs/eventfs: Add missing lockdown checks
      tracefs/eventfs: Use dput to free the toplevel events directory
      tracing: Increase trace array ref count on enable and filter files
      tracing: Have tracing_max_latency inc the trace array ref count
      tracing: Have current_trace inc the trace array ref count
      tracing: Have option files inc the trace array ref count
      tracing: Have event inject files inc the trace array ref count
      tracefs/eventfs: Free top level files on removal
      ring-buffer: Do not attempt to read past "commit"
      tracing: Use the new eventfs descriptor for print trigger
      tracing: Remove unused trace_event_file dir field
      tracing/synthetic: Fix order of struct trace_dynamic_info
      ftrace/selftests: Add softlink to latest log directory
      tracefs/eventfs: Use list_for_each_srcu() in dcache_dir_open_wrapper(=
)

Sudip Mukherjee (1):
      fbdev/g364fb: fix build failure with mips

Swapnil Patel (1):
      drm/amd/display: Don't check registers, if using AUX BL control

Szuying Chen (1):
      ata: libahci: clear pending interrupt status

Takashi Sakamoto (1):
      Revert "firewire: core: obsolete usage of GFP_ATOMIC at building
node tree"

Tero Kristo (1):
      tracing/synthetic: Print out u64 values properly

Thomas Hellstr=C3=B6m (2):
      drm/drm_exec: Work around a WW mutex lockdep oddity
      drm/tests: helpers: Avoid a driver uaf

Tim Chen (1):
      sched/fair: Fix SMT4 group_smt_balance handling

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      veth: Update XDP feature set when bringing up device

Tommy Huang (1):
      i2c: aspeed: Reset the i2c controller when timeout occurs

Ulf Hansson (1):
      pmdomain: Rename the genpd subsystem to pmdomain

Uwe Kleine-K=C3=B6nig (2):
      w1: ds2482: Switch back to use struct i2c_driver's .probe()
      i2c: Drop legacy callback .probe_new()

Vadim Fedorenko (1):
      ixgbe: fix timestamp configuration code

Varun Prakash (1):
      nvmet-tcp: pass iov_len instead of sg->length to bvec_set_page()

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Only check eDP HPD when AUX CH is shared

Vincent Whitchurch (1):
      net: stmmac: fix handling of zero coalescing tx-usecs

Vladimir Oltean (5):
      net: dsa: sja1105: hide all multicast addresses from "bridge fdb show=
"
      net: dsa: sja1105: propagate exact error code from
sja1105_dynamic_config_poll_valid()
      net: dsa: sja1105: fix multicast forwarding working only for
last added mdb entry
      net: dsa: sja1105: serialize sja1105_port_mcast_flood() with
other FDB accesses
      net: dsa: sja1105: block FDB accesses that are concurrent with a
switch reset

Wayne Lin (1):
      drm/amd/display: Adjust the MST resume flow

Yifan Zhang (1):
      drm/amd/display: fix the white screen issue when >=3D 64GB DRAM

Yoshihiro Shimoda (2):
      net: renesas: rswitch: Fix unmasking irq condition
      net: renesas: rswitch: Add spin lock protection for irq {un}mask

Yu Kuai (2):
      md: don't dereference mddev after export_rdev()
      md: fix warning for holder mismatch from export_rdev()

Zheng Yejian (2):
      selftests/ftrace: Correctly enable event in instance-event.tc
      ring-buffer: Avoid softlockup in ring_buffer_resize()

Ziyang Xuan (1):
      hsr: Fix uninit-value access in fill_frame_info()
