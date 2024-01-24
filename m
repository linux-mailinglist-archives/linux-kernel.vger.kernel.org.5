Return-Path: <linux-kernel+bounces-36249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF5A1839DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D0E3284FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF2217CD;
	Wed, 24 Jan 2024 01:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YLUdEsrs"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECAA23C5;
	Wed, 24 Jan 2024 00:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706058003; cv=none; b=aiqX1oxwGUfvvXbnDz+neYydGae7zA5Ba6RRLobWo9/SOh7lQSAgqMdMkbQnA78JOheM3asV6EsPRIkKF14Q8a4X8apdeFRjGn+IkJY0gbq6S+qL6lTHmqOa3wPTIF5R0D5N3bo5/9gJDWJiGeAZL0nrq0x3BzEqwkcxn2XvfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706058003; c=relaxed/simple;
	bh=NqnidPBxqxn5CTsQXUkVTdHEOasw85z4ibvOLm2EDEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H06tgKOA+NEMu1WNL07xwzMus1ez6ec8Sf+z5cxt7axAIl+hF/9uD0owSPbFD+iGTgYbYs9b2LfMvoLlx8yVNhRz8buO3ebUIIwYRYOG1vlXhLsdfOr2mLmPGEo8OVuXCHeCwzUDYcbTNzSCa96tnu3yDHSIudkY1OXi/D4zT0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YLUdEsrs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-290b37bb7deso1796808a91.0;
        Tue, 23 Jan 2024 16:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706057998; x=1706662798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FU8k0t0E/+0afwuHW9a9JhOh+ipVd9L+UG8BvuMGEo4=;
        b=YLUdEsrs68UHpsFZMOas+KcL3RgG5hMm/33rsWF/ymC1RVNm1XLEmlhoEQb40X0vOt
         frUIGAv9wvVmoyaoSJEswAfuU8YG7jDBUUnHk7Z96qCTlWc7GvgFU6Ed2M83+n0ggW4G
         p5sI3IKtyMYAGPM3uyKUtRT9Shh7Ajcwt8Dg0F3ucJsQEf+ziN3Yh2HPqySFLA90Tq1j
         aaox+FRRT5FgKMMN+0yoPJJ8eqNX5MfTwmVqOLh25q4Ftt2jssatmF4unLoz1OkUbgki
         vW89xzfcHgfpmjFOGr/7G9SQvviA6YqX0HpOwu3YMWPg296MC+7cUNiRgS6fD+HnOizf
         NoOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706057998; x=1706662798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FU8k0t0E/+0afwuHW9a9JhOh+ipVd9L+UG8BvuMGEo4=;
        b=TtJGTPGdsWbr84PYAEUn0+8nkZ0IPzaz0zosxsdfsh2y664/YjtDel4v3KpkVd6sI3
         q7FmcNVe7xNuhpm749uBuWT2T6tKBS2nOfIpV6U6GuZtpkCkHNXuKAgiw0e6Uqy0KLN7
         CQETWi6MRP0ToTQi2l1UdGbpusSbIlh/y56laYjbuaPxOAuM5iVLm+BcZq0ut5IwYIN9
         I7vuqdtem+Mw/9KognTTZge5eNSICGHbkRNLLKdyg7HOuEcJ79cWgZl/qIzcK1P0b5+6
         j/u76G52O51LnXjsurfTW0s5ilQN+l+LvidHQKHGP5RX2zJrBZlNxvXF2euTtTwZjiOM
         Hpmw==
X-Gm-Message-State: AOJu0YwuQxMgC2WmlZxsjjl2S+vFln9/y+jvYZxjNd0yN30VDUBgO9J6
	MkY3lOfxXYPfywo/kFp821PiqkU4ZOD/tbmZBY/sUM53J3KgvlePnK1lSJIMf/fuTewJJ14RD5F
	vC/z9L2RrUpieDUBURyn43ETHGl0=
X-Google-Smtp-Source: AGHT+IE0ZxH5L14xK3A0e2TvC9DC1McFk/GnMKLIoonp9j8Ra9aMZ3NgqRjdCMQBWMTomIkGhW2ReCn8h0mwEzcn1go=
X-Received: by 2002:a17:90a:3c88:b0:28b:fe06:5dfc with SMTP id
 g8-20020a17090a3c8800b0028bfe065dfcmr4168301pjc.29.1706057997580; Tue, 23 Jan
 2024 16:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123174533.427864181@linuxfoundation.org>
In-Reply-To: <20240123174533.427864181@linuxfoundation.org>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 24 Jan 2024 01:59:44 +0100
Message-ID: <CADo9pHhWshiORC2fCuYvDj-_cdfnPbRz3LkEPhjyK6oQH_fhqg@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/580] 6.6.14-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Works fine on my HP 550-323no Skylake system model name    : Intel(R) Core(=
TM)
i5-6400 CPU @ 2.70GHz with Arch Linux


Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den tis 23 jan. 2024 kl 18:47 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 580 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Jan 2024 17:44:18 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.14-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------
> Pseudo-Shortlog of commits:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>     Linux 6.6.14-rc2
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Fix wrong usage of lm_alias() when splitting a huge linear map=
ping
>
> Marek Szyprowski <m.szyprowski@samsung.com>
>     i2c: s3c24xx: fix transferring more than one message in polling mode
>
> Marek Szyprowski <m.szyprowski@samsung.com>
>     i2c: s3c24xx: fix read transfers in polling mode
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     ipv6: mcast: fix data-race in ipv6_mc_down / mld_ifc_work
>
> Amit Cohen <amcohen@nvidia.com>
>     selftests: mlxsw: qos_pfc: Adjust the test to support 8 lanes
>
> Petr Machata <petrm@nvidia.com>
>     mlxsw: spectrum_router: Register netdevice notifier before nexthop
>
> Ido Schimmel <idosch@nvidia.com>
>     mlxsw: spectrum_acl_tcam: Fix stack corruption
>
> Ido Schimmel <idosch@nvidia.com>
>     mlxsw: spectrum_acl_tcam: Fix NULL pointer dereference in error path
>
> Amit Cohen <amcohen@nvidia.com>
>     mlxsw: spectrum_acl_erp: Fix error flow of pool allocation failure
>
> Christoph Hellwig <hch@lst.de>
>     loop: fix the the direct I/O support check when used on top of block =
devices
>
> Ludvig P=C3=A4rsson <ludvig.parsson@axis.com>
>     ethtool: netlink: Add missing ethnl_ops_begin/complete
>
> Mark Brown <broonie@kernel.org>
>     arm64/ptrace: Don't flush ZA/ZT storage when writing ZA via ptrace
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     kdb: Fix a potential buffer overflow in kdb_local()
>
> Pavel Begunkov <asml.silence@gmail.com>
>     io_uring: adjust defer tw counting
>
> Fedor Pchelkin <pchelkin@ispras.ru>
>     ipvs: avoid stat macros calls from preemptible context
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: reject NFT_SET_CONCAT with not field length des=
cription
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: skip dead set elements in netlink dump
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: do not allow mismatch field size and set key le=
ngth
>
> Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>     netfilter: bridge: replace physindev with physinif in nf_bridge_info
>
> Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>     netfilter: propagate net to nf_bridge_get_physindev
>
> Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>     netfilter: nf_queue: remove excess nf_bridge variable
>
> Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
>     netfilter: nfnetlink_log: use proper helper for fetching physinif
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nft_limit: do not ignore unsupported flags
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: reject invalid set policy
>
> Jakub Kicinski <kuba@kernel.org>
>     net: netdevsim: don't try to destroy PHC on VFs
>
> Paolo Abeni <pabeni@redhat.com>
>     mptcp: relax check on MPC passive fallback
>
> Hengqi Chen <hengqi.chen@gmail.com>
>     LoongArch: BPF: Prevent out-of-bounds memory access
>
> Kunwu Chan <chentao@kylinos.cn>
>     net: dsa: vsc73xx: Add null pointer check to vsc73xx_gpio_probe
>
> Hao Sun <sunhao.th@gmail.com>
>     bpf: Reject variable offset alu on PTR_TO_FLOW_KEYS
>
> Qiang Ma <maqianga@uniontech.com>
>     net: stmmac: ethtool: Fixed calltrace caused by unbalanced disable_ir=
q_wake calls
>
> Benjamin Poirier <bpoirier@nvidia.com>
>     selftests: bonding: Change script interpreter
>
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu: fall back to INPUT power for AVG power via INFO IOCTL
>
> Dafna Hirschfeld <dhirschfeld@habana.ai>
>     drm/amdkfd: fixes for HMM mem allocation
>
> Kai Vehmanen <kai.vehmanen@linux.intel.com>
>     ASoC: SOF: ipc4-loader: remove the CPC check warnings
>
> Su Hui <suhui@nfschina.com>
>     gpio: mlxbf3: add an error code check in mlxbf3_gpio_probe
>
> Michal Simek <michal.simek@amd.com>
>     dt-bindings: gpio: xilinx: Fix node address in gpio
>
> Nikita Yushchenko <nikita.yoush@cogentembedded.com>
>     net: ravb: Fix dma_addr_t truncation in error case
>
> John Fastabend <john.fastabend@gmail.com>
>     net: tls, fix WARNIING in __sk_msg_free
>
> Martin KaFai Lau <martin.lau@kernel.org>
>     bpf: Avoid iter->offset making backward progress in bpf_iter_udp
>
> Martin KaFai Lau <martin.lau@kernel.org>
>     bpf: iter_udp: Retry with a larger batch size without going back to t=
he previous bucket
>
> Marc Kleine-Budde <mkl@pengutronix.de>
>     net: netdev_queue: netdev_txq_completed_mb(): fix wake condition
>
> Eric Dumazet <edumazet@google.com>
>     net: add more sanity check in virtio_net_hdr_to_skb()
>
> Gao Xiang <xiang@kernel.org>
>     erofs: fix inconsistent per-file compression format
>
> Gao Xiang <xiang@kernel.org>
>     erofs: simplify compression configuration parser
>
> Eric Dumazet <edumazet@google.com>
>     udp: annotate data-races around up->pending
>
> Sneh Shah <quic_snehshah@quicinc.com>
>     net: stmmac: Fix ethool link settings ops for integrated PCS
>
> Jens Axboe <axboe@kernel.dk>
>     block: ensure we hold a queue reference when using queue limits
>
> Eric Dumazet <edumazet@google.com>
>     mptcp: refine opt_mp_capable determination
>
> Eric Dumazet <edumazet@google.com>
>     mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()
>
> Eric Dumazet <edumazet@google.com>
>     mptcp: use OPTION_MPTCP_MPJ_SYNACK in subflow_finish_connect()
>
> Eric Dumazet <edumazet@google.com>
>     mptcp: strict validation before using mp_opt->hmac
>
> Eric Dumazet <edumazet@google.com>
>     mptcp: mptcp_parse_option() fix for MPTCPOPT_MP_JOIN
>
> Amadeusz S=C5=82awi=C5=84ski <amadeuszx.slawinski@linux.intel.com>
>     ALSA: hda: Properly setup HDMI stream
>
> Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>     net: phy: micrel: populate .soft_reset for KSZ9131
>
> Horatiu Vultur <horatiu.vultur@microchip.com>
>     net: micrel: Fix PTP frame parsing for lan8841
>
> Taehee Yoo <ap420073@gmail.com>
>     amt: do not use overwrapped cb area
>
> Sanju=C3=A1n Garc=C3=ADa, Jorge <Jorge.SanjuanGarcia@duagon.com>
>     net: ethernet: ti: am65-cpsw: Fix max mtu to fit ethernet frames
>
> Nithin Dabilpuram <ndabilpuram@marvell.com>
>     octeontx2-af: CN10KB: Fix FIFO length calculation for RPM2
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix use of Don't Fragment flag
>
> Lin Ma <linma@zju.edu.cn>
>     net: qualcomm: rmnet: fix global oob in rmnet_policy
>
> Niklas Schnelle <schnelle@linux.ibm.com>
>     s390/pci: fix max size calculation in zpci_memcpy_toio()
>
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>     ASoC: mediatek: sof-common: Add NULL check for normal_link string
>
> Jianjun Wang <jianjun.wang@mediatek.com>
>     PCI: mediatek-gen3: Fix translation window size calculation
>
> Siddharth Vadapalli <s-vadapalli@ti.com>
>     PCI: keystone: Fix race condition when initializing PHYs
>
> Maurizio Lombardi <mlombard@redhat.com>
>     nvmet-tcp: Fix the H2C expected PDU len calculation
>
> Arnd Bergmann <arnd@arndb.de>
>     nvme: trace: avoid memcpy overflow warning
>
> Arnd Bergmann <arnd@arndb.de>
>     nvmet: re-fix tracing strncpy() warning
>
> Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>     hisi_acc_vfio_pci: Update migration data pointer correctly on saving/=
resume
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     spi: coldfire-qspi: Remove an erroneous clk_disable_unprepare() from =
the remove function
>
> Dan Williams <dan.j.williams@intel.com>
>     cxl/port: Fix missing target list lock
>
> Ben Gainey <ben.gainey@arm.com>
>     perf db-export: Fix missing reference count get in call_path_from_sam=
ple()
>
> Sam Ravnborg <sam@ravnborg.org>
>     serial: apbuart: fix console prompt on qemu
>
> Christoph Niedermaier <cniedermaier@dh-electronics.com>
>     serial: imx: Correct clock error message in function probe()
>
> Chunfeng Yun <chunfeng.yun@mediatek.com>
>     usb: xhci-mtk: fix a short packet issue of gen1 isoc-in transfer
>
> Fedor Pchelkin <pchelkin@ispras.ru>
>     apparmor: avoid crash when parsed profile name is empty
>
> Fedor Pchelkin <pchelkin@ispras.ru>
>     apparmor: fix possible memory leak in unpack_trans_table
>
> Jim Harris <jim.harris@samsung.com>
>     cxl/region: fix x9 interleave typo
>
> Ian Rogers <irogers@google.com>
>     perf stat: Fix hard coded LL miss units
>
> Ian Rogers <irogers@google.com>
>     perf env: Avoid recursively taking env->bpf_progs.lock
>
> Maurizio Lombardi <mlombard@redhat.com>
>     nvmet-tcp: fix a crash in nvmet_req_complete()
>
> Maurizio Lombardi <mlombard@redhat.com>
>     nvmet-tcp: Fix a kernel panic when host sends an invalid H2C PDU leng=
th
>
> John Johansen <john.johansen@canonical.com>
>     apparmor: Fix ref count leak in task_kill
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     vdpa: Fix an error handling path in eni_vdpa_probe()
>
> Kunwu Chan <chentao@kylinos.cn>
>     power: supply: Fix null pointer dereference in smb2_probe
>
> Ashish Mhetre <amhetre@nvidia.com>
>     iommu: Don't reserve 0-length IOVA region
>
> Andrzej Pietrasiewicz <andrzej.p@collabora.com>
>     usb: gadget: webcam: Make g_webcam loadable again
>
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>     spmi: mtk-pmif: Serialize PMIF status check and command submission
>
> Oliver Neukum <oneukum@suse.com>
>     usb: cdc-acm: return correct error code on unsupported break
>
> Jiri Slaby (SUSE) <jirislaby@kernel.org>
>     tty: use 'if' in send_break() instead of 'goto'
>
> Jiri Slaby (SUSE) <jirislaby@kernel.org>
>     tty: don't check for signal_pending() in send_break()
>
> Jiri Slaby (SUSE) <jirislaby@kernel.org>
>     tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK
>
> Manivannan Sadhasivam <mani@kernel.org>
>     PCI: epf-mhi: Fix the DMA data direction of dma_unmap_single()
>
> Manivannan Sadhasivam <mani@kernel.org>
>     bus: mhi: ep: Pass mhi_ep_buf_info struct to read/write APIs
>
> Manivannan Sadhasivam <mani@kernel.org>
>     bus: mhi: ep: Use slab allocator where applicable
>
> Manivannan Sadhasivam <mani@kernel.org>
>     bus: mhi: ep: Do not allocate event ring element on stack
>
> Namhyung Kim <namhyung@kernel.org>
>     perf unwind-libunwind: Fix base address for .eh_frame
>
> Namhyung Kim <namhyung@kernel.org>
>     perf unwind-libdw: Handle JIT-generated DSOs properly
>
> Namhyung Kim <namhyung@kernel.org>
>     perf genelf: Set ELF program header addresses properly
>
> Yicong Yang <yangyicong@hisilicon.com>
>     perf hisi-ptt: Fix one memory leakage in hisi_ptt_process_auxtrace_ev=
ent()
>
> Yicong Yang <yangyicong@hisilicon.com>
>     perf header: Fix one memory leakage in perf_event__fprintf_event_upda=
te()
>
> Nuno Sa <nuno.sa@analog.com>
>     iio: adc: ad9467: fix scale setting
>
> Nuno Sa <nuno.sa@analog.com>
>     iio: adc: ad9467: add mutex to struct ad9467_state
>
> Nuno Sa <nuno.sa@analog.com>
>     iio: adc: ad9467: don't ignore error codes
>
> Nuno Sa <nuno.sa@analog.com>
>     iio: adc: ad9467: fix reset gpio handling
>
> Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>     selftests/sgx: Skip non X86_64 platform
>
> Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
>     selftests/sgx: Include memory clobber for inline asm in test enclave
>
> Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
>     selftests/sgx: Fix uninitialized pointer dereferences in encl_get_ent=
ry
>
> Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
>     selftests/sgx: Fix uninitialized pointer dereference in error path
>
> Paul Geurts <paul_geurts@live.nl>
>     serial: imx: fix tx statemachine deadlock
>
> Sakari Ailus <sakari.ailus@linux.intel.com>
>     software node: Let args be NULL in software_node_get_reference_args
>
> Sakari Ailus <sakari.ailus@linux.intel.com>
>     acpi: property: Let args be NULL in __acpi_node_get_property_referenc=
e
>
> Gregory Price <gourry.memverge@gmail.com>
>     base/node.c: initialize the accessor list before registering
>
> Ian Rogers <irogers@google.com>
>     perf stat: Exit perf stat if parse groups fails
>
> Kan Liang <kan.liang@linux.intel.com>
>     perf mem: Fix error on hybrid related to availability of mem event in=
 a PMU
