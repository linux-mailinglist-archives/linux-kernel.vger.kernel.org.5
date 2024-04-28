Return-Path: <linux-kernel+bounces-161567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B5F8B4DCF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE89AB20DF7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 20:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050928F7A;
	Sun, 28 Apr 2024 20:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dTCMSOTa"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70417389
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714337957; cv=none; b=n91NGMOkzfwaeiTLMOEo4aZgdEwkjrhivC7i/Lo1tWZSwHMpNcALLmBF5R1BoJGb2PclwtWcWFPrac660soBgb7HjmLkOMil5Kfz7KwJ5u4s4Gczc2XczZSuxSa11azxNen9+Nb43ZyJxAbXsOgMCLhvLVDp+1Bt2Xs1Dl9JoJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714337957; c=relaxed/simple;
	bh=6v611dMIovBIKG+R+i/5Xt+2k/3nupw5LnApp8TRrs0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=V4gtz/2ryE/fUxGQhvL/1fMKBQmb9HE7OENjrnwuh3s7kcbQhc1WqPsfzmpR1oO3ABtz+JM8iS1zsDypdhnLAFsw5qjR6lFc8/Id8Fhj79bYLklxd28Ncrd/r1Gx32iX2yncjfYYjxRJTIIYW5PAM8OWp6Txzrbdcu9cSIL7Eeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dTCMSOTa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a56d7d457a1so445717066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714337952; x=1714942752; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ppecOhdnmK/ZFtIlxhpYik5L8yKW/vMr+Z8Q60DIco=;
        b=dTCMSOTaMQGk1R6DJ7OCJNG+L4ngPV4wfmMqr//LyS7wI5ENy0+j4D2qmYlS0SWsi8
         VqwCR3kJXdjmaZf8yDLcKIFcigyVe+K9ob53QvnOzIFouqrR53nYmKlqmr8Q7lzguWdr
         bA48TE6CYwM8vCYnCKcfgmm+jrNl5+pr1qk9E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714337952; x=1714942752;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ppecOhdnmK/ZFtIlxhpYik5L8yKW/vMr+Z8Q60DIco=;
        b=kZUykTlu0tDvUVvEE277yxLuMx1RleWAQDCpM30uaui3PRWyXfY6Dnk8Z+6H/4ZRrZ
         OBavikvP8/M9UOlRTt8s57BLpFs9gaQVjUoqxHV8a+iNgV+fakN3mGdAq99Omy9w4hts
         GkxtBUQUQziJiR9K945G2Xou95uQ/r4cJotDMYNzZQMEPuqqA87UK+qMMZsRFEGwqLu5
         ZPek31P6l072eZloCV0+k4dhqsWksYJmMo7ZDsjLVIFVdoZafyYnlYiIml+FKgQMK8kj
         k1/sIKWSRd9VL1mD8bGka3cDMQ4Wd35e/5bxp9Z4IkeodwrBChFEAoyxJKSdqaZCSEKe
         B0Yw==
X-Gm-Message-State: AOJu0YxqpPAdUdmiGdsyemlMrbbG4MAlE0/tbEIcr3uZJ3K1GcbTl/RF
	r5se8fcj+71kQGJSYax+y1Ul+yyrjqZpqjo8Vb3V1SO/JQZ8hKU/+2AIEFvdFIPArdUqbmWnvd7
	9Dn6PVQ==
X-Google-Smtp-Source: AGHT+IGVnER1sWGnc6U/Sx+m6FzKx+JR7JjeaJfTQoxHhKMtThPnwPltXHlNRKN2I1+y5CInOeBWDA==
X-Received: by 2002:a17:907:318a:b0:a58:c6b2:7885 with SMTP id xe10-20020a170907318a00b00a58c6b27885mr5180380ejb.5.1714337952182;
        Sun, 28 Apr 2024 13:59:12 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id bw22-20020a170906c1d600b00a587281c3efsm7494353ejb.9.2024.04.28.13.59.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Apr 2024 13:59:11 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a55b3d57277so451668866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:59:11 -0700 (PDT)
