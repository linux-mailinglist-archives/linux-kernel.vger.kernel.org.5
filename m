Return-Path: <linux-kernel+bounces-30014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDEC831708
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DAF71C22217
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E02A2375A;
	Thu, 18 Jan 2024 10:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dMZ9QjnJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A01B96D;
	Thu, 18 Jan 2024 10:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705575165; cv=none; b=FEPeizbec0fOBvexUy805QYbmM8PR/NgDhX2qEEBd83z5DQt70KiLRMkis23WGjYF5L8qKtzMBJ/6dgKrUSLgsh6Ci34Cv8fxHaoca1nybsJnp+QWYOpC/u26mUT0pvuYQ7SnP6PC2buHNeqqvluWiW8/37MvMk2iMXffgEuZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705575165; c=relaxed/simple;
	bh=3Ho+mP1OGbuWj8bm1MkIYvdGsovBrFYObTTkzeBbIpY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:User-Agent:X-stable:X-Patchwork-Hint:
	 X-KernelTest-Patch:X-KernelTest-Tree:X-KernelTest-Branch:
	 X-KernelTest-Patches:X-KernelTest-Version:X-KernelTest-Deadline:
	 Content-Type:Content-Transfer-Encoding; b=ZGEqn6NTQ1GB59qIkrDWy3EfEK8sNVZMYzcFoi051Tfysi9GRhsBSpqiAMWmSO8+01NxhrDAV0b1jQYPup/fzQdBljqdchxBG+jQeGdc3kRVXVI0YhTkFWu9lsYjM1BA/4khggAAiyYLErF8+Wwxe+nxsWX26AzcAwL8AlrfWE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dMZ9QjnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90BCC433C7;
	Thu, 18 Jan 2024 10:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705575165;
	bh=3Ho+mP1OGbuWj8bm1MkIYvdGsovBrFYObTTkzeBbIpY=;
	h=From:To:Cc:Subject:Date:From;
	b=dMZ9QjnJlWCo7DNuAm4OexfhgZzWymiPWe+sLdzCMwwUcuAkKgMRku6WlQXLh5iRq
	 PzqiMH7PICOOVPIft2CumEkll4VsbgPgCsE98Tz4ele9H6Bnwxk4Jod6YtaK9WKdWA
	 KTcC8maxe3kgPwg0xu4Uo0vngZFnkaMJk0M7L1vU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@denx.de,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net,
	rwarsow@gmx.de,
	conor@kernel.org,
	allen.lkml@gmail.com
Subject: [PATCH 6.6 000/150] 6.6.13-rc1 review
Date: Thu, 18 Jan 2024 11:47:02 +0100
Message-ID: <20240118104320.029537060@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.13-rc1
X-KernelTest-Deadline: 2024-01-20T10:43+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 6.6.13 release.
There are 150 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.13-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 6.6.13-rc1

Sumanth Korikkar <sumanthk@linux.ibm.com>
    mm/memory_hotplug: fix memmap_on_memory sysfs value retrieval

Carlos Llamas <cmllamas@google.com>
    scripts/decode_stacktrace.sh: optionally use LLVM utilities

James Clark <james.clark@arm.com>
    coresight: etm4x: Fix width of CCITMIN field

LeoLiuoc <LeoLiu-oc@zhaoxin.com>
    PCI: Add ACS quirk for more Zhaoxin Root Ports

Florian Eckert <fe@dev.tdt.de>
    leds: ledtrig-tty: Free allocated ttyname buffer on deactivate

Cameron Williams <cang1@live.co.uk>
    parport: parport_serial: Add Brainboxes device IDs and geometry

Cameron Williams <cang1@live.co.uk>
    parport: parport_serial: Add Brainboxes BAR details

Guanghui Feng <guanghuifeng@linux.alibaba.com>
    uio: Fix use-after-free in uio_open

Carlos Llamas <cmllamas@google.com>
    binder: fix comment on binder_alloc_new_buf() return value

Carlos Llamas <cmllamas@google.com>
    binder: fix trivial typo of binder_free_buf_locked()

Carlos Llamas <cmllamas@google.com>
    binder: fix use-after-free in shinker's callback

Carlos Llamas <cmllamas@google.com>
    binder: use EPOLLERR from eventpoll.h

