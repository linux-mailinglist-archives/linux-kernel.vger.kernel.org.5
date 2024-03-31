Return-Path: <linux-kernel+bounces-126035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B29689313B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89A902827C8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE7584037;
	Sun, 31 Mar 2024 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="T2OQmZU0"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570F583CA6
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711881038; cv=none; b=t3y6+4B9JOpfy9/5nb9KGa35JSm9HkCPO/6aykfBVr/mM/9p6GoMKZA9CwbkZAD5e/DIydqV/s/YRTaESMNvFONJmNbelBHEEKccATym/ucZjJclWmxxOqm1eulekyBIQx5BW/Tejb5PjXFaDDpeQ6sEeSo2npWm5ak0/SvKY0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711881038; c=relaxed/simple;
	bh=3zpgI1Paos9ciLo9HGzztyAnzRRh3nIravi7wdM4Qpo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=edU21uKmAQfZZHqU/6y7bQ9BUu6dK7laT1+ZawhaCl8ENScgwr2VLe6mGUoot9ylSxx4YvHhWAs/Nf7qt5FBvPSq8E9Khl+V3qLfr8EeLa7XxRNbURrn3qHWSVoCol6yb9FdeqiXXTWmUZG7DUOh/59MPasm7LZS9N8LQfNru1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=T2OQmZU0; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 27E3340E0028;
	Sun, 31 Mar 2024 10:30:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CSisdASETqf0; Sun, 31 Mar 2024 10:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711881031; bh=LvPojGx+RycBrf5Jz7MadF0GpXNUwG/7udU95/K0TK0=;
	h=Date:From:To:Cc:Subject:From;
	b=T2OQmZU0+Fj1nMTvOZUnGsiBKScQq2DnuEs+4ZaWuavjWE0biimGhxqK8gVuhHX09
	 lAQQ+IX59th9OsOkpFd7ZJMWu/nhYhOor1pItIhVY4OqV5xKGIVJKJBBBHlK8Ii88j
	 O6AiOXdqpH5qirivjDrJ3zJVR8iDDTSYIsW+fjAH9t8A9bcth55LhPxewc7Cls0A07
	 XozQDWXVQjHZXY3tmdw6jo8+nc5Hx+X6DRPCkHoYvTzsLBqcRYbQqXTPZWhddUdsUe
	 EPXHLTwGs+ViTgtdEqUJCJJHzLDF85ET657jWvZF8kVPGHmgVtYjYNA8qPIO+sImfd
	 gnrqMFtJm5WnaXqO2lbIQtFsNmhfFZQD5cLEppml6LdUu6hd/PtUXzZlGZHJ20NJTG
	 7tyHcKOuSKavrtvzFYj/qiNjGO+aYKzOZaUgZQZIra/RMhIN8Uph6/IDxgD8PkI0Cb
	 J+QWcxIKQ+locsaOB3owgR3Z8nOSUW3c2j6og5wVMSYzb6CIunQliDK2oYE2tg0+SI
	 wVVMzleXiWT6vcl3FzFyONpgYp+AnwecBN3H/r+uy3dTrIkXeK42Y+g46VTb9O8PT6
	 uu2b4HNApHpLFsB0yrxeKt3WZmTza2bl1Tx6peACBAg8mj+ckAtecgVGDE+pXp5obF
	 hRbqb63dK2S4N2Sptq7Y/dKY=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8C81040E00B2;
	Sun, 31 Mar 2024 10:30:28 +0000 (UTC)
Date: Sun, 31 Mar 2024 12:30:27 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.9-rc2
Message-ID: <20240331103027.GAZgk7Q5vR6nlYkmm8@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent timers fix for v6.9-rc2 so that tglx can relax
more. :-P

Thx.

---

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.9_rc2

for you to fetch changes up to 1fed2f1ea62aa79e8c1df79b26e5bf5c8cf45065:

  MAINTAINERS: Add co-maintainers for time[rs] (2024-03-27 14:48:11 +0100)

----------------------------------------------------------------
- Volunteer in Anna-Maria and Frederic as timers co-maintainers

----------------------------------------------------------------
Thomas Gleixner (1):
      MAINTAINERS: Add co-maintainers for time[rs]

 MAINTAINERS | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

