Return-Path: <linux-kernel+bounces-51640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A611848DC6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC111C21ABB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3490224D5;
	Sun,  4 Feb 2024 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gftY4yvG"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92651224CE
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707050381; cv=none; b=hE6Jcz4DJLntOL71QFUDwXaQODcAA4LjMuc0g1rHegH6bq0DwtSVftrZzgljBOuzVngNYb+yQ3hvnFdqHCW76N6GJx6qUgsxM8+ElaSqbw9rjeoN5NbtCbzemSeQrvyp0MbBdK/N6aWdu3fWeoWvbC1Zha9rKbJ7Zx2OXZWLPVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707050381; c=relaxed/simple;
	bh=3iHnyL3a9LzH1hWRYFSxmYjVtfFiSGGOYTqjTT7EbqE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i494r8PyR42AOQOsRzZ2Gtit3rkj6Wb4BX82OaAt532tmA/pG0mUjQc+dS7p8rfC2bNNfrLC/WuZFZWmbhbYaQQOV6f/C9FeaTJrjnrS1Rtu5PH+1HjxnQBxRBunv8G1VODYm2rD/NJhBnbufFyDikOGQABDk3VIWn+jXr9VMVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gftY4yvG; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d094bc2244so14504791fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 04:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707050376; x=1707655176; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmT1XfKQ7CHT6QsPT8D5nxm7vHJ7XBjoPyJxARnDig0=;
        b=gftY4yvGfqKJyC3vQodrSPALF1ectlMaWofBNQBx/bSN8oneU4vFUrM4r247d4vOwE
         fOXGJ/KlHFgifAVAb1rZu2HXbh9fgJ1YJhqSAdp3RSGV7tjsKb99ScnBXWMVAZnEDQHw
         fNaS4eyFeYedhKYaBvDHKDl6A7UvavuzHUjIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707050376; x=1707655176;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZmT1XfKQ7CHT6QsPT8D5nxm7vHJ7XBjoPyJxARnDig0=;
        b=UXJF921lmOcSf/TG0vtnGYTmB59hejMwdPpVjtr1Clou07JG9ccL14KphENxzDmgGm
         kZ2JduuFqkUVgKC0Sjjc+0kwtqOAMdIO88i5QTe+HiZ3mFzel1ir5L86g3ssP9BY2ApP
         Z33+V/pAPDqIbeaJqiCEradb6XTSPcHLuAfSOlL6XOgAijoeXPweX4/4s94qSZMCMDvF
         PSW0mGqFjWExV/YNGYrGhvLL3TxyR+2rd2WQ2hdLmJzMxsX7yY+5J6nRVEUa2m66ZZ5Z
         bmtWlVigECE+xSym4LQFwsa+gn6XqSJlcP7+RpFC5/XL+gGGzgfLJrjvq9TwOgKVwRYh
         /r0Q==
X-Gm-Message-State: AOJu0Yw8RT97FcOADXPnw5D8VAsx6E68uz9Xvkc8+XmW0h7Hw33KeRMv
	16VtGWrmRsIepgHA6DAPg/3cOxYnkGqTp9wsVQZpV47lxOT36d6QxZup868aZ1AZ5xmHxUWKRlK
	e1b0=
X-Google-Smtp-Source: AGHT+IHYQCjl4+VP2JK4XENEV85jzh5kXkQjgokl1KObe3WZg/YgY0oapowejBy2K1cJtsADas2Z4Q==
X-Received: by 2002:a05:651c:50b:b0:2cf:3006:6dce with SMTP id o11-20020a05651c050b00b002cf30066dcemr9848715ljp.15.1707050375626;
        Sun, 04 Feb 2024 04:39:35 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651c140400b002d0a5ae203fsm227340lje.10.2024.02.04.04.39.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 04:39:35 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d09bdddfc9so10500421fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 04:39:34 -0800 (PST)
X-Received: by 2002:a05:651c:19a8:b0:2d0:a8fe:a4ee with SMTP id
 bx40-20020a05651c19a800b002d0a8fea4eemr591766ljb.32.1707050373991; Sun, 04
 Feb 2024 04:39:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2024 12:39:17 +0000
X-Gmail-Original-Message-ID: <CAHk-=wisik=He=zySDRHq7fe6k_cOXZeZiCkR41TmbzK2KNZtg@mail.gmail.com>
Message-ID: <CAHk-=wisik=He=zySDRHq7fe6k_cOXZeZiCkR41TmbzK2KNZtg@mail.gmail.com>
Subject: Linux 6.8-rc3
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hmm. A slightly larger rc3 that I'd have hoped for, although at this
stage in the release process it's not something that really worries me
yet.

Aside from the usual driver fixes (with sound, gpu and nvme standing
out), we've got mainly filesystem fixes (tracefs and ext4) and a big
chunk of tooling updates (perf and selftests).

The rest is mostly a random collection of fixes all over. Fairly quiet
on the arch side, with mainly just some parisc fixes.

            Linus

