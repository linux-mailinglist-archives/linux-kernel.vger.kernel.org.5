Return-Path: <linux-kernel+bounces-98335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F76887788E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:07:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CCBE1C20F30
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9463A1DE;
	Sun, 10 Mar 2024 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dmez4LLR"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50771170B
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 21:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710104820; cv=none; b=P+8TJYLQOiIbsR3E4xt9zpB4NTTG7NNl2tX8F9/qtGzRABtWdGxPszviftSDX3SJM8jxAMAi0WQru+wgEPryj3C2PpBXzqmZ3UWhB4wPGgF5fTwEjeeutNSlWq3X1iaTdsp4jpAGX796U+96jyJi6PuI18KRUOECZqW1zSPqK7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710104820; c=relaxed/simple;
	bh=qeWE3bqfRj1GmyLC6eC/3q0xNQb/UZr4WyC+skyDb8I=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fWhUXhm+gBJVpo1vi9/84GYzVz/oRegJ04YXDMIhNLJf7wx9kJt47MoGCn7K0s7/t8PInL6CKjG4ryyeuZ5YuxSGjgervUJcvzvHIDNC4XGVUyeZZawV4TqvjrpBIzSQSx80IcSfOzB1qaxLKPMK8gY+FKBp7lxwLROJwliscUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dmez4LLR; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso3239483e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710104816; x=1710709616; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gkw++whZHuAmU1j0v3Tw2QVd9GlwzifwTCz0oG4YeoI=;
        b=dmez4LLRL94BHwnp6mcgKqTFrYAwYM+aFGesp4McXBX56vTgOu5+oAz3EdkHbGTNx+
         rsKtp3q0m30/V5Xbi8f67oRcT3hiLmRPeTQZjl/Crt/0AHhVlg+mZngnzUjovkE6S0Wz
         kAid7VUz2khu+cnzLHhDm4TfC5NNWuJt3YASE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710104816; x=1710709616;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkw++whZHuAmU1j0v3Tw2QVd9GlwzifwTCz0oG4YeoI=;
        b=H0UTSWsy5ca7bTrCU2xalNlyJ0dGVKwBtLZdoiZCDOqdsJ8IRpzmmaAej0y9coMDtu
         G6+USsnTqJ4G0u3r/szsO7v+xZH6q/GtRiBMyGEuglOKN405SU6LBxW3m5nlbJvqed3A
         7jcfiKkF2p7c8zmecDBw3YSFNuudOL2GiKtxeXxORAfPxvLPxmez2QCteLjHjpOjJuUh
         biwYgQOWe6IBsMFwBpnQi4GOj0og7+OxglrZb+q42fN0aCmu6BbtFB7A9oQB7PO7kh1o
         kxWqEVGCbBJVN+uGEBbopgXJvHFB4Sq3nUWdQJ13+d7WroEhtU8tEkJqsZzNvAIZ/s/g
         pHCQ==
X-Gm-Message-State: AOJu0YxSCVozVeZ9JKn+Nmu7lhElW2hBr4UzDYnAEnfsoX8c1BpdQWFL
	HR9xCx8HuAIW9Hrwa1+oRUrtiZ1yCu5dAAiRqB+IpZao09/kkaJHwRaKcZB5DDwISG1Cef05kNN
	f
X-Google-Smtp-Source: AGHT+IFFpN7DQ7f8QxaBMjxJ0jKOamwcLqT0hm28hDrWySEc1PvvQ6NPbsKO9jvZEc1Wtl4dRLiRwg==
X-Received: by 2002:a05:6512:1183:b0:513:2617:54b7 with SMTP id g3-20020a056512118300b00513261754b7mr2802621lfr.49.1710104815382;
        Sun, 10 Mar 2024 14:06:55 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id x23-20020ac24897000000b005132f8547cdsm806358lfc.19.2024.03.10.14.06.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 14:06:54 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2505352e6so54192871fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 14:06:54 -0700 (PDT)
