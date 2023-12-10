Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55DB80BDC3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjLJWxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 17:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjLJWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 17:53:23 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0B4FD
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:53:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-50be03cc8a3so4978665e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1702248805; x=1702853605; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b2W1cAVGOzlhe7+NwCDazbetmWyQ6vctMX83hJhUaU8=;
        b=BNXg5m0Ah3CTnumFYVbNiu1GSPSU8l2F7FHqohTrC1yBMcI4D8qgop/NoKCOE8J48T
         XIde9SSYr3IrOqpM/iuGC5hy01A2Inz6Ks+nlUrL95PDi8ndsKt7uNMvcl5QfYRQvVD5
         qTg/zEF7TsPZoy9u2FiuTYNKb/Tb9v5n8g39c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702248805; x=1702853605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2W1cAVGOzlhe7+NwCDazbetmWyQ6vctMX83hJhUaU8=;
        b=pAkR1k36dvjvW9F1YmJgJMRIh1YQC1gsUfN+vBMzvhDejQkU+BfcsFju8g6wbiD4XN
         0mKEw8bFotRFTGNJygQcRMBWkDzM4llS15exiPPS00qedNOFwOq/Px/Wvs9CV0N9vMlJ
         QyihoubEYATMskRlcE/mKOTsT5hHPYrF+ypZ8e7ysI58QdKApaxLovsL088HhoD4/hQj
         2R3HOHW51tptCn3fQtvgv422gGqBhRXHlTLfLHXtk9p3TwMcZHG2+s5Ywn4gSG7NM4NN
         X5ydUxMuPeE+TT6JhupjPEFX98rtYOItnmyaS7F9McWe5PakZqPcEnsJp37oWh7sGVkk
         MyYA==
X-Gm-Message-State: AOJu0Yxt4VyrKY/hApTFCbFxdO/6D/L2O3r1DiKDdGSkt4n6tiJguIW2
        mANsN7M+oI4RfHMWDH+B0PdJ/yNoGtNJOH8R+5Q=
X-Google-Smtp-Source: AGHT+IGSmmV/Y2YuGROjTqcry0bmRtQtgkowly89dPxcVw4fIaOlaJ6roIdUR6jSha5/0D51pjRsOw==
X-Received: by 2002:a05:6512:5c7:b0:50b:f2f6:ff22 with SMTP id o7-20020a05651205c700b0050bf2f6ff22mr1220001lfo.125.1702248803673;
        Sun, 10 Dec 2023 14:53:23 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id l7-20020a056512110700b0050bf132a3f6sm906033lfg.69.2023.12.10.14.53.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 14:53:22 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-50bf37fd2bbso4992496e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:53:22 -0800 (PST)
X-Received: by 2002:ac2:489b:0:b0:50b:eeac:750d with SMTP id
 x27-20020ac2489b000000b0050beeac750dmr1275676lfc.43.1702248802067; Sun, 10
 Dec 2023 14:53:22 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 10 Dec 2023 14:53:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiwpxsPG9vaQnbh3ch9Uh6s6Kf+8x3TnYE_8prKguHDHg@mail.gmail.com>
Message-ID: <CAHk-=wiwpxsPG9vaQnbh3ch9Uh6s6Kf+8x3TnYE_8prKguHDHg@mail.gmail.com>
Subject: Linux 6.7-rc5
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

Well, this has been a week of travel, jetlag, and then a few days of
getting over a nasty cold for me.

I think I'm mostly over it, but it does mean that I'm very happy that
things have been pretty calm and it wasn't a problem that I was
feeling pretty miserable at one point and sat at the computer only
sporadically as a result.

The stats for rc5 all look very normal - the bulk is drivers (gpu,
networking and sound being the biggest areas, but we've got a bit of
everything in there), and then we have the usual mix of architecture
fixes, filesystems, networking, core kernel and some selftest updates.

Nothing looks particularly scary, which is good, because if it had
been, I wouldn't  have had the capacity to deal with it last week.

Let's hope it stays that way even as I am getting better. Because the
holidays are almost upon us, and I'm woefully underprepared.

                Linus

---

Adri=C3=A1n Larumbe (2):
      drm/panfrost: Consider dma-buf imported objects as resident
      drm/panfrost: Fix incorrect updating of current device frequency

Ahmad Fatoum (1):
      MAINTAINERS: reinstate freescale ARM64 DT directory in i.MX entry

Aleksandrs Vinarskis (1):
      ALSA: hda/realtek: fix speakers on XPS 9530 (2023)

Alex Bee (2):
      arm64: dts: rockchip: Expand reg size of vdec node for RK3399
      ARM: dts: rockchip: Fix sdmmc_pwren's pinmux setting for RK3128

