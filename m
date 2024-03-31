Return-Path: <linux-kernel+bounces-126033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C36893138
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE39EB20B94
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EBB762E5;
	Sun, 31 Mar 2024 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hd0nks06"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B770EEEC0
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711880849; cv=none; b=IqHKDJBnbc6rU9zLZSx/BTKfyZxb5jSyKIKq2tPYoz1PQXXFO4pjdyKzRjAeRl8hitTrNzEdYX+UrvntE4oqDU8jxarAb28A3k33rWCQrwkiH5hZRwnlyzZuXBT+w/opMNwjIjLYeUwBQZyMp2KBPiGZYn5Ifq76vQcGKKMl/eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711880849; c=relaxed/simple;
	bh=z3YsaUmiXJzAMJ91jUojmTwdr1iCVVYpE3My/dVKtAo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hxb/fJOZXbmD7h8XxYYC8P6wDOp3annZM7D9i9vF2QbwMCoj5JCx7oFj7aaQhF+0i21FvrjU9t8aJGTd2kT7dpZbkdKtVEdeeGuu+kFEAd0aO+etW6nPfuJKT2EyHSVeeRBFU/wF0THrxVW5NPzsPkqerzFbd0mJp0JFsVbnT8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hd0nks06; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D27B540E00B2;
	Sun, 31 Mar 2024 10:27:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id yCZs_qkhiZkE; Sun, 31 Mar 2024 10:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711880840; bh=z4kW7JXCRak7Oqlw0w+Wsv9jCFqqLGwmCNv/G0yOFvI=;
	h=Date:From:To:Cc:Subject:From;
	b=hd0nks06WWxp3rGdZ8DeU70azz2L9r9Skh4DKGicBDuBvecuCI35N0HFEcyLRuVUp
	 LPwkUHMjUmhA+UVj6eOtanV6zsZe1vmj1/dpsaDfOKC685/tItNsquFAMq4CevtXtg
	 6Ux0dPFIlTgUPM6JxT6xmqKEK0+anIhw3n/tHTljiBvXE1m/MjdkIIIjbvtP6J/Sqj
	 nEDIqMO3UK7s2CISqgHo2DSqQW7d+Y1O3LJqZbFylcybaDWM1Qv1ZiUuArJvFwyBzg
	 QdrNMyqS0wUfRgfNl1DSx7fFhhHUPsf0/JD+tmFPygPmdaUlffmWtktoothIJGTpns
	 5yg8cxQ4JrgSJudJnPUAmgSSsauSilq8K1MLRGuPQ2TpuwQQpaEr4+KkhCzCfUtykd
	 XZItmkpiYTKcoq5L9WfRj3/xB2EnAOSWs9SMSUya9Xa1RGz+Dp5W+etwtfKZ8dMz+F
	 hEDilUbOjHRJfVTr8/HJSpaZO+uvhXfW3LxBYH0tidBW8KMCswkXcCaRjMycko4orC
	 GDlbY99FqksLc9TjuuwnIPhyVbPl/h8gvAxd2NFIuv4hfikItajJ8Js9lJr51kC/4m
	 PCNkyjqlYlVG1cjBugIRjZGRg6blUPwX4/uBz7a1iYjcSaFdQN4OnC0SCZh/RJuvmb
	 YCuCyv+4q7E85qPQsfQqLph0=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D3B3A40E0028;
	Sun, 31 Mar 2024 10:27:17 +0000 (UTC)
Date: Sun, 31 Mar 2024 12:27:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v6.9-rc2
Message-ID: <20240331102711.GAZgk6f8mOWJiFN8pR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single objtool urgent fix for v6.9-rc2.

Thx.

---

The following changes since commit 486291a0e6246364936df1ecd64c90affef4b9c5:

  Merge tag 'drm-fixes-2024-03-30' of https://gitlab.freedesktop.org/drm/kernel (2024-03-29 15:51:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.9_rc2

for you to fetch changes up to 6205125bd326ed0153e5f9da3c4689fe60ae885a:

  objtool: Fix compile failure when using the x32 compiler (2024-03-30 22:12:37 +0100)

----------------------------------------------------------------
- Fix a format specifier build error in objtool during an x32 build

----------------------------------------------------------------
Mikulas Patocka (1):
      objtool: Fix compile failure when using the x32 compiler

 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