---

Alan Adamson (1):
      nvme: allow passthru cmd error logging

Alexander Tsoy (6):
      ALSA: usb-audio: Skip setting clock selector for single connections
      ALSA: usb-audio: Add delay quirk for MOTU M Series 2nd revision
      ALSA: usb-audio: Support read-only clock selector control
      Revert "ALSA: usb-audio: Skip setting clock selector for single
connections"
      ALSA: usb-audio: Check presence of valid altsetting control
      ALSA: usb-audio: Ignore clock selector errors for single connection

Andi Shyti (1):
      MAINTAINERS: Update i2c host drivers repository

Andreas Gruenbacher (1):
      Revert "gfs2: Use GL_NOBLOCK flag for non-blocking lookups"

Andrew Halaney (1):
      MAINTAINERS: Drop unreachable reviewer for Qualcomm ETHQOS ethernet d=
river

Andrew Lunn (1):
      net: dsa: mv88e6xxx: Fix failed probe due to unsupported C45 reads

Andrey Albershteyn (1):
      xfs: reset XFS_ATTR_INCOMPLETE filter on node removal

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP ZBook Power

Ard Biesheuvel (2):
      arm64: Revert "scs: Work around full LTO issue with dynamic SCS"
      arm64: scs: Disable LTO for SCS patching code

Arnaldo Carvalho de Melo (10):
      tools headers uapi: Sync linux/stat.h with the kernel sources to
pick STATX_MNT_ID_UNIQUE
      tools arch x86: Sync the msr-index.h copy with the kernel
sources to pick IA32_MKTME_KEYID_PARTITIONING
      tools headers UAPI: Sync linux/fcntl.h with the kernel sources
      tools headers UAPI: Update tools's copy of drm.h headers to pick
DRM_IOCTL_MODE_CLOSEFB
      tools headers UAPI: Sync kvm headers with the kernel sources
      tools headers UAPI: Sync unistd.h to pick {list,stat}mount,
lsm_{[gs]et_self_attr,list_modules} syscall numbers
      tools headers x86 cpufeatures: Sync with the kernel sources to
pick TDX, Zen, APIC MSR fence changes
      tools headers: Update the copy of x86's mem{cpy,set}_64.S used
in 'perf bench'
      tools include UAPI: Sync linux/mount.h copy with the kernel sources
      perf tools headers: update the asm-generic/unaligned.h copy with
the kernel sources

Arthur Grillo (1):
      Documentation: KUnit: Update the instructions on how to test
static functions

Audra Mitchell (1):
      selftests/mm: Update va_high_addr_switch.sh to check CPU for la57 fla=
g

Badal Nilawar (1):
      drm/hwmon: Fix abi doc warnings

Badhri Jagan Sridharan (1):
      Revert "usb: typec: tcpm: fix cc role at port reset"

Baokun Li (8):
      ext4: fix double-free of blocks due to wrong extents moved_len
      ext4: do not trim the group with corrupted block bitmap
      ext4: regenerate buddy after block freeing failed if under fc replay
      ext4: avoid bb_free and bb_fragments inconsistency in mb_free_blocks(=
)
      ext4: avoid dividing by 0 in mb_update_avg_fragment_size() when
block bitmap corrupt
      ext4: avoid allocating blocks from corrupted group in
ext4_mb_try_best_found()
      ext4: avoid allocating blocks from corrupted group in
ext4_mb_find_by_goal()
      ext4: mark the group block bitmap as corrupted before reporting an er=
ror

Benjamin Poirier (5):
      selftests: team: Add missing config options
      selftests: bonding: Check initial state
      selftests: net: Remove executable bits from library scripts
      selftests: net: List helper scripts in TEST_FILES Makefile variable
      selftests: forwarding: List helper scripts in TEST_FILES Makefile var=
iable

Benjamin Tissoires (4):
      selftests/hid: wacom: fix confidence tests
      HID: bpf: remove double fdget()
      HID: bpf: actually free hdev memory after attaching a HID-BPF program
      HID: bpf: use __bpf_kfunc instead of noinline

Breno Leitao (2):
      bnxt_en: Make PTP timestamp HWRM more silent
      net: sysfs: Fix /sys/class/net/<iface> path

Brenton Simpson (1):
      Input: xpad - add Lenovo Legion Go controllers

Brett Creeley (6):
      pds_core: Prevent health thread from running during reset/remove
      pds_core: Cancel AQ work on teardown
      pds_core: Use struct pdsc for the pdsc_adminq_isr private data
      pds_core: Prevent race issues involving the adminq
      pds_core: Clear BARs on reset
      pds_core: Rework teardown/setup flow to be more common

Caleb Sander (5):
      nvme: return string as char *, not unsigned char *
      nvme: remove redundant status mask
      nvme: take const cmd pointer in read-only helpers
      nvme: split out fabrics version of nvme_opcode_str()
      nvme-fc: log human-readable opcode on timeout

Carlos Llamas (1):
      binder: signal epoll threads of self-work

