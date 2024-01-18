Return-Path: <linux-kernel+bounces-30277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33406831C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989CE1F2B420
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442992C87B;
	Thu, 18 Jan 2024 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EikAJD1G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EB625571
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591542; cv=none; b=ESJ7ItInCa/qhLcR6ztH0XfDzg43eiAwvR6eRKoLNzaw41tYQDmzPAQ+l21pv4/OvfOjCgDzL/cfR6LR8znCjA45AwKHBj26fWyAhItB0300Y2uMwR0cxzJqM5jU5PWcr94k499IAjuAODi1cmIIaMgV5OICoXPPt60/HuBimCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591542; c=relaxed/simple;
	bh=ZrNZI/+KtaqDAeKBFPjQTAb311LBOoljbtl1LqlVqgU=;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To; b=h10oaIy8BmcxWnHPGSyVcKiE3RRiiLYR6Al/X8yLGehtUT/l2l8tHxW29GsSAi6Doe1yIH7oRy86+EVKDFb7L3L8ac6pNuUHHjd3SarPzR+svbji5kUUNDoj0OjFrmoxXD85xtVEv835aN3tO+LRYN8HN+p40TPkAGyDsjHljqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EikAJD1G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0DB1EC433C7;
	Thu, 18 Jan 2024 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705591542;
	bh=ZrNZI/+KtaqDAeKBFPjQTAb311LBOoljbtl1LqlVqgU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EikAJD1G0pb3jVcwCRG+fB0VgJ6aECiR0DbO54vwJS46/PkKZ7ypAmiMAywBa+7JN
	 C1OngJTsht/5e51HRbViv6HUrlVtjUPRv0J3Qk7C2KjRCLiFQz0JvjuGslWHyND9md
	 f0XkLLJ4PU0msMmmK7luaFGXqzi9hMuWLJp3wG8GINIkNCqsC+XfxzRa/E9Q94Cyff
	 gfZdmoS1nRFjp1cnjYAQndurEZBfwEKhUM9cdi+42IQxFdV6CMds4/EpKOcop3BAPf
	 3UaFtN62BBsJQ2ySVDbcgHKrVeyIn30mRyuKzVlplAmvtbTAq8M2jafdjw0NKeMuEo
	 eXCfOwb6+Tr4A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0019C4707B;
	Thu, 18 Jan 2024 15:25:41 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathanl.linux.ibm.com@kernel.org>
Subject: [PATCH RFC 0/5] dump_stack: Allow runtime updates of the hardware
 description
Date: Thu, 18 Jan 2024 09:25:11 -0600
Message-Id:
 <20240118-update-dump-stack-arch-str-v1-0-5c0f98d017b5@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANdCqWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQ0ND3dKClMSSVN2U0twC3eKSxORs3cSi5Awgs0jXPM3AwsIgxcg4zdh
 ACWhAQVFqWmYF2PBopSA3Z6XY2loA6bwz0HEAAAA=
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
 Brian King <brking@linux.ibm.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 John Ogness <john.ogness@linutronix.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Petr Mladek <pmladek@suse.com>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 Nathan Lynch <nathanl@linux.ibm.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705591541; l=2778;
 i=nathanl@linux.ibm.com; s=20230817; h=from:subject:message-id;
 bh=ZrNZI/+KtaqDAeKBFPjQTAb311LBOoljbtl1LqlVqgU=;
 b=vrcF1cNPIm2O4+bieSkcw1uoqBBdSqf4JkN+kVqZt0fSLkeqYShpMyznUhC+rjw1sJEeTCg3r
 HvE7JadRlXGBBcZSgBWO/h+xHLaE9TtJfvuE3gqdy++muQ22sED6j1/
X-Developer-Key: i=nathanl@linux.ibm.com; a=ed25519;
 pk=jPDF44RvT+9DGFOH3NGoIu1xN9dF+82pjdpnKjXfoJ0=
X-Endpoint-Received:
 by B4 Relay for nathanl@linux.ibm.com/20230817 with auth_id=78
X-Original-From: Nathan Lynch <nathanl@linux.ibm.com>
Reply-To: <nathanl@linux.ibm.com>

When the kernel emits a stack trace, typically it includes a hardware
description string, e.g.

  Kernel panic - not syncing: sysrq triggered crash
  CPU: 6 PID: 46433 Comm: bash Tainted: G        W          6.7.0-rc2+ #83
> Hardware name: IBM,9040-MR9 POWER9 (architected) 0x4e2102 0xf000005 of:IBM,FW950.01 (VM950_047) hv:phyp pSeries
  Call Trace:
   dump_stack_lvl+0xc4/0x170 (unreliable)
   panic+0x39c/0x584
   sysrq_handle_crash+0x80/0xe0
   __handle_sysrq+0x208/0x4bc
   [...]

This string is a statically allocated buffer populated during boot by
arch code calling dump_stack_set_arch_desc(). For most platforms this
is sufficient.

But the string may become inaccurate on the IBM PowerVM platform due
to live migration between machine models and firmware versions. Stack
dumps emitted after a migration reflect the machine on which the
kernel booted, not necessarily the machine on which it is currently
running. This is potentially confusing for anyone investigating
kernel issues on the platform.

To address this, this series introduces a new function that safely
updates the hardware description string and updates the powerpc
pseries platform code to call it after a migration. The series also
includes changes addressing minor latent issues identified during the
implementation.

Platforms which do not need the new functionality remain unchanged.

For this initial version at least, the powerpc/pseries part includes
some "self-test" code that 1. verifies that reconstructing the
hardware description string late in boot matches the one that was
built earlier, and 2. fully exercises the update path before any
migrations occur. This could be dropped or made configurable in the
future.

Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
---
Nathan Lynch (5):
      dump_stack: Make arch description buffer __ro_after_init
      dump_stack: Allow update of arch description string at runtime
      powerpc/prom: Add CPU info to hardware description string later
      powerpc/pseries: Prepare pseries_add_hw_description() for runtime use
      powerpc/pseries: Update hardware description string after migration

 arch/powerpc/kernel/prom.c                | 12 +++--
 arch/powerpc/platforms/pseries/mobility.c |  5 ++
 arch/powerpc/platforms/pseries/pseries.h  |  1 +
 arch/powerpc/platforms/pseries/setup.c    | 80 +++++++++++++++++++++++++++++--
 include/linux/printk.h                    |  5 ++
 lib/dump_stack.c                          | 57 ++++++++++++++++++++--
 6 files changed, 146 insertions(+), 14 deletions(-)
---
base-commit: 44a1aad2fe6c10bfe0589d8047057b10a4c18a19
change-id: 20240111-update-dump-stack-arch-str-7f0880d23f30

Best regards,
-- 
Nathan Lynch <nathanl@linux.ibm.com>