X-Received: by 2002:a17:906:ef07:b0:a55:a670:4e63 with SMTP id
 f7-20020a170906ef0700b00a55a6704e63mr7257780ejs.13.1714337950890; Sun, 28 Apr
 2024 13:59:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 28 Apr 2024 13:58:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=witYatGg+jW1kVu2Moq6yF2JNFe3wn7G0sMNhE=H=9voA@mail.gmail.com>
Message-ID: <CAHk-=witYatGg+jW1kVu2Moq6yF2JNFe3wn7G0sMNhE=H=9voA@mail.gmail.com>
Subject: Linux 6.9-rc6
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Things continue to look pretty normal, and nothing here really stands
out. The biggest single change that stands out in the diffstat is
literally a documentation update, everything else looks pretty small
and spread out.

We have the usual driver updates (mainly networking and gpu but some
updates elsewhere), some filesystem updates (mainly smb, bcachefs,
nfsd reverts, and some ntfs compat updates), and misc other fixes all
over - wifi fixes, arm dts fixlets, yadda yadda.

Nothing looks particularly big or bad. Shortlog appended for details,
please do keep testing,

                Linus

---

Abdelrahman Morsy (1):
      HID: mcp-2221: cancel delayed_work only when CONFIG_IIO is enabled

Akhil R (1):
      dmaengine: tegra186: Fix residual calculation

Alex Deucher (1):
      drm/amdgpu/sdma5.2: use legacy HDP flush for SDMA2/3

Alex Elder (1):
      mailmap: add entries for Alex Elder

Alexey Brodkin (1):
      ARC: [plat-hsdk]: Remove misplaced interrupt-cells property

Alice Ryhl (1):
      rust: don't select CONSTRUCTORS

Andrei Simion (2):
      ARM: dts: microchip: at91-sama7g5ek: Replace
regulator-suspend-voltage with the valid property
      ARM: dts: microchip: at91-sama7g54_curiosity: Replace
regulator-suspend-voltage with the valid property

Andrew Jones (1):
      RISC-V: selftests: cbo: Ensure asm operands match constraints, take 2

Andrey Ryabinin (1):
      stackdepot: respect __GFP_NOLOCKDEP allocation flag

Andy Shevchenko (2):
      idma64: Don't try to serve interrupts when device is powered off
      gpio: tangier: Use correct type for the IRQ chip data

Andy Yan (1):
      arm64: dts: rockchip: Fix the i2c address of es8316 on Cool Pi CM5

AngeloGioacchino Del Regno (1):
      soc: mediatek: mtk-svs: Append "-thermal" to thermal zone names

Arkadiusz Kubalewski (1):
      dpll: fix dpll_pin_on_pin_register() for multiple parent pins

Arnd Bergmann (2):
      dmaengine: owl: fix register access functions
      mtd: diskonchip: work around ubsan link failure

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      arm64: dts: rockchip: set PHY address of MT7531 switch to 0x1f

Aswin Unnikrishnan (1):
      rust: remove `params` from `module` macro example

Avraham Stern (1):
      wifi: iwlwifi: mvm: remove old PASN station when adding a new one

Baoquan He (1):
      LoongArch: Fix Kconfig item and left code related to CRASH_CORE

Bartosz Golaszewski (1):
      Bluetooth: qca: set power_ctrl_enabled on NULL returned by
gpiod_get_optional()

Ben Zong-You Xie (1):
      perf riscv: Fix the warning due to the incompatible type

Benjamin Tissoires (1):
      MAINTAINERS: update Benjamin's email address

Benno Lossin (1):
      rust: macros: fix soundness issue in `module!` macro

Bibo Mao (1):
      LoongArch: Lately init pmu after smp is online

Bjorn Helgaas (1):
      ARC: Fix typos

Bo-Wei Chen (1):
      docs: rust: fix improper rendering in Arch Support page

Christian Brauner (3):
      ntfs3: serve as alias for the legacy ntfs driver
      ntfs3: enforce read-only when used as legacy ntfs driver
      ntfs3: add legacy ntfs file operations

Christian Gmeiner (1):
      Revert "drm/etnaviv: Expose a few more chipspecs to userspace"

Christian Marangi (2):
      mtd: rawnand: qcom: Fix broken OP_RESET_DEVICE command in