Chaitanya Kulkarni (3):
      nvme: add module description to stop warnings
      nvmet: add module description to stop warnings
      nvme-common: add module description

Charlene Liu (2):
      Revert "drm/amd/display: initialize all the dpm level's stutter laten=
cy"
      drm/amd/display: fix USB-C flag update after enc10 feature init

Chen-Yu Tsai (3):
      ASoC: sunxi: sun4i-spdif: Add support for Allwinner H616
      ASoC: sun4i-spdif: Fix requirements for H6
      ASoC: sun4i-spdif: Add Allwinner H616 compatible

Chhayly Leang (1):
      ALSA: hda: cs35l41: Support ASUS Zenbook UM3402YAR

Christian A. Ehrhardt (3):
      usb: ucsi: Add missing ppm_lock
      usb: ucsi_acpi: Fix command completion handling
      usb: ucsi_acpi: Quirk to ack a connector change ack cmd

Christoph Niedermaier (1):
      tty: serial: Fix bit order in RS485 flag definitions

Christophe JAILLET (4):
      dmaengine: fsl-qdma: Fix a memory leak related to the status queue DM=
A
      dmaengine: fsl-qdma: Fix a memory leak related to the queue command D=
MA
      dmaengine: fsl-qdma: Remove a useless devm_kfree()
      ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Chunhai Guo (1):
      erofs: relaxed temporary buffers allocation on readahead

Colin Ian King (1):
      scsi: initio: Remove redundant variable 'rb'

Damian Muszynski (1):
      crypto: qat - fix arbiter mapping generation algorithm for QAT 402xx

Dan Carpenter (5):
      HID: hid-steam: remove pointless error message
      HID: hid-steam: Fix cleanup in probe()
      kunit: Fix a NULL vs IS_ERR() bug
      kunit: device: Fix a NULL vs IS_ERR() check in init()
      serial: 8250_pci1xxxx: fix off by one in pci1xxxx_process_read_data()

Daniel Bristot de Oliveira (1):
      tracing/timerlat: Move hrtimer_init to timerlat_fd open()

Daniel Golle (3):
      net: ethernet: mtk_eth_soc: set DMA coherent mask to get PPE working
      net: phy: mediatek-ge-soc: sync driver with MediaTek SDK
      net: dsa: mt7530: fix 10M/100M speed on MT7988 switch

Daniel Wagner (12):
      nvme-fc: do not wait in vain when unloading module
      nvmet-fcloop: swap the list_add_tail arguments
      nvmet-fc: release reference on target port
      nvmet-fc: defer cleanup using RCU properly
      nvmet-fc: free queue and assoc directly
      nvmet-fc: hold reference on hostport match
      nvmet-fc: remove null hostport pointer check
      nvmet-fc: do not tack refs on tgtports from assoc
      nvmet-fc: abort command when there is no binding
      nvmet-fc: avoid deadlock on delete association path
      nvmet-fc: take ref count on tgtport before delete assoc
      nvmet-fc: use RCU list iterator for assoc_list

Darrick J. Wong (1):
      xfs: remove conditional building of rt geometry validator functions

Dave Airlie (2):
      nouveau/gsp: use correct size for registry rpc.
      nouveau: offload fence uevents work to workqueue

Dave Kleikamp (1):
      Revert "jfs: fix shift-out-of-bounds in dbJoin"

David Gow (1):
      MAINTAINERS: kunit: Add Rae Moar as a reviewer

David Hildenbrand (3):
      uprobes: use pagesize-aligned virtual address when replacing pages
      mm/huge_memory: fix folio_set_dirty() vs. folio_mark_dirty()
      mm/memory: fix folio_set_dirty() vs. folio_mark_dirty() in zap_pte_ra=
nge()

David McFarland (1):
      drm/amd: Don't init MEC2 firmware when it fails to load

David Senoner (1):
      ALSA: hda/realtek: Fix the external mic not being recognised for
Acer Swift 1 SF114-32

Dmitry Baryshkov (1):
      usb: typec: tcpm: fix the PD disabled case

Dmitry Goncharov (1):
      kbuild: Replace tabs with spaces when followed by conditionals

Dmitry Safonov (2):
      selftests/net: Rectify key counters checks
      selftests/net: Repair RST passive reset selftest

Dmytro Laktyushkin (1):
      drm/amd/display: Fix DPSTREAM CLK on and off sequence

Donald Hunter (1):
      doc/netlink/specs: Add missing attr in rt_link spec

Edson Juliano Drosdeck (1):
      ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Ekansh Gupta (1):
      misc: fastrpc: Mark all sessions as invalid in cb_remove

Eric Dumazet (4):
      ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()
      tcp: add sanity checks to rx zerocopy
      llc: call sock_orphan() at release time
      af_unix: fix lockdep positive in sk_diag_dump_icons()

Esben Haabendal (2):
      net: stmmac: do not clear TBS enable bit on link up/down
      net: stmmac: dwmac-imx: set TSO/TBS TX queues default settings

