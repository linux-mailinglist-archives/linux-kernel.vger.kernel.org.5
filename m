Return-Path: <linux-kernel+bounces-74831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CF685DC9B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020C51F22237
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3C17BAFB;
	Wed, 21 Feb 2024 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JNtmc8E5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04576037;
	Wed, 21 Feb 2024 13:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523714; cv=none; b=PU9q/z7AF2vu2vlfrH1lmVHpFAVEvJN2TzIaDBdRDlib4249kkQKQfCYk5DMNlzOBQWSs1Rz15cfRN2pp0oUQNaAWOoO2ml1sV+ORR/7yXUOqVjJbhzmhGiD/piTE6M9P/5f7UYCXfsy004ig4DxyONKz1NiFeL1ENlRshk2ZF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523714; c=relaxed/simple;
	bh=holz1UrH94KaRFhtd9pER7GY8ybZc+7vfb3lPsm03kM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mBx5vhXdiPdmXDHD/0AFyBH7uViiHXLgAmRAUaDHWi564Decx7MFlSpLHZKKTrBzF+FxrH1htgrpzUGJhwd7VT6IOnWCSAHKLoqiwDiPhAjt5wprsON8ZzG4CDfaHRJzTNvdzL6HTMAbXt+p9oNC48XPd0563UDAf4UNzgNeXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JNtmc8E5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A75C433F1;
	Wed, 21 Feb 2024 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708523714;
	bh=holz1UrH94KaRFhtd9pER7GY8ybZc+7vfb3lPsm03kM=;
	h=From:To:Cc:Subject:Date:From;
	b=JNtmc8E5PE5WPwcWZARBkJHncFG+gw/KZAwPxoIPHUAKsliYINbenMh5qlV3bbn9e
	 RZPJFURdbgNo0+0PglQusJroeSJD5RsvYS5bvb0S1jsPftbO/ztRzEt55eg3egkLgM
	 rIiWfg+Ex0yyVdCwPoJNECTxa76iawHEhGayq0JI=
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
Subject: [PATCH 5.10 000/379] 5.10.210-rc1 review
Date: Wed, 21 Feb 2024 14:02:59 +0100
Message-ID: <20240221125954.917878865@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.210-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.210-rc1
X-KernelTest-Deadline: 2024-02-23T13:00+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.10.210 release.
There are 379 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.210-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.10.210-rc1

Dan Carpenter <dan.carpenter@linaro.org>
    PCI: dwc: Fix a 64bit bug in dw_pcie_ep_raise_msix_irq()

Florian Fainelli <florian.fainelli@broadcom.com>
    net: bcmgenet: Fix EEE implementation

Dan Carpenter <dan.carpenter@linaro.org>
    netfilter: nf_tables: fix pointer math issue in nft_byteorder_eval()

Konrad Dybcio <konrad.dybcio@linaro.org>
    drm/msm/dsi: Enable runtime PM

Douglas Anderson <dianders@chromium.org>
    PM: runtime: Have devm_pm_runtime_enable() handle pm_runtime_dont_use_autosuspend()

Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
    PM: runtime: add devm_pm_runtime_enable helper

Mikulas Patocka <mpatocka@redhat.com>
    dm: limit the number of targets and parameter size area

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: replace WARN_ONs for invalid DAT metadata block requests

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix potential bug in end_buffer_async_write

Linus Torvalds <torvalds@linuxfoundation.org>
    sched/membarrier: reduce the ability to hammer on sys_membarrier

Eric Dumazet <edumazet@google.com>
    net: prevent mss overflow in skb_segment()

Xiang Yang <xiangyang3@huawei.com>
    Revert "arm64: Stash shadow stack pointer in the task struct on interrupt"

Davidlohr Bueso <dave@stgolabs.net>
    hrtimer: Ignore slack time for RT tasks in schedule_hrtimeout_range()

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: Missing gc cancellations fixed

Jozsef Kadlecsik <kadlec@netfilter.org>
    netfilter: ipset: fix performance regression in swap operation

Carlos Llamas <cmllamas@google.com>
    scripts/decode_stacktrace.sh: optionally use LLVM utilities

Miguel Ojeda <ojeda@kernel.org>
    scripts: decode_stacktrace: demangle Rust symbols

Schspa Shi <schspa@gmail.com>
    scripts/decode_stacktrace.sh: support old bash version

Stephen Boyd <swboyd@chromium.org>
    scripts/decode_stacktrace.sh: silence stderr messages from addr2line/nm

Lino Sanfilippo <l.sanfilippo@kunbus.com>
    serial: 8250_exar: Set missing rs485_supported flag

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: 8250_exar: Fill in rs485_supported

Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
    serial: Add rs485_supported to uart_port

Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
    crypto: lib/mpi - Fix unexpected pointer access in mpi_ec_init

David Lin <yu-hao.lin@nxp.com>
    wifi: mwifiex: fix uninitialized firmware_stat

Serge Semin <fancer.lancer@gmail.com>
    mips: Fix max_mapnr being uninitialized on early stages

Niklas Cassel <niklas.cassel@wdc.com>
    PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support

Sjoerd Simons <sjoerd@collabora.com>
    bus: moxtet: Add spi device table

David Lin <yu-hao.lin@nxp.com>
    wifi: mwifiex: add extra delay for firmware ready

Lukas Wunner <lukas@wunner.de>
    wifi: mwifiex: Support SD8978 chipset

Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
    mwifiex: Select firmware based on strapping

Junxiao Bi <junxiao.bi@oracle.com>
    Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d"

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Inform kmemleak of saved_cmdlines allocation

Konrad Dybcio <konrad.dybcio@linaro.org>
    pmdomain: core: Move the unused cleanup to a _sync initcall

Oleksij Rempel <linux@rempel-privat.de>
    can: j1939: Fix UAF in j1939_sk_match_filter during setsockopt(SO_J1939_FILTER)

Nuno Sa <nuno.sa@analog.com>
    of: property: fix typo in io-channels

Rishabh Dave <ridave@redhat.com>
    ceph: prevent use-after-free in encode_cap_msg()

Alexandra Winter <wintera@linux.ibm.com>
    s390/qeth: Fix potential loss of L3-IP@ in case of network issues

Marc Zyngier <maz@kernel.org>
    irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

Doug Berger <opendmb@gmail.com>
    irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Johannes Berg <johannes.berg@intel.com>
    wifi: mac80211: reload info pointer in ieee80211_tx_dequeue()

Daniel de Villiers <daniel.devilliers@corigine.com>
    nfp: flower: prevent re-adding mac index for bonded port

Daniel Basilio <daniel.basilio@corigine.com>
    nfp: use correct macro for LengthSelect in BAR config

Kim Phillips <kim.phillips@amd.com>
    crypto: ccp - Fix null pointer dereference in __sev_platform_shutdown_locked

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix hang in nilfs_lookup_dirty_data_buffers()

Ryusuke Konishi <konishi.ryusuke@gmail.com>
    nilfs2: fix data corruption in dsync block recovery for small block sizes

bo liu <bo.liu@senarytech.com>
    ALSA: hda/conexant: Add quirk for SWS JS201D

Alexander Stein <alexander.stein@ew.tq-group.com>
    mmc: slot-gpio: Allow non-sleeping GPIO ro

Steve Wahl <steve.wahl@hpe.com>
    x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

Aleksander Mazur <deweloper@wp.pl>
    x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: improve crystal stable clock detection

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: max310x: set default value when reading clock ready bit

Vincent Donnefort <vdonnefort@google.com>
    ring-buffer: Clean ring_buffer_poll_wait() error return

Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
    hv_netvsc: Fix race condition between netvsc_probe and netvsc_remove

Sean Young <sean@mess.org>
    media: rc: bpf attach/detach requires write permission

Mario Limonciello <mario.limonciello@amd.com>
    iio: accel: bma400: Fix a compilation problem

zhili.liu <zhili.liu@ucas.com.cn>
    iio: magnetometer: rm3100: add boundary check for the value read from RM3100_REG_TMRC

David Schiller <david.schiller@jku.at>
    staging: iio: ad5933: fix type mismatch regression

Steven Rostedt (Google) <rostedt@goodmis.org>
    tracing: Fix wasted memory in saved_cmdlines logic

Baokun Li <libaokun1@huawei.com>
    ext4: fix double-free of blocks due to wrong extents moved_len