qcom_misc_cmd_type_exec()
      mtd: limit OTP NVMEM cell parse to non-NAND devices

Christoph M=C3=BCllner (2):
      riscv: thead: Rename T-Head PBMT to MAE
      riscv: T-Head: Test availability bit before enabling MAE errata

Chuck Lever (3):
      Revert "svcrdma: Add Write chunk WRs to the RPC's Send WR chain"
      Revert "NFSD: Reschedule CB operations when backchannel rpc_clnt
is shut down"
      Revert "NFSD: Convert the callback workqueue to use delayed_work"

Chun-Yi Lee (1):
      Bluetooth: hci_sync: Using hci_cmd_sync_submit when removing Adv Moni=
tor

Cl=C3=A9ment L=C3=A9ger (2):
      riscv: hwprobe: fix invalid sign extension for RISCV_HWPROBE_EXT_ZVFH=
MIN
      selftests: sud_test: return correct emulated syscall value on RISC-V

Conor Dooley (1):
      rust: make mutually exclusive with CFI_CLANG

Cristian Ciocaltea (1):
      phy: phy-rockchip-samsung-hdptx: Select CONFIG_RATIONAL

Dan Carpenter (1):
      net: ti: icssg-prueth: Fix signedness bug in prueth_init_rx_chns()

Dan Williams (1):
      cxl/core: Fix potential payload size confusion in cxl_mem_get_poison(=
)

Daniel Golle (2):
      soc: mediatek: mtk-socinfo: depends on CONFIG_SOC_BUS
      net: phy: mediatek-ge-soc: follow netdev LED trigger semantics

Daniel Okazaki (1):
      eeprom: at24: fix memory corruption race condition

Daniele Palmas (1):
      net: usb: qmi_wwan: add Telit FN920C04 compositions

David Bauer (1):
      vxlan: drop packets from invalid src-address

David Christensen (1):
      MAINTAINERS: eth: mark IBM eHEA as an Orphan

David Hildenbrand (1):
      LoongArch: Fix a build error due to __tlb_remove_tlb_entry()

David Howells (4):
      cifs: Fix reacquisition of volume cookie on still-live connection
      cifs: Add tracing for the cifs_tcon struct refcounting
      netfs: Fix writethrough-mode error handling
      netfs: Fix the pre-flush when appending to a file in writethrough mod=
e

David Kaplan (1):
      x86/cpu: Fix check for RDPKRU in __show_regs()

David Sterba (1):
      btrfs: remove colon from messages with state

Derek Foreman (1):
      drm/etnaviv: fix tx clock gating on some GC7000 variants

Dragan Simic (2):
      arm64: dts: rockchip: Remove unsupported node from the Pinebook Pro d=
ts
      arm64: dts: rockchip: Designate the system power controller on Quartz=
Pro64

Duanqiang Wen (3):
      net: libwx: fix alloc msix vectors failed
      Revert "net: txgbe: fix i2c dev name cannot match clkdev"
      Revert "net: txgbe: fix clk_name exceed MAX_DEV_ID limits"

Duoming Zhou (1):
      ax25: Fix netdev refcount issue

Edward Liaw (1):
      selftests/harness: remove use of LINE_MAX

Eric Dumazet (4):
      icmp: prevent possible NULL dereferences from icmp_build_probe()
      net: fix sk_memory_allocated_{add|sub} vs softirqs
      ipv4: check for NULL idev in ip_route_use_hint()
      net: usb: ax88179_178a: stop lying about skb->truesize

Eric Van Hensbergen (1):
      fs/9p: mitigate inode collisions

Erwan Velu (1):
      i40e: Report MFS in decimal base instead of hex

Felix Fietkau (1):
      wifi: mac80211: split mesh fast tx cache into local/proxied/forwarded

Felix Kuehling (3):
      drm/amdkfd: Fix eviction fence handling
      drm/amdgpu: Update BO eviction priorities
      drm/amdkfd: Fix rescheduling of restore worker

Fenghua Yu (1):
      dmaengine: idxd: Fix oops during rmmod on single-CPU platforms

Gabor Juhos (1):
      phy: qcom: m31: match requested regulator name with dt schema

Geert Uytterhoeven (1):
      net: ravb: Fix registered interrupt names

