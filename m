Return-Path: <linux-kernel+bounces-70586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A4785997B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1F11F21685
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DD173186;
	Sun, 18 Feb 2024 21:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VQ29gPae"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E66D1D689
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708290837; cv=none; b=HNmx0jstzulx+JV/7zCEQ7k0Ii6sOpLw8THdW9BTg7VpETS23hMtcY6epDvVP/b0S/kDlZI3y9zGWNthH89opBey0AcEY8w2FPC1yA+Jfz3glviabNx4GvgmJR1Z4t38TSgNQiS4dXFcs2OKQvl1LoK+PYr5lo062qpjnnrfvRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708290837; c=relaxed/simple;
	bh=S1qTtY2r0AG8NHcf/qwbJqxy5Ktyj8xa2Z+YS0punLI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=mVXbCt7Zi/4u7EnNwC5Q5idsCM3jz60QDbiMdVAmVROdINWh1H08GPqXwD8Ey1xPcfeGFa+5yOceIqgv59D8fMlxD9tJ9m5X3u7o7do1rGa6jGXh/XG2tOeRio+KfbqVoII51uq73cbF0tgTE1gk9jBEcUqhS9Xsls+M1F/N6F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VQ29gPae; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512a024851dso1798555e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 13:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708290832; x=1708895632; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tQn7TZclCYdvIujNQq6xtLLAHk2ZHXVY9Vy7WshYCJM=;
        b=VQ29gPaekVeGn/rv7Xnt5kp8gCQZ1hxLxgERcPhq3j1CAsWSc0hvtn3LYlRN+fTiWx
         aEGc3ZCRelleGq2woD8gkt95g19HhLGFgLfAJ82aWJQ4P6gmElAzVQIZZakbDXxqOiBr
         y96oTeZpy+exvpSWd+ll53UGXk1qoYn/S3JkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708290832; x=1708895632;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQn7TZclCYdvIujNQq6xtLLAHk2ZHXVY9Vy7WshYCJM=;
        b=U8Vzp7izcWO65z8wtQDvHMsJ2RqctZ7DxwW9j0itbJ6ie1Xktz/ceVXHpaxe6tkN0C
         ZwkIpcb6PNsLMTmAPEtI1NJDOibNMIHRdmSpiNB04WEO+CD+4FKcCRdbyotWncec/Cx0
         URwF94Pdt/kdqVMGcFtRK6eTqdIvQAr/9jc1H77d5FZj1MCTMzRrmVKEjUc2VSP9GRrK
         iWqro8Ohbx3RdtETvGjHzpgL5MtWH6DXsoPmqMEFfUfzZHyyyRqO4QL6cjFfc0rqzLSI
         9ic0u9B/deu8t/6ocIEmehYMO2iih22+MdBnP2RQpV8npidnxg/1ZWomees2+Elu9GXp
         D0uw==
X-Gm-Message-State: AOJu0YxMP3P/ZX9F857TfQ+QLdCDaaFqEwnyZMBieV9u37gWVnJGo9fN
	ZmvYQHAxylZ6ntgKpywdvFlXiDqIeXF275F882Nl2dh2pTi9f55MReCFcKwrb5vGZRLZXZkACIu
	j+Xk=
X-Google-Smtp-Source: AGHT+IEcYW1iu+LsdepdwqLfCIpkmBqzva1QVTr6LbCJYa+b6M0tO6lsR7IqqU8x7GEgarqnhtHzMA==
X-Received: by 2002:a05:6512:546:b0:512:ab58:3807 with SMTP id h6-20020a056512054600b00512ab583807mr1687108lfl.9.1708290832134;
        Sun, 18 Feb 2024 13:13:52 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id q12-20020a170906770c00b00a3df13a4fe0sm2305064ejm.15.2024.02.18.13.13.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 13:13:51 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5611e54a92dso4872968a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 13:13:51 -0800 (PST)
X-Received: by 2002:aa7:c708:0:b0:564:5b5f:6d82 with SMTP id
 i8-20020aa7c708000000b005645b5f6d82mr1176518edq.3.1708290830766; Sun, 18 Feb
 2024 13:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 18 Feb 2024 13:13:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
Message-ID: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
Subject: Linux 6.8-rc5
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ho humm..   Absolutely nothing stands out here, although I do wish
things should have calmed down a bit more at this point in the release
process.

