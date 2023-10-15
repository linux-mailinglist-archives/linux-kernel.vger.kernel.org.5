Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA64E7C9B9F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjJOUqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJOUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:46:09 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F36C1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:46:05 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso5565999a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697402763; x=1698007563; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SbO6IDaiU+4cx8Pf9Or6Qi6v3U8S7tt39MiLcr543fk=;
        b=VdjBCLOiQGqNeFpvDrwiekylXhXUEEty+aKI7YrHp/kLo8KFl23x9kV4SyIMNR8LCG
         b+idbW7iuUDeX8egikLieYItJSIlW1ko631qegLvgy6965elF8APWyCXqvB8/n7j5GUX
         2rxcEJc69fO6bQ5/V90hVbfAyxrIq8/VqBtAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697402763; x=1698007563;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbO6IDaiU+4cx8Pf9Or6Qi6v3U8S7tt39MiLcr543fk=;
        b=EHcgOk66mrjH0r2xr9U+KoqnT7VK9qacXi4YWJHwMFMU1ifHoH3ZpbS8CEBNVERyN7
         ysxL7hZn06XBD/PBX10BaU1tekH2d6tnrQUulJcQS4RxrsBDPYp8LSkRyHQ273EabVyQ
         PirN8bBlv9ohegzD9FDZaqQ8qSYBiE8aSjwVd61pCHsp4trqzl0HYoAY26PMaQSNUSq3
         sXdwtjwOQZeR6caYpURJr4i//MFbwAUJHMVE+X21PIBfJ+sZCCIqkqhG/UopBTfXQ+dP
         avoYlbvWIDGWRl1I3/tja2SY24dP5OUGSKlqPSKZnxrFF07OaJhhIWxQZ88IyRIo4qdl
         spkQ==
X-Gm-Message-State: AOJu0Yz5oX4cJd3SEJiJFEoe9e1LllRLwyxojcnNrhprRR2eWIGfFKsh
        gStw/INZnuVy3MDj9zLyJpbGB4nR4S+j2OIIP5GAmA==
X-Google-Smtp-Source: AGHT+IGnc5tcSDqlHofMyyWqC7iDrdPRfLo1XKCPmmx1MN7Sz9VgM5wCAlDDuWpo9ElDoV954Guu9w==
X-Received: by 2002:a50:f613:0:b0:53e:1721:2419 with SMTP id c19-20020a50f613000000b0053e17212419mr8067203edn.18.1697402763256;
        Sun, 15 Oct 2023 13:46:03 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id s22-20020a50d496000000b0053e8f1f79afsm1846909edi.30.2023.10.15.13.46.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Oct 2023 13:46:02 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso5565977a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:46:02 -0700 (PDT)
X-Received: by 2002:a17:907:7f9e:b0:9c2:a072:78c8 with SMTP id
 qk30-20020a1709077f9e00b009c2a07278c8mr2100756ejc.26.1697402761289; Sun, 15
 Oct 2023 13:46:01 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Oct 2023 13:45:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRt+O3rYh+0CxR7AbZVrEFgfTLubR9fLVxRpe9GGvB8g@mail.gmail.com>
Message-ID: <CAHk-=whRt+O3rYh+0CxR7AbZVrEFgfTLubR9fLVxRpe9GGvB8g@mail.gmail.com>
Subject: Linux 6.6-rc6
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So the previous week has been pretty calm, and a lot of the discussion
has been about future changes as so often happens late in the release
cycle.

But despite this rc not being anything particularly special, somebody
made a musical video documentary about it all:

    https://www.youtube.com/watch?v=3DWxnN05vOuSM

which is probably the most notable thing here.

But if you just want the usual textual version, it's appended below.
The short version is that everything looks normal, and there's just
the usual random fixes all over the place. So we'll see the final
release in two weeks unless something odd happens. That ends up being
a bit inconvenient for me, since the first week of the merge window
will happen while I'm off for vacation travel, but hey, it's not the
first time that happens, and it probably won't be the last. I'll deal.

             Linus

---

