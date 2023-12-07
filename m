Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721DE80938C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444080AbjLGVYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbjLGVXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43B6172B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701984192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kDE/M1RbzgmjQWasqi03vRWSNjlBlYY2O7ZHPetmOEs=;
        b=YfkNBS+nZ0aK7hlxe9InZUX9aLUz+3VWGQBljsOWUiq8nHuzhPMNUiVlxZZ9W73/1wYi7J
        Ig13MgnmmsuF+leaBMo4ChJ4kK9Vs76otvpWsuex2Y/ZrJWUzLq2bqLWeuXlAmJWURiTY0
        Opm6d8syt3/VBQCpxg2VP8zhtYZI4gk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-281-w01vIM_IOxi-FBFiuwyjQw-1; Thu,
 07 Dec 2023 16:23:09 -0500
X-MC-Unique: w01vIM_IOxi-FBFiuwyjQw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7BE283C32069;
        Thu,  7 Dec 2023 21:23:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC13B112131D;
        Thu,  7 Dec 2023 21:23:04 +0000 (UTC)
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
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 16/59] netfs: Add func to calculate pagecount/size-limited span of an iterator
Date:   Thu,  7 Dec 2023 21:21:23 +0000
Message-ID: <20231207212206.1379128-17-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to work out how much of an ITER_BVEC or ITER_XARRAY iterator
we can use in a pagecount-limited and size-limited span.  This will be
used, for example, to limit the number of segments in a subrequest to the
maximum number of elements that an RDMA transfer can handle.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/iterator.c   | 97 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h |  2 +
 2 files changed, 99 insertions(+)

diff --git a/fs/netfs/iterator.c b/fs/netfs/iterator.c
index 2ff07ba655a0..b781bbbf1d8d 100644
--- a/fs/netfs/iterator.c
+++ b/fs/netfs/iterator.c
@@ -101,3 +101,100 @@ ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 	return npages;
 }
 EXPORT_SYMBOL_GPL(netfs_extract_user_iter);
+
+/*
+ * Select the span of a bvec iterator we're going to use.  Limit it by both maximum
+ * size and maximum number of segments.  Returns the size of the span in bytes.
+ */
+static size_t netfs_limit_bvec(const struct iov_iter *iter, size_t start_offset,
+			       size_t max_size, size_t max_segs)
+{
+	const struct bio_vec *bvecs = iter->bvec;
+	unsigned int nbv = iter->nr_segs, ix = 0, nsegs = 0;
+	size_t len, span = 0, n = iter->count;
+	size_t skip = iter->iov_offset + start_offset;
+
+	if (WARN_ON(!iov_iter_is_bvec(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n == 0)
+		return 0;
+
+	while (n && ix < nbv && skip) {
+		len = bvecs[ix].bv_len;
+		if (skip < len)
+			break;
+		skip -= len;
+		n -= len;
+		ix++;
+	}
+
+	while (n && ix < nbv) {
+		len = min3(n, bvecs[ix].bv_len - skip, max_size);
+		span += len;
+		nsegs++;
+		ix++;
+		if (span >= max_size || nsegs >= max_segs)
+			break;
+		skip = 0;
+		n -= len;
+	}
+
+	return min(span, max_size);
+}
+
+/*
+ * Select the span of an xarray iterator we're going to use.  Limit it by both
+ * maximum size and maximum number of segments.  It is assumed that segments
+ * can be larger than a page in size, provided they're physically contiguous.
+ * Returns the size of the span in bytes.
+ */
+static size_t netfs_limit_xarray(const struct iov_iter *iter, size_t start_offset,
+				 size_t max_size, size_t max_segs)
+{
+	struct folio *folio;
+	unsigned int nsegs = 0;
+	loff_t pos = iter->xarray_start + iter->iov_offset;
+	pgoff_t index = pos / PAGE_SIZE;
+	size_t span = 0, n = iter->count;
+
+	XA_STATE(xas, iter->xarray, index);
+
+	if (WARN_ON(!iov_iter_is_xarray(iter)) ||
+	    WARN_ON(start_offset > n) ||
+	    n == 0)
+		return 0;
+	max_size = min(max_size, n - start_offset);
+
+	rcu_read_lock();
+	xas_for_each(&xas, folio, ULONG_MAX) {
+		size_t offset, flen, len;
+		if (xas_retry(&xas, folio))
+			continue;
+		if (WARN_ON(xa_is_value(folio)))
+			break;
+		if (WARN_ON(folio_test_hugetlb(folio)))
+			break;
+
+		flen = folio_size(folio);
+		offset = offset_in_folio(folio, pos);
+		len = min(max_size, flen - offset);
+		span += len;
+		nsegs++;
+		if (span >= max_size || nsegs >= max_segs)
+			break;
+	}
+
+	rcu_read_unlock();
+	return min(span, max_size);
+}
+
+size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
+			size_t max_size, size_t max_segs)
+{
+	if (iov_iter_is_bvec(iter))
+		return netfs_limit_bvec(iter, start_offset, max_size, max_segs);
+	if (iov_iter_is_xarray(iter))
+		return netfs_limit_xarray(iter, start_offset, max_size, max_segs);
+	BUG();
+}
+EXPORT_SYMBOL(netfs_limit_iter);
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 8a5b8e7bc358..a30b47e10797 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -324,6 +324,8 @@ void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
 ssize_t netfs_extract_user_iter(struct iov_iter *orig, size_t orig_len,
 				struct iov_iter *new,
 				iov_iter_extraction_t extraction_flags);
+size_t netfs_limit_iter(const struct iov_iter *iter, size_t start_offset,
+			size_t max_size, size_t max_segs);
 
 int netfs_start_io_read(struct inode *inode);
 void netfs_end_io_read(struct inode *inode);

