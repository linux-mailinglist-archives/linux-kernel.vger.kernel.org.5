Return-Path: <linux-kernel+bounces-92889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEFA87279D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AC2824CB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1A54DA11;
	Tue,  5 Mar 2024 19:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="e9wo2dGS"
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359F1C01
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709667439; cv=none; b=nDuOiNz6QHxUtzjzkKGF9L8w9uD53Ygs9YH38okXRHXkb9/AyNQBvkbFTWtLbt2VZ9JvudEk+Tc1BBr+h3odc/l+sn6q8a2OdKN8BzhkhlpKgWpodrNdHExqGzLOD1B7xdbec1jI2yMK0b8BLBnhRbTxUwpVeTFPLnDce02f3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709667439; c=relaxed/simple;
	bh=j/UAfvFMFsXCsS/euRcxy/fyrQnAZE8Q8WRvQCeVmbM=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=nQ2q2C2naSYp+tbHFFMD97Ebk+KEcxJ0edjK+OJu7Uzj8BBXk/8Jx8FJndtdPM/PrewqEHdZC9yYZpS6xaun/gdlZJiBCuHGudxC4mlPZ/v70dvqOnymacu3clUVGB/a3oXNZC6YDBPfxIpiT2Qbkj2DaBaBBOu+V1stjSYk5ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=e9wo2dGS; arc=none smtp.client-ip=203.205.221.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709667433; bh=xYAKlJMz8tHhX/SyBJ+u8i1ukaT80u/oUuBPwp95/WU=;
	h=From:To:Cc:Subject:Date;
	b=e9wo2dGSaNWPUjmsHmAKIZxBMRwMwKo64HlJcexDxQCtgevWlJCvM97413CDu04iS
	 oOpZ6AZZILPXg3B1UYuEnA1E0bXsajCBXOHI/Y+nFtTCjWHjI1AV6Yj3Na2Qa+SKRv
	 Sb35t18407gs5YTYP2RfJCex7b1xHLYrhsE7znzE=
Received: from cyy-pc.lan ([240e:379:2267:e200:bd8:e8f9:fb59:de48])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 94902851; Wed, 06 Mar 2024 03:37:09 +0800
X-QQ-mid: xmsmtpt1709667429tgqpk2n0q
Message-ID: <tencent_587730262984A011834F42D0563BC6B10405@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GpsCj3Jk0kjwcDv7v3MKRfVs0UMJTow0ftTa8kEOsfezNzLxNMp
	 jvWOfRXPWhg8CyVlVBXl4fXZ5SyrLZUnWTNoCPvZ6E0GHTAYqjrMBzB78l5VUSo897LdD6A+Jatg
	 k+aTUjZXII0ycuflDIRBkCJCaT5GHFeDnSQ+vJjw/Hs9mSK1ZPjPgsrlmsgR0X3JKZXUqmkn4dJn
	 MvhEVKDC4Vv1eb5DsCX7YgrZnr5Q/XmSzP+tfJ3gMaqNSPOpdWZbRHNmzRNZNl1DyITxtMrLTuDF
	 nWQCYSWd+FefMoeKYYNwN5zsP6E1JqBIPKQtyIRVS0gdqIpFdk1KDDekw2bGART3loZCAtogIPLJ
	 gwnBuBFQ0dTtJfjDUd/a6gAfb7VLEWxVSZX2qH8LO3rqS2Vtd/eEA9F6Vz6EEh9d9xCuioxV3a+u
	 6caUI7bLhqiXz50PBmr2YZ5CHu61T4Kejy17Yj3/yTyOQrN+eupE6RifpNFxu1f7B3fvrdqt45/o
	 CCGyFgvpaxVa8ebi7RO+slM7+d8MI/KUcgjts7gNyfQdetJv4Hh5PPBHThotd66c1fGSUN7tjG23
	 EvcLFnbpWhQVc3iytUyuVExBiFfsk0xfd21ov/Zes1mcVWgUXkiTpEOldYigZzCRNnFHXMqTnkSK
	 vPKqmvF6jx9H5lPZVR0PyVydHXW2+DUevERFMoNE/iD50i3sQOQJOaIzhXIZN164VxSRp0m5L1bb
	 nZi4xPX9UtqQlxnwQmLo5kLhYy9HZ5ArsNpI4lnLz1Yi57aXUCXtfDoWhPDXFP3+7qGRT3L6Bnys
	 Q/a+fN0k+xDZ3SyimiPDerzeJYbAHpiJ0Hmeo3uG3UXRjh7fIwS8aRX6r3nH9ZZUKs1NX6CH94DT
	 OGwIH33RgdUcaxrVZe7J9Duwc7rqHtaoU9j2ozeUi/KRfrl8Wc8/uCsJ792pnrY/a9LGLBbifKEq
	 JscTYyKot+Ue7vhvNIBU1bzoSdksLPBraurjgYPubpuEB4rgwf4DBl25boXxjXSj1zqnknScTZ4I
	 IU7Yplol568zFPtL9xMCu5DssHykI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Yangyu Chen <cyy@cyyself.name>