Abhinav Kumar (3):
      drm/msm/dsi: skip the wait for video mode done if not applicable
      drm/msm/dpu: change _dpu_plane_calc_bw() to use u64 to avoid overflow
      drm/msm/dpu: fail dpu_plane_atomic_check() based on mdp clk limits

Alex Bee (1):
      dt-bindings: ASoC: rockchip: Add compatible for RK3128 spdif

Alexander Zangerl (1):
      iio: pressure: ms5611: ms5611_prom_is_valid false negative bug

Alexandre Ghiti (3):
      riscv: kselftests: Fix mm build by removing testcases subdirectory
      riscv: Fix ftrace syscall handling which are now prefixed with __risc=
v_
      drivers: perf: Fix panic in riscv SBI mmap support

Alisa-Dariana Roman (1):
      iio: adc: ad7192: Correct reference voltage

Amadeusz S=C5=82awi=C5=84ski (2):
      ASoC: core: Print component name when printing log
      ASoC: core: Do not call link_exit() on uninitialized rtd objects

Amelie Delaunay (5):
      dmaengine: stm32-mdma: abort resume if no ongoing transfer
      dmaengine: stm32-mdma: use Link Address Register to compute residue
      dmaengine: stm32-mdma: set in_flight_bytes in case CRQA flag is set
      dmaengine: stm32-dma: fix stm32_dma_prep_slave_sg in case of MDMA cha=
ining
      dmaengine: stm32-dma: fix residue in case of MDMA chaining

Amir Goldstein (4):
      fs: factor out vfs_parse_monolithic_sep() helper
      ovl: fix regression in parsing of mount options with escaped comma
      ovl: fix regression in showing lowerdir mount option
      ovl: temporarily disable appending lowedirs

Andrew Kanner (1):
      xdp: Fix zero-size allocation warning in xskq_create()

Andy Chiu (1):
      riscv: signal: fix sigaltstack frame size checking

AngeloGioacchino Del Regno (1):
      MAINTAINERS: Add Angelo as MediaTek SoC co-maintainer

Antoine Gennart (1):
      ASoC: tlv320adc3xxx: BUG: Correct micbias setting

Antoniu Miclaus (2):
      iio: admv1013: add mixer_vgate corner cases
      iio: addac: Kconfig: update ad74413r selections

Anup Patel (1):
      irqchip/riscv-intc: Mark all INTC nodes as initialized

Athira Rajeev (2):
      powerpc/pseries: Fix STK_PARAM access in the hcall tracing code
      powerpc/pseries: Remove unused r0 in the hcall tracing code

Balamurugan C (2):
      ASoC: Intel: soc-acpi: Add entry for sof_es8336 in MTL match table.
      ASoC: Intel: soc-acpi: Add entry for HDMI_In capture support in
MTL match table

Ben Wolsieffer (1):
      irqchip/stm32-exti: add missing DT IRQ flag translation

Benjamin Segall (1):
      sched/eevdf: Fix pick_eevdf()

Biju Das (1):
      irqchip: renesas-rzg2l: Fix logic to clear TINT interrupt source

Bj=C3=B6rn T=C3=B6pel (3):
      riscv: Only consider swbp/ss handlers for correct privileged mode
      riscv, bpf: Sign-extend return values
      riscv, bpf: Track both a0 (RISC-V ABI) and a5 (BPF) return values

Borislav Petkov (AMD) (1):
      x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs

Carlos Llamas (1):
      binder: fix memory leaks of spam and pending work

Charles Keepax (1):
      soundwire: bus: Make IRQ handling conditionally built

Chen Jiahao (1):
      riscv: kdump: fix crashkernel reserving problem on RISC-V

Christian K=C3=B6nig (2):
      dma-buf: add dma_fence_timestamp helper
      drm/amdgpu: add missing NULL check

Christophe Leroy (3):
      powerpc/8xx: Fix pte_access_permitted() for PAGE_NONE
      powerpc/64e: Fix wrong test in __ptep_test_and_clear_young()
      powerpc/85xx: Fix math emulation exception

