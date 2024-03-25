Return-Path: <linux-kernel+bounces-116749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDB888A34C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 782FE2E2CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEEE1703D0;
	Mon, 25 Mar 2024 10:37:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE3413C3DD;
	Mon, 25 Mar 2024 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358921; cv=none; b=suxOWMR4ArOnB5zJaMLSXdENcu7K6O8wOfdj4LXXN+4i8etSnqT1lgsxbWme9jmkmsxQJfn9K8WKl3xFcR7M00RyiGoSkeP6j+izUWnRoYzTUbPVkNxV0Nbemn4kTizoCImyb/wKLBMytkjuRV4fO2wdOHb7G5uspmwwsvsgvfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358921; c=relaxed/simple;
	bh=wx+ZNiYpSOHdOgttIJ+LyxuucfRoYfBTMykVd7YTQMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tag8lv+owGf88SrMZeX9F9TsSfK3z7Om1i3AyHo7hGeMfYKlGe9LwxlyI4nh481iVMHRCTkLRX5JeIF8GzWwNAkVVlTNAu42hWfuoLbu40adU57+/Wvs5NhwjlQYiC7B7ERnriKhhUeZfCSbOJkOAlPGkx1PG3PTOylLO6NcUxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58E351FB;
	Mon, 25 Mar 2024 02:29:12 -0700 (PDT)
Received: from e120937-lin.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42C483F64C;
	Mon, 25 Mar 2024 02:28:37 -0700 (PDT)
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
Subject: [PATCH 0/2] Add initial ARM MHUv3 mailbox support
Date: Mon, 25 Mar 2024 09:28:06 +0000
Message-Id: <20240325092808.117510-1-cristian.marussi@arm.com>
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

So, since, I could not find a proper yaml/DT way to just define and verify
interrupt-names as:

	my_interrupt-<N> with <N> in [0, N] range

the binding as of now only introduces interrupt-names for a mere 4-channels
in the range (0,3) for each per-channel interrupt type: the idea is to
leave open the possibility to add more to this list of numbered items only
when (and if) new real HW appears that effectively needs more than four
channels. (like AMBA, where the maximum number of IRQ was progressively
increased when needed, AFAIU); any suggestion on how to better express
this, is very much welcome.

Based on v6.9-rc1, tested on ARM TCS23 [2]
(TCS23 reference SW stack is still to be made fully publicly available)

Thanks,
Cristian

[1]: https://developer.arm.com/documentation/aes0072/aa/?lang=en
[2]: https://community.arm.com/arm-community-blogs/b/tools-software-ides-blog/posts/total-compute-solutions-platform-software-stack-and-fvp

Cristian Marussi (2):
  dt-bindings: mailbox: arm,mhuv3: Add bindings
  mailbox: arm_mhuv3: Add driver

 .../bindings/mailbox/arm,mhuv3.yaml           |  239 ++++
 MAINTAINERS                                   |    9 +
 drivers/mailbox/Kconfig                       |   11 +
 drivers/mailbox/Makefile                      |    2 +
 drivers/mailbox/arm_mhuv3.c                   | 1061 +++++++++++++++++
 5 files changed, 1322 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv3.yaml
 create mode 100644 drivers/mailbox/arm_mhuv3.c

-- 
2.34.1


