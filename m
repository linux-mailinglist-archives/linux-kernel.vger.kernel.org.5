Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1001809437
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443981AbjLGVbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444221AbjLGVas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:30:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEC635A5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701984421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WWGWFaVybn+Cuwok82Tqy8Z4Nj/F9zUC0bxWKAhhGjQ=;
        b=c2SFJxYKuotqFnmhjuh34bxE82WZl6tUc6xA4CCF150DdTJ3VIRqGpJQoDRfZbm4d/bNLF
        l8/LQGzplhdoij2I4FAHMVB1pJg5Ut1ceblQLj088XULVc0j0elgp2WPvbxUOeb0dZroEv
        GuT6vNGkU2Rl1hWjra1FBA9gCAMj/zU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-VvUqiqovNqOjNjOOBY_-Hw-1; Thu,
 07 Dec 2023 16:25:05 -0500
X-MC-Unique: VvUqiqovNqOjNjOOBY_-Hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 645AC386A0B0;
        Thu,  7 Dec 2023 21:25:02 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78F85111E400;
        Thu,  7 Dec 2023 21:24:59 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v3 49/59] cifs: Set zero_point in the copy_file_range() and remap_file_range()
Date:   Thu,  7 Dec 2023 21:21:56 +0000
Message-ID: <20231207212206.1379128-50-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set zero_point in the copy_file_range() and remap_file_range()
implementations so that we don't skip reading data modified on a
server-side copy.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 078cff36cd2e..ebe04c78a955 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1337,6 +1337,8 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
 	if (rc)
 		goto unlock;
+	if (fend > target_cifsi->netfs.zero_point)
+		target_cifsi->netfs.zero_point = fend + 1;
 
 	/* Discard all the folios that overlap the destination region. */
 	cifs_dbg(FYI, "about to discard pages %llx-%llx\n", fstart, fend);
@@ -1355,6 +1357,8 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 			fscache_resize_cookie(cifs_inode_cookie(target_inode),
 					      new_size);
 		}
+		if (rc == 0 && new_size > target_cifsi->netfs.zero_point)
+			target_cifsi->netfs.zero_point = new_size;
 	}
 
 	/* force revalidate of size and timestamps of target file now
@@ -1446,6 +1450,8 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	rc = cifs_flush_folio(target_inode, destend, &fstart, &fend, false);
 	if (rc)
 		goto unlock;
+	if (fend > target_cifsi->netfs.zero_point)
+		target_cifsi->netfs.zero_point = fend + 1;
 
 	/* Discard all the folios that overlap the destination region. */
 	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);