Fangzhi Zuo (1):
      drm/amd/display: Fix dcn35 8k30 Underflow/Corruption Issue

Fedor Pchelkin (1):
      nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Fei Shao (1):
      ASoC: codecs: ES8326: Remove executable bit

Frank Li (1):
      dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Friedrich Vock (1):
      drm/amdgpu: Reset IH OVERFLOW_CLEAR bit

Gao Xiang (1):
      erofs: fix infinite loop due to a race of filling compressed_bvecs

Gaurav Jain (1):
      crypto: caam - fix asynchronous hash

Geetha sowjanya (1):
      octeontx2-pf: Remove xdp queues on program detach

Guanhua Gao (1):
      dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Gui-Dong Han (1):
      serial: core: Fix atomicity violation in uart_tiocmget

Guixin Liu (2):
      nvmet: unify aer type enum
      nvmet-tcp: fix nvme tcp ida memory leak

Hangbin Liu (1):
      selftests/net/lib: update busywait timeout value

Hannes Reinecke (3):
      nvme-auth: open-code single-use macros
      nvme: change __nvme_submit_sync_cmd() calling conventions
      nvme: enable retries for authentication commands

Hans de Goede (3):
      Input: goodix - accept ACPI resources with gpio_count =3D=3D 3 &&
gpio_int_idx =3D=3D 0
      Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID
      Input: atkbd - do not skip atkbd_deactivate() when skipping
ATKBD_CMD_GETID

Harshit Mogalapalli (1):
      hwmon: gigabyte_waterforce: Fix locking bug in waterforce_get_status(=
)

Heikki Krogerus (1):
      usb: dwc3: pci: add support for the Intel Arrow Lake-H

Helge Deller (7):
      parisc: Make RO_DATA page aligned in vmlinux.lds.S
      parisc: Check for valid stride size for cache flushes
      parisc: Prevent hung tasks when printing inventory on serial console
      parisc: Drop unneeded semicolon in parse_tree_node()
      ipv6: Ensure natural alignment of const ipv6 loopback and router addr=
esses
      parisc: Fix random data corruption from exception handler
      parisc: BTLB: Fix crash when setting up BTLB at CPU bringup

Hongyu Jin (1):
      block: Fix where bio IO priority gets set

Horatiu Vultur (2):
      phy: lan966x: Add missing serdes mux entry
      net: lan966x: Fix port configuration when using SGMII interface

Hugo Villeneuve (4):
      serial: max310x: set default value when reading clock ready bit
      serial: max310x: improve crystal stable clock detection
      serial: max310x: fail probe if clock crystal is unstable
      serial: max310x: prevent infinite while() loop in port startup

Hui Zhou (2):
      nfp: flower: add hardware offload check for post ct entry
      nfp: flower: fix hardware offload for the transfer layer port

Ian Rogers (6):
      perf list: Switch error message to pr_err() to respect debug settings=
 (-v)
      perf list: Add output file option
      perf test: Workaround debug output in list test
      perf test shell script: Fix test for python being disabled
      perf test shell daemon: Make signal test less racy
      perf vendor events intel: Alderlake/sapphirerapids metric fixes

Ido Schimmel (1):
      selftests: net: Add missing matchall classifier

Israel Rukshin (1):
      nvme-rdma: Fix transfer length when write_generate/read_verify are 0

Ivan Orlov (1):
      ALSA: pcm: Add missing formats to formats list

JackBB Wu (1):
      USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Jacob Keller (1):
      e1000e: correct maximum frequency adjustment values

Jacob Siverskog (1):
      ALSA: usb-audio: fix typo

Jai Luthra (1):
      dmaengine: ti: k3-udma: Report short packet errors

Jakub Kicinski (4):
      selftests: tcp_ao: add a config file
      selftests: tcp_ao: set the timeout to 2 minutes
      selftests: net: add missing config for nftables-backed iptables
      selftests: net: add missing config for NF_TARGET_TTL

James Clark (1):
      perf evlist: Fix evlist__new_default() for > 1 core PMU

Jan Beulich (1):
      xen-netback: properly sync TX responses

Jan Kara (1):
      readahead: avoid multiple marked readahead pages

Jason Gunthorpe (2):
      iommu: Allow ops->default_domain to work when !CONFIG_IOMMU_DMA
      drm/tegra: Do not assume that a NULL domain means no DMA IOMMU

Javier Carrasco (1):
      Input: bcm5974 - check endpoint type before starting traffic

Jay Cornwall (1):
      drm/amdkfd: Use S_ENDPGM_SAVED in trap handler

Jens Axboe (6):
      io_uring/rw: ensure poll based multishot read retries appropriately
      io_uring/poll: move poll execution helpers higher up
      io_uring/net: un-indent mshot retry path in io_recv_finish()
      io_uring/poll: add requeue return code from poll multishot handling
      io_uring/net: limit inline multishot retries
      io_uring/net: fix sr->len for IORING_OP_RECV with MSG_WAITALL and buf=
