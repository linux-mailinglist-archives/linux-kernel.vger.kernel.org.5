Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906C478A288
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjH0WOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjH0WOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:14:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB029B6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:14:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9a2185bd83cso330214266b.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693174474; x=1693779274;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p5WeGQP9vWv5ipyudRo0eucpTv7DnpMxrFZTxTm/ed8=;
        b=Vg+8/TCOyWDl8UIb4Dhn4MjewISybuRfIaXRlHNXRJrIM+959hJ9avXS9RdVWsv4KT
         ILit0cgOczD3n6nd6gufH3i/R9SPUk7nWIbRdmq0QdoH/wSH/Qxjo29xNsH1QsCP6MIM
         9M3y0SvA5cXYWPe7f9D1ydYBh+CPj7vLaWrOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693174474; x=1693779274;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p5WeGQP9vWv5ipyudRo0eucpTv7DnpMxrFZTxTm/ed8=;
        b=kkNnu/A19QT5pJG37wapE1PwRyhxKC5TPSesuBx4ZYT+DTwoHUagsNPrTZx0wdEpMd
         Riz90XpQ9ru3J41LkvDBP4CIZuUjQc/OzNULLA6+x4R4Vio0aZZWbMPvp77C9e8br3Tw
         ebmD1s9A+v0wC88WdlxRPbAZP552/DCHr0/uWrI4LUlbzgZEBlIb4FTMwpkw2OFv/NOb
         oNRXmYDhRmEtQwYNi1oPs+nRsACqXtAgqvoLP5pUBNA80n5rqAIZf12RtQ6jXmdqTs3W
         y+qSoWyBfXtn5CBB6gNvUcDXaGt74p4j9fcFpbJF0VNKaD5S0NCOWLCGaeZM7WCFHQDp
         0XXA==
X-Gm-Message-State: AOJu0YwvLqoSmePiuU57bauoFDREATXuHDjX19zVX3eI2zB+N3fpRKLA
        MT3b1apvb169fAmgGXXwNZ/NDGcGvXeJo0coDrIQXg==
X-Google-Smtp-Source: AGHT+IG8X22koHgiOZvYt3150bbWju0tTix6E96APJBzd3CtyxJrAs8QWGMwtXDQOf1g19yuytvhOA==
X-Received: by 2002:a17:906:8448:b0:9a2:23cd:f05a with SMTP id e8-20020a170906844800b009a223cdf05amr7355289ejy.76.1693174473890;
        Sun, 27 Aug 2023 15:14:33 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id qo8-20020a170907212800b0099cd008c1a4sm3898018ejb.136.2023.08.27.15.14.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 15:14:33 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9a2185bd83cso330213366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 15:14:33 -0700 (PDT)
X-Received: by 2002:a17:906:2181:b0:99d:f93e:7206 with SMTP id
 1-20020a170906218100b0099df93e7206mr16582726eju.26.1693174472936; Sun, 27 Aug
 2023 15:14:32 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Aug 2023 15:14:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmKhCrdrOCjp=5v9NO6C=PJ8ZTZcCXj09piHzsZ7qqmw@mail.gmail.com>
Message-ID: <CAHk-=wgmKhCrdrOCjp=5v9NO6C=PJ8ZTZcCXj09piHzsZ7qqmw@mail.gmail.com>
Subject: Linux 6.5
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

So nothing particularly odd or scary happened this last week, so there
is no excuse to delay the 6.5 release.

I still have this nagging feeling that a lot of people are on vacation
and that things have been quiet partly due to that. But this release
has been going smoothly, so that's probably just me being paranoid.
The biggest patches this last week were literally just to our
selftests.

The shortlog below is obviously not the 6.5 release log, it's purely
just the last week since rc7.

Anyway, this obviously means that the merge window for 6.6 starts
tomorrow. I already have ~20 pull requests pending and ready to go,
but before we start the next merge frenzy, please give this final
release one last round of testing, ok?

                  Linus

---

Alessio Igor Bogani (1):
      igb: Avoid starting unnecessary workqueues

Alexandre Ghiti (1):
      mm: add a call to flush_cache_vmap() in vmap_pfn()

Amit Cohen (1):
      mlxsw: Fix the size of 'VIRT_ROUTER_MSB'

Andre Przywara (2):
      selftests: cachestat: test for cachestat availability
      selftests: cachestat: catch failing fsync test on tmpfs

Andrey Skvortsov (1):
      clk: Fix slab-out-of-bounds error in devm_clk_release()

