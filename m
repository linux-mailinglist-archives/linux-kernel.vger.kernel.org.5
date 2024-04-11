Return-Path: <linux-kernel+bounces-140282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDB68A120A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C328D1C227B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39627146A8D;
	Thu, 11 Apr 2024 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uK7FINQu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CB879FD;
	Thu, 11 Apr 2024 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832602; cv=none; b=J6Zu6VuaF7TpDjYcUyv+Ecm2IbfoU3NBMN4dQSmWFD8Dn6MD+jNy7f8wtZTQxiOJvKjt9vv4ftGjPo58yHFagYogdhmcJtHm+Vkqn6dIBU20Yccw+QzyfQ8kV/V1kpAxDLsY4BiGYSaHnGwK7251Cf2iz1VH81RuVa9jc7ZiW4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832602; c=relaxed/simple;
	bh=9dioLCwe2gL/VOYhX/ypV3hnwp7uRX4Q5jneak3jRmE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kqNtxqxE+dHn1csGADSf8GGaL0CXniRl8vTqwysfcSq0ANznlLWB2AzHHl5W9L/QZ612Co9NlCRnIGQ7S7PZGpzxe5KmcAcWlDHQMqCL4WZtvzEM3wXc4xSKexdgF7UVlaXjY8KI4yFwS+9WVmNZg8GAmck77YNN+RU0zCGolAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uK7FINQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702A3C433C7;
	Thu, 11 Apr 2024 10:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832602;
	bh=9dioLCwe2gL/VOYhX/ypV3hnwp7uRX4Q5jneak3jRmE=;
	h=From:To:Cc:Subject:Date:From;
	b=uK7FINQu/j00qvEqU6s7IKOdUgjjvXEYZIBpBo6o6PogBd9MESWvGvjGk0eDsZazM
	 XWQ1iWLRabbCyw04m3PW52oOO4wrX8cUY2uK+k98Pj8xEBhSiqaqpID+vZaOrD9tdZ
	 gzzMwB0CljEDrKNl4HS/ESIzKfh87AC8OL0a2IeY=
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
	allen.lkml@gmail.com,
	broonie@kernel.org
Subject: [PATCH 5.15 00/57] 5.15.155-rc1 review
Date: Thu, 11 Apr 2024 11:57:08 +0200
Message-ID: <20240411095407.982258070@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.155-rc1
X-KernelTest-Deadline: 2024-04-13T09:54+00:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This is the start of the stable review cycle for the 5.15.155 release.
There are 57 patches in this series, all will be posted as a response
to this one.  If anyone has any issues with these being applied, please
let me know.

Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
Anything received after that time might be too late.

The whole patch series can be found in one patch at:
	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.155-rc1.gz
or in the git tree and branch at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
and the diffstat can be found below.

thanks,

greg k-h

-------------
Pseudo-Shortlog of commits:

Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Linux 5.15.155-rc1

Vasiliy Kovalev <kovalev@altlinux.org>
    VMCI: Fix possible memcpy() run-time warning in vmci_datagram_invoke_guest_handler()

Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    Bluetooth: btintel: Fixe build regression

Gwendal Grignou <gwendal@chromium.org>
    platform/x86: intel-vbtn: Update tablet mode switch at end of probe

Kees Cook <keescook@chromium.org>
    randomize_kstack: Improve entropy diffusion

David Hildenbrand <david@redhat.com>
    x86/mm/pat: fix VM_PAT handling in COW mappings

David Hildenbrand <david@redhat.com>
    virtio: reenable config if freezing device failed

Ard Biesheuvel <ardb@kernel.org>
    gcc-plugins/stackleak: Avoid .head.text section

Kees Cook <keescook@chromium.org>
    gcc-plugins/stackleak: Ignore .noinstr.text and .entry.text

Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
    tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: discard table flag update with pending basechain deletion

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release mutex after nft_gc_seq_end from abort path

Pablo Neira Ayuso <pablo@netfilter.org>
    netfilter: nf_tables: release batch on table validation from abort path

Roman Smirnov <r.smirnov@omp.ru>
    fbmon: prevent division by zero in fb_videomode_from_videomode()

Jiawei Fu (iBug) <i@ibugone.com>
    drivers/nvme: Add quirks for device 126f:2262

Aleksandr Burakov <a.burakov@rosalinux.ru>
    fbdev: viafb: fix typo in hw_bitblt_1 and hw_bitblt_2

