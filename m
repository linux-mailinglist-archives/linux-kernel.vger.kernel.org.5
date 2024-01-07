Return-Path: <linux-kernel+bounces-18979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5214E8265F0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D201C20B02
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EC11170B;
	Sun,  7 Jan 2024 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X9HvRGWb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9572411703
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-555aa7fd668so1236638a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 12:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704659368; x=1705264168; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6UWNLfIVq0UDaPWXQWtKgMdS6U6B0bFjFoK1/r+DVCg=;
        b=X9HvRGWbD+kKiXxbKj7qUUIBEX2bk4fMSqVwVqhF/K+T0b1Jk574gmPFRUKnCkaL85
         n1hSlqluRc/4c9YViB9X3Xj9voQoIKWkKdq8cZRadti9Mzt/u2kLI7uqDb2oZNVENt6z
         Kj4wc6T1nahk7aL/jmQCGQMUUzQCiLsATK5p8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704659368; x=1705264168;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UWNLfIVq0UDaPWXQWtKgMdS6U6B0bFjFoK1/r+DVCg=;
        b=XVasl6AQV8WLq8eaV0jVCURB7z4rCbVfOu9+CP2QVPtrE4rkW9oAKMcD9Ex+CW6V7u
         36UHf37MZ3cXMiWrRRtxP1KHTsDUlxryXyZQ9k9v0qrsXErRZsACOhAgnrUvMB0f3ssA
         XCr28L5Hzcjo8593c+wD0gXyb9Y4CZAGguiBbUbw+mJuxkL5qNjp/RG8kDw9pzO/psld
         /qV0JyLcQEUdNBmQNoZWd0Sjh99i0Q7zXuRSYNN5PjV8hS7w7V0Y0eLC/wDTJzrxmTZv
         nfeZNZHeFoQWjpMvto9LhCDMY3PN+BjJMhFZTE0fFFWNNZCQdiJGoxvnpo7p/MYWvVih
         1k9A==
X-Gm-Message-State: AOJu0YwYNM5PLtZ1scLuqSQC/fNd/87n5NRNW1FHJ7OJzEITSVTFcN3o
	frcw6G8Facov265JqKlCnPxsSNJAqNtYndPoP6bCAwAUkqk6OKRP
X-Google-Smtp-Source: AGHT+IFwwYklrxBJ+bF0ulovTRMpkeoF9ZvN1vVD3LhgZAlRqwoU3aexFhowWgzGRuOkR5uL0OQXmA==
X-Received: by 2002:a50:9986:0:b0:54c:4837:9a99 with SMTP id m6-20020a509986000000b0054c48379a99mr1372922edb.64.1704659368211;
        Sun, 07 Jan 2024 12:29:28 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id u7-20020a50eac7000000b005553a8bb61dsm3515992edp.87.2024.01.07.12.29.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jan 2024 12:29:27 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40e464f99edso4815545e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 12:29:27 -0800 (PST)
X-Received: by 2002:a05:600c:1909:b0:40d:6473:c65e with SMTP id
 j9-20020a05600c190900b0040d6473c65emr1397105wmq.103.1704659367098; Sun, 07
 Jan 2024 12:29:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 7 Jan 2024 12:29:10 -0800
X-Gmail-Original-Message-ID: <CAHk-=widprp4XoHUcsDe7e16YZjLYJWra-dK0hE1MnfPMf6C3Q@mail.gmail.com>
Message-ID: <CAHk-=widprp4XoHUcsDe7e16YZjLYJWra-dK0hE1MnfPMf6C3Q@mail.gmail.com>
Subject: Linux 6.7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

So we had a little bit more going on last week compared to the holiday
week before that, but certainly not enough to make me think we'd want
to delay this any further.

End result: 6.7 is (in number of commits: over 17k non-merge commits,
with 1k+ merges) one of the largest kernel releases we've ever had,
but the extra rc8 week was purely due to timing with the holidays, not
about any difficulties with the larger release.

The main changes this last week were a few DRM updates (mainly fixes
for new hw enablement in this version - both amd and nouveau), some
more bcachefs fixes (and bcachefs is obviously new to 6.7 and one of
the reasons for the large number of commits), and then a few random
driver updates. And a smattering of minor noise elsewhere.

