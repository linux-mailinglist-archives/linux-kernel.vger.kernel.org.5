Return-Path: <linux-kernel+bounces-34467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA993837DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F11BB2350E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2741474AA;
	Tue, 23 Jan 2024 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GySuqcW5"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348401468FA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969714; cv=none; b=tlp40DgecclawEUYMamENFDB2/JCHR8HJIWs2qzvKLN0N+0eHPw0YH3ZedMcAFpjNlhf3ytDnh9h8x2P9EPgiXQCwlLR7Um0T0ULzzVHSi4ML5SqkJ/6E+XontFTg2fpsCFQpSKpJmrsBTohwwfKe4YvYRpE9oaW+HXI2Jt9SAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969714; c=relaxed/simple;
	bh=/2zEGgWFHHSbGtTa4mjcGsr+YqaZ5NviJwqoVuZpJvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bRQrVDW1QSnvXntiIrutoDmH1IgNVzV63OOataurIDAYEbUPVJ5tB6uyaH6gZ+KU8jADNZRyRdIq39HPtbNzh1CsBCO5SgyUitubKPvQaC+7/ROl3IHoMi8unB5RzbTXfZB2q/ECNa1Kl336QP2Z0peZ3Bx8S75xtjbwzcJs6UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GySuqcW5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6dbebe4938bso804993b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969711; x=1706574511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wTcmI4hrcuF0h9O44LCbz2SMeSAa3PwN+eu36jY3Vsw=;
        b=GySuqcW5G46MB6aZ80nsulb7tA0xEzpORPP6eO813v0r3ZWBs4Vafiql0/ZdMav+bZ
         wU9ZwbryRlXEbT+x3zJXPMesPjqgWy8xfVa9vc4LUflCRb9o0NMn94XBjiqfmD1nMN8I
         Jsnivgm9wT0kS4i2bo1CzVfSLD4Y5rsoR23UU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969711; x=1706574511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTcmI4hrcuF0h9O44LCbz2SMeSAa3PwN+eu36jY3Vsw=;
        b=MHLjOFPWJrldYvKNhFebJR8198QIbkj4JaBcWJw/g7J8+HB2ZRYi0QM7B+18iOjfWP
         nRquuGELb3c9GdfR0wLPyox0kp142CzMr7fTl8SJjE4bFXIoOnWNv/E/eN0rqdpatFsn
         JV1XpWwqGchHuEoHDXHqqJv7sE2th2k6HPoZHzbd/GErmsyk+Ihbg1SV7NqktPmOdzt6
         EyFt3sIsXVa9I+ctvDnLEy4y7FY8wXjL7i5ARSRicWgU6ZAni3gRGttEDgI6YohiYxlv
         aKfu499nnM9462nAMce2s+WZjqWYxT9W0jwyL4F0+DdzfuwNL8wWaeh2szW3rRlSvJF9
         qRUw==
X-Gm-Message-State: AOJu0YyYCsoFuUbuftDyGWi51T0diC3F2tf8AwcEp/eikKwAHbsnS0Dk
	dTYnGpIiv24bjugdBKgEWafPJRkI8g3HeksnFaNLwCqi63vMVUhUB3ZiVK1/AA==
X-Google-Smtp-Source: AGHT+IFcasPszMC3IrsnJHA0hfgfbPHquE/np9HUjhJZfpzSK8f3LtKZ+Wb0eo/kZfZ2j/m4bpzjNQ==
X-Received: by 2002:a62:5e82:0:b0:6db:c5db:7711 with SMTP id s124-20020a625e82000000b006dbc5db7711mr2057348pfb.26.1705969710718;
        Mon, 22 Jan 2024 16:28:30 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00008400b006dabe67bb85sm10167569pfj.216.2024.01.22.16.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:24 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/82] overflow: Refactor open-coded arithmetic wrap-around
