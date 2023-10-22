Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697107D269B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 00:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjJVW17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Oct 2023 18:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Oct 2023 18:27:58 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B2F99
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 15:27:54 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5079eed8bfbso3735262e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 15:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698013672; x=1698618472; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RPfAf9R5boaXIuepKuC8xCaFGFIytIZgiQterSnErMw=;
        b=fl6nbVRd3/iOC+pO9Kluz4aW9dQSur57ZiSYh2SPdJ48wlmfUOHRHYe6YVE1MDaaMu
         MxICEQO74k0nH1gf3N+flbmDF3Rq5eybeP/oN8bWhg2B47pUYItXdeunxkiXSDWx93mg
         TsIY4G9cOxWNjv1N332gKzAiEI3T3AEIDClcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698013672; x=1698618472;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RPfAf9R5boaXIuepKuC8xCaFGFIytIZgiQterSnErMw=;
        b=CPKXvFYDHW+Ii6mMbboC4FAVmOAkyspC4BsW+Rpkepzf3a85CgkCuCv6RjLjp9cr4R
         uPghOYtx+xKSt3c489WqNt3e+or95FgU3ObqTkc1wQ7+0eVWJEBtfaNWcCtJUci4b2rc
         KS8dM1GePCQFkY/TUpEMhFEw7x2z+qBUQDJUnAA6hAOC9XrrhsjMDDPyrsUDxQuaBt8v
         oJKttsqHEE9tE7UCJ77UhX2vjgxpYN2yLAhexiUVwjkukc3kzPZZbfXE2YCrKze3WtMV
         3IhbjHOTU4J/uNFV+bMNB0Q1c7wJg4ef6zH4VZ0EXQf1/VDG7Jr3MeT1IfohfVa9z4Ar
         wYeQ==
X-Gm-Message-State: AOJu0YyWkx1odxP1WMHE1vmg22w3loVEPWbHhyLj0XM4bZfqp1H+c/9c
        FEi21Gw1muKsYBC+LYedp3tz7Y94M3O9b0RlOzZnsA==
X-Google-Smtp-Source: AGHT+IGjFHyh/AckwqdNrkOOK6FX79THvRCmbox8lcuyViWE7/nF5FXeD0z+OPuryHjBI2LcIz6pbA==
X-Received: by 2002:a19:7015:0:b0:503:7be:c85d with SMTP id h21-20020a197015000000b0050307bec85dmr4953990lfc.35.1698013672059;
        Sun, 22 Oct 2023 15:27:52 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id k6-20020ac24f06000000b005030b642ec8sm1412516lfr.157.2023.10.22.15.27.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Oct 2023 15:27:51 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so39945601fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 22 Oct 2023 15:27:51 -0700 (PDT)
X-Received: by 2002:a2e:81d6:0:b0:2c5:1553:9129 with SMTP id
 s22-20020a2e81d6000000b002c515539129mr5704440ljg.35.1698013670736; Sun, 22
 Oct 2023 15:27:50 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 22 Oct 2023 12:27:33 -1000
X-Gmail-Original-Message-ID: <CAHk-=whqsbGgnoeYeEuP9fabaZrpPDA=SySMBe3TfQQqVMHvBA@mail.gmail.com>
Message-ID: <CAHk-=whqsbGgnoeYeEuP9fabaZrpPDA=SySMBe3TfQQqVMHvBA@mail.gmail.com>
Subject: Linux 6.6-rc7
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Things continue to look fairly normal, and there's nothing
particularly alarming here.

The _one_ thing I react to is that this rc7 is a bit larger than I'd
like it to be. It is certainly on the bigger side of our rc7 releases
in the 6,.x series. The only 6.x with a bigger rc7 (in number of
commits) was 6.1 - and that one ended up having an rc8 too...

Anyway, while this is all bigger than I'd have liked it to be, if the
upcoming week is quiet and normal, this is the last rc and next Sunday
will see the final release and then we'll open the merge window for
6.7.  I simply am not aware of any issues that would be showstoppers.

We'll see. Please do go give this a good testing, and holler if there
are any concerns. Another release candidate is always an option if
some last-minute thing comes up,

                   Linus


---