Guanrui Huang (1):
      irqchip/gic-v3-its: Prevent double free on error

Guenter Roeck (1):
      MAINTAINERS: Drop entry for PCA9541 bus master selector

Gustavo A. R. Silva (1):
      smb: client: Fix struct_group() usage in __packed structs

G=C3=BCnther Noack (1):
      fs: Return ENOTTY directly if FS_IOC_GETUUID or FS_IOC_GETFSSYSFSPATH=
 fail

Hangbin Liu (1):
      bridge/br_netlink.c: no need to return void function

Hans de Goede (1):
      phy: ti: tusb1210: Resolve charger-det crash if charger psy is
unregistered

Himal Prasad Ghimiray (2):
      drm/xe: Remove sysfs only once on action add failure
      drm/xe: call free_gsc_pkt only once on action add failure

Huacai Chen (1):
      LoongArch: Fix callchain parse error with kernel tracepoint events

Hyunwoo Kim (3):
      tcp: Fix Use-After-Free in tcp_ao_connect_init
      net: gtp: Fix Use-After-Free in gtp_dellink
      net: openvswitch: Fix Use-After-Free in ovs_ct_exit

Ido Schimmel (12):
      mlxsw: core: Unregister EMAD trap using FORWARD action
      mlxsw: core_env: Fix driver initialization with old firmware
      mlxsw: pci: Fix driver initialization with old firmware
      mlxsw: spectrum_acl_tcam: Fix race in region ID allocation
      mlxsw: spectrum_acl_tcam: Fix race during rehash delayed work
      mlxsw: spectrum_acl_tcam: Fix possible use-after-free during
activity update
      mlxsw: spectrum_acl_tcam: Fix possible use-after-free during rehash
      mlxsw: spectrum_acl_tcam: Rate limit error message
      mlxsw: spectrum_acl_tcam: Fix memory leak during rehash
      mlxsw: spectrum_acl_tcam: Fix warning during rehash
      mlxsw: spectrum_acl_tcam: Fix incorrect list API usage
      mlxsw: spectrum_acl_tcam: Fix memory leak when canceling rehash work

Igor Artemiev (1):
      wifi: cfg80211: fix the order of arguments for trace events of
the tx_rx_evt class

Ikjoon Jang (1):
      arm64: dts: mediatek: mt8183: Add power-domains properity to mfgcfg

Iskander Amara (2):
      arm64: dts: rockchip: enable internal pull-up for Q7_THRM# on RK3399 =
Puma
      arm64: dts: rockchip: fix alphabetical ordering RK3399 puma

Ismael Luceno (1):
      ipvs: Fix checksumming on GSO of SCTP packets

Jack Xiao (1):
      drm/amdgpu/mes: fix use-after-free issue

Jacob Keller (1):
      ice: fix LAG and VF lock dependency in ice_reset_vf()

Jakub Kicinski (2):
      tools: ynl: don't ignore errors in NLMSG_DONE messages
      eth: bnxt: fix counting packets discarded due to OOM and netpoll

Jarred White (1):
      ACPI: CPPC: Fix bit_offset shift in MASK_VAL() macro

Jason Reeder (1):
      net: ethernet: ti: am65-cpts: Fix PTPv1 message type on TX packets

Jiantao Shan (1):
      LoongArch: Fix access error when read fault on a write-only VMA

Johan Hovold (5):
      phy: qcom: qmp-combo: fix VCO div offset on v5_5nm and v6
      arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
      Bluetooth: qca: fix invalid device address check
      Bluetooth: qca: fix NULL-deref on non-serdev suspend
      Bluetooth: qca: fix NULL-deref on non-serdev setup

Johannes Berg (12):
      wifi: mac80211: check EHT/TTLM action frame length
      wifi: mac80211: don't use rate mask for scanning
      Revert "wifi: iwlwifi: bump FW API to 90 for BZ/SC devices"
      wifi: mac80211: fix idle calculation with multi-link
      wifi: mac80211: mlme: re-parse with correct mode
      wifi: mac80211: mlme: fix memory leak
      wifi: mac80211: mlme: re-parse if AP mode is less than client
      wifi: nl80211: don't free NULL coalescing rule
      wifi: mac80211_hwsim: init peer measurement result
      wifi: mac80211: remove link before AP
      wifi: mac80211: fix unaligned le16 access
      wifi: iwlwifi: mvm: fix link ID management

