Return-Path: <linux-kernel+bounces-114880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34200889257
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D711FB2F344
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15842CCB75;
	Mon, 25 Mar 2024 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDRZnGyF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C03C17889F;
	Sun, 24 Mar 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323557; cv=none; b=SdyNSg+g4y1E9NjcB/Fc0q/9qd02b7jxPV9cVvG/MxVPKtCffbYFpA3Ry8VyfsDSwvPauc2WySWK026VNM7v4Zq6T2cZ7KApcRXfDU+J/n8h/FXQ/Iqw+YH6yMaC1Pq8OWDMXdC5tyuVij1fqckylPoAVK4D9J/sXnuwzRChRW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323557; c=relaxed/simple;
	bh=AS+JGYpUDsPlHwpiNSjJhMQhjdqKCPCQtDNBzfmKuyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUGOCj4QSICZXBl+fIP0YHhcPH3sir9SLl6lqpgnp5nfBo5MGCAmDNnw8gV4psUoloAVkiXxUXfoE+/ZPcLNo/FAXeE8MxkAvswYvjjqRGvUPkSzM2vvdUTenDEgGGyJZ8drxTsuaiPhi3eqHCA4GExQKmag4inQo3zw8R4QJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDRZnGyF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982FFC433F1;
	Sun, 24 Mar 2024 23:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323556;
	bh=AS+JGYpUDsPlHwpiNSjJhMQhjdqKCPCQtDNBzfmKuyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vDRZnGyFqOhJgsHO6k4eU4OLHtm07t4UZAtXFoKoi0ajTI/dOwRoOafmGucCS+2tm
	 pKUSbBw5Z+JDiVMUZUQaDkg+b0vdCjYzGyJyzitxCSnzVG1SzOU1WqWukBhHLHqAXH
	 UMtFJ0GXpLnLQLVrkwEI/1Mc0+BkgpS+ca/6NzUeS1r+OBOd6RX8DhMlSpos7O+sxD
	 PRSWA5nKgEn7apNGCxaAKrMiH5zbg/oaFbMeZQQ1ahmPvRu6E8Yhi8IykkotRVPPXP
	 8d2K/ew4+0JUqbf63Sq4bU6r+Bm45m1kPTfM51F9yUXt/5TVPAIUjiE4Sbb2UnSqMY
	 CRIWTZoG9ZBTw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 263/317] scsi: csiostor: Avoid function pointer casts
Date: Sun, 24 Mar 2024 19:34:03 -0400
Message-ID: <20240324233458.1352854-264-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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


