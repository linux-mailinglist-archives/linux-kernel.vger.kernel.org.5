Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED548781DEE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 15:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjHTNNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 09:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHTNNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 09:13:41 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25813193
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:09:58 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4ffa94a7a47so2401508e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692536996; x=1693141796;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3mAnqj4tCW/YRazp8dJ3UqzzKqJ2bHnK4e9i95pl6vc=;
        b=Ns4avr382nyn5arE/Y9gpd+n4ddSLxTtxW5A/heRN+hMjeH1D2DDmMR3gOT47s89kj
         SGtjTBfWwrHE9lrYG0yXJk17TQjzeZDLNKTbFXjlBPnJWkw0Q2hlK0f2oNktJOXCfCKD
         lbMkcnEYhAV8266V3qCOjT+dCTkw8ffro96/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692536996; x=1693141796;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3mAnqj4tCW/YRazp8dJ3UqzzKqJ2bHnK4e9i95pl6vc=;
        b=EV0jfvoZFxxUM55YQ6I2dKlkB0g/m6BMjX1KX/XYLLDPqu2a/epE0sFQANoV+9HTUZ
         R04vWvbW5cCmW+A0psfCuFVCC/+VfoBdyV4olsYYFaSm8f2RcwFPe+n/qX0TryxgwnHJ
         q3aboXlm2zzZ6rb4mz0r2BZllzdNTAzHInNMv3ORUlpj5DswE4F5XtPWn+ddlBYFfu2h
         r4ujI6DrQYihnYCu25AXUNAu+79/nm5/EhLjx70PKLtTLQ8LWfpniIPQDoI27xl66/ro
         aTCXSUtGNtb65KZbhIZ15QljPerHQTUp9PIH5xlY26fvgtTnsWYg6wSO6bAQ1U/2KnaI
         DMhQ==
X-Gm-Message-State: AOJu0YxbJ7rJvZwTLOaXv/ezMMSe7UmR15XQfkdz1h09is2tFnL3tZOC
        xz6FwBzoPoqjZD5yq83oHg0T3m+uluPkyfagnwTgrzgG
X-Google-Smtp-Source: AGHT+IF2LToH/A1QAbt4T7ZaVoP3mNeXPGK6WvvsXS4vp1QFWMX7RtkbqQTNJW2OvbrbMjeLQWk7gQ==
X-Received: by 2002:a05:6512:31ca:b0:4f8:7325:bcd4 with SMTP id j10-20020a05651231ca00b004f87325bcd4mr3790171lfe.0.1692536995936;
        Sun, 20 Aug 2023 06:09:55 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id u22-20020ac25196000000b005007e7211f7sm149651lfi.21.2023.08.20.06.09.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 06:09:55 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b9a828c920so39348911fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 06:09:55 -0700 (PDT)
X-Received: by 2002:a2e:720e:0:b0:2bb:b56b:f67e with SMTP id
 n14-20020a2e720e000000b002bbb56bf67emr2359194ljc.19.1692536994754; Sun, 20
 Aug 2023 06:09:54 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Aug 2023 15:09:38 +0200
X-Gmail-Original-Message-ID: <CAHk-=whD0w46GUTwp_tyzjZRg8Nk-U2e3ucM7EntKPfn+iOSAw@mail.gmail.com>
Message-ID: <CAHk-=whD0w46GUTwp_tyzjZRg8Nk-U2e3ucM7EntKPfn+iOSAw@mail.gmail.com>
Subject: Linux 6.5-rc7
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

So it's Sunday afternoon, just not in the usual timezone where I do
these releases, since I've been traveling.

But apart from the timezone difference, everything looks entirely
normal. Drivers (GPU, networking and sound dominate - the usual
suspects, in other words) and architecture fixes. The latter are
mostly arm devicetree fixlets, but also some x86 cleanups and fallout
from the embargo last week.

Not a huge amount of patches, and I really get the feeling that a lot
of maintainers are on vacation. But I will be optimistic and also
blame it all being quiet on things working fairly well.

So I think this will be the last rc unless something nasty comes up.
Do keep testing,

             Linus

