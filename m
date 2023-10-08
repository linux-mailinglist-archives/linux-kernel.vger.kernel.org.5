Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7957BD02C
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjJHVDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjJHVDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:03:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164DCF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 14:03:37 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b9faf05f51so429640966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 14:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696799016; x=1697403816; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nLHAyWsvNFsofPS6w4tgX5T9Ja0sfgjIJ4YmgM9xIAk=;
        b=g0+Ld4GXrobO28zeSkX7P3DfyhkrEmCcVWMcKTjYsJoVdsEH9OCOD3uxLEnG1NS22u
         5iJdGtUYTvvTlOYyy6JLvr5Ep7y+GWflmNz6Mss7xVCPxbp53SrzjSIOWTPtLW/FUav5
         gzruQynFdbz6f6fKMUD2payRqbCx/ZHoXATLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696799016; x=1697403816;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLHAyWsvNFsofPS6w4tgX5T9Ja0sfgjIJ4YmgM9xIAk=;
        b=aETW7wXZCRHP7L2RzCcMZCPVrAvXa7/D/uul/ngUxRMy90JVI+wFlegfFbfs/P6im3
         Cr2/xPi0Jbj9JvZ6zMhACNHsFJCIR80e7DwYtAxmU5d78od/GBeaVhSWnS0Kw/eTFWGj
         yKduWKvAe4e6vyTAZOR1x3mZdvbW3FiYEkuak1kiD9J14+AeXF7+cx6UOhUINAbePz31
         tcW8LlWHPwBPmgDRzknDM24KHrbJEOShZxUazTPSsmbERnsISFf3Syb4Djzis8SrsZMz
         safiGreOy+I3FgdDQxHi8okGiAbZjB91gpOumDZmZCWKSeCfz/nxLtwgc8yszdPTC/Kh
         hzWw==
X-Gm-Message-State: AOJu0Yx9BEKhWk+nBqY1D5VSCRLu4PTWZ9zObxIr2mINiSCJ4PzHIm7Z
        DWFWRN/K5BcVIX0T1HmeyqxaxOn+UIl2YE+pdVgLfjhq
X-Google-Smtp-Source: AGHT+IFaGaw6WWGZy9LsDn7ZYNndlP/bJxAP9lBoswwKvFqwwGvo5YJtObwWLNU1QV9+2szRZ9SLXQ==
X-Received: by 2002:a17:906:259:b0:9ad:c763:c3fd with SMTP id 25-20020a170906025900b009adc763c3fdmr12537861ejl.28.1696799015549;
        Sun, 08 Oct 2023 14:03:35 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id dx12-20020a170906a84c00b009b977bea1dcsm5891082ejb.23.2023.10.08.14.03.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 14:03:35 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so6765678a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 14:03:34 -0700 (PDT)
X-Received: by 2002:aa7:cd56:0:b0:532:eb5f:c8e6 with SMTP id
 v22-20020aa7cd56000000b00532eb5fc8e6mr12117915edw.8.1696799014362; Sun, 08
 Oct 2023 14:03:34 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 Oct 2023 14:03:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh7awamHE3ujoxZFcGMg3wvLTk8UZYSm3m7vUDhpmP2+A@mail.gmail.com>
Message-ID: <CAHk-=wh7awamHE3ujoxZFcGMg3wvLTk8UZYSm3m7vUDhpmP2+A@mail.gmail.com>
Subject: Linux 6.6-rc5
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things are back to normal, and we have a networking pull this week.

And probably because of the missed week, networking shows up quite
clearly in the diffstat, although honestly, that's probably also
because everything else has been pretty quiet.

We've got other misc driver fixes, of course, and a few filesystem
fixes. But network drivers, core networking, and some network-related
selftests do account for probably about half of the patch this week.

Apart from that, nothing in here looks particularly odd,

           Linus

---

Aditya Kumar Singh (1):
      wifi: cfg80211: validate AP phy operation before starting it

Al Viro (2):
      ovl: move freeing ovl_entry past rcu delay
      ovl: fetch inode once in ovl_dentry_revalidate_common()

Alexandra Diupina (1):
      drivers/net: process the result of hdlc_open() and add call of
hdlc_close() in uhdlc_close()

