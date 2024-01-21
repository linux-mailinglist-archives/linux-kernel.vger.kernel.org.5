Return-Path: <linux-kernel+bounces-32184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBA488357C6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B821C1C20D78
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D403438DD3;
	Sun, 21 Jan 2024 20:41:42 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CC0381A9;
	Sun, 21 Jan 2024 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705869702; cv=none; b=pzZJ8DUXSKeM2a1K3SVm2nMEevWEB1StrXB8wjLti3pAZpNfttKtf2bx0a9uKauiZcFWpzar6uUHjKR8iX2W4csgjCBBNVH2wO8eFvZXjbh8Qd94g/iaSo+omOXaSLzQV5vbGiK82LsQtyP32M3kCGOQIY9ccJDyl63XPtriXnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705869702; c=relaxed/simple;
	bh=A1sAifn2sBFzYOkWtoxj0vCZieiNpW4Rdqd4QI70m+E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l97Vdgn7WQ5ECaM2ovzuln5+6TmLHFJ4GQGLeM0WGOeEinW8bx94rsuJl6BtvtnSUoL58epl6MQ7GDF7LTmeoYBll9JWm8FhkZ8bIHGltJqEWlHBqTGaBMURBBv7QUspfhrDSs/rN4P0ldWIIg0p/dk+saNMUa86Db8AxE+yW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 1D1C01401CF; Sun, 21 Jan 2024 21:41:37 +0100 (CET)
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
Subject: [PATCH v3 0/3] UCSI fixes
Date: Sun, 21 Jan 2024 21:41:20 +0100
Message-Id: <20240121204123.275441-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This small series contains two general bugfixes to ucsi_acpi
and a quirk to make the UCSI controller on various Dell laptops
work. The changes can be applied idependently but all three
are required to fix the Dell issues.

For details on the general bugfixes please refer to the individual
commit messages.

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
probably be applied to on Dell systems.

To mitigate potential problems from this dell quirk includes a
probe mechanism that detect the need for the quirk once and we
only deviate from the UCSI spec if the quirk is actually required.

Changes in v3 from v2:
- Add an info message if the quirk is enabled.
- Fix checkpatch errors etc.
- Add Fixes: and CC: stable.

Changes in v2 from v1:
- Add a second general bugfix.
- Remove module parmater and generic quirk infrastructure.
- Implement quirk directly in ucsi_acpi.c
- Add probe logic to reliably detect the need for the quirk 

Christian A. Ehrhardt (3):
  usb: ucsi: Add missing ppm_lock
  usb: ucsi_acpi: Fix command completion handling
  usb: ucsi_acpi: Quirk to ack a connector change ack cmd

 drivers/usb/typec/ucsi/ucsi.c      |  2 +
 drivers/usb/typec/ucsi/ucsi_acpi.c | 86 +++++++++++++++++++++++++++---
 2 files changed, 81 insertions(+), 7 deletions(-)

-- 
2.40.1


