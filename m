Return-Path: <linux-kernel+bounces-80083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9B4862A8B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F5F1F215A8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123B214AA7;
	Sun, 25 Feb 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SIbiH+Zd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446C514AA3;
	Sun, 25 Feb 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708869409; cv=none; b=OxytvApW19aDg0NNgdvIzHw87t9nku66EJgf21xsNPdFgyVN3inz9jczwRhhbVJZrM5e1x7v6u2+BMGY57Jd79uBeXsFXHmzfJvab4/5R0G4TS4eH/v78RDnnbEwZUpdvzJlgV8BL7hBaIWV8CTrEMpITwQkHLcXfILmxTwK5LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708869409; c=relaxed/simple;
	bh=eRiacYGs142auxDBgiJEG5vpqq5Rj1hXRktpvD05jIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g7DpaR8Xv/DeIwPPw+9sTkGp5zfSI9X1983Oa5b3kUUgAPx66Nt5L0fPLCfxXDdM/JXiKIcl+SpSKp+RpRmpSSZFUPKrnhJ8s1RtPCCEsagMF8kniW2AnNMOpKIm6Z2PaIhzymjHTng0veIJ8+gBacrz78D4wJbdwF+hD81NYtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SIbiH+Zd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D530C433C7;
	Sun, 25 Feb 2024 13:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708869408;
	bh=eRiacYGs142auxDBgiJEG5vpqq5Rj1hXRktpvD05jIc=;
	h=Date:From:To:Cc:Subject:From;
	b=SIbiH+Zdz/lRFwIz4JFwOOCyS4YIL7FUAJFJJoy43LkdnDnySaUW/4AQ5fg1jBDbZ
	 4vsNxykRWaj/b3JSR622iRg10DVm5JM1g97kHpQFYbPhScI34m1xlDC6yDaD3KNMN1
	 uxJQDmQpuk2tiEyFmhr9bHEWtgIwl0bXxOuMQvO0=
Date: Sun, 25 Feb 2024 14:56:46 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.8-rc6
Message-ID: <ZdtHHn2s9ksLd9zT@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.8-rc6

for you to fetch changes up to 69f89168b310878be82d7d97bc0d22068ad858c0:

  usb: typec: tpcm: Fix issues with power being removed during reset (2024-02-20 09:14:36 +0100)

----------------------------------------------------------------
USB fixes for 6.8-rc6

Here are some small USB fixes for 6.8-rc6 to resolve some reported
problems.  These include:
  - regression fixes with typec tpcm code as reported by many
  - cdnsp and cdns3 driver fixes
  - usb role setting code bugfixes
  - build fix for uhci driver
  - ncm gadget driver bugfix
  - MAINTAINERS entry update

All of these have been in linux-next all week with no reported issues
and there is at least one fix in here that is in Thorsten's regression
list that is being tracked.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Aaro Koskinen (1):
      usb: gadget: omap_udc: fix USB gadget regression on Palm TE

Andreas Larsson (1):
      usb: uhci-grlib: Explicitly include linux/platform_device.h

Frank Li (2):
      usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
      usb: cdns3: fix memory double free when handle zero packet

Guenter Roeck (1):
      MAINTAINERS: Drop myself as maintainer of TYPEC port controller drivers

Krishna Kurapati (1):
      usb: gadget: ncm: Avoid dropping datagrams of properly parsed NTBs

Mark Brown (1):
      usb: typec: tpcm: Fix issues with power being removed during reset

Ondrej Jirman (1):
      Revert "usb: typec: tcpm: reset counter when enter into unattached state after try role"

Pawel Laszczak (2):
      usb: cdnsp: blocked some cdns3 specific code
      usb: cdnsp: fixed issue with incorrect detecting CDNSP family controllers

Thinh Nguyen (1):
      usb: dwc3: gadget: Don't disconnect if not started

Xu Yang (2):
      usb: roles: fix NULL pointer issue when put module's reference
      usb: roles: don't get/set_role() when usb_role_switch is unregistered

 MAINTAINERS                         |  3 +--
 drivers/usb/cdns3/cdns3-gadget.c    |  8 ++++++--
 drivers/usb/cdns3/core.c            |  1 -
 drivers/usb/cdns3/drd.c             | 13 +++++++++----
 drivers/usb/cdns3/drd.h             |  6 +++++-
 drivers/usb/cdns3/host.c            | 16 ++++++++++++++--
 drivers/usb/dwc3/gadget.c           |  5 +++++
 drivers/usb/gadget/function/f_ncm.c | 10 +++++++++-
 drivers/usb/gadget/udc/omap_udc.c   |  3 ++-
 drivers/usb/host/uhci-grlib.c       |  1 +
 drivers/usb/roles/class.c           | 29 +++++++++++++++++++++--------
 drivers/usb/typec/tcpm/tcpm.c       |  6 ++----
 12 files changed, 75 insertions(+), 26 deletions(-)