To: linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Guo Ren <guoren@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH v4 0/7] riscv: add initial support for Canaan Kendryte K230
Date: Wed,  6 Mar 2024 03:36:08 +0800
X-OQ-MSGID: <20240305193608.1084130-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

K230 is an ideal chip for RISC-V Vector 1.0 evaluation now. Add initial
support for it to allow more people to participate in building drivers
to mainline for it.

This kernel has been tested upon factory SDK [1] with
k230_evb_only_linux_defconfig and patched mainline opensbi [2] to skip
locked pmp and successfully booted to busybox on initrd with this log [3].

[1] https://github.com/kendryte/k230_sdk
[2] https://github.com/cyyself/opensbi/tree/k230
[3] https://gist.github.com/cyyself/b9445f38cc3ba1094924bd41c9086176

Changes since v3:
- Refactor Kconfig.soc which uses ARCH_CANAAN for regular Canaan SoCs and
  rename SOC_CANAAN to SOC_CANAAN_K210 for K210 in patch [5/7]
- Sort dt-binding stings on Cannan SoCs in alphanumerical order

v3: https://lore.kernel.org/linux-riscv/tencent_BB2364BBF1812F4E304F7BDDD11E57356605@qq.com/

Changes since v2:
- Add MIT License to dts file
- Sort dt-binding stings in alphanumerical order
- Sort filename in dts Makefile in alphanumerical order
- Rename canmv-k230.dts to k230-canmv.dts

v2: https://lore.kernel.org/linux-riscv/tencent_64A9B4B31C2D70D5633042461AC9F80C0509@qq.com/

Changes since v1:
- Patch dt-bindings in clint and plic
- Use enum in K230 compatible dt bindings
- Fix dts to pass `make dtbs_check`
- Add more details in commit message

v1: https://lore.kernel.org/linux-riscv/tencent_E15F8FE0B6769E6338AE690C7F4844A31706@qq.com/

Yangyu Chen (7):
  dt-bindings: riscv: Add T-HEAD C908 compatible
  dt-bindings: add Canaan K230 boards compatible strings
  dt-bindings: timer: Add Canaan K230 CLINT
  dt-bindings: interrupt-controller: Add Canaan K230 PLIC
  riscv: Kconfig.socs: Split ARCH_CANAAN and SOC_CANAAN_K210
  riscv: dts: add initial canmv-k230 and k230-evb dts
  riscv: config: enable ARCH_CANAAN in defconfig

 .../sifive,plic-1.0.0.yaml                    |   1 +
 .../devicetree/bindings/riscv/canaan.yaml     |   8 +-
 .../devicetree/bindings/riscv/cpus.yaml       |   1 +
 .../bindings/timer/sifive,clint.yaml          |   1 +
 arch/riscv/Kconfig.socs                       |   8 +-
 arch/riscv/Makefile                           |   2 +-
 arch/riscv/boot/dts/canaan/Makefile           |   2 +
 arch/riscv/boot/dts/canaan/k230-canmv.dts     |  24 +++
 arch/riscv/boot/dts/canaan/k230-evb.dts       |  24 +++
 arch/riscv/boot/dts/canaan/k230.dtsi          | 140 ++++++++++++++++++
 arch/riscv/configs/defconfig                  |   1 +
 arch/riscv/configs/nommu_k210_defconfig       |   3 +-
 .../riscv/configs/nommu_k210_sdcard_defconfig |   3 +-
 drivers/clk/Kconfig                           |   4 +-
 drivers/pinctrl/Kconfig                       |   4 +-
 drivers/reset/Kconfig                         |   4 +-
 drivers/soc/Makefile                          |   2 +-
 drivers/soc/canaan/Kconfig                    |   4 +-
 18 files changed, 220 insertions(+), 16 deletions(-)
 create mode 100644 arch/riscv/boot/dts/canaan/k230-canmv.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230-evb.dts
 create mode 100644 arch/riscv/boot/dts/canaan/k230.dtsi

-- 
2.43.0