Johannes Thumshirn (1):
      btrfs: fix information leak in btrfs_ioctl_logical_to_ino()

Johannes Weiner (1):
      mm: zswap: fix shrinker NULL crash with cgroup_disable=3Dmemory

Jose Ignacio Tornos Martinez (1):
      arm64: dts: rockchip: regulator for sd needs to be always on for BPI-=
R2Pro

Joshua Ashton (1):
      drm/amd/display: Set color_mgmt_changed to true on unsuspend

Justin Chen (1):
      net: bcmasp: fix memory leak when bringing down interface

Kalle Valo (1):
      wifi: ath11k: use RCU when accessing struct inet6_dev::ac_list

Kenny Levinsen (1):
      HID: i2c-hid: Revert to await reset ACK before reading report descrip=
tor

Kent Overstreet (14):
      bcachefs: Fix null ptr deref in twf from BCH_IOCTL_FSCK_OFFLINE
      bcachefs: node scan: ignore multiple nodes with same seq if interior
      bcachefs: make sure to release last journal pin in replay
      bcachefs: Fix bch2_dev_btree_bitmap_marked_sectors() shift
      bcachefs: KEY_TYPE_error is allowed for reflink
      bcachefs: fix leak in bch2_gc_write_reflink_key
      bcachefs: Fix bio alloc in check_extent_checksum()
      bcachefs: Check for journal entries overruning end of sb clean sectio=
n
      bcachefs: Fix missing call to bch2_fs_allocator_background_exit()
      bcachefs: bkey_cached.btree_trans_barrier_seq needs to be a ulong
      bcachefs: Tweak btree key cache shrinker so it actually frees
      bcachefs: Fix deadlock in journal write path
      bcachefs: Fix inode early destruction path
      bcachefs: If we run merges at a lower watermark, they must be nonbloc=
king

Kirill A. Shutemov (1):
      x86/tdx: Preserve shared bit on mprotect()

Krzysztof Kozlowski (4):
      arm64: dts: rockchip: drop panel port unit address in GRU Scarlet
      arm64: dts: rockchip: drop redundant pcie-reset-suspend in Scarlet Du=
mo
      arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 1
      arm64: dts: rockchip: drop redundant disable-gpios in Lubancat 2

Kuniyuki Iwashima (1):
      af_unix: Suppress false-positive lockdep splat for spin_lock()
in __unix_gc().

Laine Taffin Altman (1):
      rust: init: remove impl Zeroable for Infallible

Lang Yu (2):
      drm/amdkfd: make sure VM is ready for updating operations
      drm/amdgpu/umsch: don't execute umsch test when GPU is in reset/suspe=
nd

Lijo Lazar (2):
      drm/amdgpu: Assign correct bits for SDMA HDP flush
      drm/amd/pm: Restore config space after reset

Linus Torvalds (1):
      Linux 6.9-rc6

Louis Chauvet (1):
      dmaengine: xilinx: xdma: Fix synchronization issue

Luca Weiss (1):
      arm64: dts: qcom: Fix type of "wdog" IRQs for remoteprocs

Lucas Stach (1):
      drm/atomic-helper: fix parameter order in
drm_format_conv_state_copy() call

Luiz Augusto von Dentz (3):
      Bluetooth: hci_sync: Use advertised PHYs on hci_le_ext_create_conn_sy=
nc
      Bluetooth: hci_event: Fix sending HCI_OP_READ_ENC_KEY_SIZE
      Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID

Lukas Wunner (1):
      igc: Fix LED-related deadlock on driver unbind

MD Danish Anwar (1):
      net: phy: dp83869: Fix MII mode failure

Ma Jun (1):
      drm/amdgpu/pm: Remove gpu_od if it's an empty directory

Maksim Kiselev (1):
      mmc: sdhci-of-dwcmshc: th1520: Increase tuning loop count to 128