The shortlog is appended - there really isn't much there, you can
scroll through it quickly if you care about the details - and this
obviously means that tomorrow the merge window for 6.8 opens. I
already have two dozen+ early pull requests pending - thank you.

But please do kick the tires of this before the fun of the next
development series starts. Ok?

                 Linus

---

Aabish Malik (1):
      ALSA: hda/realtek: enable SND_PCI_QUIRK for hp pavilion 14-ec1xxx ser=
ies

Adrian Cinal (1):
      net: bcmgenet: Fix FCS generation for fragmented skbuffs

Alex Deucher (2):
      drm/amd/display: add nv12 bounding box
      drm/amdgpu: skip gpu_info fw loading on navi12

Alex Henrie (1):
      Revert "net: ipv6/addrconf: clamp preferred_lft to the minimum requir=
ed"

Alexander Lobakin (1):
      idpf: fix corrupted frames and skb leaks in singleq mode

Andrii Staikov (1):
      i40e: Restore VF MSI-X state during PCI reset

Andy Chi (1):
      ALSA: hda/realtek: fix mute/micmute LEDs for a HP ZBook

Arkadiusz Kubalewski (1):
      ice: dpll: fix phase offset value

Arnd Bergmann (1):
      ALSA: hda: cs35l41: fix building without CONFIG_SPI

Asad Kamal (5):
      drm/amd/pm: Use separate metric table for APU
      drm/amd/pm: Update metric table for jpeg/vcn data
      drm/amd/pm: Add mem_busy_percent for GCv9.4.3 apu
      drm/amd/pm: Add gpu_metrics_v1_5
      drm/amd/pm: Use gpu_metrics_v1_5 for SMUv13.0.6

Attreyee Mukherjee (1):
      Documentation/i2c: fix spelling error in i2c-address-translators

Baolin Wang (1):
      mm: memcg: fix split queue list crash when large folio migration

Benjamin Bara (1):
      i2c: core: Fix atomic xfer check for non-preempt config

Benjamin Berg (2):
      wifi: mac80211: do not re-add debugfs entries during resume
      wifi: mac80211: add/remove driver debugfs entries as appropriate

Bjorn Helgaas (2):
      Revert "PCI/ASPM: Remove pcie_aspm_pm_state_change()"
      MAINTAINERS: Orphan Cadence PCIe IP

Brad Cowie (1):
      netfilter: nf_nat: fix action not being set for all ct states

Chancel Liu (1):
      ASoC: fsl_rpmsg: Fix error handler with pm_runtime_enable

Chen Ni (1):
      asix: Add check for usbnet_get_endpoints

Claudiu Beznea (1):
      net: ravb: Wait for operating mode to be applied

Dave Airlie (9):
      nouveau/gsp: add three notifier callbacks that we see in normal
operation (v2)
      nouveau/gsp: drop some acpi related debug
      nouveau: fix disp disabling with GSP
      nouveau/gsp: free acpi object after use
      nouveau/gsp: free userd allocation.
      nouveau/gsp: convert gsp errors to generic errors
      nouveau/gsp: don't free ctrl messages on errors
      nouveau/gsp: always free the alloc messages on r535
      nouveau: push event block/allowing out of the fence context

David Thompson (1):
      mlxbf_gige: fix receive packet race condition

Dinghao Liu (1):
      net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues

Dmitry Safonov (2):
      net/tcp_sigpool: Use kref_get_unless_zero()
      net/tcp: Only produce AO/MD5 logs if there are any keys

Douglas Anderson (3):
      drm/bridge: parade-ps8640: Never store more than msg->size bytes
in AUX xfer
      drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes
in AUX xfer
      drm/bridge: ps8640: Fix size mismatch warning w/ len

Eugen Hristev (1):
      ASoC: mediatek: mt8186: fix AUD_PAD_TOP register and offset

Geert Uytterhoeven (1):
      mmc: core: Cancel delayed work before releasing host

Geoffrey D. Bennett (1):
      ALSA: scarlett2: Convert meter levels from little-endian

Gergo Koteles (4):
      ALSA: hda/tas2781: do not use regcache
      ALSA: hda/tas2781: fix typos in comment
      ALSA: hda/tas2781: move set_drv_data outside tasdevice_init
      ALSA: hda/tas2781: remove sound controls in unbind