But while there's a bit more changes here than I would have wished
for, there's not anything big or scary going on that I can see: just
small things all over. In fact, a fair chunk of the changes are in the
selftests, not kernel code itself (mainly kvm, but also some continued
work on the networking side). The documentation subdirectory also
stands out a bit, although that's at least partly due to Greg having
worked on the whole CVE process and documenting that.

The docs and selftests together account for about a quarter of the patch.

But of course, most of the changes are in drivers. Sound, network
drivers, and GPU driver fixes dominate the diffstat, but there's
really a bit of everything in there - we've got HID, i2c, PCI, SCSI,
staging, you name it.

Outside of drivers, we've got some filesystem fixes (btrfs, zonefs,
ceph, smb client, bcachefs) and some core networking updates. And
minor arch updates.

Anyway, I think (and hope) we'll start seeing things calm down, and
the next few rc's are smaller.

Please commence testing,

                 Linus

---

Aaron Conole (2):
      net: openvswitch: limit the number of recursions from action sets
      selftests: openvswitch: Add validation for the recursion test

Alex Williamson (1):
      PCI: Fix active state requirement in PME polling

Alexey Khoroshilov (1):
      ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Allison Henderson (1):
      net:rds: Fix possible deadlock in rds_message_put

Amadeusz S=C5=82awi=C5=84ski (1):
      ASoC: Intel: avs: Fix dynamic port assignment when TDM is set

Amir Goldstein (1):
      remap_range: merge do_clone_file_range() into vfs_clone_file_range()

Andrew Ballance (1):
      gen_compile_commands: fix invalid escape sequence warning

Andrew Jones (8):
      KVM: selftests: Remove redundant newlines
      KVM: selftests: aarch64: Remove redundant newlines
      KVM: selftests: riscv: Remove redundant newlines
      KVM: selftests: s390x: Remove redundant newlines
      KVM: selftests: x86_64: Remove redundant newlines
      RISC-V: paravirt: steal_time should be static
      RISC-V: paravirt: Use correct restricted types
      RISC-V: KVM: Use correct restricted types

Andr=C3=A9 Draszik (1):
      dt-bindings: don't anchor DT_SCHEMA_FILES to bindings directory

Andy Shevchenko (2):
      seq_buf: Don't use "proxy" headers
      seq_buf: Fix kernel documentation

Arnd Bergmann (10):
      powerpc: udbg_memcons: mark functions static
      powerpc: 85xx: mark local functions static
      nouveau/svm: fix kvcalloc() argument order
      ASoC: q6dsp: fix event handler prototype
      bnad: fix work_queue type mismatch
      ethernet: cpts: fix function pointer cast warnings
      nvmem: include bit index in cell sysfs file name
      i2c: pasemi: split driver into two separate modules
      drm/xe: avoid function cast warnings
      kallsyms: ignore ARMv4 thunks along with others

Arunpravin Paneer Selvam (1):
      drm/buddy: Fix alloc_range() error handling code

Attila T=C5=91k=C3=A9s (1):
      ASoC: amd: yc: Fix non-functional mic on Lenovo 82UU

Ben Wolsieffer (1):
      regmap: kunit: fix raw noinc write test wrapping

Bibo Mao (1):
      irqchip/loongson-eiointc: Use correct struct type in
eiointc_domain_alloc()

Breno Leitao (17):
      net: fill in MODULE_DESCRIPTION()s for xfrm
      net: fill in MODULE_DESCRIPTION()s for mpoa
      net: fill in MODULE_DESCRIPTION()s for af_key
      net: fill in MODULE_DESCRIPTION()s for 6LoWPAN
      net: fill in MODULE_DESCRIPTION()s for ipv6 modules
      net: fill in MODULE_DESCRIPTION()s for ipv4 modules
      net: fill in MODULE_DESCRIPTION()s for net/sched
      net: fill in MODULE_DESCRIPTION()s for ipvtap
      net: fill in MODULE_DESCRIPTION()s for dsa_loop_bdinfo
      net: sysfs: Fix /sys/class/net/<iface> path for statistics
      net: fill in MODULE_DESCRIPTION()s for xen-netback
      net: fill in MODULE_DESCRIPTION()s for ieee802154/fakelb
      net: fill in MODULE_DESCRIPTION()s for plip
      net: fill in MODULE_DESCRIPTION()s for fddik/skfp
      net: fill in MODULE_DESCRIPTION()s for ppp
      net: fill in MODULE_DESCRIPTION()s for mdio_devres
      net: fill in MODULE_DESCRIPTION()s for missing arcnet