Ekansh Gupta <quic_ekangupt@quicinc.com>
    misc: fastrpc: Mark all sessions as invalid in cb_remove

Carlos Llamas <cmllamas@google.com>
    binder: signal epoll threads of self-work

Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
    ALSA: hda/realtek: Enable headset mic on Vaio VJFE-ADL

Jan Beulich <jbeulich@suse.com>
    xen-netback: properly sync TX responses

Nikita Zhandarovich <n.zhandarovich@fintech.ru>
    net: hsr: remove WARN_ONCE() in send_hsr_supervision_frame()

Fedor Pchelkin <pchelkin@ispras.ru>
    nfc: nci: free rx_data_reassembly skb on NCI device cleanup

Nathan Chancellor <nathan@kernel.org>
    kbuild: Fix changing ELF file type for output of gen_btf for big endian

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    firewire: core: correct documentation of fw_csr_string() kernel API

Ondrej Mosnacek <omosnace@redhat.com>
    lsm: fix the logic in security_inode_getsecctx()

Lee Duncan <lduncan@suse.com>
    scsi: Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"

Radek Krejci <radek.krejci@oracle.com>
    modpost: trim leading spaces when processing source files list

Jean Delvare <jdelvare@suse.de>
    i2c: i801: Fix block process call transactions

Heiner Kallweit <hkallweit1@gmail.com>
    i2c: i801: Remove i801_set_block_buffer_mode

Jiangfeng Xiao <xiaojiangfeng@huawei.com>
    powerpc/kasan: Fix addr error caused by page alignment

Zhipeng Lu <alexious@zju.edu.cn>
    media: ir_toy: fix a memleak in irtoy_tx

yuan linyu <yuanlinyu@hihonor.com>
    usb: f_mass_storage: forbid async queue when shutdown happen

Oliver Neukum <oneukum@suse.com>
    USB: hub: check for alternate port before enabling A_ALT_HNP_SUPPORT

Christian A. Ehrhardt <lk@c--e.de>
    usb: ucsi_acpi: Fix command completion handling

Jason Gerecke <killertofu@gmail.com>
    HID: wacom: Do not register input devices until after hid_hw_start

Tatsunosuke Tobita <tatsunosuke.tobita@wacom.com>
    HID: wacom: generic: Avoid reporting a serial of '0' to userspace

Luka Guzenko <l.guzenko@web.de>
    ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx

David Senoner <seda18@rolmail.net>
    ALSA: hda/realtek: Fix the external mic not being recognised for Acer Swift 1 SF114-32

Zach O'Keefe <zokeefe@google.com>
    mm/writeback: fix possible divide-by-zero in wb_dirty_limits(), again

Masami Hiramatsu (Google) <mhiramat@kernel.org>
    tracing/trigger: Fix to return error if failed to alloc snapshot

Ivan Vecera <ivecera@redhat.com>
    i40e: Fix waiting for queues of all VSIs to be disabled

Guenter Roeck <linux@roeck-us.net>
    MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path for statistics

Alexey Khoroshilov <khoroshilov@ispras.ru>
    ASoC: rt5645: Fix deadlock in rt5645_jack_detect_work()

Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
    spi: ppc4xx: Drop write-only variable

Aaron Conole <aconole@redhat.com>
    net: openvswitch: limit the number of recursions from action sets

Christian A. Ehrhardt <lk@c--e.de>
    of: unittest: Fix compile in the non-dynamic case

David Sterba <dsterba@suse.com>
    btrfs: send: return EOPNOTSUPP on unknown flags

Boris Burkov <boris@bur.io>
    btrfs: forbid deleting live subvol qgroup

Qu Wenruo <wqu@suse.com>
    btrfs: do not ASSERT() if the newly created subvolume already got read

Boris Burkov <boris@bur.io>
    btrfs: forbid creating subvol qgroups

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_set_rbtree: skip end interval element from gc

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix a typo of register name in DPP safety handling

Simon Horman <horms@kernel.org>
    net: stmmac: xgmac: use #define for string constants

Jiri Wiesner <jwiesner@suse.de>
    clocksource: Skip watchdog check for large watchdog intervals

Prathu Baronia <prathubaronia2011@gmail.com>
    vhost: use kzalloc() instead of kmalloc() followed by memset()

Hans de Goede <hdegoede@redhat.com>
    Input: atkbd - skip ATKBD_CMD_SETLEDS when skipping ATKBD_CMD_GETID

Werner Sembach <wse@tuxedocomputers.com>
    Input: i8042 - fix strange behavior of touchpad on Clevo NS70PU

Frederic Weisbecker <frederic@kernel.org>
    hrtimer: Report offline hrtimer enqueue

Prashanth K <quic_prashk@quicinc.com>
    usb: host: xhci-plat: Add support for XHCI_SG_TRB_CACHE_SIZE_QUIRK

Leonard Dallmayr <leonard.dallmayr@mailbox.org>
    USB: serial: cp210x: add ID for IMST iM871A-USB

Puliang Lu <puliang.lu@fibocom.com>
    USB: serial: option: add Fibocom FM101-GL variant

JackBB Wu <wojackbb@gmail.com>
    USB: serial: qcserial: add new usb-id for Dell Wireless DW5826e

Julian Wiedmann <jwi@linux.ibm.com>
    net/af_iucv: clean up a try_then_request_module()

Tejun Heo <tj@kernel.org>
    blk-iocost: Fix an UBSAN shift-out-of-bounds warning

Ming Lei <ming.lei@redhat.com>
    scsi: core: Move scsi_host_busy() out of host lock if it is for per-command

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: remove scratch_aligned pointer

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: add helper to release pcpu scratch area

Florian Westphal <fw@strlen.de>
    netfilter: nft_set_pipapo: store index in scratch maps

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_ct: reject direction for ct id

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: restrict match/target protocol to u16

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_compat: reject unused compat flag

Eric Dumazet <edumazet@google.com>
    ppp_async: limit MRU to 64K

Shigeru Yoshida <syoshida@redhat.com>
    tipc: Check the bearer type before calling tipc_udp_nl_bearer_add()

David Howells <dhowells@redhat.com>
    rxrpc: Fix response to PING RESPONSE ACKs to a dead call

Eric Dumazet <edumazet@google.com>
    inet: read sk->sk_family once in inet_recv_error()

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix bogus core_id to attr name mapping

Zhang Rui <rui.zhang@intel.com>
    hwmon: (coretemp) Fix out-of-bounds memory access

Loic Prylli <lprylli@netflix.com>
    hwmon: (aspeed-pwm-tacho) mutex for tach reading

Zhipeng Lu <alexious@zju.edu.cn>
    atm: idt77252: fix a memleak in open_card_ubr0

Antoine Tenart <atenart@kernel.org>
    tunnels: fix out of bounds access when building IPv6 PMTU error

Paolo Abeni <pabeni@redhat.com>
    selftests: net: avoid just another constant wait

Furong Xu <0x1207@gmail.com>
    net: stmmac: xgmac: fix handling of DPP safety error for DMA channels

Kuogee Hsieh <quic_khsieh@quicinc.com>
    drm/msm/dp: return correct Colorimetry for DP_TEST_DYNAMIC_RANGE_CEA case

Tony Lindgren <tony@atomide.com>
    phy: ti: phy-omap-usb2: Fix NULL pointer dereference for SRP

Frank Li <Frank.Li@nxp.com>
    dmaengine: fix is_slave_direction() return false when DMA_DEV_TO_DEV

Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
    phy: renesas: rcar-gen3-usb2: Fix returning wrong error code

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: fsl-qdma: Fix a memory leak related to the queue command DMA

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    dmaengine: fsl-qdma: Fix a memory leak related to the status queue DMA

Jai Luthra <j-luthra@ti.com>
    dmaengine: ti: k3-udma: Report short packet errors

Guanhua Gao <guanhua.gao@nxp.com>
    dmaengine: fsl-dpaa2-qdma: Fix the size of dma pools

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: sleep: Fix error handling in dpm_prepare()

Alexey Dobriyan <adobriyan@gmail.com>
    uapi: stddef.h: Fix __DECLARE_FLEX_ARRAY for C++

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: remove print in bond_verify_device_path

Benjamin Berg <bberg@redhat.com>
    HID: apple: Add 2021 magic keyboard FN key mapping

Alex Henrie <alexhenrie24@gmail.com>
    HID: apple: Add support for the 2021 Magic Keyboard