fers

Jingbo Xu (1):
      erofs: get rid of unneeded GFP_NOFS

Jiri Kosina (1):
      HID: logitech-hidpp: add support for Logitech G Pro X Superlight 2

Joe Lawrence (1):
      selftests/livepatch: fix and refactor new dmesg message code

Johan Hovold (8):
      ASoC: codecs: wsa883x: fix PA volume control
      ASoC: codecs: lpass-wsa-macro: fix compander volume hack
      ASoC: codecs: wcd9335: drop unused gain hack remnant
      ASoC: codecs: wcd938x: fix headphones volume controls
      ASoC: qcom: sc8280xp: limit speaker volumes
      HID: i2c-hid-of: fix NULL-deref on failed power up
      Revert "power: supply: qcom_battmgr: Register the power supplies
after PDR is up"
      PCI/ASPM: Fix deadlock when enabling ASPM

Johannes Weiner (1):
      mm: memcontrol: don't throttle dying tasks on memory.high

Jose Ignacio Tornos Martinez (1):
      kbuild: rpm-pkg: simplify installkernel %post

Jos=C3=A9 Relvas (1):
      ALSA: hda/realtek: Apply headset jack quirk for non-bass alc287 think=
pads

Jos=C3=A9 Roberto de Souza (1):
      drm/xe: Fix crash in trace_dma_fence_init()

Jozsef Kadlecsik (1):
      netfilter: ipset: fix performance regression in swap operation

Julian Sikorski (1):
      ALSA: usb-audio: Add a quirk for Yamaha YIT-W12TX transmitter

Kai-Heng Feng (1):
      HID: i2c-hid: Skip SET_POWER SLEEP for Cirque touchpad on system susp=
end

Kailang Yang (1):
      ALSA: hda/realtek - Add speaker pin verbtable for Dell dual
speaker platform

Keith Busch (1):
      nvme: use ctrl state accessor

Kemeng Shi (9):
      ext4: remove unused return value of __mb_check_buddy
      ext4: remove unused parameter ngroup in ext4_mb_choose_next_group_*()
      ext4: remove unneeded return value of ext4_mb_release_context
      ext4: remove unused ext4_allocation_context::ac_groups_considered
      ext4: remove unused return value of ext4_mb_release
      ext4: remove unused return value of ext4_mb_release_inode_pa
      ext4: remove unused return value of ext4_mb_release_group_pa
      ext4: remove unnecessary parameter "needed" in ext4_discard_prealloca=
tions
      ext4: remove 'needed' in trace_ext4_discard_preallocations

Kenzo Gomez (1):
      ALSA: hda: cs35l41: Support additional ASUS Zenbook UX3402VA

Kevin Brodsky (1):
      arm64: vdso32: Remove unused vdso32-offsets.h

Konstantin Aladyshev (2):
      hwmon: (pmbus/mp2975) Fix driver initialization for MP2975 device
      hwmon: (pmbus/mp2975) Correct comment inside 'mp2975_read_byte_data'

Krishna Kurapati (1):
      usb: gadget: ncm: Fix endianness of wMaxSegmentSize variable in ecm_d=
esc

Krzysztof Kozlowski (4):
      ASoC: codecs: wcd938x: handle deferred probe
      ASoC: codecs: wcd938x: skip printing deferred probe failuers
      ASoC: codecs: wcd934x: drop unneeded regulator include
      ASoC: allow up to eight CPU/codec DAIs

Kunwu Chan (2):
      dmaengine: ti: edma: Add some null pointer checks to the edma_probe
      HID: nvidia-shield: Add missing null pointer checks to LED initializa=
tion

Lang Yu (1):
      drm/amdkfd: reserve the BO before validating it

Le Ma (1):
      drm/amdgpu: move the drm client creation behind drm device registrati=
on

Lennert Buytenhek (1):
      ahci: Extend ASM1061 43-bit DMA address quirk to other ASM106x parts

Leonard Dallmayr (1):
      USB: serial: cp210x: add ID for IMST iM871A-USB

Li RongQing (2):
      scsi: virtio_scsi: Remove duplicate check if queue is broken
      ALSA: virtio: remove duplicate check if queue is broken

Linus L=C3=BCssing (3):
      batman-adv: mcast: fix mcast packet type counter on timeouted nodes
      batman-adv: mcast: fix memory leak on deleting a batman-adv interface
      bridge: mcast: fix disabled snooping after long uptime

Linus Torvalds (10):
      tracefs: remove stale 'update_gid' code
      soc: apple: mailbox: error pointers are negative integers
      eventfs: Initialize the tracefs inode properly
      tracefs: Avoid using the ei->dentry pointer unnecessarily
      tracefs: dentry lookup crapectomy
      eventfs: Remove unused d_parent pointer field
      eventfs: Clean up dentry ops and add revalidate function
      eventfs: Get rid of dentry pointers without refcounts
      Kconfig: Disable -Wstringop-overflow for GCC globally
      Linux 6.8-rc3