Hangbin Liu (1):
      selftests: bonding: do not set port down when adding to bond

Hangyu Hua (1):
      net: sched: em_text: fix possible memory leak in em_text_destroy()

Jeff Layton (1):
      nfsd: drop the nfsd_put helper

Jeffrey Hugo (1):
      accel/qaic: Implement quirk for SOC_HW_VERSION

Jiajun Xie (1):
      mm: fix unmap_mapping_range high bits shift bug

Jingbo Xu (2):
      mm: fix arithmetic for bdi min_ratio
      mm: fix arithmetic for max_prop_frac when setting max_ratio

Jinghao Jia (1):
      x86/kprobes: fix incorrect return address calculation in
kprobe_emulate_call_indirect

Jocelyn Falempe (1):
      drm/mgag200: Fix gamma lut not initialized for G200ER, G200EV, G200SE

Johannes Berg (1):
      wifi: iwlwifi: pcie: don't synchronize IRQs from IRQ

John Johansen (1):
      apparmor: Fix move_mount mediation by detecting if source is detached

Jorge Ramirez-Ortiz (1):
      mmc: rpmb: fixes pause retune on all RPMB partitions.

Joshua Ashton (1):
      drm/amd/display: Fix sending VSC (+ colorimetry) packets for
DP/eDP displays without PSR

J=C3=B6rn-Thorben Hinz (1):
      net: Implement missing getsockopt(SO_TIMESTAMPING_NEW)

Kai-Heng Feng (1):
      r8169: Fix PCI error on system resume

Katarzyna Wieczerzycka (1):
      ice: Fix link_down_on_close message

Ke Xiao (1):
      i40e: fix use-after-free in i40e_aqc_add_filters()

Kent Overstreet (13):
      bcachefs: Fix extents iteration + snapshots interaction
      bcachefs: fix invalid free in dio write path
      bcachefs: fix setting version_upgrade_complete
      bcachefs: Factor out darray resize slowpath
      bcachefs: Switch darray to kvmalloc()
      bcachefs: DARRAY_PREALLOCATED()
      bcachefs: fix buffer overflow in nocow write path
      bcachefs: move BCH_SB_ERRS() to sb-errors_types.h
      bcachefs: prt_bitflags_vector()
      bcachefs: Add persistent identifiers for recovery passes
      bcachefs: bch_sb.recovery_passes_required
      bcachefs: bch_sb_field_downgrade
      bcachefs: make RO snapshots actually RO

Khaled Almahallawy (1):
      drm/i915/dp: Fix passing the correct DPCD_REV for
drm_dp_set_phy_test_pattern

Kurt Kanzenbach (3):
      igc: Report VLAN EtherType matching back to user
      igc: Check VLAN TCI mask
      igc: Check VLAN EtherType mask

