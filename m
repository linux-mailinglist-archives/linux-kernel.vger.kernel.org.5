Return-Path: <linux-kernel+bounces-51302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5827C848908
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE5C1F23311
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 21:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81FF4134C6;
	Sat,  3 Feb 2024 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IvFBwbuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA93D168C4;
	Sat,  3 Feb 2024 21:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706996982; cv=none; b=jNm9hTFi+uWbV66Ud6en59lOrCQ7BxCcuO9ej2tJCe2mV2bDp+yPLbA6OVeNnIswr2RihEX9XE+x/b9IClUJZQcgyPx93K8bXAdxYYKlgLhgm6xkHQYS1V2Lgih0YZDEU/vPSjgEAskSbdvR+uAADMhsdhZqEq5jSQXAJlf3YBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706996982; c=relaxed/simple;
	bh=CWvjXeV56RYSKT++CeZK3nd8uP5aO9tEw9qI4EYECqw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=da+4HX4UWmm1Uy/wgSh4amc5yJqm68rP7PEz8jAuPx/SL4BkG3cKckWvhCzuM9IuqbnTWQ35fxJTcH9rXA1gBcxu0drlB3rad1Ad+cbit4rFo3gBBN4Kmu7qHkeyrDOgi5Nc/BGdWHTQ6NuN61GZAwj54J20JxXuSSn8fpeEfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IvFBwbuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31077C433F1;
	Sat,  3 Feb 2024 21:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706996982;
	bh=CWvjXeV56RYSKT++CeZK3nd8uP5aO9tEw9qI4EYECqw=;
	h=Date:From:To:Cc:Subject:From;
	b=IvFBwbuNwIp5d4zZsCkjva1NviktZAilU8hHma2/9ukkz+Sz/ujPi6Fwy3bsV3m5K
	 qL26peO0k8UKQGnNH/RgqHSWN9tsuKVWaPWIst5bBW5ro3gQLu6T1/jagZYOOla1X0
	 YEYTtEcWlZmbK2aDX954vXaHAWkvjqaeJh8GibS8=
Date: Sat, 3 Feb 2024 13:49:41 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.8-rc3
Message-ID: <Zb609YTmtyjUEwhc@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc3

for you to fetch changes up to b35f8dbbce818b02c730dc85133dc7754266e084:

  serial: max310x: prevent infinite while() loop in port startup (2024-01-27 19:09:10 -0800)

----------------------------------------------------------------
TTY/Serial driver fixes for 6.8-rc3

Here are some small tty and serial driver fixes for 6.8-rc3 that resolve
a number of reported issues.  Included in here are:
  - rs485 flag definition fix that affected the user/kernel abi in -rc1
  - max310x driver fixes
  - 8250_pci1xxxx driver off-by-one fix
  - uart_tiocmget locking race fix

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Christoph Niedermaier (1):
      tty: serial: Fix bit order in RS485 flag definitions

Dan Carpenter (1):
      serial: 8250_pci1xxxx: fix off by one in pci1xxxx_process_read_data()

Gui-Dong Han (1):
      serial: core: Fix atomicity violation in uart_tiocmget

Hugo Villeneuve (4):
      serial: max310x: set default value when reading clock ready bit
      serial: max310x: improve crystal stable clock detection
      serial: max310x: fail probe if clock crystal is unstable
      serial: max310x: prevent infinite while() loop in port startup

 drivers/tty/serial/8250/8250_pci1xxxx.c |  4 +--
 drivers/tty/serial/max310x.c            | 53 ++++++++++++++++++++++++++-------
 drivers/tty/serial/serial_core.c        |  2 +-
 include/uapi/linux/serial.h             | 13 ++++----
 4 files changed, 53 insertions(+), 19 deletions(-)