Lokesh Gidra (1):
      userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb

Lorenzo Pieralisi (1):
      MAINTAINERS: Add Manivannan Sadhasivam as PCI Endpoint maintainer

Luka Guzenko (1):
      ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

Ma Jun (2):
      drm/amdgpu: Fix the warning info in mode1 reset
      drm/amdgpu/pm: Use inline function for IP version check

Mantas Pucka (2):
      phy: qcom-qmp-usb: fix register offsets for ipq8074/ipq6018
      phy: qcom-qmp-usb: fix serdes init sequence for IPQ6018

Marco Elver (3):
      mm, kmsan: fix infinite recursion due to RCU critical section
      stackdepot: add stats counters exported via debugfs
      stackdepot: make fast paths lock-less again

Marco Pagani (1):
      kunit: run test suites only after module initialization completes

Marian Postevca (1):
      ASoC: amd: acp: Fix support for a Huawei Matebook laptop

Mario Limonciello (1):
      Revert "drm/amd/pm: fix the high voltage and temperature issue"

Mark Brown (2):
      kselftest/seccomp: Use kselftest output functions for benchmark
      kselftest/seccomp: Report each expectation we assert as a KTAP test

Martin Blumenstingl (3):
      regulator: pwm-regulator: Add validity checks in continuous .get_volt=
age
      regulator: pwm-regulator: Calculate the output voltage for disabled P=
WMs
      regulator: pwm-regulator: Manage boot-on with disabled PWM channels

Masahiro Yamada (3):
      kbuild: fix W=3D flags in the help message
      modpost: avoid using the alias attribute
      kconfig: initialize sym->curr.tri to 'no' for all symbol types again

Masami Hiramatsu (Google) (1):
      tracing/trigger: Fix to return error if failed to alloc snapshot

Mathias Nyman (3):
      xhci: fix possible null pointer dereference at secondary
interrupter removal
      xhci: fix off by one check when adding a secondary interrupter.
      xhci: process isoc TD properly when there was a transaction error mid=
 TD.

Mathieu Desnoyers (1):
      selftests/rseq: Do not skip !allowed_cpus for mm_cid

Matt Roper (1):
      drm/xe: Grab mem_access when disabling C6 on skip_guc_pc platforms

Matthew Brost (3):
      drm/xe: Only allow 1 ufence per exec / bind IOCTL
      drm/xe: Use LRC prefix rather than CTX prefix in lrc desc defines
      drm/xe: Make all GuC ABI shift values unsigned

Matthias May (1):
      selftests: net: add missing config for GENEVE

Matthieu Baerts (NGI0) (8):
      selftests: mptcp: add missing kconfig for NF Filter
      selftests: mptcp: add missing kconfig for NF Filter in v6
      selftests: mptcp: add missing kconfig for NF Mangle
      selftests: mptcp: increase timeout to 30 min
      selftests: mptcp: decrease BW in simult flows
      selftests: mptcp: allow changing subtests prefix
      selftests: mptcp: join: stop transfer when check is done (part 1)
      selftests: mptcp: join: stop transfer when check is done (part 2)

Michael Kelley (1):
      scsi: storvsc: Fix ring buffer size calculation

Michal Pecio (1):
      xhci: handle isoc Babble and Buffer Overrun events properly

Michal Vok=C3=A1=C4=8D (1):
      net: dsa: qca8k: fix illegal usage of GPIO

Mikulas Patocka (4):
      dm: limit the number of targets and parameter size area
      dm stats: limit the number of entries
      dm writecache: allow allocations larger than 2GiB
      dm-crypt, dm-verity: disable tasklets

Ming Lei (1):
      scsi: core: Move scsi_host_busy() out of host lock for waking up
EH handler

Mohammad Nassiri (1):
      selftests/net: Argument value mismatch when calling verify_counters()

Muhammad Usama Anjum (2):
      selftests/mm: mremap_test: fix build warning
      selftests/mm: switch to bash from sh

Mukul Joshi (1):
      drm/amdkfd: Use correct drm device for cgroup permission check

Nathan Chancellor (2):
      um: Fix adding '-no-pie' for clang
      modpost: Add '.ltext' and '.ltext.*' to TEXT_SECTIONS

Nicholas Susanto (1):
      drm/amd/display: Underflow workaround by increasing SR exit latency

Nico Pache (1):
      selftests: mm: fix map_hugetlb failure on 64K page size systems

Nicolas Dichtel (1):
      ipmr: fix kernel panic when forwarding mcast packets

Nikita Zhandarovich (1):
      net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Nitin U. Yewale (3):
      nvme-tcp: show hostnqn when connecting to tcp target
      nvme-rdma: show hostnqn when connecting to rdma target
      nvme-fc: show hostnqn when connecting to fc target

Oliver Neukum (1):
      USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Ondrej Mosnacek (2):
      lsm: fix the logic in security_inode_getsecctx()
      lsm: fix default return value of the socket_getpeersec_*() hooks