Linus Torvalds (2):
      x86/csum: clean up `csum_partial' further
      Linux 6.7

Lukas Bulwahn (1):
      MAINTAINERS: wifi: brcm80211: remove non-existing
SHA-cyfmac-dev-list@infineon.com

Lyude Paul (2):
      drm/nouveau/gsp: Fix ACPI MXDM/MXDS method invocations
      drm/nouveau/dp: Honor GSP link training retry timeouts

Marc Dionne (1):
      net: Save and restore msg_namelen in sock_sendmsg

Marcin Wojtas (1):
      MAINTAINERS: Update mvpp2 driver email

Mark Brown (4):
      ASoC: meson: g12a-toacodec: Validate written enum values
      ASoC: meson: g12a-tohdmitx: Validate written enum values
      ASoC: meson: g12a-toacodec: Fix event generation
      ASoC: meson: g12a-tohdmitx: Fix event generation for S/PDIF mux

Mathieu Othacehe (1):
      mailmap: add entries for Mathieu Othacehe

Matthieu Baerts (1):
      MAINTAINERS: add Geliang as reviewer for MPTCP

Michael Chan (1):
      bnxt_en: Remove mis-applied code from bnxt_cfg_ntp_filters()

Mike Kravetz (1):
      MAINTAINERS: remove hugetlb maintainer Mike Kravetz

Naoya Horiguchi (1):
      MAINTAINERS: hand over hwpoison maintainership to Miaohe Lin

Naveen Mamindlapalli (2):
      octeontx2-af: Always configure NIX TX link credits based on max frame=
 size
      octeontx2-af: Re-enable MAC TX in otx2_stop processing

Ngai-Mint Kwan (1):
      ice: Shut down VSI with "link-down-on-close" enabled

Noah Goldstein (1):
      x86/csum: Remove unnecessary odd handling

Pablo Neira Ayuso (3):
      netfilter: nf_tables: set transport offset from mac header for
netdev/egress
      netfilter: nf_tables: skip set commit for deleted/destroyed sets
      netfilter: nft_immediate: drop chain reference counter on error

Paolo Abeni (1):
      mptcp: prevent tcp diag from closing listener subflows

Paolo Bonzini (1):
      KVM: x86/pmu: fix masking logic for MSR_CORE_PERF_GLOBAL_CTRL

Paul Greenwalt (1):
      ice: fix Get link status data length

Pavan Kumar Linga (1):
      idpf: avoid compiler introduced padding in virtchnl2_rss_key struct

Peter Ujfalusi (1):
      ASoC: SOF: Intel: hda-codec: Delay the codec device registration

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix GEM import path code

Radu Pirea (NXP OSS) (1):
      MAINTAINERS: step down as TJA11XX C45 maintainer

Randy Dunlap (1):
      net: phy: linux/phy.h: fix Excess kernel-doc description warning

Rik van Riel (1):
      mm: align larger anonymous mappings on THP boundaries

Rodrigo Cataldo (1):
      igc: Fix hicredit calculation

Sagi Maimon (1):
      ptp: ocp: fix bug in unregistering the DPLL subsystem

Sarannya S (1):
      net: qrtr: ns: Return 0 if server port is not present

Shin'ichiro Kawasaki (1):
      Revert "platform/x86: p2sb: Allow p2sb_bar() calls during PCI
device probe"

Shyam Prasad N (3):
      cifs: after disabling multichannel, mark tcon for reconnect
      cifs: cifs_chan_is_iface_active should be called with chan_lock held
      cifs: do not depend on release_iface for maintaining iface_list

Siddh Raman Pant (2):
      nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref
to llcp_local
      nfc: Do not send datagram if socket state isn't LLCP_BOUND

Siddhesh Dharme (1):
      ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP ProBook 440 G6

Stefan Wahren (2):
      ARM: sun9i: smp: Fix array-index-out-of-bounds read in sunxi_mc_smp_i=
nit
      ARM: sun9i: smp: fix return code check of of_property_match_string

Steven Rostedt (Google) (2):
      tracefs: Check for dentry->d_inode exists in set_gid()
      eventfs: Fix bitwise fields for "is_events"

Sudheer Mogilappagari (1):
      i40e: Fix filter input checks to prevent config with invalid values

Suman Ghosh (1):
      octeontx2-af: Fix marking couple of structure as __packed

Suren Baghdasaryan (1):
      arch/mm/fault: fix major fault accounting when retrying under per-VMA=
 lock

Takashi Sakamoto (1):
      firewire: ohci: suppress unexpected system reboot in AMD Ryzen
machines and ASM108x/VT630x PCIe cards

Tetsuo Handa (1):
      mm: shrinker: use kvzalloc_node() from expand_one_shrinker_info()

Thomas Lange (1):
      net: Implement missing SO_TIMESTAMPING_NEW cmsg support

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Update handling of MMIO triggered reports

Wayne Lin (1):
      drm/amd/display: pbn_div need be updated for hotplug event

Wen Gu (1):
      net/smc: fix invalid link access in dumping SMC-R connections

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix eMMC init failure after hw reset

Xuan Zhuo (1):
      virtio_net: fix missing dma unmap for resize

Yu Zhao (1):
      mm/mglru: skip special VMAs in lru_gen_look_around()

Yuntao Wang (1):
      efi/x86: Fix the missing KASLR_FLAG bit in boot_params->hdr.loadflags

Zack Rusin (1):
      MAINTAINERS: change vmware.com addresses to broadcom.com

Zhipeng Lu (1):
      sfc: fix a double-free bug in efx_probe_filters

Ziyang Huang (1):
      mmc: meson-mx-sdhc: Fix initialization frozen issue

wangkeqi (1):
      connector: Fix proc_event_num_listeners count not cleared