Manivannan Sadhasivam (3):
      arm64: dts: qcom: sm8450: Fix the msi-map entries
      arm64: dts: qcom: sm8550: Fix the msi-map entries
      arm64: dts: qcom: sm8650: Fix the msi-map entries

Mantas Pucka (1):
      mmc: sdhci-msm: pervent access to suspended controller

Marcel Ziswiler (1):
      phy: freescale: imx8m-pcie: fix pcie link-up instability

Marek Vasut (1):
      arm64: dts: imx8mp: Fix assigned-clocks for second CSI2

Marios Makassikis (1):
      ksmbd: clear RENAME_NOREPLACE before calling vfs_rename

Matthew Sakai (1):
      dm vdo murmurhash: remove unneeded semicolon

Matthew Wilcox (Oracle) (3):
      mm: create FOLIO_FLAG_FALSE and FOLIO_TYPE_OPS macros
      mm: support page_mapcount() on page_has_type() pages
      mm: turn folio_test_hugetlb into a PageType

Matthias Schiffer (1):
      net: dsa: mv88e6xx: fix supported_interfaces setup in
mv88e6250_phylink_get_caps()

Maximilian Luz (2):
      firmware: qcom: uefisecapp: Fix memory related IO errors and crashes
      arm64: dts: qcom: sc8180x: Fix ss_phy_irq for secondary USB controlle=
r

Miaohe Lin (1):
      mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when dissolve_free_hugetlb_fol=
io()

Michael Chan (1):
      bnxt_en: Fix error recovery for 5760X (P7) chips

Michael Heimpold (1):
      ARM: dts: imx6ull-tarragon: fix USB over-current polarity

Michal Tomek (1):
      phy: rockchip-snps-pcie3: fix bifurcation on rk3588

Michal Wajdeczko (1):
      drm/xe/guc: Fix arguments passed to relay G2H handlers

Miguel Ojeda (2):
      kbuild: rust: remove unneeded `@rustc_cfg` to avoid ICE
      kbuild: rust: force `alloc` extern to allow "empty" Rust files

Mikhail Kobuk (2):
      phy: marvell: a3700-comphy: Fix out of bounds read
      phy: marvell: a3700-comphy: Fix hardcoded array size

Ming Lei (1):
      dm: restore synchronous close of device mapper block device

Miquel Raynal (2):
      dmaengine: xilinx: xdma: Fix wrong offsets in the buffers
addresses in dma descriptor
      dmaengine: xilinx: xdma: Clarify kdoc in XDMA driver

Miri Korenblit (1):
      wifi: iwlwifi: mvm: return uid from iwl_mvm_build_scan_cmd

Muhammad Usama Anjum (2):
      selftests: mm: fix unused and uninitialized variable warning
      selftests: mm: protection_keys: save/restore nr_hugepages value
from launch script

Muhammed Efe Cetin (1):
      arm64: dts: rockchip: mark system power controller and fix typo
on orangepi-5-plus

Mukul Joshi (2):
      drm/amdgpu: Fix leak when GPU memory allocation fails
      drm/amdkfd: Add VRAM accounting for SVM migration

Nam Cao (2):
      HID: i2c-hid: remove I2C_HID_READ_PENDING flag to prevent lock-up
      fbdev: fix incorrect address computation in deferred IO

Namjae Jeon (4):
      ksmbd: fix slab-out-of-bounds in smb2_allocate_rsp_buf
      ksmbd: validate request buffer size in smb2_allocate_rsp_buf()
      ksmbd: common: use struct_group_attr instead of struct_group for
network_open_info
      ksmbd: add continuous availability share parameter

Naohiro Aota (1):
      btrfs: scrub: run relocation repair when/only needed

Nathan Chancellor (2):
      bcachefs: Fix format specifier in validate_bset_keys()
      Bluetooth: Fix type of len in {l2cap,sco}_sock_getsockopt_old()

Nuno Pereira (1):
      HID: nintendo: Fix N64 controller being identified as mouse

N=C3=ADcolas F. R. A. Prado (5):
      arm64: dts: mediatek: mt8192: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to vpp/vdosy=
s
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex
      arm64: dts: mediatek: mt8195: Add missing gce-client-reg to mutex1
      arm64: dts: mediatek: cherry: Describe CPU supplies