X-Received: by 2002:ac2:4357:0:b0:513:2508:7b2a with SMTP id
 o23-20020ac24357000000b0051325087b2amr2576828lfl.65.1710104813761; Sun, 10
 Mar 2024 14:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 10 Mar 2024 14:06:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiehc0DfPtL6fC2=bFuyzkTnuiuYSQrr6JTQxQao6pq1Q@mail.gmail.com>
Message-ID: <CAHk-=wiehc0DfPtL6fC2=bFuyzkTnuiuYSQrr6JTQxQao6pq1Q@mail.gmail.com>
Subject: Linux 6.8
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So it took a bit longer for the commit counts to come down this
release than I tend to prefer, but a lot of that seemed to be about
various selftest updates (networking in particular) rather than any
actual real sign of problems. And the last two weeks have been pretty
quiet, so I feel there's no real reason to delay 6.8.  We always have
some straggling work, and we'll end up having some of it pushed to
stable rather than hold up the new code. Nothing worrisome enough to
keep the regular release schedule from happening.

As usual, the shortlog below is just for the last week since rc7, the
overall changes in 6.8 are obviously much much bigger. This is not the
historically big release that 6.7 was - we seem to be back to a fairly
average release size for the last few years. You can see it in the
overall diffstats too - this looks like an average release in pretty
much all respects, and we don't have (for example) any obvious big new
filesystems or architectures. I think the biggest single new thing in
6.8 is probably the new Xe drm driver, but honestly, the big bulk of
changes are just various random updates and fixes all over.

Just as it should be.

In a sea of normality, one thing that stands out is a bit of random
git numerology.  This is the last mainline kernel to have less than
ten million git objects. In fact, we're at 9.996 million objects, so
we got really close to crossing that not-milestone if it hadn't been
for the nice calming down in the last couple of weeks. Other trees -
notably linux-next - obviously are already comfortably over that
limit.

Of course, there is absolutely nothing special about it apart from a
nice round number.  Git doesn't care.

Anyway, this all obviously means that tomorrow the merge window for
6.9 opens, and I already have several pull requests pending. Thanks to
everybody who sent in early pull requests, you know who you are. But
before that excitement commences, please do spend a bit of time with
the now boring old status quo and give 6.8 a good test, ok?

              Linus

---

Al Raj Hassain (1):
      ASoC: amd: yc: Add HP Pavilion Aero Laptop 13-be2xxx(8BD6) into
DMI quirk table

Alan Stern (1):
      USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command

Alban Boy=C3=A9 (1):
      ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 table=
t

Alex Deucher (1):
      drm/amd/display: handle range offsets in VRR ranges

Alexander Usyskin (3):
      mei: me: add arrow lake point S DID
      mei: me: add arrow lake point H DID
      mei: gsc_proxy: match component when GSC is on different bus

Andreas Pape (1):
      ASoC: rcar: adg: correct TIMSEL setting for SSI9

Andrew Ballance (1):
      scripts/gdb/symbols: fix invalid escape sequence warning

Andrey Skvortsov (1):
      crypto: sun8i-ce - Fix use after free in unprepare

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for HP EliteBook

Animesh Manna (1):
      drm/i915/panelreplay: Move out psr_init_dpcd() from init_connector()

Antonio Borneo (1):
      pinctrl: stm32: fix PM support for stm32mp257

Arnd Bergmann (1):
      net: bql: fix building with BQL disabled

Aya Levin (1):
      net/mlx5: Fix fw reporter diagnose output

Badhri Jagan Sridharan (1):
      usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices

Bart Van Assche (2):
      Revert "fs/aio: Make io_cancel() generate completions again"
      fs/aio: Check IOCB_AIO_RW before the struct aio_kiocb conversion

Bartosz Golaszewski (1):
      pinctrl: don't put the reference to GPIO device in pinctrl_pins_show(=
)

Charles Keepax (1):
      spi: cs42l43: Don't limit native CS to the first chip select

Christophe JAILLET (1):
      i2c: wmt: Fix an error handling path in wmt_i2c_probe()

Coiby Xu (1):
      integrity: eliminate unnecessary "Problem loading X.509 certificate" =
msg

Cong Yang (1):
      drm/panel: boe-tv101wum-nl6: Fine tune Himax83102-j02 panel HFP