Junxiao Bi <junxiao.bi@oracle.com>
    Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Fedor Pchelkin <pchelkin@ispras.ru>
    ksmbd: free ppace array on error in parse_dacl

Namjae Jeon <linkinjeon@kernel.org>
    ksmbd: don't allow O_TRUNC open on read-only share

Lewis Huang <lewis.huang@amd.com>
    drm/amd/display: Pass pwrseq inst for backlight and ABM

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: Intel: hda-codec: Delay the codec device registration

Sjoerd Simons <sjoerd@collabora.com>
    bus: moxtet: Add spi device table

Sjoerd Simons <sjoerd@collabora.com>
    bus: moxtet: Mark the irq as shared

Hans de Goede <hdegoede@redhat.com>
    ACPI: resource: Add another DMI match for the TongFang GMxXGxx

Tom Jason Schwanke <tom@catboys.cloud>
    ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP Envy X360 13-ay0xxx

Paolo Bonzini <pbonzini@redhat.com>
    x86/microcode: do not cache microcode if it will not be used

Jani Nikula <jani.nikula@intel.com>
    drm/crtc: fix uninitialized variable use

Linus Torvalds <torvalds@linux-foundation.org>
    x86/csum: clean up `csum_partial' further

Noah Goldstein <goldstein.w.n@gmail.com>
    x86/csum: Remove unnecessary odd handling

Stefan Wahren <wahrenst@gmx.net>
    ARM: sun9i: smp: fix return code check of of_property_match_string

wangkeqi <wangkeqiwang@didiglobal.com>
    connector: Fix proc_event_num_listeners count not cleared

Sarannya S <quic_sarannya@quicinc.com>
    net: qrtr: ns: Return 0 if server port is not present

Siddh Raman Pant <code@siddh.me>
    nfc: Do not send datagram if socket state isn't LLCP_BOUND

Stefan Hajnoczi <stefanha@redhat.com>
    virtio_blk: fix snprintf truncation compiler warning

Matthew Wilcox (Oracle) <willy@infradead.org>
    ida: Fix crash in ida_free when the bitmap is empty

Linus Torvalds <torvalds@linux-foundation.org>
    posix-timers: Get rid of [COMPAT_]SYS_NI() uses

Patrick Rudolph <patrick.rudolph@9elements.com>
    pinctrl: cy8c95x0: Fix get_pincfg

Patrick Rudolph <patrick.rudolph@9elements.com>
    pinctrl: cy8c95x0: Fix regression

Patrick Rudolph <patrick.rudolph@9elements.com>
    pinctrl: cy8c95x0: Fix typo

Charlene Liu <charlene.liu@amd.com>
    drm/amd/display: get dprefclk ss info from integration info table

Wayne Lin <wayne.lin@amd.com>
    drm/amd/display: Add case for dcn35 to support usb4 dmub hpd event

Philip Yang <Philip.Yang@amd.com>
    drm/amdkfd: svm range always mapped flag not working on APU

Jensen Huang <jensenhuang@friendlyarm.com>
    i2c: rk3x: fix potential spinlock recursion on poll

Paulo Alcantara <pc@manguebit.com>
    smb: client: fix potential OOB in smb2_dump_detail()

Guilherme G. Piccoli <gpiccoli@igalia.com>
    HID: nintendo: Prevent divide-by-zero on code

Mike Snitzer <snitzer@kernel.org>
    dm audit: fix Kconfig so DM_AUDIT depends on BLK_DEV_DM

Stefan Binding <sbinding@opensource.cirrus.com>
    ALSA: hda/realtek: Add quirks for ASUS Zenbook 2022 Models

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add new swapped-speakers quirk

Hans de Goede <hdegoede@redhat.com>
    ASoC: Intel: bytcr_rt5640: Add quirk for the Medion Lifetab S10346

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmc: Disable keyboard wakeup on AMD Framework 13

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmc: Move keyboard wakeup disablement detection to pmc-quirks

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmc: Only run IRQ1 firmware version check on Cezanne

Mario Limonciello <mario.limonciello@amd.com>
    platform/x86/amd/pmc: Move platform defines to header

Vishnu Sankar <vishnuocv@gmail.com>
    platform/x86: thinkpad_acpi: fix for incorrect fan reporting on some ThinkPad systems

Ryan McClelland <rymcclel@gmail.com>
    HID: nintendo: fix initializer element is not constant error

Ghanshyam Agrawal <ghanshyam1898@gmail.com>
    kselftest: alsa: fixed a print formatting warning

Dan Williams <dan.j.williams@intel.com>
    driver core: Add a guard() definition for the device_lock()

Luca Weiss <luca@z3ntu.xyz>
    Input: xpad - add Razer Wolverine V2 support

Avraham Stern <avraham.stern@intel.com>
    wifi: iwlwifi: pcie: avoid a NULL pointer dereference

Vineet Gupta <vgupta@kernel.org>
    ARC: fix smatch warning

Vineet Gupta <vgupta@kernel.org>
    ARC: fix spare error

Vineeth Vijayan <vneethv@linux.ibm.com>
    s390/scm: fix virtual vs physical address confusion

Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
    ASoC: cs35l45: Prevents spinning during runtime suspend

Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
    ASoC: cs35l45: Prevent IRQ handling when suspending/resuming

Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
    ASoC: cs35l45: Use modern pm_ops

Mario Limonciello <mario.limonciello@amd.com>
    pinctrl: amd: Mask non-wake source pins with interrupt enabled at suspend

Esther Shimanovich <eshimanovich@chromium.org>
    Input: i8042 - add nomux quirk for Acer P459-G2-M

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - skip ATKBD_CMD_GETID in translated mode

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning

José Pekkarinen <jose.pekkarinen@foxhound.fi>
    Input: psmouse - enable Synaptics InterTouch for ThinkPad L14 G1

Steven Rostedt (Google) <rostedt@goodmis.org>
    ring-buffer: Do not record in NMI if the arch does not support cmpxchg in NMI

Zheng Yejian <zhengyejian1@huawei.com>
    tracing: Fix uaf issue when open the hist or hist_debug file

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    MIPS: dts: loongson: drop incorrect dwmac fallback compatible

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    stmmac: dwmac-loongson: drop useless check for compatible fallback

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Add size check when printing trace_marker output

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Have large events show up as '[LINE TOO BIG]' instead of nothing

Ye Bin <yebin10@huawei.com>
    jbd2: fix soft lockup in journal_finish_inode_data_buffers()

Wang Yao <wangyao@lemote.com>
    efi/loongarch: Use load address to calculate kernel entry address

Hans de Goede <hdegoede@redhat.com>
    platform/x86: intel-vbtn: Fix missing tablet-mode-switch events

Judy Hsiao <judyhsiao@chromium.org>
    neighbour: Don't let neigh_forced_gc() disable preemption for long

Ziqi Zhao <astrajoan@yahoo.com>
    drm/crtc: Fix uninit-value bug in drm_mode_setcrtc

Zhang Yi <yi.zhang@huawei.com>
    jbd2: increase the journal IO's priority

Zhang Yi <yi.zhang@huawei.com>
    jbd2: correct the printing of write_flags in jbd2_write_superblock()

Chao Song <chao.song@linux.intel.com>
    soundwire: intel_ace2x: fix AC timing setting for ACE2.x

Weihao Li <cn.liweihao@gmail.com>
    clk: rockchip: rk3128: Fix HCLK_OTG gate register

Chris Morgan <macromorgan@hotmail.com>
    clk: rockchip: rk3568: Add PLL rate for 292.5MHz

Hengqi Chen <hengqi.chen@gmail.com>
    LoongArch: Preserve syscall nr across execve()

Jinyang He <hejinyang@loongson.cn>
    LoongArch: Set unwind stack type to unknown rather than set error flag

WANG Rui <wangrui@loongson.cn>
    LoongArch: Apply dynamic relocations for LLD

Armin Wolf <W_Armin@gmx.de>
    hwmon: (corsair-psu) Fix probe when built-in

Ivan Orlov <ivan.orlov0322@gmail.com>
    ALSA: pcmtest: stop timer before buffer is released

Inki Dae <inki.dae@samsung.com>
    drm/exynos: fix a wrong error checking

Xiang Yang <xiangyang3@huawei.com>
    drm/exynos: fix a potential error pointer dereference

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Add NULL checks for function pointers

Ivan Lipski <ivlipski@amd.com>
    drm/amd/display: Add monitor patch for specific eDP

Stefan Wiehler <stefan.wiehler@nokia.com>
    mips/smp: Call rcutree_report_cpu_starting() earlier

Rob Herring <robh@kernel.org>
    arm64: dts: rockchip: Fix PCI node addresses on rk3399-gru

Bitao Hu <yaoma@linux.alibaba.com>
    nvme: fix deadlock between reset and scan

Nitesh Shetty <nj.shetty@samsung.com>
    nvme: prevent potential spectre v1 gadget

Keith Busch <kbusch@kernel.org>
    nvme-ioctl: move capable() admin check to the end

Keith Busch <kbusch@kernel.org>
    nvme: ensure reset state check ordering

Keith Busch <kbusch@kernel.org>
    nvme: introduce helper function to get ctrl state

David Rau <David.Rau.opensource@dm.renesas.com>
    ASoC: da7219: Support low DC impedance headset

Thinh Tran <thinhtr@linux.vnet.ibm.com>
    net/tg3: fix race condition in tg3_reset_task()

Shannon Nelson <shannon.nelson@amd.com>
    pds_vdpa: set features order

Shannon Nelson <shannon.nelson@amd.com>
    pds_vdpa: clear config callback when status goes to 0

Shannon Nelson <shannon.nelson@amd.com>
    pds_vdpa: fix up format-truncation complaint

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: ipc4-topology: Correct data structures for the GAIN module

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: SOF: ipc4-topology: Correct data structures for the SRC module

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: hdac_hda: Conditionally register dais for HDMI and Analog

Jeremy Soller <jeremy@system76.com>
    ASoC: amd: yc: Add DMI entry to support System76 Pangolin 13

Dave Airlie <airlied@redhat.com>
    nouveau/tu102: flush all pdbs on vmm flush

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: SOF: sof-audio: Modify logic for enabling/disabling topology cores

Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
    ASoC: SOF: ipc4-topology: Add core_mask in struct snd_sof_pipeline

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ASoC: Intel: skl_hda_dsp_generic: Drop HDMI routes when HDMI is not available

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_xcvr: refine the requested phy clock frequency

Shuming Fan <shumingf@realtek.com>
    ASoC: rt5650: add mutex to avoid the jack detection failure

Shengjiu Wang <shengjiu.wang@nxp.com>
    ASoC: fsl_xcvr: Enable 2 * TX bit clock for spdif only case

Maciej Strozek <mstrozek@opensource.cirrus.com>
    ASoC: cs43130: Fix incorrect frame delay configuration

Maciej Strozek <mstrozek@opensource.cirrus.com>
    ASoC: cs43130: Fix the position of const qualifier

Kamil Duljas <kamil.duljas@gmail.com>
    ASoC: Intel: Skylake: mem leak in skl register function

Kamil Duljas <kamil.duljas@gmail.com>
    ASoC: SOF: topology: Fix mem leak in sof_dai_load()

David Lin <CTLIN0@nuvoton.com>
    ASoC: nau8822: Fix incorrect type in assignment and cast to restricted __be16

Kamil Duljas <kamil.duljas@gmail.com>
    ASoC: Intel: Skylake: Fix mem leak in few functions

Heiko Stuebner <heiko@sntech.de>
    arm64: dts: rockchip: fix rk356x pcie msg interrupt name

Charles Keepax <ckeepax@opensource.cirrus.com>
    ASoC: wm8974: Correct boost mixer inputs

Matus Malych <matus@malych.org>
    ASoC: amd: yc: Add HP 255 G10 into quirk table

Yicong Yang <yangyicong@hisilicon.com>
    hwtracing: hisi_ptt: Don't try to attach a task

Yicong Yang <yangyicong@hisilicon.com>
    hwtracing: hisi_ptt: Handle the interrupt in hardirq context

Keith Busch <kbusch@kernel.org>
    nvme-core: check for too small lba shift

Ming Lei <ming.lei@redhat.com>
    blk-mq: don't count completed flush data request as inflight in case of quiesce

Felix Kuehling <Felix.Kuehling@amd.com>
    Revert "drm/prime: Unexport helpers for fd/handle conversion"

Dmitry Antipov <dmantipov@yandex.ru>
    smb: client, common: fix fortify warnings

Lijo Lazar <lijo.lazar@amd.com>
    drm/amdgpu: Use another offset for GC 9.4.3 remap

ZhenGuo Yin <zhenguo.yin@amd.com>
    drm/amdkfd: Free gang_ctx_bo and wptr_bo in pqm_uninit

Lu Yao <yaolu@kylinos.cn>
    drm/amdgpu: Fix cat debugfs amdgpu_regs_didt causes kernel null pointer

Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
    drm/amd/display: update dcn315 lpddr pstate latency

Mukul Joshi <mukul.joshi@amd.com>
    drm/amdkfd: Use common function for IP version check

Hawking Zhang <Hawking.Zhang@amd.com>
    drm/amdgpu: Do not issue gpu reset from nbio v7_9 bif interrupt

Yu Kuai <yukuai3@huawei.com>
    block: warn once for each partition in bio_check_ro()

Jens Axboe <axboe@kernel.dk>
    io_uring: use fget/fput consistently

Maurizio Lombardi <mlombard@redhat.com>
    nvme-core: fix a memory leak in nvme_ns_info_from_identify()

Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
    ALSA: hda: intel-nhlt: Ignore vbps when looking for DMIC 32 bps format

Johannes Berg <johannes.berg@intel.com>
    debugfs: fix automount d_fsdata usage

Ben Greear <greearb@candelatech.com>
    wifi: mac80211: handle 320 MHz in ieee80211_ht_cap_ie_to_sta_ht_cap

Michael-CY Lee <michael-cy.lee@mediatek.com>
    wifi: avoid offset calculation on NULL pointer

Johannes Berg <johannes.berg@intel.com>
    wifi: cfg80211: lock wiphy mutex for rfkill poll

Edward Adam Davis <eadavis@qq.com>
    mptcp: fix uninit-value in mptcp_incoming_options

Vasiliy Kovalev <kovalev@altlinux.org>
    ALSA: hda - Fix speaker and headset mic pin config for CHUWI CoreBook XPro

Charles Keepax <ckeepax@opensource.cirrus.com>
    pinctrl: lochnagar: Don't build on MIPS

Michal Wajdeczko <michal.wajdeczko@intel.com>
    kunit: Reset suite counter right before running tests

Maxime Ripard <mripard@kernel.org>
    kunit: Warn if tests are slow

Chester Lin <clin@suse.com>
    pinctrl: s32cc: Avoid possible string truncation

Eric Biggers <ebiggers@google.com>
    f2fs: explicitly null-terminate the xattr list


-------------

Diffstat:

 Makefile                                           |   4 +-
 arch/arc/kernel/setup.c                            |   4 +-
 arch/arc/kernel/signal.c                           |   6 +-
 arch/arm/mach-sunxi/mc_smp.c                       |   4 +-
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |   3 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet-dumo.dts  |   4 +-
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |   1 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi           |   2 +-
 arch/arm64/include/asm/syscall_wrapper.h           |   4 -
 arch/loongarch/Makefile                            |   2 +-
 arch/loongarch/include/asm/efi.h                   |   2 +-
 arch/loongarch/include/asm/elf.h                   |   2 +-
 arch/loongarch/kernel/stacktrace.c                 |   2 +-
 arch/loongarch/kernel/unwind.c                     |   1 -
 arch/loongarch/kernel/unwind_prologue.c            |   2 +-
 arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi |   3 +-
 arch/mips/boot/dts/loongson/ls7a-pch.dtsi          |   3 +-
 arch/mips/kernel/smp.c                             |   4 +-
 arch/riscv/include/asm/syscall_wrapper.h           |   5 -
 arch/s390/include/asm/syscall_wrapper.h            |  13 +--
 arch/x86/include/asm/syscall_wrapper.h             |  34 +------
 arch/x86/kernel/cpu/microcode/core.c               |   6 ++
 arch/x86/lib/csum-partial_64.c                     | 105 +++++++--------------
 block/blk-core.c                                   |  14 ++-
 block/blk-mq.c                                     |  14 ++-
 drivers/acpi/resource.c                            |   7 ++
 drivers/android/binder.c                           |   2 +-
 drivers/android/binder_alloc.c                     |  10 +-
 drivers/block/virtio_blk.c                         |   8 +-
 drivers/bus/moxtet.c                               |   9 +-
 drivers/clk/rockchip/clk-rk3128.c                  |   2 +-
 drivers/clk/rockchip/clk-rk3568.c                  |   1 +
 drivers/connector/cn_proc.c                        |   5 +-
 drivers/firmware/efi/libstub/loongarch-stub.c      |   4 +-
 drivers/firmware/efi/libstub/loongarch.c           |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   6 ++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c             |   5 -
 drivers/gpu/drm/amd/amdgpu/soc15.c                 |  17 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c |  54 ++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c               |  18 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  |   6 ++
 drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c |  23 +++--
 .../gpu/drm/amd/display/dc/bios/command_table2.c   |  12 +--
 .../gpu/drm/amd/display/dc/bios/command_table2.h   |   2 +-
 .../amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c |   8 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |  26 +++--
 drivers/gpu/drm/amd/display/dc/dc_bios_types.h     |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c      |   8 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.h  |   2 +-
 .../amd/display/dc/dce110/dce110_hw_sequencer.c    |  16 ++--
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hwseq.c |  36 +++++--
 .../drm/amd/display/dc/dcn31/dcn31_panel_cntl.c    |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h        |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/panel_cntl.h |   2 +
 drivers/gpu/drm/amd/display/dc/link/link_factory.c |  56 +++++++----
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h    |  14 ++-
 .../amd/display/include/grph_object_ctrl_defs.h    |   2 +
 drivers/gpu/drm/drm_crtc.c                         |   8 +-
 drivers/gpu/drm/drm_prime.c                        |  33 ++++---
 drivers/gpu/drm/exynos/exynos_drm_dma.c            |   8 +-
 drivers/gpu/drm/exynos/exynos_hdmi.c               |   2 +
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmmtu102.c |   2 +-
 drivers/hid/hid-nintendo.c                         |  71 ++++++++------
 drivers/hwmon/corsair-psu.c                        |  18 +++-
 drivers/hwtracing/coresight/coresight-etm4x.h      |   2 +-
 drivers/hwtracing/ptt/hisi_ptt.c                   |   9 +-
 drivers/i2c/busses/i2c-rk3x.c                      |  13 ++-
 drivers/input/joystick/xpad.c                      |   1 +
 drivers/input/keyboard/atkbd.c                     |  46 ++++++++-
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/serio/i8042-acpipnpio.h              |   8 ++
 drivers/leds/trigger/ledtrig-tty.c                 |   4 +
 drivers/md/Kconfig                                 |   1 +
 drivers/md/raid5.c                                 |  12 ---
 drivers/net/ethernet/broadcom/tg3.c                |  11 ++-
 .../net/ethernet/stmicro/stmmac/dwmac-loongson.c   |   5 -
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c       |   2 +-
 drivers/nvme/host/core.c                           |  64 ++++++++-----
 drivers/nvme/host/fc.c                             |   6 +-
 drivers/nvme/host/ioctl.c                          |  21 +++--
 drivers/nvme/host/nvme.h                           |   6 ++
 drivers/nvme/host/pci.c                            |  14 +--
 drivers/nvme/host/rdma.c                           |  23 +++--
 drivers/nvme/host/tcp.c                            |  27 ++++--
 drivers/nvme/target/configfs.c                     |   3 +
 drivers/parport/parport_serial.c                   |  64 +++++++++++++
 drivers/pci/quirks.c                               |   8 +-
 drivers/pinctrl/cirrus/Kconfig                     |   3 +-
 drivers/pinctrl/nxp/pinctrl-s32cc.c                |   4 +-
 drivers/pinctrl/pinctrl-amd.c                      |   9 ++
 drivers/pinctrl/pinctrl-amd.h                      |   5 +
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |  14 ++-
 drivers/platform/x86/amd/pmc/pmc-quirks.c          |  20 ++++
 drivers/platform/x86/amd/pmc/pmc.c                 |  33 +++----
 drivers/platform/x86/amd/pmc/pmc.h                 |  12 +++
 drivers/platform/x86/intel/vbtn.c                  |  19 +++-
 drivers/platform/x86/thinkpad_acpi.c               |  98 ++++++++++++++++---
 drivers/reset/hisilicon/hi6220_reset.c             |   2 +-
 drivers/s390/block/scm_blk.c                       |   7 +-
 drivers/soundwire/intel_ace2x.c                    |   3 +-
 drivers/uio/uio.c                                  |   7 +-
 drivers/vdpa/pds/debugfs.c                         |   2 +-
 drivers/vdpa/pds/vdpa_dev.c                        |   7 +-
 fs/debugfs/file.c                                  |   8 ++
 fs/debugfs/inode.c                                 |  27 ++++--
 fs/debugfs/internal.h                              |  10 +-
 fs/f2fs/xattr.c                                    |   6 ++
 fs/jbd2/commit.c                                   |  10 +-
 fs/jbd2/journal.c                                  |  24 +++--
 fs/smb/client/cifspdu.h                            |  24 +++--
 fs/smb/client/cifssmb.c                            |   6 +-
 fs/smb/client/smb2misc.c                           |  30 +++---
 fs/smb/client/smb2ops.c                            |   6 +-
 fs/smb/client/smb2pdu.c                            |   8 +-
 fs/smb/client/smb2pdu.h                            |  16 ++--
 fs/smb/common/smb2pdu.h                            |  17 ++--
 fs/smb/server/smb2pdu.c                            |  23 ++---
 fs/smb/server/smbacl.c                             |  11 ++-
 include/drm/drm_prime.h                            |   7 ++
 include/linux/blk_types.h                          |   1 +
 include/linux/device.h                             |   2 +
 include/linux/ieee80211.h                          |   4 +-
 include/linux/jbd2.h                               |   3 +
 io_uring/cancel.c                                  |  11 ++-
 io_uring/io_uring.c                                |  36 +++----
 kernel/sys_ni.c                                    |  14 +++
 kernel/time/posix-stubs.c                          |  45 ---------
 kernel/trace/ring_buffer.c                         |   6 ++
 kernel/trace/trace.c                               |  12 ++-
 kernel/trace/trace.h                               |   1 +
 kernel/trace/trace_events_hist.c                   |  12 ++-
 kernel/trace/trace_output.c                        |   6 +-
 lib/idr.c                                          |   2 +-
 lib/kunit/test.c                                   |  42 ++++++++-
 lib/test_ida.c                                     |  40 ++++++++
 mm/memory_hotplug.c                                |   8 +-
 net/core/neighbour.c                               |   9 +-
 net/mac80211/ht.c                                  |   1 +
 net/mptcp/options.c                                |   1 +
 net/nfc/llcp_sock.c                                |   5 +
 net/qrtr/ns.c                                      |   4 +-
 net/wireless/core.c                                |   2 +
 scripts/decode_stacktrace.sh                       |  19 +++-
 sound/drivers/pcmtest.c                            |  13 ++-
 sound/hda/intel-nhlt.c                             |  33 ++++++-
 sound/pci/hda/patch_realtek.c                      |  16 +++-
 sound/soc/amd/yc/acp6x-mach.c                      |  14 +++
 sound/soc/codecs/cs35l45-i2c.c                     |   2 +-
 sound/soc/codecs/cs35l45-spi.c                     |   2 +-
 sound/soc/codecs/cs35l45.c                         |  56 ++++++++++-
 sound/soc/codecs/cs43130.c                         |   6 +-
 sound/soc/codecs/da7219-aad.c                      |   2 +-
 sound/soc/codecs/hdac_hda.c                        |  23 ++++-
 sound/soc/codecs/nau8822.c                         |   9 +-
 sound/soc/codecs/rt5645.c                          |  10 +-
 sound/soc/codecs/wm8974.c                          |   6 +-
 sound/soc/fsl/fsl_xcvr.c                           |  14 ++-
 sound/soc/intel/boards/bytcr_rt5640.c              |  31 ++++--
 sound/soc/intel/boards/skl_hda_dsp_generic.c       |   2 +
 sound/soc/intel/skylake/skl-pcm.c                  |   9 +-
 sound/soc/intel/skylake/skl-sst-ipc.c              |   4 +-
 sound/soc/sof/intel/hda-codec.c                    |  18 ++--
 sound/soc/sof/ipc3-topology.c                      |   2 +
 sound/soc/sof/ipc4-control.c                       |  20 ++--
 sound/soc/sof/ipc4-topology.c                      |  61 +++++++-----
 sound/soc/sof/ipc4-topology.h                      |  34 +++++--
 sound/soc/sof/sof-audio.c                          |  65 ++++++++-----
 sound/soc/sof/sof-audio.h                          |   2 +
 sound/soc/sof/topology.c                           |   4 +-
 tools/testing/selftests/alsa/mixer-test.c          |   2 +-
 172 files changed, 1575 insertions(+), 772 deletions(-)