Oleg Nesterov (2):
      sched/isolation: Prevent boot crash when the boot CPU is nohz_full
      sched/isolation: Fix boot crash when maxcpus < first housekeeping CPU

Pablo Neira Ayuso (1):
      netfilter: nf_tables: honor table dormant flag from netdev
release event path

Patrik Jakobsson (1):
      drm/gma500: Remove lid code

Paul Geurts (1):
      NFC: trf7970a: disable all regulators on removal

Paulo Alcantara (1):
      smb: client: fix rename(2) regression against samba

Peter M=C3=BCnster (1):
      net: b44: set pause params only when interface is up

Peter Xu (1):
      mm/hugetlb: fix missing hugetlb_lock for resv uncharge

Peyton Lee (1):
      drm/amdgpu/vpe: fix vpe dpm setup failed

Pin-yen Lin (4):
      arm64: dts: mediatek: mt8192-asurada: Update min voltage
constraint for MT6315
      arm64: dts: mediatek: mt8195-cherry: Update min voltage
constraint for MT6315
      arm64: dts: mediatek: mt8183-kukui: Use default min voltage for MT635=
8
      arm64: dts: mediatek: mt8186-corsola: Update min voltage
constraint for Vgpu

Prathamesh Shete (1):
      gpio: tegra186: Fix tegra186_gpio_is_accessible() check

Prike Liang (1):
      drm/amdgpu: Fix the ring buffer size for queue VM flush

Qu Wenruo (1):
      btrfs: fix wrong block_start calculation for btrfs_drop_extent_map_ra=
nge()

Quentin Schulz (3):
      arm64: dts: rockchip: enable internal pull-up on Q7_USB_ID for RK3399=
 Puma
      arm64: dts: rockchip: enable internal pull-up on PCIE_WAKE# for
RK3399 Puma
      arm64: dts: rockchip: add regulators for PCIe on RK3399 Puma Haikou

Rafael J. Wysocki (1):
      ACPI: PM: s2idle: Evaluate all Low-Power S0 Idle _DSM functions

Rafa=C5=82 Mi=C5=82ecki (9):
      arm64: dts: mediatek: mt7622: fix clock controllers
      arm64: dts: mediatek: mt7622: fix IR nodename
      arm64: dts: mediatek: mt7622: fix ethernet controller "compatible"
      arm64: dts: mediatek: mt7622: drop "reset-names" from thermal block
      arm64: dts: mediatek: mt7986: drop invalid properties from ethsys
      arm64: dts: mediatek: mt7986: drop "#reset-cells" from Ethernet contr=
oller
      arm64: dts: mediatek: mt7986: drop invalid thermal block clock
      arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps with "map-"
      arm64: dts: mediatek: mt2712: fix validation errors

Rahul Rameshbabu (4):
      macsec: Enable devices to advertise whether they update sk_buff
md_dst during offloads
      ethernet: Add helper for assigning packet type when dest address
does not match device address
      macsec: Detect if Rx skb is macsec-related for offloading
devices that update md_dst
      net/mlx5e: Advertise mlx5 ethernet driver updates sk_buff md_dst
for MACsec

Rajendra Nayak (1):
      arm64: dts: qcom: x1e80100: Fix the compatible for cluster idle state=
s

Rex Zhang (1):
      dmaengine: idxd: Convert spinlock to mutex to lock evl workqueue

Richard Kinder (1):
      wifi: mac80211: ensure beacon is non-S1G prior to extracting the
beacon timestamp field

Rob Herring (3):
      dt-bindings: rockchip: grf: Add missing type to 'pcie-phy' node
      dt-bindings: eeprom: at24: Fix ST M24C64-D compatible schema
      arm64: dts: rockchip: Fix USB interface compatible string on
kobol-helios64

Sabrina Dubroca (1):
      tls: fix lockless read of strp->msg_ready in ->poll

Samuel Holland (2):
      riscv: Fix TASK_SIZE on 64-bit NOMMU
      riscv: Fix loading 64-bit NOMMU kernels past the start of RAM

Sean Anderson (1):
      dma: xilinx_dpdma: Fix locking

