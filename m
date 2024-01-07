Return-Path: <linux-kernel+bounces-18742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C63826276
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E153B21C3C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E54A15A2;
	Sun,  7 Jan 2024 00:17:48 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C897EC;
	Sun,  7 Jan 2024 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 9BC681402B8; Sun,  7 Jan 2024 01:17:41 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Make UCSI on Dell Latitude work
Date: Sun,  7 Jan 2024 01:16:57 +0100
Message-Id: <20240107001701.130535-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UCSI interface on a Dell Latitude 5431 stops working after
the first async event with:

    GET_CONNECTOR_STATUS failed (-110)

The core problem is that when sending the ACK_CC_CI command to
clear the connector status changed condition the PPM expects us
to send anothr ack for the command completion condition. However,
the UCSI spec states that no ack for the command completion is
required when the command is ACK_CC_CI (or PPM_RESET).

There are various reports that suggest that several Dell laptops
are affected by this problem. E.g. the kernel bugzilla has this
report which is most likely an instance of this bug:

    https://bugzilla.kernel.org/show_bug.cgi?id=216426

This led me to the somewhat bold conclusion that the quirk should
probably be applied to all Dell systems. However, I'm open to
suggestions on how to proceed with this.

While debugging another issue was found that is present for all systems
but only triggered with the quirk active: The ACK_CC_CI command
to ack the connector status change is sent without any lock which
allows for a race where this command is sent while another command
is currently in progress.

The series consists of 4 changes:
- Add the missing lock around ucsi_acknowledge_connector_change.
  This change is a generic bugfix.
- Add infrastructure for quirks and a quirk override module parameter
  to the typec_ucsi module. There's at least one other change in the
  works that wants something similar here:
    https://lore.kernel.org/all/20231023215327.695720-2-dmitry.baryshkov@linaro.org/
  Additionally, doing the dell quirk is a bit easier in the gereric
  UCSI code. The module parameter will allow users to fix things if
  the DMI matching goes wrong. Additionally, we can easily ask users
  to test different quirks without the need to recompile.
- Actually add the required quirk to ucsi.c.
- Finally, refactor DMI matching in ucsi_acpi.c and enable the new
  quirk for all DELL systems. The latter is kind of bold and I'm open
  to suggestings on how to proceed here.
  I'm CC'ing Dell.Client.Kernel@dell.com because this seems to be a
  list where Dell people are that might be able to provide more
  insight on this.

Christian A. Ehrhardt (4):
  usb: ucsi: Add quirk infrastructure
  usb: ucsi: Add missing ppm_lock
  usb: ucsi: Quirk to ack a connector change ack cmd
  usb: ucsi: Apply UCSI_ACK_CONNECTOR_CHANGE_ACK_CMD to DELL systems

 .../admin-guide/kernel-parameters.txt         |  5 +++
 drivers/usb/typec/ucsi/ucsi.c                 | 21 ++++++++-
 drivers/usb/typec/ucsi/ucsi.h                 |  7 ++-
 drivers/usb/typec/ucsi/ucsi_acpi.c            | 45 ++++++++++++++++---
 drivers/usb/typec/ucsi/ucsi_ccg.c             |  2 +-
 drivers/usb/typec/ucsi/ucsi_glink.c           |  2 +-
 drivers/usb/typec/ucsi/ucsi_stm32g0.c         |  2 +-
 7 files changed, 73 insertions(+), 11 deletions(-)

-- 
2.40.1