Amir Goldstein (3):
      ovl: fix file reference leak when submitting aio
      ovl: make use of ->layers safe in rcu pathwalk
      ovl: fix NULL pointer defer when encoding non-decodable lower fid

Andrii Nakryiko (1):
      bpf: unconditionally reset backtrack_state masks on global func exit

Anna Schumaker (1):
      SUNRPC/TLS: Lock the lower_xprt during the tls handshake

Armin Wolf (2):
      platform/x86: think-lmi: Fix reference leak
      platform/x86: hp-bioscfg: Fix reference leak

Arnd Bergmann (3):
      wifi: iwlwifi: dbg_ini: fix structure packing
      ima: rework CONFIG_IMA dependency block
      media: pci: intel: ivsc: select V4L2_FWNODE

Artem Chernyshev (1):
      RDMA/cxgb4: Check skb value for failure to allocate

Arthur Grillo (1):
      drm/tests: Fix kunit_release_action ctx argument

Bart Van Assche (1):
      RDMA/srp: Do not call scsi_done() from srp_abort()

Bartosz Golaszewski (1):
      gpio: aspeed: fix the GPIO number passed to pinctrl_gpio_set_config()

Ben Greear (1):
      wifi: iwlwifi: Ensure ack flag is properly cleared.

Ben Wolsieffer (1):
      net: stmmac: dwmac-stm32: fix resume on STM32 MCU

Benjamin Berg (2):
      wifi: cfg80211: avoid leaking stack data into trace
      wifi: mac80211: Create resources for disabled links

Benjamin Poirier (1):
      ipv4: Set offload_failed flag in fibmatch results

Bernard Metzler (1):
      RDMA/siw: Fix connection failure handling

Chen-Yu Tsai (1):
      regulator: mt6358: split ops for buck and linear range LDO regulators

Cheng Xu (1):
      RDMA/erdma: Fix NULL pointer access in regmr_cmd

Chengfeng Ye (1):
      tipc: fix a potential deadlock on &tx->lock

Chris Wilson (1):
      drm/i915: Invalidate the TLBs on each GT

Christian Marangi (1):
      net: ethernet: mediatek: disable irq before schedule napi

Christoph Hellwig (1):
      nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl

Christophe JAILLET (6):
      HID: sony: Fix a potential memory leak in sony_probe()
      wifi: iwlwifi: mvm: Fix a memory corruption issue
      IB/mlx4: Fix the size of a buffer in add_port_entries()
      media: pxa_camera: Fix an error handling path in pxa_camera_probe()
      HID: nvidia-shield: Fix a missing led_classdev_unregister() in
the probe error handling path
      HID: nvidia-shield: Fix some missing function calls() in the
probe error handling path

Chuck Lever (1):
      SUNRPC: Fail quickly when server does not recognize TLS

Clark Wang (1):
      net: stmmac: platform: fix the incorrect parameter

Dan Carpenter (6):
      of: dynamic: Fix potential memory leak in of_changeset_action()
      RDMA/erdma: Fix error code in erdma_create_scatter_mtt()
      HID: steelseries: Fix signedness bug in
steelseries_headset_arctis_1_fetch_battery()
      net: ethernet: ti: am65-cpsw: Fix error code in
am65_cpsw_nuss_init_tx_chns()
      net: ti: icssg-prueth: Fix signedness bug in prueth_init_tx_chns()
      dmaengine: ti: k3-udma-glue: clean up k3_udma_glue_tx_get_irq() retur=
n

Daniel Borkmann (2):
      bpf, mprog: Fix maximum program check on mprog attachment
      selftest/bpf: Add various selftests for program limits

Daniel Bristot de Oliveira (4):
      rtla/timerlat_aa: Zero thread sum after every sample analysis
      rtla/timerlat_aa: Fix negative IRQ delay
      rtla/timerlat_aa: Fix previous IRQ delay for IRQs that happens
after thread sample
      rtla/timerlat: Do not stop user-space if a cpu is offline

Danilo Krummrich (3):
      drm/nouveau: chan: use struct nvif_mclass
      drm/nouveau: chan: use channel class definitions
      drm/nouveau: exec: report max pushs through getparam

Dave Chinner (3):
      xfs: move log discard work to xfs_discard.c
      xfs: reduce AGF hold times during fstrim operations
      xfs: abort fstrim if kernel is suspending