Sean Christopherson (2):
      cpu: Re-enable CPU mitigations by default for !X86 architectures
      cpu: Ignore "mitigations" kernel parameter if CPU_MITIGATIONS=3Dn

Sean Wang (1):
      Bluetooth: btusb: mediatek: Fix double free of skb in coredump

Sebastian Reichel (2):
      phy: rockchip-snps-pcie3: fix clearing PHP_GRF_PCIESEL_CON bits
      phy: rockchip: naneng-combphy: Fix mux on rk3588

Sergei Antonov (1):
      mmc: moxart: fix handling of sgm->consumed, otherwise WARN_ON trigger=
s

Sindhu Devale (1):
      i40e: Do not use WQ_MEM_RECLAIM flag for workqueue

Stephen Boyd (2):
      phy: qcom: qmp-combo: Fix VCO div offset on v3
      phy: qcom: qmp-combo: Fix register base for QSERDES_DP_PHY_MODE

Steve French (2):
      smb3: missing lock when picking channel
      smb3: fix lock ordering potential deadlock in cifs_sync_mid_result

Su Hui (1):
      octeontx2-af: fix the double free in rvu_npc_freemem()

Sudheer Mogilappagari (1):
      iavf: Fix TC config comparison with existing adapter TC config

Sweet Tea Dorminy (1):
      btrfs: fallback if compressed IO fails for ENOSPC

Takayuki Nagata (1):
      cifs: reinstate original behavior again for forceuid/forcegid

Tetsuo Handa (1):
      profiling: Remove create_prof_cpu_mask().

Thorsten Leemhuis (6):
      docs: verify/bisect: use git switch, tag kernel, and various fixes
      docs: verify/bisect: add and fetch stable branches ahead of time
      docs: verify/bisect: proper headlines and more spacing
      docs: verify/bisect: explain testing reverts, patches and newer code
      docs: verify/bisect: describe how to use a build host
      docs: verify/bisect: stable regressions: first stable, then mainline

Tianchen Ding (2):
      sched/eevdf: Always update V if se->on_rq when reweighting
      sched/eevdf: Fix miscalculation in reweight_entity() when se is not c=
urr

Tom Lendacky (1):
      x86/sev: Check for MWAITX and MONITORX opcodes in the #VC handler

Uwe Kleine-K=C3=B6nig (1):
      MAINTAINERS: Update Uwe's email address, drop SIOX maintenance

Vanshidhar Konda (1):
      ACPI: CPPC: Fix access width used for PCC registers

Vijendar Mukunda (1):
      soundwire: amd: fix for wake interrupt handling for clockstop mode

Vikas Gupta (2):
      bnxt_en: refactor reset close code
      bnxt_en: Fix the PCI-AER routines

Vineet Gupta (2):
      ARC: Fix -Wmissing-prototypes warnings
      ARC: mm: fix new code about cache aliasing

Vinod Koul (1):
      dmaengine: Revert "dmaengine: pl330: issue_pending waits until WFP st=
ate"

Vishal Moola (Oracle) (1):
      hugetlb: check for anon_vma prior to folio allocation

WangYuli (1):
      Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853

Wedson Almeida Filho (2):
      rust: phy: implement `Send` for `Registration`
      rust: kernel: require `Send` for `Module` implementations

Wenkuan Wang (1):
      x86/CPU/AMD: Add models 0x10-0x1f to the Zen5 range

William Zhang (1):
      mtd: rawnand: brcmnand: Fix data access violation for STB chip

Wolfram Sang (1):
      i2c: smbus: fix NULL function pointer dereference

Xuewen Yan (1):
      sched/eevdf: Prevent vlag from going out of bounds in reweight_eevdf(=
)

Yaraslau Furman (1):
      HID: logitech-dj: allow mice to use all types of reports

Yick Xie (1):
      udp: preserve the connected status if only UDP cmsg

Yu Kuai (1):
      block: fix module reference leakage from bdev_open_by_dev error path

Zhang Lixu (1):
      HID: intel-ish-hid: ipc: Fix dev_err usage with uninitialized dev->de=
vc

Zhu Lingshan (1):
      vDPA: code clean for vhost_vdpa uapi

Zijun Hu (1):
      Bluetooth: btusb: Fix triggering coredump implementation for QCA