Date: Mon, 22 Jan 2024 16:26:35 -0800
Message-Id: <20240122235208.work.748-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13635; i=keescook@chromium.org;
 h=from:subject:message-id; bh=/2zEGgWFHHSbGtTa4mjcGsr+YqaZ5NviJwqoVuZpJvY=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgDnQIlWDXkYm+e3z8Lv9+5708n8eKOSW3DC
 3p2a//QVMeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IAwAKCRCJcvTf3G3A
 JgvjEAChhDiClIia0Lvxw5PPhFD1eI2r5gNCKbbaMo2tbBn3wI6YmPdGGNrQfTcn4/cWF2u6ypC
 Cs6utqzPrkW7t932fDMa93LeJjNKwmJCq8yG3rcVs2T9BhLpAeiP6xjQeKAnsaqplfVUdU3IQWK
 DrkccHjBeQFlqFtMFsr2SuPmERHrq9RmVpT0EVradL5DvN8YIZODYUn1/nsZbSsRMlnnzr2XSpQ
 3L8cUbX49lgn57jtNlPuRXpKqXAF8zwFYT6JBMAjSwu0iKT+08I7zprqffMACu4Ed/+OJbuWGCL
 RCC619L9Z8H9N05mU7MxlzJbsh/1B2iBDH9q2P1qDdTO3p36soSC37xHuSFaw4rpWNQKk1qAl9z
 141XQt0325IIXjQBa4gw8XO+sz36F8aJAwOFehLjrFcNc0rSYAmwut1CGbJ+utyM7BX+Q6GEdMQ
 8gUw1ljXBCbk44DU+T6c8niXGXrRuHRP/U36XiK8S+ywSxxpikMhTTTZ2gIvrEFIqVev5ub91pp
 MgftMbvnDDIL4uLneIX5tDM01eAwZ66MyuyQ9/KiTp9odL5Scm2G7GTbMBFedWw5S/WoCyiBLHZ
 p8XkA270CBpjAbO2GaaRpimpW33GOLecrBMWoWgM/klqVwpwsqi7tMYncQFRLkL4hJylYyVXH2d
 8D6UUn 4MDAbx56g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

In our continuing effort to eliminate root causes of flaws in the kernel,
this series is the start to providing a way to have sensible coverage
for catching unexpected arithmetic wrap-around.

A quick word on language: while discussing[1] the finer details of
the C standard's view on arithmetic, I was disabused of using the term
"overflow" when what I really mean is "wrap-around". When describing
security vulnerabilities, "overflow" is the common term and often used
interchangeably with "wrap-around". Strictly speaking, though, "overflow"
applies only to signed[2] and pointer[3] types, and "wrap-around" is for
unsigned[4]. An arithmetic "overflow" is considered undefined behavior,
which has caused our builds pain in the past, since "impossible"
conditions might get elided by the compiler. As a result, we build
with -fno-strict-overflow which coverts all "overflow" conditions into
"wrap-around" (i.e. 2s complement), regardless of type.

All this is to say I am discussing arithmetic wrap-around, which is
the condition where the value exceeds a type's maximum value (or goes
below its minimum value) and wraps around. I'm not interested in the
narrow definition of "undefined behavior" -- we need to stamp out the
_unexpected_ behavior, where the kernel operates on a pathological value
that wrapped around without the code author's intent.

As always, this is about being able disambiguate the intent of arithmetic
in the kernel. We intentionally use wrapping arithmetic in all kinds of
places, but we need to be able to annotate it as such going forward so
the compiler can distinguish when it needs to perform instrumentation
(when such instrumentation is enabled).

Getting back to my earlier mention of -fno-strict-overflow, the bulk of
the series is refactoring for a common code pattern in the kernel where
to test for potentially overflowing addition, the addition is performed,
and wrap-around is tested for. This is what originally[5] caused us to
enable -fno-strict-overflow:

	var + offset < var

For these cases we can use either check_add_overflow() or
add_would_overflow(). These helpers will not trip the wrap-around
instrumentation, and do not depend on the whims of the compiler options.
(Note that I have no intention of removing -fno-strict-overflow any
time soon, if ever. As with all these kinds of changes, we need to
evolve our support for it, and we can't introduce undefined behavior
into the kernel.)