and HBP (again)

Cosmin Tanislav (2):
      iio: accel: adxl367: fix DEVID read after reset
      iio: accel: adxl367: fix I2C FIFO data register

Daniel Baluta (1):
      MAINTAINERS: Use a proper mailinglist for NXP i.MX development

Daniel Borkmann (2):
      xdp, bonding: Fix feature flags when there are no slave devs anymore
      selftests/bpf: Fix up xdp bonding test wrt feature flags

Dave Airlie (1):
      nouveau: lock the client object tree.

Dawei Li (1):
      firmware: microchip: Fix over-requested allocation size

Dmitry Baryshkov (1):
      Revert "arm64: dts: qcom: msm8996: Hook up MPM"

Douglas Anderson (3):
      Revert "tty: serial: simplify qcom_geni_serial_send_chunk_fifo()"
      drm/udl: Add ARGB8888 as a format
      Revert "drm/udl: Add ARGB8888 as a format"

Edmund Raile (1):
      firewire: ohci: prevent leak of left-over IRQ on unbind

Eduard Zingerman (2):
      bpf: check bpf_func_state->callback_depth when pruning states
      selftests/bpf: test case for callback_depth states pruning logic

Edward Adam Davis (1):
      net/rds: fix WARNING in rds_conn_connect_if_down

Ekansh Gupta (1):
      misc: fastrpc: Pass proper arguments to scm call

Emeel Hakim (1):
      net/mlx5e: Fix MACsec state loss upon state update in offload path

Emil Tantilov (1):
      idpf: disable local BH when scheduling napi for marker packets

Eric Dumazet (2):
      geneve: make sure to pull inner header in geneve_rx()
      net/ipv6: avoid possible UAF in ip6_route_mpath_notify()

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Restore CONFIG_BACKLIGHT_CLASS_DEVICE

Florian Kauer (1):
      igc: avoid returning frame twice in XDP_REDIRECT

Florian Westphal (1):
      netfilter: nft_ct: fix l3num expectations with inet pseudo family

Francesco Dolcini (1):
      ARM: dts: imx7: remove DSI port endpoints

Frej Drejhammar (1):
      comedi: comedi_8255: Correct error in subdevice initialization

Gao Xiang (2):
      erofs: fix uninitialized page cache reported by KMSAN
      erofs: apply proper VMA alignment for memory mapped files on THP

Gavin Li (1):
      Revert "net/mlx5: Block entering switchdev mode with ns inconsistency=
"

Geliang Tang (1):
      selftests: mptcp: diag: return KSFT_FAIL not test_cnt

Guillaume Nault (1):
      xfrm: Clear low order bits of ->flowi4_tos in decode_session4().

Hans de Goede (2):
      misc: lis3lv02d_i2c: Fix regulators getting en-/dis-abled twice
on suspend/resume
      platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR

Harshit Mogalapalli (1):
      platform/x86/amd/pmf: Fix missing error code in amd_pmf_init_smart_pc=
()

Heiner Kallweit (2):
      i2c: i801: Fix using mux_pdev before it's set
      i2c: i801: Avoid potential double call to gpiod_remove_lookup_table

Herbert Xu (1):
      crypto: rk3288 - Fix use after free in unprepare

Horatiu Vultur (1):
      net: sparx5: Fix use after free inside sparx5_del_mact_entry

Ian Abbott (1):
      comedi: comedi_test: Prevent timers rescheduling during deletion

Imre Deak (2):
      drm: Fix output poll work for drm_kms_helper_poll=3Dn
      drm/i915/dp: Fix connector DSC HW state readout

Ivan Vecera (1):
      i40e: Fix firmware version comparison function

Jacob Keller (1):
      ice: virtchnl: stop pretending to support RSS over AQ or registers

Jakub Kicinski (2):
      page_pool: fix netlink dump stop/resume
      dpll: move all dpll<>netdev helpers to dpll code

Janusz Krzysztofik (1):
      drm/i915/selftests: Fix dependency of some timeouts on HZ

Jason Xing (12):
      netrom: Fix a data-race around sysctl_netrom_default_path_quality
      netrom: Fix a data-race around