>
> Ilkka Koskinen <ilkka@os.amperecomputing.com>
>     perf vendor events arm64 AmpereOne: Rename BPU_FLUSH_MEM_FAULT to GPC=
_FLUSH_MEM_FAULT
>
> Brett Creeley <brett.creeley@amd.com>
>     vfio/pds: Fix calculations in pds_vfio_dirty_sync
>
> Veronika Molnarova <vmolnaro@redhat.com>
>     perf test record user-regs: Fix mask for vg register
>
> Arnaldo Carvalho de Melo <acme@redhat.com>
>     libapi: Add missing linux/types.h header to get the __u64 type on io.=
h
>
> Adrian Hunter <adrian.hunter@intel.com>
>     perf header: Fix segfault on build_mem_topology() error path
>
> Nick Forrington <nick.forrington@arm.com>
>     perf test: Remove atomics from test_loop to avoid test failures
>
> Laurentiu Tudor <laurentiu.tudor@nxp.com>
>     iommu: Map reserved memory as cacheable if device is coherent
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     serial: 8250: omap: Don't skip resource freeing if pm_runtime_resume_=
and_get() failed
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     PCI: Avoid potential out-of-bounds read in pci_dev_for_each_resource(=
)
>
> Su Hui <suhui@nfschina.com>
>     power: supply: bq256xx: fix some problem in bq256xx_hw_init
>
> Jan Palus <jpalus@fastmail.com>
>     power: supply: cw2015: correct time_to_empty units in sysfs
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     MIPS: Alchemy: Fix an out-of-bound access in db1550_dev_setup()
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     MIPS: Alchemy: Fix an out-of-bound access in db1200_dev_setup()
>
> Frederik Haxel <haxel@fzi.de>
>     riscv: Fixed wrong register in XIP_FIXUP_FLASH_OFFSET macro
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Fix set_direct_map_default_noflush() to reset _PAGE_EXEC
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge =
linear mappings
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Fix module_alloc() that did not reset the linear mapping permi=
ssions
>
> Alexandre Ghiti <alexghiti@rivosinc.com>
>     riscv: Check if the code to patch lies in the exit section
>
> Vincent Whitchurch <vincent.whitchurch@axis.com>
>     um: virt-pci: fix platform map offset
>
> Serge Semin <fancer.lancer@gmail.com>
>     mips: Fix incorrect max_low_pfn adjustment
>
> Serge Semin <fancer.lancer@gmail.com>
>     mips: dmi: Fix early remap on MIPS32
>
> Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>     srcu: Use try-lock lockdep annotation for NMI-safe access.
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     mfd: intel-lpss: Fix the fractional clock divider flags
>
> Kunwu Chan <chentao@kylinos.cn>
>     mfd: tps6594: Add null pointer check to tps6594_device_init()
>
> Martin Kurbanov <mmkurbanov@salutedevices.com>
>     leds: aw200xx: Fix write to DIM parameter
>
> Dang Huynh <danct12@riseup.net>
>     leds: aw2013: Select missing dependency REGMAP_I2C
>
> Kunwu Chan <chentao@kylinos.cn>
>     mfd: syscon: Fix null pointer dereference in of_syscon_register()
>
> Charles Keepax <ckeepax@opensource.cirrus.com>
>     mfd: cs42l43: Correct SoundWire port list
>
> Neil Armstrong <neil.armstrong@linaro.org>
>     mfd: rk8xx: fixup devices registration with PLATFORM_DEVID_AUTO
>
> Randy Dunlap <rdunlap@infradead.org>
>     ARM: 9330/1: davinci: also select PINCTRL
>
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>     serial: sc16is7xx: set safe default SPI clock frequency
>
> Hugo Villeneuve <hvilleneuve@dimonoff.com>
>     serial: sc16is7xx: add check for unsupported SPI modes during probe
>
> Jason Gerecke <jason.gerecke@wacom.com>
>     HID: wacom: Correct behavior when processing some confidence =3D=3D f=
alse touches
>
> Yauhen Kharuzhy <jekhor@gmail.com>
>     HID: sensor-hub: Enable hid core report processing for all devices
>
> Marcelo Schmitt <marcelo.schmitt@analog.com>
>     iio: adc: ad7091r: Pass iio_dev to event handler
>
> Sean Christopherson <seanjc@google.com>
>     KVM: x86/pmu: Reset the PMU, i.e. stop counters, before refreshing
>
> Sean Christopherson <seanjc@google.com>
>     KVM: x86/pmu: Move PMU reset logic to common x86 code
>
> Oliver Upton <oliver.upton@linux.dev>
>     KVM: arm64: vgic-its: Avoid potential UAF in LPI translation cache
>
> Marc Zyngier <maz@kernel.org>
>     KVM: arm64: vgic-v4: Restore pending state on host userspace write
>
> Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>     x86/kvm: Do not try to disable kvmclock if it was not enabled
>
> qizhong cheng <qizhong.cheng@mediatek.com>
>     PCI: mediatek: Clear interrupt status before dispatching handler
>
> Niklas Cassel <niklas.cassel@wdc.com>
>     PCI: dwc: endpoint: Fix dw_pcie_ep_raise_msix_irq() alignment support
>
> Bjorn Helgaas <bhelgaas@google.com>
>     x86/pci: Reserve ECAM if BIOS didn't include it in PNP0C02 _CRS
>
> Tadeusz Struk <tstruk@gigaio.com>
>     PCI/P2PDMA: Remove reference to pci_p2pdma_map_sg()
>
> Huang Ying <ying.huang@intel.com>
>     cxl/port: Fix decoder initialization when nr_targets > interleave_way=
s
>
> Sean Christopherson <seanjc@google.com>
>     Revert "nSVM: Check for reserved encodings of TLB_CONTROL in nested V=
MCB"
>
> Nicolas Dichtel <nicolas.dichtel@6wind.com>
>     Revert "net: rtnetlink: Enslave device before bringing it up"
>
> Petr Tesarik <petr@tesarici.cz>
>     net: stmmac: fix ethtool per-queue statistics
>
> David Lin <yu-hao.lin@nxp.com>
>     wifi: mwifiex: fix uninitialized firmware_stat
>
> David Lin <yu-hao.lin@nxp.com>
>     wifi: mwifiex: configure BSSID consistently when starting AP
>
> David Lin <yu-hao.lin@nxp.com>
>     wifi: mwifiex: add extra delay for firmware ready
>
> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>     wifi: rtlwifi: Convert LNKCTL change to PCIe cap RMW accessors
>
> Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>     wifi: rtlwifi: Remove bogus and dangerous ASPM disable/enable code
>
> Christian Marangi <ansuelsmth@gmail.com>
>     wifi: mt76: fix broken precal loading from MTD for mt7915
>
> Isaac J. Manjarres <isaacmanjarres@google.com>
>     iommu/dma: Trace bounce buffer usage when mapping buffers
>
> Rob Clark <robdclark@chromium.org>
>     iommu/arm-smmu-qcom: Add missing GMU entry to match table
>
> Jiri Olsa <olsajiri@gmail.com>
>     bpf: Fix re-attachment branch in bpf_tracing_prog_attach
>
> Gui-Dong Han <2045gemini@gmail.com>
>     Bluetooth: Fix atomicity violation in {min,max}_key_size_set
>
> Stefan Berger <stefanb@linux.ibm.com>
>     rootfs: Fix support for rootfstype=3D when root=3D is given
>
> Bart Van Assche <bvanassche@acm.org>
>     md/raid1: Use blk_opf_t for read and write operations
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     pwm: Fix out-of-bounds access in of_pwm_single_xlate()
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     pwm: jz4740: Don't use dev_err_probe() in .request()
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: check if catch-all set element is active in nex=
t generation
>
> Matthew Wilcox (Oracle) <willy@infradead.org>
>     block: Fix iterating over an empty bio with bio_for_each_folio_all
>
> Matthew Wilcox (Oracle) <willy@infradead.org>
>     block: Remove special-casing of compound pages
>
> Min Li <min15.li@samsung.com>
>     block: add check that partition length needs to be aligned with block=
 size
>
> Mario Limonciello <mario.limonciello@amd.com>
>     drm/amd: Enable PCIe PME from D3
>
> Junxiao Bi <junxiao.bi@oracle.com>
>     md: bypass block throttle for superblock update
>
> Chandrakanth patil <chandrakanth.patil@broadcom.com>
>     scsi: mpi3mr: Block PEL Enable Command on Controller Reset and Unreco=
verable State
>
> Chandrakanth patil <chandrakanth.patil@broadcom.com>
>     scsi: mpi3mr: Clean up block devices post controller reset
>
> Chandrakanth patil <chandrakanth.patil@broadcom.com>
>     scsi: mpi3mr: Refresh sdev queue depth after controller reset
>
> Amir Goldstein <amir73il@gmail.com>
>     scsi: target: core: add missing file_{start,end}_write()
>
> Bart Van Assche <bvanassche@acm.org>
>     scsi: ufs: core: Simplify power management during async scan
>
> Nam Cao <namcao@linutronix.de>
>     fbdev: flush deferred IO before closing
>
> Nam Cao <namcao@linutronix.de>
>     fbdev: flush deferred work in fb_deferred_io_fsync()
>
> Thomas Zimmermann <tzimmermann@suse.de>
>     fbdev/acornfb: Fix name of fb_ops initializer macro
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring: ensure local task_work is run on wait timeout
>
> Jens Axboe <axboe@kernel.dk>
>     io_uring/rw: ensure io->bytes_done is always initialized
>
> Pavel Begunkov <asml.silence@gmail.com>
>     io_uring: don't check iopoll if request completes
>
> Xi Ruoyao <xry111@xry111.site>
>     LoongArch: Fix and simplify fcsr initialization on execve()
>
> Eric Biggers <ebiggers@google.com>
>     ceph: select FS_ENCRYPTION_ALGS if FS_ENCRYPTION
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: only v2 leases handle the directory
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: fix UAF issue in ksmbd_tcp_new_connection()
>
> Namjae Jeon <linkinjeon@kernel.org>
>     ksmbd: validate mech token in session setup
>
> Bin Li <bin.li@canonical.com>
>     ALSA: hda/realtek: Enable headset mic on Lenovo M70 Gen5
>
> Yo-Jung Lin <leo.lin@canonical.com>
>     ALSA: hda/realtek: Enable mute/micmute LEDs and limit mic boost on HP=
 ZBook