Carlos Song (1):
      spi: imx: fix the burst length at DMA mode and CPU mode

Cezary Rojewski (1):
      ASoC: Intel: avs: Fix pci_probe() error path

Chaitanya Kulkarni (2):
      nvme-fabrics: fix I/O connect error handling
      nvmet: remove superfluous initialization

Charles Keepax (2):
      ASoC: cs42l43: Handle error from devm_pm_runtime_enable
      ASoC: cs42l43: Add system suspend ops to disable IRQ

Christian A. Ehrhardt (1):
      of: unittest: Fix compile in the non-dynamic case

Christian Brauner (1):
      fs: relax mount_setattr() permission checks

Christian Lamparter (1):
      spi: spi-ppc4xx: include missing platform_device.h

Chuck Lever (1):
      net/handshake: Fix handshake_req_destroy_test1

Cosmin Tanislav (2):
      iio: adc: ad4130: zero-initialize clock init data
      iio: adc: ad4130: only set GPIO_CTRL if pin is unused

Cristian Ciocaltea (1):
      ASoC: SOF: amd: Fix locking in ACP IRQ handler

Curtis Malainey (1):
      ASoC: SOF: IPC3: fix message bounds on ipc ops

Damien Le Moal (1):
      zonefs: Improve error handling

Dan Carpenter (8):
      iio: adc: ad7091r8: Fix error code in ad7091r8_gpio_setup()
      ASoC: cs35l56: fix reversed if statement in cs35l56_dspwait_asp1tx_pu=
t()
      serial: 8250_pci1xxxx: partially revert off by one patch
      wifi: iwlwifi: Fix some error codes
      wifi: iwlwifi: uninitialized variable in iwl_acpi_get_ppag_table()
      cifs: fix underflow in parse_server_interfaces()
      irqchip/qcom-mpm: Fix IS_ERR() vs NULL check in qcom_mpm_init()
      drm/amd/display: Fix && vs || typos

Daniel Bristot de Oliveira (6):
      tools/rtla: Fix Makefile compiler options for clang
      tools/rtla: Fix uninitialized bucket/data->bucket_size warning
      tools/rtla: Fix clang warning about mount_point var size
      tools/rtla: Remove unused sched_getattr() function
      tools/rv: Fix Makefile compiler options for clang
      tools/rv: Fix curr_reactor uninitialized variable

Daniel Gabay (1):
      wifi: iwlwifi: mvm: use correct address 3 in A-MSDU

Danilo Krummrich (2):
      drm/nouveau: don't fini scheduler if not initialized
      drm/nouveau: omit to create schedulers using the legacy uAPI

Dave Ertman (1):
      ice: Add check for lport extraction to LAG init

David Engraf (1):
      powerpc/cputable: Add missing PPC_FEATURE_BOOKE on PPC64 Book-E

David Gow (1):
      kunit: device: Unregister the kunit_bus on shutdown

David Schiller (1):
      staging: iio: ad5933: fix type mismatch regression

Dimitri Fedrau (1):
      iio: humidity: hdc3020: fix temperature offset

Dinghao Liu (1):
      iio: core: fix memleak in iio_device_register_sysfs

Dmitry Antipov (2):
      net: smc: fix spurious error message from __sock_release()
      net: sctp: fix skb leak in sctp_inq_free()

Dmitry Baryshkov (1):
      drm/msm/a6xx: set highest_bank_bit to 13 for a610

Doug Berger (1):
      irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Easwar Hariharan (1):
      arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata

Emmanuel Grumbach (1):
      wifi: iwlwifi: mvm: fix a crash when we run out of stations

Eniac Zhang (1):
      ALSA: hda/realtek: fix mute/micmute LED For HP mt645

Eric Dumazet (4):
      tcp: move tp->scaling_ratio to tcp_sock_read_txrx group
      tcp: move tp->tcp_usec_ts to tcp_sock_read_txrx group
      net-device: move lstats in net_device_read_txrx
      net: add rcu safety to rtnl_prop_list_size()

Even Xu (1):
      HID: Intel-ish-hid: Ishtp: Fix sensor reads after ACPI S3 suspend

Fangrui Song (1):
      arm64: jump_label: use constraints "Si" instead of "i"

Felix Fietkau (1):
      netfilter: nf_tables: fix bidirectional offload regression