Christos Skevis (1):
      ALSA: usb-audio: Fix microphone sound on Nexigo webcam.

Damien Le Moal (1):
      scsi: Do not rescan devices with a suspended queue

Dan Carpenter (4):
      drm/msm/dsi: fix irq_of_parse_and_map() error checking
      mlxsw: fix mlxsw_sp2_nve_vxlan_learning_set() return type
      ceph: fix type promotion bug on 32bit systems
      ixgbe: fix crash with empty VF macvlan list

Daniel Borkmann (6):
      bpf: Fix BPF_PROG_QUERY last field check
      bpf: Handle bpf_mprog_query with NULL entry
      selftests/bpf: Test bpf_mprog query API via libbpf and raw syscall
      selftests/bpf: Adapt assert_mprog_count to always expect 0 count
      selftests/bpf: Test query on empty mprog and pass revision into attac=
h
      selftests/bpf: Make seen_tc* variable tests more robust

Daniel Miess (1):
      drm/amd/display: Don't set dpms_off for seamless boot

Darrick J. Wong (2):
      xfs: adjust the incore perag block_count when shrinking
      xfs: process free extents to busy list in FIFO order

David Sterba (1):
      Revert "btrfs: reject unknown mount options early"

David Vernet (2):
      bpf: Fix verifier log for async callback return values
      selftests/bpf: Add testcase for async callback return value failure

Dharma Balasubiramani (1):
      counter: microchip-tcb-capture: Fix the use of internal GCLK logic

Dinghao Liu (1):
      ieee802154: ca8210: Fix a potential UAF in ca8210_probe

Dmitry Baryshkov (2):
      arm64: dts: qcom: sm8150: extend the size of the PDC resource
      drm/msm/mdss: fix highest-bank-bit for msm8998

Dmitry Torokhov (3):
      pinctrl: avoid unsafe code pattern in find_pinctrl()
      Revert "Input: psmouse - add delay when deactivating for SMBus mode"
      Input: synaptics-rmi4 - handle reset delay when using SMBus trsnsport

Duoming Zhou (1):
      dmaengine: mediatek: Fix deadlock caused by synchronize_irq()

Eric Dumazet (2):
      net: refine debug info in skb_checksum_help()
      net: nfc: fix races in nfc_llcp_sock_get() and nfc_llcp_sock_get_sn()

Eugen Hristev (1):
      arm64: dts: mediatek: fix t-phy unit name

Fabio Estevam (1):
      ASoC: dt-bindings: fsl,micfil: Document #sound-dai-cells

Fabrice Gasnier (1):
      counter: chrdev: fix getting array extensions

Frank Li (3):
      dmaengine: fsl-dma: fix DMA error when enabling sg if 'DONE' bit is s=
et
      dmaengine: fsl-edma: fix edma4 channel enable failure on second attem=
pt
      dmaengine: fsl-edma: fix all channels requested when call
fsl_edma3_xlate()

GONG, Ruiqi (1):
      iio: irsd200: fix -Warray-bounds bug in irsd200_trigger_handler

Geert Uytterhoeven (3):
      dt-bindings: interrupt-controller: renesas,irqc: Add r8a779f0 support
      irqchip/renesas-rzg2l: Convert to irq_data_get_irq_chip_data()
      media: ipu-bridge: Add missing acpi_dev_put() in
ipu_bridge_get_ivsc_acpi_dev()

Gerd Bayer (1):
      net/smc: Fix dependency of SMC on ISM

Gustavo A. R. Silva (2):
      net: sched: cls_u32: Fix allocation size in u32_init()
      btrfs: add __counted_by for struct btrfs_delayed_item and use
struct_size()

Haibo Chen (2):
      arm64: dts: imx93: add the Flex-CAN stop mode by GPR
      can: flexcan: remove the auto stop mode for IMX93

Hal Feng (2):
      pinctrl: starfive: jh7110: Fix failure to set irq after
CONFIG_PM is enabled
      pinctrl: starfive: jh7110: Add system pm ops to save and restore cont=
ext