>
> =C3=87a=C4=9Fhan Demir <caghandemir@marun.edu.tr>
>     ALSA: hda/relatek: Enable Mute LED on HP Laptop 15s-fq2xxx
>
> Takashi Iwai <tiwai@suse.de>
>     ALSA: oxygen: Fix right channel of capture volume mixer
>
> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>     serial: omap: do not override settings for RS485 support
>
> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>     serial: 8250_exar: Set missing rs485_supported flag
>
> Christoph Niedermaier <cniedermaier@dh-electronics.com>
>     serial: imx: Ensure that imx_uart_rs485_config() is called with enabl=
ed clock
>
> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>     serial: core, imx: do not set RS485 enabled if it is not supported
>
> Stefan Wahren <wahrenst@gmx.net>
>     serial: 8250_bcm2835aux: Restore clock error handling
>
> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>     serial: core: make sure RS485 cannot be enabled when it is not suppor=
ted
>
> Lino Sanfilippo <l.sanfilippo@kunbus.com>
>     serial: core: fix sanitizing check for RTS settings
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     dt-bindings: phy: qcom,sc8280xp-qmp-usb43dp-phy: fix path to header
>
> Gui-Dong Han <2045gemini@gmail.com>
>     usb: mon: Fix atomicity violation in mon_bin_vma_fault
>
> RD Babiera <rdbabiera@google.com>
>     usb: typec: class: fix typec_altmode_put_partner to put plugs
>
> Heikki Krogerus <heikki.krogerus@linux.intel.com>
>     Revert "usb: typec: class: fix typec_altmode_put_partner to put plugs=
"
>
> Frank Li <Frank.Li@nxp.com>
>     usb: cdns3: Fix uvc fail when DMA cross 4k boundery since sg enabled
>
> Frank Li <Frank.Li@nxp.com>
>     usb: cdns3: fix iso transfer error when mult is not zero
>
> Frank Li <Frank.Li@nxp.com>
>     usb: cdns3: fix uvc failure work since sg support enabled
>
> Xu Yang <xu.yang_2@nxp.com>
>     usb: chipidea: wait controller resume finished for wakeup irq
>
> Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>     Revert "usb: dwc3: don't reset device side if dwc3 was configured as =
host-only"
>
> Thinh Nguyen <Thinh.Nguyen@synopsys.com>
>     Revert "usb: dwc3: Soft reset phy on probe for host"
>
> Wesley Cheng <quic_wcheng@quicinc.com>
>     usb: dwc3: gadget: Queue PM runtime idle on disconnect event
>
> Wesley Cheng <quic_wcheng@quicinc.com>
>     usb: dwc3: gadget: Handle EP0 request dequeuing properly
>
> Uttkarsh Aggarwal <quic_uaggarwa@quicinc.com>
>     usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart
>
> Xu Yang <xu.yang_2@nxp.com>
>     usb: phy: mxs: remove CONFIG_USB_OTG condition for mxs_phy_is_otg_hos=
t()
>
> Frank Li <Frank.Li@nxp.com>
>     Revert "usb: gadget: f_uvc: change endpoint allocation in uvc_functio=
n_bind()"
>
> Heiko Carstens <hca@linux.ibm.com>
>     tick-sched: Fix idle and iowait sleeptime accounting vs CPU hotplug
>
> Michael Ellerman <mpe@ellerman.id.au>
>     powerpc/64s: Increase default stack size to 32KB
>
> Tony Lindgren <tony@atomide.com>
>     clocksource/drivers/timer-ti-dm: Fix make W=3Dn kerneldoc warnings
>
> Carlos Llamas <cmllamas@google.com>
>     binder: fix race between mmput() and do_exit()
>
> Jan Beulich <jbeulich@suse.com>
>     xen-netback: don't produce zero-size SKB frags
>
> Kaibo Ma <ent3rm4n@gmail.com>
>     Revert "drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole"
>
> Matthew Maurer <mmaurer@google.com>
>     rust: Ignore preserve-most functions
>
> Hans de Goede <hdegoede@redhat.com>
>     Input: atkbd - use ab83 as id when skipping the getid command
>
> Stefan Wiehler <stefan.wiehler@nokia.com>
>     mips/smp: Call rcutree_report_cpu_starting() earlier
>
> Carlos Llamas <cmllamas@google.com>
>     binder: fix unused alloc->free_async_space
>
> Carlos Llamas <cmllamas@google.com>
>     binder: fix async space check for 0-sized buffers
>
> David Howells <dhowells@redhat.com>
>     keys, dns: Fix size check of V1 server-list header
>
> Jordan Rome <linux@jordanrome.com>
>     selftests/bpf: Add assert for user stacks in test_task_stack
>
> Tejun Heo <tj@kernel.org>
>     Revert "kernfs: convert kernfs_idr_lock to an irq safe raw spinlock"
>
> Andrea Righi <andrea.righi@canonical.com>
>     kernfs: convert kernfs_idr_lock to an irq safe raw spinlock
>
> Jing Xia <jing.xia@unisoc.com>
>     class: fix use-after-free in class_register()
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     of: unittest: Fix of_count_phandle_with_args() expected value message
>
> Dario Binacchi <dario.binacchi@amarulasolutions.com>
>     fbdev: imxfb: fix left margin setting
>
> Christian A. Ehrhardt <lk@c--e.de>
>     of: Fix double free in of_parse_phandle_with_args_map
>
> Li Nan <linan122@huawei.com>
>     ksmbd: validate the zero field of packet header
>
> Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>     kselftest/alsa - conf: Stringify the printed errno in sysfs_get()
>
> Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>     kselftest/alsa - mixer-test: Fix the print format specifier warning
>
> Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>     kselftest/alsa - mixer-test: fix the number of parameters to ksft_exi=
t_fail_msg()
>
> Arnd Bergmann <arnd@arndb.de>
>     drm/amd/display: avoid stringop-overflow warnings for dp_decide_lane_=
settings()
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     drm/amd/pm/smu7: fix a memleak in smu7_hwmgr_backend_init
>
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amdkfd: Confirm list is non-empty before utilizing list_first_ent=
ry in kfd_topology.c
>
> Sergey Gorenko <sergeygo@nvidia.com>
>     IB/iser: Prevent invalidating wrong MR
>
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     gpio: sysfs: drop the mention of gpiochip_find() from sysfs code
>
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     gpiolib: provide gpio_device_find()
>
> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>     gpiolib: make gpio_device_get() and gpio_device_put() public
>
> Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>     drm/amdkfd: Fix type of 'dbg_flags' in 'struct kfd_process'
>
> Peter Robinson <pbrobinson@gmail.com>
>     mmc: sdhci_omap: Fix TI SoC dependencies
>
> Peter Robinson <pbrobinson@gmail.com>
>     mmc: sdhci_am654: Fix TI SoC dependencies
>
> Geoffrey D. Bennett <g@b4.vu>
>     ALSA: scarlett2: Add clamp() in scarlett2_mixer_ctl_put()
>
> Geoffrey D. Bennett <g@b4.vu>
>     ALSA: scarlett2: Add missing error checks to *_ctl_get()
>
> Geoffrey D. Bennett <g@b4.vu>
>     ALSA: scarlett2: Allow passing any output to line_out_remap()
>
> Geoffrey D. Bennett <g@b4.vu>
>     ALSA: scarlett2: Add missing error check to scarlett2_usb_set_config(=
)
>
> Geoffrey D. Bennett <g@b4.vu>
>     ALSA: scarlett2: Add missing error check to scarlett2_config_save()
>
> Hans de Goede <hdegoede@redhat.com>
>     ASoC: rt5645: Drop double EF20 entry from dmi_platform_data[]
>
> Philipp Zabel <p.zabel@pengutronix.de>
>     pwm: stm32: Fix enable count for clk in .probe()
>
> Philipp Zabel <p.zabel@pengutronix.de>
>     pwm: stm32: Use hweight32 in stm32_pwm_detect_channels
>
> Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
>     clk: fixed-rate: fix clk_hw_register_fixed_rate_with_accuracy_parent_=
hw
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     clk: qcom: dispcc-sm8550: Update disp PLL settings
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     clk: qcom: gcc-sm8550: Mark RCGs shared where applicable
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     clk: qcom: gcc-sm8550: use collapse-voting for PCIe GDSCs
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     clk: qcom: gcc-sm8550: Mark the PCIe GDSCs votable
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     clk: qcom: gcc-sm8550: Add the missing RETAIN_FF_ENABLE GDSC flag
>
> Xingyuan Mo <hdthky0@gmail.com>
>     accel/habanalabs: fix information leak in sec_attest_info()
>
> N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>     drm/mediatek: dp: Add phy_mtk_dp module as pre-dependency
>
> Gergo Koteles <soyer@irl.hu>
>     ASoC: tas2781: add support for FW version 0x0503
>
> Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>     ASoC: amd: vangogh: Drop conflicting ACPI-based probing
>
> Su Hui <suhui@nfschina.com>
>     clk: si5341: fix an error code problem in si5341_output_clk_set_rate
>
> Marek Vasut <marek.vasut+renesas@mailbox.org>
>     clk: rs9: Fix DIF OEn bit placement on 9FGV0241
>
> Vignesh Raghavendra <vigneshr@ti.com>
>     watchdog: rti_wdt: Drop runtime pm reference count when watchdog is u=
nused
>
> Stefan Wahren <wahrenst@gmx.net>
>     watchdog: bcm2835_wdt: Fix WDIOC_SETTIMEOUT handling
>
> Jerry Hoemann <jerry.hoemann@hpe.com>
>     watchdog/hpwdt: Only claim UNKNOWN NMI if from iLO
>
> Curtis Klein <curtis.klein@hpe.com>
>     watchdog: set cdev owner before adding
>
> Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>     drivers: clk: zynqmp: update divider round rate logic
>
> Jay Buddhabhatti <jay.buddhabhatti@amd.com>
>     drivers: clk: zynqmp: calculate closest mux rate
>
> Yang Yingliang <yangyingliang@huawei.com>
>     clk: sp7021: fix return value check in sp7021_clk_probe()
>
> Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>     clk: qcom: videocc-sm8150: Add missing PLL config property
>
> Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>     clk: qcom: videocc-sm8150: Update the videocc resets
>
> Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>     dt-bindings: clock: Update the videocc resets for sm8150
>
> Zhiguo Niu <zhiguo.niu@unisoc.com>
>     f2fs: fix to check return value of f2fs_recover_xattr_data
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     drm/amd/pm: fix a double-free in amdgpu_parse_extended_power_table
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     gpu/drm/radeon: fix two memleaks in radeon_vm_init
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     drivers/amd/pm: fix a use-after-free in kv_parse_power_table
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     drm/amd/pm: fix a double-free in si_dpm_init
>
> Alex Deucher <alexander.deucher@amd.com>
>     drm/amdgpu/debugfs: fix error code when smc register accessors are NU=
LL
>
> Hsiao Chien Sung <shawn.sung@mediatek.com>
>     drm/mediatek: Fix underrun in VDO1 when switches off the layer
>
> Hsiao Chien Sung <shawn.sung@mediatek.com>
>     drm/mediatek: Remove the redundant driver data for DPI
>
> Hsiao Chien Sung <shawn.sung@mediatek.com>
>     drm/mediatek: Return error if MDP RDMA failed to enable the clock
>
> Jessica Zhang <quic_jesszhan@quicinc.com>
>     drm/msm/dpu: Drop enable and frame_count parameters from dpu_hw_setup=
_misr()
>
> Jessica Zhang <quic_jesszhan@quicinc.com>
>     drm/msm/dpu: Set input_sel bit for INTF
>
> Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>     clk: renesas: rzg2l: Check reset monitor registers
>
> Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>     clk: renesas: rzg2l-cpg: Reuse code in rzg2l_cpg_reset()
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     media: dvb-frontends: m88ds3103: Fix a memory leak in an error handli=
ng path of m88ds3103_probe()
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     media: dvbdev: drop refcount on error path in dvb_device_open()
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to update iostat correctly in f2fs_filemap_fault()
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to check compress file in f2fs_move_file_range()
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to wait on block writeback for post_read case
>
> Chris Morgan <macromorgan@hotmail.com>
>     drm/panel: st7701: Fix AVCL calculation
>
> Bjorn Andersson <quic_bjorande@quicinc.com>
>     drm/msm/adreno: Fix A680 chip id
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     media: rkisp1: Fix media device memory leak
>
> Mehdi Djait <mehdi.djait@bootlin.com>
>     media: dt-bindings: media: rkisp1: Fix the port description for the p=
arallel interface
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     media: imx-mipi-csis: Drop extra clock enable at probe()
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     media: imx-mipi-csis: Fix clock handling in remove()
>
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: bttv: add back vbi hack
>
> Hans Verkuil <hverkuil-cisco@xs4all.nl>
>     media: bttv: start_streaming should return a proper error code
>
> Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
>     clk: qcom: gpucc-sm8150: Update the gpu_cc_pll1 config
>
> Chengchang Tang <tangchengchang@huawei.com>
>     RDMA/hns: Fix memory leak in free_mr_init()
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     media: cx231xx: fix a memleak in cx231xx_init_isoc
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     drm/bridge: tc358767: Fix return value on error case
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     drm/bridge: cdns-mhdp8546: Fix use of uninitialized variable
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     drm/radeon/trinity_dpm: fix a memleak in trinity_parse_power_table
>
> Zhipeng Lu <alexious@zju.edu.cn>
>     drm/radeon/dpm: fix a memleak in sumo_parse_power_table
>
> Yang Yingliang <yangyingliang@huawei.com>
>     drm/radeon: check the alloc_workqueue return value in radeon_crtc_ini=
t()
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/msm/dpu: correct clk bit for WB2 block
>
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>     drm/panfrost: Ignore core_mask for poweroff and disable PWRTRANS irq
>
> Bard Liao <yung-chuan.liao@linux.intel.com>
>     ASoC: SOF: topology: Use partial match for disconnecting DAI link and=
 DAI widget