Filipe Manana (7):
      btrfs: add and use helper to check if block group is used
      btrfs: do not delete unused block group if it may be used soon
      btrfs: add new unused block groups to the list of unused block groups
      btrfs: don't reserve space for checksums when writing to nocow files
      btrfs: reject encoded write if inode has nodatasum flag set
      btrfs: zoned: fix chunk map leak when loading block group zone info
      btrfs: don't refill whole delayed refs block reserve when
starting transaction

Florian Fainelli (1):
      net: bcmasp: Handle RX buffer allocation failure

Gaurav Batra (1):
      powerpc/pseries/iommu: Fix iommu initialisation during DLPAR add

Gavrilov Ilia (1):
      pppoe: Fix memory leak in pppoe_sendmsg()

Geliang Tang (2):
      mptcp: check addrs list in userspace_pm_get_local_id
      MAINTAINERS: update Geliang's email address

Gergo Koteles (1):
      ASoC: tas2781: add module parameter to tascodec_init()

Greg Kroah-Hartman (2):
      Revert "kobject: Remove redundant checks for whether ktype is NULL"
      Documentation: Document the Linux Kernel CVE process

Guenter Roeck (1):
      MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Hamza Mahfooz (1):
      drm/amdgpu: make damage clips support configurable

Hans de Goede (5):
      media: atomisp: Adjust for v4l2_subdev_state handling changes in 6.8
      ASoC: Intel: Boards: Fix NULL pointer deref in BYT/CHT boards
      ASoC: Intel: cht_bsw_rt5645: Cleanup codec_name handling
      ASoC: rt5645: Make LattePanda board DMI match more precise
      ASoC: rt5645: Add DMI quirk for inverted jack-detect on MeeGoPad T8

Harshit Mogalapalli (1):
      drm/rockchip: vop2: add a missing unlock in vop2_crtc_atomic_enable()

Hojin Nam (1):
      perf: CXL: fix mismatched cpmu event opcode

Horatiu Vultur (1):
      lan966x: Fix crash when adding interface under a lag

Hu Yadi (2):
      selftests/landlock: Fix net_test build with old libc
      selftests/landlock: Fix fs_test build with old libc

Ido Schimmel (5):
      selftests: net: Fix bridge backup port test flakiness
      selftests: forwarding: Fix layer 2 miss test flakiness
      selftests: forwarding: Fix bridge MDB test flakiness
      selftests: forwarding: Suppress grep warnings
      selftests: forwarding: Fix bridge locked port test flakiness

Ilkka Koskinen (1):
      perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1
(incorrect child count)

Ivan Vecera (3):
      i40e: Do not allow untrusted VF to remove administratively set MAC
      i40e: Fix waiting for queues of all VSIs to be disabled
      i40e: Fix wrong mask used during DCB config

Jacek Lawrynowicz (1):
      accel/ivpu: Fix DevTLB errors on suspend/resume and recovery

Jakub Kicinski (7):
      net: tls: factor out tls_*crypt_async_wait()
      tls: fix race between async notify and socket close
      tls: fix race between tx work scheduling and socket close
      net: tls: handle backlogging of crypto requests
      selftests: tls: use exact comparison in recv_partial
      net: tls: fix returned read length with async decrypt
      selftests: tls: increase the wait in poll_partial_rec_async

Jann Horn (1):
      lsm: fix integer overflow in lsm_set_self_attr() syscall

Jason Gerecke (1):
      HID: wacom: Do not register input devices until after hid_hw_start

Javier Carrasco (1):
      iio: move LIGHT_UVA and LIGHT_UVB to the end of iio_modifier

Jean Delvare (1):
      i2c: i801: Fix block process call transactions

Jean-Lo=C3=AFc Charroud (3):
      ALSA: hda/realtek: cs35l41: Add internal speaker support for
ASUS UM3402 with missing DSD
      ALSA: hda/realtek: cs35l41: Fix device ID / model name
      ALSA: hda/realtek: cs35l41: Fix order and duplicates in quirks table

Jeffrey Hugo (1):
      ASoC: dt-bindings: google,sc7280-herobrine: Drop bouncing @codeaurora

Jens Axboe (1):
      io_uring/net: fix multishot accept overflow handling

Jiangfeng Xiao (1):
      powerpc/kasan: Fix addr error caused by page alignment