Aaron Conole (4):
      selftests: openvswitch: Add version check for pyroute2
      selftests: openvswitch: Catch cases where the tests are killed
      selftests: openvswitch: Skip drop testing on older kernels
      selftests: openvswitch: Fix the ct_tuple for v4

Adrian Hunter (2):
      perf dlfilter: Fix use of addr_location__exit() in dlfilter__object_c=
ode()
      perf dlfilter: Add a test for object_code()

Adrien Thierry (2):
      phy: qcom-qmp-usb: initialize PCS_USB registers
      phy: qcom-qmp-usb: split PCS_USB init table for sc8280xp and sa8775p

Albert Huang (1):
      net/smc: fix smc clc failed issue when netdevice not in init_net

Amir Goldstein (1):
      fanotify: limit reporting of event with non-decodeable file handles

Amir Tzin (1):
      net/mlx5e: Fix VF representors reporting zero counters to "ip -s" com=
mand

Andrea Righi (1):
      rust: fix bindgen build error with fstrict-flex-arrays

Andy Shevchenko (2):
      Revert "pinctrl: avoid unsafe code pattern in find_pinctrl()"
      gpiolib: acpi: Add missing memset(0) to acpi_get_gpiod_from_data()

Anshuman Khandual (1):
      KVM: arm64: pmu: Drop redundant check for non-NULL kvm_pmu_events

Ard Biesheuvel (1):
      x86/boot: efistub: Assign global boot_params variable

Arkadiusz Bokowy (1):
      Bluetooth: vhci: Fix race when opening vhci device

Armin Wolf (2):
      platform/x86: wmi: Update MAINTAINERS entry
      platform/surface: platform_profile: Propagate error if profile
registration fails

Arnaldo Carvalho de Melo (1):
      tools build: Fix llvm feature detection, still used by bpftool

Arnd Bergmann (3):
      fbdev: atyfb: only use ioremap_uc() on i386 and ia64
      Bluetooth: avoid memcmp() out of bounds warning
      fbdev: sa1100fb: mark sa1100fb_init() static

Artem Borisov (1):
      ALSA: hda/realtek: Add quirk for ASUS ROG GU603ZV

Avri Altman (1):
      mmc: core: Capture correct oemid-bits for eMMC cards

Bagas Sanjaya (1):
      Revert "net: wwan: iosm: enable runtime pm support for 7560"

Beau Belgrave (1):
      selftests/user_events: Fix abi_test for BE archs

Beno=C3=AEt Monin (1):
      USB: serial: option: add entry for Sierra EM9191 with new firmware

Bibek Kumar Patro (1):
      mtd: rawnand: qcom: Unmap the right resource upon probe failure

Bo Liu (1):
      phy: qualcomm: Fix typos in comments

Borislav Petkov (AMD) (1):
      x86/sev: Disable MMIO emulation from user mode

Catalin Marinas (1):
      mm: slab: Do not create kmalloc caches smaller than arch_slab_minalig=
n()

Charles Keepax (2):
      ASoC: dt-bindings: cirrus,cs42l43: Update values for bias sense
      ASoC: cs42l43: Update values for bias sense

Chen-Yu Tsai (1):
      drm/mediatek: Correctly free sg_table in gem prime vmap

Christoph Paasch (1):
      netlink: Correct offload_xstats size

Dai Ngo (1):
      nfs42: client needs to strip file mode's suid/sgid bit after ALLOCATE=
 op

Dan Carpenter (4):
      mmc: sdhci-sprd: Fix error code in sdhci_sprd_tuning()
      ASoC: pxa: fix a memory leak in probe()
      fbdev: omapfb: fix some error codes
      net: usb: smsc95xx: Fix an error code in smsc95xx_reset()

Dan Clash (1):
      audit,io_uring: io_uring openat triggers audit reference count underf=
low

David Rau (1):
      ASoC: da7219: Correct the process of setting up Gnd switch in AAD

Dinghao Liu (1):
      s390/cio: fix a memleak in css_alloc_subchannel

Dmitry Baryshkov (1):
      dt-bindings: phy: qcom,ipq8074-qmp-pcie: fix warning regarding reg si=
ze

Dong Chenchen (1):
      net: xfrm: skip policies marked as dead while reinserting policies

