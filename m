Return-Path: <linux-kernel+bounces-113459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34333888481
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD071288A38
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E4B1B0DFB;
	Sun, 24 Mar 2024 22:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3VII3py"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642C1B0DDB;
	Sun, 24 Mar 2024 22:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320260; cv=none; b=nmbIaq+e+GK7uy1wvhilYObQWSk58D3N5X+gdnfGTEPeaNqIHmAt40mBz9E66jgVM/6PKXlCMYVq9xBnKCFJ45hmKeBHmu3ETqsgcpnkssb6C/0bxY0Y8GDzoUkjbGCM97tsoKaWkFxy8p+qFjZ21wm0nxLb3WMeehT9fNdnVeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320260; c=relaxed/simple;
	bh=AS+JGYpUDsPlHwpiNSjJhMQhjdqKCPCQtDNBzfmKuyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVPIyXrsUl9am2NJkiLXByYfLGK2wPCnBB21a3Pyh71pNflEyW3DmB6JgcVa6cQK+s55nwb/VHL+XRo5qv0zm5LBU93DX113fpsFPad59BtxvleRwcEhkfcC1WszxsI14qjj2qTJCtMp78NT8xY3YPhTzQPpvaSV1v+OUWEhHcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3VII3py; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B69C433F1;
	Sun, 24 Mar 2024 22:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320260;
	bh=AS+JGYpUDsPlHwpiNSjJhMQhjdqKCPCQtDNBzfmKuyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3VII3pyYuoh3xHCnraeLGAcjYSSfv1chbdMjahqujGUK+7s5kq4AzpnhNPMVj1vd
	 mH8ex6cMAlsdl7o52i1KahmrkY/HmsxFBoN1gehm5Z6fYSyZ8/kQHbJTn+5/oScsvT
	 uYeQN+1KW4OeWGMUXCHKXy8siJ5eHKNvz117iwICDymobYddNVroOce86mTj6SQam2
	 Dg5M1+lsIDLqGmQvzDwppGc94XIRyywkwmfH648KFh3+xrPmieoDUxgeLmDrFZbm9c
	 /pRd71V4t+L09TGZYELhN6LEjOvs30CN3yXeXMghinO0XzJTapSDMGG359mIdqKH8N
	 3tbsx+N50mY/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 568/715] scsi: csiostor: Avoid function pointer casts
Date: Sun, 24 Mar 2024 18:32:27 -0400
Message-ID: <20240324223455.1342824-569-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