Jiaxun Yang (3):
      ptrace: Introduce exception_ip arch hook
      MIPS: Clear Cause.BD in instruction_pointer_set
      mm/memory: Use exception ip to search exception tables

Jiri Pirko (2):
      dpll: fix possible deadlock during netlink dump operation
      net/mlx5: DPLL, Fix possible use after free after delayed work
timer triggers

Jiri Slaby (SUSE) (2):
      serial: core: introduce uart_port_tx_flags()
      serial: mxs-auart: fix tx

Johannes Berg (1):
      wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

John Kacur (1):
      tools/rtla: Exit with EXIT_SUCCESS when help is invoked

Jonathan Cameron (1):
      iio: humidity: hdc3020: Add Makefile, Kconfig and MAINTAINERS entry

Josef Bacik (1):
      btrfs: don't drop extent_map for free space inode on write error

Kees Cook (1):
      xen/gntalloc: Replace UAPI 1-element array

Keith Busch (1):
      nvme: implement support for relaxed effects

Kent Overstreet (5):
      bcachefs: Fix missing bch2_err_class() calls
      bcachefs: fix missing endiannes conversion in sb_members
      bcachefs: Clamp replicas_required to replicas
      bcachefs: Fix check_version_upgrade()
      bcachefs: Fix missing va_end()

Kent Russell (1):
      drm/amdkfd: Fix L2 cache size reporting in GFX9.4.3

Keqi Wang (1):
      connector/cn_proc: revert "connector: Fix
proc_event_num_listeners count not cleared"

Konrad Dybcio (2):
      interconnect: qcom: sc8180x: Mark CO0 BCM keepalive
      interconnect: qcom: sm8550: Enable sync_state

Krzysztof Kozlowski (3):
      gpiolib: add gpiod_to_gpio_device() stub for !GPIOLIB
      gpiolib: add gpio_device_get_base() stub for !GPIOLIB
      gpiolib: add gpio_device_get_label() stub for !GPIOLIB

Kuniyuki Iwashima (1):
      af_unix: Fix task hung while purging oob_skb in GC.

Kunwu Chan (2):
      x86/xen: Add some null pointer checking to smp.c
      igb: Fix string truncation warnings in igb_set_fw_version

Kyle Swenson (1):
      netfilter: nat: restore default DNAT behavior

Lee Duncan (2):
      scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
      scsi: fnic: Move fnic_fnic_flush_tx() to a work queue

Linus Torvalds (2):
      update workarounds for gcc "asm goto" issue
      Linux 6.8-rc5

Lukas Bulwahn (1):
      ALSA: hda/cs35l56: select intended config FW_CS_DSP

Maciej Fijalkowski (2):
      i40e: avoid double calling i40e_pf_rxq_wait()
      i40e: take into account XDP Tx queues when stopping rings

Magnus Karlsson (1):
      bonding: do not report NETDEV_XDP_ACT_XSK_ZEROCOPY

Manasi Navare (1):
      drm/i915/dsc: Fix the macro that calculates DSCC_/DSCA_ PPS reg addre=
ss

Manuel Fombuena (1):
      HID: multitouch: Add required quirk for Synaptics 0xcddc device

Marc Zyngier (3):
      irqchip/gic-v3-its: Handle non-coherent GICv4 redistributors
      irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems
      irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Mario Limonciello (4):
      iio: accel: bma400: Fix a compilation problem
      ASoC: amd: yc: Add DMI quirk for Lenovo Ideapad Pro 5 16ARP8
      drm/amd: Stop evicting resources on APUs in suspend
      Revert "drm/amd: flush any delayed gfxoff on suspend entry"

Mark Brown (3):
      arm64/signal: Don't assume that TIF_SVE means we saved SVE state
      regmap: kunit: Ensure that changed bytes are actually different
      arm64/sve: Lower the maximum allocation for the SVE ptrace regset

Markus Elfring (1):
      xen/privcmd: Use memdup_array_user() in alloc_ioreq()

Masahiro Yamada (2):
      KVM: arm64: Do not source virt/lib/Kconfig twice
      kbuild: use 4-space indentation when followed by conditionals

Masami Hiramatsu (Google) (1):
      tracing/probes: Fix to search structure fields correctly

Mathias Krause (1):
      KVM: x86: Fix KVM_GET_MSRS stack info leak

Matthew Auld (2):
      drm/tests/drm_buddy: add alloc_contiguous test
      drm/xe/display: fix i915_gem_object_is_shmem() wrapper