Douglas Anderson (1):
      drm/panel: Move AUX B116XW03 out of panel-edp back to panel-simple

Dragos Tatulea (3):
      net/mlx5e: RX, Fix page_pool allocation failure recovery for striding=
 rq
      net/mlx5e: RX, Fix page_pool allocation failure recovery for legacy r=
q
      net/mlx5e: XDP, Fix XDP_REDIRECT mpwqe page fragment leaks on shutdow=
n

Dust Li (1):
      net/smc: return the right falback reason when prefix checks fail

Edward AD (1):
      Bluetooth: hci_sock: fix slab oob read in create_monitor_event

Eric Dumazet (6):
      xfrm: interface: use DEV_STATS_INC()
      xfrm: fix a data-race in xfrm_gen_index()
      xfrm: fix a data-race in xfrm_lookup_with_ifid()
      tun: prevent negative ifindex
      tcp: tsq: relax tcp_small_queue_check() when rtx queue contains
a single skb
      ipv4: fib: annotate races around nh->nh_saddr_genid and nh->nh_saddr

Fabio Porcedda (1):
      USB: serial: option: add Telit LE910C4-WWX 0x1035 composition

Felix Kuehling (2):
      drm/amdgpu: Fix possible null pointer dereference
      drm/amdgpu: Reserve fences for VM update

Florian Fainelli (1):
      net: phy: bcm7xxx: Add missing 16nm EPHY statistics

Florian Westphal (2):
      netfilter: nfnetlink_log: silence bogus compiler warning
      netfilter: nft_payload: fix wrong mac header matching

Francis Laniel (2):
      tracing/kprobes: Return EADDRNOTAVAIL when func matches several symbo=
ls
      selftests/ftrace: Add new test case which checks non unique symbol

Gabriel Marcano (1):
      fs/ntfs3: Fix directory element type detection

Gavrilov Ilia (1):
      net: pktgen: Fix interface flags printing

Geert Uytterhoeven (3):
      mtd: physmap-core: Restore map_rom fallback
      phy: realtek: Realtek PHYs should depend on ARCH_REALTEK
      neighbor: tracing: Move pin6 inside CONFIG_IPV6=3Dy section

Geliang Tang (1):
      mptcp: avoid sending RST when closing the initial subflow

Gil Fine (1):
      thunderbolt: Call tb_switch_put() once DisplayPort bandwidth
request is finished

Haibo Chen (3):
      mmc: core: sdio: hold retuning if sdio in 1-bit mode
      gpio: vf610: mask the gpio irq in system suspend and support wakeup
      gpio: vf610: set value before the direction to avoid a glitch

Hamza Mahfooz (1):
      drm/edid: add 8 bpc quirk to the BenQ GW2765

Hanjun Guo (1):
      ACPI: bus: Move acpi_arm_init() to the place of after acpi_ghes_init(=
)

Hans de Goede (3):
      platform/x86: asus-wmi: Change ASUS_WMI_BRN_DOWN code from 0x20 to 0x=
2e
      platform/x86: asus-wmi: Only map brightness codes when using
asus-wmi backlight control
      platform/x86: asus-wmi: Map 0x2a code, Ignore 0x2b and 0x2c events

Herbert Xu (1):
      KEYS: asymmetric: Fix sign/verify on pkcs1pad without a hash

Huacai Chen (2):
      LoongArch: Export symbol invalid_pud_table for modules building
      LoongArch: Replace kmap_atomic() with kmap_local_page() in
copy_user_highpage()

Icenowy Zheng (1):
      LoongArch: Disable WUC for pgprot_writecombine() like ioremap_wc()

Ido Schimmel (2):
      selftests: fib_tests: Disable RP filter in multipath list receive tes=
t
      selftests: fib_tests: Count all trace point invocations

Iulia Tanasescu (1):
      Bluetooth: ISO: Fix invalid context error

Jacek Lawrynowicz (1):
      accel/ivpu: Don't enter d0i3 during FLR

Jakub Kicinski (5):
      net: fix ifname in netlink ntf during netns move
      net: check for altname conflicts when changing netdev's netns
      net: avoid UAF on deleted altname
      net: move altnames together with the netdevice
      selftests: net: add very basic test for netdev names and namespaces

