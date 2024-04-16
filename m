Return-Path: <linux-kernel+bounces-146775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D8A8A6AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F288B2160B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C399512C461;
	Tue, 16 Apr 2024 12:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvNIsDA0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D912BF32;
	Tue, 16 Apr 2024 12:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269957; cv=none; b=r8skHBKDjMCS9aQe9EvBzo877RLtxvYTSHxJnRWnMylm/JbO2x8ICCOYIOuBhREcbPfs0tpe2iIg8PefErW6+nXfbcJO8XwUFaK9F6Mt3mabdqIlTgOhM5XKuaqR0KNmfkoeVjo/0dppPwGBnd8QFtwk4U8IpkBQBVd9shtOtOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269957; c=relaxed/simple;
	bh=nqsVC29cav+O44VG4QeWXSJch8muwTP+2TH5V6jNPlU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AhLE/9AjwenIaH6cblZ3d8MHYNq+HHlrI0v/4qc5EYtOqlUuD6B6+85Ptsl98+UWO2cZv4cm4ygF7cT8bN0UVAAymBenvxHKn/0nYVk6VvhTJJZAAxV5AEHeiwkZHtEd2JoGEVX9kaCS2jzc2bckbkc/KYQhBjFS6QWCgmbN/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvNIsDA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8906EC113CE;
	Tue, 16 Apr 2024 12:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713269956;
	bh=nqsVC29cav+O44VG4QeWXSJch8muwTP+2TH5V6jNPlU=;
	h=From:To:Cc:Subject:Date:From;
	b=WvNIsDA0QjdVK5Ias3Y3b5vSJ9oTsHd+zV28wuBPeHdw1OKiuFYVMwpKB2ThC42Ti
	 k+/5AKZOlosbK9AGcjhrKL+JNY7by8U3VM15gTS6AM35bIWZ2md/jgU010U/D9dezx
	 eRsEUIuTxC0r4PcQvwNc+XsTgfxBgA3fI40PxL0wBwtg0vPNgaNq9CBT9BxTJSx2Jm
	 0soXEF65tpM+dYrlcQOjnsJpokPEUer3zXNEAB7pL2L7sE+R3QzIOdIfn684koXcpy
	 n1egPyuO/qLzEI3MsQeV4L5QKhBM/BxDY2gJ3MAg/+a7L0gTnnJW9zS5oYer195ldR
	 AfKXMsaxa6GQA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 0/4] kbuild: replace $(srctree)/$(src) with $(src) in Makefiles
Date: Tue, 16 Apr 2024 21:18:34 +0900
Message-Id: <20240416121838.95427-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes upstream/downstream Makefiles look consistent.