>
> Bard Liao <yung-chuan.liao@linux.intel.com>
>     ASoC: Intel: sof_sdw_rt_sdca_jack_common: ctx->headset_codec_dev =3D =
NULL
>
> Brent Lu <brent.lu@intel.com>
>     ASoC: Intel: glk_rt5682_max98357a: fix board id mismatch
>
> Sebastian Reichel <sre@kernel.org>
>     media: v4l: async: Fix duplicated list deletion
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/drv: propagate errors from drm_modeset_register_all()
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     drm/msm/dsi: Use pm_runtime_resume_and_get to prevent refcnt leaks
>
> Bjorn Andersson <quic_bjorande@quicinc.com>
>     drm/msm/dpu: Add missing safe_lut_tbl in sc8180x catalog
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     drm/msm/mdp4: flush vblank event on disable
>
> Linus Walleij <linus.walleij@linaro.org>
>     ASoC: cs35l33: Fix GPIO name and drop legacy include
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     drm/imx/lcdc: Fix double-free of driver data
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     drm/tidss: Fix dss reset
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     drm/tidss: Check for K2G in in dispc_softreset()
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     drm/tidss: Return error value from from softreset
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     drm/tidss: Move reset to the end of dispc_init()
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     drm/radeon: check return value of radeon_ring_lock()
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     drm/radeon/r100: Fix integer overflow issues in r100_cs_track_check()
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     drm/radeon/r600_cs: Fix possible int overflows in r600_cs_check_reg()
>
> Chao Yu <chao@kernel.org>
>     f2fs: fix to avoid dirent corruption
>
> Dario Binacchi <dario.binacchi@amarulasolutions.com>
>     drm/bridge: Fix typo in post_disable() description
>
> Alexander Stein <alexander.stein@ew.tq-group.com>
>     media: amphion: Fix VPU core alias name
>
> Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>     media: rkvdec: Hook the (TRY_)DECODER_CMD stateless ioctls
>
> Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>     media: verisilicon: Hook the (TRY_)DECODER_CMD stateless ioctls
>
> Paul Kocialkowski <paul.kocialkowski@bootlin.com>
>     media: visl: Hook the (TRY_)DECODER_CMD stateless ioctls
>
> Zheng Wang <zyytlz.wz@163.com>
>     media: mtk-jpeg: Remove cancel worker in mtk_jpeg_remove to avoid the=
 crash of multi-core JPEG devices
>
> Ricardo B. Marliere <ricardo@marliere.net>
>     media: pvrusb2: fix use after free on context disconnection
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     drm/tilcdc: Fix irq free on unload
>
> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>     drm/bridge: tpd12s015: Drop buggy __exit annotation for remove functi=
on
>
> Abhinav Singh <singhabhinav9051571833@gmail.com>
>     drm/nouveau/fence:: fix warning directly dereferencing a rcu pointer
>
> Chris Morgan <macromorgan@hotmail.com>
>     drm/panel-elida-kd35t133: hold panel in reset for unprepare
>
> Chris Morgan <macromorgan@hotmail.com>
>     drm/panel: nv3051d: Hold panel in reset for unprepare
>
> Junxian Huang <huangjunxian6@hisilicon.com>
>     RDMA/hns: Fix inappropriate err code for unsupported operations
>
> Leon Romanovsky <leon@kernel.org>
>     RDMA/usnic: Silence uninitialized symbol smatch warnings
>
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>     drm/panfrost: Really power off GPU cores in panfrost_gpu_power_off()
>
> Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
>     drm/dp_mst: Fix fractional DSC bpp handling
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     Revert "drm/omapdrm: Annotate dma-fence critical section in commit pa=
th"
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     Revert "drm/tidss: Annotate dma-fence critical section in commit path=
"
>
> Arnd Bergmann <arnd@arndb.de>
>     ARM: davinci: always select CONFIG_CPU_ARM926T
>
> Eric Dumazet <edumazet@google.com>
>     ip6_tunnel: fix NEXTHDR_FRAGMENT handling in ip6_tnl_parse_tlv_enc_li=
m()
>
> David Howells <dhowells@redhat.com>
>     rxrpc: Fix skbuff cleanup of call's recvmsg_queue and rx_oos_queue
>
> Asmaa Mnebhi <asmaa@nvidia.com>
>     mlxbf_gige: Enable the GigE port in mlxbf_gige_open
>
> Asmaa Mnebhi <asmaa@nvidia.com>
>     mlxbf_gige: Fix intermittent no ip issue
>
> Tao Liu <taoliu828@163.com>
>     net/sched: act_ct: fix skb leak and crash on ooo frags
>
> Ming Lei <ming.lei@redhat.com>
>     blk-cgroup: fix rcu lockdep warning in blkg_lookup()
>
> Eric Dumazet <edumazet@google.com>
>     sctp: fix busy polling
>
> Eric Dumazet <edumazet@google.com>
>     sctp: support MSG_ERRQUEUE flag in recvmsg()
>
> John Fastabend <john.fastabend@gmail.com>
>     bpf: sockmap, fix proto update hook to avoid dup calls
>
> Benjamin Berg <benjamin.berg@intel.com>
>     wifi: cfg80211: parse all ML elements in an ML probe response
>
> Benjamin Berg <benjamin.berg@intel.com>
>     wifi: cfg80211: correct comment about MLD ID
>
> Andy Yan <andyshrk@163.com>
>     arm64: dts: rockchip: Fix led pinctrl of lubancat 1
>
> Christoph Hellwig <hch@lst.de>
>     null_blk: don't cap max_hw_sectors to BLK_DEF_MAX_SECTORS
>
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     Bluetooth: btmtkuart: fix recv_buf() return value
>
> Francesco Dolcini <francesco.dolcini@toradex.com>
>     Bluetooth: btnxpuart: fix recv_buf() return value
>
> Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>     Bluetooth: Fix bogus check for re-auth no supported with non-ssp
>
> Pablo Neira Ayuso <pablo@netfilter.org>
>     netfilter: nf_tables: validate chain type update if available
>
> Florian Westphal <fw@strlen.de>
>     netfilter: nf_tables: mark newset as dead on transaction abort
>
> Miri Korenblit <miriam.rachel.korenblit@intel.com>
>     wifi: iwlwifi: assign phy_ctxt before eSR activation
>
> Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
>     wifi: iwlwifi: fix out of bound copy_from_user
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: iwlwifi: mvm: send TX path flush in rfkill
>
> Johannes Berg <johannes.berg@intel.com>
>     wifi: iwlwifi: mvm: set siso/mimo chains to 1 in FW SMPS request
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: rtl8192se: using calculate_bit_shift()
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: rtl8192ee: using calculate_bit_shift()
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: rtl8192de: using calculate_bit_shift()
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: rtl8192ce: using calculate_bit_shift()
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: rtl8192cu: using calculate_bit_shift()
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: rtl8192c: using calculate_bit_shift()
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: rtl8188ee: phy: using calculate_bit_shift()
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: add calculate_bit_shift()
>
> Hou Tao <houtao1@huawei.com>
>     bpf: Use c->unit_size to select target cache during free
>
> Hou Tao <houtao1@huawei.com>
>     bpf: Use pcpu_alloc_size() in bpf_mem_free{_rcu}()
>
> Hou Tao <houtao1@huawei.com>
>     bpf: Re-enable unit_size checking for global per-cpu allocator
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sc8180x: Fix up PCIe nodes
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     arm64: dts: qcom: sc8180x: switch PCIe QMP PHY to new style of bindin=
gs
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sc8180x: Mark PCIe hosts cache-coherent
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sm8550: Update idle state time requirements
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sm8550: Separate out X3 idle state
>
> Chukun Pan <amadeus@jmu.edu.cn>
>     arm64: dts: qcom: ipq6018: fix clock rates for GCC_USB0_MOCK_UTMI_CLK
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sc7280: Mark SDHCI hosts as cache-coherent
>
> Li Nan <linan122@huawei.com>
>     block: add check of 'minors' and 'first_minor' in device_add_disk()
>
> Abel Vesa <abel.vesa@linaro.org>
>     soc: qcom: llcc: Fix LLCC_TRP_ATTR2_CFGn offset
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     arm64: dts: qcom: sm8150-hdk: fix SS USB regulators
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     arm64: dts: qcom: sm8150: make dispcc cast minimal vote on MMCX
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sm6375: Hook up MPM
>
> Johan Hovold <johan+linaro@kernel.org>
>     arm64: dts: qcom: sm6375: fix USB wakeup interrupt types
>
> Atul Dhudase <quic_adhudase@quicinc.com>
>     soc: qcom: llcc: Fix dis_cap_alloc and retain_on_pc configuration
>
> Nikita Travkin <nikita@trvn.ru>
>     arm64: dts: qcom: acer-aspire1: Correct audio codec definition
>
> Hou Tao <houtao1@huawei.com>
>     bpf: Limit the number of kprobes when attaching program to multiple k=
probes
>
> Hou Tao <houtao1@huawei.com>
>     bpf: Limit the number of uprobes when attaching program to multiple u=
probes
>
> Joakim Zhang <joakim.zhang@cixtech.com>
>     dma-mapping: clear dev->dma_mem to NULL after freeing it
>
> Arseniy Krasnov <avkrasnov@salutedevices.com>
>     virtio/vsock: send credit update during setting SO_RCVLOWAT
>
> Arseniy Krasnov <avkrasnov@salutedevices.com>
>     virtio/vsock: fix logic which reduces credit update messages
>
> Leone Fernando <leone4fernando@gmail.com>
>     ipmr: support IP_PKTINFO on cache report IGMP msg
>
> Hangbin Liu <liuhangbin@gmail.com>
>     selftests/net: fix grep checking for fib_nexthop_multiprefix
>
> Yonghong Song <yonghong.song@linux.dev>
>     bpf: Fix a race condition between btf_put() and map_free()
>
> Ahmad Fatoum <a.fatoum@pengutronix.de>
>     ARM: dts: stm32: don't mix SCMI and non-SCMI board compatibles
>
> Yihang Li <liyihang9@huawei.com>
>     scsi: hisi_sas: Correct the number of global debugfs registers
>
> Yihang Li <liyihang9@huawei.com>
>     scsi: hisi_sas: Rollback some operations if FLR failed
>
> Yihang Li <liyihang9@huawei.com>
>     scsi: hisi_sas: Check before using pointer variables
>
> Yihang Li <liyihang9@huawei.com>
>     scsi: hisi_sas: Replace with standard error code return value
>
> Manivannan Sadhasivam <mani@kernel.org>
>     scsi: ufs: qcom: Fix the return value when platform_get_resource_byna=
me() fails
>
> Manivannan Sadhasivam <mani@kernel.org>
>     scsi: ufs: qcom: Fix the return value of ufs_qcom_ice_program_key()
>
> Adam Ford <aford173@gmail.com>
>     arm64: dts: imx8mm: Reduce GPU to nominal speed
>
> Geert Uytterhoeven <geert+renesas@glider.be>
>     arm64: dts: renesas: white-hawk-cpu: Fix missing serial console pin c=
ontrol
>
> Rob Herring <robh@kernel.org>
>     arm64: dts: xilinx: Apply overlays to base dtbs
>
> Li Nan <linan122@huawei.com>
>     block: Set memalloc_noio to false on device_add_disk() error path
>
> YiFei Zhu <zhuyifei@google.com>
>     selftests/bpf: Relax time_tai test for equal timestamps in tai_forwar=
d
>
> Miri Korenblit <miriam.rachel.korenblit@intel.com>
>     wifi: iwlwifi: don't support triggered EHT CQI feedback
>
> Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>     wifi: mt76: mt7921: fix country count limitation for CLC
>
> Eugen Hristev <eugen.hristev@collabora.com>
>     arm64: dts: mediatek: mt8186: fix address warning for ADSP mailboxes
>
> Chen-Yu Tsai <wenst@chromium.org>
>     arm64: dts: mediatek: mt8186: Fix alias prefix for ovl_2l0
>
> Moudy Ho <moudy.ho@mediatek.com>
>     arm64: dts: mediatek: mt8195: revise VDOSYS RDMA node name
>
> Moudy Ho <moudy.ho@mediatek.com>
>     arm64: dts: mediatek: mt8183: correct MDP3 DMA-related nodes
>
> Moudy Ho <moudy.ho@mediatek.com>
>     dt-bindings: media: mediatek: mdp3: correct RDMA and WROT node with g=
eneric names
>
> Andrei Matei <andreimatei1@gmail.com>
>     bpf: Fix accesses to uninit stack slots
>
> Andrei Matei <andreimatei1@gmail.com>
>     bpf: Guard stack limits against 32bit overflow
>
> Johan Hovold <johan+linaro@kernel.org>
>     arm64: dts: hisilicon: hikey970-pmic: fix regulator cells properties
>
> Andrei Matei <andreimatei1@gmail.com>
>     bpf: Fix verification of indirect var-off stack access
>
> Wang Zhao <wang.zhao@mediatek.com>
>     wifi: mt76: mt7921s: fix workqueue problem causes STA association fai=
l
>
> StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>     wifi: mt76: mt7915: also MT7981 is 3T3R but nss2 on 5 GHz band
>
> StanleyYP Wang <StanleyYP.Wang@mediatek.com>
>     wifi: mt76: mt7915: fix EEPROM offset of TSSI flag on MT7981
>
> MeiChia Chiu <meichia.chiu@mediatek.com>
>     wifi: mt76: mt7996: fix rate usage of inband discovery frames
>
> Sujuan Chen <sujuan.chen@mediatek.com>
>     wifi: mt76: mt7996: fix the size of struct bss_rate_tlv
>
> Lorenzo Bianconi <lorenzo@kernel.org>
>     wifi: mt76: mt7915: fallback to non-wed mode if platform_get_resource=
 fails in mt7915_mmio_wed_init()