Hans de Goede (6):
      ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CBA
      ACPI: EC: Add quirk for the HP Pavilion Gaming 15-dk1xxx
      Input: goodix - ensure int GPIO is in input for gpio_count =3D=3D 1
&& gpio_int_idx =3D=3D 0 case
      HID: logitech-hidpp: Fix kernel crash on receiver USB disconnect
      ACPI: resource: Add TongFang GM6BGEQ, GM6BG5Q and GM6BG0Q to
irq1_edge_low_force_override[]
      media: subdev: Don't report V4L2_SUBDEV_CAP_STREAMS when the
streams API is disabled

Heikki Krogerus (1):
      usb: typec: ucsi: Fix missing link removal

Herbert Xu (1):
      dm crypt: Fix reqsize in crypt_iv_eboiv_gen

Hui Liu (1):
      usb: typec: qcom: Update the logic of regulator enable and disable

Icenowy Zheng (1):
      drm/amdgpu: fix SI failure due to doorbells allocation

Ilya Leoshkevich (2):
      s390/bpf: Fix clobbering the caller's backchain in the trampoline
      s390/bpf: Fix unwinding past the trampoline

Ioana Ciornei (1):
      phy: lynx-28g: cancel the CDR check work item on the remove path

JP Kobryn (1):
      perf/x86/lbr: Filter vsyscall addresses

Jakub Kicinski (1):
      net: tcp: fix crashes trying to free half-baked MTU probes

Jan Kara (1):
      quota: Fix slow quotaoff

Janusz Krzysztofik (1):
      ASoC: ti: ams-delta: Fix cx81801_receive() argument types

Javier Carrasco (3):
      usb: misc: onboard_hub: add support for Microchip USB2412 USB 2.0 hub
      net: usb: dm9601: fix uninitialized variable use in dm9601_mdio_read
      Input: powermate - fix use-after-free in powermate_config_complete

Jeff Layton (1):
      xfs: reinstate the old i_version counter as STATX_CHANGE_COOKIE

Jeffery Miller (1):
      Input: psmouse - fix fast_reconnect function for PS/2 mode

Jeremy Cline (1):
      nfc: nci: assert requested protocol is valid

Jeremy Kerr (1):
      mctp: perform route lookups under a RCU read-side lock

Jiapeng Chong (1):
      xfs: Remove duplicate include

Jiexun Wang (1):
      RISC-V: Fix wrong use of CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK

Jisheng Zhang (1):
      soc: renesas: Make ARCH_R9A07G043 (riscv version) depend on NONPORTAB=
LE

Joey Gouly (1):
      drm/tiny: correctly print `struct resource *` on error

Johan Hovold (2):
      power: supply: qcom_battmgr: fix enable request endianness
      HID: i2c-hid: fix handling of unpopulated devices

John Ogness (1):
      printk: flush consoles before checking progress

John Watts (1):
      can: sun4i_can: Only show Kconfig if ARCH_SUNXI is set

Jonathan Cameron (1):
      iio: imu: bno055: Fix missing Kconfig dependencies

Jordan Rife (1):
      libceph: use kernel_connect()

Jorge Sanjuan Garcia (1):
      mcb: remove is_added flag from mcb_device struct

Juergen Gross (1):
      xen/events: replace evtchn_rwlock with RCU

Kailang Yang (2):
      ALSA: hda/realtek - ALC287 merge RTK codec with CS CS35L41 AMP
      ALSA: hda/realtek: Change model for Intel RVP board

Kees Cook (1):
      Documentation: embargoed-hardware-issues.rst: Clarify prenotifaction

Kirill A. Shutemov (1):
      x86/alternatives: Disable KASAN in apply_alternatives()

Konstantin Meskhidze (1):
      drm/vmwgfx: fix typo of sizeof argument

Kory Maincent (1):
      ethtool: Fix mod state of verbose no_mask bitset

Krishna Kurapati (1):
      usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call

Krzysztof Ha=C5=82asa (1):
      IXP4xx MAINTAINERS entries

Krzysztof Kozlowski (1):
      dt-bindings: iio: rohm,bu27010: add missing vdd-supply to example

