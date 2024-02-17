Return-Path: <linux-kernel+bounces-69929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D7F859067
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 173B9B20FBC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C97C6C3;
	Sat, 17 Feb 2024 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CBC4Blh5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717837A726;
	Sat, 17 Feb 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182808; cv=none; b=sNWNI3fwx+hymSKg4fDN0u4gy38TcRqSrwm2r/UfV86hK/rnErGQLwVdc2JfB4cC6BGzOpy0u8xNOoshwzXbL8pcFNcfTr5+xSpOQd33Gw2FB90bICcC6Y9OOj2jcT1OX/IDkoaO83iJ9lX3KrM2wF0ewnlhca1jfdXYpyjadW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182808; c=relaxed/simple;
	bh=GnG4gSB9PZheNU8B6ac1pNf6EmgDWkzBzNZVkg7jyiE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OsvxqnVelLMM879Lqg/VthUC+3MkHSGw3d0bM4Guy0W59yR9KqA5R589+KSE/xlM6jFHNrBuuOui5o1qPn7L+TlMvkfUtJFaq7fr0cgIGUQiqxZRVk0tt2Pd2sdPUKs5sURZOCJJ9JK/bYPNOb+MWcuXhs9xudiVJqIQpVQKAYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CBC4Blh5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842CAC433C7;
	Sat, 17 Feb 2024 15:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708182808;
	bh=GnG4gSB9PZheNU8B6ac1pNf6EmgDWkzBzNZVkg7jyiE=;
	h=Date:From:To:Cc:Subject:From;
	b=CBC4Blh5JJc5qcOnDSnrDaMkEOSMLypwiZAsM5J9ycFEqzRFyvOohqT1W58Y4xCsT
	 RQccF+01KPz3avrYQh6/KwPpZy8xkGCDg0NMBbzOUG5qgZ6TC+EvKXmmE8VebzYTkc
	 zKlBbHepHClJXWpyf+R4FYenf1XlhKk20tvnXAsc=
Date: Sat, 17 Feb 2024 16:13:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.8-rc5
Message-ID: <ZdDNFfwclvmprBoR@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc5

for you to fetch changes up to 7d708c145b2631941b8b0b4a740dc2990818c39c:

  Revert "usb: dwc3: Support EBC feature of DWC_usb31" (2024-02-09 10:26:08 +0000)

----------------------------------------------------------------
USB/Thunderbolt fixes for 6.8-rc5

Here are 2 small fixes for 6.8-rc5:
  - thunderbolt to fix a reported issue on many platforms
  - dwc3 driver revert of a commit that caused problems in -rc1

Both of these changes have been in linux-next for over a week with no
reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.8-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Mohammad Rahimi (1):
      thunderbolt: Fix setting the CNS bit in ROUTER_CS_5

Thinh Nguyen (1):
      Revert "usb: dwc3: Support EBC feature of DWC_usb31"

 drivers/thunderbolt/tb_regs.h | 2 +-
 drivers/thunderbolt/usb4.c    | 2 +-
 drivers/usb/dwc3/core.h       | 1 -
 drivers/usb/dwc3/gadget.c     | 6 ------
 drivers/usb/dwc3/gadget.h     | 2 --
 include/linux/usb/gadget.h    | 1 -
 6 files changed, 2 insertions(+), 12 deletions(-)

