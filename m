Return-Path: <linux-kernel+bounces-130973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABF2898169
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A3F41C2176C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 06:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409A04CB3D;
	Thu,  4 Apr 2024 06:25:19 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186BE1AAC4;
	Thu,  4 Apr 2024 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712211918; cv=none; b=nt0kWt/w6nD1wnfmolMaTpDg9AyoQe1nnkG2Cju51MTYdXm4y64Y/+bR503TuEbVUn+bu2XUFaphEYfhPa6o55coXb7PB0dUar4YPxbJRRJ+IVB9LNytRn+esgDk7wCsSi1s41nT4Z7CmbO/osb2xEO0EC2SgTRuY+J/Rgl53C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712211918; c=relaxed/simple;
	bh=Uo09rOYqIxOFRfj72qvjqX4RBzZIAdSWGrqPXZi5JOY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I2tSY9v+88x6u7SHLZDRCISdG6ZqiLVtMEkFBObFjlI7Ey84ad0pmvz2O99fPuldFP1KNVWvh/iN4jtE2DbzuMtmimv7wvnW65edsUmR/Ij2lUs7h/wB2uOoc0v3n6nOGZo8dGmWpj5rqjjIPjBDVi2uAE1NZh3peZlm04R3wHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA8B31007;
	Wed,  3 Apr 2024 23:25:45 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8FBF3F64C;
	Wed,  3 Apr 2024 23:25:13 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com,
	cristian.marussi@arm.com,
	jassisinghbrar@gmail.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: [PATCH v3 0/2] Add initial ARM MHUv3 mailbox support
Date: Thu,  4 Apr 2024 07:23:45 +0100
Message-Id: <20240404062347.3219795-1-cristian.marussi@arm.com>
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

 .../bindings/mailbox/arm,mhuv3.yaml           |  217 ++++
 MAINTAINERS                                   |    9 +
 drivers/mailbox/Kconfig                       |   11 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/arm_mhuv3.c                   | 1063 +++++++++++++++++
 5 files changed, 1302 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
 create mode 100644 drivers/mailbox/arm_mhuv3.c

-- 
2.34.1


