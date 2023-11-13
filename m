Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA187EA727
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 00:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjKMXpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 18:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbjKMXpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 18:45:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C258F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 15:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699919088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=MWLskBwSdWDZ41yFDXxOzxCovYMtUiIkublLbv2soJQ=;
        b=gY2+4zPDrtW6sgBm9w9yN1Kn08GlMkvW+YDfo59mwxrmXIsCpSlccM6/qHaukSNNnEovkY
        7Y3S3nQXHuIXIxSek4FqLHPFUU87zStHR9ZCNf+7NBfiRaVm+P/7tN+ZvW4lHYIBoMJep6
        Q+dVUw5qCj5DMgiiec0RMA1lmYlQJ04=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-HezSOEpmMgCumBzIQGPfFQ-1; Mon, 13 Nov 2023 18:44:44 -0500
X-MC-Unique: HezSOEpmMgCumBzIQGPfFQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1261C810FC0;
        Mon, 13 Nov 2023 23:44:42 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC5882166B26;
        Mon, 13 Nov 2023 23:44:41 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 2C3E9409B6035; Mon, 13 Nov 2023 20:35:57 -0300 (-03)
Message-ID: <20231113233502.563575851@redhat.com>
User-Agent: quilt/0.67
Date:   Mon, 13 Nov 2023 20:34:21 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/2] mm: vmstat: introduce node_page_state_pages_snapshot
References: <20231113233420.446465795@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a _snapshot variant of node_page_state_snapshot,
similar to zone_page_state_snapshot.

To be used by next patch.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/vmstat.h |    4 ++++
 mm/vmstat.c            |   28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

Index: linux/mm/vmstat.c
===================================================================
--- linux.orig/mm/vmstat.c
+++ linux/mm/vmstat.c
@@ -1031,6 +1031,34 @@ unsigned long node_page_state(struct pgl
 
 	return node_page_state_pages(pgdat, item);
 }
+
+/*
+ * Determine the per node value of a stat item, snapshot version
+ * (see comment on top zone_page_state_snapshot).
+ */
+unsigned long node_page_state_pages_snapshot(struct pglist_data *pgdat,
+					     enum node_stat_item item)
+{
+	long x = atomic_long_read(&pgdat->vm_stat[item]);
+#ifdef CONFIG_SMP
+	int cpu;
+
+	for_each_online_cpu(cpu)
+		x += per_cpu_ptr(pgdat->per_cpu_nodestats, cpu)->vm_node_stat_diff[item];
+
+	if (x < 0)
+		x = 0;
+#endif
+	return x;
+}
+
+unsigned long node_page_state_snapshot(struct pglist_data *pgdat,
+				       enum node_stat_item item)
+{
+	VM_WARN_ON_ONCE(vmstat_item_in_bytes(item));
+
+	return node_page_state_pages(pgdat, item);
+}
 #endif
 
 #ifdef CONFIG_COMPACTION
Index: linux/include/linux/vmstat.h
===================================================================
--- linux.orig/include/linux/vmstat.h
+++ linux/include/linux/vmstat.h
@@ -262,6 +262,10 @@ extern unsigned long node_page_state(str
 						enum node_stat_item item);
 extern unsigned long node_page_state_pages(struct pglist_data *pgdat,
 					   enum node_stat_item item);
+extern unsigned long node_page_state_snapshot(struct pglist_data *pgdat,
+						enum node_stat_item item);
+extern unsigned long node_page_state_pages_snapshot(struct pglist_data *pgdat,
+						    enum node_stat_item item);
 extern void fold_vm_numa_events(void);
 #else
 #define sum_zone_node_page_state(node, item) global_zone_page_state(item)