Andrii Staikov (1):
      i40e: fix potential NULL pointer dereferencing of pf->vf
i40e_sync_vsi_filters()

Andr=C3=A9 Apitzsch (1):
      platform/x86: ideapad-laptop: Add support for new hotkeys found
on ThinkBook 14s Yoga ITL

Andy Chiu (1):
      RISC-V: vector: export VLENB csr in __sc_riscv_v_state

Anh Tuan Phan (1):
      selftests/net: Add log.txt and tools to .gitignore

Ankit Nautiyal (1):
      drm/display/dp: Fix the DP DSC Receiver cap size

Anshuman Gupta (1):
      drm/i915/dgfx: Enable d3cold at s2idle

Arnd Bergmann (1):
      radix tree: remove unused variable

Ar=C4=B1n=C3=A7 =C3=9CNAL (1):
      net: dsa: mt7530: fix handling of 802.1X PAE frames

Ayush Jain (1):
      selftests/mm: FOLL_LONGTERM need to be updated to 0x100

Bao D. Nguyen (1):
      scsi: ufs: mcq: Fix the search/wrap around logic

Bartosz Golaszewski (2):
      gpio: sim: dispose of irq mappings before destroying the irq_sim doma=
in
      gpio: sim: pass the GPIO device's software node to irq domain

Benjamin Coddington (3):
      NFSv4: Fix dropped lock for racing OPEN and delegation return
      nfsd: Fix race to FREE_STATEID and cl_revoked
      NFS: Fix sysfs server name memory leak

