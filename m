Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0907E6DD0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343776AbjKIPmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbjKIPmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507E835B4
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699544447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPkiL8/hAwJ3VdyDaCXHEu9+4Gz9SH6fncAOjEzNMKU=;
        b=JlreBVv81dBps4PGgjWs575UXIWY0GCSi5Vwn4J5Y6E+tJ4T8iMNAZm0owqPyD+kjC23ec
        k0IY15LdcKveLU6qXGVYLG99iY5ISA62iA/9sTwc1hDenJ5mqw8QfnixssL9AfJ7yJbyXA
        RULpw/3sMaNhL1whi5uFU7fM44oHZyM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-696-jO7rVc9NMAezoqeCCmTnOw-1; Thu,
 09 Nov 2023 10:40:45 -0500
X-MC-Unique: jO7rVc9NMAezoqeCCmTnOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB382381BE94;
        Thu,  9 Nov 2023 15:40:41 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C75CF1C060AE;
        Thu,  9 Nov 2023 15:40:40 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 17/41] afs: Don't put afs_call in afs_wait_for_call_to_complete()
Date:   Thu,  9 Nov 2023 15:39:40 +0000
Message-ID: <20231109154004.3317227-18-dhowells@redhat.com>
In-Reply-To: <20231109154004.3317227-1-dhowells@redhat.com>
References: <20231109154004.3317227-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't put the afs_call struct in afs_wait_for_call_to_complete() but rather
have the caller do it.  This will allow the caller to fish stuff out of the
afs_call struct rather than the afs_addr_cursor struct, thereby allowing a
subsequent patch to subsume it.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/fs_operation.c |  7 +++--
 fs/afs/fsclient.c     |  5 ++-
 fs/afs/internal.h     |  2 +-
 fs/afs/rxrpc.c        | 73 ++++++++++++++++---------------------------
 fs/afs/vlclient.c     | 64 ++++++++++++++++++++++---------------
 5 files changed, 75 insertions(+), 76 deletions(-)

diff --git a/fs/afs/fs_operation.c b/fs/afs/fs_operation.c
index bfb9a7634bd9..1c22d6e77846 100644
--- a/fs/afs/fs_operation.c
+++ b/fs/afs/fs_operation.c
@@ -191,8 +191,11 @@ void afs_wait_for_operation(struct afs_operation *op)
 		else
 			op->ac.error = -ENOTSUPP;
 
