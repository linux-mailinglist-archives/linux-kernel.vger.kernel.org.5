Return-Path: <linux-kernel+bounces-63304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B940B852D74
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF112B23D45
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D231824B54;
	Tue, 13 Feb 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6XMpU/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DBC249F9;
	Tue, 13 Feb 2024 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707818725; cv=none; b=JYIjAR8jigtTyr3BM5C2xYe/Gq8T7a1NXRuGiCM3+VBCxH4j8ny6fi6S3hqQFasUVyyat31u5+5fP3vm5y1NxuydA10C7PD+gY5BBRL9HZ1Mx28JoghJGoVgLPs9xH1mt6zv5hnN9ddEGQIX26Nelww1MPDlBKRXCw9Of/14o9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707818725; c=relaxed/simple;
	bh=emMWihdG3YmlZB9a2YuEdmHk2vnpD5HUAdSQ+KiaJ6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mg+pmQJj8MeBm3+nFYjXGW4fiqlA4GGDXkS7pyBdBP+7xiTslp6YKeuBGNNrQ8ssTGqtpf+3vGFeP1PWvrXRBlJAHQgksPXeqhQUmY1FCpHgin0laJxRnnPX8xvZOCgBmcJbUz9+6kn0yOOFZ5bsNHP8z/IaByDnfTq0Vj5kBvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g6XMpU/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0099EC433F1;
	Tue, 13 Feb 2024 10:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707818724;
	bh=emMWihdG3YmlZB9a2YuEdmHk2vnpD5HUAdSQ+KiaJ6U=;
	h=From:To:Cc:Subject:Date:From;
	b=g6XMpU/c/C4zVcOqAnH8qctNqQfSeyU0RRegFvSKE0ZOfDT9JRvhc45z2WxRcO50U
	 ufVpF1BdcdKjziP4BCnnpc0oMsk3NEfq32rz3QDPO8lumirpZeAAOZ+5ZyhJ047969
	 Te3bLskKkIMIA0if6gYRiRtHlMjMMeSBpy/73c3Gjv0e8y58ujuLR7ZHPQRu2m29CV
	 5iyFbmwZOP9PzSJS9IyOZymtqc8kKKCEy6fnJQw4LMKP/k4YrWwUi5cNbtJUqeTAzv
	 yqI04ygtWkit92oUjQ3EAlS33l0a/3wIjSbJXnqqBJ7gSSG9Agx3xanox8lTR977hX
	 pWXprkxTWG9Wg==
From: Arnd Bergmann <arnd@kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	James Bottomley <JBottomley@Parallels.com>,
	Naresh Kumar Inna <naresh@chelsio.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] scsi: csiostor: avoid function pointer casts
Date: Tue, 13 Feb 2024 11:05:00 +0100
Message-Id: <20240213100518.457623-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

csiostor uses function pointer casts to keep the csio_ln_ev state machine
hidden, but this causes warnings about control flow integrity (KCFI) violations
in clang-16 and higher:

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

Move the enum into a shared header so the correct types can be used without the
need for casts.

Fixes: a3667aaed569 ("[SCSI] csiostor: Chelsio FCoE offload driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/csiostor/csio_defs.h  | 18 ++++++++++++++++--
 drivers/scsi/csiostor/csio_lnode.c |  8 ++++----
 drivers/scsi/csiostor/csio_lnode.h | 13 -------------
 3 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/csiostor/csio_defs.h b/drivers/scsi/csiostor/csio_defs.h
index c38017b4af98..e50e93e7fe5a 100644
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
index d5ac93897023..5b3ffefae476 100644
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
index 372a67d122d3..607698a0f063 100644
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
2.39.2