Jan Stancek (1):
      iomap: fix short copy in iomap_write_iter()

Jens Axboe (1):
      io_uring: fix crash with IORING_SETUP_NO_MMAP and invalid SQ ring add=
ress

Jesse Brandeburg (2):
      ice: fix over-shifted variable
      ice: reset first in crash dump kernels

Jianbo Liu (1):
      net/mlx5e: Don't offload internal port if filter device is out device

Jim Mattson (2):
      KVM: x86: Mask LVTPC when handling a PMI
      KVM: x86/pmu: Synthesize at most one PMI per VM-exit

Jinjie Ruan (2):
      phy: realtek: usb: Drop unnecessary error check for debugfs_create_di=
r()
      net: dsa: bcm_sf2: Fix possible memory leak in bcm_sf2_mdio_register(=
)

Jiri Pirko (1):
      netlink: specs: devlink: fix reply command values

Jiri Slaby (SUSE) (1):
      perf/benchmark: fix seccomp_unotify benchmark for 32-bit

Jiri Wiesner (1):
      bonding: Return pointer to data after pull on skb

Joerg Roedel (2):
      x86/sev: Check IOBM for IOIO exceptions from user-space
      x86/sev: Check for user-space IOIO pointing to kernel space

Joey Gouly (2):
      KVM: arm64: Add nPIR{E0}_EL1 to HFG traps
      KVM: arm64: POR{E0}_EL1 do not need trap handlers

Johan Hovold (8):
      ASoC: codecs: wcd938x: drop bogus bind error handling
      ASoC: codecs: wcd938x: fix unbind tear down order
      ASoC: codecs: wcd938x: fix resource leaks on bind errors
      ASoC: codecs: wcd938x: fix regulator leaks on probe errors
      ASoC: codecs: wcd938x: fix runtime PM imbalance on remove
      ASoC: codecs: wcd938x-sdw: fix use after free on driver unbind
      ASoC: codecs: wcd938x-sdw: fix runtime PM imbalance on probe errors
      regmap: fix NULL deref on lookup

Johannes Berg (3):
      wifi: cfg80211: use system_unbound_wq for wiphy work
      wifi: mac80211: fix error path key leak
      net: rfkill: reduce data->mtx scope in rfkill_fop_open

Jorge Maidana (2):
      fbdev: uvesafb: Remove uvesafb_exec() prototype from
include/video/uvesafb.h
      fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()

Josua Mayer (1):
      net: rfkill: gpio: prevent value glitch during probe

Kailang Yang (1):
      ALSA: hda/realtek - Fixed ASUS platform headset Mic issue

Karol Herbst (1):
      drm/nouveau/disp: fix DP capable DSM connectors

Karolina Stolarek (1):
      drm/ttm: Reorder sys manager cleanup step

Kees Cook (4):
      fbdev: mmp: Annotate struct mmphw_ctrl with __counted_by
      fbdev: mmp: Annotate struct mmp_path with __counted_by
      netfilter: nf_tables: Annotate struct nft_pipapo_match with __counted=
_by
      Bluetooth: hci_sock: Correctly bounds check and pad HCI_MON_NEW_INDEX=
 name

Keith Busch (2):
      nvme: sanitize metadata bounce buffer for reads
      nvme-pci: add BOGUS_NID for Intel 0a54 device

Khaled Almahallawy (1):
      drm/i915/cx0: Only clear/set the Pipe Reset bit of the PHY Lanes Owne=
d

Kirill A. Shutemov (1):
      efi/unaccepted: Fix soft lockups caused by parallel memory acceptance

Konrad Dybcio (2):
      phy: qcom-qmp-combo: Square out 8550 POWER_STATE_CONFIG1
      phy: qcom-qmp-combo: initialize PCS_USB registers

Konstantin Komarov (14):
      fs/ntfs3: Add ckeck in ni_update_parent()
      fs/ntfs3: Write immediately updated ntfs state
      fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)
      fs/ntfs3: Add more attributes checks in mi_enum_attr()
      fs/ntfs3: fix deadlock in mark_as_free_ex
      fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super
      fs/ntfs3: Use inode_set_ctime_to_ts instead of inode_set_ctime
      fs/ntfs3: Allow repeated call to ntfs3_put_sbi
      fs/ntfs3: Fix alternative boot searching
      fs/ntfs3: Refactoring and comments
      fs/ntfs3: Add more info into /proc/fs/ntfs3/<dev>/volinfo
      fs/ntfs3: Do not allow to change label if volume is read-only
      fs/ntfs3: Fix possible NULL-ptr-deref in ni_readpage_cmpr()
      fs/ntfs3: Fix NULL pointer dereference on error in attr_allocate_fram=