This series is mainly 3 parts:

 - documentation, a coccinelle script, and new/improved helpers
 - (re)introduction of the overflow sanitizers
 - refactoring the "please wrap around to see if I wrapped around" tests

While this work is underway in the kernel, there will be complementary
work happening in GCC and Clang to expand the existing sanitizers
to behave correctly with -fno-strict-overflow. In the meantime, the
sanitizers are excluded from CONFIG_COMPILE_TEST.

-Kees

[1] https://gcc.gnu.org/pipermail/gcc-patches/2023-September/630578.html
[2] https://github.com/KSPP/linux/issues/26
[3] https://github.com/KSPP/linux/issues/344
[4] https://github.com/KSPP/linux/issues/27
[5] https://bugzilla.kernel.org/show_bug.cgi?id=12597

Kees Cook (82):
  overflow: Expand check_add_overflow() for pointer addition
  overflow: Introduce add_would_overflow()
  overflow: Introduce add_wrap()
  docs: deprecated.rst: deprecate open-coded arithmetic wrap-around
  cocci: Refactor open-coded arithmetic wrap-around
  overflow: Reintroduce signed and unsigned overflow sanitizers
  overflow: Introduce CONFIG_UBSAN_POINTER_WRAP
  iov_iter: Avoid wrap-around instrumentation in
    copy_compat_iovec_from_user
  select: Avoid wrap-around instrumentation in do_sys_poll()
  locking/atomic/x86: Silence intentional wrapping addition
  arm64: atomics: lse: Silence intentional wrapping addition
  ipv4: Silence intentional wrapping addition
  btrfs: Refactor intentional wrap-around calculation
  smb: client: Refactor intentional wrap-around calculation
  dma-buf: Refactor intentional wrap-around calculation
  drm/nouveau/mmu: Refactor intentional wrap-around calculation
  drm/vc4: Refactor intentional wrap-around calculation
  ext4: Refactor intentional wrap-around calculation
  fs: Refactor intentional wrap-around calculation
  fpga: dfl: Refactor intentional wrap-around calculation
  drivers/fsi: Refactor intentional wrap-around calculation
  x86/sgx: Refactor intentional wrap-around calculation
  KVM: Refactor intentional wrap-around calculation
  KVM: arm64: vgic: Refactor intentional wrap-around calculation
  KVM: SVM: Refactor intentional wrap-around calculation
  buildid: Refactor intentional wrap-around calculation
  m68k: Refactor intentional wrap-around calculation
  niu: Refactor intentional wrap-around calculation
  rds: Refactor intentional wrap-around calculation
  s390/kexec_file: Refactor intentional wrap-around calculation
  ARC: dw2 unwind: Refactor intentional wrap-around calculation
  vringh: Refactor intentional wrap-around calculation
  mm/vmalloc: Refactor intentional wrap-around calculation
  ipc: Refactor intentional wrap-around calculation
  ACPI: custom_method: Refactor intentional wrap-around test
  agp: Refactor intentional wrap-around test
  aio: Refactor intentional wrap-around test
  arm: 3117/1: Refactor intentional wrap-around test
  crypto: Refactor intentional wrap-around test
  arm64: stacktrace: Refactor intentional wrap-around test
  wil6210: Refactor intentional wrap-around test
  bcachefs: Refactor intentional wrap-around test
  bpf: Refactor intentional wrap-around test
  btrfs: Refactor intentional wrap-around test
  cifs: Refactor intentional wrap-around test
  crypto: Refactor intentional wrap-around test
  dm verity: Refactor intentional wrap-around test
  drm/nouveau/mmu: Refactor intentional wrap-around test
  drm/i915: Refactor intentional wrap-around test
  drm/vc4: Refactor intentional wrap-around test
  ext4: Refactor intentional wrap-around test
  f2fs: Refactor intentional wrap-around test
  fs: Refactor intentional wrap-around test
  hpfs: Refactor intentional wrap-around test
  kasan: Refactor intentional wrap-around test
  usercopy: Refactor intentional wrap-around test
  KVM: arm64: vgic-v3: Refactor intentional wrap-around test
  s390/mm: Refactor intentional wrap-around test
  lib/scatterlist: Refactor intentional wrap-around test
  powerpc: Refactor intentional wrap-around test
  scsi: mpt3sas: Refactor intentional wrap-around test
  mwifiex: pcie: Refactor intentional wrap-around test
  mm: Refactor intentional wrap-around test
  netfilter: Refactor intentional wrap-around test
  nios2: Refactor intentional wrap-around test
  fs/ntfs3: Refactor intentional wrap-around test
  ocfs2: Refactor intentional wrap-around test
  PCI: Refactor intentional wrap-around test
  perf tools: Refactor intentional wrap-around test
  remoteproc: Refactor intentional wrap-around test
  s390/mm: Refactor intentional wrap-around test
  scsi: sd_zbc: Refactor intentional wrap-around test
  sh: Refactor intentional wrap-around test
  ARC: dw2 unwind: Refactor intentional wrap-around test
  timekeeping: Refactor intentional wrap-around test
  udf: Refactor intentional wrap-around test
  virtio: Refactor intentional wrap-around test
  mm/vmalloc: Refactor intentional wrap-around test
  staging: vme_user: Refactor intentional wrap-around test
  xen-netback: Refactor intentional wrap-around test
  lib: zstd: Refactor intentional wrap-around test
  mqueue: Refactor intentional wrap-around test

 Documentation/process/deprecated.rst          | 36 ++++++++
 arch/arc/kernel/unwind.c                      |  7 +-
 arch/arm/nwfpe/softfloat.c                    |  2 +-
 arch/arm64/include/asm/atomic_lse.h           |  8 +-
 arch/arm64/include/asm/stacktrace/common.h    |  2 +-
 arch/arm64/kvm/vgic/vgic-kvm-device.c         |  6 +-
 arch/arm64/kvm/vgic/vgic-mmio-v3.c            |  2 +-
 arch/arm64/kvm/vgic/vgic-v2.c                 | 10 ++-
 arch/m68k/kernel/sys_m68k.c                   |  5 +-
 arch/nios2/kernel/sys_nios2.c                 |  2 +-
 arch/powerpc/platforms/powernv/opal-prd.c     |  2 +-
 arch/powerpc/xmon/xmon.c                      |  2 +-
 arch/s390/include/asm/stacktrace.h            |  6 +-
 arch/s390/kernel/machine_kexec_file.c         |  5 +-
 arch/s390/mm/gmap.c                           |  4 +-
 arch/s390/mm/vmem.c                           |  2 +-
 arch/sh/kernel/sys_sh.c                       |  2 +-
 arch/x86/include/asm/atomic.h                 |  2 +-
 arch/x86/kernel/cpu/sgx/ioctl.c               |  6 +-
 arch/x86/kvm/svm/sev.c                        |  5 +-
 crypto/adiantum.c                             |  2 +-
 drivers/acpi/custom_method.c                  |  2 +-
 drivers/char/agp/generic.c                    |  2 +-
 drivers/crypto/amcc/crypto4xx_alg.c           |  2 +-
 drivers/crypto/axis/artpec6_crypto.c          |  2 +-
 drivers/dma-buf/dma-buf.c                     |  7 +-
 drivers/fpga/dfl.c                            |  5 +-
 drivers/fsi/fsi-core.c                        |  6 +-
 drivers/gpu/drm/i915/i915_vma.c               |  2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/vmm.c |  8 +-
 drivers/gpu/drm/vc4/vc4_validate.c            |  7 +-
 drivers/md/dm-switch.c                        |  2 +-
 drivers/md/dm-verity-target.c                 |  2 +-
 drivers/md/dm-writecache.c                    |  2 +-
 drivers/net/ethernet/sun/niu.c                |  5 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |  2 +-
 drivers/net/wireless/marvell/mwifiex/pcie.c   |  6 +-
 drivers/net/xen-netback/hash.c                |  2 +-
 drivers/pci/pci.c                             |  2 +-
 drivers/remoteproc/pru_rproc.c                |  2 +-
 drivers/remoteproc/remoteproc_elf_loader.c    |  2 +-
 drivers/remoteproc/remoteproc_virtio.c        |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_ctl.c            |  2 +-
 drivers/scsi/sd_zbc.c                         |  2 +-
 drivers/staging/vme_user/vme.c                |  2 +-
 drivers/vhost/vringh.c                        |  8 +-
 drivers/virtio/virtio_pci_modern_dev.c        |  4 +-
 fs/aio.c                                      |  2 +-
 fs/bcachefs/bkey.c                            |  4 +-
 fs/bcachefs/fs.c                              |  2 +-
 fs/bcachefs/quota.c                           |  2 +-
 fs/bcachefs/util.c                            |  2 +-
 fs/btrfs/extent_map.c                         |  6 +-
 fs/btrfs/extent_map.h                         |  6 +-
 fs/btrfs/ordered-data.c                       |  2 +-
 fs/ext4/block_validity.c                      |  2 +-
 fs/ext4/extents.c                             |  5 +-
 fs/ext4/resize.c                              |  2 +-
 fs/f2fs/file.c                                |  2 +-
 fs/f2fs/verity.c                              |  2 +-
 fs/hpfs/alloc.c                               |  2 +-
 fs/ntfs3/record.c                             |  4 +-
 fs/ocfs2/resize.c                             |  2 +-
 fs/read_write.c                               |  8 +-
 fs/remap_range.c                              |  2 +-
 fs/select.c                                   | 13 +--
 fs/smb/client/readdir.c                       |  5 +-
 fs/smb/client/smb2pdu.c                       |  4 +-
 fs/udf/balloc.c                               |  4 +-
 include/linux/compiler_types.h                | 29 +++++-
 include/linux/overflow.h                      | 76 +++++++++++++++-
 ipc/mqueue.c                                  |  2 +-
 ipc/shm.c                                     |  6 +-
 kernel/bpf/verifier.c                         | 12 +--
 kernel/time/timekeeping.c                     |  2 +-
 lib/Kconfig.ubsan                             | 27 ++++++
 lib/buildid.c                                 |  6 +-
 lib/iov_iter.c                                |  5 +-
 lib/overflow_kunit.c                          | 77 ++++++++++++++--
 lib/scatterlist.c                             |  2 +-
 lib/test_ubsan.c                              | 82 +++++++++++++++++
 lib/ubsan.c                                   | 89 +++++++++++++++++++
 lib/ubsan.h                                   |  5 ++
 lib/zstd/decompress/zstd_decompress.c         |  4 +-
 mm/kasan/generic.c                            |  2 +-
 mm/kasan/sw_tags.c                            |  2 +-
 mm/memory.c                                   |  4 +-
 mm/mmap.c                                     |  2 +-
 mm/mremap.c                                   |  2 +-
 mm/nommu.c                                    |  4 +-
 mm/usercopy.c                                 |  2 +-
 mm/util.c                                     |  2 +-
 mm/vmalloc.c                                  |  7 +-
 net/ipv4/route.c                              |  8 +-
 net/netfilter/xt_u32.c                        |  4 +-
 net/rds/info.c                                |  6 +-
 scripts/Makefile.ubsan                        |  3 +
 .../coccinelle/misc/add_would_overflow.cocci  | 70 +++++++++++++++
 tools/perf/util/dso.c                         |  2 +-
 tools/perf/util/unwind-libdw.c                |  2 +-
 tools/perf/util/unwind-libunwind-local.c      |  2 +-
 virt/kvm/coalesced_mmio.c                     |  6 +-
 102 files changed, 680 insertions(+), 167 deletions(-)
 create mode 100644 scripts/coccinelle/misc/add_would_overflow.cocci

-- 
2.34.1


