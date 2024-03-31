Return-Path: <linux-kernel+bounces-126054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E699893181
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2AD71F2183A
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C301442FC;
	Sun, 31 Mar 2024 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dyyDrPck"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1D1442F4
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 11:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711884736; cv=none; b=XET5d5xomASxYdw3+3OYYTh5upMWqvoE5Sf/42QaTsL8Nq53EcM16L4mtcvJ/lMh283N1OBYvEiH5zq0K72WvAp++7qu2pJcuBvJyp4TaAA3V8HaW3LvRlX134cS4OHx/CEmeJLun5nrq+6Iz1057FAnvH+ma/eZynimhsbivY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711884736; c=relaxed/simple;
	bh=l/n89jyRdv3BnpcUTkDf5x/y6UK/zmD1HFTQ6NBSiSw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tWk6b3v7nSjaW0f2ybNI5aSWY+8T9Sokb7paXYSNYAEMRPaJsWXrZiCkDyFA0zzdbKZIs4iMW3p5AjNkdV83Qt+WZ6849G4PfluSwzrhy9D4wzDh8feKd7VO2yAAlOnAEVZn6Xm1r5NhhUVXVdt1QiZWByNQbSpS9uyoOeqtGoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dyyDrPck; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0D0DC40E0028;
	Sun, 31 Mar 2024 11:32:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id K_OUclyJakUS; Sun, 31 Mar 2024 11:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711884728; bh=+iSMLyYb7/bY4QxWCBuy7ZiSq+kT8uNNtncKvWabhFw=;
	h=Date:From:To:Cc:Subject:From;
	b=dyyDrPckjta1WSoc76GvkUFDMtsUyvz2+mRu8Bi5vf+s2Xdos1rXjt4veSwr2u2Q1
	 Ra0l0vDldw8F5YUR4CKMT5WYWTsUh1lY4E3hhzJIQWPBWhFmCppFzOmd8tkK0cVXPM
	 vcD8o1eaHRcVKat3ulNjGz68lwnfIsHa+zAJMsX5VgWc19rtYbJL6rmP5ZY0vzLySq
	 2j39ERKhwVqOAv7LKVMoYJI3enppNmNJvl3lzZNBZc9pmnQBP/38v2y5X8mHTw6rmW
	 VqmJBnB+uYY6UeCrAVrZXEKKmqqYfp4WdkuyQvg+U68Gi2QMjS5jfzouQ37ngMlWHk
	 G90XApLkaCbenulfhqlAC3CoYfyEfT8FktSfMGWIAhHh6KMU6wZVBsLsWkvX4Wn73J
	 MNqgK558RTICvIo+ffAxrD8ZLy+FE8hpbHGJsqQnUgQk22rwhdyQ9rmYweuY/cvl4x
	 0ur5ryon51NWYA4BKqNGOil/i3yHqNoLtDnJAaECyzb/+v6Uewl/YG2dIX6Uw7bRhg
	 q3TY+xoOOp5I5EOLJqiOK2mbAiC1C4ck4HX3ApKyKTp5uOvrP+pMiAP4caYO1ufCLO
	 9y/oF2ankEOrH/AXB+OEibSyXFonfsnGrgTkQ9m+TJQd5n6CJOvr4u7QtrcpGgL9kj
	 iaBxzTscu/1zB9NBrSIUh894=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4841F40E0202;
	Sun, 31 Mar 2024 11:32:05 +0000 (UTC)
Date: Sun, 31 Mar 2024 13:32:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.9-rc2
Message-ID: <20240331113204.GAZglJtCst_SqlTfJ3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two urgent IRQ subsystem fixes for v6.9-rc2.

Thx.

---

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/irq_urgent_for_v6.9_rc2

for you to fetch changes up to 9e81e329508576b499b5c47ab106b5fa45ce96d9:

  irqchip/armada-370-xp: Suppress unused-function warning (2024-03-26 02:12:16 +0100)

----------------------------------------------------------------
- Fix an unused function warning on irqchip/irq-armada-370-xp

- Fix the IRQ sharing with pinctrl-amd and ACPI OSL

----------------------------------------------------------------
Arnd Bergmann (1):
      irqchip/armada-370-xp: Suppress unused-function warning

Rafael J. Wysocki (1):
      genirq: Introduce IRQF_COND_ONESHOT and use it in pinctrl-amd

 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 drivers/pinctrl/pinctrl-amd.c       | 2 +-
 include/linux/interrupt.h           | 3 +++
 kernel/irq/manage.c                 | 9 +++++++--
 4 files changed, 12 insertions(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