Pablo Neira Ayuso (3):
      netfilter: nf_tables: restrict tunnel object to NFPROTO_NETDEV
      netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger
      netfilter: nft_ct: sanitize layer 3 and 4 protocol number in
custom expectations

Paolo Abeni (11):
      selftests: net: remove dependency on ebpf tests
      selftests: net: included needed helper in the install targets
      selftests: net: explicitly wait for listener ready
      selftests: net: add missing config for big tcp tests
      selftests: net: add missing required classifier
      selftests: net: give more time for GRO aggregation
      selftests: net: add missing config for pmtu.sh tests
      selftests: net: fix available tunnels detection
      selftests: net: don't access /dev/stdout in pmtu.sh
      selftests: net: enable some more knobs
      mptcp: fix data re-injection from stale subflow

Parav Pandit (1):
      devlink: Fix referring to hw_addr attribute during state validation

Patrick Rudolph (1):
      regulator (max5970): Fix IRQ handler

Paulo Alcantara (1):
      smb: client: increase number of PDUs allowed in a compound request

Pavan Kumar Linga (1):
      idpf: avoid compiler padding in virtchnl2_ptype struct

Petr Vorel (1):
      MAINTAINERS: add man-pages git trees

Philip Yang (1):
      drm/amdkfd: Correct partial migration virtual addr

Prashanth K (2):
      usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
      usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Praveen Kaligineedi (1):
      gve: Fix skb truesize underestimation

Puliang Lu (1):
      USB: serial: option: add Fibocom FM101-GL variant

Randy Dunlap (2):
      dmaengine: at_hdmac: fix some kernel-doc warnings
      usb: gadget: pch_udc: fix an Excess kernel-doc warning

Richard Fitzgerald (18):
      ASoC: wm_adsp: Fix firmware file search order
      ASoC: wm_adsp: Don't overwrite fwf_name with the default
      ASoC: cs35l56: cs35l56_component_remove() must clear cs35l56->compone=
nt
      ASoC: cs35l56: cs35l56_component_remove() must clean up wm_adsp
      ASoC: cs35l56: Don't add the same register patch multiple times
      ASoC: cs35l56: Remove buggy checks from cs35l56_is_fw_reload_needed()
      ASoC: cs35l56: Fix to ensure ASP1 registers match cache
      ASoC: cs35l56: Fix default SDW TX mixer registers
      ALSA: hda: cs35l56: Initialize all ASP1 registers
      ASoC: cs35l56: Fix for initializing ASP1 mixer registers
      ASoC: cs35l56: Fix misuse of wm_adsp 'part' string for silicon revisi=
on
      ASoC: cs35l56: Firmware file must match the version of preloaded firm=
ware
      ASoC: cs35l56: Load tunings for the correct speaker models
      ASoC: cs35l56: Allow more time for firmware to boot
      ALSA: hda: cs35l56: Fix order of searching for firmware files
      ALSA: hda: cs35l56: Fix filename string field layout
      ALSA: hda: cs35l56: Firmware file must match the version of
preloaded firmware
      ALSA: hda: cs35l56: Remove unused test stub function

Romain Naour (1):
      regulator: ti-abb: don't use
devm_platform_ioremap_resource_byname for shared interrupt register

Rui Salvaterra (2):
      ALSA: hda: Replace numeric device IDs with constant values
      ALSA: hda: Increase default bdl_pos_adj for Apollo Lake

Ryan Roberts (2):
      selftests/mm: ksm_tests should only MADV_HUGEPAGE valid memory
      mm: thp_get_unmapped_area must honour topdown preference

Ryan Schaefer (1):
      netfilter: conntrack: correct window scaling with retransmitted SYN

Samasth Norway Ananda (1):
      NFSv4.1: Assign the right value for initval and retries for rpc timeo=
ut

Samuel Holland (1):
      scs: add CONFIG_MMU dependency for vfree_atomic()

Sean Anderson (1):
      usb: ulpi: Fix debugfs directory leak

Sean Young (1):
      ALSA: usb-audio: add quirk for RODE NT-USB+

Sebastian Ott (1):
      drm/virtio: Set segment size for virtio_gpu device

Shivaprasad G Bhat (1):
      powerpc: iommu: Bring back table group release_ownership() call

Shyam Prasad N (4):
      cifs: make sure that channel scaling is done only once
      cifs: avoid redundant calls to disable multichannel
      cifs: do not search for channel if server is terminating
      cifs: failure to add channel on iface should bump up weight

Sidhartha Kumar (1):
      fs/hugetlbfs/inode.c: mm/memory-failure.c: fix hugetlbfs hwpoison han=
dling

Simon Horman (1):
      MAINTAINERS: Add connector headers to NETWORKING DRIVERS

Sohaib Nadeem (1):
      drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz

Souradeep Chakrabarti (1):
      hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Srinivasan Shanmugam (3):
      drm/amd/display: Add NULL check for kzalloc in