Matthias Schiffer (1):
      powerpc/6xx: set High BAT Enable flag on G2_LE cores

Maxim Galaganov (1):
      selftests: net: ip_local_port_range: define IPPROTO_MPTCP

Maxime Jayat (1):
      can: netlink: Fix TDCO calculation using the old data bittiming

Maximilian Heyne (1):
      xen/events: close evtchn after mapping cleanup

Michael Ellerman (2):
      Revert "powerpc/pseries/iommu: Fix iommu initialisation during DLPAR =
add"
      powerpc/kasan: Limit KASAN thread size increase to 32KB

Micka=C3=ABl Sala=C3=BCn (1):
      selftests/landlock: Fix capability for net_test

Mika Westerberg (1):
      spi: intel-pci: Add support for Lunar Lake-M SPI serial flash

Mike Christie (1):
      scsi: target: Fix unmap setup during configuration

Mike Tipton (2):
      interconnect: qcom: sm8650: Use correct ACV enable_mask
      interconnect: qcom: x1e80100: Add missing ACV enable_mask

Mingwei Zhang (1):
      KVM: x86/pmu: Fix type length error when reading pmu->fixed_ctr_ctrl

Miri Korenblit (1):
      wifi: iwlwifi: clear link_id in time_event

Mohammad Rahimi (1):
      thunderbolt: Fix setting the CNS bit in ROUTER_CS_5

Nathan Chancellor (1):
      kbuild: Fix changing ELF file type for output of gen_btf for big endi=
an

Nathan Lynch (1):
      powerpc/pseries/papr-sysparm: use u8 arrays for payloads

Naveen N Rao (2):
      powerpc/64: Set task pt_regs->link to the LR value on scv entry
      powerpc/ftrace: Ignore ftrace locations in exit text sections

Nicholas Kazlauskas (1):
      drm/amd/display: Increase ips2_eval delay for DCN35

Nuno Sa (4):
      iio: imu: adis: ensure proper DMA alignment
      iio: adc: ad_sigma_delta: ensure proper DMA alignment
      of: property: fix typo in io-channels
      iio: commom: st_sensors: ensure proper DMA alignment

N=C3=ADcolas F. R. A. Prado (1):
      kselftest: dt: Stop relying on dirname to improve performance

Oleksandr Natalenko (1):
      HID: logitech-hidpp: Do not flood kernel log

Oleksij Rempel (1):
      can: j1939: Fix UAF in j1939_sk_match_filter during
setsockopt(SO_J1939_FILTER)

Pablo Neira Ayuso (1):
      netfilter: nft_set_pipapo: fix missing : in kdoc

Paolo Abeni (10):
      selftests: net: add more missing kernel config
      mptcp: drop the push_pending field
      mptcp: fix rcv space initialization
      mptcp: fix more tx path fields initialization
      mptcp: corner case locking for rx path fields initialization
      mptcp: really cope with fastopen race
      selftests: net: cope with slow env in gro.sh test
      selftests: net: cope with slow env in so_txtime.sh test
      selftests: net: more strict check in net_helper
      selftests: net: more pmtu.sh fixes

Parav Pandit (1):
      devlink: Fix command annotation documentation

Paul Barker (1):
      net: ravb: Count packets instead of descriptors in GbEth RX path

Paulo Alcantara (2):
      smb: client: set correct id, uid and cruid for multiuser automounts
      smb: client: handle path separator of created SMB symlinks

Peter Ujfalusi (3):
      ASoC: SOF: Intel: pci-tgl: Change the default paths and firmware name=
s
      ASoC: SOF: Intel: pci-lnl: Change the topology path to intel/sof-ipc4=
-tplg
      ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspen=
d

Petr Pavlu (1):
      tracing: Fix HAVE_DYNAMIC_FTRACE_WITH_REGS ifdef

Philip Yang (1):
      drm/prime: Support page array >=3D 4GB

Prasad Pandit (1):
      KVM: x86: make KVM_REQ_NMI request iff NMI pending for vcpu

R Nageswara Sastry (1):
      selftests/powerpc/papr_vpd: Check devfd before get_system_loc_code()

Radek Krejci (1):
      modpost: trim leading spaces when processing source files list

Radhey Shyam Pandey (1):
      dt-bindings: xilinx: replace Piyush Mehta maintainership