Breno Leitao <leitao@debian.org>
    net: sysfs: Fix /sys/class/net/<iface> path

Eric Dumazet <edumazet@google.com>
    af_unix: fix lockdep positive in sk_diag_dump_icons()

Zhipeng Lu <alexious@zju.edu.cn>
    net: ipv4: fix a memleak in ip_setup_cork

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_ct: sanitize layer 3 and 4 protocol number in custom expectations

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_log: replace BUG_ON by WARN_ON_ONCE when putting logger

Eric Dumazet <edumazet@google.com>
    llc: call sock_orphan() at release time

Helge Deller <deller@kernel.org>
    ipv6: Ensure natural alignment of const ipv6 loopback and router addresses

Christophe JAILLET <christophe.jaillet@wanadoo.fr>
    ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ixgbe: Refactor overtemp event handling

Jedrzej Jagielski <jedrzej.jagielski@intel.com>
    ixgbe: Refactor returning internal error codes

Piotr Skajewski <piotrx.skajewski@intel.com>
    ixgbe: Remove non-inclusive language

Eric Dumazet <edumazet@google.com>
    tcp: add sanity checks to rx zerocopy

Arjun Roy <arjunroy@google.com>
    net-zerocopy: Refactor frag-is-remappable test.

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: make sure to pull inner header in __ip6_tnl_rcv()

Eric Dumazet <edumazet@google.com>
    ip6_tunnel: use dev_sw_netstats_rx_add()

Ming Lei <ming.lei@redhat.com>
    scsi: core: Move scsi_host_busy() out of host lock for waking up EH handler

Bart Van Assche <bvanassche@acm.org>
    scsi: core: Introduce enum scsi_disposition

Su Hui <suhui@nfschina.com>
    scsi: isci: Fix an error code problem in isci_io_request_build()

Stephen Rothwell <sfr@canb.auug.org.au>
    drm: using mul_u32_u32() requires linux/math64.h

Edward Adam Davis <eadavis@qq.com>
    wifi: cfg80211: fix RCU dereference in __cfg80211_bss_update

Peter Zijlstra <peterz@infradead.org>
    perf: Fix the nr_addr_filters fix

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Release 'adev->pm.fw' before return in 'amdgpu_device_need_post()'

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amd/powerplay: Fix kzalloc parameter 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'

Xiubo Li <xiubli@redhat.com>
    ceph: fix deadlock or deadcode of misusing dget()

Ming Lei <ming.lei@redhat.com>
    blk-mq: fix IO hang from sbitmap wakeup race

Zhu Yanjun <yanjun.zhu@linux.dev>
    virtio_net: Fix "‘%d’ directive writing between 1 and 11 bytes into a region of size 10" warnings

Ian Rogers <irogers@google.com>
    libsubcmd: Fix memory leak in uniq()

Hans de Goede <hdegoede@redhat.com>
    misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback

Bjorn Helgaas <bhelgaas@google.com>
    PCI/AER: Decode Requester ID when no error info found

Max Kellermann <max.kellermann@ionos.com>
    fs/kernfs/dir: obey S_ISGID

Adrian Reber <areber@redhat.com>
    tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE

Hardik Gajjar <hgajjar@de.adit-jv.com>
    usb: hub: Replace hardcoded quirk value with BIT() macro

Daniel Stodden <dns@arista.com>
    PCI: switchtec: Fix stdev_release() crash after surprise hot remove

Guilherme G. Piccoli <gpiccoli@igalia.com>
    PCI: Only override AMD USB controller if required

Peter Robinson <pbrobinson@gmail.com>
    mfd: ti_am335x_tscadc: Fix TI SoC dependencies

Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
    xen/gntdev: Fix the abuse of underlying struct page in DMA-buf import

Harshit Shah <harshitshah.opendev@gmail.com>
    i3c: master: cdns: Update maximum prescaler value for i2c clock

Nathan Chancellor <nathan@kernel.org>
    um: net: Fix return type of uml_net_start_xmit()

Benjamin Berg <benjamin@sipsolutions.net>
    um: Don't use vfprintf() for os_info()

Anton Ivanov <anton.ivanov@cambridgegreys.com>
    um: Fix naming clash between UML and scheduler

Heiner Kallweit <hkallweit1@gmail.com>
    leds: trigger: panic: Don't register panic notifier if creating the trigger failed

Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
    drm/amdgpu: Drop 'fence' check in 'to_amdgpu_amdkfd_fence()'

Felix Kuehling <Felix.Kuehling@amd.com>
    drm/amdgpu: Let KFD sync with VM fences

Josip Pavic <josip.pavic@amd.com>
    drm/amd/display: make flip_timestamp_in_us a 64-bit variable

Werner Fischer <devlists@wefi.net>
    watchdog: it87_wdt: Keep WDTCTRL bit 3 unmodified for IT8784/IT8786

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()

Kuan-Wei Chiu <visitorckw@gmail.com>
    clk: hi3620: Fix memory leak in hi3620_mmc_clk_init()

Rob Clark <robdclark@chromium.org>
    drm/msm/dpu: Ratelimit framedone timeout msgs

Su Hui <suhui@nfschina.com>
    media: ddbridge: fix an error code problem in ddb_probe

Daniel Vacek <neelx@redhat.com>
    IB/ipoib: Fix mcast list locking

Douglas Anderson <dianders@chromium.org>
    drm/exynos: Call drm_atomic_helper_shutdown() at shutdown/unbind time

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: intel-dspcfg: add filters for ARL-S and ARL

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    ALSA: hda: Intel: add HDA_ARL PCI ID support

Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
    PCI: add INTEL_HDA_ARL to pci_ids.h

Michael Tretter <m.tretter@pengutronix.de>
    media: rockchip: rga: fix swizzling for RGB formats

Ghanshyam Agrawal <ghanshyam1898@gmail.com>
    media: stk1160: Fixed high volume of stk1160_dbg messages

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/mipi-dsi: Fix detach call without attach

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/framebuffer: Fix use of uninitialized variable

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/drm_file: fix use of uninitialized variable

Jaegeuk Kim <jaegeuk@kernel.org>
    f2fs: fix write pointers on zoned device after roll forward

Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
    drm/amd/display: Fix tiled display misalignment

Jack Wang <jinpu.wang@ionos.com>
    RDMA/IPoIB: Fix error code return in ipoib_mcast_join

Al Viro <viro@zeniv.linux.org.uk>
    fast_dput(): handle underflows gracefully

Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
    ASoC: doc: Fix undefined SND_SOC_DAPM_NOPM argument

Takashi Iwai <tiwai@suse.de>
    ALSA: hda: Refer to correct stream index at loops

Chao Yu <chao@kernel.org>
    f2fs: fix to check return value of f2fs_reserve_new_block()

Andrii Staikov <andrii.staikov@intel.com>
    i40e: Fix VF disable behavior to block all traffic

Frédéric Danis <frederic.danis@collabora.com>
    Bluetooth: L2CAP: Fix possible multiple reject send

Zijun Hu <quic_zijuhu@quicinc.com>
    Bluetooth: qca: Set both WIDEBAND_SPEECH and LE_STATES quirks for QCA2066

Benjamin Berg <benjamin.berg@intel.com>
    wifi: cfg80211: free beacon_ies when overridden from hidden BSS

Su Hui <suhui@nfschina.com>
    wifi: rtlwifi: rtl8723{be,ae}: using calculate_bit_shift()

Zenm Chen <zenmchen@gmail.com>
    wifi: rtl8xxxu: Add additional USB IDs for RTL8192EU devices

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property

Mao Jinlong <quic_jinlmao@quicinc.com>
    arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property

Alex Lyakas <alex.lyakas@zadara.com>
    md: Whenassemble the array, consult the superblock of the freshest device

Christoph Hellwig <hch@lst.de>
    block: prevent an integer overflow in bvec_try_merge_hw_page

Tobias Waldekranz <tobias@waldekranz.com>
    net: dsa: mv88e6xxx: Fix mv88e6352_serdes_get_stats error path

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23/28: Fix the DMA controller node name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx23-sansa: Use preferred i2c-gpios properties

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27-apf27dev: Fix LED name

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25/27: Pass timing0

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25: Fix the iim compatible string

Kees Cook <keescook@chromium.org>
    block/rnbd-srv: Check for unlikely string overflow

Shannon Nelson <shannon.nelson@amd.com>
    ionic: pass opcode to devcmd_wait

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx1: Fix sram node

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx27: Fix sram node

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx: Use flash@0,0 pattern

