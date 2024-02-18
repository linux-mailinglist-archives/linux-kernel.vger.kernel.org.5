Return-Path: <linux-kernel+bounces-70350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2274A859660
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EBA71C20B57
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3694E1DA;
	Sun, 18 Feb 2024 10:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EJROp+jR"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900BC14A86
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252741; cv=none; b=CP8nOP72Q8FUfjb5isfQq6WfmdISEbIlEvrDRas6rP6oYXaKtsIk4paQF/btcs7RNXoXpLl5Gq/7JkbwC1G8gbsAbPkVFpXVnQrN6Ou4czCUqjhrNNTq59HglKQ9gf/S4q28pLzAwEVOMbkfoGVMjFxY88caXmCGuAF27YjkYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252741; c=relaxed/simple;
	bh=b1OLxdppIRRlj1AqLwZ9zJ+Yuf2QzAgLFUUz2nfXzb4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uo0kPGjScbTCWBBAOGJWTarWOpxUg+lTE2syInTxRBpk1/Yq4OJnqFBdcHwpNJ5SuCmoo6sfZor2EFK4jfIrOIII+1DutORVHaX/GKPWn58WfevAbp7PRNz94ZlV8lsKrW00QIbZWgB7XCndQ4RjIFzMf2zsj0OyrYQTJhf0Zi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EJROp+jR; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 401DA40E0196;
	Sun, 18 Feb 2024 10:38:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id L7IP1xubM1XP; Sun, 18 Feb 2024 10:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708252728; bh=RuPkCXimlSUgT7uVH960kjgsmn5Bo+kg7cKiP7J7QKM=;
	h=Date:From:To:Cc:Subject:From;
	b=EJROp+jRFmkIurm3WY+atakMNkAjvdixmeMTxcYKbYGGv8sEMCVjEM5kKdQcAxdPo
	 oeNIIlIKddhgft6Y+5rFJoAwu5LJR/1RoGURNcwsu9CdRGHc4sUATgihEXM1oqQcNm
	 9enR7czNHhtXFWFJe3kCkaPbM+c/IsNnP6WV1Sg2WvdcA2onnHVLy0rLAhlEwIgli3
	 2sEzvQE/xhShQKHYzueNcEMZewbaSLsAEOASdzSHaRV3OIepFBOaiSXOgT0afrL6FJ
	 oNOwhmT2tmrlFgnHNDAs+defBbHePhVnHHFX/sSdaWiuCIn7XKYGoc8rIw9PCmPwIc
	 eECCd6c3+kzBmJ9PqLmHCDKRGlZ1MNw2FyaIjfPltykgme9m1YqrsBORYUQ/PT5KS0
	 4ZUv7zUnkjJkcpcgF+JoSKTc4+fzwfqpt6rQGpN6jKlATZKXbYEvlpdyy6ceh0XwcJ
	 sjGUyl4czj4Z3Hhd79BLSxU/mJOg6YuUUyx6o3uQfORKoNC22kxK8IXiZZLsjSDVzn
	 bcSgsl6ioBhxJEK7pTVtu3lxNq3fDY6+0DER0GWLKb8Bpy3BC/GmOlrL3kZgAwYvMw
	 3cIJGs5xYo/Yb3mnsfJnLeVTDx9cI8wXPTEsMO/mIoxboRWRrEPuLnhRJxu9AoQzhV
	 TxA8CGYS/c459irgoUPIFHQM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 081E840E00B2;
	Sun, 18 Feb 2024 10:38:44 +0000 (UTC)
Date: Sun, 18 Feb 2024 11:38:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.8-rc5
Message-ID: <20240218103837.GAZdHeLbPN7pXCkE3L@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a bunch of irqchip fixes for v6.8-rc5.

Thx.

---

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq_urgent_for_v6.8_rc5

for you to fetch changes up to af9acbfc2c4b72c378d0b9a2ee023ed01055d3e2:

  irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update (2024-02-13 11:29:52 +0100)

----------------------------------------------------------------
- Fix GICv4.1 affinity update

- Restore a quirk for ACPI-based GICv4 systems

- Handle non-coherent GICv4 redistributors properly

- Prevent spurious interrupts on Broadcom devices using GIC v3
  architecture

- Other minor fixes

----------------------------------------------------------------
Bibo Mao (1):
      irqchip/loongson-eiointc: Use correct struct type in eiointc_domain_alloc()

Dan Carpenter (1):
      irqchip/qcom-mpm: Fix IS_ERR() vs NULL check in qcom_mpm_init()

Doug Berger (1):
      irqchip/irq-brcmstb-l2: Add write memory barrier before exit

Marc Zyngier (3):
      irqchip/gic-v3-its: Handle non-coherent GICv4 redistributors
      irqchip/gic-v3-its: Restore quirk probing for ACPI-based systems
      irqchip/gic-v3-its: Fix GICv4.1 VPE affinity update

 drivers/irqchip/irq-brcmstb-l2.c       |  5 ++-
 drivers/irqchip/irq-gic-v3-its.c       | 62 ++++++++++++++++++++++------------
 drivers/irqchip/irq-loongson-eiointc.c |  2 +-
 drivers/irqchip/irq-qcom-mpm.c         |  4 +--
 4 files changed, 47 insertions(+), 26 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