---

Abel Vesa (1):
      regulator: qcom-rpmh: Fix LDO 12 regulator for PM8550

Abel Wu (1):
      sock: Fix misuse of sk_under_memory_pressure()

Alex Deucher (1):
      Revert "Revert "drm/amdgpu/display: change pipe policy for DCN 2.0""

Alexander Stein (1):
      arm64: dts: imx93: Fix anatop node size

Alexandre Ghiti (1):
      riscv: uaccess: Return the number of bytes effectively not copied

Alfred Lee (1):
      net: dsa: mv88e6xxx: Wait for EEPROM done before HW reset

Allen Hubbe (2):
      pds_vdpa: reset to vdpa specified mac
      pds_vdpa: alloc irq vectors on DRIVER_OK

Anand Jain (1):
      btrfs: fix replace/scrub failure with metadata_uuid

Andrej Picej (1):
      ARM: dts: imx6: phytec: fix RTC interrupt level

Andrii Staikov (1):
      i40e: fix misleading debug logs

Andy Shevchenko (1):
      gpiolib: sysfs: Do unexport GPIO when user asks for it

Arnd Bergmann (1):
      asm-generic: partially revert "Unify uapi bitsperlong.h for
arm64, riscv and loongarch"

Artem Chernyshev (1):
      broadcom: b44: Use b44_writephy() return value

Asad Kamal (1):
      drm/amd/pm: Update pci link width for smu v13.0.6

Atul Raut (1):
      fbdev: amifb: Replace zero-length arrays with DECLARE_FLEX_ARRAY() he=
lper

Bard Liao (1):
      ASoC: max98363: don't return on success reading revision ID

Bartosz Golaszewski (1):
      gpiolib: fix reference leaks when removing GPIO chips still in use

Borislav Petkov (AMD) (4):
      x86/CPU/AMD: Fix the DIV(0) initial fix attempt
      x86/srso: Disable the mitigation on unaffected configurations
      x86/srso: Explain the untraining sequences a bit more
      x86/srso: Correct the mitigation status when SMT is disabled

Carlos Song (1):
      i2c: imx-lpi2c: return -EINVAL when i2c peripheral clk doesn't work

Celeste Liu (1):
      riscv: entry: set a0 =3D -ENOSYS only when syscall !=3D -1

Chen-Yu Tsai (1):
      media: mtk-jpeg: Set platform driver data earlier

Chengfeng Ye (1):
      i2c: bcm-iproc: Fix bcm_iproc_i2c_isr deadlock issue

Chengming Zhou (1):
      blk-mq: release scheduler resource when request completes

Chris Mason (1):
      btrfs: only subtract from len_to_oe_boundary when it is tracking an e=
xtent

Christopher Obbard (2):
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK Pi 4
      arm64: dts: rockchip: Disable HS400 for eMMC on ROCK 4C+

Cristian Ciocaltea (1):
      arm64: dts: rockchip: Drop invalid regulator-init-microvolt property

Dan Carpenter (2):
      i2c: sun6i-p2wi: Fix an error message in probe()
      accel/qaic: Clean up integer overflow checking in map_user_pages()

Daniel Baluta (1):
      ASoC: fsl: micfil: Use dual license micfil code

David Heidelberg (1):
      drm/panel: JDI LT070ME05000 simplify with dev_err_probe()

David Hildenbrand (4):
      virtio-mem: remove unsafe unplug in Big Block Mode (BBM)
      virtio-mem: convert most offline_and_remove_memory() errors to -EBUSY
      virtio-mem: keep retrying on offline_and_remove_memory() errors
in Sub Block Mode (SBM)
      virtio-mem: check if the config changed before fake offlining memory

Dmitry Baryshkov (1):
      arm64: dts: qcom: qrb5165-rb5: fix thermal zone conflict

Dragos Tatulea (5):
      vdpa: Enable strict validation for netlinks ops
      vdpa/mlx5: Correct default number of queues when MQ is on
      vdpa/mlx5: Fix mr->initialized semantics
      vdpa/mlx5: Fix crash on shutdown for when no ndev exists
      net/mlx5e: XDP, Fix fifo overrun on XDP_REDIRECT