David Howells (1):
      ipv4, ipv6: Fix handling of transhdrlen in __ip{,6}_append_data()

David Jeffery (1):
      md/raid5: release batch_last before waiting for another stripe_head

David Wilder (1):
      ibmveth: Remove condition to recompute TCP header checksum.

Dinghao Liu (2):
      scsi: zfcp: Fix a double put in zfcp_port_enqueue()
      ptp: ocp: Fix error handling in ptp_ocp_device_init

Duje Mihanovi=C4=87 (1):
      gpio: pxa: disable pinctrl calls for MMP_GPIO

Eric Dumazet (3):
      net: fix possible store tearing in neigh_periodic_work()
      neighbour: fix data-races around n->output
      netlink: annotate data-races around sk->sk_err

Fabian Vogt (1):
      HID: Add quirk to ignore the touchscreen battery on HP ENVY 15-eu0556=
ng

Fabio Estevam (3):
      net: dsa: mv88e6xxx: Avoid EEPROM timeout when EEPROM is absent
      dt-bindings: display: fsl,imx6-hdmi: Change to
'unevaluatedProperties: false'
      media: dt-bindings: imx7-csi: Make power-domains not required for imx=
8mq

Fedor Pchelkin (1):
      dm zoned: free dmz->ddev array in dmz_put_zoned_devices

Felix Fietkau (2):
      wifi: mac80211: fix mesh id corruption on 32 bit systems
      wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

Filipe Manana (4):
      btrfs: always print transaction aborted messages with an error level
      btrfs: error out when COWing block using a stale transaction
      btrfs: error when COWing block from a root that is being deleted
      btrfs: error out when reallocating block for defrag using a
stale transaction

Florian Westphal (2):
      netfilter: nft_payload: rebuild vlan header on h_proto access
      netfilter: nf_tables: nft_set_rbtree: fix spurious insertion failure

Gao Xiang (1):
      erofs: fix memory leak of LZMA global compressed deduplication

Geert Uytterhoeven (3):
      of: overlay: Reorder struct fragment fields kerneldoc
      dt-bindings: cache: andestech,ax45mp-cache: Fix unit address in examp=
le
      dt-bindings: media: renesas,vin: Fix field-even-active spelling

Geliang Tang (1):
      mptcp: userspace pm allow creating id 0 subflow

Gregory Greenman (1):
      iwlwifi: mvm: handle PS changes in vif_cfg_changed

Gustavo A. R. Silva (4):
      wifi: mwifiex: Fix tlv_buf_left calculation
      wifi: mwifiex: Replace one-element array with flexible-array
member in struct mwifiex_ie_types_rxba_sync
      wifi: mwifiex: Sanity check tlv_len and tlv_bitmap_len
      qed/red_ll2: Fix undefined behavior bug in struct qed_ll2_info

Haiyang Zhang (3):
      net: mana: Fix TX CQE error handling
      net: mana: Fix the tso_bytes calculation
      net: mana: Fix oversized sge0 for GSO packets

Hamdan Igbaria (1):
      RDMA/mlx5: Fix mutex unlocking on error flow for steering anchor crea=
tion

Hangbin Liu (1):
      ipv4/fib: send notify when delete source address routes

Hans de Goede (1):
      HID: logitech-hidpp: Add Bluetooth ID for the Logitech M720
Triathlon mouse

Hector Martin (1):
      iommu/apple-dart: Handle DMA_FQ domains in attach_dev()

Helge Deller (1):
      parisc: Fix crash with nr_cpus=3D1 option

Hou Tao (1):
      bpf: Use kmalloc_size_roundup() to adjust size_index

Ilan Peer (2):
      wifi: cfg80211: Fix 6GHz scan configuration
      wifi: iwlwifi: mvm: Fix incorrect usage of scan API

Ilya Maximets (1):
      ipv6: tcp: add a missing nf_reset_ct() in 3WHS handling

Irui Wang (1):
      media: mediatek: vcodec: Fix encoder access NULL pointer

Jakub Sitnicki (1):
      bpf, sockmap: Reject sk_msg egress redirects to non-TCP sockets

Jeff Johnson (1):
      MAINTAINERS: wifi: ath12k: add wiki link

Jeff Layton (1):
      nfs: decrement nrequests counter before releasing the req