e()

Kory Maincent (1):
      Revert "ethtool: Fix mod state of verbose no_mask bitset"

Krzysztof Kozlowski (5):
      dt-bindings: mmc: sdhci-msm: correct minimum number of clocks
      ASoC: soc-dapm: Add helper for comparing widget name
      ASoC: codecs: wsa-macro: handle component name prefix
      pinctrl: qcom: lpass-lpi: fix concurrent register updates
      nfc: nci: fix possible NULL pointer dereference in send_acknowledge()

Kuan-Wei Chiu (1):
      efi: fix memory leak in krealloc failure handling

Kuniyuki Iwashima (1):
      tcp: Fix listen() warning with v4-mapped-v6 address.

Lama Kayal (1):
      net/mlx5e: Take RTNL lock before triggering netdev notifiers

Lee, Chun-Yi (2):
      Bluetooth: hci_event: Ignore NULL link key
      Bluetooth: Reject connection with the device which has same BD_ADDR

Like Xu (1):
      KVM: selftests: Remove obsolete and incorrect test case metadata

Liming Sun (1):
      platform/mellanox: mlxbf-tmfifo: Fix a warning message

Linus Torvalds (1):
      Linux 6.6-rc7

Luben Tuikov (2):
      drm/amdgpu: Unset context priority is now invalid
      gpu/drm: Eliminate DRM_SCHED_PRIORITY_UNSET

Luiz Augusto von Dentz (2):
      Bluetooth: hci_event: Fix using memcmp when comparing keys
      Bluetooth: hci_event: Fix coding style

Luka Guzenko (1):
      ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq5xxx

MD Danish Anwar (3):
      net: ti: icssg-prueth: Fix tx_total_bytes count
      net: ethernet: ti: Fix mixed module-builtin object
      net: ti: icssg-prueth: Fix r30 CMDs bitmasks

Ma Ke (2):
      net: ipv6: fix return value check in esp_remove_trailer
      net: ipv4: fix return value check in esp_remove_trailer

Maher Sanalla (1):
      net/mlx5: Handle fw tracer change ownership event based on MTRC

Manish Chopra (1):
      qed: fix LL2 RX buffer allocation

Manmohan Shukla (1):
      rust: error: Markdown style nit

Marc Zyngier (1):
      KVM: arm64: timers: Correctly handle TGE flip with CNTPOFF_EL2

Mark Brown (1):
      ASoC: dwc: Fix non-DT instantiation

Martin Kurbanov (1):
      mtd: spinand: micron: correct bitmask for ecc status

Martin Wilck (1):
      nvme-auth: use chap->s2 to indicate bidirectional authentication

Masami Hiramatsu (Google) (2):
      Documentation: probes: Add a new ret_ip callback parameter
      fprobe: Fix to ensure the number of active retprobes is not zero

Mateusz Pacuszka (1):
      ice: Fix safe mode when DDP is missing

Mateusz Polchlopek (1):
      docs: fix info about representor identification

Matthieu Baerts (2):
      selftests: mptcp: join: correctly check for no RST
      selftests: mptcp: join: no RST when rm subflow/addr

Maurizio Lombardi (2):
      nvme-rdma: do not try to stop unallocated queues
      nvmet-auth: complete a request only after freeing the dhchap pointers

Max Chou (1):
      Bluetooth: btrtl: Ignore error return for hci_devcd_register()

Maxim Levitsky (3):
      x86: KVM: SVM: always update the x2avic msr interception
      x86: KVM: SVM: add support for Invalid IPI Vector interception
      x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()

Michael Ellerman (2):
      powerpc/mm: Allow ARCH_FORCE_MAX_ORDER up to 12
      powerpc/64s/radix: Don't warn on copros in radix__tlb_flush()

