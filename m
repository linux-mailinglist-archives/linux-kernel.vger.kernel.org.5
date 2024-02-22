Return-Path: <linux-kernel+bounces-76566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4E985F942
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA8B1C20D22
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEA5131722;
	Thu, 22 Feb 2024 13:13:33 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00B95FB81;
	Thu, 22 Feb 2024 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607612; cv=none; b=Ho7dRXDb4fnYmlTnl3ea2c3IzVI6N37U4PSIDgqojMXNugnAtGlSglYyDI5W/NJuRSUfzglYZF1ZubzkBysrxdwekbAwvmXflnjAPwJcgAzDriCYmiB+UN/oaShLuBHhM0yRe4cB8My7NGEMxkQ0v4v05saM/ZL6LTnFpUbOO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607612; c=relaxed/simple;
	bh=huKReSSGrI37xYZpUhp+rCn29BeIKsVmRo9XmUqOkr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C5a07tI2L/AhtQKmtwQB7VvNUl5Fv8486If+gMl9J4MuhmaPfX/VIqMrJPbvpQcncTh1ZrulK0YbEJaYG8N5cbm7DNLbCH/DFgEe0PEQmhhDAcojL40zRepoj1FBrGDQuWRIOvpNhAKQpQdslOZq09MbQMgroHvOCfw8e7ei1xA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TgY8d49w9z9xGhZ;
	Thu, 22 Feb 2024 20:57:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 21C07140A0D;
	Thu, 22 Feb 2024 21:13:14 +0800 (CST)
Received: from huaweicloud.com (unknown [10.45.157.235])
	by APP1 (Coremail) with SMTP id LxC2BwDXzhdSSNdlhi4AAw--.34998S2;
	Thu, 22 Feb 2024 14:13:12 +0100 (CET)
From: Petr Tesarik <petrtesarik@huaweicloud.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Xin Li <xin3.li@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Pengfei Xu <pengfei.xu@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ze Gao <zegao2021@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Kai Huang <kai.huang@intel.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Joerg Roedel <jroedel@suse.de>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Tina Zhang <tina.zhang@intel.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: [RFC 0/5] PoC: convert AppArmor parser to SandBox Mode
Date: Thu, 22 Feb 2024 14:12:25 +0100
Message-Id: <20240222131230.635-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
References: <fb4a40c7-af9a-406a-95ab-406595f3ffe5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXzhdSSNdlhi4AAw--.34998S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw1DWF4UuF4kuFWkWF43GFg_yoW8tw1UpF
	n3ta15GF4kJF92yws3AF1F93yFqw4rCw13GFsrKw1Yy3WYqa18XryS9r43uay5ur98Ka43
	tF4avF1jg3WUJa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
	WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26rWY6r4U
	JwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa
	7VUbJ73DUUUUU==
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/

From: Petr Tesarik <petr.tesarik1@huawei-partners.com>

[ For people newly added to Cc, this RFC is a reply to subsystem
  maintainers who asked for a real-world demonstration of how
  SandBox Mode could be used in practice. SandBox Mode itself
  was proposed in these two series (generic and x86):

* https://lore.kernel.org/lkml/20240214113516.2307-1-petrtesarik@huaweicloud.com/T/
* https://lore.kernel.org/lkml/20240214113035.2117-1-petrtesarik@huaweicloud.com/T/
]

This patch series provides an example of running existing kernel code in
a sandbox. It also adds some fixes and infrastructure to the base series.
If you only want to see how the conversion itself might look like, skip
straight to patch 5/5.

Patches 1 and 2 amend the base patch series. Patches 3 and 4 are ported
from my earlier proof of concept and adapted to work without adding too
much other code. I am sending a complete WIP patch series so you can
actually build and run the code.

Disclaimer: This code is not ready for submission. It is incomplete and
may contain bugs. It is provided here for the sole purpose of demonstrating
how existing kernel code would be modified to run in a sandbox.

PATCH 1/5 is a bug fix discovered after sending patch series v1.
PATCH 2/5 allows to map a buffer into the sandbox at its kernel address.
PATCH 3/5 is required to intercept calls to pre-selected kernel functions.
PATCH 4/5 implements dynamic allocation in sandbox mode.
PATCH 5/5 demonstrates how to convert existing kernel code to use SBM.

Petr Tesarik (5):
  sbm: x86: fix SBM error entry path
  sbm: enhance buffer mapping API
  sbm: x86: infrastructure to fix up sandbox faults
  sbm: fix up calls to dynamic memory allocators
  apparmor: parse profiles in sandbox mode

 arch/x86/entry/entry_64.S     |  10 ++-
 arch/x86/kernel/sbm/call_64.S |  20 +++++
 arch/x86/kernel/sbm/core.c    | 161 +++++++++++++++++++++++++++++++++-
 arch/x86/kernel/vmlinux.lds.S |   9 ++
 include/linux/sbm.h           |  77 ++++++++++++++++
 kernel/sbm.c                  |  34 +++++++
 mm/slab_common.c              |   3 +-
 mm/slub.c                     |  17 ++--
 mm/vmalloc.c                  |  11 +--
 security/apparmor/crypto.c    |   7 +-
 security/apparmor/policy.c    |  29 ++++--
 security/apparmor/secid.c     |   3 +-
 12 files changed, 352 insertions(+), 29 deletions(-)

-- 
2.34.1


