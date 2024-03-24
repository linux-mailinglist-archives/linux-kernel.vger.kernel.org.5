Return-Path: <linux-kernel+bounces-116346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB85988A1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 767D5B22121
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E99299184;
	Mon, 25 Mar 2024 03:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRvhSirz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147BC2987D3;
	Sun, 24 Mar 2024 23:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324363; cv=none; b=Z2PIOWbIt01oICXaMOaivEWHZ9MTdKRUQ/+Ov4YUui3s3JuCWIY9qZVM3h5XlktTlUeLc4+h8UWK/IEPMh+alBgBWRMY/xEp6rI8FMFHao46Oj6u+/asyU5Sy+S6T39paMu0eg1xVnTsl77gjMSN43pK3xocrEcgnmOgXmsYfOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324363; c=relaxed/simple;
	bh=uVrNHrQbG48tlepRvvnPkOqOGzG/mveUSwCDgzNolHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izxcHzn/4rUYraB+hPE3RecGTLa58vTWT5YsOkw83wU7Dr20E2wzXVJzzpXUIHR3XBBmwvODdH29f2Sm4ZWBzzHUirYhLnTRy56r4RgjDhrMoEG8pWKUrAnMu1/Gn5H57hiij9jw6xC6OYAoVdysB176bJDjjm5VcpXZiJnDadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRvhSirz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364D3C43394;
	Sun, 24 Mar 2024 23:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324361;
	bh=uVrNHrQbG48tlepRvvnPkOqOGzG/mveUSwCDgzNolHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VRvhSirzHsf2VpWx3VPOwkX2dho90ArskvX5WM9DMxuTfsIaTAItKeVd+DUXu5LFI
	 s1BRJ81plD2KrbfSJ5CcKTCBKWATNB/uTB/FiK2q50f3tbqsyYKP2WI0JoIJvT3Rp3
	 8gJ83wUot7CHrmxkeDo7dW//YV7YZtN05ZJzhmQq4t+zSCmqEhRe8d12kzHZTSCT+A
	 4i2zIw0KA+TwhtcFF/tfNXRRUAa6b74jjbcbprtDnz0jnAQ6Xcl9ND2YsACuFhPryv
	 UKBv51ZNXYxLSH6ie0yCJ6tmK+M6jzsTDJIa0/FVCfBsDTKo76nFIxGpxuUvNv8aba
	 mgMUXfdl29EqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 129/148] scsi: csiostor: Avoid function pointer casts
Date: Sun, 24 Mar 2024 19:49:53 -0400
Message-ID: <20240324235012.1356413-130-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 98944fb3f0b85..1c4e1c86c1d2f 100644
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
@@ -1367,15 +1367,15 @@ csio_free_fcfinfo(struct kref *kref)
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


