Return-Path: <linux-kernel+bounces-69930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7594985906A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 16:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AD11C216FD
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCE17C6C1;
	Sat, 17 Feb 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m519jL8f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607687C0AE;
	Sat, 17 Feb 2024 15:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708182841; cv=none; b=ryfZYHKLecLhUg8oD2G7Z4swI7y1Jq1+fvrQ04SqrB5vFAkseO2YA2lL96ud2ZDRITMErIvq1iI4oKa6i+3zUzkYMGQv3C4NrWCi2/evrW5PRRDGYMm/aTbz5GhNtFRbJm/jZIhyAPjYyIyV5W2BMpgbtpAhiSkNxoGIbNUUwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708182841; c=relaxed/simple;
	bh=N+7oGJ5SRLTAWb4NVnkQjUjbXXHuDex3ENh+WWZQqmk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z9zPIKjOAxxXxRP21NGpwGql4Q/D/EvXpwnQH6lFmgwA8m4ocKQRkH3hNq4Klx5siviaUDcxA8JdltBS6QGycilMHCJcfCvm6aRDbZbg03AI6xVgUtS7cPa3YcKMReMnz7XAWvXOICOYOwYey5zx7MNS0bAJaclMpWIjql1AZ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m519jL8f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83125C433C7;
	Sat, 17 Feb 2024 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708182840;
	bh=N+7oGJ5SRLTAWb4NVnkQjUjbXXHuDex3ENh+WWZQqmk=;
	h=Date:From:To:Cc:Subject:From;
	b=m519jL8fuZuwCvx/PQY6mlHLF7L4knT6p3gs/IcAxDHOhnhThkDOSX3k4DhdizGCW
	 GoNGSl3uCvCHtamsKU24zOA30K8V6x2/9uIE/IPmJR/fneX97rnKZ9/egXKJcp49nW
	 KQGADznLbKH7H2o+wTcMRGFNuB6IlYkZAZWkav38=
Date: Sat, 17 Feb 2024 16:13:58 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver fixes for 6.8-rc5
Message-ID: <ZdDNNg5Gsxf2uQKh@kroah.com>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc5

for you to fetch changes up to 7be50f2e8f20fc2299069b28dea59a28e3abe20a:

  serial: mxs-auart: fix tx (2024-02-06 14:42:11 +0000)

----------------------------------------------------------------
TTY/Serial fixes for 6.8-rc5

Here are 3 small tty and serial driver fixes for 6.8-rc5:
  - revert a 8250_pci1xxxx off-by-one change that was incorrect
  - 2 changes to fix the transmit path of the mxs-auart driver, fixing a
    regression in the 6.2 release

All of these have been in linux-next for over a week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      serial: 8250_pci1xxxx: partially revert off by one patch

Jiri Slaby (SUSE) (2):
      serial: core: introduce uart_port_tx_flags()
      serial: mxs-auart: fix tx

 drivers/tty/serial/8250/8250_pci1xxxx.c |  2 +-
 drivers/tty/serial/mxs-auart.c          |  5 ++++-
 include/linux/serial_core.h             | 32 +++++++++++++++++++++++++++-----
 3 files changed, 32 insertions(+), 7 deletions(-)

