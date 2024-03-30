Return-Path: <linux-kernel+bounces-125724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A803892B31
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 13:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A263B2147B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C95383A5;
	Sat, 30 Mar 2024 12:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZlR1Q+yO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AD93717B;
	Sat, 30 Mar 2024 12:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711801556; cv=none; b=POt1aFf+IfZbu8zcdQgpoAGI7rhKf81N0M07DnDVLhUyB154egc7AkiXGymo3rTAQKUc8Dpoc8ZoNn/Zu/A5QQk5pBUiKnKajQWYzs4YpzAuhBc/KkZ/CG1KG+gUA1dBjkJCyn3a+dOu0vk5tS3pLE29cpfRyW4QX0Zki7WDGAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711801556; c=relaxed/simple;
	bh=0XRUml01rr7gdHFQJBRFu9sqyJtGjnt+AjcaOvI9Ow8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C6I8YTMQnisk+3LeAnpMitXysplAT0izwqyV0uAiZwy19sFscdI9ghhAG+EtbfguT97VG40Iuq718Mb3sFkCP0r+c+eO15uvN9Nulwl8arbkrTA4Z+C1aQPawlsfA01Vnf3sJ3dBOvLao+f5l/xivTy26mKE/qnN/2M814NjETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZlR1Q+yO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495B6C433C7;
	Sat, 30 Mar 2024 12:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711801555;
	bh=0XRUml01rr7gdHFQJBRFu9sqyJtGjnt+AjcaOvI9Ow8=;
	h=Date:From:To:Cc:Subject:From;
	b=ZlR1Q+yOMTjd7fPLYM4LhKvc/1peFbyPEG55fMuO2wroER6jqsmWkPa5ePWvFoRsM
	 PQDs1u/qi/DRhKfK7AwRBDRvp7tU3O47koQrQ3nAmg7gQ4MOImuxDb/qEBSSro9Unw
	 1YhEywWTlFygFAg1nzkIcmEfHU5FZw7ANjbpv/DU=
Date: Sat, 30 Mar 2024 13:25:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.9-rc2
Message-ID: <ZggE0HwcSJTQzE0D@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.9-rc2

for you to fetch changes up to f4d1960764d8a70318b02f15203a1be2b2554ca1:

  USB: core: Fix deadlock in port "disable" sysfs attribute (2024-03-26 15:02:28 +0100)

----------------------------------------------------------------
USB Fixes for 6.9-rc2

Here are a bunch of small USB fixes for reported problems and
regressions for 6.9-rc2.  Included in here are:
  - deadlock fixes for long-suffering issues
  - USB phy driver revert for reported problem
  - typec fixes for reported problems
  - duplicate id in dwc3 dropped
  - dwc2 driver fixes
  - udc driver warning fix
  - cdc-wdm race bugfix
  - other tiny USB bugfixes

All of these have been in linux-next this past week with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (3):
      USB: core: Fix deadlock in usb_deauthorize_interface()
      USB: core: Add hub_get() and hub_put() routines
      USB: core: Fix deadlock in port "disable" sysfs attribute

Alexander Stein (1):
      Revert "usb: phy: generic: Get the vbus supply"

Christian A. Ehrhardt (5):
      usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
      usb: typec: ucsi: Check for notifications after init
      usb: typec: ucsi: Ack unsupported commands
      usb: typec: ucsi_acpi: Refactor and fix DELL quirk
      usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

Heikki Krogerus (1):
      usb: dwc3: pci: Drop duplicate ID

Jameson Thies (1):
      usb: typec: ucsi: Check capabilities before cable and identity discovery

Krishna Kurapati (1):
      usb: typec: ucsi: Fix race between typec_switch and role_switch

Kyle Tso (3):
      usb: typec: tcpm: Correct port source pdo array in pd_set callback
      usb: typec: tcpm: Update PD of Type-C port upon pd_set
      usb: typec: Return size of buffer if pd_set operation succeeds

Minas Harutyunyan (5):
      usb: dwc2: host: Fix hibernation flow
      usb: dwc2: host: Fix remote wakeup from hibernation
      usb: dwc2: host: Fix ISOC flow in DDMA mode
      usb: dwc2: gadget: Fix exiting from clock gating
      usb: dwc2: gadget: LPM flow fix

Oliver Neukum (1):
      usb: cdc-wdm: close race between read and workqueue

Thinh Nguyen (1):
      usb: dwc3: Properly set system wakeup

Weitao Wang (1):
      USB: UAS: return ENODEV when submit urbs fail with device not attached

Xu Yang (1):
      usb: typec: tcpm: fix double-free issue in tcpm_port_unregister_pd()

Yongzhi Liu (1):
      usb: misc: ljca: Fix double free in error handling path

yuan linyu (1):
      usb: udc: remove warning when queue disabled ep

 drivers/usb/class/cdc-wdm.c         |  6 ++-
 drivers/usb/core/hub.c              | 23 +++++++---
 drivers/usb/core/hub.h              |  2 +
 drivers/usb/core/port.c             | 38 ++++++++++++++--
 drivers/usb/core/sysfs.c            | 16 +++++--
 drivers/usb/dwc2/core.h             | 14 ++++++
 drivers/usb/dwc2/core_intr.c        | 72 +++++++++++++++++++----------
 drivers/usb/dwc2/gadget.c           | 10 +++++
 drivers/usb/dwc2/hcd.c              | 49 ++++++++++++++++----
 drivers/usb/dwc2/hcd_ddma.c         | 17 ++++---
 drivers/usb/dwc2/hw.h               |  2 +-
 drivers/usb/dwc2/platform.c         |  2 +-
 drivers/usb/dwc3/core.c             |  2 +
 drivers/usb/dwc3/core.h             |  2 +
 drivers/usb/dwc3/dwc3-pci.c         |  2 -
 drivers/usb/dwc3/gadget.c           | 10 +++++
 drivers/usb/dwc3/host.c             | 11 +++++
 drivers/usb/gadget/udc/core.c       |  4 +-
 drivers/usb/misc/usb-ljca.c         | 22 ++++-----
 drivers/usb/phy/phy-generic.c       |  7 ---
 drivers/usb/storage/uas.c           | 28 ++++++------
 drivers/usb/typec/class.c           |  7 ++-
 drivers/usb/typec/tcpm/tcpm.c       |  6 +--
 drivers/usb/typec/ucsi/ucsi.c       | 90 +++++++++++++++++++++++++++++--------
 drivers/usb/typec/ucsi/ucsi.h       |  5 ++-
 drivers/usb/typec/ucsi/ucsi_acpi.c  | 71 +++++++++++++----------------
 drivers/usb/typec/ucsi/ucsi_glink.c | 14 ++++++
 27 files changed, 374 insertions(+), 158 deletions(-)

