Return-Path: <linux-kernel+bounces-97390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92B38769EE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62018B20C39
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 17:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9073E4C627;
	Fri,  8 Mar 2024 17:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jeLcoHp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC9D28DAE;
	Fri,  8 Mar 2024 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709918986; cv=none; b=FB5XVOfwAilaoNEiu99X1xPKwDaCQvBOMlwXvZW17h2fTGRhkE5/yxUb5OUCc560+mEtXMMa+NGhkN5ehpLEHGqr4pdG711wb16GddB6N3yLee9z3PaUAlFpMhT40MSbp3jFQ/RrX+BmHoTI9vFt7hfVF5Ibct40KuGwIvvarro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709918986; c=relaxed/simple;
	bh=iuKd7BJCZde3rcVymwHNOdzVrzk9Y9A/nmtw093sWLs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Z20ZqBpN4p5Q/hkq3td9/FB8Vq4DyNhO/IXpRRBT0B1Vb5mNI+vG9bmwc+G0xS0fS6himSzDXbCrmnLs5gNQ7/cua4PpP3TcbqsVTpgtIspGW0KFsYa7aMMSbJ6PkL+x12uQts59Ojl1D200DbY6Qa2pYUUBl6x8ScM14txm2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jeLcoHp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B283AC433F1;
	Fri,  8 Mar 2024 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709918986;
	bh=iuKd7BJCZde3rcVymwHNOdzVrzk9Y9A/nmtw093sWLs=;
	h=Date:From:To:Cc:Subject:From;
	b=2jeLcoHp/Hw7n2ScOxtQ53yPVWPgJ0G/T32fHwopai0qdXc5P9JMbRIAIxta2W+/8
	 tg23Ig4WOzaG2acN392GnbSlsgf6xb9N0//+ogbt4Z+IyAMUGeMPbT403xfhQiuRwH
	 Z+bhryRhefUz/+wXQQPYoc+fj38HgZLuU5DjSrPE=
Date: Fri, 8 Mar 2024 17:29:43 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt driver fixes for 6.8-rc8
Message-ID: <ZetLB2-_00QyZZJs@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc8

for you to fetch changes up to b234c70fefa7532d34ebee104de64cc16f1b21e4:

  xhci: Fix failure to detect ring expansion need. (2024-03-05 13:47:08 +0000)

----------------------------------------------------------------
USB / Thunderbolt fixes for 6.8-rc8 (or -final)

Here are some small remaining fixes for USB and Thunderbolt drivers for
6.8-rc8.  Included in here are fixes for:
  - thunderbold NULL dereference fix
  - typec driver fixes
  - xhci driver regression fix
  - usb-storage divide-by-0 fix
  - ncm gadget driver fix

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (1):
      USB: usb-storage: Prevent divide-by-0 error in isd200_ata_command

Badhri Jagan Sridharan (1):
      usb: typec: tpcm: Fix PORT_RESET behavior for self powered devices

Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.8-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Krishna Kurapati (1):
      usb: gadget: ncm: Fix handling of zero block length packets

Mathias Nyman (2):
      usb: port: Don't try to peer unused USB ports based on location
      xhci: Fix failure to detect ring expansion need.

Mika Westerberg (1):
      thunderbolt: Fix NULL pointer dereference in tb_port_update_credits()

Neil Armstrong (1):
      usb: typec: ucsi: fix UCSI on SM8550 & SM8650 Qualcomm devices

RD Babiera (1):
      usb: typec: altmodes/displayport: create sysfs nodes as driver's default device attribute group

 drivers/thunderbolt/switch.c             |  3 +++
 drivers/usb/core/port.c                  |  5 +++--
 drivers/usb/gadget/function/f_ncm.c      |  2 +-
 drivers/usb/host/xhci-ring.c             |  8 +++++++-
 drivers/usb/storage/isd200.c             | 23 ++++++++++++++++++-----
 drivers/usb/typec/altmodes/displayport.c | 18 +++++++++---------
 drivers/usb/typec/tcpm/tcpm.c            |  7 +++++--
 drivers/usb/typec/ucsi/ucsi_glink.c      |  1 +
 8 files changed, 47 insertions(+), 20 deletions(-)