Edward Cree (2):
      sfc: don't unregister flow_indr if it was never registered
      sfc: don't fail probe if MAE/TC setup fails

Eric Dumazet (1):
      net: do not allow gso_size to be set to GSO_BY_FRAGS

Eugenio P=C3=A9rez (1):
      vdpa/mlx5: Delete control vq iotlb in destroy_mr only when necessary

Fabio Estevam (3):
      ARM: dts: imx6sx: Remove LDB endpoint
      arm64: dts: imx8mm: Drop CSI1 PHY reference clock configuration
      media: imx: imx7-media-csi: Fix applying format constraints

Feng Liu (1):
      virtio-pci: Fix legacy device flag setting error in probe

Filipe Manana (1):
      btrfs: fix infinite directory reads

Florian Westphal (4):
      netfilter: nf_tables: fix false-positive lockdep splat
      netfilter: nf_tables: fix kdoc warnings after gc rework
      netfilter: nf_tables: deactivate catchall elements in next generation
      netfilter: nf_tables: don't fail inserts if duplicate has expired

Gal Pressman (1):
      virtio-vdpa: Fix cpumask memory leak in virtio_vdpa_find_vqs()

Guo Ren (2):
      riscv: stack: Fixup independent irq stack for CONFIG_FRAME_POINTER=3D=
n
      riscv: stack: Fixup independent softirq stack for CONFIG_FRAME_POINTE=
R=3Dn

G=C3=BCnther Noack (1):
      TIOCSTI: Document CAP_SYS_ADMIN behaviour in Kconfig

Hans de Goede (1):
      ASoC: lower "no backend DAIs enabled for ... Port" log severity

Harshit Mogalapalli (1):
      mmc: sunplus: Fix error handling in spmmc_drv_probe()

Hawkins Jiawei (1):
      virtio-net: Zero max_tx_vq field for VIRTIO_NET_CTRL_MQ_HASH_CONFIG c=
ase

Helge Deller (1):
      parisc: Fix CONFIG_TLB_PTLOCK to work with lightweight spinlock check=
s

Herbert Xu (1):
      xfrm: Silence warnings triggerable by bad packets

Jakub Kicinski (1):
      net: openvswitch: reject negative ifindex

James Zhu (1):
      drm/amdgpu: skip xcp drm device allocation when out of drm resource

Jani Nikula (3):
      drm/i915/sdvo: fix panel_type initialization
      drm/i915: fix display probe for IVB Q and IVB D GT2 server
      Revert "drm/edid: Fix csync detailed mode parsing"

Jason Wang (1):
      virtio-net: set queues after driver_ok

Jason Xing (1):
      net: fix the RTO timer retransmitting skb every 1ms if linear
option is enabled

Jeff Layton (1):
      sunrpc: set the bv_offset of first bvec in svc_tcp_sendmsg

Jerome Brunet (1):
      ASoC: meson: axg-tdm-formatter: fix channel slot allocation

Jiadong Zhu (1):
      drm/amdgpu: disable mcbp if parameter zero is set

Jiasheng Jiang (1):
      soc: aspeed: socinfo: Add kfree for kstrdup

Jiri Slaby (SUSE) (1):
      serial: 8250: drop lockdep annotation from serial8250_clear_IER()

Josef Bacik (1):
      btrfs: fix incorrect splitting in btrfs_drop_extent_map_range

Justin Chen (1):
      net: phy: broadcom: stub c45 read/write for 54810

Kailang Yang (1):
      ALSA: hda/realtek - Remodified 3k pull low procedure

Karol Herbst (1):
      drm/nouveau/disp: fix use-after-free in error handling of
nouveau_connector_create

Kenneth Feng (1):
      drm/amd/pm: disallow the fan setting if there is no fan on smu 13.0.0

Konrad Dybcio (1):
      arm64: dts: qcom: sc7180: Fix DSI0_PHY reg-names