Jeff Moyer (1):
      io-wq: fully initialize wqe before calling
cpuhp_state_add_instance_nocalls()

Jens Axboe (3):
      io_uring/kbuf: don't allow registered buffer rings on highmem pages
      io_uring: ensure io_lockdep_assert_cq_locked() handles disabled rings
      io_uring: don't allow IORING_SETUP_NO_MMAP rings on highmem pages

Jeremy Cline (1):
      net: nfc: llcp: Add lock when modifying device list

Jing Zhang (1):
      perf/arm-cmn: Fix the unhandled overflow status of counter 4 to 7

Jingbo Xu (2):
      erofs: allow empty device tags in flatdev mode
      erofs: update documentation

Jiri Kosina (1):
      HID: sony: remove duplicate NULL check before calling usb_free_urb()

Jithu Joseph (1):
      platform/x86/intel/ifs: release cpus_read_lock()

Johannes Berg (6):
      wifi: cfg80211: fix cqm_config access race
      wifi: cfg80211: add missing kernel-doc for cqm_rssi_work
      rfkill: sync before userspace visibility/changes
      wifi: mac80211: fix potential key use-after-free
      wifi: mac80211: fix potential key leak
      wifi: mac80211: work around Cisco AP 9115 VHT MPDU length

John David Anglin (1):
      parisc: Restore __ldcw_align for PA-RISC 2.0 processors

John Fastabend (3):
      bpf: tcp_read_skb needs to pop skb regardless of seq
      bpf, sockmap: Do not inc copied_seq when PEEK flag set
      bpf, sockmap: Add tests for MSG_F_PEEK

Jordan Rife (4):
      net: replace calls to sock->ops->connect() with kernel_connect()
      net: prevent rewrite of msg_name in sock_sendmsg()
      net: prevent address rewrite in kernel_bind()
      smb: use kernel_connect() and kernel_bind()

Josef Bacik (1):
      btrfs: fix some -Wmaybe-uninitialized warnings in ioctl.c

Juerg Haefliger (1):
      wifi: brcmfmac: Replace 1-element arrays with flexible arrays

Juntong Deng (1):
      selftests: Fix wrong TARGET in kselftest top level Makefile

Junxiao Bi (1):
      scsi: target: core: Fix deadlock due to recursive locking

Kai Uwe Broulik (1):
      drm: panel-orientation-quirks: Add quirk for One Mix 2S

Kalle Valo (5):
      MAINTAINERS: wifi: remove generic wiki links from drivers
      MAINTAINERS: wifi: rtlwifi: remove git tree
      MAINTAINERS: wifi: rtl8xxxu: remove git tree
      MAINTAINERS: wifi: wl12xx: remove git tree
      MAINTAINERS: wifi: hostap: remove maintainer and web page

Karan Tilak Kumar (1):
      scsi: fnic: Fix sg_reset success path

Kees Cook (1):
      sky2: Make sure there is at least one frag_addr available

Kenneth Feng (1):
      drm/amd/pm: add unique_id for gc 11.0.3

Konrad Dybcio (1):
      dt-bindings: arm-smmu: Fix SDM630 clocks description

Konstantin Meskhidze (1):
      RDMA/uverbs: Fix typo of sizeof argument

Krzysztof Kozlowski (1):
      dt-bindings: mfd: Revert "dt-bindings: mfd: maxim,max77693: Add
USB connector"

Leon Hwang (1):
      bpf: Fix tr dereferencing

Leon Romanovsky (3):
      RDMA/cma: Fix truncation compilation warning in make_cma_ports
      RDMA/mlx5: Remove not-used cache disable flag
      RDMA/core: Require admin capabilities to set system parameters

Linus Torvalds (1):
      Linux 6.6-rc5

Lizhi Hou (2):
      PCI: of_property: Handle interrupt parsing failures
      PCI: of: Destroy changeset when adding PCI device node fails

Lorenzo Bianconi (1):
      wifi: mt76: fix lock dependency problem for wed_lock

Luben Tuikov (1):
      drm/amdgpu: Fix a memory leak

Luca Ceresoli (2):
      staging: media: tegra-video: fix infinite recursion regression
      dt-bindings: trivial-devices: Fix MEMSIC MXC4005 compatible string