Chancel Liu <chancel.liu@nxp.com>
    ASoC: soc-core.c: Skip dummy codec when adding platforms

Colin Ian King <colin.i.king@gmail.com>
    usb: sl811-hcd: only defined function checkdone if QUIRK2 is defined

Marco Felsch <m.felsch@pengutronix.de>
    usb: typec: tcpci: add generic tcpci fallback compatible

Petre Rodan <petre.rodan@subdimension.ro>
    tools: iio: replace seekdir() in iio_generic_buffer

linke li <lilinke99@qq.com>
    ring-buffer: use READ_ONCE() to read cpu_buffer->commit_page in concurrent environment

Ricardo B. Marliere <ricardo@marliere.net>
    ktest: force $buildonly = 1 for 'make_warnings_file' test type

Alban Boyé <alban.boye@protonmail.com>
    platform/x86: touchscreen_dmi: Add an extra entry for a variant of the Chuwi Vi8 tablet

Gergo Koteles <soyer@irl.hu>
    Input: allocate keycode for Display refresh rate toggle

Manjunath Patil <manjunath.b.patil@oracle.com>
    RDMA/cm: add timeout to cm_destroy_id wait

Roman Smirnov <r.smirnov@omp.ru>
    block: prevent division by zero in blk_rq_stat_sum()

Ian Rogers <irogers@google.com>
    libperf evlist: Avoid out-of-bounds access

Daniel Drake <drake@endlessos.org>
    Revert "ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default"

Dai Ngo <dai.ngo@oracle.com>
    SUNRPC: increase size of rpc_wait_queue.qlen from unsigned short to unsigned int

Aric Cyr <aric.cyr@amd.com>
    drm/amd/display: Fix nanosec stat overflow

Ye Bin <yebin10@huawei.com>
    ext4: forbid commit inconsistent quota data when errors=remount-ro

Zhang Yi <yi.zhang@huawei.com>
    ext4: add a hint for block bitmap corrupt state in mb_groups

Takashi Sakamoto <o-takashi@sakamocchi.jp>
    ALSA: firewire-lib: handle quirk to calculate payload quadlets as data block counter

Arnd Bergmann <arnd@arndb.de>
    media: sta2x11: fix irq handler cast

Alex Henrie <alexhenrie24@gmail.com>
    isofs: handle CDs with bad root inode but good Joliet root directory

Justin Tee <justin.tee@broadcom.com>
    scsi: lpfc: Fix possible memory leak in lpfc_rcv_padisc()

Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
    sysv: don't call sb_bread() with pointers_lock held

Geert Uytterhoeven <geert+renesas@glider.be>
    pinctrl: renesas: checker: Limit cfg reg enum checks to provided IDs

Kunwu Chan <chentao@kylinos.cn>
    Input: synaptics-rmi4 - fail probing if memory allocation for "phys" fails

Edward Adam Davis <eadavis@qq.com>
    Bluetooth: btintel: Fix null ptr deref in btintel_read_version

Eric Dumazet <edumazet@google.com>
    net/smc: reduce rtnl pressure in smc_pnet_create_pnetids_list()

David Sterba <dsterba@suse.com>
    btrfs: send: handle path ref underflow in header iterate_inode_ref()

David Sterba <dsterba@suse.com>
    btrfs: export: handle invalid inode or root reference in btrfs_get_parent()

David Sterba <dsterba@suse.com>
    btrfs: handle chunk tree lookup error in btrfs_relocate_sys_chunks()

Baochen Qiang <quic_bqiang@quicinc.com>
    wifi: ath11k: decrease MHI channel buffer length to 8KB

Serge Semin <fancer.lancer@gmail.com>
    net: pcs: xpcs: Return EINVAL in the internal methods

Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
    tools/power x86_energy_perf_policy: Fix file leak in get_pkg_num()

Kunwu Chan <chentao@kylinos.cn>
    pstore/zone: Add a null pointer check to the psz_kmsg_read

Shannon Nelson <shannon.nelson@amd.com>
    ionic: set adminq irq affinity

Johan Jonker <jbx6244@gmail.com>
    arm64: dts: rockchip: fix rk3399 hdmi ports node

Johan Jonker <jbx6244@gmail.com>
    arm64: dts: rockchip: fix rk3328 hdmi ports node

C Cheng <C.Cheng@mediatek.com>
    cpuidle: Avoid potential overflow in integer multiplication