-		if (op->call)
-			op->error = afs_wait_for_call_to_complete(op->call, &op->ac);
+		if (op->call) {
+			afs_wait_for_call_to_complete(op->call, &op->ac);
+			op->error = op->ac.error;
+			afs_put_call(op->call);
+		}
 	}
 
 	switch (op->error) {
diff --git a/fs/afs/fsclient.c b/fs/afs/fsclient.c
index 6821ce0f9d63..020073387111 100644
--- a/fs/afs/fsclient.c
+++ b/fs/afs/fsclient.c
@@ -1612,6 +1612,7 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
 {
 	struct afs_call *call;
 	__be32 *bp;
+	int ret;
 
 	_enter("");
 
@@ -1627,7 +1628,9 @@ int afs_fs_give_up_all_callbacks(struct afs_net *net,
 
 	call->server = afs_use_server(server, afs_server_trace_give_up_cb);
 	afs_make_call(ac, call, GFP_NOFS);
-	return afs_wait_for_call_to_complete(call, ac);
+	afs_wait_for_call_to_complete(call, ac);
+	afs_put_call(call);
+	return ret;
 }
 
 /*
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 08026dfd4421..6ab353e145be 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -1290,7 +1290,7 @@ extern void __net_exit afs_close_socket(struct afs_net *);
 extern void afs_charge_preallocation(struct work_struct *);
 extern void afs_put_call(struct afs_call *);
 extern void afs_make_call(struct afs_addr_cursor *, struct afs_call *, gfp_t);
-extern long afs_wait_for_call_to_complete(struct afs_call *, struct afs_addr_cursor *);
+void afs_wait_for_call_to_complete(struct afs_call *call, struct afs_addr_cursor *ac);
 extern struct afs_call *afs_alloc_flat_call(struct afs_net *,
 					    const struct afs_call_type *,
 					    size_t, size_t);
diff --git a/fs/afs/rxrpc.c b/fs/afs/rxrpc.c
index 1a18fcbdec80..31044fba1bdb 100644
--- a/fs/afs/rxrpc.c
+++ b/fs/afs/rxrpc.c
@@ -575,48 +575,44 @@ static void afs_deliver_to_call(struct afs_call *call)
 /*
  * Wait synchronously for a call to complete and clean up the call struct.
  */
-long afs_wait_for_call_to_complete(struct afs_call *call,
-				   struct afs_addr_cursor *ac)
+void afs_wait_for_call_to_complete(struct afs_call *call, struct afs_addr_cursor *ac)
 {
-	long ret;
 	bool rxrpc_complete = false;
 
-	DECLARE_WAITQUEUE(myself, current);
-
 	_enter("");
 
-	ret = call->error;
-	if (ret < 0)
-		goto out;
+	if (!afs_check_call_state(call, AFS_CALL_COMPLETE)) {
+		DECLARE_WAITQUEUE(myself, current);
+
+		add_wait_queue(&call->waitq, &myself);
+		for (;;) {
+			set_current_state(TASK_UNINTERRUPTIBLE);
+
+			/* deliver any messages that are in the queue */
+			if (!afs_check_call_state(call, AFS_CALL_COMPLETE) &&
+			    call->need_attention) {
+				call->need_attention = false;
+				__set_current_state(TASK_RUNNING);
+				afs_deliver_to_call(call);
+				continue;
+			}
 
-	add_wait_queue(&call->waitq, &myself);
-	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
-
-		/* deliver any messages that are in the queue */
-		if (!afs_check_call_state(call, AFS_CALL_COMPLETE) &&
-		    call->need_attention) {
-			call->need_attention = false;
-			__set_current_state(TASK_RUNNING);
-			afs_deliver_to_call(call);
-			continue;
-		}
+			if (afs_check_call_state(call, AFS_CALL_COMPLETE))
+				break;
 
-		if (afs_check_call_state(call, AFS_CALL_COMPLETE))
-			break;
+			if (!rxrpc_kernel_check_life(call->net->socket, call->rxcall)) {
+				/* rxrpc terminated the call. */
+				rxrpc_complete = true;
+				break;
+			}
 
-		if (!rxrpc_kernel_check_life(call->net->socket, call->rxcall)) {
-			/* rxrpc terminated the call. */
-			rxrpc_complete = true;
-			break;
+			schedule();
 		}
 
-		schedule();
+		remove_wait_queue(&call->waitq, &myself);
+		__set_current_state(TASK_RUNNING);
 	}
 
-	remove_wait_queue(&call->waitq, &myself);
-	__set_current_state(TASK_RUNNING);
-
 	if (!afs_check_call_state(call, AFS_CALL_COMPLETE)) {
 		if (rxrpc_complete) {
 			afs_set_call_complete(call, call->error, call->abort_code);
@@ -635,23 +631,8 @@ long afs_wait_for_call_to_complete(struct afs_call *call,
 	ac->error = call->error;
 	spin_unlock_bh(&call->state_lock);
 
-	ret = ac->error;
-	switch (ret) {
-	case 0:
-		ret = call->ret0;
-		call->ret0 = 0;
-
-		fallthrough;
-	case -ECONNABORTED:
+	if (call->error == 0 || call->error == -ECONNABORTED)
 		ac->responded = true;
-		break;
-	}
-
-out:
-	_debug("call complete");
-	afs_put_call(call);
-	_leave(" = %p", (void *)ret);
-	return ret;
 }
 
 /*
diff --git a/fs/afs/vlclient.c b/fs/afs/vlclient.c
index 41e7932d75c6..650534892a20 100644
--- a/fs/afs/vlclient.c
+++ b/fs/afs/vlclient.c
@@ -106,12 +106,6 @@ static int afs_deliver_vl_get_entry_by_name_u(struct afs_call *call)
 	return 0;
 }
 
-static void afs_destroy_vl_get_entry_by_name_u(struct afs_call *call)
-{
-	kfree(call->ret_vldb);
-	afs_flat_call_destructor(call);
-}
-
 /*
  * VL.GetEntryByNameU operation type.
  */
@@ -119,7 +113,7 @@ static const struct afs_call_type afs_RXVLGetEntryByNameU = {
 	.name		= "VL.GetEntryByNameU",
 	.op		= afs_VL_GetEntryByNameU,
 	.deliver	= afs_deliver_vl_get_entry_by_name_u,
-	.destructor	= afs_destroy_vl_get_entry_by_name_u,
+	.destructor	= afs_flat_call_destructor,
 };
 
 /*
@@ -166,7 +160,13 @@ struct afs_vldb_entry *afs_vl_get_entry_by_name_u(struct afs_vl_cursor *vc,
 
 	trace_afs_make_vl_call(call);
 	afs_make_call(&vc->ac, call, GFP_KERNEL);
-	return (struct afs_vldb_entry *)afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_put_call(call);
+	if (vc->ac.error) {
+		kfree(entry);
+		return ERR_PTR(vc->ac.error);
+	}
+	return entry;
 }
 
 /*
@@ -249,12 +249,6 @@ static int afs_deliver_vl_get_addrs_u(struct afs_call *call)
 	return 0;
 }
 
-static void afs_vl_get_addrs_u_destructor(struct afs_call *call)
-{
-	afs_put_addrlist(call->ret_alist);
-	return afs_flat_call_destructor(call);
-}
-
 /*
  * VL.GetAddrsU operation type.
  */
@@ -262,7 +256,7 @@ static const struct afs_call_type afs_RXVLGetAddrsU = {
 	.name		= "VL.GetAddrsU",
 	.op		= afs_VL_GetAddrsU,
 	.deliver	= afs_deliver_vl_get_addrs_u,
-	.destructor	= afs_vl_get_addrs_u_destructor,
+	.destructor	= afs_flat_call_destructor,
 };
 
 /*
@@ -273,6 +267,7 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 					 const uuid_t *uuid)
 {
 	struct afs_ListAddrByAttributes__xdr *r;
+	struct afs_addr_list *alist;
 	const struct afs_uuid *u = (const struct afs_uuid *)uuid;
 	struct afs_call *call;
 	struct afs_net *net = vc->cell->net;
@@ -309,7 +304,14 @@ struct afs_addr_list *afs_vl_get_addrs_u(struct afs_vl_cursor *vc,
 
 	trace_afs_make_vl_call(call);
 	afs_make_call(&vc->ac, call, GFP_KERNEL);
-	return (struct afs_addr_list *)afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_wait_for_call_to_complete(call, &vc->ac);
+	alist = call->ret_alist;
+	afs_put_call(call);
+	if (vc->ac.error) {
+		afs_put_addrlist(alist);
+		return ERR_PTR(vc->ac.error);
+	}
+	return alist;
 }
 
 /*
@@ -618,7 +620,7 @@ static const struct afs_call_type afs_YFSVLGetEndpoints = {
 	.name		= "YFSVL.GetEndpoints",
 	.op		= afs_YFSVL_GetEndpoints,
 	.deliver	= afs_deliver_yfsvl_get_endpoints,
-	.destructor	= afs_vl_get_addrs_u_destructor,
+	.destructor	= afs_flat_call_destructor,
 };
 
 /*
@@ -628,6 +630,7 @@ static const struct afs_call_type afs_YFSVLGetEndpoints = {
 struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 					      const uuid_t *uuid)
 {
+	struct afs_addr_list *alist;
 	struct afs_call *call;
 	struct afs_net *net = vc->cell->net;
 	__be32 *bp;
@@ -652,7 +655,14 @@ struct afs_addr_list *afs_yfsvl_get_endpoints(struct afs_vl_cursor *vc,
 
 	trace_afs_make_vl_call(call);
 	afs_make_call(&vc->ac, call, GFP_KERNEL);
-	return (struct afs_addr_list *)afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_wait_for_call_to_complete(call, &vc->ac);
+	alist = call->ret_alist;
+	afs_put_call(call);
+	if (vc->ac.error) {
+		afs_put_addrlist(alist);
+		return ERR_PTR(vc->ac.error);
+	}
+	return alist;
 }
 
 /*
@@ -717,12 +727,6 @@ static int afs_deliver_yfsvl_get_cell_name(struct afs_call *call)
 	return 0;
 }
 
-static void afs_destroy_yfsvl_get_cell_name(struct afs_call *call)
-{
-	kfree(call->ret_str);
-	afs_flat_call_destructor(call);
-}
-
 /*
  * VL.GetCapabilities operation type
  */
@@ -730,7 +734,7 @@ static const struct afs_call_type afs_YFSVLGetCellName = {
 	.name		= "YFSVL.GetCellName",
 	.op		= afs_YFSVL_GetCellName,
 	.deliver	= afs_deliver_yfsvl_get_cell_name,
-	.destructor	= afs_destroy_yfsvl_get_cell_name,
+	.destructor	= afs_flat_call_destructor,
 };
 
 /*
@@ -745,6 +749,7 @@ char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *vc)
 	struct afs_call *call;
 	struct afs_net *net = vc->cell->net;
 	__be32 *bp;
+	char *cellname;
 
 	_enter("");
 
@@ -763,5 +768,12 @@ char *afs_yfsvl_get_cell_name(struct afs_vl_cursor *vc)
 	/* Can't take a ref on server */
 	trace_afs_make_vl_call(call);
 	afs_make_call(&vc->ac, call, GFP_KERNEL);
-	return (char *)afs_wait_for_call_to_complete(call, &vc->ac);
+	afs_wait_for_call_to_complete(call, &vc->ac);
+	cellname = call->ret_str;
+	afs_put_call(call);
+	if (vc->ac.error) {
+		kfree(cellname);
+		return ERR_PTR(vc->ac.error);
+	}
+	return cellname;
 }