Kuninori Morimoto (2):
      ASoC: simple-card-utils: fixup simple_util_startup() error handling
      ASoC: simple-card: fixup asoc_simple_probe() error handling

Kuniyuki Iwashima (1):
      af_packet: Fix fortified memcpy() without flex array.

Kuogee Hsieh (1):
      drm/msm/dp: do not reinitialize phy unless retry during link training

Lad Prabhakar (3):
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update
description for '#interrupt-cells' property
      riscv: errata: andes: Makefile: Fix randconfig build issue
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
RZ/G2UL SoC

Lakshmi Yadlapati (1):
      iio: pressure: dps310: Adjust Timeout Settings

Linu Cherian (1):
      coresight: Fix run time warnings while reusing ETR buffer

Linus Torvalds (2):
      Revert "x86/smp: Put CPUs into INIT on shutdown if possible"
      Linux 6.6-rc6

Linus Walleij (1):
      Revert "pinctrl: tegra: Add support to display pin function"

Lorenz Bauer (1):
      bpf: Refuse unused attributes in bpf_prog_{attach,detach}

Lorenzo Pieralisi (2):
      dt-bindings: interrupt-controller: arm,gic-v3: Add
dma-noncoherent property
      irqchip/gic-v3: Enable non-coherent redistributors/ITSes DT probing

Lucy Mielke (1):
      workqueue: fix -Wformat-truncation in create_worker

Luis Henriques (1):
      ceph: remove unnecessary IS_ERR() check in ceph_fname_to_usr()

Lukas Magel (1):
      can: isotp: isotp_sendmsg(): fix TX state detection and wait behavior

Lukas Wunner (3):
      xhci: Clear EHB bit only at end of interrupt handler
      xhci: Preserve RsvdP bits in ERSTBA register correctly
      serial: Reduce spinlocked portion of uart_rs485_config()

Macpaul Lin (2):
      arm64: dts: mediatek: mt8195-demo: fix the memory size to 8GB
      arm64: dts: mediatek: mt8195-demo: update and reorder reserved
memory regions

Marc Zyngier (3):
      irqchip/gic-v3-its: Split allocation from initialisation of its_node
      MAINTAINERS: Add myself as the ARM GIC maintainer
      MAINTAINERS: Remove myself from the general IRQ subsystem maintenance

Marcelo Schmitt (1):
      iio: dac: ad3552r: Correct device IDs

Marek Beh=C3=BAn (2):
      net: dsa: qca8k: fix regmap bulk read/write methods on big endian sys=
tems
      net: dsa: qca8k: fix potential MDIO bus conflict when accessing
internal PHYs via management frames

Mario Limonciello (1):
      usb: typec: ucsi: Use GET_CAPABILITY attributes data to set
power supply scope

Markus Schneider-Pargmann (1):
      can: tcan4x5x: Fix id2_register for tcan4553

Mathias Nyman (1):
      xhci: track port suspend state correctly in unsuccessful resume cases

Matthew Wilcox (Oracle) (1):
      drm: Do not overrun array in drm_gem_get_pages()

Matthias Berndt (1):
      Input: xpad - add PXN V900 support

Matthias Reichl (1):
      ASoC: hdmi-codec: Fix broken channel map reporting

Max Nguyen (1):
      Input: xpad - add HyperX Clutch Gladiate Support

Michael Ellerman (1):
      powerpc/47x: Fix 47x syscall return crash

Michal Koutn=C3=BD (1):
      cgroup: Remove duplicates in cgroup v1 tasks file

Michal Swiatkowski (1):
      ice: block default rule setting on LAG interface

Mika Westerberg (4):
      thunderbolt: Workaround an IOMMU fault on certain systems with
Intel Maple Ridge
      thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding
      thunderbolt: Correct TMU mode initialization from hardware
      thunderbolt: Restart XDomain discovery handshake after failure

Mikhail Kobuk (1):
      pinctrl: nuvoton: wpcm450: fix out of bounds write

Miquel Raynal (2):
      ASoC: soc-generic-dmaengine-pcm: Fix function name in comment
      can: sja1000: Always restart the Tx queue after an overrun