Alex Deucher (2):
      drm/amd/display: Increase frame warning limit with KASAN or KCSAN in =
dml
      drm/amdgpu: fix buffer funcs setting order on suspend

Alexander Stein (4):
      arm64: dt: imx93: tqma9352-mba93xxla: Fix LPUART2 pad config
      dt-bindings: pwm: imx-pwm: Unify #pwm-cells for all compatibles
      arm64: dts: freescale: imx8-ss-lsio: Fix #pwm-cells
      arm64: dts: freescale: imx8-ss-dma: Fix #pwm-cells

Alexander Usyskin (1):
      mei: pxp: fix mei_pxp_send_message return value

Alvin Lee (1):
      drm/amd/display: Use channel_width =3D 2 for vram table 3.0

Andi Shyti (1):
      serial: ma35d1: Validate console index before assignment

Andrew Jones (1):
      RISC-V: hwprobe: Always use u64 for extension bits

Andrew Morton (2):
      MAINTAINERS: add Andrew Morton for lib/*
      mm/memory.c:zap_pte_range() print bad swap entry

Andy Shevchenko (2):
      units: add missing header
      serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART

AngeloGioacchino Del Regno (8):
      ASoC: SOF: mediatek: mt8186: Add Google Steelix topology compatible
      arm64: dts: mediatek: mt8195: Fix PM suspend/resume with venc clocks
      arm64: dts: mediatek: mt8183: Fix unit address for scp reserved memor=
y
      arm64: dts: mediatek: mt8183-evb: Fix unit_address_vs_reg warning on =
ntc
      arm64: dts: mediatek: mt8173-evb: Fix regulator-fixed node names
      arm64: dts: mediatek: mt8183: Move thermal-zones to the root node
      arm64: dts: mediatek: mt8186: Change gpu speedbin nvmem cell name
      arm64: dts: mediatek: cherry: Fix interrupt cells for MT6360 on I2C7

Antoniu Miclaus (1):
      hwmon: max31827: include regulator header

Armin Wolf (3):
      platform/x86: wmi: Skip blocks with zero instances
      hwmon: (acpi_power_meter) Fix 4.29 MW bug
      hwmon: (corsair-psu) Fix probe when built-in

Arnd Bergmann (2):
      ARM: PL011: Fix DMA support
      drm/bridge: tc358768: select CONFIG_VIDEOMODE_HELPERS

Ashwin Dayanand Kamat (1):
      x86/sev: Fix kernel crash due to late update to read-only ghcb_versio=
n

Ayush Singh (1):
      greybus: gb-beagleplay: Ensure le for values in transport

Bagas Sanjaya (1):
      MAINTAINERS: drop Antti Palosaari

Baoquan He (2):
      drivers/base/cpu: crash data showing should depends on KEXEC_CORE
      kernel/Kconfig.kexec: drop select of KEXEC for CRASH_DUMP

Bin Li (1):
      ALSA: hda/realtek: Enable headset on Lenovo M90 Gen5

Bitao Hu (1):
      nvme: fix deadlock between reset and scan

Boerge Struempfel (1):
      gpiolib: sysfs: Fix error handling on failed export

Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Check vendor in the AMD microcode callback

Brett Creeley (1):
      ionic: Fix dim work handling in split interrupt mode

Cameron Williams (1):
      parport: Add support for Brainboxes IX/UC/PX parallel cards

Chancel Liu (1):
      ASoC: imx-rpmsg: SND_SOC_IMX_RPMSG should depend on OF and I2C

Charles Keepax (1):
      ASoC: wm8974: Correct boost mixer inputs

Charlie Jenkins (3):
      riscv: Safely remove entries from relocation list
      riscv: Correct type casting in module loading
      Support rv32 ULEB128 test

Chester Lin (2):
      MAINTAINERS: change the S32G2 maintainer's email address.
      .mailmap: add a new address mapping for Chester Lin

Christophe JAILLET (1):
      hwmon: (nzxt-kraken2) Fix error handling path in kraken2_probe()

ChunHao Lin (1):
      r8169: fix rtl8125b PAUSE frames blasting when suspended

Claudio Imbrenda (2):
      KVM: s390: vsie: fix wrong VIR 37 when MSO is used
      KVM: s390/mm: Properly reset no-dat

Cl=C3=A9ment L=C3=A9ger (1):
      riscv: fix misaligned access handling of C.SWSP and C.SDSP

Colin Ian King (1):
      hwmon: ltc2991: Fix spelling mistake "contiuous" -> "continuous"

Conor Dooley (2):
      riscv: dts: sophgo: remove address-cells from intc node
      riscv: dts: microchip: move timebase-frequency to mpfs.dtsi

D. Wythe (1):
      netfilter: bpf: fix bad registration on nf_defrag

Dan Carpenter (1):
      io_uring/kbuf: Fix an NULL vs IS_ERR() bug in io_alloc_pbuf_ring()

Daniel Borkmann (1):
      packet: Move reference count in packet_sock to atomic_long_t

Daniel Mack (1):
      serial: sc16is7xx: address RX timeout interrupt errata

Daniil Maximov (1):
      net: atlantic: Fix NULL dereference of skb pointer in

Dave Airlie (1):
      nouveau/tu102: flush all pdbs on vmm flush

David Howells (3):
      cifs: Fix flushing, invalidation and file size with copy_file_range()
      cifs: Fix flushing, invalidation and file size with FICLONE
      cifs: Fix non-availability of dedup breaking generic/304

David Jeffery (1):
      md/raid6: use valid sector values to determine if an I/O should
wait on the reshape

David Lin (1):
      ASoC: nau8822: Fix incorrect type in assignment and cast to
restricted __be16

David Rau (1):
      ASoC: da7219: Support low DC impedance headset

David Thompson (1):
      mlxbf-bootctl: correctly identify secure boot with development keys

David Woodhouse (1):
      KVM: selftests: add -MP to CFLAGS

Dinghao Liu (3):
      ASoC: wm_adsp: fix memleak in wm_adsp_buffer_populate
      scsi: be2iscsi: Fix a memleak in beiscsi_init_wrb_handle()
      net: bnxt: fix a potential use-after-free in bnxt_init_tc

Dmitry Safonov (5):
      Documentation/tcp: Fix an obvious typo
      net/tcp: Consistently align TCP-AO option in the header
      net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
      net/tcp: Don't add key with non-matching VRF on connected sockets
      net/tcp: Don't store TCP-AO maclen on reqsk

Douglas Anderson (5):
      r8152: Hold the rtnl_lock for all of reset
      r8152: Add RTL8152_INACCESSIBLE checks to more loops
      r8152: Add RTL8152_INACCESSIBLE to r8156b_wait_loading_flash()
      r8152: Add RTL8152_INACCESSIBLE to r8153_pre_firmware_1()
      r8152: Add RTL8152_INACCESSIBLE to r8153_aldps_en()

Elliot Berman (1):
      freezer,sched: Do not restore saved_state of a thawed task

Eric Dumazet (2):
      ipv6: fix potential NULL deref in fib6_add()
      tcp: do not accept ACK of bytes we never sent

Eric Woudstra (1):
      arm64: dts: mt7986: fix emmc hs400 mode without uboot initialization

Eugen Hristev (3):
      arm64: dts: mediatek: mt8186: fix clock names for power domains
      arm64: dts: mediatek: mt7622: fix memory node warning check
      arm64: dts: mediatek: mt8183-kukui-jacuzzi: fix dsi unnecessary
cells properties

Fabio Estevam (4):
      ARM: dts: imx6ul-pico: Describe the Ethernet PHY clock
      ARM: dts: imx28-xea: Pass the 'model' property
      dt-bindings: lcdif: Properly describe the i.MX23 interrupts
      dt-bindings: display: adi,adv75xx: Document #sound-dai-cells

Florian Fainelli (2):
      pwm: bcm2835: Fix NPD in suspend/resume
      scripts/gdb: fix lx-device-list-bus and lx-device-list-class

Florian Westphal (2):
      netfilter: nft_set_pipapo: skip inactive elements during set walk
      netfilter: nf_tables: fix 'exist' matching on bigendian arches

Francesco Dolcini (1):
      platform/surface: aggregator: fix recv_buf() return value

Frank Wunderlich (2):
      arm64: dts: mt7986: define 3W max power to both SFP on BPI-R3
      arm64: dts: mt7986: change cooling trips

Geetha sowjanya (3):
      octeontx2-af: Fix mcs sa cam entries size
      octeontx2-af: Fix mcs stats register address
      octeontx2-af: Add missing mcs flr handler call

Georg Gottleuber (1):
      nvme-pci: Add sleep quirk for Kingston drives

Greg Kroah-Hartman (1):
      Revert "greybus: gb-beagleplay: Ensure le for values in transport"

Haibo Chen (2):
      arm64: dts: imx93: update gpio node name to align with register addre=
ss
      arm64: dts: imx8ulp: update gpio node name to align with register add=
ress

Hans de Goede (3):
      platform/x86: asus-wmi: Move i8042 filter install to shared asus-wmi =
code
      platform/x86: asus-wmi: Change q500a_i8042_filter() into a
generic i8042-filter
      platform/x86: asus-wmi: Filter Volume key presses if also
reported via atkbd

Hawking Zhang (1):
      drm/amdgpu: Update fw version for boot time error query

Heiko Carstens (1):
      checkstack: fix printed address

Heiko Stuebner (2):
      arm64: dts: rockchip: fix rk356x pcie msg interrupt name
      arm64: dts: rockchip: drop interrupt-names property from rk3588s dfi

Heiner Kallweit (1):
      leds: trigger: netdev: fix RTNL handling to prevent potential deadloc=
k

Helge Deller (1):
      parisc: Fix asm operand number out of range build error in bug table

Hengqi Chen (3):
      LoongArch: Preserve syscall nr across execve()
      LoongArch: BPF: Don't sign extend memory load operand
      LoongArch: BPF: Don't sign extend function return value

Hsin-Yi Wang (1):
      arm64: dts: mt8183: kukui: Fix underscores in node names

Hugh Dickins (1):
      mm: fix oops when filemap_map_pmd() without prealloc_pte

Hui Zhou (1):
      nfp: flower: fix for take a mutex lock in soft irq context and rcu lo=
ck

Ian Rogers (2):
      perf metrics: Avoid segv if default metricgroup isn't set
      perf list: Fix JSON segfault by setting the used
skip_duplicate_pmus callback

Ido Schimmel (2):
      psample: Require 'CAP_NET_ADMIN' when joining "packets" group
      drop_monitor: Require 'CAP_SYS_ADMIN' when joining "events" group

Ilkka Koskinen (1):
      perf vendor events arm64: AmpereOne: Add missing
DefaultMetricgroupName fields

Inki Dae (1):
      drm/exynos: fix a wrong error checking

Ivan Lipski (1):
      drm/amd/display: Add monitor patch for specific eDP

Ivan Orlov (1):
      ALSA: pcmtest: stop timer before buffer is released

Ivan Vecera (1):
      i40e: Fix unexpected MFS warning message

Jack Wang (4):
      RDMA/rtrs-srv: Do not unconditionally enable irq
      RDMA/rtrs-clt: Start hb after path_up
      RDMA/rtrs-clt: Fix the max_send_wr setting
      RDMA/rtrs-clt: Remove the warnings for req in_use check

Jacob Keller (1):
      iavf: validate tx_coalesce_usecs even if rx_coalesce_usecs is zero

Jakub Kicinski (1):
      MAINTAINERS: exclude 9p from networking

James Clark (1):
      coresight: Fix crash when Perf and sysfs modes are used concurrently

Jason Gunthorpe (2):
      iommufd: Add iommufd_ctx to iommufd_put_object()
      iommufd: Do not UAF during iommufd_put_object()

Jason Zhang (1):
      ALSA: pcm: fix out-of-bounds in snd_pcm_state_names

Jens Axboe (1):
      io_uring/kbuf: check for buffer list readiness after NULL check

Jeremy Soller (1):
      ASoC: amd: yc: Add DMI entry to support System76 Pangolin 13

Jiadong Zhu (1):
      drm/amdgpu: disable MCBP by default

Jianheng Zhang (1):
      net: stmmac: fix FPE events losing

Jiaxun Yang (3):
      MIPS: Loongson64: Reserve vgabios memory on boot
      MIPS: Loongson64: Enable DMA noncoherent support
      MIPS: Loongson64: Handle more memory types passed from firmware

Jiexun Wang (1):
      mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()

Jinyang He (1):
      LoongArch: Set unwind stack type to unknown rather than set error fla=
g

Jiri Olsa (2):
      bpf: Fix prog_array_map_poke_run map poke update
      selftests/bpf: Add test for early update in prog_array_map_poke_run

Johan Hovold (1):
      ASoC: soc-pcm: fix up bad merge

Johannes Berg (1):
      Revert "debugfs: annotate debugfs handlers vs. removal with lockdep"

John Fastabend (2):
      net: tls, update curr on splice as well
      bpf: sockmap, updating the sg structure should also update curr

Jonas Karlman (1):
      arm64: dts: rockchip: Expand reg size of vdec node for RK3328

Junhao He (4):
      hwtracing: hisi_ptt: Add dummy callback pmu::read()
      coresight: ultrasoc-smb: Fix sleep while close preempt in enable_smb
      coresight: ultrasoc-smb: Config SMB buffer before register sink
      coresight: ultrasoc-smb: Fix uninitialized before use buf_hw_base

Junxian Huang (2):
      RDMA/hns: Fix unnecessary err return when using invalid congest
control algorithm
      MAINTAINERS: Add Chengchang Tang as Hisilicon RoCE maintainer

Kalesh AP (1):
      RDMA/bnxt_re: Correct module description string

Kamil Duljas (3):
      ASoC: Intel: Skylake: Fix mem leak in few functions
      ASoC: SOF: topology: Fix mem leak in sof_dai_load()
      ASoC: Intel: Skylake: mem leak in skl register function

Keith Busch (3):
      nvme: introduce helper function to get ctrl state
      nvme: ensure reset state check ordering
      nvme-ioctl: move capable() admin check to the end

Kelly Kane (1):
      r8152: add vendor/device ID pair for ASUS USB-C2500

Kirill A. Shutemov (2):
      x86/coco: Disable 32-bit emulation by default on TDX and SEV
      x86/tdx: Allow 32-bit emulation by default

Konrad Dybcio (1):
      dt-bindings: interrupt-controller: Allow #power-domain-cells

Konstantin Aladyshev (1):
      usb: gadget: f_hid: fix report descriptor allocation

Krzysztof Kozlowski (2):
      ARM: dts: rockchip: minor whitespace cleanup around '=3D'
      arm64: dts: rockchip: minor whitespace cleanup around '=3D'

Kuan-Ying Lee (1):
      scripts/gdb/tasks: fix lx-ps command error

Kunkun Jiang (1):
      KVM: arm64: GICv4: Do not perform a map to a mapped vLPI

Kunwu Chan (3):
      platform/mellanox: Add null pointer checks for devm_kasprintf()
      platform/mellanox: Check
devm_hwmon_device_register_with_groups() return value
      ARM: imx: Check return value of devm_kasprintf in imx_mmdc_perf_init

Lad Prabhakar (1):
      riscv: errata: andes: Probe for IOCP only once in boot stage

Li Ma (1):
      drm/amd/swsmu: update smu v14_0_0 driver if version and metrics table

Lijo Lazar (4):
      drm/amdgpu: Restrict extended wait to PSP v13.0.6
      drm/amdgpu: Add NULL checks for function pointers
      drm/amdgpu: Update HDP 4.4.2 clock gating flags
      drm/amdgpu: Avoid querying DRM MGCG status

Like Xu (2):
      KVM: x86: Get CPL directly when checking if loaded vCPU is in kernel =
mode
      KVM: x86: Remove 'return void' expression for 'void function'

Linus Torvalds (1):
      Linux 6.7-rc5

Liu Shixin (2):
      Revert "mm/kmemleak: move the initialisation of object to __link_obje=
ct"
      mm/kmemleak: move set_track_prepare() outside raw_spinlocks

Lizhi Xu (1):
      squashfs: squashfs_read_data need to check if the length is 0

Lorenzo Bianconi (1):
      net: veth: fix packet segmentation in veth_convert_skb_to_xdp_buff

Lorenzo Pieralisi (1):
      firmware: arm_ffa: Fix ffa_notification_info_get() IDs handling

Luca Ceresoli (1):
      of: dynamic: Fix of_reconfig_get_state_change() return value document=
ation

Lukasz Luba (1):
      powercap: DTPM: Fix missing cpufreq_cpu_put() calls

Luke D. Jones (1):
      platform/x86: asus-wmi: disable USB0 hub on ROG Ally before suspend

Maciej Strozek (2):
      ASoC: cs43130: Fix the position of const qualifier
      ASoC: cs43130: Fix incorrect frame delay configuration

Malcolm Hart (1):
      ASoC: amd: yc: Fix non-functional mic on ASUS E1504FA

Marcin Szycik (1):
      ice: Restore fix disabling RX VLAN filtering

Marian Postevca (1):
      ASoC: amd: acp: Add support for a new Huawei Matebook laptop

Mario Limonciello (1):
      ALSA: hda/realtek: Add Framework laptop 16 to quirks

Mathias Nyman (1):
      Revert "xhci: Loosen RPM as default policy to cover for AMD xHC 1.1"

Matthias Reichl (1):
      regmap: fix bogus error on regcache_sync success

Matus Malych (1):
      ASoC: amd: yc: Add HP 255 G10 into quirk table

Md Haris Iqbal (3):
      RDMA/rtrs-srv: Check return values while processing info request
      RDMA/rtrs-srv: Free srv_mr iu only when always_invalidate is true
      RDMA/rtrs-srv: Destroy path files after making sure no IOs in-flight

Michael Walle (1):
      dt-bindings: display: mediatek: dsi: remove Xinlei's mail

Michal Swiatkowski (1):
      ice: change vfs.num_msix_per to vf->num_msix

Mike Kravetz (1):
      hugetlb: fix null-ptr-deref in hugetlb_vma_lock_write

Mike Marciniszyn (3):
      RDMA/core: Fix umem iterator when PAGE_SIZE is greater then HCA pgsz
      RDMA/irdma: Ensure iWarp QP queue memory is OS paged aligned
      RDMA/irdma: Fix support for 64k pages

Ming Lei (1):
      lib/group_cpus.c: avoid acquiring cpu hotplug lock in group_cpus_even=
ly

Miquel Raynal (1):
      nvmem: Do not expect fixed layouts to grab a layout driver

Mukesh Ojha (1):
      devcoredump: Send uevent once devcd is ready

Mustafa Ismail (2):
      RDMA/irdma: Do not modify to SQD on error
      RDMA/irdma: Add wait for suspend on SQD

Nathan Rossi (1):
      arm64: dts: imx8mp: imx8mq: Add parkmode-disable-ss-quirk on DWC3

Naveen Mamindlapalli (1):
      octeontx2-pf: consider both Rx and Tx packet stats for adaptive
interrupt coalescing

Naveen N Rao (1):
      powerpc/ftrace: Fix stack teardown in ftrace_no_trace

Neil Armstrong (1):
      ASoC: codecs: lpass-tx-macro: set active_decimator correct default va=
lue

Nico Pache (1):
      selftests/mm: prevent duplicate runs caused by TEST_GEN_PROGS

Nitesh Shetty (1):
      nvme: prevent potential spectre v1 gadget

Nithin Dabilpuram (1):
      octeontx2-af: Adjust Tx credits when MCS external bypass is disabled

N=C3=ADcolas F. R. A. Prado (1):
      dt: dt-extract-compatibles: Don't follow symlinks when walking tree

Pablo Neira Ayuso (2):
      netfilter: nf_tables: bail out on mismatching dynset and set expressi=
ons
      netfilter: nf_tables: validate family when identifying table via hand=
le

Paolo Abeni (1):
      tcp: fix mid stream window clamp.

Pascal No=C3=ABl (1):
      ALSA: hda/realtek: Apply quirk for ASUS UM3504DA

Paulo Alcantara (1):
      smb: client: fix potential NULL deref in parse_dfs_referrals()

Pavel Begunkov (2):
      io_uring: fix mutex_unlock with unreferenced ctx
      io_uring/af_unix: disable sending io_uring over sockets

Peng Fan (1):
      arm64: dts: imx93: correct mediamix power

Peter Ujfalusi (5):
      ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is
not available
      ASoC: Intel: sof_sdw: Always register the HDMI dai links
      ASoC: hdac_hda: Conditionally register dais for HDMI and Analog
      ASoC: SOF: ipc4-topology: Correct data structures for the SRC module
      ASoC: SOF: ipc4-topology: Correct data structures for the GAIN module

Peter Xu (4):
      mm/pagemap: fix ioctl(PAGEMAP_SCAN) on vma check
      mm/pagemap: fix wr-protect even if PM_SCAN_WP_MATCHING not set
      mm/selftests: fix pagemap_ioctl memory map test
      mm/Kconfig: make userfaultfd a menuconfig

Peter Zijlstra (1):
      perf: Fix perf_event_validate_size()

Petr Pavlu (3):
      tracing: Fix incomplete locking when disabling buffered events
      tracing: Fix a warning when allocating buffered events fails
      tracing: Fix a possible race when disabling buffered events

Phil Sutter (1):
      netfilter: xt_owner: Fix for unsafe access of sk->sk_socket

Philipp Zabel (1):
      ARM: dts: imx7: Declare timers compatible with fsl,imx6dl-gpt

RD Babiera (1):
      usb: typec: class: fix typec_altmode_put_partner to put plugs

Rafael J. Wysocki (1):
      ACPI: utils: Fix error path in acpi_evaluate_reference()

Rahul Bhansali (1):
      octeontx2-af: Update Tx link register range

Randy Dunlap (2):
      hv_netvsc: rndis_filter needs to select NLS
      greybus: BeaglePlay driver needs CRC_CCITT

Ranjani Sridharan (2):
      ASoC: SOF: ipc4-topology: Add core_mask in struct snd_sof_pipeline
      ASoC: SOF: sof-audio: Modify logic for enabling/disabling topology co=
res

Rob Herring (2):
      arm64: dts: rockchip: Fix PCI node addresses on rk3399-gru
      dt-bindings: perf: riscv,pmu: drop unneeded quotes

Robin Murphy (1):
      iommufd/selftest: Fix _test_mock_dirty_bitmaps()

Roman Gushchin (1):
      mm: kmem: properly initialize local objcg variable in current_obj_cgr=
oup()

Roman Li (1):
      drm/amd/display: Fix array-index-out-of-bounds in dml2

Ronald Wahl (3):
      serial: 8250: 8250_omap: Do not start RX DMA on THRI interrupt
      serial: 8250_omap: Add earlycon support for the AM654 UART controller
      serial: 8250: 8250_omap: Clear UART_HAS_RHR_IT_DIS bit

Roy Luo (1):
      USB: gadget: core: adjust uevent timing on gadget unbind

Ryusuke Konishi (2):
      nilfs2: fix missing error check for sb_set_blocksize call
      nilfs2: prevent WARNING in nilfs_sufile_set_segment_usage()

Sam Edwards (2):
      arm64: dts: rockchip: Fix Turing RK1 interrupt pinctrls
      arm64: dts: rockchip: Fix eMMC Data Strobe PD on rk3588

Samuel Holland (1):
      riscv: Fix SMP when shadow call stacks are enabled

Sarah Grant (1):
      ALSA: usb-audio: Add Pioneer DJM-450 mixer controls

Sascha Hauer (1):
      dt-bindings: soc: rockchip: grf: add rockchip,rk3588-pmugrf

Sean Christopherson (3):
      KVM: Set file_operations.owner appropriately for all such structures
      Revert "KVM: Prevent module exit until all VMs are freed"
      KVM: SVM: Update EFER software model on CR0 trap for SEV-ES

Sean Nyekjaer (1):
      net: dsa: microchip: provide a list of valid protocols for xmit handl=
er

SeongJae Park (2):
      mm/damon/core: copy nr_accesses when splitting region
      mm/damon/sysfs-schemes: add timeout for update_schemes_tried_regions

Shannon Nelson (4):
      pds_vdpa: fix up format-truncation complaint
      pds_vdpa: clear config callback when status goes to 0
      pds_vdpa: set features order
      ionic: fix snprintf format length warning

Shengjiu Wang (3):
      ASoC: fsl_sai: Fix no frame sync clock issue on i.MX8MP
      ASoC: fsl_xcvr: Enable 2 * TX bit clock for spdif only case
      ASoC: fsl_xcvr: refine the requested phy clock frequency

Shifeng Li (2):
      RDMA/irdma: Fix UAF in irdma_sc_ccq_get_cqe_info()
      RDMA/irdma: Avoid free the non-cqp_request scratch

Shigeru Yoshida (2):
      RDMA/core: Fix uninit-value access in ib_get_eth_speed()
      ipv4: ip_gre: Avoid skb_pull() failure in ipgre_xmit()

Shin'ichiro Kawasaki (1):
      nvme: improve NVME_HOST_AUTH and NVME_TARGET_AUTH config descriptions

Shuming Fan (1):
      ASoC: rt5650: add mutex to avoid the jack detection failure

Shyam Prasad N (2):
      Revert "cifs: reconnect work should have reference on server struct"
      cifs: reconnect worker should take reference on server struct
unconditionally

Sidhartha Kumar (1):
      mm/hugetlb: have CONFIG_HUGETLB_PAGE select CONFIG_XARRAY_MULTI

Srinivas Kandagatla (2):
      ASoC: ops: add correct range check for limiting volume
      ASoC: qcom: sc8280xp: Limit speaker digital volumes

Stefan Eichenberger (1):
      arm64: dts: imx8-apalis: set wifi regulator to always-on

Stefan Kerkmann (1):
      ARM: dts: imx6q: skov: fix ethernet clock regression

Stefan Wahren (1):
      ARM: dts: bcm2711-rpi-400: Fix delete-node of led_act

Stefan Wiehler (1):
      mips/smp: Call rcutree_report_cpu_starting() earlier

Stefano Garzarella (1):
      vsock/virtio: fix "comparison of distinct pointer types lacks a
cast" warning

Steve Sistare (1):
      vdpa/mlx5: preserve CVQ vringh index

Steven Rostedt (Google) (5):
      tracing: Always update snapshot buffer size
      tracing: Stop current tracer when resizing buffer
      tracing: Disable snapshot buffer when stopping instance tracers
      ring-buffer: Force absolute timestamp on discard of event
      ring-buffer: Test last update in 32bit version of __rb_time_read()

Su Hui (3):
      misc: mei: client.c: return negative error code in mei_cl_write
      misc: mei: client.c: fix problem of return '-EOVERFLOW' in mei_cl_wri=
te
      highmem: fix a memory copy problem in memcpy_from_folio

Subbaraya Sundeep (2):
      octeontx2-pf: Add missing mutex lock in otx2_get_pauseparam
      octeontx2-af: Check return value of nix_get_nixlf before using nixlf

Sudeep Holla (8):
      firmware: arm_ffa: Declare ffa_bus_type structure in the header
      firmware: arm_ffa: Allow FF-A initialisation even when notification f=
ails
      firmware: arm_ffa: Setup the partitions after the notification
initialisation
      firmware: arm_ffa: Add checks for the notification enabled state
      firmware: arm_ffa: Fix FFA notifications cleanup path
      firmware: arm_ffa: Fix the size of the allocation in
ffa_partitions_cleanup()
      firmware: arm_scmi: Fix frequency truncation by promoting multiplier =
type
      firmware: arm_scmi: Fix possible frequency truncation when using
level indexing mode

Sumanth Korikkar (2):
      mm/memory_hotplug: add missing mem_hotplug_lock
      mm/memory_hotplug: fix error handling in add_memory_resource()

Sumit Garg (1):
      tee: optee: Fix supplicant based device enumeration

Takashi Iwai (1):
      ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7

Tejun Heo (1):
      workqueue: Make sure that wq_unbound_cpumask is never empty

Thinh Tran (1):
      net/tg3: fix race condition in tg3_reset_task()

Thomas Bogendoerfer (1):
      MIPS: kernel: Clear FPU states when setting up kernel threads

Thomas Gleixner (2):
      x86/entry: Convert INT 0x80 emulation to IDTENTRY
      x86/entry: Do not allow external 0x80 interrupts

Thomas Reichinger (1):
      arcnet: restoring support for multiple Sohard Arcnet cards

Thomas Zimmermann (1):
      drm/atomic-helpers: Invoke end_fb_access while owning plane state

Tiezhu Yang (2):
      LoongArch: BPF: Fix sign-extension mov instructions
      LoongArch: BPF: Fix unconditional bswap instructions

Tim Bosse (1):
      ALSA: hda/realtek: add new Framework laptop to quirks

Tim Van Patten (1):
      cgroup_freezer: cgroup_freezing: Check if not frozen

Timur Tabi (1):
      nouveau/gsp: document some aspects of GSP-RM

Tobias Waldekranz (1):
      net: dsa: mv88e6xxx: Restore USXGMII support for 6393X

Uwe Kleine-K=C3=B6nig (1):
      coresight: etm4x: Remove bogous __exit annotation for some functions

Vegard Nossum (1):
      Documentation: coresight: fix `make refcheckdocs` warning

Ville Syrj=C3=A4l=C3=A4 (4):
      drm/i915: Check pipe active state in {planes,vrr}_{enabling,disabling=
}()
      drm/i915: Skip some timing checks on BXT/GLK DSI transcoders
      drm/i915/mst: Fix .mode_valid_ctx() return values
      drm/i915/mst: Reject modes that require the bigjoiner

WANG Rui (1):
      LoongArch: Apply dynamic relocations for LLD

Wen Gu (1):
      net/smc: fix missing byte order conversion in CLC handshake

Xi Ruoyao (1):
      LoongArch: Slightly clean up drdtime()

Xiang Yang (1):
      drm/exynos: fix a potential error pointer dereference

Xiaolei Wang (1):
      arm64: dts: imx8qm: Add imx8qm's own pm to avoid panic during startup

Yang Wang (2):
      drm/amd/pm: support new mca smu error code decoding
      drm/amdgpu: optimize the printing order of error data

Yewon Choi (1):
      xsk: Skip polling event check for unbound socket

Yi Zhang (1):
      ndtest: fix typo class_regster -> class_register

Yicong Yang (2):
      hwtracing: hisi_ptt: Handle the interrupt in hardirq context
      hwtracing: hisi_ptt: Don't try to attach a task

Yonghong Song (1):
      bpf: Fix a verifier bug due to incorrect branch offset
comparison with cpu=3Dv4

Yonglong Liu (2):
      net: hns: fix wrong head when modify the tx feature when sending pack=
ets
      net: hns: fix fake link up on xge port

Yu Kuai (4):
      md: fix missing flush of sync_work
      md: don't leave 'MD_RECOVERY_FROZEN' in error path of md_set_readonly=
()
      md: fix stopping sync thread
      md: split MD_RECOVERY_NEEDED out of mddev_resume

Zhipeng Lu (1):
      octeontx2-af: fix a use-after-free in rvu_npa_register_reporters

angquan yu (1):
      KVM: selftests: Actually print out magic token in NX hugepages
skip message

heminhong (1):
      drm/i915: correct the input parameter on _intel_dsb_commit()