Fabio Estevam <festevam@denx.de>
    ARM: dts: imx25/27-eukrea: Fix RTC node name

Johan Jonker <jbx6244@gmail.com>
    ARM: dts: rockchip: fix rk3036 hdmi ports node

Hou Tao <houtao1@huawei.com>
    bpf: Set uattr->batch.count as zero before batched update or deletion

Hannes Reinecke <hare@suse.de>
    scsi: libfc: Fix up timeout error in fc_fcp_rec_error()

Hannes Reinecke <hare@suse.de>
    scsi: libfc: Don't schedule abort twice

Hou Tao <houtao1@huawei.com>
    bpf: Add map and need_defer parameters to .map_fd_put_ptr()

Minsuk Kang <linuxlovemin@yonsei.ac.kr>
    wifi: ath9k: Fix potential array-index-out-of-bounds read in ath9k_htc_txstatus()

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7s: Fix nand-controller #size-cells

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7s: Fix lcdif compatible

Alexander Stein <alexander.stein@ew.tq-group.com>
    ARM: dts: imx7d: Fix coresight funnel ports

ching Huang <ching2048@areca.com.tw>
    scsi: arcmsr: Support new PCI device IDs 1883 and 1886

Zhengchao Shao <shaozhengchao@huawei.com>
    bonding: return -ENOMEM instead of BUG in alb_upper_dev_walk

Ido Schimmel <idosch@nvidia.com>
    PCI: Add no PM reset quirk for NVIDIA Spectrum devices

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible file string name overflow when updating firmware

Yonghong Song <yonghong.song@linux.dev>
    selftests/bpf: Fix pyperf180 compilation failure with clang18

Andrii Nakryiko <andrii@kernel.org>
    selftests/bpf: satisfy compiler by having explicit return in btf test

Shiji Yang <yangshiji66@outlook.com>
    wifi: rt2x00: restart beacon queue when hardware reset

Baokun Li <libaokun1@huawei.com>
    ext4: avoid online resizing failures due to oversized flex bg

Baokun Li <libaokun1@huawei.com>
    ext4: remove unnecessary check from alloc_flex_gd()

Baokun Li <libaokun1@huawei.com>
    ext4: unify the type of flexbg_size to unsigned int

Ye Bin <yebin10@huawei.com>
    ext4: fix inconsistent between segment fstrim and full fstrim

Gabriel Krisman Bertazi <krisman@suse.de>
    ecryptfs: Reject casefold directory inodes

Anna Schumaker <Anna.Schumaker@Netapp.com>
    SUNRPC: Fix a suspicious RCU usage warning

Heiko Carstens <hca@linux.ibm.com>
    KVM: s390: fix setting of fpc register

Heiko Carstens <hca@linux.ibm.com>
    s390/ptrace: handle setting of fpc register correctly

Edward Adam Davis <eadavis@qq.com>
    jfs: fix array-index-out-of-bounds in diNewExt

Oleg Nesterov <oleg@redhat.com>
    rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()

Oleg Nesterov <oleg@redhat.com>
    afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()

Oleg Nesterov <oleg@redhat.com>
    afs: fix the usage of read_seqbegin_or_lock() in afs_lookup_volume_rcu()

Thomas Bourgoin <thomas.bourgoin@foss.st.com>
    crypto: stm32/crc32 - fix parsing list of devices

Weichen Chen <weichen.chen@mediatek.com>
    pstore/ram: Fix crash when setting number of cpus to an odd number

Edward Adam Davis <eadavis@qq.com>
    jfs: fix uaf in jfs_evict_inode

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix array-index-out-of-bounds in dbAdjTree

Manas Ghandat <ghandatmanas@gmail.com>
    jfs: fix slab-out-of-bounds Read in dtSearch

Osama Muhammad <osmtendev@gmail.com>
    UBSAN: array-index-out-of-bounds in dtSplitRoot

Osama Muhammad <osmtendev@gmail.com>
    FS:JFS:UBSAN:array-index-out-of-bounds in dbAdjTree

Shuai Xue <xueshuai@linux.alibaba.com>
    ACPI: APEI: set memory failure flags as MF_ACTION_REQUIRED on synchronous events

Mukesh Ojha <quic_mojha@quicinc.com>
    PM / devfreq: Synchronize devfreq_monitor_[start/stop]

Prarit Bhargava <prarit@redhat.com>
    ACPI: extlog: fix NULL pointer dereference check

Dmitry Antipov <dmantipov@yandex.ru>
    PNP: ACPI: fix fortify warning

Yuluo Qiu <qyl27@outlook.com>
    ACPI: video: Add quirk for the Colorful X15 AT 23 Laptop

Chris Riches <chris.riches@nutanix.com>
    audit: Send netlink ACK before setting connection in auditd_set

Rui Zhang <zr.zhang@vivo.com>
    regulator: core: Only increment use_count when enable_count changes

Andrzej Hajda <andrzej.hajda@intel.com>
    debugobjects: Stop accessing objects after releasing hash bucket lock

Greg KH <gregkh@linuxfoundation.org>
    perf/core: Fix narrow startup race when creating the perf nr_addr_filters sysfs file

Zhiquan Li <zhiquan1.li@intel.com>
    x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Naveen N Rao <naveen@kernel.org>
    powerpc/lib: Validate size for vector operations

Stephen Rothwell <sfr@canb.auug.org.au>
    powerpc: pmd_move_must_withdraw() is only needed for CONFIG_TRANSPARENT_HUGEPAGE

Jun'ichi Nomura <junichi.nomura@nec.com>
    x86/boot: Ignore NMIs during very early boot

Michael Ellerman <mpe@ellerman.id.au>
    powerpc/mm: Fix build failures due to arch_reserved_kernel_pages()

Michael Ellerman <mpe@ellerman.id.au>
    powerpc: Fix build error due to is_valid_bugaddr()

Mark Rutland <mark.rutland@arm.com>
    drivers/perf: pmuv3: don't expose SW_INCR event in sysfs

Kunwu Chan <chentao@kylinos.cn>
    powerpc/mm: Fix null-pointer dereference in pgtable_cache_add

Richard Palethorpe <rpalethorpe@suse.com>
    x86/entry/ia32: Ensure s32 is sign extended to s64

Tim Chen <tim.c.chen@linux.intel.com>
    tick/sched: Preserve number of idle sleeps across CPU hotplug events

Xi Ruoyao <xry111@xry111.site>
    mips: Call lose_fpu(0) before initializing fcr31 in mips_set_personality_nan

Kamal Dasu <kamal.dasu@broadcom.com>
    spi: bcm-qspi: fix SFDP BFPT read by usig mspi read

Wenhua Lin <Wenhua.Lin@unisoc.com>
    gpio: eic-sprd: Clear interrupt after set the interrupt type

Fedor Pchelkin <pchelkin@ispras.ru>
    drm/exynos: gsc: minor fix for loop iteration in gsc_runtime_resume

Arnd Bergmann <arnd@arndb.de>
    drm/exynos: fix accidental on-stack copy of exynos_drm_plane

Markus Niebel <Markus.Niebel@ew.tq-group.com>
    drm: panel-simple: add missing bus flags for Tianma tm070jvhg[30/33]

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Add documenting comment for nfsd4_release_lockowner()

Chuck Lever <chuck.lever@oracle.com>
    NFSD: Modernize nfsd4_release_lockowner()

Omar Sandoval <osandov@fb.com>
    btrfs: avoid copying BTRFS_ROOT_SUBVOL_DEAD flag to snapshot of subvolume being deleted

Nikolay Borisov <nborisov@suse.com>
    btrfs: remove err variable from btrfs_delete_subvolume

Charan Teja Kalla <quic_charante@quicinc.com>
    mm/sparsemem: fix race in accessing memory_section->usage

Rolf Eike Beer <eb@emlix.com>
    mm: use __pfn_to_section() instead of open coding it

Zheng Wang <zyytlz.wz@163.com>
    media: mtk-jpeg: Fix use after free bug due to error path handling in mtk_jpeg_dec_device_run

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sc7180: fix USB wakeup interrupt types

Sandeep Maheswaram <sanm@codeaurora.org>
    arm64: dts: qcom: sc7180: Use pdc interrupts for USB instead of GIC interrupts

Paul Cercueil <paul@crapouillou.net>
    ARM: dts: samsung: exynos4210-i9100: Unconditionally enable LDO12

