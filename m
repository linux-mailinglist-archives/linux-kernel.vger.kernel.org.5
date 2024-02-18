Return-Path: <linux-kernel+bounces-70605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F208599C1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCBF2816DC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130D9745DB;
	Sun, 18 Feb 2024 22:21:12 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF23A71B41;
	Sun, 18 Feb 2024 22:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708294871; cv=none; b=LIv1Da+xY+nagFyKHZe6mOtlU/5pY7kSyWkvhrjqJRNUDKzBxHqZKrvEf9EW9uVFXirkGor/FuJjUtDgcavIR8+1kaaST1bL+CynycbAHaWws+uBC7ArpQAZXfiFWnC2njuvaGAp+iHkwca7dpqVtOZrMWv4MDY3iF2tmSQZvUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708294871; c=relaxed/simple;
	bh=BRwcKCBkoqF12N4ufDpMcCEgTArkJnOd7MPeSkn/5No=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qY3ErrK8Mm8AvLzJA5B8Ui6e28IgUIjf4HxyXlh41EiaUTEUlyg8moSacjmMFmAf/QQixBeydfqUSENf1yFlxYnkD1EDLXMMbPkdXDNnZMu7jP8c3LkuaGay8/5y/TpuuBD4fNwk5OJ+brsvgzgO5Vkyde0LIPpFt+eWYqTpmx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id E5249140229; Sun, 18 Feb 2024 23:21:00 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	Hans de Goede <hdegoede@redhat.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Prashanth K <quic_prashk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	Haotien Hsu <haotienh@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Utkarsh Patel <utkarsh.h.patel@intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Min-Hua Chen <minhuadotchen@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [RFC PATCH 0/6] UCSI backend API refactoring
Date: Sun, 18 Feb 2024 23:20:33 +0100
Message-Id: <20240218222039.822040-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The (new) API for UCSI backends has some problems:

The UCSI spec assumes a mailbox style communication:
1. The OPM fills data (UCSI_MESSAGE_OUT and UCSI_CONTROL)
   into the mailbox memory region. In the ACPI case these are
   simple host memory accesses.
2. The OPM notifies the PPM that a command should be executed.
   In the ACPI case this is a call the _DSM ACPI function.
   Within that function the UCSI_CONTROL and the UCSI_MESSAGE_OUT
   data is transferred to something like the embedded controller
   and then the PPM is notified e.g. by an SMI.
3. The PPM executes the command. As a result UCSI_MESSAGE_IN and
   UCSI_CCI in the mailbox memory are updated and the OPM
   is notified. In the ACPI case the notification is an SCI and
   ACPI provides a handler that syncs UCSI_MESSAGE_IN and
   UCSI_CCI from the EC into host memory before notifying the
   OPM via the ACPI Notify() command.

The major problem is that steps 1 (update mailbox memory) and
step 2 (notify PPM and start command execution) are two different
steps. The current API only knows about a write function that
combines writing to mailbox memory and starting command execution.

This only works as long as the commands do not have arguments
that must be in UCSI_MESSAGE_OUT.

Additionally, Step 3 (at least in the ACPI case) above suggests
that UCSI_CCI and UCSI_MESSAGE_IN should generally be read from
mailbox memory. Except for some special cases the sync operation
via the _DSM-Read function in ACPI is not required and seems to
do more harm then good.

E.g. the zenbook quirks could be avoided if we didn't re-read the
UCSI_CCI and UCSI_MESSAGE_IN data from the embedded controller
on each read operation. The recent fix to the CCG backend seems
to address the same issue.

This change series proposes a new API with the following design
goals:
- Retain the nice features of the previous API redesign. In
  particular the synchronous execution of commands in the
  backend and the ability to handle quirks there.
- The API must still be able to handle all backends (obviously).
  Thus each new API function is currently implemented in all
  backends in the same change.
- Separate writing to mailbox data and starting command execution
  to allow for commands with UCSI_MESSAGE_OUT data.
- Avoid hardware accesses (as opposed to mailbox memory accesses)
  outside of the command execution context as much as possible.
- Avoid use of explicit mailbox offsets (that are subject to
  change with later UCSI revisions) in the UCSI core.

The proposed new API features:
- read_data() and write_data() for access to the message data
  fields. This is supposed to be a pure mailbox access that
  even in the case of a write does not start a command.
- sync_cmd() and async_cmd() to write the command register and
  start command execution.
- A cached version of the current contents of CCI in the core
  UCSI structure. This value is only updated if a notification
  is received from the hardware.
- poll_cci() to force an update of the cached CCI value from
  hardware. This is required to poll for PPM reset completion.

CAVEATs:
- The series will certainly need more polishing etc. before
  it can be accepted. I will do this provided that the series
  is considered a good idea in general.
- The series compiles, passes smatch, sparse and checkpatch but
  I only have ucsi_acpi hardware to test this. The other backends
  (ccg, glink, stm32g0) will need testers and likely some fixes
  as well.

So, what do you think?

Christian A. Ehrhardt (6):
  usb: ucsi_glink: Fix endianness issues
  ucsi_ccg: Cleanup endianness confusion
  usb: typec: ucsi: Make Version a parameter to ucsi_register
  usb: typec: ucsi: Cache current CCI value in struct ucsi
  usb: typec: ucsi: Introdcue ->read_data and ->write_data
  usb: typec: ucsi: Convert a?sync_write to a?sync_cmd

 drivers/usb/typec/ucsi/ucsi.c         |  53 ++++--------
 drivers/usb/typec/ucsi/ucsi.h         |  28 +++---
 drivers/usb/typec/ucsi/ucsi_acpi.c    | 119 ++++++++++++--------------
 drivers/usb/typec/ucsi/ucsi_ccg.c     | 107 ++++++++++++-----------
 drivers/usb/typec/ucsi/ucsi_glink.c   | 104 +++++++++++++++++-----
 drivers/usb/typec/ucsi/ucsi_stm32g0.c |  80 ++++++++++++++---
 6 files changed, 290 insertions(+), 201 deletions(-)

-- 
2.40.1


