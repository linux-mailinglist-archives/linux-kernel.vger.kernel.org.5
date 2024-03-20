Return-Path: <linux-kernel+bounces-108570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6309A880C59
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023951F212F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6802C698;
	Wed, 20 Mar 2024 07:48:39 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E310E2231C;
	Wed, 20 Mar 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920918; cv=none; b=JhSuh/VrFFrtsP5QBJZiXyj7tW9u3EbwSw72SKlM5X8IPktHymibfIIH3ZBDHe9K9Do5WFLlNRGF9Ro3ldPWEl1Hf6GbPbK+ugDoUVXFKsgTQ87TughLLVzux8HsusUa9gnSnDqnOw50DsCXYIwbRb1SICv73OHDSjwfmVY8wI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920918; c=relaxed/simple;
	bh=6v51l2BaV+t4HJloO9qBHphewQnPu0qnDnrMTLpEHjk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g9+s4TYPJCI9lPEyEGZfLBrmWbgKAV7/FEB5EYkzKhVuSuNqZ8tQDf+A/DeAh+h//VnXBrItehVIFc8Tjgdu5wGYbj2vTx8zXlkSYNQhEH4BTohhzYl1a2HeM4+LnGMOpKnSoGQjdQNpBwd1OfkCsGssUE6j7o0TpiIYJMVxQ/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id EBA5E140551; Wed, 20 Mar 2024 08:40:01 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org,
	Kenneth Crudup <kenny@panix.com>
Subject: [PATCH 0/5] Fix various races in UCSI
Date: Wed, 20 Mar 2024 08:39:21 +0100
Message-Id: <20240320073927.1641788-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix various races in UCSI code:
- The EVENT_PENDING bit should be cleared under the PPM lock to
  avoid spurious re-checking of the connector status.
- The initial connector change notification during init may be
  lost which can cause a stuck UCSI controller. Observed by me
  and others during resume or after module reload.
- Unsupported commands must be ACKed. This was uncovered by the
  recent change from Jameson Thies that did sent unsupported commands.
- The DELL quirk still isn't quite complete and I've found a more
  elegant way to handle this. A connector change ack _is_ accepted
  on affected systems if it is bundled with a command ack.
- If we do two consecutive resets or the controller is already
  reset at boog the second reset might complete early because the
  reset complete bit is already set. ucsi_ccg.c has a work around
  for this but it looks like an more general issue to me.

NOTE:
As a result of these individual fixes we could think about the
question if there are additional cases where we send some type
of command to the PPM while the bit that indicates its completion
is already set in CCI. And in fact there is one more case where
this can happen: The ack command that clears the connector change
is sent directly after the ack command for the previous command.
It might be possible to simply ack the connector change along with
the first command ucsi_handle_connector_change() and not at the
end. AFAICS the connector lock should protect us from races that
might arise out of this.

Christian A. Ehrhardt (5):
  usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
  usb: typec: ucsi: Check for notifications after init
  usb: typec: ucsi: Ack unsupported commands
  usb: typec: ucsi_acpi: Refactor and fix DELL quirk
  usb: typec: ucsi: Clear UCSI_CCI_RESET_COMPLETE before reset

 drivers/usb/typec/ucsi/ucsi.c      | 56 ++++++++++++++++++++--
 drivers/usb/typec/ucsi/ucsi_acpi.c | 75 +++++++++++++-----------------
 2 files changed, 84 insertions(+), 47 deletions(-)

-- 
2.40.1