'amdgpu_dm_atomic_commit_tail()'
      drm/amd/display: Fix buffer overflow in
'get_host_router_total_dp_tunnel_bw()'
      drm/amdgpu: Fix missing error code in 'gmc_v6/7/8/9_0_hw_init()'

Steven Rostedt (Google) (5):
      tracefs: Zero out the tracefs_inode when allocating it
      eventfs: Warn if an eventfs_inode is freed without is_freed being set
      eventfs: Restructure eventfs_inode structure to be more condensed
      eventfs: Remove fsnotify*() functions from lookup()
      eventfs: Keep all directory links at 1

Su Hui (2):
      scsi: isci: Fix an error code problem in isci_io_request_build()
      HID: hidraw: fix a problem of memory leak in hidraw_release()

Sun Haiyong (2):
      perf top: Remove needless malloc(0) call that triggers -Walloc-size
      perf tools: Fix calloc() arguments to address error introduced in gcc=
-14

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook U728 to i8042 quirk table

T.J. Mercier (1):
      dma-buf: heaps: Don't track CMA dma-buf pages under RssFile

Takashi Iwai (1):
      ALSA: usb-audio: Sort quirk table entries

Takashi Sakamoto (2):
      firewire: core: correct documentation of fw_csr_string() kernel API
      firewire: core: search descriptor leaf just after vendor
directory entry in root directory

Techno Mooney (1):
      ASoC: amd: yc: Add DMI quirk for MSI Bravo 15 C7VF

Thomas Hellstr=C3=B6m (3):
      drm/xe: Annotate mcr_[un]lock()
      drm/xe: Don't use __user error pointers
      drm/xe/vm: Subclass userptr vmas

Thomas Richter (1):
      perf test: Fix 'perf script' tests on s390

Tony Lindgren (1):
      phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Tyrel Datwyler (1):
      scsi: MAINTAINERS: Update ibmvscsi_tgt maintainer

Udipto Goswami (2):
      usb: gadget: ncm: Fix indentations in documentation of NCM section
      usb: core: Prevent null pointer dereference in update_port_device_sta=
te

Uttkarsh Aggarwal (1):
      usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspen=
d

Venkata Prasad Potturu (3):
      ASoC: amd: acp: Enable rt5682s clocks in acp slave mode
      ASoC: amd: acp: Update platform name for different boards
      ASoC: amd: acp: Add check for cpu dai link initialization

Vincent Donnefort (1):
      ring-buffer: Clean ring_buffer_poll_wait() error return

Vinod Koul (1):
      dmaengine: at_hdmac: add missing kernel-doc style description

Vitaly Rodionov (1):
      ALSA: hda/cs8409: Suppress vmaster control for Dolphin models

Wen Gu (1):
      net/smc: fix incorrect SMC-D link group matching logic

Wenjing Liu (1):
      drm/amd/display: fix incorrect mpc_combine array size

Werner Sembach (1):
      Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Will Deacon (1):
      misc: open-dice: Fix spurious lockdep warning

Wolfram Sang (1):
      spi: sh-msiof: avoid integer overflow in constants

Xin Long (1):
      netfilter: conntrack: check SCTP_CID_SHUTDOWN_ACK for vtag
setting in sctp_new

Xu Yang (1):
      usb: chipidea: core: handle power lost in workqueue

Yang Shi (2):
      mm: mmap: map MAP_STACK to VM_NOHUGEPAGE
      mm: huge_memory: don't force huge page alignment on 32 bit

Yicong Yang (1):
      perf build: Make minimal shellcheck version to v0.6.0

Yifan Zhang (2):
      drm/amdgpu: drm/amdgpu: remove golden setting for gfx 11.5.0
      drm/amdgpu: remove asymmetrical irq disabling in vcn 4.0.5 suspend

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

Yosry Ahmed (1):
      MAINTAINERS: supplement of zswap maintainers update

Yuezhang Mo (1):
      exfat: fix zero the unwritten part for dio read

Zach O'Keefe (1):
      mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

Zhang Bingwu (1):
      kbuild: defconf: use SRCARCH to find merged configs

Zhang Yi (6):
      ext4: refactor ext4_da_map_blocks()
      ext4: convert to exclusive lock while inserting delalloc extents
      ext4: correct the hole length returned by ext4_map_blocks()
      ext4: add a hole extent entry in cache after punch
      ext4: make ext4_map_blocks() distinguish delalloc only extent
      ext4: make ext4_set_iomap() recognize IOMAP_DELALLOC map type

Zhipeng Lu (1):
      net: ipv4: fix a memleak in ip_setup_cork

Zhu Ning (4):
      ASoC: codecs: ES8326: improving crosstalk performance
      ASoC: codecs: ES8326: Improving the THD+N performance
      ASoC: codecs: ES8326: Minimize the pop noise on headphone
      ASoC: codecs: ES8326: fix the capture noise issue

yuan linyu (1):
      usb: f_mass_storage: forbid async queue when shutdown happen