sysctl_netrom_obsolescence_count_initialiser
      netrom: Fix data-races around sysctl_netrom_network_ttl_initialiser
      netrom: Fix a data-race around sysctl_netrom_transport_timeout
      netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
      netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_de=
lay
      netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
      netrom: Fix a data-race around
sysctl_netrom_transport_requested_window_size
      netrom: Fix a data-race around sysctl_netrom_transport_no_activity_ti=
meout
      netrom: Fix a data-race around sysctl_netrom_routing_control
      netrom: Fix a data-race around sysctl_netrom_link_fails_count
      netrom: Fix data-races around sysctl_net_busy_read

Javier Carrasco (1):
      Revert "Input: bcm5974 - check endpoint type before starting traffic"

Jean-Baptiste Maneyrol (2):
      iio: imu: inv_mpu6050: fix FIFO parsing when empty
      iio: imu: inv_mpu6050: fix frequency setting when chip is off

Jernej Skrabec (1):
      arm64: dts: allwinner: h616: Add Orange Pi Zero 2W to Makefile

Jesse Brandeburg (1):
      ice: fix typo in assignment

Jianbo Liu (2):
      net/mlx5: E-switch, Change flow rule destination checking
      net/mlx5e: Change the warning when ignore_flow_level is not supported

Johan Hovold (4):
      arm64: dts: qcom: sc8280xp-crd: limit pcie4 link speed
      arm64: dts: qcom: sc8280xp-x13s: limit pcie4 link speed
      phy: qcom-qmp-combo: fix drm bridge registration
      phy: qcom-qmp-combo: fix type-c switch registration

Jon Hunter (1):
      arm64: tegra: Fix Tegra234 MGBE power-domains

Kailang Yang (2):
      ALSA: hda/realtek - Fix headset Mic no show at resume back for
Lenovo ALC897 platform
      ALSA: hda/realtek - Add Headset Mic supported Acer NB platform

Kamalesh Babulal (1):
      cgroup/cpuset: Fix retval in update_cpumask()

Karol Herbst (1):
      drm/nouveau: fix stale locked mutex in nouveau_gem_ioctl_pushbuf

Kees Cook (2):
      iio: pressure: dlhl60d: Initialize empty DLH bytes
      init/Kconfig: lower GCC version check for -Warray-bounds

Konrad Dybcio (1):
      arm64: dts: qcom: sm6115: Fix missing interconnect-names

Krishna Kurapati (1):
      usb: gadget: ncm: Fix handling of zero block length packets

Lena Wang (1):
      netfilter: nf_conntrack_h323: Add protection for bmp length out of ra=
nge

Leon Romanovsky (1):
      xfrm: Pass UDP encapsulation in TX packet offload

Li Ma (1):
      drm/amd/swsmu: modify the gfx activity scaling

Linus Torvalds (2):
      iov_iter: get rid of 'copy_mc' flag
      Linux 6.8

Liu Ying (1):
      arm64: dts: imx8mp: Fix LDB clocks property

Ma Jun (1):
      drm/amdgpu/pm: Fix the error of pwm1_enable setting

Maciej Fijalkowski (3):
      ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
      i40e: disable NAPI right after disabling irqs when handling xsk_pool
      ice: reorder disabling IRQ and NAPI in ice_qp_dis

Marek Vasut (1):
      arm64: dts: imx8mp: Fix TC9595 reset GPIO on DH i.MX8M Plus DHCOM SoM

Masahisa Kojima (1):
      MAINTAINERS: net: netsec: add myself as co-maintainer

Mathias Krause (1):
      Input: synaptics-rmi4 - fix UAF of IRQ domain on driver removal

Mathias Nyman (2):
      usb: port: Don't try to peer unused USB ports based on location
      xhci: Fix failure to detect ring expansion need.

Matthew Auld (1):
      drm/tests/buddy: fix print format

Matthieu Baerts (NGI0) (1):
      selftests: mptcp: diag: avoid extra waiting

Max Nguyen (1):
      Input: xpad - add additional HyperX Controller Identifiers