Lukas Schauer <lukas@schauer.dev>
    pipe: wakeup wr_wait after setting max_usage

Max Kellermann <max.kellermann@ionos.com>
    fs/pipe: move check to pipe_has_watch_queue()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: sleep: Fix possible deadlocks in core system-wide PM code

Li zeming <zeming@nfschina.com>
    PM: core: Remove unnecessary (void *) conversions

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    PM: sleep: Avoid calling put_device() under dpm_list_mtx

Bjorn Helgaas <bhelgaas@google.com>
    PM: sleep: Use dev_printk() when possible

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: simplify some error checking

Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
    drm/tidss: Fix atomic_flush check

Dan Carpenter <dan.carpenter@linaro.org>
    drm/bridge: nxp-ptn3460: fix i2c_master_send() error checking

Ville Syrjälä <ville.syrjala@linux.intel.com>
    drm: Don't unref the same fb many times by mistake due to deadlock handling

Mario Limonciello <mario.limonciello@amd.com>
    gpiolib: acpi: Ignore touchpad wakeup on GPD G1619-04

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: reject QUEUE/DROP verdict parameters

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nft_chain_filter: handle NETDEV_UNREGISTER for inet/ingress basechain

Emmanuel Grumbach <emmanuel.grumbach@intel.com>
    wifi: iwlwifi: fix a memory corruption

Bernd Edlinger <bernd.edlinger@hotmail.de>
    exec: Fix error handling in begin_new_exec()

Ilya Dryomov <idryomov@gmail.com>
    rbd: don't move requests to the running list on errors

Omar Sandoval <osandov@fb.com>
    btrfs: don't abort filesystem when attempting to snapshot deleted subvolume

Qu Wenruo <wqu@suse.com>
    btrfs: defrag: reject unknown flags of btrfs_ioctl_defrag_range_args

David Sterba <dsterba@suse.com>
    btrfs: don't warn if discard range is not aligned to sector

Chung-Chiang Cheng <cccheng@synology.com>
    btrfs: tree-checker: fix inline ref size in error messages

Fedor Pchelkin <pchelkin@ispras.ru>
    btrfs: ref-verify: free ref cache before clearing mount opt

Shenwei Wang <shenwei.wang@nxp.com>
    net: fec: fix the unhandled context fault from smmu

Zhipeng Lu <alexious@zju.edu.cn>
    fjes: fix memleaks in fjes_hw_setup

Jakub Kicinski <kuba@kernel.org>
    selftests: netdevsim: fix the udp_tunnel_nic test

Jenishkumar Maheshbhai Patel <jpatel2@marvell.com>
    net: mvpp2: clear BM pool before initialization

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: validate NFPROTO_* family

Florian Westphal <fw@strlen.de>
    netfilter: nf_tables: restrict anonymous set and map names to 16 bytes

Zhipeng Lu <alexious@zju.edu.cn>
    net/mlx5e: fix a double-free in arfs_create_groups

Yevgeny Kliteynik <kliteyn@nvidia.com>
    net/mlx5: DR, Use the right GVMI number for drop action

Zhengchao Shao <shaozhengchao@huawei.com>
    ipv6: init the accept_queue's spinlocks in inet6_create

Zhengchao Shao <shaozhengchao@huawei.com>
    netlink: fix potential sleeping issue in mqueue_flush_file

Salvatore Dipietro <dipiets@amazon.com>
    tcp: Add memory barrier to tcp_push()

David Howells <dhowells@redhat.com>
    afs: Hide silly-rename files from userspace

Petr Pavlu <petr.pavlu@suse.com>
    tracing: Ensure visibility when inserting an element into tracing_map

Sharath Srinivasan <sharath.srinivasan@oracle.com>
    net/rds: Fix UBSAN: array-index-out-of-bounds in rds_cmsg_recv

Kuniyuki Iwashima <kuniyu@amazon.com>
    llc: Drop support for ETH_P_TR_802_2.

Eric Dumazet <edumazet@google.com>
    llc: make llc_ui_sendmsg() more robust against bonding changes

Lin Ma <linma@zju.edu.cn>
    vlan: skip nested type that is not IFLA_VLAN_QOS_MAPPING

Michael Chan <michael.chan@broadcom.com>
    bnxt_en: Wait for FLR to complete during probe

Zhengchao Shao <shaozhengchao@huawei.com>
    tcp: make sure init the accept_queue's spinlocks once

Wen Gu <guwen@linux.alibaba.com>
    net/smc: fix illegal rmb_desc access in SMC-D connection dump

Paolo Bonzini <pbonzini@redhat.com>
    KVM: use __vcalloc for very large allocations

Paolo Bonzini <pbonzini@redhat.com>
    mm: vmalloc: introduce array allocation functions

Kees Cook <keescook@chromium.org>
    smb3: Replace smb2pdu 1-element arrays with flex-arrays

Kees Cook <keescook@chromium.org>
    stddef: Introduce DECLARE_FLEX_ARRAY() helper

Matthew Wilcox (Oracle) <willy@infradead.org>
    block: Remove special-casing of compound pages

Al Viro <viro@zeniv.linux.org.uk>
    rename(): fix the locking of subdirectories

Zhihao Cheng <chengzhihao1@huawei.com>
    ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

Dave Airlie <airlied@redhat.com>
    nouveau/vmm: don't set addr on the fail path to avoid warning

Mario Limonciello <mario.limonciello@amd.com>
    rtc: Adjust failure return code for cmos_set_alarm()

Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    mmc: mmc_spi: remove custom DMA mapped buffers

Avri Altman <avri.altman@wdc.com>
    mmc: core: Use mrq.sbc in close-ended ffu

Vegard Nossum <vegard.nossum@oracle.com>
    scripts/get_abi: fix source path leak

Alfred Piccioni <alpic@google.com>
    lsm: new security_file_ioctl_compat() hook

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB DP/DM HS PHY interrupts

Johan Hovold <johan+linaro@kernel.org>
    arm64: dts: qcom: sdm845: fix USB wakeup interrupt types

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    async: Introduce async_schedule_dev_nocall()

Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    async: Split async_schedule_node_domain()

Helge Deller <deller@gmx.de>
    parisc/firmware: Fix F-extend for PDC addresses

Qiang Yu <quic_qianyu@quicinc.com>
    bus: mhi: host: Drop chan lock before queuing buffers

Xiaolei Wang <xiaolei.wang@windriver.com>
    rpmsg: virtio: Free driver_override when rpmsg_remove()

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: s390/aes - Fix buffer overread in CTR mode

Herbert Xu <herbert@gondor.apana.org.au>
    hwrng: core - Fix page fault dead lock on mmap-ed hwrng

Hongchen Zhang <zhanghongchen@loongson.cn>
    PM: hibernate: Enforce ordering during image compression/decompression

Herbert Xu <herbert@gondor.apana.org.au>
    crypto: api - Disallow identical driver names

Suraj Jitindar Singh <surajjs@amazon.com>
    ext4: allow for the last group to be marked as trimmed

Jonathan Cameron <Jonathan.Cameron@huawei.com>
    iio:adc:ad7091r: Move exports into IIO_AD7091R namespace.

Amelie Delaunay <amelie.delaunay@foss.st.com>
    dmaengine: fix NULL pointer in channel unregistration function

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Enable internal vref if external vref is not supplied

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Allow users to configure device events

Marcelo Schmitt <marcelo.schmitt@analog.com>
    iio: adc: ad7091r: Set alert bit in config register

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: add check for unsupported SPI modes during probe

Oleksij Rempel <linux@rempel-privat.de>
    spi: introduce SPI_MODE_X_MASK macro

Hugo Villeneuve <hvilleneuve@dimonoff.com>
    serial: sc16is7xx: set safe default SPI clock frequency

Daniel Lezcano <daniel.lezcano@linaro.org>
    units: add the HZ macros

Daniel Lezcano <daniel.lezcano@linaro.org>
    units: change from 'L' to 'UL'

qizhong cheng <qizhong.cheng@mediatek.com>
    PCI: mediatek: Clear interrupt status before dispatching handler

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg enabled

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix iso transfer error when mult is not zero

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix incorrect calculation of ep_buf_size when more than one config

Frank Li <Frank.Li@nxp.com>
    usb: cdns3: fix uvc failure work since sg support enabled

Pawel Laszczak <pawell@cadence.com>
    usb: cdns3: Fixes for sparse warnings


