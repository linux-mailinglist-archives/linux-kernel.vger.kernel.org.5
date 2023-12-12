Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1BD80EF38
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 15:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376929AbjLLOrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 09:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376934AbjLLOq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 09:46:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9221BD1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 06:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702392381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/T6yVZIIW8gaOaFWvjKuKFf94e1s7X/v7fENW4wrGt4=;
        b=UOvV/UZrDbXyctXGhcwCPfg9U5bep/1VBOxoD1EnykzYB0QewgBG6VrGUS+YKcEhVUaxmJ
        Nk9pk2Cq+TLWw6vdeOSGWn7CS5tB1ImJfMJMG70X8nVqRygZ6G3ViKUweOUZYUuVJxvlmx
        3XBKQ6dpco85rtHqJwxymRKgj2FjTUA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-ShvQGx-SNoyQc4i5Dz0B7A-1; Tue,
 12 Dec 2023 09:46:19 -0500
X-MC-Unique: ShvQGx-SNoyQc4i5Dz0B7A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DFD201E441E3;
        Tue, 12 Dec 2023 14:46:18 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CB6BE492BC6;
        Tue, 12 Dec 2023 14:46:17 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Markus Suvanto <markus.suvanto@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>
Cc:     David Howells <dhowells@redhat.com>, linux-afs@lists.infradead.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] afs: Fix dynamic root lookup DNS check
Date:   Tue, 12 Dec 2023 14:46:10 +0000
Message-ID: <20231212144611.3100234-3-dhowells@redhat.com>
In-Reply-To: <20231212144611.3100234-1-dhowells@redhat.com>
References: <20231212144611.3100234-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the afs dynamic root directory, the ->lookup() function does a DNS check
on the cell being asked for and if the DNS upcall reports an error it will
report an error back to userspace (typically ENOENT).

However, if a failed DNS upcall returns a new-style result, it will return
a valid result, with the status field set appropriately to indicate the
type of failure - and in that case, dns_query() doesn't return an error and
we let stat() complete with no error - which can cause confusion in
userspace as subsequent calls that trigger d_automount then fail with
ENOENT.

Fix this by checking the status result from a valid dns_query() and
returning an error if it indicates a failure.

Fixes: bbb4c4323a4d ("dns: Allow the dns resolver to retrieve a server set")
Reported-by: Markus Suvanto <markus.suvanto@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216637
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---

Notes:
    Changes
    =======
    ver #2)
     - Fix signed-unsigned comparison when checking return val.

 fs/afs/dynroot.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index 34474a061654..1f656005018e 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -114,6 +114,7 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	struct afs_net *net = afs_d2net(dentry);
 	const char *name = dentry->d_name.name;
 	size_t len = dentry->d_name.len;
+	char *result = NULL;
 	int ret;
 
 	/* Names prefixed with a dot are R/W mounts. */
@@ -131,9 +132,22 @@ static int afs_probe_cell_name(struct dentry *dentry)
 	}
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
-			NULL, NULL, false);
-	if (ret == -ENODATA || ret == -ENOKEY)
+			&result, NULL, false);
+	if (ret == -ENODATA || ret == -ENOKEY || ret == 0)
 		ret = -ENOENT;
+	if (ret > 0 && ret >= sizeof(struct dns_server_list_v1_header)) {
+		struct dns_server_list_v1_header *v1 = (void *)result;
+
+		if (v1->hdr.zero == 0 &&
+		    v1->hdr.content == DNS_PAYLOAD_IS_SERVER_LIST &&
+		    v1->hdr.version == 1 &&
+		    (v1->status != DNS_LOOKUP_GOOD &&
+		     v1->status != DNS_LOOKUP_GOOD_WITH_BAD))
+			return -ENOENT;
+
+	}
+
+	kfree(result);
 	return ret;
 }
 