Melissa Wen (1):
      drm/amd/display: check dc_link before dereferencing

Michael Kelley (8):
      Drivers: hv: vmbus: Calculate ring buffer size for more
efficient use of memory
      fbdev/hyperv_fb: Fix logic error for Gen2 VMs in hvfb_getmem()
      Drivers: hv: vmbus: Remove duplication and cleanup code in
create_gpadl_header()
      Drivers: hv: vmbus: Update indentation in create_gpadl_header()
      Documentation: hyperv: Add overview of PCI pass-thru device support
      x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor cal=
lback
      x86/mm: Regularize set_memory_p() parameters and make non-static
      x86/hyperv: Make encrypted/decrypted changes safe for
load_unaligned_zeropad()

Michal Schmidt (1):
      ice: fix uninitialized dplls mutex usage

Michal Swiatkowski (1):
      ice: reconfig host after changing MSI-X on VF

Mika Westerberg (1):
      thunderbolt: Fix NULL pointer dereference in tb_port_update_credits()

Mike Yu (2):
      xfrm: fix xfrm child route lookup for packet offload
      xfrm: set skb control buffer based on packet offload as well

Moshe Shemesh (1):
      net/mlx5: Check capability for fw_reset

Nathan Chancellor (1):
      xfrm: Avoid clang fortify warning in copy_to_user_tmpl()

Neil Armstrong (3):
      arm64: dts: qcom: sm8650-qrd: add gpio74 as reserved gpio
      arm64: dts: qcom: sm8650-mtp: add gpio74 as reserved gpio
      usb: typec: ucsi: fix UCSI on SM8550 & SM8650 Qualcomm devices

Nicolas Pitre (1):
      vt: fix unicode buffer corruption when deleting characters

Niklas Cassel (1):
      mailmap: fix Kishon's email

Niklas S=C3=B6derlund (1):
      dt-bindings: net: renesas,ethertsn: Document default for delays

Nirmoy Das (1):
      drm/i915: Check before removing mm notifier

Nuno Sa (1):
      counter: fix privdata alignment

Oleksij Rempel (1):
      net: lan78xx: fix runtime PM count underflow on link stop

Pablo Neira Ayuso (3):
      netfilter: nf_tables: disallow anonymous set with timeout flag
      netfilter: nf_tables: reject constant set with timeout
      netfilter: nf_tables: mark set as dead when unbinding anonymous
set with timeout

Paolo Bonzini (1):
      SEV: disable SEV-ES DebugSwap by default

Peter Collingbourne (1):
      serial: 8250_dw: Do not reclock if already at correct rate

Peter Martincic (1):
      hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC

Puranjay Mohan (1):
      arm64: prohibit probing on arch_kunwind_consume_entry()

Qi Zheng (1):
      mm: userfaultfd: fix unexpected change to src_folio when UFFDIO_MOVE =
fails

Quentin Schulz (2):
      regulator: rk808: fix buck range on RK806
      regulator: rk808: fix LDO range on RK806

RD Babiera (1):
      usb: typec: altmodes/displayport: create sysfs nodes as driver's
default device attribute group

Rahul Rameshbabu (2):
      net/mlx5e: Use a memory barrier to enforce PTP WQ xmit
submission tracking occurs after populating the metadata_map
      net/mlx5e: Switch to using _bh variant of of spinlock API in
port timestamping NAPI poll context

Rand Deeb (1):
      net: ice: Fix potential NULL pointer dereference in ice_bridge_setlin=
k()

Ricardo B. Marliere (1):
      Drivers: hv: vmbus: make hv_bus const

Rickard x Andersson (1):
      tty: serial: imx: Fix broken RS485

Rob Herring (1):
      ASoC: dt-bindings: nvidia: Fix 'lge' vendor prefix

Rodrigo Vivi (1):
      drm/xe: Return immediately on tile_init failure

Saeed Mahameed (1):
      Revert "net/mlx5e: Check the number of elements before walk TC rhasht=
able"

Sasha Neftin (1):
      intel: legacy: Partial revert of field get conversion

Saurabh Sengar (1):
      x86/hyperv: Allow 15-bit APIC IDs for VTL platforms

