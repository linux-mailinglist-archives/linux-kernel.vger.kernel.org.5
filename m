Return-Path: <linux-kernel+bounces-87267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5E486D1E6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D82C1F22B91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4602378289;
	Thu, 29 Feb 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="feqEOwGg"
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96278261
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230708; cv=none; b=T1vrMzFhW8mJo6fJv79VGzSFAfH39NeklkVeWhg2A4lqKzXCjo0+VAA9+GH19hQJjwgjLsU6aTubRYg9ayJqIV+aZ5FuUdzKdOm5ttpHaMqMbZmZv2Ei/Vg1qKh7AeDROwT62IkymUEU+GDYLFdHPJd2fcqC4j3zYqvXf+h/lNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230708; c=relaxed/simple;
	bh=FnDnPP7Y9XQwoylss8G5T67X/FVEG5s4Rcpw8ybX4Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SEgYHwH3fu9M/QruZPGwGM/6Ghtc4EpHDgL63TDyShRyo49bbbkPw+p4Zml4xcfMdIbAnRL9VSzdXEnxxuuqNfUVy+hJJ+arkr4mgmWoszc3SbLtPNauzBfhYA+2taBHIih+YG560lsn48+F4XoIKKqQnCQma+W0b6xHwp5+mPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=feqEOwGg; arc=none smtp.client-ip=84.16.66.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Tlzx26Grtzbjw;
	Thu, 29 Feb 2024 19:18:14 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Tlzx22tb3z3f;
	Thu, 29 Feb 2024 19:18:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709230694;
	bh=FnDnPP7Y9XQwoylss8G5T67X/FVEG5s4Rcpw8ybX4Gg=;
	h=From:To:Cc:Subject:Date:From;
	b=feqEOwGg2Iv1NZObT2SyiKHajiqlnot4568scHg3m89CcsazsxfIz4uDzwadqQH9s
	 jYxn3EckYSIiS0hPurynyy42hLR+eUYNsQhfdo8+VWbPJNr0d6qnJx8o8JfHbaYyj3
	 pIHnXTojevktxGB4/C2S3Xmc6uYmZINC8sLDrDKI=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock fixes for v6.8-rc7
Date: Thu, 29 Feb 2024 19:18:02 +0100
Message-ID: <20240229181802.371558-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR fixes a potential issue when handling inodes with inconsistent
properties.

Please pull these changes for v6.8-rc7.  This commit merged cleanly with
your master branch.  The kernel code has been tested in the latest
linux-next releases since last week.

Regards,
 Mickaël

--
The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc7

for you to fetch changes up to d9818b3e906a0ee1ab02ea79e74a2f755fc5461a:

  landlock: Fix asymmetric private inodes referring (2024-02-26 18:23:53 +0100)

----------------------------------------------------------------
Landlock fix for v6.8-rc7

----------------------------------------------------------------
Mickaël Salaün (1):
      landlock: Fix asymmetric private inodes referring

 security/landlock/fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