Luiz Augusto von Dentz (4):
      Bluetooth: hci_sync: Fix handling of HCI_QUIRK_STRICT_DUPLICATE_FILTE=
R
      Bluetooth: ISO: Fix handling of listen for unicast
      Bluetooth: hci_core: Fix build warnings
      Bluetooth: hci_codec: Fix leaking content of local_codecs

Ma Ke (1):
      HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event

Marek Beh=C3=BAn (1):
      leds: Drop BUG_ON check for LED_COLOR_ID_MULTI

Mario Limonciello (2):
      drm/amd: Fix logic error in sienna_cichlid_update_pcie_parameters()
      drm/amd: Fix detection of _PR3 on the PCIe root port

Mark Zhang (1):
      RDMA/cma: Initialize ib_sa_multicast structure to 0 when join

Martino Fontana (1):
      HID: nintendo: reinitialize USB Pro Controller after resuming from su=
spend

Mathias Krause (1):
      drm/i915: Register engines early to avoid type confusion

Matthieu Baerts (1):
      MAINTAINERS: update Matthieu's email address

Michael Guralnik (1):
      RDMA/mlx5: Fix assigning access flags to cache mkeys

Michal Schmidt (1):
      ice: always add legacy 32byte RXDID in supported_rxdids

Micha=C5=82 Miros=C5=82aw (2):
      regulator/core: regulator_register: set device->class earlier
      regulator/core: Revert "fix kobject release warning and memory
leak in regulator_register()"

Mika Westerberg (1):
      PCI/PM: Mark devices disconnected if upstream PCIe link is down on re=
sume

Mike Snitzer (1):
      MAINTAINERS: update the dm-devel mailing list

Namjae Jeon (5):
      ksmbd: fix race condition between session lookup and expire
      ksmbd: fix race condition with fp
      ksmbd: fix race condition from parallel smb2 logoff requests
      ksmbd: fix race condition from parallel smb2 lock requests
      ksmbd: fix race condition between tree conn lookup and disconnect

Neal Cardwell (2):
      tcp: fix quick-ack counting to count actual ACKs of new data
      tcp: fix delayed ACKs for MSS boundary condition

Nicolin Chen (1):
      iommu/arm-smmu-v3: Fix soft lockup triggered by
arm_smmu_mm_invalidate_range

Nirmoy Das (1):
      drm/i915: Don't set PIPE_CONTROL_FLUSH_L3 for aux inval

Oleksandr Tymoshenko (1):
      ima: Finish deprecation of IMA_TRUSTED_KEYRING Kconfig

Oza Pawandeep (1):
      cpuidle, ACPI: Evaluate LPI arch_flags for broadcast timer

Paolo Abeni (1):
      mptcp: fix delegated action races

Parthiban Veerasooran (1):
      ethtool: plca: fix plca enable data type while parsing the value

Paulo Alcantara (1):
      smb: client: do not start laundromat thread on nohandlecache

Pavankumar Kondeti (1):
      PM: hibernate: Fix copying the zero bitmap to safe pages

Peter Zijlstra (2):
      sched/eevdf: Also update slice on placement
      sched/eevdf: Fix avg_vruntime()

Phil Sutter (2):
      selftests: netfilter: Extend nft_audit.sh
      netfilter: nf_tables: Deduplicate nft_register_obj audit logs

Pin-yen Lin (1):
      wifi: mwifiex: Fix oob check condition in mwifiex_process_rx_packet

Qu Wenruo (1):
      btrfs: reject unknown mount options early

Rahul Rameshbabu (2):
      HID: nvidia-shield: Select POWER_SUPPLY Kconfig option
      HID: multitouch: Add required quirk for Synaptics 0xcd7e device

Randy Dunlap (4):
      HID: nvidia-shield: add LEDS_CLASS dependency
      platform/mellanox: tmfifo: fix kernel-doc warnings
      page_pool: fix documentation typos
      net: lan743x: also select PHYLIB

Remi Pommarel (1):
      net: stmmac: remove unneeded stmmac_poll_controller

Renan Guilherme Lebre Ramos (1):
      platform/x86: touchscreen_dmi: Add info for the Positivo C4128B

Richard Fitzgerald (1):
      regmap: rbtree: Fix wrong register marked as in-cache when
creating new node

Rob Herring (8):
      dt-bindings: riscv: cpus: Add missing additionalProperties on
