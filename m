Return-Path: <linux-kernel+bounces-126056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4256893183
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 13:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D0A28262C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 11:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F021442FD;
	Sun, 31 Mar 2024 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eMCzLFB2"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3192869A
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711885027; cv=none; b=pDe1cM+EYVboyTTT+F+tlMq1wqW54crWTnZoHjMbWu0aYMNsAonMalUmLa9QWXceXZIROVUc0YCk0iBGmVGMcz5PVau/r0J3ZCBc8Fz7WzBLqp3gFbnEI1uVmoqM/BdfLowFlgbYbx3DwC2MK0Gv4U4mc0wFHp1+NkHfSzAddEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711885027; c=relaxed/simple;
	bh=GKcJqXtY8wEAn32Oia9385Z6N6US0rkv12tdaQx549g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OhD3GNX2nGrR65LNhoa/DyKVjxaBA/A3fSwA/xwstxPmEMg7OMdcZKMF5ClRQEtv//G57L4vnRDyQkZBQmEz+wVVYWW9v1Hr+Cs+sTwBTexbRtaKHFNuzFZBAoQGCfykveG7lOAlVmfdaDMDS//K+TL3K3ba1oLsWak85TwVwBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eMCzLFB2; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4EA2040E0202;
	Sun, 31 Mar 2024 11:37:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hVdJnxuKsHb7; Sun, 31 Mar 2024 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711885019; bh=RnOzGehsC/J5Cn5Xkb+jg0PValmIxoaF+OOmi1wtTuk=;
	h=Date:From:To:Cc:Subject:From;
	b=eMCzLFB2+w1rYJ9P6DrMcLI+r0UhfkXIgbxhQ/ete+p3mNxegyRUWqEfDaydh4KyM
	 V8ArkIAL6PGH5Jggp5j9tuISB3W95Ugj9J5RCtH4OuLjUrQ2GiYQoNEsSGPgo1ctBD
	 ToZg+HqHK9R7AGKScILJLSgq/TIPRWHavhBylPMhJVTSoObwOtdRcv2m+MjIJPz+Oi
	 CqjhEVROdD9k/+8epI1/NOOv7tpUbRYY1Az+yKeR4cuCP7bhrMbl/pqVej6Au6KQbo
	 2v9C3jLeLkvyzKn4agRZtDM6QMeziHOi/X9Wxfr5COmb5j4N9ZR6Z6F47xdwt9Ya87
	 VfSi7dxKXA8Bmix2GpgfNgiPzWbOKN9E7vs1BCYQcTHG9T1Wb/qk8AWT6unrD2/Bjk
	 oyo7MvJNPDf5RA+xug3i6SGXm1wl106tOVLh12+4YTBaeQpAHLVMSMI7sfxZgPoDtg
	 cuHO9BV6/YgGvQY0YCJGrzbWequVvvMoYUTGJbe6G2ZtWouVvGrLKnK+o8nw9/SG2+
	 SVDDCrNnot5DowpQf72WSfh4UI3ghqHPXEfQuG8sT07JJS8qVAA6XTq15VKdU1do3M
	 ZtWgHUiJR0Nj5w0wAG6insh1QeF4P+Ae5b4DqBKy0ANa+4Zo5tSCiihIm9GpHwnmjR
	 pJz7AanVcifXBYOFZuKW630U=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C628640E0028;
	Sun, 31 Mar 2024 11:36:56 +0000 (UTC)
Date: Sun, 31 Mar 2024 13:36:54 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC urgent fixes for v6.9-rc2
Message-ID: <20240331113654.GAZglK1jFAzgAFWjZS@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple more fixes to the FMPM driver, for v6.9-rc2.

Thx.

---

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_urgent_for_v6.9_rc2

for you to fetch changes up to a6b227d70d2ad9eb08adc3fe532ebb7ec88ac897:

  RAS: Avoid build errors when CONFIG_DEBUG_FS=n (2024-03-26 21:48:21 +0100)

----------------------------------------------------------------
- Fix more issues in the AMD FMPM driver

----------------------------------------------------------------
Yazen Ghannam (3):
      RAS/AMD/FMPM: Avoid NULL ptr deref in get_saved_records()
      RAS/AMD/FMPM: Safely handle saved records of various sizes
      RAS: Avoid build errors when CONFIG_DEBUG_FS=n

 drivers/ras/amd/fmpm.c | 57 ++++++++++++++++++++++++++++++++++----------------
 drivers/ras/debugfs.h  |  4 ++++
 2 files changed, 43 insertions(+), 18 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

