Return-Path: <linux-kernel+bounces-68962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DAB858298
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776561F21DE6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EE412FB1E;
	Fri, 16 Feb 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CCt+eSyw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE75944369;
	Fri, 16 Feb 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708101184; cv=none; b=YqmJJbz3Rspe1XnKfsdI0AMrr/70ZVFt3IOrPv8Mj7iW9KBQVaZyUBHcb3Tbdg4Wth73m8Z75MDj935AEsTYrCWBR7RgWs1foIB+TaPtqajs/GsWcEAzXlMX77++11jtfiwaZlEPyAok1ThjtZvVUcH6oMgzBC9f8UKAK1vKwYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708101184; c=relaxed/simple;
	bh=Of7v1GxhPAmcslNCv2upPf4LImqPPOW1O8gZ/gUB0K0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ki5ahlPr5++u5/THDLzyqZ6ORUb4vPXRwWmrxAs/ZqIL/ZqNlP9PT4GPG24dXhSHH2ORUP12LObN3Z499fGGXuCJ20ZiWuLP4aYecedWg7BTiyXETNeLQOoPFe2+Yob8qCo6HBLVPWD4w3zYMa/icZ5Bkt51b3QW3HgsNIOJGjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CCt+eSyw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 063E8C433F1;
	Fri, 16 Feb 2024 16:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708101184;
	bh=Of7v1GxhPAmcslNCv2upPf4LImqPPOW1O8gZ/gUB0K0=;
	h=From:To:Cc:Subject:Date:From;
	b=CCt+eSywPtfHMHf159xCuj+SEArQm0vinZXB6BlnoVBqEYpD8oB39RXX/hgLEHvQ6
	 8Rb/uYvmOTcCclLOSkiWIKKM2Ej3gutNnqUMK2l5YHCw35HAQgkHAKWFFuE2988sS6
	 WpbEean1hiftDBiGRvTDLCVq20o5L5C9ajE8+ttVRzE2keG2Dkns3Nyi1Z0xqd8uT3
	 4Jocxw6KCYxdzZ+Uae58DbpQLhsBwjISLfai3uErE8cN/lq2vU9feE/vhoPzmLNtHK
	 /TkwduhA77vJ4pv8CsOe4UYULsp04ut6lWK5lJj0f5ZLaOe6g6pKhmOOLI4aEcmtTM
	 wpdK7UrXHZOMg==
From: Arnd Bergmann <arnd@kernel.org>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] firmware: arm_scmi: avoid returning uninialized data
Date: Fri, 16 Feb 2024 17:32:53 +0100
Message-Id: <20240216163259.1927967-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Clang notices that there is a code path through
scmi_powercap_notify_supported() that returns an
undefined value:

drivers/firmware/arm_scmi/powercap.c:821:11: error: variable 'supported' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
  821 |         else if (evt_id == SCMI_EVENT_POWERCAP_MEASUREMENTS_CHANGED)
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:824:9: note: uninitialized use occurs here
  824 |         return supported;
      |                ^~~~~~~~~
drivers/firmware/arm_scmi/powercap.c:821:7: note: remove the 'if' if its condition is always true
  821 |         else if (evt_id == SCMI_EVENT_POWERCAP_MEASUREMENTS_CHANGED)
      |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  822 |                 supported = dom_info->notify_powercap_measurement_change;
drivers/firmware/arm_scmi/powercap.c:811:16: note: initialize the variable 'supported' to silence this warning
  811 |         bool supported;
      |                       ^

Return 'false' here, which is probably what was intended.

Fixes: c92a75fe84ce ("firmware: arm_scmi: Implement Powercap .is_notify_supported callback")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/firmware/arm_scmi/powercap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
index aae91f47303e..8ee3be8776b0 100644
--- a/drivers/firmware/arm_scmi/powercap.c
+++ b/drivers/firmware/arm_scmi/powercap.c
@@ -820,6 +820,8 @@ scmi_powercap_notify_supported(const struct scmi_protocol_handle *ph,
 		supported = dom_info->notify_powercap_cap_change;
 	else if (evt_id == SCMI_EVENT_POWERCAP_MEASUREMENTS_CHANGED)
 		supported = dom_info->notify_powercap_measurement_change;
+	else
+		supported = false;
 
 	return supported;
 }
-- 
2.39.2