Michael Mueller (1):
      KVM: s390: fix gisa destroy operation might lead to cpu stalls

Michal Schmidt (1):
      i40e: prevent crash on probe if hw registers have invalid values

Miguel Ojeda (3):
      docs: rust: update Rust docs output path
      kbuild: remove old Rust docs output path
      rust: docs: fix logo replacement

Milan Broz (1):
      block: Fix regression in sed-opal for a saved key.

Miquel Raynal (3):
      mtd: rawnand: marvell: Ensure program page operations are successful
      mtd: rawnand: arasan: Ensure program page operations are successful
      mtd: rawnand: pl353: Ensure program page operations are successful

Neal Cardwell (1):
      tcp: fix excessive TLP and RACK timeouts from HZ rounding

Nicholas Piggin (1):
      powerpc/qspinlock: Fix stale propagated yield_cpu

Nikita Kravets (1):
      platform/x86: msi-ec: Fix the 3rd config

Niklas Schnelle (1):
      s390/pci: fix iommu bitmap allocation

Nikolay Borisov (1):
      x86/efistub: Don't try to print after ExitBootService()

Olga Kornievskaia (1):
      NFSv4.1: fixup use EXCHGID4_FLAG_USE_PNFS_DS for DS server

Orlando Chamberlain (1):
      apple-gmux: Hard Code max brightness for MMIO gmux

Pablo Neira Ayuso (4):
      netfilter: nf_tables: do not remove elements if set backend
implements .abort
      netfilter: nf_tables: do not refresh timeout when resetting element
      netfilter: nft_set_rbtree: .deactivate fails if element has expired
      netfilter: nf_tables: revert do not remove elements if set
backend implements .abort

Pablo Sun (1):
      mmc: mtk-sd: Use readl_poll_timeout_atomic in msdc_reset_hw

Paolo Abeni (4):
      tcp: allow again tcp_disconnect() when threads are waiting
      tcp_bpf: properly release resources on error paths
      tcp: check mptcp-level constraints for backlog coalescing
      mptcp: more conservative check for zero probes

Paolo Bonzini (1):
      KVM: MIPS: fix -Wunused-but-set-variable warning

Pauli Virtanen (1):
      Bluetooth: hci_sync: always check if connection is alive before delet=
ing

Pavel Skripkin (1):
      fs/ntfs3: Fix OOB read in ntfs_init_from_boot

Pedro Tammela (1):
      net/sched: sch_hfsc: upgrade 'rt' to 'sc' when it becomes a inner cur=
ve

Peter Zijlstra (2):
      sched/eevdf: Fix heap corruption more
      perf: Disallow mis-matched inherited group reads

Phil Sutter (2):
      netfilter: nf_tables: audit log object reset once per table
      selftests: netfilter: Run nft_audit.sh in its own netns

Puliang Lu (1):
      USB: serial: option: add Fibocom to DELL custom modem FM101R-GL

Quinn Tran (1):
      scsi: qla2xxx: Fix double free of dsd_list during driver load

Randy Dunlap (1):
      drm/nouveau: exec: fix ioctl kernel-doc warning

Richard Fitzgerald (3):
      ASoC: cs35l56: Fix illegal use of init_completion()
      ASoC: cs35l56: ASP1 DOUT must default to Hi-Z when not transmitting
      ASoC: cs42l42: Fix missing include of gpio/consumer.h

Roman Kagan (1):
      KVM: x86/pmu: Truncate counter value to allowed width on write

Rouven Czerwinski (1):
      mtd: rawnand: Ensure the nand chip supports cached reads

Roy Chateau (1):
      ASoC: codecs: tas2780: Fix log of failed reset via I2C.

Sagi Grimberg (1):
      nvmet-tcp: Fix a possible UAF in queue intialization setup

Scott Mayhew (1):
      NFS: Fix potential oops in nfs_inode_remove_request()

Sean Christopherson (7):
      KVM: selftests: Treat %llx like %lx when formatting guest printf
      KVM: selftests: Zero-initialize entire test_result in memslot perf te=
st
      x86/fpu: Allow caller to constrain xfeatures when copying to uabi buf=
fer
      KVM: x86: Constrain guest-supported xfeatures only at KVM_GET_XSAVE{2=
}
      KVM: selftests: Touch relevant XSAVE state in guest for state test
      KVM: selftests: Load XSAVE state into untouched vCPU during state tes=
