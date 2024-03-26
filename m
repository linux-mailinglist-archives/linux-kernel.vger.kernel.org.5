Return-Path: <linux-kernel+bounces-118512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1548288BBF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C22542A7CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4BB1350C8;
	Tue, 26 Mar 2024 08:06:35 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565EC134412;
	Tue, 26 Mar 2024 08:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440395; cv=none; b=b8MktuAa58bIIrdhMWOFCoG5Wdqw0sHUUESh1nBFjklbMX3Oe++22Tro5ozBf4gVgOrfmd5dGAkxgTODllXpDS8bDiUrtlH+htbxGcN625/quWTa0VTjPnaldJZboHzMnxF7uSRkOFKF0pn0u8G4yE4rjBCaLcBuwgVmzewo9Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440395; c=relaxed/simple;
	bh=f9hCfYedwpxEoNBuNNWZFPjqKzvQdVCG0xEb4sz+K0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gda3IwEnZYTXDYcYYmD8drPHgUS80AQJFqSsHSxP9DPshbYHAMWGScwc/mey3Yt5mVI3RCreeJX7jXKG0UPsQnxjbs5zDJNATdSg8BIevBqnO6mu3i4LztoI7saFMAp2e4VsFvx1yGfXMYgPBDO6+EJv3oCGN0l6ePKQjY05JtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxHOsDggJmCUoeAA--.61102S3;
	Tue, 26 Mar 2024 16:06:27 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxbRMBggJmhaRoAA--.9600S2;
	Tue, 26 Mar 2024 16:06:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Tianrui Zhao <zhaotianrui@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev,
	x86@kernel.org
Subject: [PATCH 0/2] LoongArch: Add steal time support
Date: Tue, 26 Mar 2024 16:06:23 +0800
Message-Id: <20240326080625.898051-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxbRMBggJmhaRoAA--.9600S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Para-virt feature steal time is added in both kvm and guest kernel side.
It is silimar with other architectures, steal time structure comes from
guest memory, also pseduo register is used to save/restore base address
of steal time structure, so that vm migration is supported also.

Bibo Mao (2):
  LoongArch: KVM: Add steal time support in kvm side
  LoongArch: Add steal time support in guest side

 arch/loongarch/include/asm/kvm_host.h  |   7 ++
 arch/loongarch/include/asm/kvm_para.h  |  10 ++
 arch/loongarch/include/asm/loongarch.h |   1 +
 arch/loongarch/include/asm/paravirt.h  |   5 +
 arch/loongarch/include/uapi/asm/kvm.h  |   4 +
 arch/loongarch/kernel/paravirt.c       | 130 +++++++++++++++++++++++++
 arch/loongarch/kernel/time.c           |   2 +
 arch/loongarch/kvm/exit.c              |  35 ++++++-
 arch/loongarch/kvm/vcpu.c              | 120 +++++++++++++++++++++++
 9 files changed, 309 insertions(+), 5 deletions(-)


base-commit: 2ac2b1665d3fbec6ca709dd6ef3ea05f4a51ee4c
-- 
2.39.3


