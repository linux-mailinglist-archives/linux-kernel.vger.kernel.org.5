Return-Path: <linux-kernel+bounces-114378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8A7888FDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:02:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E32F1C2B9BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5F1270C84;
	Sun, 24 Mar 2024 23:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iV9DqiqL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036D13EFFB;
	Sun, 24 Mar 2024 23:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321796; cv=none; b=HR6tKDoDy9BVq97v9gDxMnTArL4MapCBuLqjZC185/+HpOh6yXmAnbeWNbZjQXcq+JLmDscZZqE1rfhOeZRZudDMaTjJe0n+glAmh9jrIi9xUFWSFrqxmCR+cDeI5lSGMQQrLPZhji0uV2vKQZUmuKnlPlzc3tmBe8/99McijjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321796; c=relaxed/simple;
	bh=AS+JGYpUDsPlHwpiNSjJhMQhjdqKCPCQtDNBzfmKuyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BpMs+6C+pdQ6RVTuD4gqyJWhPDxayExZ/fiePncDZXPN0DMsPnbKszC8Y8BxxnK4BZFic27Mjws+WfX9IwyIXafore7rGbPZaRSx9DfcQEKV7TL3YYiQzlVIOC92y2JtYubStQN3UusXOk2HjTC0OxakGux9lXPl8BHsdNq7hWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iV9DqiqL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3181C43399;
	Sun, 24 Mar 2024 23:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321794;
	bh=AS+JGYpUDsPlHwpiNSjJhMQhjdqKCPCQtDNBzfmKuyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iV9DqiqLvqb5HverbVygzRohg67MLx6Sh+V5SnhMkXYIDnONMJ7L5/flpoeNXcy+E
	 BL/VPXe0HmaDJUmbYQ1aA2ViBlbdLkJhL6/S0wxXMp4DThC1WEN18YuJlPk++9ffHA
	 xLc9Vnt2sNCRgFRzoZ6PrciLSEIw0gS02kZv6geYcWvZJNvoCd0arNh9bneTAbZ9BJ
	 jwmsKDT1/57ZI00YJF2pM3686idUIVo9zIfZ6sNFa2TsoszX0A8ZkAdNeWy9SbiNN9
	 xbjjWcarhWbqaJJT5RqPSjsreQM4O4R51KV7fzssgiABWc6NzHw/+j79/Cl987ZS7c
	 5cJ45QsCklL+Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 522/638] scsi: csiostor: Avoid function pointer casts
Date: Sun, 24 Mar 2024 18:59:19 -0400
Message-ID: <20240324230116.1348576-523-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 9f3dbcb5632d6876226031d552ef6163bb3ad215 ]

csiostor uses function pointer casts to keep the csio_ln_ev state machine
hidden, but this causes warnings about control flow integrity (KCFI)
violations in clang-16 and higher:

drivers/scsi/csiostor/csio_lnode.c:1098:33: error: cast from 'void (*)(struct csio_lnode *, enum csio_ln_ev)' to 'csio_sm_state_t' (aka 'void (*)(void *, unsigned int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1098 |         return (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_ready));
      |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/csiostor/csio_lnode.c:1369:29: error: cast from 'void (*)(struct csio_lnode *, enum csio_ln_ev)' to 'csio_sm_state_t' (aka 'void (*)(void *, unsigned int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1369 |         if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_uninit)) {
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/csiostor/csio_lnode.c:1373:29: error: cast from 'void (*)(struct csio_lnode *, enum csio_ln_ev)' to 'csio_sm_state_t' (aka 'void (*)(void *, unsigned int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1373 |         if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_ready)) {
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/scsi/csiostor/csio_lnode.c:1377:29: error: cast from 'void (*)(struct csio_lnode *, enum csio_ln_ev)' to 'csio_sm_state_t' (aka 'void (*)(void *, unsigned int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
 1377 |         if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_offline)) {
      |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Move the enum into a shared header so the correct types can be used without
the need for casts.

Fixes: a3667aaed569 ("[SCSI] csiostor: Chelsio FCoE offload driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20240213100518.457623-1-arnd@kernel.org
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/csiostor/csio_defs.h  | 18 ++++++++++++++++--
 drivers/scsi/csiostor/csio_lnode.c |  8 ++++----
 drivers/scsi/csiostor/csio_lnode.h | 13 -------------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_defs.h b/drivers/scsi/csiostor/csio_defs.h
index c38017b4af982..e50e93e7fe5a1 100644
--- a/drivers/scsi/csiostor/csio_defs.h
+++ b/drivers/scsi/csiostor/csio_defs.h
@@ -73,7 +73,21 @@ csio_list_deleted(struct list_head *list)
 #define csio_list_prev(elem)	(((struct list_head *)(elem))->prev)
 
 /* State machine */
-typedef void (*csio_sm_state_t)(void *, uint32_t);
+struct csio_lnode;
+
+/* State machine evets */
+enum csio_ln_ev {
+	CSIO_LNE_NONE = (uint32_t)0,
+	CSIO_LNE_LINKUP,
+	CSIO_LNE_FAB_INIT_DONE,
+	CSIO_LNE_LINK_DOWN,
+	CSIO_LNE_DOWN_LINK,
+	CSIO_LNE_LOGO,
+	CSIO_LNE_CLOSE,
+	CSIO_LNE_MAX_EVENT,
+};
+
+typedef void (*csio_sm_state_t)(struct csio_lnode *ln, enum csio_ln_ev evt);
 
 struct csio_sm {
 	struct list_head	sm_list;
@@ -83,7 +97,7 @@ struct csio_sm {
 static inline void
 csio_set_state(void *smp, void *state)
 {
-	((struct csio_sm *)smp)->sm_state = (csio_sm_state_t)state;
+	((struct csio_sm *)smp)->sm_state = state;
 }
 
 static inline void
diff --git a/drivers/scsi/csiostor/csio_lnode.c b/drivers/scsi/csiostor/csio_lnode.c
index d5ac938970232..5b3ffefae476d 100644
--- a/drivers/scsi/csiostor/csio_lnode.c
+++ b/drivers/scsi/csiostor/csio_lnode.c
@@ -1095,7 +1095,7 @@ csio_handle_link_down(struct csio_hw *hw, uint8_t portid, uint32_t fcfi,
 int
 csio_is_lnode_ready(struct csio_lnode *ln)
 {
-	return (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_ready));
+	return (csio_get_state(ln) == csio_lns_ready);
 }
 
 /*****************************************************************************/
@@ -1366,15 +1366,15 @@ csio_free_fcfinfo(struct kref *kref)
 void
 csio_lnode_state_to_str(struct csio_lnode *ln, int8_t *str)
 {
-	if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_uninit)) {
+	if (csio_get_state(ln) == csio_lns_uninit) {
 		strcpy(str, "UNINIT");
 		return;
 	}
-	if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_ready)) {
+	if (csio_get_state(ln) == csio_lns_ready) {
 		strcpy(str, "READY");
 		return;
 	}
-	if (csio_get_state(ln) == ((csio_sm_state_t)csio_lns_offline)) {
+	if (csio_get_state(ln) == csio_lns_offline) {
 		strcpy(str, "OFFLINE");
 		return;
 	}
diff --git a/drivers/scsi/csiostor/csio_lnode.h b/drivers/scsi/csiostor/csio_lnode.h
index 372a67d122d38..607698a0f0631 100644
--- a/drivers/scsi/csiostor/csio_lnode.h
+++ b/drivers/scsi/csiostor/csio_lnode.h
@@ -53,19 +53,6 @@
 extern int csio_fcoe_rnodes;
 extern int csio_fdmi_enable;
 
-/* State machine evets */
-enum csio_ln_ev {
-	CSIO_LNE_NONE = (uint32_t)0,
-	CSIO_LNE_LINKUP,
-	CSIO_LNE_FAB_INIT_DONE,
-	CSIO_LNE_LINK_DOWN,
-	CSIO_LNE_DOWN_LINK,
-	CSIO_LNE_LOGO,
-	CSIO_LNE_CLOSE,
-	CSIO_LNE_MAX_EVENT,
-};
-
-
 struct csio_fcf_info {
 	struct list_head	list;
 	uint8_t			priority;
-- 
2.43.0