Rajneesh Bhardwaj (2):
      drm/amdkfd: update SIMD distribution algo for GFXIP 9.4.2 onwards
      drm/amdgpu: Fix implicit assumtion in gfx11 debug flags

Ralf Schlatterbeck (1):
      spi-mxs: Fix chipselect glitch

Randy Dunlap (2):
      iio: imu: bno055: serdev requires REGMAP
      net: ti: icssg-prueth: add dependency for PTP

Ranjani Sridharan (1):
      ASoC: SOF: ipc3-topology: Fix pipeline tear down logic

Ricardo B. Marliere (2):
      xen: pcpu: make xen_pcpu_subsys const
      xen: balloon: make balloon_subsys const

Richard Fitzgerald (3):
      ASoC: cs35l56: Fix deadlock in ASP1 mixer register initialization
      ASoC: cs35l56: Remove default from IRQ1_CFG register
      ASoC: cs35l56: Workaround for ACPI with broken spk-id-gpios property

Rob Clark (4):
      drm/msm/gem: Fix double resv lock aquire
      Revert "drm/msm/gpu: Push gpu lock down past runpm"
      drm/crtc: fix uninitialized variable use even harder
      drm/msm: Wire up tlb ops

Rob Herring (4):
      dt-bindings: display: nxp,tda998x: Fix 'audio-ports' constraints
      dt-bindings: tpm: Drop type from "resets"
      net: marvell,prestera: Fix example PCI bus addressing
      dt-bindings: ufs: samsung,exynos-ufs: Add size constraints on
"samsung,sysreg"

Roman Li (1):
      drm/amd/display: Fix array-index-out-of-bounds in dcn35_clkmgr

Sabrina Dubroca (1):
      net: tls: fix use-after-free with partial reads and async decrypt

Sam Protsenko (1):
      iio: pressure: bmp280: Add missing bmp085 to SPI id table

Saravana Kannan (6):
      driver core: Fix device_link_flag_is_sync_state_only()
      driver core: fw_devlink: Improve detection of overlapping cycles
      driver core: fw_devlink: Improve logs for cycle detection
      of: property: Improve finding the consumer of a remote-endpoint prope=
rty
      of: property: Improve finding the supplier of a remote-endpoint prope=
rty
      of: property: Add in-ports/out-ports support to of_graph_get_port_par=
ent()

Sasha Neftin (1):
      igc: Remove temporary workaround

Sean Christopherson (4):
      KVM: selftests: Reword the NX hugepage test's skip message to be
more helpful
      KVM: selftests: Delete superfluous, unused "stage" variable in AMX te=
st
      KVM: selftests: Fix a semaphore imbalance in the dirty ring logging t=
est
      KVM: selftests: Don't assert on exact number of 4KiB in dirty
log split test

Sean Young (2):
      media: rc: bpf attach/detach requires write permission
      media: pwm-ir-tx: Depend on CONFIG_HIGH_RES_TIMERS

Sebastian Ene (1):
      KVM: arm64: Fix circular locking dependency

SeongJae Park (1):
      xen/xenbus: document will_handle argument for xenbus_watch_path()

Seongsu Park (1):
      arm64: fix typo in comments

Shannon Nelson (2):
      ionic: minimal work with 0 budget
      pds_core: no health-thread in VF path

Shivaprasad G Bhat (1):
      powerpc/iommu: Fix the missing iommu_group_put() during platform
domain attach

Shrikanth Hegde (1):
      powerpc/pseries: fix accuracy of stolen time

Shuming Fan (1):
      ALSA: hda/realtek: add IDs for Dell dual spk platform

Shyam Prasad N (1):
      cifs: update the same create_guid on replay

Siddharth Vadapalli (1):
      MAINTAINERS: Add Siddharth Vadapalli as PCI TI DRA7XX/J721E reviewer

Simon Horman (1):
      net: stmmac: xgmac: use #define for string constants

Sohaib Nadeem (2):
      Revert "drm/amd/display: increased min_dcfclk_mhz and min_fclk_mhz"
      drm/amd/display: fixed integer types and null check locations

Srinivas Pandruvada (1):
      iio: hid-sensor-als: Return 0 for HID_USAGE_SENSOR_TIME_TIMESTAMP

Srinivasan Shanmugam (5):
      drm/amd/display: Initialize 'wait_time_microsec' variable in
link_dp_training_dpia.c
      drm/amd/display: Fix possible use of uninitialized
'max_chunks_fbc_mode' in 'calculate_bandwidth()'
      drm/amd/display: Fix possible buffer overflow in