Masahiro Yamada (4):
  arch: use $(obj)/ instead of $(src)/ for preprocessed linker scripts
  Makefile: remove some unnecessary header include paths
  kbuild: use $(obj)/ instead of $(src)/ for pattern rules for %.[cS]
  kbuild: use $(src) instead of $(srctree)/$(src) for source directory

 Documentation/Makefile                        |  8 ++++----
 Documentation/devicetree/bindings/Makefile    | 10 +++++-----
 Documentation/kbuild/makefiles.rst            | 12 +++++------
 Makefile                                      |  7 +++++++
 arch/arc/boot/dts/Makefile                    |  3 +--
 arch/arm/Kbuild                               |  2 +-
 arch/arm/boot/Makefile                        |  3 +--
 arch/arm/mach-s3c/Makefile                    |  2 +-
 arch/arm/plat-orion/Makefile                  |  2 +-
 arch/arm/tools/Makefile                       |  2 +-
 arch/arm64/kernel/vdso/Makefile               |  2 +-
 arch/arm64/kernel/vdso32/Makefile             |  2 +-
 arch/arm64/kvm/Makefile                       |  4 ++--
 arch/arm64/kvm/hyp/Makefile                   |  2 +-
 arch/csky/boot/dts/Makefile                   |  4 +---
 arch/csky/kernel/vdso/Makefile                |  4 ++--
 arch/loongarch/kvm/Makefile                   |  2 --
 arch/loongarch/vdso/Makefile                  |  2 +-
 arch/mips/kernel/syscalls/Makefile            |  2 +-
 arch/mips/vdso/Makefile                       |  4 ++--
 arch/nios2/boot/dts/Makefile                  |  3 +--
 arch/parisc/kernel/vdso32/Makefile            |  4 ++--
 arch/parisc/kernel/vdso64/Makefile            |  4 ++--
 arch/powerpc/boot/Makefile                    |  6 +++---
 arch/powerpc/boot/dts/Makefile                |  3 +--
 arch/powerpc/boot/dts/fsl/Makefile            |  3 +--
 arch/powerpc/kernel/vdso/Makefile             |  8 ++++----
 arch/riscv/kernel/compat_vdso/Makefile        |  2 +-
 arch/riscv/kernel/vdso/Makefile               |  2 +-
 arch/riscv/kvm/Makefile                       |  2 +-
 arch/s390/kernel/syscalls/Makefile            |  4 ++--
 arch/s390/kernel/vdso32/Makefile              |  4 ++--
 arch/s390/kernel/vdso64/Makefile              |  4 ++--
 arch/sh/kernel/vsyscall/Makefile              |  4 ++--
 arch/sparc/vdso/Makefile                      |  2 +-
 arch/um/kernel/Makefile                       |  2 +-
 arch/x86/boot/Makefile                        |  2 +-
 arch/x86/entry/vdso/Makefile                  |  2 +-
 arch/x86/kernel/Makefile                      |  2 +-
 arch/x86/kernel/cpu/Makefile                  |  2 +-
 arch/x86/mm/Makefile                          |  2 +-
 arch/x86/um/vdso/Makefile                     |  2 +-
 arch/xtensa/boot/dts/Makefile                 |  3 +--
 certs/Makefile                                |  4 ++--
 drivers/Makefile                              |  5 -----
 drivers/crypto/intel/qat/qat_420xx/Makefile   |  2 +-
 drivers/crypto/intel/qat/qat_4xxx/Makefile    |  2 +-
 drivers/crypto/intel/qat/qat_c3xxx/Makefile   |  2 +-
 drivers/crypto/intel/qat/qat_c3xxxvf/Makefile |  2 +-
 drivers/crypto/intel/qat/qat_c62x/Makefile    |  2 +-
 drivers/crypto/intel/qat/qat_c62xvf/Makefile  |  2 +-
 .../crypto/intel/qat/qat_dh895xcc/Makefile    |  2 +-
 .../crypto/intel/qat/qat_dh895xccvf/Makefile  |  2 +-
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 drivers/gpu/drm/arm/display/komeda/Makefile   |  4 ++--
 drivers/gpu/drm/i915/Makefile                 |  4 ++--
 drivers/gpu/drm/imagination/Makefile          |  2 --
 drivers/gpu/drm/msm/Makefile                  |  8 ++++----
 drivers/gpu/drm/nouveau/Kbuild                | 10 ++++------
 drivers/gpu/drm/xe/Makefile                   | 10 +++++-----
 drivers/hid/amd-sfh-hid/Makefile              |  2 +-
 drivers/hid/intel-ish-hid/Makefile            |  2 +-
 drivers/md/dm-vdo/Makefile                    |  2 +-
 .../net/ethernet/aquantia/atlantic/Makefile   |  2 --
 drivers/net/ethernet/chelsio/libcxgb/Makefile |  2 +-
 drivers/net/ethernet/fungible/funeth/Makefile |  2 +-
 drivers/net/ethernet/hisilicon/hns3/Makefile  |  2 +-
 .../broadcom/brcm80211/brcmfmac/Makefile      |  4 ++--
 .../broadcom/brcm80211/brcmfmac/bca/Makefile  |  6 +++---
 .../broadcom/brcm80211/brcmfmac/cyw/Makefile  |  6 +++---
 .../broadcom/brcm80211/brcmfmac/wcc/Makefile  |  6 +++---
 .../broadcom/brcm80211/brcmsmac/Makefile      |  6 +++---
 .../broadcom/brcm80211/brcmutil/Makefile      |  2 +-
 .../net/wireless/intel/iwlwifi/dvm/Makefile   |  2 +-
 .../net/wireless/intel/iwlwifi/mei/Makefile   |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/Makefile   |  2 +-
 .../net/wireless/intel/iwlwifi/tests/Makefile |  2 +-
 .../wireless/realtek/rtl818x/rtl8180/Makefile |  2 +-
 .../wireless/realtek/rtl818x/rtl8187/Makefile |  2 +-
 drivers/scsi/aic7xxx/Makefile                 | 12 +++++------
 drivers/staging/rtl8723bs/Makefile            |  2 +-
 fs/iomap/Makefile                             |  2 +-
 fs/unicode/Makefile                           | 14 ++++++-------
 fs/xfs/Makefile                               |  4 ++--
 init/Makefile                                 |  2 +-
 lib/Makefile                                  |  6 +++---
 lib/raid6/Makefile                            |  2 +-
 net/wireless/Makefile                         |  2 +-
 rust/Makefile                                 |  6 +++---
 samples/bpf/Makefile                          |  2 +-
 samples/hid/Makefile                          |  2 +-
 scripts/Kbuild.include                        |  3 +--
 scripts/Makefile.asm-generic                  |  6 +++---
 scripts/Makefile.build                        | 20 +++++++++----------
 scripts/Makefile.clean                        |  2 +-
 scripts/Makefile.host                         |  4 ++--
 scripts/Makefile.lib                          | 10 +++++-----
 scripts/Makefile.modpost                      |  2 +-
 scripts/dtc/Makefile                          |  6 +++---
 scripts/gdb/linux/Makefile                    |  2 +-
 scripts/genksyms/Makefile                     |  4 ++--
 scripts/kconfig/Makefile                      |  8 ++++----
 security/tomoyo/Makefile                      |  2 +-
 usr/Makefile                                  |  2 +-
 usr/include/Makefile                          |  2 +-
 105 files changed, 193 insertions(+), 208 deletions(-)

-- 
2.40.1