Biju Das (4):
      clk: Fix undefined reference to `clk_rate_exclusive_{get,put}'
      pinctrl: renesas: rzg2l: Fix NULL pointer dereference in
rzg2l_dt_subnode_to_map()
      pinctrl: renesas: rzv2m: Fix NULL pointer dereference in
rzv2m_dt_subnode_to_map()
      pinctrl: renesas: rza2: Add lock around
pinctrl_generic{{add,remove}_group,{add,remove}_function}

BrenoRCBrito (1):
      ASoC: amd: yc: Add VivoBook Pro 15 to quirks list for acp6x

Chao Song (1):
      ASoC: SOF: ipc4-pcm: fix possible null pointer deference

Charles Keepax (1):
      ASoC: cs35l41: Correct amp_gain_tlv values

Christian G=C3=B6ttsche (1):
      selinux: set next pointer before attaching to list

Chuck Lever (2):
      xprtrdma: Remap Receive buffers after a reconnect
      NFSD: Fix a thinko introduced by recent trace point changes

Daniel Golle (1):
      net: ethernet: mtk_eth_soc: fix NULL pointer on hw reset

Danielle Ratson (1):
      mlxsw: pci: Set time stamp fields also when its type is MIRROR_UTC

David Hildenbrand (3):
      mm/gup: reintroduce FOLL_NUMA as FOLL_HONOR_NUMA_FAULT
      smaps: use vm_normal_page_pmd() instead of follow_trans_huge_pmd()
      mm/gup: handle cont-PTE hugetlb pages correctly in
gup_must_unshare() via GUP-fast

David Michael (1):
      drm/panfrost: Skip speed binning on EOPNOTSUPP

Edward Cree (1):
      sfc: allocate a big enough SKB for loopback selftest packet

Eric Dumazet (3):
      sock: annotate data-races around prot->memory_pressure
      dccp: annotate data-races in dccp_poll()
      ipv4: fix data-races around inet->inet_id

Fedor Pchelkin (2):
      NFSv4.2: fix error handling in nfs42_proc_getxattr
      NFSv4: fix out path in __nfs4_get_acl_uncached

Feng Tang (1):
      x86/fpu: Set X86_FEATURE_OSXSAVE feature after enabling OSXSAVE in CR=
4

Florian Westphal (3):
      netfilter: nf_tables: validate all pending tables
      netfilter: nf_tables: fix out of memory error handling
      netfilter: nf_tables: defer gc run if previous batch is still pending

Francesco Dolcini (1):
      clk: keystone: syscon-clk: Fix audio refclk

Frieder Schrempf (1):
      drm: bridge: samsung-dsim: Fix init during host transfer

GONG, Ruiqi (1):
      samples: ftrace: Replace bti assembly with hint for older compiler

Hangbin Liu (4):
      selftests: bonding: do not set port down before adding to bond
      bonding: fix macvlan over alb bond support
      selftest: bond: add new topo bond_topo_2d1c.sh
      selftests: bonding: add macvlan over bond testing

Hans de Goede (1):
      ACPI: resource: Fix IRQ override quirk for PCSpecialist Elimina Pro 1=
6 M

Hariprasad Kelam (1):
      octeontx2-af: SDP: fix receive link config

Helge Deller (1):
      lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels

Herbert Xu (1):
      Revert "crypto: caam - adjust RNG timing to support more devices"

Huacai Chen (2):
      LoongArch: Ensure FP/SIMD registers in the core dump file is up to da=
te
      LoongArch: Fix hw_breakpoint_control() for watchpoints

Hugh Dickins (1):
      shmem: fix smaps BUG sleeping while atomic

Ido Schimmel (3):
      mlxsw: reg: Fix SSPR register layout
      selftests: mlxsw: Fix test failure on Spectrum-4
      rtnetlink: Reject negative ifindexes in RTM_NEWLINK

Imre Deak (2):
      drm: Add an HPD poll helper to reschedule the poll work
      drm/i915: Fix HPD polling, reenabling the output poll work as needed

Jakub Kicinski (1):
      net: validate veth and vxcan peer ifindexes

Jamal Hadi Salim (1):
      net/sched: fix a qdisc modification with ambiguous command request

Jani Nikula (1):
      drm/i915: fix Sphinx indentation warning

Jesse Brandeburg (1):
      ice: fix receive buffer size miscalculation

Jiri Pirko (1):
      devlink: add missing unregister linecard notification

Johan Hovold (1):
      genirq: Fix software resend lockup and nested resend

Josua Mayer (1):
      net: sfp: handle 100G/25G active optical cables in sfp_parse_support

Kees Cook (1):
      tg3: Use slab_build_skb() when needed

Kevin-Lu (1):
      MAINTAINERS: Add entries for TEXAS INSTRUMENTS ASoC DRIVERS

Leonard G=C3=B6hrs (1):
      spi: stm32: fix accidential revert to byte-sized transfer splitting

Liam R. Howlett (1):
      maple_tree: disable mas_wr_append() when other readers are possible

Linus Torvalds (2):
      mm: avoid 'might_sleep()' in get_mmap_lock_carefully()
      Linux 6.5

Lu Wei (1):
      ipvlan: Fix a reference count leak warning in ipvlan_ns_exit()

Lucas Karpinski (1):
      selftests: cgroup: fix test_kmem_basic less than error

Maciej Strozek (1):
      ASoC: cs35l56: Read firmware uuid from a device property instead of _=
SUB

Marek Beh=C3=BAn (1):
      leds: trigger: netdev: rename 'hw_control' sysfs entry to 'offloaded'

Mario Limonciello (2):
      pinctrl: amd: Mask wake bits on probe again
      ASoC: amd: yc: Fix a non-functional mic on Lenovo 82SJ

Masahiro Yamada (3):
      LoongArch: Remove unneeded #include <asm/export.h>
      LoongArch: Replace #include <asm/export.h> with #include <linux/expor=
t.h>
      LoongArch: Remove <asm/export.h>

Miaohe Lin (1):
      mm: memory-failure: fix unexpected return value in soft_offline_page(=
)

Michael Ellerman (1):
      ibmveth: Use dcbf rather than dcbfl

Mingzheng Xing (1):
      riscv: Fix build errors using binutils2.37 toolchains

Neil Armstrong (1):
      scsi: ufs: ufs-qcom: Clear qunipro_g4_sel for HW major version > 5

Oliver Hartkopp (2):
      can: isotp: fix support for transmission of SF without flow control
      can: raw: add missing refcount for memory leak fix

Pablo Neira Ayuso (3):
      netfilter: nf_tables: flush pending destroy work before netlink notif=
ier
      netfilter: nf_tables: GC transaction race with abort path
      netfilter: nf_tables: use correct lock to protect gc_list

Palmer Dabbelt (1):
      RISC-V: Remove ptrace support for vectors

Pavel Skripkin (1):
      crypto: fix uninit-value in af_alg_free_resources

Peng Fan (1):
      of/platform: increase refcount of fwnode

Petr Oros (2):
      Revert "ice: Fix ice VF reset during iavf initialization"
      ice: Fix NULL pointer deref during VF reset

Ping-Ke Shih (1):
      wifi: mac80211: limit reorder_buf_filtered to avoid UBSAN warning

Randy Dunlap (1):
      wifi: iwlwifi: mvm: add dependency for PTP clock

Remi Pommarel (3):
      batman-adv: Do not get eth header before batadv_check_management_pack=
et
      batman-adv: Fix TT global entry leak when client roamed back
      batman-adv: Fix batadv_v_ogm_aggr_send memory leak

Rick Edgecombe (1):
      x86/fpu: Invalidate FPU state correctly on exec()

Rik van Riel (1):
      mm,ima,kexec,of: use memblock_free_late from ima_free_kexec_buffer

Rob Clark (1):
      dma-buf/sw_sync: Avoid recursive lock during fence signal

Rob Herring (2):
      of: unittest: Fix EXPECT for parse_phandle_with_args_map() test
      of: dynamic: Refactor action prints to not use "%pOF" inside devtree_=
lock

Ruan Jinjie (2):
      net: bgmac: Fix return value check for fixed_phy_register()
      net: bcmgenet: Fix return value check for fixed_phy_register()

Ryusuke Konishi (1):
      nilfs2: fix general protection fault in nilfs_lookup_dirty_data_buffe=
rs()

Sabrina Dubroca (1):
      MAINTAINERS: add entry for macsec

Sasha Neftin (1):
      igc: Fix the typo in the PTM Control macro

Serge Semin (2):
      net: mdio: mdio-bitbang: Fix C45 read/write protocol
      net: phy: Fix deadlocking in phy_error() invocation

Shenghao Ding (1):
      ASoC: tas2781: fixed register access error when switching to other ch=
ips

Shih-Yi Chen (1):
      platform/mellanox: Fix mlxbf-tmfifo not handling all virtio
CONSOLE notifications

Simon Trimmer (1):
      ASoC: cs35l56: Add an ACPI match table

Srinivas Goud (1):
      spi: spi-cadence: Fix data corruption issues in slave mode

Suren Baghdasaryan (1):
      mm: enable page walking API to lock vmas during the walk

Sven Eckelmann (3):
      batman-adv: Trigger events for auto adjusted MTU
      batman-adv: Don't increase MTU when set by user
      batman-adv: Hold rtnl lock during MTU update via netlink

Sven Schnelle (3):
      tracing/synthetic: Use union instead of casts
      tracing/synthetic: Skip first entry for stack traces
      tracing/synthetic: Allocate one additional element for size

Swapnil Devesh (1):
      platform/x86: lenovo-ymc: Add Lenovo Yoga 7 14ACN6 to
ec_trigger_quirk_dmi_table

T.J. Mercier (1):
      mm: multi-gen LRU: don't spin during memcg release

Takashi Iwai (1):
      ALSA: ymfpci: Fix the missing snd_card_free() call at probe error

Thinh Tran (1):
      bnx2x: new flag for track HW resource allocation

Tiezhu Yang (4):
      LoongArch: Do not kill the task in die() if notify_die() returns
NOTIFY_STOP
      LoongArch: Return earlier in die() if notify_die() returns NOTIFY_STO=
P
      LoongArch: Add identifier names to arguments of die() declaration
      LoongArch: Put the body of play_dead() into arch_cpu_idle_dead()

Trond Myklebust (1):
      NFS: Fix a use after free in nfs_direct_join_group()

Vladimir Oltean (1):
      net: dsa: felix: fix oversize frame dropping for always closed
tc-taprio gates

WANG Xuerui (1):
      LoongArch: Replace -ffreestanding with finer-grained -fno-builtin's

Wei Chen (1):
      media: vcodec: Fix potential array out-of-bounds in encoder queue_set=
up

Xi Ruoyao (1):
      LoongArch: Remove redundant "source drivers/firmware/Kconfig"

Yin Fengwei (3):
      madvise:madvise_cold_or_pageout_pte_range(): don't use
mapcount() against large folio for sharing check
      madvise:madvise_free_huge_pmd(): don't use mapcount() against
large folio for sharing check
      madvise:madvise_free_pte_range(): don't use mapcount() against
large folio for sharing check

Zack Rusin (2):
      drm/vmwgfx: Fix shader stage validation
      drm/vmwgfx: Fix possible invalid drm gem put calls

Zheng Yejian (4):
      tracing: Fix cpu buffers unavailable due to 'record_disabled' missed
      selftests/ftrace: Add a basic testcase for snapshot
      tracing: Fix memleak due to race between current_tracer and trace
      tracing: Introduce pipe_cpumask to avoid race on trace_pipes

Zhu Wang (2):
      scsi: core: raid_class: Remove raid_component_add()
      scsi: snic: Fix double free in snic_tgt_create()