Krzysztof Kozlowski (9):
      arm64: dts: qcom: sm8150: Fix OSM L3 interconnect cells
      arm64: dts: qcom: sm8250: Fix EPSS L3 interconnect cells
      arm64: dts: qcom: sc8180x: Fix OSM L3 compatible
      arm64: dts: qcom: sm8350: fix BAM DMA crash and reboot
      arm64: dts: rockchip: correct wifi interrupt flag in eaidk-610
      arm64: dts: rockchip: correct wifi interrupt flag in Rock Pi 4B
      arm64: dts: rockchip: correct wifi interrupt flag in Box Demo
      arm64: dts: rockchip: add missing space before { on indiedroid nova
      arm64: dts: rockchip: minor whitespace cleanup around '=3D'

Laurent Pinchart (1):
      media: uvcvideo: Fix menu count handling for userspace XU mappings

Leon Romanovsky (2):
      xfrm: delete offloaded policy
      xfrm: don't skip free of empty state in acquire policy

Li Zhijian (1):
      drivers/rnbd: restore sysfs interface to rnbd-client

Liang Chen (1):
      net: veth: Page pool creation error handling for existing pools only

Lijo Lazar (1):
      drm/amd/pm: Fix temperature unit of SMU v13.0.6

Lin Ma (8):
      net: xfrm: Fix xfrm_address_filter OOB read
      net: af_key: fix sadb_x_filter validation
      net: xfrm: Amend XFRMA_SEC_CTX nla_policy structure
      xfrm: add NULL check in xfrm_update_ae_params
      xfrm: add forgotten nla_policy for XFRMA_MTIMER_THRESH
      vdpa: Add features attr to vdpa_nl_policy for nlattr length check
      vdpa: Add queue index attr to vdpa_nl_policy for nlattr length check
      vdpa: Add max vqp attr to vdpa_nl_policy for nlattr length check

Lin Yujun (1):
      ARM: dts: integrator: fix PCI bus dtc warnings

Linus Torvalds (1):
      Linux 6.5-rc7

Luca Ceresoli (1):
      drm/panel: simple: Fix AUO G121EAN01 panel timings according to the d=
ocs

Manish Chopra (1):
      qede: fix firmware halt over suspend and resume

Marcin Szycik (1):
      ice: Block switchdev mode when ADQ is active and vice versa

Marek Vasut (1):
      arm64: dts: imx8mn: Drop CSI1 PHY reference clock configuration

Mario Limonciello (1):
      drm/amd: flush any delayed gfxoff on suspend entry

Mark Brown (2):
      arm64/ptrace: Ensure that SME is set up for target when writing SSVE =
state
      arm64/ptrace: Ensure that the task sees ZT writes on first use

Martin Fuzzey (1):
      regulator: da9063: better fix null deref with partial DT

Maxime Coquelin (1):
      vduse: Use proper spinlock for IRQ injection

Michael Walle (1):
      MAINTAINERS: add content regex for gpio-regmap

Michal Schmidt (4):
      octeon_ep: fix timeout value for waiting on mbox response
      octeon_ep: cancel tx_timeout_task later in remove sequence
      octeon_ep: cancel ctrl_mbox_task after intr_poll_task
      octeon_ep: cancel queued works in probe error path

Mike Christie (3):
      vhost-scsi: Fix alignment handling with windows
      vhost-scsi: Rename vhost_scsi_iov_to_sgl
      MAINTAINERS: add vhost-scsi entry and myself as a co-maintainer

Ming Lei (1):
      blk-cgroup: hold queue_lock when removing blkg->q_node

Mingzheng Xing (1):
      riscv: Handle zicsr/zifencei issue between gcc and binutils

Nam Cao (1):
      riscv: correct riscv_insn_is_c_jr() and riscv_insn_is_c_jalr()

Nathan Lynch (1):
      powerpc/rtas_flash: allow user copy to flash block cache objects

Naveen Kumar Goud Arepalli (1):
      arm64: dts: qcom: sa8775p-ride: Update L4C parameters

Ninad Naik (1):
      pinctrl: qcom: Add intr_target_width field to support increased
number of interrupt targets

Pablo Neira Ayuso (3):
      netfilter: nf_tables: fix GC transaction races with netns and
netlink event exit path
      netfilter: nf_tables: GC transaction race with netns dismantle
      netfilter: nft_dynset: disallow object maps

Parker Newman (1):
      i2c: tegra: Fix i2c-tegra DMA config option processing

Peter Ujfalusi (1):
      ASoC: SOF: ipc4-topology: Update the basecfg for copier earlier

Peter Zijlstra (11):
      x86/cpu: Fix __x86_return_thunk symbol type
      x86/cpu: Fix up srso_safe_ret() and __x86_return_thunk()
      objtool/x86: Fix SRSO mess
      x86/alternative: Make custom return thunk unconditional
      x86/cpu: Clean up SRSO return thunk mess
      x86/cpu: Rename original retbleed methods
      x86/cpu: Rename srso_(.*)_alias to srso_alias_\1
      x86/cpu: Cleanup the untrain mess
      x86/cpu/kvm: Provide UNTRAIN_RET_VM
      objtool/x86: Fixup frame-pointer vs rethunk
      x86/static_call: Fix __static_call_fixup()

Petr Machata (1):
      selftests: mirror_gre_changes: Tighten up the TTL test match

Petr Pavlu (2):
      x86/retpoline,kprobes: Fix position of thunk sections with
CONFIG_LTO_CLANG
      x86/retpoline,kprobes: Skip optprobe check for indirect jumps
with retpolines and IBT

Pierre-Louis Bossart (1):
      ASoC: Intel: sof-sdw: update jack detection quirk for LunarLake RVP

Piotr Gardocki (1):
      iavf: fix FDIR rule fields masks validation

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix slicing memory leak

Prasad Pandit (1):
      ipv6: fix indentation of a config attribute

Qingsong Chen (1):
      rust: macros: vtable: fix `HAS_*` redefinition (`gen_const_name`)

Quan Nguyen (1):
      i2c: designware: Correct length byte validation logic

Radhey Shyam Pandey (1):
      net: macb: In ZynqMP resume always configure PS GTR for non-wakeup so=
urce

Ranjani Sridharan (1):
      ASoC: SOF: intel: hda: Clean up link DMA for IPC3 during stop

Rob Herring (1):
      ARM: zynq: Explicitly include correct DT includes

Ruan Jinjie (1):
      fbdev: atmel_lcdfb: Remove redundant of_match_ptr()

Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Russell King (Oracle) (1):
      net: phy: fix IRQ-based wake-on-lan over hibernate / power off

Scott Mayhew (1):
      smb: client: fix null auth

Sean Christopherson (1):
      x86/retpoline: Don't clobber RFLAGS during srso_safe_ret()

Shannon Nelson (4):
      pds_vdpa: protect Makefile from unconfigured debugfs
      pds_vdpa: always allow offering VIRTIO_NET_F_MAC
      pds_vdpa: clean and reset vqs entries
      pds_vdpa: fix up debugfs feature bit printing

Shay Drory (1):
      net/mlx5: Fix mlx5_cmd_update_root_ft() error flow

Shazad Hussain (1):
      dt-bindings: pinctrl: qcom,sa8775p-tlmm: add gpio function constant

Shengyu Qu (2):
      ARM: dts: am335x-bone-common: Add GPIO PHY reset on revision C3 board
      ARM: dts: am335x-bone-common: Add vcc-supply for on-board eeprom

Sherry Sun (1):
      tty: serial: fsl_lpuart: Clear the error flags by writing 1 for
lpuart32 platforms

Shuming Fan (1):
      ASoC: rt1308-sdw: fix random louder sound

Simon Horman (1):
      mailmap: add entries for Simon Horman

Sishuai Gong (1):
      ipvs: fix racy memcpy in proc_do_sync_threshold

Stefan Binding (3):
      ALSA: hda/realtek: Add quirks for HP G11 Laptops
      ALSA: hda/realtek: Switch Dell Oasis models to use SPI
      ALSA: hda/cs8409: Support new Dell Dolphin Variants

Steve French (2):
      cifs: fix potential oops in cifs_oplock_break
      smb3: display network namespace in debug information

Sweet Tea Dorminy (1):
      blk-crypto: dynamically allocate fallback profile

Tam Nguyen (1):
      i2c: designware: Handle invalid SMBus block data response length valu=
e

Thierry Reding (1):
      i2c: tegra: Fix failure during probe deferral cleanup

Tim Huang (1):
      drm/amdgpu: skip fence GFX interrupts disable/enable for S0ix

Tony Lindgren (11):
      bus: ti-sysc: Flush posted write on enable before reset
      serial: core: Controller id cannot be negative
      serial: core: Fix serial core port id to not use port->line
      serial: core: Fix serial core controller port name to show controller=
 id
      serial: core: Fix serial_base_match() after fixing controller port na=
me
      MAINTAINERS: Merge TTY layer and serial drivers
      serial: core: Fix kmemleak issue for serial core device remove
      serial: 8250: Reinit port_id when adding back serial8250_isa_devs
      serial: 8250: Fix oops for port->pm on uart_change_pm()
      serial: core: Revert port_id use
      serial: core: Fix serial core port id, including multiport devices

Umio Yasuno (1):
      drm/amdgpu/pm: fix throttle_status for other than MP1 11.0.7

Uwe Kleine-K=C3=B6nig (2):
      fbdev: ssd1307fb: Print the PWM's label instead of its number
      i2c: Update documentation to use .probe() again

Vinay Belgaumkar (1):
      drm/i915/guc/slpc: Restore efficient freq earlier

Vlad Buslov (1):
      Revert "vlan: Fix VLAN 0 memory leak"

Wander Lairson Costa (1):
      drm/qxl: fix UAF on handle creation

Wei Chen (1):
      mmc: sunplus: fix return value check of mmc_add_host()

Wolfram Sang (1):
      virtio-mmio: don't break lifecycle of vm_dev

Xia Fukun (1):
      ASoC: SOF: Fix incorrect use of sizeof in sof_ipc3_do_rx_work()

Xiang Yang (1):
      net: pcs: Add missing put_device call in miic_create

Xiaolei Wang (2):
      ARM: dts: imx: Set default tuning step for imx7d usdhc
      ARM: dts: imx: Set default tuning step for imx6sx usdhc

Xin Long (1):
      netfilter: set default timeout to 3 secs for sctp shutdown send
and recv state

Yang Yingliang (1):
      mmc: wbsd: fix double mmc_free_host() in wbsd_init()

Yangtao Li (1):
      mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove

Yi Yang (1):
      tty: n_gsm: fix the UAF caused by race condition in gsm_cleanup_mux

Yibin Ding (1):
      mmc: block: Fix in_flight[issue_type] value error

Yicong Yang (1):
      i2c: hisi: Only handle the interrupt of the driver's transfer

Yogesh Hegde (1):
      arm64: dts: rockchip: Fix Wifi/Bluetooth on ROCK Pi 4 boards

Yuanjun Gong (1):
      fbdev: mmp: fix value check in mmphw_probe()

Yue Haibing (1):
      fbdev: kyro: Remove unused declarations

Zev Weiss (1):
      soc: aspeed: uart-routing: Use __sysfs_match_string

Zhang Shurong (1):
      ASoC: rt5665: add missed regulator_bulk_disable

Zhengchao Shao (3):
      xfrm: fix slab-use-after-free in decode_session6
      ip6_vti: fix slab-use-after-free in decode_session6
      ip_vti: fix potential slab-use-after-free in decode_session6

Zhu Wang (1):
      fbdev: goldfishfb: Do not check 0 for platform_get_irq()

Ziyang Xuan (1):
      team: Fix incorrect deletion of ETH_P_8021AD protocol vid from slaves

dengxiang (1):
      ALSA: usb-audio: Add support for Mythware XA001AU capture and
playback interfaces.

jairaj-arava (1):
      ASoC: Intel: sof-sdw-cs42142: fix for codec button mapping

xiaoshoukui (1):
      btrfs: fix BUG_ON condition in btrfs_cancel_balance
