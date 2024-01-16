Return-Path: <linux-kernel+bounces-28358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC07982FD40
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 899E7294E36
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B861667C54;
	Tue, 16 Jan 2024 22:41:13 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDC71BF31;
	Tue, 16 Jan 2024 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444873; cv=none; b=oAGlZSl8OZwUwEvzfgWCxF7xJ8oq0xakaryoVADLvtykmjvZr0i2z7i92+4Fx0rGHXENXddvyx9QaqFMJYE2YpCRUe1cAGiizRfi6C6INhPLVacvnjt7oX3x29/vi3Is196ucF2xwZwWL4wRF4J0xbyqKPgs2ayQIYSOT0YtPCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444873; c=relaxed/simple;
	bh=IDDgqgMqyw2E7Xgg9/KdO7AkOipyHB3yv3BBjx3WNQU=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=OEU16+wNnS+8ZzLmhp/FPjM5Rs6jpCrGUssjz63LCZTRaGSZYuTTkiePmLbd6TzHhhZ8pEmQvqjtQ5rI/lz7yvm36kCWW0B4YoSfBV3o+Ec635IgxrE1SwZlqYc/+8C6S9WgZl9cOFt32wXLDtLm4nNVHFAs1NNDTvYmPVPXH9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 3EA3514033C; Tue, 16 Jan 2024 23:41:02 +0100 (CET)
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
Subject: [PATCH 0/3] UCSI fixes
Date: Tue, 16 Jan 2024 23:40:38 +0100
Message-Id: <20240116224041.220740-1-lk@c--e.de>
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
work. The changes can be applied idependantly but all three
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