'find_dcfclk_for_voltage()'
      drm/amd/display: Fix possible NULL dereference on device
remove/driver unload
      drm/amdgpu/display: Initialize gamma correction mode variable in
dcn30_get_gamcor_current()

Steve French (1):
      smb: Fix regression in writes when non-standard maximum write
size negotiated

Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mappe=
d.

Steven Rostedt (Google) (1):
      tracing: Inform kmemleak of saved_cmdlines allocation

Su Yue (1):
      bcachefs: fix kmemleak in __bch2_read_super error handling path

Subbaraya Sundeep (1):
      octeontx2-af: Remove the PF_FUNC validation for NPC transmit rules

Sven Schnelle (1):
      tracing: Use ring_buffer_record_is_set_on() in tracer_tracing_is_on()

Takashi Iwai (1):
      ALSA: usb-audio: More relaxed check of MIDI jack names

Tatsunosuke Tobita (1):
      HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Tejun Heo (1):
      Revert "workqueue: Override implicit ordered attribute in
workqueue_apply_unbound_cpumask()"

Thinh Nguyen (1):
      Revert "usb: dwc3: Support EBC feature of DWC_usb31"

Thomas Hellstr=C3=B6m (2):
      drm/xe/vm: Avoid reserving zero fences
      drm/xe/pt: Allow for stricter type- and range checking

Thong (1):
      drm/amdgpu/soc21: update VCN 4 max HEVC encoding resolution

Thorsten Blum (2):
      docs: kconfig: Fix grammar and formatting
      tracing/synthetic: Fix trace_string() return value

Tom Chung (1):
      drm/amd/display: Preserve original aspect ratio in create stream

Tomasz Kudela (1):
      ALSA: hda: Add Lenovo Legion 7i gen7 sound quirk

Tomi Valkeinen (2):
      media: Revert "media: rkisp1: Drop IRQF_SHARED"
      media: rkisp1: Fix IRQ handling due to shared interrupts

Uwe Kleine-K=C3=B6nig (3):
      spi: ppc4xx: Fix fallout from include cleanup
      spi: ppc4xx: Fix fallout from rename in struct spi_bitbang
      spi: ppc4xx: Drop write-only variable

Vadim Fedorenko (1):
      net-timestamp: make sk_tskey more predictable in error path

Vaishnav Achath (1):
      spi: omap2-mcspi: Revert FIFO support without DMA

Vegard Nossum (1):
      docs: kernel_feat.py: fix build error for missing files

Victor Nogueira (1):
      net/sched: act_mirred: Don't zero blockid when net device is being de=
leted

Viken Dadhaniya (1):
      i2c: qcom-geni: Correct I2C TRE sequence

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915/dp: Limit SST link rate to <=3D8.1Gbps

Vincent Guittot (1):
      topology: Set capacity_freq_ref in all cases

Vitaly Kuznetsov (7):
      KVM: selftests: Avoid infinite loop in hyperv_features when
invtsc is missing
      KVM: selftests: Fail tests when open() fails with !ENOENT
      KVM: selftests: Generalize check_clocksource() from kvm_clock_test
      KVM: selftests: Use generic sys_clocksource_is_tsc() in
vmx_nested_tsc_scaling_test
      KVM: selftests: Run clocksource dependent tests with
hyperv_clocksource_tsc_page too
      KVM: selftests: Make hyperv_clock require TSC based system clocksourc=
e
      KVM: x86: Make gtod_is_based_on_tsc() return 'bool'

Will Deacon (1):
      KVM: arm64: Fix double-free following kvm_pgtable_stage2_free_unlinke=
d()

Xiubo Li (2):
      ceph: always queue a writeback when revoking the Fb caps
      ceph: add ceph_cap_unlink_work to fire check_caps() immediately

Zhikai Zhai (1):
      drm/amd/display: Add align done check

Zhipeng Lu (1):
      media: ir_toy: fix a memleak in irtoy_tx

Ziqi Zhao (1):
      can: j1939: prevent deadlock by changing j1939_socks_lock to rwlock

bo liu (1):
      ALSA: hda/conexant: Add quirk for SWS JS201D

limingming3 (1):
      tools/rtla: Replace setting prio with nice for SCHED_OTHER

zhili.liu (1):
      iio: magnetometer: rm3100: add boundary check for the value read
from RM3100_REG_TMRC