-------------

Diffstat:

 Documentation/ABI/testing/sysfs-class-net-queues   |  22 +-
 .../ABI/testing/sysfs-class-net-statistics         |  48 ++--
 .../bindings/net/wireless/marvell-8xxx.txt         |   4 +-
 Documentation/filesystems/directory-locking.rst    |  29 +--
 Documentation/filesystems/locking.rst              |   5 +-
 Documentation/filesystems/porting.rst              |  18 ++
 Documentation/sound/soc/dapm.rst                   |   2 +-
 Makefile                                           |   4 +-
 arch/arm/boot/dts/exynos4210-i9100.dts             |   8 +
 arch/arm/boot/dts/imx1-ads.dts                     |   2 +-
 arch/arm/boot/dts/imx1-apf9328.dts                 |   2 +-
 arch/arm/boot/dts/imx1.dtsi                        |   5 +-
 arch/arm/boot/dts/imx23-sansa.dts                  |  12 +-
 arch/arm/boot/dts/imx23.dtsi                       |   2 +-
 arch/arm/boot/dts/imx25-eukrea-cpuimx25.dtsi       |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dts  |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-svga.dts  |   2 +-
 .../imx25-eukrea-mbimxsd25-baseboard-dvi-vga.dts   |   2 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx25.dtsi                       |   2 +-
 arch/arm/boot/dts/imx27-apf27dev.dts               |   4 +-
 arch/arm/boot/dts/imx27-eukrea-cpuimx27.dtsi       |   4 +-
 .../boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts  |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts   |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts     |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   2 +-
 arch/arm/boot/dts/imx27.dtsi                       |   3 +
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/imx7d.dtsi                       |   3 -
 arch/arm/boot/dts/imx7s.dtsi                       |  10 +-
 arch/arm/boot/dts/rk3036.dtsi                      |  14 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi              |  21 ++
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  32 ++-
 arch/arm64/boot/dts/qcom/sc7180.dtsi               |   8 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi               |  16 +-
 arch/arm64/kernel/entry.S                          |   8 +-
 arch/arm64/kernel/perf_event.c                     |   6 +-
 arch/mips/include/asm/checksum.h                   |   3 +-
 arch/mips/kernel/elf.c                             |   6 +
 arch/mips/mm/init.c                                |  15 +-
 arch/parisc/kernel/firmware.c                      |   4 +-
 arch/powerpc/include/asm/mmu.h                     |   4 +
 arch/powerpc/include/asm/mmzone.h                  |   3 -
 arch/powerpc/kernel/traps.c                        |   2 +
 arch/powerpc/kvm/book3s_hv_uvmem.c                 |   2 +-
 arch/powerpc/lib/sstep.c                           |  10 +
 arch/powerpc/mm/book3s64/pgtable.c                 |   2 +
 arch/powerpc/mm/init-common.c                      |   5 +-
 arch/powerpc/mm/kasan/kasan_init_32.c              |   1 +
 arch/s390/crypto/aes_s390.c                        |   4 +-
 arch/s390/crypto/paes_s390.c                       |   4 +-
 arch/s390/kernel/ptrace.c                          |   6 +-
 arch/s390/kvm/kvm-s390.c                           |   5 -
 arch/um/drivers/net_kern.c                         |   2 +-
 arch/um/include/shared/kern_util.h                 |   2 +-
 arch/um/kernel/process.c                           |   2 +-
 arch/um/os-Linux/helper.c                          |   6 +-
 arch/um/os-Linux/util.c                            |  19 +-
 arch/x86/Kconfig.cpu                               |   2 +-
 arch/x86/boot/compressed/ident_map_64.c            |   5 +
 arch/x86/boot/compressed/idt_64.c                  |   1 +
 arch/x86/boot/compressed/idt_handlers_64.S         |   1 +
 arch/x86/boot/compressed/misc.h                    |   1 +
 arch/x86/include/asm/syscall_wrapper.h             |  25 +-
 arch/x86/kernel/cpu/mce/core.c                     |  16 ++
 arch/x86/kvm/mmu/page_track.c                      |   2 +-
 arch/x86/kvm/x86.c                                 |   4 +-
 arch/x86/mm/ident_map.c                            |  23 +-
 block/bio.c                                        |   9 +-
 block/blk-iocost.c                                 |   7 +
 block/blk-mq.c                                     |  16 ++
 crypto/algapi.c                                    |   1 +
 drivers/acpi/acpi_extlog.c                         |   5 +-
 drivers/acpi/acpi_video.c                          |   9 +
 drivers/acpi/apei/ghes.c                           |  29 ++-
 drivers/android/binder.c                           |  10 +
 drivers/ata/libata-eh.c                            |   2 +-
 drivers/atm/idt77252.c                             |   2 +
 drivers/base/power/domain.c                        |   2 +-
 drivers/base/power/main.c                          | 251 +++++++++++----------
 drivers/base/power/runtime.c                       |  22 ++
 drivers/block/rbd.c                                |  22 +-
 drivers/block/rnbd/rnbd-srv.c                      |  19 +-
 drivers/bluetooth/hci_qca.c                        |   1 +
 drivers/bus/mhi/host/main.c                        |   4 +
 drivers/bus/moxtet.c                               |   7 +
 drivers/char/hw_random/core.c                      |  36 +--
 drivers/clk/hisilicon/clk-hi3620.c                 |   4 +-
 drivers/clk/mmp/clk-of-pxa168.c                    |   3 +
 drivers/crypto/ccp/sev-dev.c                       |  10 +-
 drivers/crypto/stm32/stm32-crc32.c                 |   2 +-
 drivers/devfreq/devfreq.c                          |  24 +-
 drivers/dma/dmaengine.c                            |   3 +
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c            |  10 +-
 drivers/dma/fsl-qdma.c                             |  27 +--
 drivers/dma/ti/k3-udma.c                           |  10 +-
 drivers/firewire/core-device.c                     |   7 +-
 drivers/gpio/gpio-eic-sprd.c                       |  32 ++-
 drivers/gpio/gpiolib-acpi.c                        |  14 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c           |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c           |   4 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h       |   2 +-
 .../amd/pm/powerplay/hwmgr/process_pptables_v1_0.c |   2 +-
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |   6 +-
 drivers/gpu/drm/drm_file.c                         |   2 +-
 drivers/gpu/drm/drm_framebuffer.c                  |   2 +-
 drivers/gpu/drm/drm_mipi_dsi.c                     |  17 +-
 drivers/gpu/drm/drm_plane.c                        |   1 +
 drivers/gpu/drm/exynos/exynos5433_drm_decon.c      |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_drv.c            |  11 +
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   4 +-
 drivers/gpu/drm/exynos/exynos_drm_gsc.c            |   2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   5 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h            |   1 +
 drivers/gpu/drm/msm/dp/dp_link.c                   |  12 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |   3 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   4 +
 drivers/gpu/drm/nouveau/nouveau_vmm.c              |   3 +
 drivers/gpu/drm/panel/panel-simple.c               |   2 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
 drivers/hid/hid-apple.c                            |  33 ++-
 drivers/hid/hid-ids.h                              |   1 +
 drivers/hid/hid-quirks.c                           |   1 +
 drivers/hid/wacom_sys.c                            |  63 ++++--
 drivers/hid/wacom_wac.c                            |   9 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   7 +
 drivers/hwmon/coretemp.c                           |  40 ++--
 drivers/i2c/busses/i2c-i801.c                      |  19 +-
 drivers/i3c/master/i3c-master-cdns.c               |   7 +-
 drivers/iio/accel/Kconfig                          |   2 +
 drivers/iio/adc/ad7091r-base.c                     | 173 +++++++++++++-
 drivers/iio/adc/ad7091r-base.h                     |   8 +
 drivers/iio/adc/ad7091r5.c                         |  29 +--
 drivers/iio/magnetometer/rm3100-core.c             |  10 +-
 drivers/infiniband/ulp/ipoib/ipoib_multicast.c     |   7 +-
 drivers/input/keyboard/atkbd.c                     |  13 +-
 drivers/input/serio/i8042-acpipnpio.h              |   6 +
 drivers/irqchip/irq-brcmstb-l2.c                   |   5 +-
 drivers/irqchip/irq-gic-v3-its.c                   |  22 +-
 drivers/leds/trigger/ledtrig-panic.c               |   5 +-
 drivers/md/dm-core.h                               |   2 +
 drivers/md/dm-ioctl.c                              |   3 +-
 drivers/md/dm-table.c                              |   9 +-
 drivers/md/md.c                                    |  54 ++++-
 drivers/md/raid5.c                                 |  12 -
 drivers/media/pci/ddbridge/ddbridge-main.c         |   2 +-
 drivers/media/platform/mtk-jpeg/mtk_jpeg_core.c    |   6 +-
 drivers/media/platform/rockchip/rga/rga.c          |  15 +-
 drivers/media/rc/bpf-lirc.c                        |   6 +-
 drivers/media/rc/ir_toy.c                          |   2 +
 drivers/media/rc/lirc_dev.c                        |   5 +-
 drivers/media/rc/rc-core-priv.h                    |   2 +-
 drivers/media/usb/stk1160/stk1160-video.c          |   5 +-
 drivers/mfd/Kconfig                                |   1 +
 drivers/misc/fastrpc.c                             |   2 +-
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c             |   1 +
 drivers/mmc/core/block.c                           |  46 +++-
 drivers/mmc/core/slot-gpio.c                       |   6 +-
 drivers/mmc/host/mmc_spi.c                         | 186 +--------------
 drivers/net/bonding/bond_alb.c                     |   3 +-
 drivers/net/dsa/mv88e6xxx/chip.h                   |   4 +-
 drivers/net/dsa/mv88e6xxx/serdes.c                 |   8 +-
 drivers/net/dsa/mv88e6xxx/serdes.h                 |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c          |   5 +
 drivers/net/ethernet/broadcom/genet/bcmgenet.c     |  22 +-
 drivers/net/ethernet/broadcom/genet/bcmgenet.h     |   3 +
 drivers/net/ethernet/broadcom/genet/bcmmii.c       |   6 +
 drivers/net/ethernet/freescale/fec_main.c          |   2 +
 drivers/net/ethernet/intel/i40e/i40e_main.c        |   2 +-
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  32 +++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 +
 drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c     |  36 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c     |  61 +++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_common.c    | 177 +++++++--------
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c   |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c      |  44 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.c       |  34 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h       |   1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c       | 105 ++++-----
 drivers/net/ethernet/intel/ixgbe/ixgbe_phy.h       |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c     |   2 +-
 drivers/net/ethernet/intel/ixgbe/ixgbe_type.h      |  51 +----
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c      |  44 ++--
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c      | 149 ++++++------
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  27 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en_arfs.c  |  26 ++-
 .../mellanox/mlx5/core/steering/dr_action.c        |   1 +
 .../ethernet/netronome/nfp/flower/tunnel_conf.c    |   2 +-
 .../ethernet/netronome/nfp/nfpcore/nfp6000_pcie.c  |   6 +-
 drivers/net/ethernet/pensando/ionic/ionic_dev.c    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_dev.h    |   1 +
 drivers/net/ethernet/pensando/ionic/ionic_main.c   |   2 +-
 drivers/net/ethernet/stmicro/stmmac/common.h       |   1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h     |   3 +
 .../net/ethernet/stmicro/stmmac/dwxgmac2_core.c    |  58 ++++-
 drivers/net/fjes/fjes_hw.c                         |  37 ++-
 drivers/net/hyperv/netvsc.c                        |   5 +-
 drivers/net/ppp/ppp_async.c                        |   4 +
 drivers/net/virtio_net.c                           |   9 +-
 drivers/net/wireless/ath/ath9k/htc_drv_txrx.c      |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-dbg-tlv.c   |   2 +-
 drivers/net/wireless/marvell/mwifiex/Kconfig       |   5 +-
 drivers/net/wireless/marvell/mwifiex/sdio.c        |  67 +++++-
 drivers/net/wireless/marvell/mwifiex/sdio.h        |   8 +
 drivers/net/wireless/ralink/rt2x00/rt2x00dev.c     |   3 +
 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c     |  11 +
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  |  12 +
 .../net/wireless/realtek/rtlwifi/rtl8723ae/phy.c   |   6 +-
 .../net/wireless/realtek/rtlwifi/rtl8723be/phy.c   |   4 +-
 drivers/net/xen-netback/netback.c                  | 100 ++++----
 drivers/of/property.c                              |   2 +-
 drivers/of/unittest.c                              |  12 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   2 +
 drivers/pci/controller/pcie-mediatek.c             |  10 +-
 drivers/pci/pcie/aer.c                             |   9 +-
 drivers/pci/quirks.c                               |  24 +-
 drivers/pci/switch/switchtec.c                     |  25 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c           |   4 -
 drivers/phy/ti/phy-omap-usb2.c                     |   4 +-
 drivers/pnp/pnpacpi/rsparser.c                     |  12 +-
 drivers/regulator/core.c                           |  52 +++--
 drivers/rpmsg/virtio_rpmsg_bus.c                   |   1 +
 drivers/rtc/rtc-cmos.c                             |   4 +-
 drivers/s390/net/qeth_l3_main.c                    |   9 +-
 drivers/scsi/arcmsr/arcmsr.h                       |   4 +
 drivers/scsi/arcmsr/arcmsr_hba.c                   |   6 +
 drivers/scsi/device_handler/scsi_dh_alua.c         |   4 +-
 drivers/scsi/device_handler/scsi_dh_emc.c          |   4 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c         |   4 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                      |  20 +-
 drivers/scsi/isci/request.c                        |   2 +-
 drivers/scsi/libfc/fc_fcp.c                        |  18 +-
 drivers/scsi/lpfc/lpfc.h                           |   1 +
 drivers/scsi/lpfc/lpfc_init.c                      |   4 +-
 drivers/scsi/scsi_error.c                          |  73 +++---
 drivers/scsi/scsi_lib.c                            |   6 +-
 drivers/scsi/scsi_priv.h                           |   4 +-
 drivers/spi/spi-bcm-qspi.c                         |   4 +-
 drivers/spi/spi-ppc4xx.c                           |   5 -
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
 drivers/tty/serial/8250/8250_core.c                |   1 +
 drivers/tty/serial/8250/8250_exar.c                |  13 ++
 drivers/tty/serial/max310x.c                       |  21 +-
 drivers/tty/serial/sc16is7xx.c                     |   8 +-
 drivers/tty/tty_ioctl.c                            |   4 +-
 drivers/usb/cdns3/ep0.c                            |   4 +-
 drivers/usb/cdns3/gadget.c                         | 152 +++++++++----
 drivers/usb/cdns3/gadget.h                         |   3 +
 drivers/usb/core/hub.c                             |  34 +--
 drivers/usb/gadget/function/f_mass_storage.c       |  20 +-
 drivers/usb/host/xhci-plat.c                       |   3 +
 drivers/usb/serial/cp210x.c                        |   1 +
 drivers/usb/serial/option.c                        |   1 +
 drivers/usb/serial/qcserial.c                      |   2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c                 |  17 +-
 drivers/vhost/vhost.c                              |   5 +-
 drivers/watchdog/it87_wdt.c                        |  14 +-
 drivers/xen/gntdev-dmabuf.c                        |  54 ++---
 fs/afs/callback.c                                  |   3 +-
 fs/afs/dir.c                                       |   8 +
 fs/afs/server.c                                    |   7 +-
 fs/btrfs/disk-io.c                                 |  13 +-
 fs/btrfs/extent-tree.c                             |   3 +-
 fs/btrfs/inode.c                                   |  43 ++--
 fs/btrfs/ioctl.c                                   |  12 +
 fs/btrfs/qgroup.c                                  |  14 ++
 fs/btrfs/ref-verify.c                              |   6 +-
 fs/btrfs/send.c                                    |   2 +-
 fs/btrfs/tree-checker.c                            |   2 +-
 fs/ceph/caps.c                                     |  12 +-
 fs/cifs/smb2misc.c                                 |   2 +-
 fs/cifs/smb2ops.c                                  |  14 +-
 fs/cifs/smb2pdu.c                                  |  13 +-
 fs/cifs/smb2pdu.h                                  |  42 ++--
 fs/dcache.c                                        |   7 +-
 fs/ecryptfs/inode.c                                |   8 +
 fs/exec.c                                          |   3 +
 fs/ext4/mballoc.c                                  |  26 ++-
 fs/ext4/move_extent.c                              |   6 +-
 fs/ext4/resize.c                                   |  37 +--
 fs/f2fs/recovery.c                                 |  25 +-
 fs/ioctl.c                                         |   3 +-
 fs/jfs/jfs_dmap.c                                  |  57 ++---
 fs/jfs/jfs_dtree.c                                 |   7 +-
 fs/jfs/jfs_imap.c                                  |   3 +
 fs/jfs/jfs_mount.c                                 |   6 +-
 fs/kernfs/dir.c                                    |  12 +
 fs/namei.c                                         |  60 +++--
 fs/nfsd/nfs4state.c                                |  61 ++---
 fs/nilfs2/dat.c                                    |  27 ++-
 fs/nilfs2/file.c                                   |   8 +-
 fs/nilfs2/recovery.c                               |   7 +-
 fs/nilfs2/segment.c                                |   8 +-
 fs/pipe.c                                          |  19 +-
 fs/pstore/ram.c                                    |   1 +
 fs/ubifs/dir.c                                     |   2 +
 include/drm/drm_color_mgmt.h                       |   1 +
 include/drm/drm_mipi_dsi.h                         |   2 +
 include/linux/async.h                              |   2 +
 include/linux/bpf.h                                |   6 +-
 include/linux/dmaengine.h                          |   3 +-
 include/linux/hrtimer.h                            |   4 +-
 include/linux/lsm_hook_defs.h                      |   2 +
 include/linux/mmc/sdio_ids.h                       |   1 +
 include/linux/mmzone.h                             |  18 +-
 include/linux/netfilter/ipset/ip_set.h             |   4 +
 include/linux/pci_ids.h                            |   1 +
 include/linux/pipe_fs_i.h                          |  16 ++
 include/linux/pm_runtime.h                         |   8 +
 include/linux/security.h                           |   9 +
 include/linux/serial_core.h                        |   1 +
 include/linux/spi/spi.h                            |   1 +
 include/linux/stddef.h                             |  13 ++
 include/linux/syscalls.h                           |   1 +
 include/linux/units.h                              |  10 +-
 include/linux/vmalloc.h                            |   5 +
 include/net/af_unix.h                              |  20 +-
 include/net/inet_connection_sock.h                 |   8 +
 include/net/llc_pdu.h                              |   6 +-
 include/net/netfilter/nf_tables.h                  |   4 +-
 include/scsi/scsi.h                                |  21 +-
 include/scsi/scsi_dh.h                             |   3 +-
 include/scsi/scsi_eh.h                             |   2 +-
 include/uapi/linux/btrfs.h                         |   3 +
 include/uapi/linux/netfilter/nf_tables.h           |   2 +
 include/uapi/linux/stddef.h                        |  23 ++
 kernel/async.c                                     |  85 +++++--
 kernel/audit.c                                     |  31 ++-
 kernel/bpf/arraymap.c                              |  12 +-
 kernel/bpf/hashtab.c                               |   6 +-
 kernel/bpf/map_in_map.c                            |   2 +-
 kernel/bpf/map_in_map.h                            |   2 +-
 kernel/bpf/syscall.c                               |   6 +
 kernel/events/core.c                               |  38 +++-
 kernel/power/swap.c                                |  38 ++--
 kernel/sched/membarrier.c                          |   9 +
 kernel/time/clocksource.c                          |  25 +-
 kernel/time/hrtimer.c                              |  17 +-
 kernel/time/tick-sched.c                           |   5 +
 kernel/trace/ring_buffer.c                         |   2 +-
 kernel/trace/trace.c                               |  78 +++----
 kernel/trace/trace_events_trigger.c                |   6 +-
 kernel/trace/tracing_map.c                         |   7 +-
 lib/debugobjects.c                                 | 204 +++++++----------
 lib/mpi/ec.c                                       |   3 +
 mm/page-writeback.c                                |   2 +-
 mm/sparse.c                                        |  17 +-
 mm/util.c                                          |  50 ++++
 net/8021q/vlan_netlink.c                           |   4 +
 net/bluetooth/l2cap_core.c                         |   3 +-
 net/can/j1939/j1939-priv.h                         |   1 +
 net/can/j1939/socket.c                             |  22 +-
 net/core/request_sock.c                            |   3 -
 net/core/skbuff.c                                  |   3 +-
 net/hsr/hsr_device.c                               |   4 +-
 net/ipv4/af_inet.c                                 |   9 +-
 net/ipv4/inet_connection_sock.c                    |   4 +
 net/ipv4/ip_output.c                               |  12 +-
 net/ipv4/ip_tunnel_core.c                          |   2 +-
 net/ipv4/tcp.c                                     |  45 +++-
 net/ipv6/addrconf_core.c                           |  21 +-
 net/ipv6/af_inet6.c                                |   3 +
 net/ipv6/ip6_tunnel.c                              |  28 ++-
 net/iucv/af_iucv.c                                 |  14 +-
 net/llc/af_llc.c                                   |  26 ++-
 net/llc/llc_core.c                                 |   7 -
 net/mac80211/tx.c                                  |   3 +-
 net/netfilter/ipset/ip_set_bitmap_gen.h            |  14 +-
 net/netfilter/ipset/ip_set_core.c                  |  39 +++-
 net/netfilter/ipset/ip_set_hash_gen.h              |  19 +-
 net/netfilter/ipset/ip_set_list_set.c              |  13 +-
 net/netfilter/nf_log.c                             |   7 +-
 net/netfilter/nf_tables_api.c                      |  20 +-
 net/netfilter/nft_byteorder.c                      |   5 +-
 net/netfilter/nft_chain_filter.c                   |  11 +-
 net/netfilter/nft_compat.c                         |  23 +-
 net/netfilter/nft_ct.c                             |  27 +++
 net/netfilter/nft_flow_offload.c                   |   5 +
 net/netfilter/nft_meta.c                           |   2 +-
 net/netfilter/nft_nat.c                            |   5 +
 net/netfilter/nft_rt.c                             |   5 +
 net/netfilter/nft_set_pipapo.c                     | 108 ++++-----
 net/netfilter/nft_set_pipapo.h                     |  18 +-
 net/netfilter/nft_set_pipapo_avx2.c                |  17 +-
 net/netfilter/nft_set_rbtree.c                     |   6 +-
 net/netfilter/nft_socket.c                         |   5 +
 net/netfilter/nft_synproxy.c                       |   7 +-
 net/netfilter/nft_tproxy.c                         |   5 +
 net/netfilter/nft_xfrm.c                           |   5 +
 net/netlink/af_netlink.c                           |   2 +-
 net/nfc/nci/core.c                                 |   4 +
 net/openvswitch/flow_netlink.c                     |  49 ++--
 net/rds/af_rds.c                                   |   2 +-
 net/rxrpc/conn_event.c                             |   8 +
 net/rxrpc/conn_service.c                           |   3 +-
 net/smc/smc_diag.c                                 |   2 +-
 net/sunrpc/xprtmultipath.c                         |  17 +-
 net/tipc/bearer.c                                  |   6 +
 net/unix/af_unix.c                                 |  14 +-
 net/unix/diag.c                                    |   2 +-
 net/wireless/scan.c                                |   4 +
 scripts/decode_stacktrace.sh                       |  64 +++++-
 scripts/get_abi.pl                                 |   2 +-
 scripts/kernel-doc                                 |   3 +-
 scripts/link-vmlinux.sh                            |   9 +-
 scripts/mod/sumversion.c                           |   7 +-
 security/security.c                                |  32 ++-
 security/selinux/hooks.c                           |  28 +++
 security/smack/smack_lsm.c                         |   1 +
 security/tomoyo/tomoyo.c                           |   1 +
 sound/hda/hdac_stream.c                            |   9 +-
 sound/hda/intel-dsp-config.c                       |  10 +
 sound/pci/hda/hda_intel.c                          |   2 +
 sound/pci/hda/patch_conexant.c                     |  18 ++
 sound/pci/hda/patch_realtek.c                      |   3 +
 sound/soc/codecs/rt5645.c                          |   1 +
 tools/lib/subcmd/help.c                            |  18 +-
 tools/testing/selftests/bpf/prog_tests/btf.c       |   1 +
 tools/testing/selftests/bpf/progs/pyperf180.c      |  22 ++
 .../drivers/net/netdevsim/udp_tunnel_nic.sh        |   9 +
 tools/testing/selftests/net/pmtu.sh                |  18 +-
 virt/kvm/kvm_main.c                                |   4 +-
 424 files changed, 4092 insertions(+), 2224 deletions(-)



