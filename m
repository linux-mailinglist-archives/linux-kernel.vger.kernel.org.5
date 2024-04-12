Return-Path: <linux-kernel+bounces-143254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D438A3658
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 21:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75E61F2240B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6973314F9FB;
	Fri, 12 Apr 2024 19:28:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2128413DDAC;
	Fri, 12 Apr 2024 19:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712950133; cv=none; b=MRIRtTktzd7yKUq0DDw0/dBtK8bZFUaP1JgamUosxk3247Y5tovFKW1kRI/lIxjmpfdntPnnOsD4EQlmuNlRffWoaQQOwK0GCDgkKWrO3Tv7L0G2Nxjv4qnW5GxS/uQbdf8OGb73x2kjk35+lgxSmD+bOLqKte3AUgIWzmigwPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712950133; c=relaxed/simple;
	bh=XCy6bbyyqN1LWwKCTQigfobBsswimYECHWPI1zDHCsM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QosKAwDWEb7+UkSppC8Huu4qovPgEACmk/crh0O7diEXyMde3GiSsJ5N2pwyjOm9H/eqpvyww8xCpd0lN2CNFc4tLDMdmMQyZow9spQRG11MG8DkH+JqDINtuVMoyorvhQRbNPzYVGwkqp4/RR4B9D3QcA+xIV62o7kzb8HAj1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18E45339;
	Fri, 12 Apr 2024 12:29:18 -0700 (PDT)
Received: from e120937-lin.. (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A953F766;
	Fri, 12 Apr 2024 12:28:47 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jassisinghbrar@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	jonathan.cameron@huawei.com
Subject: [PATCH v4 0/2] Add initial ARM MHUv3 mailbox support
Date: Fri, 12 Apr 2024 20:27:59 +0100
Message-Id: <20240412192801.554464-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds support for the new ARM Message Handling Unit v3 mailbox
controller [1].

The ARM MHUv3 can optionally support various extensions, enabling the
usage of different transport protocols.

Patch [2/2] adds a platform driver which, as of now, provides support only
for the Doorbell extension using the combined interrupt.

On the other side, bindings in [1/2] are introduced for all the extensions
described by the specification, as long as they are of interest to an
entity running from Normal world, like Linux: as such, Doorbell, FIFO and
FastChannel extensions are documented.

In these regards, note that the ARM MHUv3 controller can optionally
implement a considerable number of interrupts to express a great deal of
events and many of such interrupts are defined as being per-channel: with
the total maximum amount of possibly implemented channels across all
extensions being 1216 (1024+128+64), it would mean *a lot* of
interrupt-names to enumerate in the bindings.

For the sake of simplicity the binding as of now only introduces interrupt
names for a mere 8-channels in the range (0,7) for each per-channel
interrupt type: the idea is to leave open the possibility to add more to
this list of numbered items only when (and if) new real HW appears that
effectively needs more than 8 channels. (like AMBA, where the maximum
number of IRQ was progressively increased when needed, AFAIU).

Based on v6.9-rc1, tested on ARM TCS23 [2]
(TCS23 reference SW stack is still to be made fully publicly available)

Thanks,
Cristian

[1]: https://developer.arm.com/documentation/aes0072/aa/?lang=en
[2]: https://community.arm.com/arm-community-blogs/b/tools-software-ides-blog/posts/total-compute-solutions-platform-software-stack-and-fvp


---
v3 -> v4
 - avoid magic numbers for regs padding holes
 - renaming various enums terminators to count_ instead of max_
 - using scoped_guards for spinlock_save
 - dropping FIRST_EXT naming for 0-indexed enum
 - reduce indentation by using early returns or continue on failure-paths
 - use dev_err_probe where appropriate
 - be less noisy with dev_dbg
 - refactored mhuv3_mbx_comb_interrupt using __free cleanups for .read_data
 - refactored doorbell lookups with scoped_guards
 - fail on IRQ request failures: do not carry-on best effort
 - drop usage of platform_set_drvdata and .remove in favour of
   devm_add_action_or_reset
 - review failures handling on extensions initialization
 - removed name clashes
 - more comments on regs decorations
 - decreasing line-lengths definitions
 - use __ffs instead of __builtin_ctz
 - dropped used of bitfields in favour of bitmasks
 - reading implementer/revision/variant/product_id
 - fixed a few misspellings
 - DT: using ARM GIC defines in example
 - DT: defined MHUv3 Extensions types in new file dt-bindings/arm/mhuv3-dt.h
v2 -> v3
 - fixed spurious tabs/spaces in DT binding
v1 -> v2
 - clarified DT bindings extension descriptions around configurability
   and discoverability
 - removed unused labels from the DT example
 - using pattern properties to define DT interrupt-names
 - bumped DT interrupt maxItems to 74 (allowing uo to 8 channels per extension)
 - fixed checkpatch warnings about side-effects on write/read bitfield macros
 - fixed sparse errors as reported
   | Reported-by: kernel test robot <lkp@intel.com>
   | Closes: https://lore.kernel.org/oe-kbuild-all/202403290015.tCLXudqC-lkp@intel.com/


Cristian Marussi (2):
  dt-bindings: mailbox: arm,mhuv3: Add bindings
  mailbox: arm_mhuv3: Add driver

 .../bindings/mailbox/arm,mhuv3.yaml           |  224 ++++
 MAINTAINERS                                   |    9 +
 drivers/mailbox/Kconfig                       |   11 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/arm_mhuv3.c                   | 1102 +++++++++++++++++
 include/dt-bindings/arm/mhuv3-dt.h            |   13 +
 6 files changed, 1361 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
 create mode 100644 drivers/mailbox/arm_mhuv3.c
 create mode 100644 include/dt-bindings/arm/mhuv3-dt.h

-- 
2.34.1