Moshe Shemesh (1):
      devlink: Hold devlink lock on health reporter dump get

M=C3=A5rten Lindahl (1):
      iio: light: vcnl4000: Don't power on/off chip in config

Namjae Jeon (4):
      ksmbd: not allow to open file if delelete on close bit is set
      ksmbd: fix wrong error response status by using set_smb2_rsp_status()
      ksmbd: fix Null pointer dereferences in ksmbd_update_fstate()
      ksmbd: fix potential double free on smb2_read_pipe() error path

Neil Armstrong (1):
      irqchip/qcom-pdc: Add support for v3.2 HW

Nils Hoppmann (1):
      net/smc: Fix pos miscalculation in statistics

N=C3=ADcolas F. R. A. Prado (1):
      arm64: dts: mediatek: mt8195: Set DSU PMU status to fail

Olaf Hering (1):
      hyperv: reduce size of ms_hyperv_info

Ondrej Jirman (1):
      media: i2c: ov8858: Don't set fwnode in the driver

Ondrej Zary (4):
      ata: pata_parport: fix pata_parport_devchk
      ata: pata_parport: implement set_devctl
      ata: pata_parport: add custom version of wait_after_reset
      ata: pata_parport: fit3: implement IDE command set registers

Paulo Alcantara (2):
      smb: client: make laundromat a delayed worker
      smb: client: prevent new fids from being removed by laundromat

Pawel Laszczak (1):
      usb: cdnsp: Fixes issue with dequeuing not queued requests

Peng Fan (1):
      pmdomain: imx: scu-pd: correct DMA2 channel

Peter Wang (1):
      scsi: ufs: core: Correct clear TM error log

Peter Zijlstra (1):
      sched/eevdf: Fix min_deadline heap integrity

Phil Elwell (1):
      iio: pressure: bmp280: Fix NULL pointer exception

Philipp Rossak (1):
      iio: adc: imx8qxp: Fix address for command buffer registers

Pierre-Louis Bossart (2):
      ASoC: Intel: soc-acpi: fix Dell SKU 0B34
      ASoC: Intel: sof_sdw: add support for SKU 0B14

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Prashanth K (1):
      usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command fails

RD Babiera (1):
      usb: typec: altmodes/displayport: Signal hpd low when exiting mode

Radhey Shyam Pandey (1):
      dt-bindings: dmaengine: zynqmp_dma: add xlnx,bus-width required prope=
rty

Radu Pirea (NXP OSS) (4):
      net: macsec: indicate next pn update when offloading
      octeontx2-pf: mcs: update PN only when update_pn is true
      net: phy: mscc: macsec: reject PN update requests
      net/mlx5e: macsec: use update_pn flag instead of PN comparation

Ralph Siemsen (1):
      pinctrl: renesas: rzn1: Enable missing PINMUX

Randy Dunlap (2):
      x86/resctrl: Fix kernel-doc warnings
      net: skbuff: fix kernel-doc typos

Ratheesh Kannoth (1):
      octeontx2-pf: Fix page pool frag allocation warning

Rex Zhang (1):
      dmaengine: idxd: use spin_lock_irqsave before wait_event_lock_irq

Ricardo Ca=C3=B1uelo (1):
      usb: hub: Guard against accesses to uninitialized BOS descriptors

Rijo Thomas (1):
      tee: amdtee: fix use-after-free vulnerability in amdtee_close_session

Rob Herring (1):
      dt-bindings: iio: adc: adi,ad7292: Fix additionalProperties on
channel nodes

Roger Pau Monne (1):
      xen-netback: use default TX queue size for vifs

Ruihai Zhou (1):
      drm/panel: boe-tv101wum-nl6: Completely pull GPW to VGL before TP ter=
m

Russ Weight (1):
      firmware_loader: Update contact emails for ABI docs

Russell King (Oracle) (1):
      cpu-hotplug: Provide prototypes for arch CPU registration

Sakari Ailus (1):
      media: xilinx-vipp: Look for entities also in waiting_list