interrupt-controller node
      arm64: Add Cortex-A520 CPU part definition
      arm64: errata: Add Cortex-A520 speculative unprivileged load workarou=
nd
      dt-bindings: bus: fsl,imx8qxp-pixel-link-msi-bus: Drop child
'reg' property
      media: dt-bindings: Add missing unevaluatedProperties on child
node schemas
      dt-bindings: PCI: brcm,iproc-pcie: Fix example indentation
      dt-bindings: PCI: brcm,iproc-pcie: Drop common pci-bus properties
      dt-bindings: PCI: brcm,iproc-pcie: Fix 'msi' child node schema

Robin Murphy (1):
      iommu/arm-smmu-v3: Avoid constructing invalid range commands

Rocky Liao (1):
      Bluetooth: btusb: add shutdown function for QCA6174

Sakari Ailus (1):
      media: ipu-bridge: Fix Kconfig dependencies

Samson Tam (1):
      drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to
master OTG pipes only

Sascha Hauer (1):
      wifi: rtw88: rtw8723d: Fix MAC address offset in EEPROM

Selvin Xavier (2):
      RDMA/bnxt_re: Fix the handling of control path response data
      RDMA/bnxt_re: Decrement resource stats correctly

Shay Drory (2):
      RDMA/mlx5: Fix NULL string error
      RDMA/mlx5: Fix mkey cache possible deadlock on cleanup

Shigeru Yoshida (1):
      net: usb: smsc75xx: Fix uninit-value access in __smsc75xx_read_reg

Song Liu (2):
      s390/bpf: Let arch_prepare_bpf_trampoline return program size
      selftests/bpf: Check bpf_cubic_acked() is called via struct_ops

Sricharan Ramabadhran (1):
      PCI: qcom: Fix IPQ8074 enumeration

Srinivas Pandruvada (1):
      HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

Stefano Garzarella (1):
      vringh: don't use vringh_kiov_advance() in vringh_iov_xfer()

Tom Lendacky (2):
      x86/sev: Use the GHCB protocol when available for SNP CPUID requests
      x86/sev: Change npages to unsigned long in snp_accept_memory()

Tomasz Swiatek (1):
      platform/x86: touchscreen_dmi: Add info for the BUSH Bush Windows tab=
let

Trond Myklebust (3):
      NFSv4: Fix a nfs4_state_manager() race
      NFSv4: Fix a state manager thread deadlock regression
      Revert "SUNRPC dont update timeout value on connection reset"

Uwe Kleine-K=C3=B6nig (1):
      platform/x86: hp-wmi:: Mark driver struct with __refdata to
prevent section mismatch warning

Wen Gong (2):
      wifi: cfg80211/mac80211: hold link BSSes when assoc fails for
MLO connection
      wifi: mac80211: allow transmitting EAPOL frames with tainted key

Woody Zhang (1):
      mfd: cs42l43: Fix MFD_CS42L43 dependency on REGMAP_IRQ

Xie XiuQi (1):
      rtla: fix a example in rtla-timerlat-hist.rst

Xin Long (4):
      netfilter: handle the connecting collision properly in
nf_conntrack_proto_sctp
      selftests: netfilter: test for sctp collision processing in nf_conntr=
ack
      sctp: update transport state when processing a dupcook packet
      sctp: update hb timer immediately after users change hb_interval

Xuewen Yan (1):
      cpufreq: schedutil: Update next_freq when cpufreq_limits change

Yao Xiao (1):
      Bluetooth: Delete unused hci_req_prepare_suspend() declaration

Ying Hsu (2):
      Bluetooth: Fix hci_link_tx_to RCU lock usage
      Bluetooth: Avoid redundant authentication

Yong Wu (1):
      iommu/mediatek: Fix share pgtable for iova over 4GB

Yoshihiro Shimoda (1):
      rswitch: Fix PHY station management clock setting

Yu Liao (1):
      ACPI: NFIT: Fix incorrect calculation of idt size

Zhang Rui (1):
      iommu/vt-d: Avoid memory allocation in iommu_suspend()

Zhihao Cheng (1):
      ubi: Refuse attaching if mtd's erasesize is 0

luosili (1):
      ksmbd: fix uaf in smb20_oplock_break_ack