Sean Christopherson (8):
      KVM: x86: Mark target gfn of emulated atomic instruction as dirty
      KVM: Make KVM_MEM_GUEST_MEMFD mutually exclusive with KVM_MEM_READONL=
Y
      KVM: x86: Update KVM_SW_PROTECTED_VM docs to make it clear they're a =
WIP
      KVM: x86/mmu: Restrict KVM_SW_PROTECTED_VM to the TDP MMU
      KVM: selftests: Create GUEST_MEMFD for relevant invalid flags testcas=
es
      KVM: selftests: Add a testcase to verify GUEST_MEMFD and
READONLY are exclusive
      KVM: SVM: Flush pages under kvm->lock to fix UAF in
svm_register_enc_region()
      KVM: x86/mmu: Retry fault before acquiring mmu_lock if mapping is cha=
nging

Sherry Sun (1):
      tty: serial: fsl_lpuart: avoid idle preamble pending if CTS is enable=
d

Stefan Binding (3):
      ALSA: hda: cs35l41: Support Lenovo Thinkbook 16P
      ALSA: hda/realtek: Add quirks for Lenovo Thinkbook 16P laptops
      ALSA: hda: cs35l41: Overwrite CS35L41 configuration for ASUS UM5302LA

Steven Rostedt (Google) (7):
      tracing/net_sched: Fix tracepoints that save qdisc_dev() as a string
      tracing: Remove precision vsnprintf() check from print event
      tracing: Limit trace_seq size to just 8K and not depend on
architecture PAGE_SIZE
      tracing: Limit trace_marker writes to just 4K
      ring-buffer: Fix waking up ring buffer readers
      ring-buffer: Fix resetting of shortest_full
      tracing: Use .flush() call to wake up readers

Stuart Henderson (4):
      ASoC: madera: Fix typo in madera_set_fll_clks shift value
      ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
      ASoC: wm8962: Enable both SPKOUTR_ENA and SPKOUTL_ENA in mono mode
      ASoC: wm8962: Fix up incorrect error message in wm8962_set_fll

Sumit Garg (1):
      tee: optee: Fix kernel panic caused by incorrect error handling

Suraj Kandpal (3):
      drm/i915/hdcp: Move to direct reads for HDCP
      drm/i915/hdcp: Remove additional timing for reading mst hdcp message
      drm/i915/hdcp: Extract hdcp structure from correct connector

Thierry Reding (1):
      arm64: tegra: Set the correct PHY mode for MGBE

Tobias Jakobi (Compleo) (1):
      net: dsa: microchip: fix register write order in ksz8_ind_write8()

Toke H=C3=B8iland-J=C3=B8rgensen (1):
      cpumap: Zero-initialise xdp_rxq_info struct before running XDP progra=
m

Tommy Huang (1):
      i2c: aspeed: Fix the dummy irq expected print

Tvrtko Ursulin (1):
      MAINTAINERS: Update email address for Tvrtko Ursulin

Uwe Kleine-K=C3=B6nig (1):
      Input: gpio_keys_polled - suppress deferred probe error for gpio

Vasileios Amoiridis (1):
      iio: pressure: Fixes BMP38x and BMP390 SPI support

Ville Syrj=C3=A4l=C3=A4 (1):
      drm/i915: Don't explode when the dig port we don't have an AUX CH

Vlastimil Babka (2):
      mm, vmscan: prevent infinite loop for costly GFP_NOIO |
__GFP_RETRY_MAYFAIL allocations
      mm, mmap: fix vma_merge() case 7 with vma_ops->close

Waiman Long (1):
      cgroup/cpuset: Fix a memory leak in update_exclusive_cpumask()

Wentong Wu (1):
      mei: Add Meteor Lake support for IVSC device

Xiubo Li (1):
      libceph: init the cursor when preparing sparse read in msgr2

Yicong Yang (1):
      serial: port: Don't suspend if the port is still busy

Yongzhi Liu (1):
      net: pds_core: Fix possible double free in error handling path

songxiebing (1):
      ALSA: hda: optimize the probe codec process