t
      KVM: selftests: Force load all supported XSAVE state in state test

Sergey Shtylyov (2):
      fbdev: core: cfbcopyarea: fix sloppy typing
      fbdev: core: syscopyarea: fix sloppy typing

Shailend Chand (1):
      gve: Do not fully free QPL pages on prefill errors

Shay Drory (2):
      net/mlx5: Perform DMA operations in the right locations
      net/mlx5: E-switch, register event handler before arming the event

Shinas Rasheed (1):
      octeon_ep: update BQL sent bytes before ringing doorbell

Shuming Fan (1):
      ASoC: rt5650: fix the wrong result of key button

Srinivas Pandruvada (1):
      platform/x86: intel-uncore-freq: Conditionally create attribute
for read frequency

Stanislaw Gruszka (1):
      Revert "accel/ivpu: Use cached buffers for FW loading"

Stephen Boyd (1):
      drm/bridge: ti-sn65dsi86: Associate DSI device lifetime with
auxiliary device

Su Hui (1):
      fs/ntfs3: Avoid possible memory leak

Sunil V L (1):
      ACPI: irq: Fix incorrect return value in acpi_register_gsi()

Sven van Ashbrook (1):
      mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix SoCs can suspend

Tiezhu Yang (1):
      LoongArch: Use SYM_CODE_* to annotate exception handlers

Tom Lendacky (1):
      KVM: SVM: Fix build error when using -Werror=3Dunused-but-set-variabl=
e

Tomas Henzl (1):
      scsi: mpt3sas: Fix in error path

Tony Lindgren (3):
      phy: mapphone-mdm6600: Fix runtime disable on probe
      phy: mapphone-mdm6600: Fix runtime PM for remove
      phy: mapphone-mdm6600: Fix pinctrl_pm handling for sleep pins

Trond Myklebust (2):
      pNFS: Fix a hang in nfs4_evict_inode()
      pNFS/flexfiles: Check the layout validity in
ff_layout_mirror_prepare_stats

Ulf Hansson (1):
      mmc: core: Fix error propagation for some ioctl commands

Vadim Pasternak (1):
      platform: mellanox: Fix a resource leak in an error handling
path in probing flow

Varadarajan Narayanan (1):
      phy: qcom: m31: Remove unwanted qphy->vreg is NULL check

Vasily Gorbik (1):
      s390/kasan: handle DCSS mapping in memory holes

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Retry gtt fault when out of fence registers

Vlad Buslov (1):
      net/mlx5: Bridge, fix peer entry ageing in LAG mode

Vladimir Oltean (1):
      net: mdio-mux: fix C45 access returning -EIO after API change

Wedson Almeida Filho (1):
      rust: error: fix the description for `ECHILD`

Willem de Bruijn (1):
      net: more strict VIRTIO_NET_HDR_GSO_UDP_L4 validation

William A. Kennington III (1):
      spi: npcm-fiu: Fix UMA reads when dummy.nbytes =3D=3D 0

Wludzik, Jozef (1):
      accel/ivpu: Extend address range for MMU mmap

Wyes Karny (1):
      perf pmu: Fix perf stat output with correct scale and unit

Xingyuan Mo (2):
      nf_tables: fix NULL pointer dereference in nft_inner_init()
      nf_tables: fix NULL pointer dereference in nft_expr_inner_parse()

Yang Yingliang (2):
      phy: qcom: phy-qcom-m31: fix wrong pointer pass to PTR_ERR()
      phy: qcom: phy-qcom-m31: change m31_ipq5332_regs to static

Zeng Heng (1):
      fs/ntfs3: fix panic about slab-out-of-bounds caused by ntfs_list_ea()

Zhang Changzhong (1):
      xfrm6: fix inet6_dev refcount underflow problem

Ziqi Zhao (1):
      fs/ntfs3: Fix possible null-pointer dereference in hdr_find_e()

Ziyang Xuan (1):
      Bluetooth: Fix a refcnt underflow problem for hci_conn

Zygo Blaxell (1):
      btrfs: fix stripe length calculation for non-zoned data chunk allocat=
ion
