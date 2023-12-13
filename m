Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF19811390
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 14:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379082AbjLMNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 08:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441913AbjLMNuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 08:50:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A29B10E6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 05:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702475446;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IQYJ9RXWQFDz937vpFGQ9JrCjfZ3A06FDJnr0rYbbpw=;
        b=CNwLAz7iUwFeKUQR+J7AMmPfnJSFDAmhjGFb7uDWGk0mOrwD15W62E/ZmYGi6wjlXtfAem
        Ttmea8fIKpThCcJex5RDIhuHlfERK0quh6yaKw8hmPWPiDB1YOucDbeITjGU/3Ikd2VNUg
        5Ng9HpiOyHqUSrWjP76aD5gpnfhsWWQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-fWH0lE0TOtydjl50slfC9A-1; Wed, 13 Dec 2023 08:50:41 -0500
X-MC-Unique: fWH0lE0TOtydjl50slfC9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A803A10193A6;
        Wed, 13 Dec 2023 13:50:40 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC4611C060B1;
        Wed, 13 Dec 2023 13:50:39 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 21/40] rxrpc: Create a procfile to display outstanding client conn bundles
Date:   Wed, 13 Dec 2023 13:49:43 +0000
Message-ID: <20231213135003.367397-22-dhowells@redhat.com>
In-Reply-To: <20231213135003.367397-1-dhowells@redhat.com>
References: <20231213135003.367397-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create /proc/net/rxrpc/bundles to display outstanding rxrpc client
connection bundles.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 net/rxrpc/ar-internal.h |  4 +++
 net/rxrpc/conn_client.c | 10 ++++++
 net/rxrpc/net_ns.c      |  4 +++
 net/rxrpc/proc.c        | 76 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 94 insertions(+)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 8eea7a487380..2f8b39a614c3 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -68,6 +68,7 @@ struct rxrpc_net {
 	atomic_t		nr_calls;	/* Count of allocated calls */
 
 	atomic_t		nr_conns;
+	struct list_head	bundle_proc_list; /* List of bundles for proc */
 	struct list_head	conn_proc_list;	/* List of conns in this namespace for proc */
 	struct list_head	service_conns;	/* Service conns in this namespace */
 	rwlock_t		conn_lock;	/* Lock for ->conn_proc_list, ->service_conns */
@@ -432,6 +433,7 @@ struct rxrpc_bundle {
 	struct rxrpc_local	*local;		/* Representation of local endpoint */
 	struct rxrpc_peer	*peer;		/* Remote endpoint */
 	struct key		*key;		/* Security details */
+	struct list_head	proc_link;	/* Link in net->bundle_proc_list */
 	const struct rxrpc_security *security;	/* applied security module */
 	refcount_t		ref;
 	atomic_t		active;		/* Number of active users */
@@ -445,6 +447,7 @@ struct rxrpc_bundle {
 	struct rb_node		local_node;	/* Node in local->client_conns */
 	struct list_head	waiting_calls;	/* Calls waiting for channels */
 	unsigned long		avail_chans;	/* Mask of available channels */
+	unsigned int		conn_ids[4];	/* Connection IDs. */
 	struct rxrpc_connection	*conns[4];	/* The connections in the bundle (max 4) */
 };
 
@@ -1167,6 +1170,7 @@ void rxrpc_put_peer(struct rxrpc_peer *, enum rxrpc_peer_trace);
  */
 extern const struct seq_operations rxrpc_call_seq_ops;
 extern const struct seq_operations rxrpc_connection_seq_ops;
+extern const struct seq_operations rxrpc_bundle_seq_ops;
 extern const struct seq_operations rxrpc_peer_seq_ops;
 extern const struct seq_operations rxrpc_local_seq_ops;
 
diff --git a/net/rxrpc/conn_client.c b/net/rxrpc/conn_client.c
index 1d95f8bc769f..3b9b267a4431 100644
--- a/net/rxrpc/conn_client.c
+++ b/net/rxrpc/conn_client.c
@@ -91,6 +91,10 @@ static struct rxrpc_bundle *rxrpc_alloc_bundle(struct rxrpc_call *call,
 		atomic_set(&bundle->active, 1);
 		INIT_LIST_HEAD(&bundle->waiting_calls);
 		trace_rxrpc_bundle(bundle->debug_id, 1, rxrpc_bundle_new);
+
+		write_lock(&bundle->local->rxnet->conn_lock);
+		list_add_tail(&bundle->proc_link, &bundle->local->rxnet->bundle_proc_list);
+		write_unlock(&bundle->local->rxnet->conn_lock);
 	}
 	return bundle;
 }
@@ -109,6 +113,9 @@ static void rxrpc_free_bundle(struct rxrpc_bundle *bundle)
 {
 	trace_rxrpc_bundle(bundle->debug_id, refcount_read(&bundle->ref),
 			   rxrpc_bundle_free);
+	write_lock(&bundle->local->rxnet->conn_lock);
+	list_del(&bundle->proc_link);
+	write_unlock(&bundle->local->rxnet->conn_lock);
 	rxrpc_put_peer(bundle->peer, rxrpc_peer_put_bundle);
 	key_put(bundle->key);
 	kfree(bundle);
@@ -338,6 +345,7 @@ static bool rxrpc_add_conn_to_bundle(struct rxrpc_bundle *bundle,
 	old = bundle->conns[slot];
 	if (old) {
 		bundle->conns[slot] = NULL;
+		bundle->conn_ids[slot] = 0;
 		trace_rxrpc_client(old, -1, rxrpc_client_replace);
 		rxrpc_put_connection(old, rxrpc_conn_put_noreuse);
 	}
@@ -351,6 +359,7 @@ static bool rxrpc_add_conn_to_bundle(struct rxrpc_bundle *bundle,
 	rxrpc_activate_bundle(bundle);
 	conn->bundle_shift = shift;
 	bundle->conns[slot] = conn;
+	bundle->conn_ids[slot] = conn->debug_id;
 	for (i = 0; i < RXRPC_MAXCALLS; i++)
 		set_bit(shift + i, &bundle->avail_chans);
 	return true;
@@ -671,6 +680,7 @@ static void rxrpc_unbundle_conn(struct rxrpc_connection *conn)
 	if (bundle->conns[bindex] == conn) {
 		_debug("clear slot %u", bindex);
 		bundle->conns[bindex] = NULL;
+		bundle->conn_ids[bindex] = 0;
 		for (i = 0; i < RXRPC_MAXCALLS; i++)
 			clear_bit(conn->bundle_shift + i, &bundle->avail_chans);
 		rxrpc_put_client_connection_id(bundle->local, conn);
diff --git a/net/rxrpc/net_ns.c b/net/rxrpc/net_ns.c
index a0319c040c25..a4c135d0fbcc 100644
--- a/net/rxrpc/net_ns.c
+++ b/net/rxrpc/net_ns.c
@@ -45,6 +45,7 @@ static __net_init int rxrpc_init_net(struct net *net)
 	atomic_set(&rxnet->nr_calls, 1);
 
 	atomic_set(&rxnet->nr_conns, 1);
+	INIT_LIST_HEAD(&rxnet->bundle_proc_list);
 	INIT_LIST_HEAD(&rxnet->conn_proc_list);
 	INIT_LIST_HEAD(&rxnet->service_conns);
 	rwlock_init(&rxnet->conn_lock);
@@ -78,6 +79,9 @@ static __net_init int rxrpc_init_net(struct net *net)
 	proc_create_net("conns", 0444, rxnet->proc_net,
 			&rxrpc_connection_seq_ops,
 			sizeof(struct seq_net_private));
+	proc_create_net("bundles", 0444, rxnet->proc_net,
+			&rxrpc_bundle_seq_ops,
+			sizeof(struct seq_net_private));
 	proc_create_net("peers", 0444, rxnet->proc_net,
 			&rxrpc_peer_seq_ops,
 			sizeof(struct seq_net_private));
diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index 682636d3b060..6c86cbb98d1d 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -198,6 +198,82 @@ const struct seq_operations rxrpc_connection_seq_ops = {
 	.show   = rxrpc_connection_seq_show,
 };
 
+/*
+ * generate a list of extant virtual bundles in /proc/net/rxrpc/bundles
+ */
+static void *rxrpc_bundle_seq_start(struct seq_file *seq, loff_t *_pos)
+	__acquires(rxnet->conn_lock)
+{
+	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
+
+	read_lock(&rxnet->conn_lock);
+	return seq_list_start_head(&rxnet->bundle_proc_list, *_pos);
+}
+
+static void *rxrpc_bundle_seq_next(struct seq_file *seq, void *v,
+				       loff_t *pos)
+{
+	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
+
+	return seq_list_next(v, &rxnet->bundle_proc_list, pos);
+}
+
+static void rxrpc_bundle_seq_stop(struct seq_file *seq, void *v)
+	__releases(rxnet->conn_lock)
+{
+	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
+
+	read_unlock(&rxnet->conn_lock);
+}
+
+static int rxrpc_bundle_seq_show(struct seq_file *seq, void *v)
+{
+	struct rxrpc_bundle *bundle;
+	struct rxrpc_net *rxnet = rxrpc_net(seq_file_net(seq));
+	char lbuff[50], rbuff[50];
+
+	if (v == &rxnet->bundle_proc_list) {
+		seq_puts(seq,
+			 "Proto Local                                          "
+			 " Remote                                         "
+			 " SvID Ref Act Flg Key      |"
+			 " Bundle   Conn_0   Conn_1   Conn_2   Conn_3\n"
+			 );
+		return 0;
+	}
+
+	bundle = list_entry(v, struct rxrpc_bundle, proc_link);
+
+	sprintf(lbuff, "%pISpc", &bundle->local->srx.transport);
+	sprintf(rbuff, "%pISpc", &bundle->peer->srx.transport);
+	seq_printf(seq,
+		   "UDP   %-47.47s %-47.47s %4x %3u %3d"
+		   " %c%c%c %08x | %08x %08x %08x %08x %08x\n",
+		   lbuff,
+		   rbuff,
+		   bundle->service_id,
+		   refcount_read(&bundle->ref),
+		   atomic_read(&bundle->active),
+		   bundle->try_upgrade ? 'U' : '-',
+		   bundle->exclusive ? 'e' : '-',
+		   bundle->upgrade ? 'u' : '-',
+		   key_serial(bundle->key),
+		   bundle->debug_id,
+		   bundle->conn_ids[0],
+		   bundle->conn_ids[1],
+		   bundle->conn_ids[2],
+		   bundle->conn_ids[3]);
+
+	return 0;
+}
+
+const struct seq_operations rxrpc_bundle_seq_ops = {
+	.start  = rxrpc_bundle_seq_start,
+	.next   = rxrpc_bundle_seq_next,
+	.stop   = rxrpc_bundle_seq_stop,
+	.show   = rxrpc_bundle_seq_show,
+};
+
 /*
  * generate a list of extant virtual peers in /proc/net/rxrpc/peers
  */