>
> Christian Marangi <ansuelsmth@gmail.com>
>     wifi: mt76: fix typo in mt76_get_of_eeprom_from_nvmem function
>
> Johan Hovold <johan+linaro@kernel.org>
>     arm64: dts: qcom: sm8550: fix USB wakeup interrupt types
>
> Johan Hovold <johan+linaro@kernel.org>
>     arm64: dts: qcom: sc7280: fix usb_2 wakeup interrupt types
>
> Johan Hovold <johan+linaro@kernel.org>
>     arm64: dts: qcom: sa8775p: fix USB wakeup interrupt types
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sc7280: Mark Adreno SMMU as DMA coherent
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sc7280: Fix up GPU SIDs
>
> Nia Espera <nespera@igalia.com>
>     arm64: dts: qcom: sm8350: Fix DMA0 address
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sm6125: add interrupts to DWC3 USB controller
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sdm845-db845c: correct LED panic indicator
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: qrb5165-rb5: correct LED panic indicator
>
> Caleb Connolly <caleb.connolly@linaro.org>
>     arm64: dts: qcom: qrb2210-rb1: use USB host mode
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: qrb2210-rb1: Hook up USB3
>
> Artem Chernyshev <artem.chernyshev@red-soft.ru>
>     scsi: fnic: Return error if vmalloc() failed
>
> Andrii Nakryiko <andrii@kernel.org>
>     bpf: fix check for attempt to corrupt spilled pointer
>
> Hangbin Liu <liuhangbin@gmail.com>
>     selftests/net: specify the interface when do arping
>
> Hou Tao <houtao1@huawei.com>
>     bpf: Defer the free of inner map when necessary
>
> Hou Tao <houtao1@huawei.com>
>     bpf: Add map and need_defer parameters to .map_fd_put_ptr()
>
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: qcom: sm6350: Make watchdog bark interrupt edge triggered
>
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: qcom: sc8280xp: Make watchdog bark interrupt edge trigger=
ed
>
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: qcom: sa8775p: Make watchdog bark interrupt edge triggere=
d
>
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: qcom: sm8250: Make watchdog bark interrupt edge triggered
>
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: qcom: sm8150: Make watchdog bark interrupt edge triggered
>
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: qcom: sdm845: Make watchdog bark interrupt edge triggered
>
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: qcom: sc7280: Make watchdog bark interrupt edge triggered
>
> Luca Weiss <luca.weiss@fairphone.com>
>     arm64: dts: qcom: sc7280: Mark some nodes as 'reserved'
>
> Douglas Anderson <dianders@chromium.org>
>     arm64: dts: qcom: sc7180: Make watchdog bark interrupt edge triggered
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sm8550: correct TX Soundwire clock
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     arm64: dts: qcom: sm8450: correct TX Soundwire clock
>
> Bjorn Andersson <quic_bjorande@quicinc.com>
>     arm64: dts: qcom: sc8180x-primus: Fix HALL_INT polarity
>
> Stephen Boyd <swboyd@chromium.org>
>     dt-bindings: arm: qcom: Fix html link
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     ARM: dts: qcom: sdx65: correct SPMI node name
>
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>     ARM: dts: qcom: sdx65: correct PCIe EP phy-names
>
> Andrii Nakryiko <andrii@kernel.org>
>     bpf: enforce precision of R0 on callback return
>
> Yu Kuai <yukuai3@huawei.com>
>     md: synchronize flush io with array reconfiguration
>
> Jeroen van Ingen Schenau <jeroen.vaningenschenau@novoserve.com>
>     selftests/bpf: Fix erroneous bitmask operation
>
> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>     wifi: rtw88: sdio: Honor the host max_req_size in the RX path
>
> Jan Kiszka <jan.kiszka@siemens.com>
>     arm64: dts: ti: iot2050: Re-add aliases
>
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>     arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type
>
> Nitin Yadav <n-yadav@ti.com>
>     arm64: dts: ti: k3-am62a-main: Fix GPIO pin count in DT nodes
>
> Su Hui <suhui@nfschina.com>
>     wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavio=
r
>
> Bart Van Assche <bvanassche@acm.org>
>     scsi: bfa: Use the proper data type for BLIST flags
>
> Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>     firmware: ti_sci: Fix an off-by-one in ti_sci_debugfs_create()
>
> Peter Delevoryas <peter@pjd.dev>
>     net/ncsi: Fix netlink major/minor version numbers
>
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>     ARM: dts: qcom: apq8064: correct XOADC register address
>
> Arnd Bergmann <arnd@arndb.de>
>     wifi: libertas: stop selecting wext
>
> Luca Weiss <luca.weiss@fairphone.com>
>     wifi: ath11k: Defer on rproc_get failure
>
> Jordan Rome <jordalgo@meta.com>
>     bpf: Add crosstask check to __bpf_get_stack
>
> Florian Lehner <dev@der-flo.net>
>     bpf, lpm: Fix check prefixlen before walking trie
>
> Chih-Kang Chang <gary.chang@realtek.com>
>     wifi: rtw88: fix RX filter in FIF_ALLMULTI flag
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     wifi: plfxlc: check for allocation failure in plfxlc_usb_wreq_async()
>
> Luca Weiss <luca@z3ntu.xyz>
>     ARM: dts: qcom: msm8226: provide dsi phy clocks to mmcc
>
> Johan Hovold <johan+linaro@kernel.org>
>     arm64: dts: qcom: sc8280xp-x13s: add missing camera LED pin config
>
> Konrad Dybcio <konrad.dybcio@linaro.org>
>     arm64: dts: qcom: sc8280xp-x13s: Use the correct DP PHY compatible
>
> Caleb Connolly <caleb.connolly@linaro.org>
>     arm64: dts: qcom: qrb4210-rb2: don't force usb peripheral mode
>
> David McKay <david.mckay@codasip.com>
>     asm-generic: Fix 32 bit __generic_cmpxchg_local
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     pNFS: Fix the pnfs block driver's calculation of layoutget size
>
> Olga Kornievskaia <kolga@netapp.com>
>     SUNRPC: fix _xprt_switch_find_current_entry logic
>
> Trond Myklebust <trond.myklebust@hammerspace.com>
>     NFSv4.1/pnfs: Ensure we handle the error NFS4ERR_RETURNCONFLICT
>
> Scott Mayhew <smayhew@redhat.com>
>     NFS: Use parent's objective cred in nfs_access_login_time()
>
> Benjamin Coddington <bcodding@redhat.com>
>     blocklayoutdriver: Fix reference leak of pnfs_device_node
>
> Arnd Bergmann <arnd@arndb.de>
>     csky: fix arch_jump_label_transform_static override
>
> Chengming Zhou <zhouchengming@bytedance.com>
>     crypto: scomp - fix req->dst buffer overflow
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - do not resize req->src when doing hash operations
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - fix processing hash requests with req->nbytes < sg->=
length
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - improve error handling in sahara_sha_process()
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - fix wait_for_completion_timeout() error handling
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - fix ahash reqsize
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - handle zero-length aes requests
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - avoid skcipher fallback code duplication
>
> wangyangxin <wangyangxin1@huawei.com>
>     crypto: virtio - Wait for tasklet to complete on device remove
>
> Alexander Aring <aahringo@redhat.com>
>     dlm: fix format seq ops type 4
>
> Edward Adam Davis <eadavis@qq.com>
>     gfs2: fix kernel BUG in gfs2_quota_cleanup
>
> Osama Muhammad <osmtendev@gmail.com>
>     gfs2: Fix kernel NULL pointer dereference in gfs2_rgrp_dump
>
> Christian Brauner <brauner@kernel.org>
>     fs: indicate request originates from old mount API
>
> Gao Xiang <xiang@kernel.org>
>     erofs: fix memory leak on short-lived bounced pages
>
> Sergey Shtylyov <s.shtylyov@omp.ru>
>     pstore: ram_core: fix possible overflow in persistent_ram_init_ecc()
>
> Zhiqi Song <songzhiqi1@huawei.com>
>     crypto: hisilicon/zip - save capability registers in probe process
>
> Zhiqi Song <songzhiqi1@huawei.com>
>     crypto: hisilicon/sec2 - save capability registers in probe process
>
> Zhiqi Song <songzhiqi1@huawei.com>
>     crypto: hisilicon/hpre - save capability registers in probe process
>
> Wenkai Lin <linwenkai6@hisilicon.com>
>     crypto: hisilicon/qm - add a function to set qm algs
>
> Chenghai Huang <huangchenghai2@huawei.com>
>     crypto: hisilicon/zip - add zip comp high perf mode configuration
>
> Zhiqi Song <songzhiqi1@huawei.com>
>     crypto: hisilicon/qm - save capability registers in qm init process
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - fix error handling in sahara_hw_descriptor_create()
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - fix processing requests with cryptlen < sg->length
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - fix ahash selftest failure
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - fix cbc selftest failure
>
> Ovidiu Panait <ovidiu.panait@windriver.com>
>     crypto: sahara - remove FLAGS_NEW_KEY logic
>
> Nikita Zhandarovich <n.zhandarovich@fintech.ru>
>     crypto: safexcel - Add error handling for dma_map_sg() calls
>
> Herbert Xu <herbert@gondor.apana.org.au>
>     crypto: af_alg - Disallow multiple in-flight AIO requests
>
> Dinghao Liu <dinghao.liu@zju.edu.cn>
>     crypto: ccp - fix memleak in ccp_init_dm_workarea
>
> Chen Ni <nichen@iscas.ac.cn>
>     crypto: sa2ul - Return crypto_aead_setkey to transfer the error
>
> Gonglei (Arei) <arei.gonglei@huawei.com>
>     crypto: virtio - Handle dataq logic with tasklet
>
> Chanho Park <chanho61.park@samsung.com>
>     crypto: jh7110 - Correct deferred probe return
>
> Dan Carpenter <dan.carpenter@linaro.org>
>     crypto: rsa - add a check for allocation failure
>
> Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>     selinux: Fix error priority for bind with AF_UNSPEC on PF_INET6 socke=
t
>
> Binbin Zhou <zhoubinbin@loongson.cn>
>     drivers/thermal/loongson2_thermal: Fix incorrect PTR_ERR() judgment
>
> Borislav Petkov (AMD) <bp@alien8.de>
>     cpuidle: haltpoll: Do not enable interrupts when entering idle
>
> ZhaoLong Wang <wangzhaolong1@huawei.com>
>     mtd: Fix gluebi NULL pointer dereference caused by ftl notifier
>
> Richard Fitzgerald <rf@opensource.cirrus.com>
>     kunit: debugfs: Fix unchecked dereference in debugfs_print_results()
>
> Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>     thermal: core: Fix NULL pointer dereference in zone registration erro=
r path
>
> Tony Luck <tony.luck@intel.com>
>     ACPI: extlog: Clear Extended Error Log status when RAS_CEC handled th=
e error
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>     ACPI: LPSS: Fix the fractional clock divider flags
>
> Wolfram Sang <wsa+renesas@sang-engineering.com>
>     spi: sh-msiof: Enforce fixed DTDL for R-Car H3
>
> Ard Biesheuvel <ardb@kernel.org>
>     efivarfs: Free s_fs_info on unmount
>
> Ilias Apalodimas <ilias.apalodimas@linaro.org>
>     efivarfs: force RO when remounting if SetVariable is not supported
>
> Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
>     calipso: fix memory leak in netlbl_calipso_add_pass()
>
> Alexandra Diupina <adiupina@astralinux.ru>
>     cpufreq: scmi: process the result of devm_of_clk_add_hw_provider()
>
> David E. Box <david.e.box@linux.intel.com>
>     platform/x86/intel/vsec: Fix xa_alloc memory leak
>
> Yang Yingliang <yangyingliang@huawei.com>
>     spi: cadence-quadspi: add missing clk_disable_unprepare() in cqspi_pr=
obe()
>
> Chen Ni <nichen@iscas.ac.cn>
>     KEYS: encrypted: Add check for strsep
>
> Nikita Kiryushin <kiryushin@ancud.ru>
>     ACPI: LPIT: Avoid u32 multiplication overflow
>
> Nikita Kiryushin <kiryushin@ancud.ru>
>     ACPI: video: check for error while searching for backlight device par=
ent
>
> Ronald Monthero <debug.penguin32@gmail.com>
>     mtd: rawnand: Increment IFC_TIMEOUT_MSECS for nand controller respons=
e
>
> Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
>     spi: spi-zynqmp-gqspi: fix driver kconfig dependencies
>
> Alexander Antonov <alexander.antonov@linux.intel.com>
>     perf/x86/intel/uncore: Fix NULL pointer dereference issue in upi_fill=
_topology()
>
> Yiwei Lin <s921975628@gmail.com>
>     sched/fair: Update min_vruntime for reweight_entity() correctly
>
> Kunwu Chan <chentao@kylinos.cn>
>     powerpc/imc-pmu: Add a null pointer check in update_events_in_group()
>
> Kunwu Chan <chentao@kylinos.cn>
>     powerpc/powernv: Add a null pointer check in opal_powercap_init()
>
> Kunwu Chan <chentao@kylinos.cn>
>     powerpc/powernv: Add a null pointer check in opal_event_init()
>
> Kunwu Chan <chentao@kylinos.cn>
>     powerpc/powernv: Add a null pointer check to scom_debug_init_one()
>
> Nathan Lynch <nathanl@linux.ibm.com>
>     powerpc/rtas: Avoid warning on invalid token argument to sys_rtas()
>
> Kajol Jain <kjain@linux.ibm.com>
>     powerpc/hv-gpci: Add return value check in affinity_domain_via_partit=
ion_show function
>
> Michael Ellerman <mpe@ellerman.id.au>
>     selftests/powerpc: Fix error handling in FPU/VMX preemption tests
>
> Nicholas Piggin <npiggin@gmail.com>
>     KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MS=
R_EE
>
> Jordan Niethe <jniethe5@gmail.com>
>     KVM: PPC: Book3S HV: Introduce low level MSR accessor
>
> Jordan Niethe <jniethe5@gmail.com>
>     KVM: PPC: Book3S HV: Use accessors for VCPU registers
>
> Junhao He <hejunhao3@huawei.com>
>     drivers/perf: hisi: Fix some event id for HiSilicon UC pmu
>
> Robin Murphy <robin.murphy@arm.com>
>     perf/arm-cmn: Fix HN-F class_occup_id events
>
> Nathan Lynch <nathanl@linux.ibm.com>
>     powerpc/pseries/memhp: Fix access beyond end of drmem array
>
> Randy Dunlap <rdunlap@infradead.org>
>     powerpc/44x: select I2C for CURRITUCK
>
> Peter Zijlstra <peterz@infradead.org>
>     x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram
>
> Masahiro Yamada <masahiroy@kernel.org>
>     powerpc: add crtsavres.o to always-y instead of extra-y
>
> Arnd Bergmann <arnd@arndb.de>
>     EDAC/thunderx: Fix possible out-of-bounds string access
>
> Yazen Ghannam <yazen.ghannam@amd.com>
>     x86/mce/inject: Clear test status value
>
> Colin Ian King <colin.i.king@gmail.com>
>     x86/lib: Fix overflow when counting digits
>
>
> -------------
>
> Diffstat:
>
>  Documentation/devicetree/bindings/arm/qcom.yaml    |   2 +-
>  .../devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml |   2 +-
>  .../bindings/media/mediatek,mdp3-rdma.yaml         |  29 +-
>  .../bindings/media/mediatek,mdp3-wrot.yaml         |  23 +-
>  .../devicetree/bindings/media/rockchip-isp1.yaml   |  11 +-
>  .../phy/qcom,sc8280xp-qmp-usb43dp-phy.yaml         |   4 +-
>  Documentation/driver-api/pci/p2pdma.rst            |  16 +-
>  Makefile                                           |   4 +-
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi           |   2 +-
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi           |   4 +-
>  arch/arm/boot/dts/qcom/qcom-sdx65.dtsi             |   4 +-
>  arch/arm/boot/dts/st/stm32mp157a-dk1-scmi.dts      |   2 +-
>  arch/arm/boot/dts/st/stm32mp157c-dk2-scmi.dts      |   2 +-
>  arch/arm/boot/dts/st/stm32mp157c-ed1-scmi.dts      |   2 +-
>  arch/arm/boot/dts/st/stm32mp157c-ev1-scmi.dts      |   3 +-
>  arch/arm/mach-davinci/Kconfig                      |   2 +
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi          |   4 +-
>  arch/arm64/boot/dts/hisilicon/hikey970-pmic.dtsi   |   3 -
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi           |   6 +-
>  arch/arm64/boot/dts/mediatek/mt8186.dtsi           |   6 +-
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi           |  24 +-
>  arch/arm64/boot/dts/qcom/ipq6018.dtsi              |   2 +-
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  10 +
>  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts           |   1 -
>  arch/arm64/boot/dts/qcom/qrb5165-rb5.dts           |   2 +-
>  arch/arm64/boot/dts/qcom/sa8775p.dtsi              |  14 +-
>  arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts   |  17 +-
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |   2 +-
>  arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |  24 ++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi               |  20 +-
>  arch/arm64/boot/dts/qcom/sc8180x-primus.dts        |   2 +-
>  arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 152 ++++------
>  .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     |  11 +
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi             |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |   2 +-
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |   2 +-
>  arch/arm64/boot/dts/qcom/sm6125.dtsi               |   4 +
>  arch/arm64/boot/dts/qcom/sm6350.dtsi               |   2 +-
>  arch/arm64/boot/dts/qcom/sm6375.dtsi               |  41 ++-
>  arch/arm64/boot/dts/qcom/sm8150-hdk.dts            |  12 +-
>  arch/arm64/boot/dts/qcom/sm8150.dtsi               |   3 +-
>  arch/arm64/boot/dts/qcom/sm8250.dtsi               |   2 +-
>  arch/arm64/boot/dts/qcom/sm8350.dtsi               |   4 +-
>  arch/arm64/boot/dts/qcom/sm8450.dtsi               |   2 +-
>  arch/arm64/boot/dts/qcom/sm8550.dtsi               |  38 ++-
>  .../boot/dts/renesas/r8a779g0-white-hawk-cpu.dtsi  |   3 +
>  arch/arm64/boot/dts/rockchip/rk3566-lubancat-1.dts |   2 +-
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          |   4 +-
>  arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi |  10 +
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |   2 +-
>  arch/arm64/boot/dts/xilinx/Makefile                |   9 +-
>  arch/arm64/kernel/ptrace.c                         |  13 +-
>  arch/arm64/kvm/vgic/vgic-its.c                     |   5 +
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c                 |  27 +-
>  arch/csky/include/asm/jump_label.h                 |   5 +
>  arch/loongarch/include/asm/elf.h                   |   5 -
>  arch/loongarch/kernel/elf.c                        |   5 -
>  arch/loongarch/kernel/process.c                    |   1 +
>  arch/loongarch/net/bpf_jit.c                       |   5 +-
>  arch/mips/alchemy/devboards/db1200.c               |   2 +-
>  arch/mips/alchemy/devboards/db1550.c               |   2 +-
>  arch/mips/include/asm/dmi.h                        |   2 +-
>  arch/mips/kernel/setup.c                           |   4 +-
>  arch/mips/kernel/smp.c                             |   4 +-
>  arch/powerpc/Kconfig                               |   1 +
>  arch/powerpc/kernel/rtas.c                         |  19 +-
>  arch/powerpc/kvm/book3s_64_mmu_hv.c                |   5 +-
>  arch/powerpc/kvm/book3s_64_mmu_radix.c             |   5 +-
>  arch/powerpc/kvm/book3s_hv.c                       | 198 ++++++------
>  arch/powerpc/kvm/book3s_hv.h                       |  68 +++++
>  arch/powerpc/kvm/book3s_hv_builtin.c               |   5 +-
>  arch/powerpc/lib/Makefile                          |   2 +-
>  arch/powerpc/perf/hv-gpci.c                        |   3 +
>  arch/powerpc/perf/imc-pmu.c                        |   6 +
>  arch/powerpc/platforms/44x/Kconfig                 |   1 +
>  arch/powerpc/platforms/powernv/opal-irqchip.c      |   2 +
>  arch/powerpc/platforms/powernv/opal-powercap.c     |   6 +
>  arch/powerpc/platforms/powernv/opal-xscom.c        |   5 +
>  arch/powerpc/platforms/pseries/hotplug-memory.c    |   9 +-
>  arch/riscv/include/asm/sections.h                  |   1 +
>  arch/riscv/include/asm/xip_fixup.h                 |   2 +-
>  arch/riscv/kernel/module.c                         |   3 +-
>  arch/riscv/kernel/patch.c                          |  11 +-
>  arch/riscv/kernel/vmlinux-xip.lds.S                |   2 +
>  arch/riscv/kernel/vmlinux.lds.S                    |   2 +
>  arch/riscv/mm/pageattr.c                           | 275 ++++++++++++++-=
--
>  arch/s390/include/asm/pci_io.h                     |  32 +-
>  arch/s390/pci/pci_mmio.c                           |  12 +-
>  arch/um/drivers/virt-pci.c                         |   2 +-
>  arch/x86/events/intel/uncore_snbep.c               |  10 +-
>  arch/x86/include/asm/kvm-x86-pmu-ops.h             |   2 +-
>  arch/x86/include/asm/mwait.h                       |  11 +-
>  arch/x86/kernel/cpu/mce/inject.c                   |   1 +
>  arch/x86/kernel/kvmclock.c                         |  12 +-
>  arch/x86/kvm/pmu.c                                 |  63 +++-
>  arch/x86/kvm/pmu.h                                 |  18 --
>  arch/x86/kvm/svm/nested.c                          |  15 -
>  arch/x86/kvm/svm/pmu.c                             |  16 -
>  arch/x86/kvm/vmx/pmu_intel.c                       |  20 --
>  arch/x86/lib/misc.c                                |   2 +-
>  arch/x86/pci/mmconfig-shared.c                     |  13 +-
>  block/bio.c                                        |  46 +--
>  block/blk-cgroup.h                                 |   3 +-
>  block/blk-mq.c                                     |  16 +-
>  block/genhd.c                                      |   5 +-
>  block/ioctl.c                                      |  11 +-
>  crypto/af_alg.c                                    |  14 +-
>  crypto/rsa.c                                       |   2 +
>  crypto/scompress.c                                 |   6 +
>  drivers/accel/habanalabs/common/habanalabs_ioctl.c |   2 +-
>  drivers/acpi/acpi_extlog.c                         |   7 +-
>  drivers/acpi/acpi_lpit.c                           |   2 +-
>  drivers/acpi/acpi_lpss.c                           |   3 +-
>  drivers/acpi/acpi_video.c                          |  12 +-
>  drivers/acpi/property.c                            |   4 +
>  drivers/android/binder_alloc.c                     |  22 +-
>  drivers/base/class.c                               |   1 +
>  drivers/base/node.c                                |   9 +-
>  drivers/base/swnode.c                              |   3 +
>  drivers/block/loop.c                               |  52 ++--
>  drivers/block/null_blk/main.c                      |  12 +-
>  drivers/bluetooth/btmtkuart.c                      |  11 +-
>  drivers/bluetooth/btnxpuart.c                      |   7 +-
>  drivers/bus/mhi/ep/main.c                          | 139 ++++++---
>  drivers/bus/mhi/ep/ring.c                          |  41 +--
>  drivers/clk/clk-renesas-pcie.c                     |   2 +-
>  drivers/clk/clk-si5341.c                           |   4 +-
>  drivers/clk/clk-sp7021.c                           |  12 +-
>  drivers/clk/qcom/dispcc-sm8550.c                   |   8 +
>  drivers/clk/qcom/gcc-sm8550.c                      | 110 +++----
>  drivers/clk/qcom/gpucc-sm8150.c                    |   4 +-
>  drivers/clk/qcom/videocc-sm8150.c                  |   5 +
>  drivers/clk/renesas/rzg2l-cpg.c                    |  91 +++---
>  drivers/clk/zynqmp/clk-mux-zynqmp.c                |   2 +-
>  drivers/clk/zynqmp/divider.c                       |  66 +---
>  drivers/clocksource/timer-ti-dm.c                  |   4 +-
>  drivers/cpufreq/scmi-cpufreq.c                     |   7 +-
>  drivers/cpuidle/cpuidle-haltpoll.c                 |   9 +-
>  drivers/crypto/ccp/ccp-ops.c                       |   5 +-
>  drivers/crypto/hisilicon/hpre/hpre_main.c          | 122 ++++----
>  drivers/crypto/hisilicon/qm.c                      |  98 +++++-
>  drivers/crypto/hisilicon/sec2/sec.h                |   7 +
>  drivers/crypto/hisilicon/sec2/sec_crypto.c         |  13 +-
>  drivers/crypto/hisilicon/sec2/sec_main.c           |  70 +++--
>  drivers/crypto/hisilicon/zip/zip_main.c            | 175 ++++++++---
>  drivers/crypto/inside-secure/safexcel_cipher.c     |  19 +-
>  drivers/crypto/sa2ul.c                             |   3 +-
>  drivers/crypto/sahara.c                            | 248 +++++++--------
>  drivers/crypto/starfive/jh7110-cryp.c              |  10 +-
>  drivers/crypto/virtio/virtio_crypto_common.h       |   2 +
>  drivers/crypto/virtio/virtio_crypto_core.c         |  26 +-
>  drivers/cxl/core/port.c                            |  24 +-
>  drivers/cxl/core/region.c                          |   2 +-
>  drivers/cxl/cxl.h                                  |   2 -
>  drivers/edac/thunderx_edac.c                       |  10 +-
>  drivers/firmware/ti_sci.c                          |  10 +-
>  drivers/gpio/gpio-mlxbf3.c                         |   2 +
>  drivers/gpio/gpiolib-sysfs.c                       |   2 +-
>  drivers/gpio/gpiolib.c                             |  95 ++++--
>  drivers/gpio/gpiolib.h                             |  10 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c        |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |   2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c            |   7 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c       |  26 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c           |   6 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h              |   2 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  21 +-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |   2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c    |   2 +-
>  .../display/dc/link/protocols/link_dp_training.c   |   2 +-
>  .../display/dc/link/protocols/link_dp_training.h   |   2 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c         |   4 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c     |  52 +---
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c         |   5 +-
>  .../gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c    |   6 +-
>  .../gpu/drm/bridge/cadence/cdns-mhdp8546-hdcp.c    |   3 +-
>  drivers/gpu/drm/bridge/tc358767.c                  |   2 +-
>  drivers/gpu/drm/bridge/ti-tpd12s015.c              |   4 +-
>  drivers/gpu/drm/display/drm_dp_mst_topology.c      |  20 +-
>  drivers/gpu/drm/drm_drv.c                          |  10 +-
>  drivers/gpu/drm/i915/display/intel_dp_mst.c        |   5 +-
>  drivers/gpu/drm/imx/lcdc/imx-lcdc.c                |   9 -
>  drivers/gpu/drm/mediatek/mtk_disp_merge.c          |   2 +-
>  drivers/gpu/drm/mediatek/mtk_dp.c                  |   1 +
>  drivers/gpu/drm/mediatek/mtk_dpi.c                 |  16 +-
>  drivers/gpu/drm/mediatek/mtk_mdp_rdma.c            |   3 +-
>  drivers/gpu/drm/msm/adreno/adreno_device.c         |   2 +-
>  .../drm/msm/disp/dpu1/catalog/dpu_5_1_sc8180x.h    |   1 +
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_0_sm8250.h |   2 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_6_2_sc7180.h |   2 +-
>  .../gpu/drm/msm/disp/dpu1/catalog/dpu_7_2_sc7280.h |   2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_crtc.c           |   4 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |   4 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.c        |   6 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_intf.h        |   4 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.c          |   6 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_lm.h          |   3 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.c        |  20 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_util.h        |   8 +-
>  drivers/gpu/drm/msm/disp/mdp4/mdp4_crtc.c          |   9 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   4 +-
>  drivers/gpu/drm/nouveau/dispnv50/disp.c            |   3 +-
>  drivers/gpu/drm/nouveau/nv04_fence.c               |   2 +-
>  drivers/gpu/drm/omapdrm/omap_drv.c                 |   9 +-
>  drivers/gpu/drm/panel/panel-elida-kd35t133.c       |   2 +
>  drivers/gpu/drm/panel/panel-newvision-nv3051d.c    |   2 +
>  drivers/gpu/drm/panel/panel-sitronix-st7701.c      |   2 +-
>  drivers/gpu/drm/panfrost/panfrost_gpu.c            |  70 +++--
>  drivers/gpu/drm/radeon/r100.c                      |   4 +-
>  drivers/gpu/drm/radeon/r600_cs.c                   |   4 +-
>  drivers/gpu/drm/radeon/radeon_display.c            |   7 +-
>  drivers/gpu/drm/radeon/radeon_vm.c                 |   8 +-
>  drivers/gpu/drm/radeon/si.c                        |   4 +
>  drivers/gpu/drm/radeon/sumo_dpm.c                  |   4 +-
>  drivers/gpu/drm/radeon/trinity_dpm.c               |   4 +-
>  drivers/gpu/drm/tests/drm_dp_mst_helper_test.c     |   6 +-
>  drivers/gpu/drm/tidss/tidss_dispc.c                |  63 +++-
>  drivers/gpu/drm/tidss/tidss_kms.c                  |   4 -
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   2 +-
>  drivers/hid/hid-sensor-hub.c                       |   2 +-
>  drivers/hid/wacom_wac.c                            |  32 +-
>  drivers/i2c/busses/i2c-s3c2410.c                   |  40 +--
>  drivers/idle/intel_idle.c                          |  19 +-
>  drivers/iio/adc/ad7091r-base.c                     |   6 +-
>  drivers/iio/adc/ad9467.c                           | 112 +++++--
>  drivers/iio/adc/adi-axi-adc.c                      |  74 +----
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c         |   6 +-
>  drivers/infiniband/hw/hns/hns_roce_pd.c            |   2 +-
>  drivers/infiniband/hw/mthca/mthca_cmd.c            |   4 +-
>  drivers/infiniband/hw/mthca/mthca_main.c           |   2 +-
>  drivers/infiniband/ulp/iser/iscsi_iser.h           |   2 -
>  drivers/infiniband/ulp/iser/iser_initiator.c       |   5 +-
>  drivers/infiniband/ulp/iser/iser_memory.c          |   8 +-
>  drivers/infiniband/ulp/iser/iser_verbs.c           |   1 -
>  drivers/input/keyboard/atkbd.c                     |  12 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |   1 +
>  drivers/iommu/dma-iommu.c                          |   3 +
>  drivers/iommu/of_iommu.c                           |   7 +
>  drivers/leds/Kconfig                               |   1 +
>  drivers/leds/leds-aw200xx.c                        |   7 +-
>  drivers/md/md.c                                    |  29 +-
>  drivers/md/raid1.c                                 |  12 +-
>  drivers/media/dvb-core/dvbdev.c                    |   2 +
>  drivers/media/dvb-frontends/m88ds3103.c            |   7 +-
>  drivers/media/pci/bt8xx/bttv-driver.c              |  27 +-
>  drivers/media/pci/bt8xx/bttv-vbi.c                 |   8 +-
>  drivers/media/platform/amphion/vpu_core.c          |   2 +-
>  .../media/platform/mediatek/jpeg/mtk_jpeg_core.c   |   1 -
>  drivers/media/platform/nxp/imx-mipi-csis.c         |  17 +-
>  .../media/platform/rockchip/rkisp1/rkisp1-dev.c    |   6 +-
>  drivers/media/platform/verisilicon/hantro_drv.c    |   2 +
>  drivers/media/platform/verisilicon/hantro_v4l2.c   |   3 +
>  drivers/media/test-drivers/visl/visl-video.c       |   3 +
>  drivers/media/usb/cx231xx/cx231xx-core.c           |   2 +
>  drivers/media/usb/pvrusb2/pvrusb2-context.c        |   3 +-
>  drivers/media/v4l2-core/v4l2-async.c               |   1 -
>  drivers/mfd/cs42l43-sdw.c                          |  74 ++---
>  drivers/mfd/intel-lpss.c                           |   2 +-
>  drivers/mfd/rk8xx-core.c                           |  34 +--
>  drivers/mfd/syscon.c                               |   4 +
>  drivers/mfd/tps6594-core.c                         |   3 +
>  drivers/mmc/host/Kconfig                           |  10 +-
>  drivers/mtd/mtd_blkdevs.c                          |   4 +-
>  drivers/mtd/nand/raw/fsl_ifc_nand.c                |   2 +-
>  drivers/net/amt.c                                  |   6 +-
>  drivers/net/dsa/vitesse-vsc73xx-core.c             |   2 +
>  drivers/net/ethernet/marvell/octeontx2/af/rpm.c    |   7 +-
>  .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c |  26 +-
>  .../ethernet/mellanox/mlxbf_gige/mlxbf_gige_rx.c   |   6 +-
>  .../net/ethernet/mellanox/mlxsw/spectrum_acl_erp.c |   8 +-
>  .../ethernet/mellanox/mlxsw/spectrum_acl_tcam.c    |   6 +-
>  .../net/ethernet/mellanox/mlxsw/spectrum_router.c  |  24 +-
>  drivers/net/ethernet/qualcomm/rmnet/rmnet_config.c |   2 +-
>  drivers/net/ethernet/renesas/ravb_main.c           |   2 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac.h       |   1 +
>  .../net/ethernet/stmicro/stmmac/stmmac_ethtool.c   |  29 +-
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |   1 +
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c           |   5 +-
>  drivers/net/netdevsim/netdev.c                     |   9 +-
>  drivers/net/phy/micrel.c                           |   9 +
>  drivers/net/wireless/ath/ath11k/ahb.c              |   4 +-
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c |   3 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/debugfs.c   |   2 +-
>  .../net/wireless/intel/iwlwifi/mvm/mld-mac80211.c  |   6 +-
>  drivers/net/wireless/intel/iwlwifi/mvm/phy-ctxt.c  |  11 -
>  drivers/net/wireless/intel/iwlwifi/mvm/tx.c        |   2 +-
>  drivers/net/wireless/marvell/libertas/Kconfig      |   2 -
>  drivers/net/wireless/marvell/mwifiex/cfg80211.c    |   2 +
>  drivers/net/wireless/marvell/mwifiex/fw.h          |   1 +
>  drivers/net/wireless/marvell/mwifiex/ioctl.h       |   1 +
>  drivers/net/wireless/marvell/mwifiex/sdio.c        |  21 +-
>  drivers/net/wireless/marvell/mwifiex/sdio.h        |   2 +
>  drivers/net/wireless/marvell/mwifiex/uap_cmd.c     |   8 +
>  drivers/net/wireless/mediatek/mt76/eeprom.c        |   6 +-
>  drivers/net/wireless/mediatek/mt76/mt76.h          |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt7615/sdio.c   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/eeprom.h |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/main.c   |   5 +-
>  drivers/net/wireless/mediatek/mt76/mt7915/mmio.c   |   2 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c    |  11 +-
>  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   |   4 +-
>  .../net/wireless/mediatek/mt76/mt7921/sdio_mac.c   |   3 +-
>  drivers/net/wireless/mediatek/mt76/mt7996/mac.c    |   4 +-
>  drivers/net/wireless/mediatek/mt76/mt7996/mcu.h    |   2 +-
>  drivers/net/wireless/mediatek/mt76/sdio.c          |  18 +-
>  drivers/net/wireless/purelifi/plfxlc/usb.c         |   5 +-
>  drivers/net/wireless/realtek/rtlwifi/pci.c         |  79 +----
>  drivers/net/wireless/realtek/rtlwifi/pci.h         |   5 -
>  .../net/wireless/realtek/rtlwifi/rtl8188ee/phy.c   |  14 +-
>  .../wireless/realtek/rtlwifi/rtl8192c/phy_common.c |  12 +-
>  .../wireless/realtek/rtlwifi/rtl8192c/phy_common.h |   1 -
>  .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.c   |   6 +-
>  .../net/wireless/realtek/rtlwifi/rtl8192ce/phy.h   |   1 -
>  .../net/wireless/realtek/rtlwifi/rtl8192cu/phy.c   |   6 +-
>  .../net/wireless/realtek/rtlwifi/rtl8192de/phy.c   |  15 +-
>  .../net/wireless/realtek/rtlwifi/rtl8192ee/phy.c   |  16 +-
>  .../net/wireless/realtek/rtlwifi/rtl8192se/phy.c   |  15 +-
>  .../net/wireless/realtek/rtlwifi/rtl8821ae/phy.c   |   5 +-
>  drivers/net/wireless/realtek/rtlwifi/wifi.h        |   7 +
>  drivers/net/wireless/realtek/rtw88/mac80211.c      |   4 +-
>  drivers/net/wireless/realtek/rtw88/sdio.c          |  35 ++-
>  drivers/net/xen-netback/netback.c                  |  44 ++-
>  drivers/nvme/target/tcp.c                          |  20 +-
>  drivers/nvme/target/trace.h                        |   5 +-
>  drivers/of/base.c                                  |   1 +
>  drivers/of/unittest-data/tests-phandle.dtsi        |  10 +-
>  drivers/of/unittest.c                              |  74 +++--
>  drivers/pci/controller/dwc/pci-keystone.c          |   9 +
>  drivers/pci/controller/dwc/pcie-designware-ep.c    |   1 +
>  drivers/pci/controller/pcie-mediatek-gen3.c        |  85 +++---
>  drivers/pci/controller/pcie-mediatek.c             |  10 +-
>  drivers/pci/endpoint/functions/pci-epf-mhi.c       |  66 ++--
>  drivers/perf/arm-cmn.c                             |   2 +-
>  drivers/perf/hisilicon/hisi_uncore_uc_pmu.c        |   4 +-
>  drivers/platform/x86/intel/vsec.c                  |  25 +-
>  drivers/platform/x86/intel/vsec.h                  |   1 +
>  drivers/power/supply/bq256xx_charger.c             |   5 +-
>  drivers/power/supply/cw2015_battery.c              |   2 +-
>  drivers/power/supply/qcom_pmi8998_charger.c        |   4 +
>  drivers/pwm/core.c                                 |   2 +-
>  drivers/pwm/pwm-jz4740.c                           |   7 +-
>  drivers/pwm/pwm-stm32.c                            |  31 +-
>  drivers/scsi/bfa/bfad_bsg.c                        |   2 +-
>  drivers/scsi/fnic/fnic_debugfs.c                   |   3 +-
>  drivers/scsi/hisi_sas/hisi_sas_main.c              |  11 +-
>  drivers/scsi/hisi_sas/hisi_sas_v3_hw.c             |   9 +-
>  drivers/scsi/mpi3mr/mpi3mr_app.c                   |  16 +
>  drivers/scsi/mpi3mr/mpi3mr_os.c                    |  19 +-
>  drivers/soc/qcom/llcc-qcom.c                       |  10 +-
>  drivers/spi/Kconfig                                |   3 +-
>  drivers/spi/spi-cadence-quadspi.c                  |   4 +-
>  drivers/spi/spi-coldfire-qspi.c                    |   1 -
>  drivers/spi/spi-sh-msiof.c                         |  17 ++
>  drivers/spmi/spmi-mtk-pmif.c                       |  20 +-
>  drivers/staging/media/rkvdec/rkvdec.c              |   3 +
>  drivers/target/target_core_file.c                  |  10 +-
>  drivers/thermal/loongson2_thermal.c                |   2 +-
>  drivers/thermal/thermal_core.c                     |   1 -
>  drivers/tty/serial/8250/8250_bcm2835aux.c          |   2 +
>  drivers/tty/serial/8250/8250_exar.c                |   5 +-
>  drivers/tty/serial/8250/8250_omap.c                |   2 +-
>  drivers/tty/serial/apbuart.c                       |   2 +-
>  drivers/tty/serial/imx.c                           |  36 +--
>  drivers/tty/serial/omap-serial.c                   |  27 +-
>  drivers/tty/serial/sc16is7xx.c                     |   8 +-
>  drivers/tty/serial/serial_core.c                   |  33 +-
>  drivers/tty/tty_io.c                               |  31 +-
>  drivers/ufs/core/ufshcd.c                          |   7 +-
>  drivers/ufs/host/ufs-qcom.c                        |   4 +-
>  drivers/usb/cdns3/cdns3-gadget.c                   | 142 ++++++---
>  drivers/usb/cdns3/cdns3-gadget.h                   |   3 +
>  drivers/usb/chipidea/core.c                        |   7 +
>  drivers/usb/class/cdc-acm.c                        |   3 +
>  drivers/usb/dwc3/core.c                            |  39 +--
>  drivers/usb/dwc3/ep0.c                             |   5 +-
>  drivers/usb/dwc3/gadget.c                          |  19 +-
>  drivers/usb/gadget/function/f_uvc.c                |  63 ++--
>  drivers/usb/gadget/function/u_uvc.h                |   6 +
>  drivers/usb/gadget/legacy/webcam.c                 | 333 +++++++++++++++=
+-----
>  drivers/usb/host/xhci-mtk.c                        |  40 ++-
>  drivers/usb/host/xhci-mtk.h                        |   2 +
>  drivers/usb/mon/mon_bin.c                          |   7 +-
>  drivers/usb/phy/phy-mxs-usb.c                      |   3 +-
>  drivers/usb/typec/class.c                          |   4 +-
>  drivers/vdpa/alibaba/eni_vdpa.c                    |   6 +-
>  drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c     |   7 +-
>  drivers/vfio/pci/pds/dirty.c                       |   6 +-
>  drivers/vhost/vsock.c                              |   1 +
>  drivers/video/fbdev/acornfb.c                      |   2 +-
>  drivers/video/fbdev/core/fb_defio.c                |   8 +-
>  drivers/video/fbdev/imxfb.c                        |  27 +-
>  drivers/watchdog/bcm2835_wdt.c                     |   3 +-
>  drivers/watchdog/hpwdt.c                           |   2 +-
>  drivers/watchdog/rti_wdt.c                         |  13 +-
>  drivers/watchdog/watchdog_dev.c                    |   3 +-
>  fs/ceph/Kconfig                                    |   1 +
>  fs/dlm/debug_fs.c                                  |   2 +-
>  fs/efivarfs/super.c                                |  15 +
>  fs/erofs/compress.h                                |   6 +
>  fs/erofs/decompressor.c                            |  62 +++-
>  fs/erofs/decompressor_deflate.c                    |   5 +-
>  fs/erofs/decompressor_lzma.c                       |   4 +-
>  fs/erofs/internal.h                                |  38 +--
>  fs/erofs/super.c                                   |  72 +----
>  fs/erofs/zdata.c                                   |   5 +-
>  fs/erofs/zmap.c                                    |  23 +-
>  fs/f2fs/data.c                                     |   7 +-
>  fs/f2fs/file.c                                     |   7 +-
>  fs/f2fs/namei.c                                    |   2 +-
>  fs/f2fs/node.c                                     |   6 +-
>  fs/f2fs/xattr.c                                    |  11 +-
>  fs/gfs2/quota.c                                    |   3 +-
>  fs/gfs2/rgrp.c                                     |   2 +-
>  fs/namespace.c                                     |  11 +
>  fs/nfs/blocklayout/blocklayout.c                   |   7 +-
>  fs/nfs/dir.c                                       |   2 +-
>  fs/nfs/direct.c                                    |   5 +-
>  fs/nfs/internal.h                                  |   2 +-
>  fs/nfs/nfs4proc.c                                  |   3 +
>  fs/nfs/pnfs.c                                      |   3 +-
>  fs/pstore/ram_core.c                               |   2 +-
>  fs/smb/server/asn1.c                               |   5 +
>  fs/smb/server/connection.c                         |   6 -
>  fs/smb/server/connection.h                         |   2 +-
>  fs/smb/server/oplock.c                             |   6 +
>  fs/smb/server/smb2pdu.c                            |  22 +-
>  fs/smb/server/smb_common.c                         |   6 +-
>  fs/smb/server/transport_rdma.c                     |  11 +-
>  fs/smb/server/transport_tcp.c                      |  13 +-
>  include/asm-generic/cmpxchg-local.h                |   2 +-
>  include/crypto/if_alg.h                            |   3 +
>  include/drm/display/drm_dp_mst_helper.h            |   2 +-
>  include/drm/drm_bridge.h                           |   2 +-
>  include/dt-bindings/clock/qcom,videocc-sm8150.h    |   4 +
>  include/linux/bio.h                                |   9 +-
>  include/linux/bpf.h                                |  13 +-
>  include/linux/bpf_mem_alloc.h                      |   1 +
>  include/linux/clk-provider.h                       |   4 +-
>  include/linux/gpio/driver.h                        |   6 +
>  include/linux/hisi_acc_qm.h                        |  20 +-
>  include/linux/iio/adc/adi-axi-adc.h                |   4 +
>  include/linux/mhi_ep.h                             |  19 +-
>  include/linux/netfilter_bridge.h                   |   6 +-
>  include/linux/pci.h                                |  12 +-
>  include/linux/rcupdate.h                           |   6 +
>  include/linux/skbuff.h                             |   2 +-
>  include/linux/srcu.h                               |   2 +-
>  include/linux/virtio_net.h                         |   9 +-
>  include/linux/virtio_vsock.h                       |   1 +
>  include/net/af_vsock.h                             |   2 +-
>  include/net/bluetooth/hci_core.h                   |   1 -
>  include/net/netdev_queues.h                        |   2 +-
>  include/uapi/linux/bpf.h                           |   3 +
>  init/do_mounts.c                                   |   9 +-
>  io_uring/io_uring.c                                |  22 +-
>  io_uring/rw.c                                      |  10 +-
>  kernel/bpf/arraymap.c                              |  12 +-
>  kernel/bpf/hashtab.c                               |   6 +-
>  kernel/bpf/lpm_trie.c                              |   3 +
>  kernel/bpf/map_in_map.c                            |  13 +-
>  kernel/bpf/map_in_map.h                            |   2 +-
>  kernel/bpf/memalloc.c                              |  94 +-----
>  kernel/bpf/stackmap.c                              |  11 +-
>  kernel/bpf/syscall.c                               |  47 ++-
>  kernel/bpf/verifier.c                              |  96 +++---
>  kernel/debug/kdb/kdb_main.c                        |   2 -
>  kernel/dma/coherent.c                              |   4 +-
>  kernel/sched/fair.c                                |  20 +-
>  kernel/time/tick-sched.c                           |   5 +
>  kernel/trace/bpf_trace.c                           |   7 +
>  lib/kunit/debugfs.c                                |   4 +-
>  net/bluetooth/hci_conn.c                           |   8 +-
>  net/bluetooth/hci_debugfs.c                        |  12 +-
>  net/bluetooth/hci_event.c                          |  11 +-
>  net/bridge/br_netfilter_hooks.c                    |  42 ++-
>  net/bridge/br_netfilter_ipv6.c                     |  14 +-
>  net/core/rtnetlink.c                               |  14 +-
>  net/dns_resolver/dns_key.c                         |   2 +-
>  net/ethtool/features.c                             |   9 +-
>  net/ipv4/af_inet.c                                 |   1 +
>  net/ipv4/ipmr.c                                    |  13 +-
>  net/ipv4/netfilter/nf_reject_ipv4.c                |   9 +-
>  net/ipv4/udp.c                                     |  34 +--
>  net/ipv6/ip6_tunnel.c                              |  26 +-
>  net/ipv6/mcast.c                                   |   4 +
>  net/ipv6/netfilter/nf_reject_ipv6.c                |  11 +-
>  net/ipv6/udp.c                                     |  16 +-
>  net/mptcp/options.c                                |   6 +-
>  net/mptcp/subflow.c                                |  17 +-
>  net/ncsi/internal.h                                |   7 +-
>  net/ncsi/ncsi-netlink.c                            |   4 +-
>  net/ncsi/ncsi-pkt.h                                |   7 +-
>  net/ncsi/ncsi-rsp.c                                |  26 +-
>  net/netfilter/ipset/ip_set_hash_netiface.c         |   8 +-
>  net/netfilter/ipvs/ip_vs_xmit.c                    |   4 +-
>  net/netfilter/nf_log_syslog.c                      |  13 +-
>  net/netfilter/nf_queue.c                           |   6 +-
>  net/netfilter/nf_tables_api.c                      |  38 ++-
>  net/netfilter/nfnetlink_log.c                      |   8 +-
>  net/netfilter/nft_limit.c                          |  19 +-
>  net/netfilter/xt_physdev.c                         |   2 +-
>  net/netlabel/netlabel_calipso.c                    |  49 +--
>  net/rxrpc/ar-internal.h                            |   1 +
>  net/rxrpc/call_object.c                            |   4 +-
>  net/rxrpc/local_object.c                           |  13 +-
>  net/rxrpc/output.c                                 |   6 +-
>  net/rxrpc/rxkad.c                                  |   2 +
>  net/sched/act_ct.c                                 |  12 +-
>  net/sctp/socket.c                                  |  13 +-
>  net/sunrpc/xprtmultipath.c                         |   2 +-
>  net/tls/tls_sw.c                                   |   6 +-
>  net/unix/unix_bpf.c                                |  21 +-
>  net/vmw_vsock/af_vsock.c                           |   9 +-
>  net/vmw_vsock/hyperv_transport.c                   |   4 +-
>  net/vmw_vsock/virtio_transport.c                   |   1 +
>  net/vmw_vsock/virtio_transport_common.c            |  43 ++-
>  net/vmw_vsock/vsock_loopback.c                     |   1 +
>  net/wireless/scan.c                                |  47 ++-
>  rust/bindgen_parameters                            |   4 +
>  security/apparmor/lib.c                            |   1 +
>  security/apparmor/lsm.c                            |   1 -
>  security/apparmor/policy_unpack.c                  |  11 +-
>  security/keys/encrypted-keys/encrypted.c           |   4 +
>  security/selinux/hooks.c                           |   7 +
>  sound/pci/hda/patch_hdmi.c                         |   6 +
>  sound/pci/hda/patch_realtek.c                      |   3 +
>  sound/pci/oxygen/oxygen_mixer.c                    |   2 +-
>  sound/soc/amd/vangogh/acp5x-mach.c                 |  35 +--
>  sound/soc/codecs/cs35l33.c                         |   4 +-
>  sound/soc/codecs/rt5645.c                          |   8 -
>  sound/soc/codecs/tas2781-fmwlib.c                  |   1 +
>  .../soc/intel/boards/sof_sdw_rt_sdca_jack_common.c |   1 +
>  sound/soc/intel/common/soc-acpi-intel-glk-match.c  |  14 +-
>  sound/soc/mediatek/common/mtk-dsp-sof-common.c     |   2 +-
>  sound/soc/sof/ipc4-loader.c                        |  11 +-
>  sound/soc/sof/topology.c                           |   2 +-
>  sound/usb/mixer_scarlett_gen2.c                    | 223 +++++++++-----
>  tools/include/uapi/linux/bpf.h                     |   3 +
>  tools/lib/api/io.h                                 |   1 +
>  tools/perf/builtin-stat.c                          |  18 +-
>  .../arch/arm64/ampere/ampereone/core-imp-def.json  |   2 +-
>  .../attr/test-record-user-regs-no-sve-aarch64      |   2 +-
>  .../tests/attr/test-record-user-regs-sve-aarch64   |   2 +-
>  tools/perf/tests/workloads/thloop.c                |   4 +-
>  tools/perf/util/bpf-event.c                        |   8 +-
>  tools/perf/util/bpf-event.h                        |  12 +-
>  tools/perf/util/db-export.c                        |   4 +-
>  tools/perf/util/env.c                              |  50 ++--
>  tools/perf/util/env.h                              |   4 +
>  tools/perf/util/genelf.c                           |   6 +-
>  tools/perf/util/header.c                           |  17 +-
>  tools/perf/util/hisi-ptt.c                         |   1 +
>  tools/perf/util/mem-events.c                       |  25 +-
>  tools/perf/util/stat-shadow.c                      |   2 +-
>  tools/perf/util/unwind-libdw.c                     |  21 +-
>  tools/perf/util/unwind-libunwind-local.c           |   2 +-
>  tools/testing/selftests/alsa/conf.c                |   2 +-
>  tools/testing/selftests/alsa/mixer-test.c          |   4 +-
>  tools/testing/selftests/bpf/prog_tests/bpf_iter.c  |   2 +
>  tools/testing/selftests/bpf/prog_tests/time_tai.c  |   2 +-
>  .../selftests/bpf/progs/bpf_iter_task_stack.c      |   5 +
>  .../selftests/bpf/progs/test_global_func16.c       |   2 +-
>  .../selftests/bpf/progs/verifier_basic_stack.c     |   8 +-
>  .../testing/selftests/bpf/progs/verifier_int_ptr.c |   5 +-
>  .../selftests/bpf/progs/verifier_raw_stack.c       |   5 +-
>  .../testing/selftests/bpf/progs/verifier_var_off.c |  62 +++-
>  .../selftests/bpf/progs/xdp_synproxy_kern.c        |   4 +-
>  .../selftests/bpf/verifier/atomic_cmpxchg.c        |  11 -
>  tools/testing/selftests/bpf/verifier/calls.c       |   4 +-
>  .../drivers/net/bonding/mode-1-recovery-updelay.sh |   2 +-
>  .../drivers/net/bonding/mode-2-recovery-updelay.sh |   2 +-
>  .../testing/selftests/drivers/net/mlxsw/qos_pfc.sh |  18 +-
>  .../drivers/net/mlxsw/spectrum-2/tc_flower.sh      | 106 ++++++-
>  .../selftests/net/arp_ndisc_untracked_subnets.sh   |   2 +-
>  .../selftests/net/fib_nexthop_multiprefix.sh       |   4 +-
>  tools/testing/selftests/powerpc/math/fpu_preempt.c |   9 +-
>  tools/testing/selftests/powerpc/math/vmx_preempt.c |  10 +-
>  tools/testing/selftests/sgx/Makefile               |   2 +-
>  tools/testing/selftests/sgx/load.c                 |   9 +-
>  tools/testing/selftests/sgx/sigstruct.c            |   5 +-
>  tools/testing/selftests/sgx/test_encl.c            |   8 +-
>  581 files changed, 5299 insertions(+), 3273 deletions(-)
>
>
>