John Ogness <john.ogness@linutronix.de>
    panic: Flush kernel log buffer at the end

Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
    VMCI: Fix memcpy() run-time warning in dg_dispatch_as_host()

Markus Elfring <elfring@users.sourceforge.net>
    batman-adv: Improve exception handling in batadv_throw_uevent()

Markus Elfring <elfring@users.sourceforge.net>
    batman-adv: Return directly after a failed batadv_dat_select_candidates() in batadv_dat_forward_data()

Dmitry Antipov <dmantipov@yandex.ru>
    wifi: ath9k: fix LNA selection in ath_ant_try_scan()

Vladimir Oltean <vladimir.oltean@nxp.com>
    net: dsa: fix panic when DSA master device unbinds on shutdown


-------------

Diffstat:

 Makefile                                           |  4 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 11 ++++-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 12 +++++-
 arch/x86/mm/pat/memtype.c                          | 49 +++++++++++++++-------
 block/blk-stat.c                                   |  2 +-
 drivers/acpi/sleep.c                               | 12 ------
 drivers/bluetooth/btintel.c                        |  2 +-
 drivers/cpuidle/driver.c                           |  3 +-
 .../gpu/drm/amd/display/modules/inc/mod_stats.h    |  4 +-
 drivers/infiniband/core/cm.c                       | 20 ++++++++-
 drivers/input/rmi4/rmi_driver.c                    |  6 ++-
 drivers/media/pci/sta2x11/sta2x11_vip.c            |  9 ++--
 drivers/misc/vmw_vmci/vmci_datagram.c              |  6 ++-
 drivers/net/ethernet/pensando/ionic/ionic_lif.c    |  5 ++-
 drivers/net/pcs/pcs-xpcs.c                         |  4 +-
 drivers/net/wireless/ath/ath11k/mhi.c              |  2 +-
 drivers/net/wireless/ath/ath9k/antenna.c           |  2 +-
 drivers/nvme/host/pci.c                            |  3 ++
 drivers/pinctrl/renesas/core.c                     |  4 +-
 drivers/platform/x86/intel/vbtn.c                  |  5 ++-
 drivers/platform/x86/touchscreen_dmi.c             |  9 ++++
 drivers/scsi/lpfc/lpfc_nportdisc.c                 |  6 ++-
 drivers/tty/n_gsm.c                                |  3 ++
 drivers/usb/host/sl811-hcd.c                       |  2 +
 drivers/usb/typec/tcpm/tcpci.c                     |  1 +
 drivers/video/fbdev/core/fbmon.c                   |  7 ++--
 drivers/video/fbdev/via/accel.c                    |  4 +-
 drivers/virtio/virtio.c                            | 10 ++++-
 fs/btrfs/export.c                                  |  9 +++-
 fs/btrfs/send.c                                    | 10 ++++-
 fs/btrfs/volumes.c                                 | 12 +++++-
 fs/ext4/mballoc.c                                  |  5 ++-
 fs/ext4/super.c                                    | 12 ++++++
 fs/isofs/inode.c                                   | 18 +++++++-
 fs/pstore/zone.c                                   |  2 +
 fs/sysv/itree.c                                    | 10 ++---
 include/linux/randomize_kstack.h                   |  2 +-
 include/linux/sunrpc/sched.h                       |  2 +-
 include/uapi/linux/input-event-codes.h             |  1 +
 kernel/panic.c                                     |  8 ++++
 kernel/trace/ring_buffer.c                         |  2 +-
 mm/memory.c                                        |  4 ++
 net/batman-adv/distributed-arp-table.c             |  3 +-
 net/batman-adv/main.c                              | 14 ++++---
 net/dsa/dsa2.c                                     | 25 +++--------
 net/netfilter/nf_tables_api.c                      | 47 ++++++++++++++++-----
 net/smc/smc_pnet.c                                 | 10 +++++
 scripts/gcc-plugins/stackleak_plugin.c             |  6 +++
 sound/firewire/amdtp-stream.c                      | 12 ++++--
 sound/firewire/amdtp-stream.h                      |  4 ++
 sound/soc/soc-core.c                               |  3 ++
 tools/iio/iio_utils.c                              |  2 +-
 tools/lib/perf/evlist.c                            | 18 +++++---
 tools/lib/perf/include/internal/evlist.h           |  4 +-
 .../x86_energy_perf_policy.c                       |  1 +
 tools/testing/ktest/ktest.pl                       |  1 +
 56 files changed, 326 insertions(+), 128 deletions(-)



