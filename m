Return-Path: <linux-kernel+bounces-139888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74248A08E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FE9CB27A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738B713DDB8;
	Thu, 11 Apr 2024 06:55:20 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA4213D622
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 06:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818520; cv=none; b=jMUMTH0R+watiJyC6nGERw+jxsX863qmDeEJD0WtbdJLKFKLFR6OsQkGR2nt/PhZCY7kSSHjoowRO5S0+t10h30GusQaNyy1hGVk/B7LJDbRN7WvDxC7sHFSEjyz73Pg49Dokhys8JKuy9S74NEWz/8rkuL2R7uDS1XPFLBC5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818520; c=relaxed/simple;
	bh=QKav+5y61ZdnV0RW5NGa87eeulpAiivRJ79CGIruxTs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jaKNUcrVp0hii/E+baDOsOxpI1gWCyCUeVpzE70GlXvdHZVeLnSlvVKlh0LxOWkaGPs8KY2tO08pNYEcWnML410mc3i0dwofqrEMcgX5a+WRHXl3EHqcVbu6aONS2vCw4Y68iCN3BZ3DyU4yY1n/x/bDlIboLCdSRhSPV2/80OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFVkF5RFcz2NW75;
	Thu, 11 Apr 2024 14:52:21 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 30338180063;
	Thu, 11 Apr 2024 14:55:14 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Thu, 11 Apr
 2024 14:55:12 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <james.morse@arm.com>, <suzuki.poulose@arm.com>,
	<yuzenghui@huawei.com>, <tglx@linutronix.de>, <mark.rutland@arm.com>,
	<ardb@kernel.org>, <broonie@kernel.org>, <liaochang1@huawei.com>,
	<anshuman.khandual@arm.com>, <miguel.luis@oracle.com>, <joey.gouly@arm.com>,
	<ryan.roberts@arm.com>, <jeremy.linton@arm.com>,
	<daniel.thompson@linaro.org>, <sumit.garg@linaro.org>, <liwei391@huawei.com>,
	<peterz@infradead.org>, <jpoimboe@kernel.org>, <ericchancf@google.com>,
	<kristina.martsenko@arm.com>, <robh@kernel.org>,
	<scott@os.amperecomputing.com>, <songshuaishuai@tinylab.org>,
	<shijie@os.amperecomputing.com>, <bhe@redhat.com>,
	<akpm@linux-foundation.org>, <horms@kernel.org>,
	<rmk+kernel@armlinux.org.uk>, <Jonathan.Cameron@huawei.com>,
	<takakura@valinux.co.jp>, <dianders@chromium.org>, <swboyd@chromium.org>,
	<frederic@kernel.org>, <reijiw@google.com>, <ruanjinjie@huawei.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kvmarm@lists.linux.dev>
Subject: [PATCH v2 0/9] Rework the DAIF mask, unmask and track API
Date: Thu, 11 Apr 2024 06:48:49 +0000
Message-ID: <20240411064858.3232574-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd200013.china.huawei.com (7.221.188.133)

This patch series reworks the DAIF mask, unmask, and track API for the
upcoming FEAT_NMI extension added in Armv8.8.

As platform and virtualization[1] supports for FEAT_NMI is emerging, and
Mark Brown's FEAT_NMI patch series[2] highlighted the need for clean up
the existing hacking style approach about DAIF management code before
adding NMI functionality, furthermore, we discover some subtle bugs
during 'perf' and 'ipi_backtrace' transition from PSEUDO_NMI to
FEAT_NMI, in summary, all of these emphasize the importance of rework.

This series of reworking patches follows the suggestion from Mark
Rutland mentioned in Mark Brown's patchset. In summary, he think the
better way for DAIF manangement look likes as following:

(a) Adding entry-specific helpers to manipulate abstract exception masks
    covering DAIF + PMR + ALLINT. Those need unmask-at-entry and
    mask-at-exit behaviour, and today only need to manage DAIF + PMR.

    It should be possible to do this ahead of ALLINT / NMI support.

(b) Adding new "logical exception mask" helpers that treat DAIF + PMR +
    ALLINT as separate elements. 

This patches cherry-pick a part of Mark Brown' FEAT_NMI series, in order
to pass compilation and basic testing, includes perf and ipi_backtrace.

[1] https://lore.kernel.org/all/20240407081733.3231820-1-ruanjinjie@huawei.com/
[2] https://lore.kernel.org/linux-arm-kernel/Y4sH5qX5bK9xfEBp@lpieralisi/

v2->v1:
Add SoB tags following the origin author's SoBs.

Jinjie Ruan (1):
  arm64/cpufeature: Simplify detect PE support for FEAT_NMI

Liao Chang (5):
  arm64/cpufeature: Use alternatives to check enabled ARM64_HAS_NMI
    feature
  arm64: daifflags: Add logical exception masks covering DAIF + PMR +
    ALLINT
  arm64: Unify exception masking at entry and exit of exception
  arm64: Deprecate old local_daif_{mask,save,restore}
  irqchip/gic-v3: Improve the maintainability of NMI masking in GIC
    driver

Mark Brown (3):
  arm64/sysreg: Add definitions for immediate versions of MSR ALLINT
  arm64/cpufeature: Detect PE support for FEAT_NMI
  arm64/nmi: Add Kconfig for NMI

 arch/arm64/Kconfig                   |  17 ++
 arch/arm64/include/asm/cpufeature.h  |   6 +
 arch/arm64/include/asm/daifflags.h   | 296 ++++++++++++++++++++++-----
 arch/arm64/include/asm/nmi.h         |  27 +++
 arch/arm64/include/asm/sysreg.h      |   2 +
 arch/arm64/include/uapi/asm/ptrace.h |   1 +
 arch/arm64/kernel/acpi.c             |  10 +-
 arch/arm64/kernel/cpufeature.c       |  58 +++++-
 arch/arm64/kernel/debug-monitors.c   |   7 +-
 arch/arm64/kernel/entry-common.c     |  96 +++++----
 arch/arm64/kernel/entry.S            |   2 -
 arch/arm64/kernel/hibernate.c        |   6 +-
 arch/arm64/kernel/irq.c              |   2 +-
 arch/arm64/kernel/machine_kexec.c    |   2 +-
 arch/arm64/kernel/setup.c            |   2 +-
 arch/arm64/kernel/smp.c              |   6 +-
 arch/arm64/kernel/suspend.c          |   6 +-
 arch/arm64/kvm/hyp/vgic-v3-sr.c      |   6 +-
 arch/arm64/kvm/hyp/vhe/switch.c      |   4 +-
 arch/arm64/mm/mmu.c                  |   6 +-
 arch/arm64/tools/cpucaps             |   2 +
 drivers/irqchip/irq-gic-v3.c         |   6 +-
 22 files changed, 438 insertions(+), 132 deletions(-)
 create mode 100644 arch/arm64/include/asm/nmi.h

-- 
2.34.1