Sarthak Kukreti (1):
      block: Don't invalidate pagecache for invalid falloc modes

Saurabh Sengar (3):
      x86/hyperv: Restrict get_vtl to only VTL platforms
      x86/hyperv: Remove hv_vtl_early_init initcall
      x86/hyperv: Add common print prefix "Hyper-V" in hv_init

Sebastian Reichel (1):
      power: supply: qcom_battmgr: fix battery_id type

Shengjiu Wang (2):
      ASoC: fsl_sai: Don't disable bitclock for i.MX8MP
      ASoC: fsl-asoc-card: use integer type for fll_id and pll_id

Shiyang Ruan (1):
      xfs: correct calculation for agend and blockcount

Shradha Gupta (1):
      hv/hv_kvp_daemon:Support for keyfile based connection profile

Simon Ser (1):
      drm/atomic-helper: relax unregistered connector check

Song Shuai (1):
      riscv: Remove duplicate objcopy flag

Stefan Binding (1):
      ALSA: hda: cs35l41: Cleanup and fix double free in firmware request

Stephen Boyd (1):
      drm/msm/dp: Add newlines to debug printks

Sumit Garg (1):
      KEYS: trusted: Remove redundant static calls usage

Suzuki K Poulose (1):
      coresight: tmc-etr: Disable warnings for allocation failures

Sven Frotscher (1):
      ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM

Szilard Fabian (1):
      Input: i8042 - add Fujitsu Lifebook E5411 to i8042 quirk table

Thinh Nguyen (1):
      usb: dwc3: Soft reset phy on probe for host

Tony Lindgren (2):
      serial: 8250_omap: Fix errors with no_console_suspend
      serial: core: Fix checks for tx runtime PM state

Tzung-Bi Shih (1):
      iio: cros_ec: fix an use-after-free in cros_ec_sensors_push_data()

Vijendar Mukunda (1):
      ASoC: SOF: amd: fix for firmware reload failure after playback

Vladimir Oltean (2):
      phy: lynx-28g: lock PHY while performing CDR lock workaround
      phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to
shared registers

Waiman Long (2):
      cgroup: Fix incorrect css_set_rwsem reference in comment
      workqueue: Override implicit ordered attribute in
workqueue_apply_unbound_cpumask()

WangJinchao (1):
      workqueue: doc: Fix function and sysfs path errors

Wesley Cheng (1):
      usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer

WhaleChang (1):
      ALSA: usb-audio: Fix microphone sound on Opencomm2 Headset

Will Mortensen (1):
      net/mlx5e: Again mutually exclude RX-FCS and RX-port-timestamp

Xiaolei Wang (1):
      usb: cdns3: Modify the return value of cdns_set_active () to
void when CONFIG_PM_SLEEP is disabled

Xingxing Luo (2):
      usb: musb: Modify the "HWVers" register address
      usb: musb: Get the musb_qh poniter after musb_giveback

Xiubo Li (1):
      ceph: fix incorrect revoked caps assert in ceph_fill_file_size()

Xuan Zhuo (1):
      virtio_net: fix the missing of the dma cpu sync

Yanguo Li (1):
      nfp: flower: avoid rmmod nfp crash issues

Yoshihiro Shimoda (4):
      ravb: Fix up dma_free_coherent() call in ravb_remove()
      ravb: Fix use-after-free issue in ravb_tx_timeout_work()
      rswitch: Fix renesas_eth_sw_remove() implementation
      rswitch: Fix imbalance phy_power_off() calling

YueHaibing (1):
      pinctrl: lantiq: Remove unsued declaration ltq_pinctrl_unregister()

Zack Rusin (1):
      drm/vmwgfx: Keep a gem reference to user bos in surfaces

Zhang Shurong (2):
      ASoC: rt5682: Fix regulator enable/disable sequence
      dmaengine: ste_dma40: Fix PM disable depth imbalance in d40_probe

Zqiang (2):
      workqueue: Fix UAF report by KASAN in pwq_release_workfn()
      workqueue: Use the kmem_cache_free() instead of kfree() to release pw=
q
