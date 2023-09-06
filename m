Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCA0793731
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjIFIc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbjIFIc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:32:56 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E75E58
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:32:46 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 2C43D5876F44D; Wed,  6 Sep 2023 10:32:45 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id A3BB95870428A;
        Wed,  6 Sep 2023 10:32:44 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     o-takashi@sakamocchi.jp
Cc:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] emsmdb: consolidate repeated call logic around get_rpc_info() [2/3]
Date:   Wed,  6 Sep 2023 10:32:44 +0200
Message-ID: <20230906083244.25768-1-jengelh@inai.de>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 exch/emsmdb/oxcfxics.cpp | 51 ++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 34 deletions(-)

diff --git a/exch/emsmdb/oxcfxics.cpp b/exch/emsmdb/oxcfxics.cpp
index 26754ea73..6cfc0b008 100644
--- a/exch/emsmdb/oxcfxics.cpp
+++ b/exch/emsmdb/oxcfxics.cpp
@@ -87,22 +87,18 @@ oxcfxics_load_folder_content(logon_object *plogon, uint64_t folder_id,
 	TARRAY_SET tmp_set;
 	char tmp_essdn[256];
 	uint32_t permission;
-	const char *username;
 	EID_ARRAY *pmessage_ids;
 	LONG_TERM_ID long_term_id;
 	PROPTAG_ARRAY tmp_proptags;
 	TPROPVAL_ARRAY tmp_propvals;
+	auto username = plogon->eff_user();
 	
 	if (plogon->logon_mode != logon_mode::owner) {
-		auto rpc_info = get_rpc_info();
-		username = rpc_info.username;
 		if (!exmdb_client::get_folder_perm(plogon->get_dir(),
 		    folder_id, username, &permission))
 			return NULL;	
 		if (!(permission & (frightsReadAny | frightsOwner)))
 			return NULL;
-	} else {
-		username = NULL;
 	}
 	auto pfldctnt = folder_content_init();
 	if (pfldctnt == nullptr)
@@ -151,13 +147,6 @@ oxcfxics_load_folder_content(logon_object *plogon, uint64_t folder_id,
 	if (!b_sub)
 		return pfldctnt;
 
-	DCERPC_INFO rpc_info;
-	if (plogon->logon_mode != logon_mode::owner) {
-		rpc_info = get_rpc_info();
-		username = rpc_info.username;
-	} else {
-		username = NULL;
-	}
 	if (!exmdb_client::load_hierarchy_table(plogon->get_dir(),
 	    folder_id, username, TABLE_FLAG_NONOTIFICATIONS, nullptr,
 	    &table_id, &row_count))
@@ -415,14 +404,14 @@ ec_error_t rop_fasttransfersourcecopymessages(const LONGLONG_ARRAY *pmessage_ids
 	if (object_type != ems_objtype::folder)
 		return ecNotSupported;
 	if (plogon->logon_mode != logon_mode::owner) {
-		auto rpc_info = get_rpc_info();
+		auto username = plogon->eff_user();
 		if (!exmdb_client::get_folder_perm(plogon->get_dir(),
-		    pfolder->folder_id, rpc_info.username, &permission))
+		    pfolder->folder_id, username, &permission))
 			return ecError;
 		if (!(permission & (frightsReadAny | frightsOwner))) {
 			for (size_t i = 0; i < pmessage_ids->count; ++i) {
 				if (!exmdb_client::check_message_owner(plogon->get_dir(),
-				    pmessage_ids->pll[i], rpc_info.username, &b_owner))
+				    pmessage_ids->pll[i], username, &b_owner))
 					return ecError;
 				if (!b_owner)
 					return ecAccessDenied;
@@ -705,9 +694,8 @@ ec_error_t rop_syncconfigure(uint8_t sync_type, uint8_t send_options,
 		return ecNullObject;
 	if (sync_type == SYNC_TYPE_CONTENTS &&
 	    plogon->logon_mode != logon_mode::owner) {
-		auto rpc_info = get_rpc_info();
 		if (!exmdb_client::get_folder_perm(plogon->get_dir(),
-		    pfolder->folder_id, rpc_info.username, &permission))
+		    pfolder->folder_id, plogon->eff_user(), &permission))
 			return ecError;
 		if (!(permission & (frightsOwner | frightsReadAny)))
 			return ecAccessDenied;
@@ -761,10 +749,9 @@ static ec_error_t simc_otherstore(LOGMAP *logmap, uint8_t logon_id,
 	auto dir = logon->get_dir();
 
 	if (logon->logon_mode != logon_mode::owner) {
-		auto rpc = get_rpc_info();
 		uint32_t permission = 0;
 		if (!exmdb_client::get_folder_perm(dir,
-		    folder_id, rpc.username, &permission))
+		    folder_id, logon->eff_user(), &permission))
 			return ecError;
 		if (!(permission & frightsCreate))
 			return ecAccessDenied;
@@ -871,9 +858,9 @@ ec_error_t rop_syncimportmessagechange(uint8_t import_flags,
 	BOOL b_new = !b_exist ? TRUE : false;
 	*pmessage_id = message_id;
 	if (plogon->logon_mode != logon_mode::owner) {
-		auto rpc_info = get_rpc_info();
+		auto username = plogon->eff_user();
 		if (!exmdb_client::get_folder_perm(dir,
-		    folder_id, rpc_info.username, &permission))
+		    folder_id, username, &permission))
 			return ecError;
 		if (b_new) {
 			if (!(permission & frightsCreate))
@@ -887,7 +874,7 @@ ec_error_t rop_syncimportmessagechange(uint8_t import_flags,
 			tag_access = MAPI_ACCESS_MODIFY | MAPI_ACCESS_READ|MAPI_ACCESS_DELETE;
 		} else {
 			if (!exmdb_client::check_message_owner(dir,
-			    message_id, rpc_info.username, &b_owner))
+			    message_id, username, &b_owner))
 				return ecError;
 			if (b_owner || (permission & frightsReadAny))
 				tag_access |= MAPI_ACCESS_READ;
@@ -969,7 +956,6 @@ ec_error_t rop_syncimportreadstatechanges(uint16_t count,
 	uint64_t read_cn;
 	uint64_t folder_id;
 	uint32_t permission;
-	const char *username;
 	uint32_t proptag_buff[2];
 	PROPTAG_ARRAY tmp_proptags;
 	TPROPVAL_ARRAY tmp_propvals;
@@ -985,17 +971,16 @@ ec_error_t rop_syncimportreadstatechanges(uint16_t count,
 	if (pctx->get_sync_type() != SYNC_TYPE_CONTENTS)
 		return ecNotSupported;
 	pctx->mark_started();
-	username = NULL;
-	auto rpc_info = get_rpc_info();
+	auto username = plogon->eff_user();
 	auto dir = plogon->get_dir();
 	if (plogon->logon_mode != logon_mode::owner) {
 		auto pfolder = pctx->get_parent_object();
 		folder_id = pfolder->folder_id;
 		if (!exmdb_client::get_folder_perm(dir,
-		    folder_id, rpc_info.username, &permission))
+		    folder_id, username, &permission))
 			return ecError;
-		if (!(permission & frightsReadAny))
-			username = rpc_info.username;
+		if (permission & frightsReadAny)
+			username = nullptr;
 	}
 	for (unsigned int i = 0; i < count; ++i) {
 		if (!common_util_binary_to_xid(&pread_stat[i].message_xid, &tmp_xid))
@@ -1030,7 +1015,7 @@ ec_error_t rop_syncimportreadstatechanges(uint16_t count,
 				return ecError;
 		} else {
 			if (!exmdb_client::set_message_read_state(dir,
-			    rpc_info.username, message_id,
+			    username, message_id,
 			    pread_stat[i].mark_as_read, &read_cn))
 				return ecError;
 		}
@@ -1274,7 +1259,6 @@ ec_error_t rop_syncimportdeletes(uint8_t flags, const TPROPVAL_ARRAY *ppropvals,
 	ems_objtype object_type;
 	uint16_t replid;
 	uint32_t permission;
-	const char *username;
 	EID_ARRAY message_ids;
 	
 	if (ppropvals->count != 1 ||
@@ -1298,14 +1282,13 @@ ec_error_t rop_syncimportdeletes(uint8_t flags, const TPROPVAL_ARRAY *ppropvals,
 	pctx->mark_started();
 	auto pfolder = pctx->get_parent_object();
 	auto folder_id = pfolder->folder_id;
-	auto rpc_info = get_rpc_info();
+	auto username = plogon->eff_user();
 	auto dir = plogon->get_dir();
-	username = rpc_info.username;
 	if (plogon->logon_mode == logon_mode::owner) {
-		username = NULL;
+		/* nothing */;
 	} else if (sync_type == SYNC_TYPE_CONTENTS &&
 	    !exmdb_client::get_folder_perm(dir,
-	    folder_id, rpc_info.username, &permission)) {
+	    folder_id, username, &permission)) {
 		if (permission & (frightsOwner | frightsDeleteAny))
 			username = NULL;
 		else if (!(permission & frightsDeleteOwned))
-- 
2.42.0

