Return-Path: <linux-kernel+bounces-51303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C7184890B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE892843C7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376D7134AE;
	Sat,  3 Feb 2024 21:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QWGCiAMH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4311188
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 21:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706997010; cv=none; b=m6XlWROqJiGedLOc08fbBZEYn5QHv+IGksm7db4skJFW98GdkgYjWbO3fzfdmhXbBwP2CTta4wnnIkj3YSPe/nF2hSoUoElJ+HZW3PuplXf/bQkrp+6lHZNDDhuvrenMUVsclFvAozmT5ypN53OPi97ZSMhWtJOtloWKeMTTyQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706997010; c=relaxed/simple;
	bh=TPT4TKuq67fz41FFSi7tbq/va+wMZZammdD/Tm0LWQI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dDXMxhWMAQHkIXqwii1mhulu1/g/FIlAggjHWqIo3bhLklaxNxDKnwKmoL9oQFoGNjzy/IViAypKwlm35e8qCxNJ17CfoX78I04eB9bI3+MrqEHFEj9nri2dpJrucRRgtOLcl9GulcbHQbOrGvVfyJyWt9CPCs+zxGYyCFcMKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QWGCiAMH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E825FC433F1;
	Sat,  3 Feb 2024 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706997010;
	bh=TPT4TKuq67fz41FFSi7tbq/va+wMZZammdD/Tm0LWQI=;
	h=Date:From:To:Cc:Subject:From;
	b=QWGCiAMHMOsonCax3xjcLFHCWQzgly2f4nzRhwe8VaSbjtxE3i/s8NmmxnA8deB4K
	 s/bfbhbWN0BEb3hTQDefZVf74kLqZaHaF3L3hrBth7aRPCAtuiDTmlYw+bBKjcNGv3
	 bMl3eQjOQHu0u0XcoXzboQVWV53WY7na9UrsGXzI=
Date: Sat, 3 Feb 2024 13:50:09 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 6.8-rc3
Message-ID: <Zb61EW7GkqldLC7b@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:

  Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-6.8-rc3

for you to fetch changes up to 97830f3c3088638ff90b20dfba2eb4d487bf14d7:

  binder: signal epoll threads of self-work (2024-01-31 14:08:28 -0800)

----------------------------------------------------------------
Char/Misc driver fixes for 6.8-rc3

Here are three tiny driver fixes for 6.8-rc3.  They include:
  - Android binder long-term bug with epoll finally being fixed
  - fastrpc driver shutdown bugfix
  - open-dice lockdep fix

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Carlos Llamas (1):
      binder: signal epoll threads of self-work

Ekansh Gupta (1):
      misc: fastrpc: Mark all sessions as invalid in cb_remove

Will Deacon (1):
      misc: open-dice: Fix spurious lockdep warning

 drivers/android/binder.c | 10 ++++++++++
 drivers/misc/fastrpc.c   |  2 +-
 drivers/misc/open-dice.c |  2 +-
 3 files changed, 12 insertions(+), 2 deletions(-)

