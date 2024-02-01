Return-Path: <linux-kernel+bounces-48472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 617D4845C79
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED631F2C8F6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C3A626A9;
	Thu,  1 Feb 2024 16:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgUDac1H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C6262174;
	Thu,  1 Feb 2024 16:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706803666; cv=none; b=n60zGgLrGPpQ0ayhfgo0GqD6aJbBzc47qkF16e7mQZIvg4wmOO7exPCyJrALtpIGDlwCQcVAZE7n+lUDDyRYu2PxM8/IrnGOAxokfQoG4IDoeScDFptnlRm7FyAwDgNG2/YsipjO2j+xme5YlDppB29RKy4fyGgGV8pROZ1yD4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706803666; c=relaxed/simple;
	bh=r1jaUwoxglsNWHO60/roArWTIt/rqzl1LuZUFI7RDn8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RGMzWyk8KZoS2J5NM/Pm6TQ5HxjfGkP7sYbN8eGhclsDwZOi74F2VNfKWIjZuo8/R0c2P69ywui8Yhm/sMbHnOituc6WSLQthoc+/6/5yyowLwfLxcgo5RU9G5ZqVyKTyX01ZCuhLyLoy/br+mfH4ohfQcxhfdSzoso2OEqQ0BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgUDac1H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D4CC433C7;
	Thu,  1 Feb 2024 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706803665;
	bh=r1jaUwoxglsNWHO60/roArWTIt/rqzl1LuZUFI7RDn8=;
	h=Date:From:To:Subject:From;
	b=lgUDac1HbGZn4Hy7F5lK+7fOirRp07h3tY7J9GX0gUjg8IxoPrbH4n7QTJ1dnS8Sx
	 SHq1lgiOoyBLz1b1kOLE8iObWPcBNs0MeaXFYJB8S5qiQia52nkJ2hpjBoOvy5SY4s
	 hNTbMc/Up8hR3I8lxL7TJxUK5e7vUZ0M8kFnAucC3dzNXioqe/JKvNIythlekAnSCT
	 30qYrYguBwsW5mAXNxBbjpS/kkzVZIVcvE98AiO6zz2CqDVdb3d6Y5EY2P7fh0e9p3
	 UtlaDimoKposF0iCxuYwso2b7SVUKK8BJREoS062GTMfzh+EU2Av48uP83xYtxZV2+
	 0WSxF8Cze3HTA==
Date: Thu, 1 Feb 2024 17:07:41 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.8-rc3
Message-ID: <ZbvBzWJ5k5TnpRSW@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull a few important fixes for the parisc architecture for 6.8-rc3:

The current exception handler, which helps on kernel accesses to userspace,
may exhibit data corruption. The problem is that it is not guaranteed that the
compiler will use the processor register we specified in the source code, but
may choose another register which then will lead to silent register- and data
corruption.  To fix this issue we now use another strategy to help the
exception handler to always find and set the error code into the correct CPU
register.

The other fixes are small: fixing CPU hotplug bringup, fix the page alignment
of the RO_DATA section, added a check for the calculated cache stride and fix
possible hangups when printing longer output at bootup when running on serial
console.

Most of the patches are tagged for stable series.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit 8a696a29c6905594e4abf78eaafcb62165ac61f1:

  Merge tag 'platform-drivers-x86-v6.8-2' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2024-01-27 09:48:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.8-rc3

for you to fetch changes up to 913b9d443a0180cf0de3548f1ab3149378998486:

  parisc: BTLB: Fix crash when setting up BTLB at CPU bringup (2024-01-31 13:51:26 +0100)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.8-rc3:

- Fix random data corruption triggered by exception handler
- Fix crash when setting up BTLB at CPU bringup
- Prevent hung tasks when printing inventory on serial console
- Make RO_DATA page aligned in vmlinux.lds.S
- Add check for valid cache stride size

----------------------------------------------------------------
Helge Deller (6):
      parisc: Make RO_DATA page aligned in vmlinux.lds.S
      parisc: Check for valid stride size for cache flushes
      parisc: Prevent hung tasks when printing inventory on serial console
      parisc: Drop unneeded semicolon in parse_tree_node()
      parisc: Fix random data corruption from exception handler
      parisc: BTLB: Fix crash when setting up BTLB at CPU bringup

 arch/parisc/Kconfig                     |  1 -
 arch/parisc/include/asm/assembly.h      |  1 +
 arch/parisc/include/asm/extable.h       | 64 +++++++++++++++++++++++++++++++++
 arch/parisc/include/asm/special_insns.h |  6 ++--
 arch/parisc/include/asm/uaccess.h       | 48 ++++---------------------
 arch/parisc/kernel/cache.c              | 10 ++++--
 arch/parisc/kernel/drivers.c            |  5 ++-
 arch/parisc/kernel/unaligned.c          | 44 +++++++++++------------
 arch/parisc/kernel/vmlinux.lds.S        |  2 +-
 arch/parisc/mm/fault.c                  | 11 ++++--
 10 files changed, 118 insertions(+), 74 deletions(-)
 create mode 100644 arch/parisc/include/asm/extable.h

