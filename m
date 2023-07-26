Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE6D76387A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjGZOIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbjGZOHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:22 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65C52698
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:04 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140703euoutp02df57de8cf3357f5dc8908f7b00a11d87~1cAoY2T9W1595615956euoutp02Z
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140703euoutp02df57de8cf3357f5dc8908f7b00a11d87~1cAoY2T9W1595615956euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380423;
        bh=cMTBe7sf9ly5UubZ6NjClaUkcmfE+QKlrsv2BzOiDwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Vvd+n4h7geZSsoeldQAkwhPqgw3HCYur0tmqfRaEQJ9xFOCRtTd7tHFUqTzmwdoFe
         SL+ejs5ZIgioncLKDt5lYO7DpE8uFT6Yl3U6HBeSUEfJ81Skd/vqEjPm/kxRxGmcxx
         jTvBskRbLnKHuRmqJjxeP6cCb5QTSG74CGXq9e2s=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726140702eucas1p14c105669e63c6e3cfd4d0cb7320154a4~1cAni14LW2259722597eucas1p1v;
        Wed, 26 Jul 2023 14:07:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8A.F6.11320.68821C46; Wed, 26
        Jul 2023 15:07:02 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140702eucas1p20c75fc21d675ea267dd2ad4ebd6e60b4~1cAnKGUn40231902319eucas1p2Q;
        Wed, 26 Jul 2023 14:07:02 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230726140702eusmtrp215065597cf1bd38d1f098d84ab275544~1cAnJbZxl2063520635eusmtrp2E;
        Wed, 26 Jul 2023 14:07:02 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-41-64c12886d5f1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A6.57.14344.68821C46; Wed, 26
        Jul 2023 15:07:02 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140702eusmtip2423b6f9945d4ce69ab1ed5e9d0188f6a~1cAm7AxCU2279822798eusmtip2E;
        Wed, 26 Jul 2023 14:07:02 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     willy@infradead.org, keescook@chromium.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] sysctl: Add size to register_net_sysctl function
Date:   Wed, 26 Jul 2023 16:06:28 +0200
Message-Id: <20230726140635.2059334-9-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKKsWRmVeSWpSXmKPExsWy7djP87ptGgdTDP6/MrSYc76FxeLpsUfs
        Fkv3P2S0+L8g3+JMd67FhW19rBaXd81hs7gx4SmjxbEFYhbfTr9htPj9Yw6bA7fH7IaLLB5b
        Vt5k8liwqdRj8wotj1uvbT02repk83i/7yqbR9+WVYwenzfJBXBGcdmkpOZklqUW6dslcGWs
        WzOZqWCRTMXRaSvZGhjniHcxcnJICJhITF31ih3EFhJYwShx52l8FyMXkP2FUeL9q33MEM5n
        RomuIzfZYTpaXp5ngUgsZ5TYuHQ5O4TzklHi4LmpLCBVbAI6Euff3AFrFxFYCdTeuoARxGEG
        aXm1+CpYlbCAu8SKpydYQWwWAVWJL18WAHVwcPAK2EocavOCWCcv0XZ9OiOIzSlgJ7Fy7Xew
        cl4BQYmTM5+AjWEGqmneOhtsmYTABw6JSS2LWCCaXSQW7l/OCmELS7w6vgXqBxmJ/zvnM0E0
        TGaU2P/vAzuEs5pRYlnjVyaIKmuJlitP2EEuYhbQlFi/Sx8i7CjRc+84G0hYQoBP4sZbQYgj
        +CQmbZvODBHmlehoE4KoVpHoWzoF6hwpieuXd7JB2B4Sv3buZZ/AqDgLyTuzkLwzC2HvAkbm
        VYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIEp6/S/4192MC5/9VHvECMTB+MhRgkOZiUR
        XsOYfSlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamNLO
        yDW4BT+xvr/50EWtc1e3Jfzl2rNOtOZz2pGO/1Pk/s4W/5IqMS9ZasqZlrJ9R7f/3r8/6oXn
        X8bXH7aFhQY5R9x85SN+uc9wcuGnu69F2btems4LeXtJ0DvUwz+5auXqUsc5y1cmHH/022TR
        y6ndiu/urHl02uV/9uU0hSO2ZwU7mx67f5xR53BR9rdQjcUVE4dLYtsZDi1OflcauNiwNSsr
        Km7WvJK2qfpnLR/rJdqX/xHZ5pR60jVUTvq9whydLceWWb5Iev3Wr8V8vsvp44J/UoSSLzOF
        K9dqf5nL8f/CssocFnsV/q3PCgxspW9leM5/7jy9TemDtfK1/96lErt3bTW6IVX4eqH9olNK
        LMUZiYZazEXFiQCuNiZMyAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEIsWRmVeSWpSXmKPExsVy+t/xe7ptGgdTDO7dE7eYc76FxeLpsUfs
        Fkv3P2S0+L8g3+JMd67FhW19rBaXd81hs7gx4SmjxbEFYhbfTr9htPj9Yw6bA7fH7IaLLB5b
        Vt5k8liwqdRj8wotj1uvbT02repk83i/7yqbR9+WVYwenzfJBXBG6dkU5ZeWpCpk5BeX2CpF
        G1oY6RlaWugZmVjqGRqbx1oZmSrp29mkpOZklqUW6dsl6GWsWzOZqWCRTMXRaSvZGhjniHcx
        cnJICJhItLw8z9LFyMUhJLCUUeLI+1nMXYwcQAkpie/LOCFqhCX+XOtig6h5zijxYeIHNpAE
        m4COxPk3d5hBEiICaxklbr49xQ7iMIM486ZPYwGpEhZwl1jx9AQriM0ioCrx5csCsA28ArYS
        h9q8IDbIS7Rdn84IYnMK2EmsXPsdrFwIqKRn6lN2EJtXQFDi5MwnYCOZgeqbt85mnsAoMAtJ
        ahaS1AJGplWMIqmlxbnpucVGesWJucWleel6yfm5mxiBkbXt2M8tOxhXvvqod4iRiYPxEKME
        B7OSCK9hzL4UId6UxMqq1KL8+KLSnNTiQ4ymQGdPZJYSTc4HxnZeSbyhmYGpoYmZpYGppZmx
        kjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTUNeu8gkRvbsNNNdvWcXwcsHSy4uX96ZuijG8
        3ZPItK3xlgLLsbkqLOW9CcpT3DSl76hqL1hx9teEbLWVHJvZ8mesWRfH8OTh8c+bVm13mqT3
        8PWytN+dsS16MTohs19Nur6viS9+wtkK8Z5vR9wXcmo3P3mYtrqNf8nS5d7vjp9bd8aBmbvg
        8h2Vv8rWO/ZXvzlvq2DhfZRbLSJPxHxTqt6cpxv0OgKSvz6pWTeZa9cC7n2zv0SGmfvuseU2
        aV/o43v+3tm9x05NZQ2t2GX7p6t8q7TI/Q+ZGpOCV+a6BETc+mRcnSbsIHD9/p3DTScLpTeG
        /czd915jsWjBrVqtnZm1WjozFrHL3PhpUn33sBJLcUaioRZzUXEiAAubwa41AwAA
X-CMS-MailID: 20230726140702eucas1p20c75fc21d675ea267dd2ad4ebd6e60b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140702eucas1p20c75fc21d675ea267dd2ad4ebd6e60b4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140702eucas1p20c75fc21d675ea267dd2ad4ebd6e60b4
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140702eucas1p20c75fc21d675ea267dd2ad4ebd6e60b4@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is part of the effort to remove the sentinel (last empty) element
from the ctl_table arrays.

We create a new function register_net_sysctl_sz with an extra size
argument. A macro replaces the existing register_net_sysctl. For now,
the size passed by the macro is SIZE_MAX (will eventually be ARRAY_SIZE)
to avoid compilation warnings from pointers to ctl_table arrays instead
of the arrays themselves.

Care is also taken to add table_size to the stopping criteria in such a
way that when we remove the empty sentinel element, it will continue
stopping in the last element of the ctl_table array

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/net/net_namespace.h | 10 ++++++----
 net/sysctl_net.c            | 22 +++++++++++++---------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 78beaa765c73..e4e5fe75a281 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -469,15 +469,17 @@ void unregister_pernet_device(struct pernet_operations *);
 
 struct ctl_table;
 
+#define register_net_sysctl(net, path, table)	\
+	register_net_sysctl_sz(net, path, table, SIZE_MAX)
 #ifdef CONFIG_SYSCTL
 int net_sysctl_init(void);
-struct ctl_table_header *register_net_sysctl(struct net *net, const char *path,
-					     struct ctl_table *table);
+struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
+					     struct ctl_table *table, size_t table_size);
 void unregister_net_sysctl_table(struct ctl_table_header *header);
 #else
 static inline int net_sysctl_init(void) { return 0; }
-static inline struct ctl_table_header *register_net_sysctl(struct net *net,
-	const char *path, struct ctl_table *table)
+static inline struct ctl_table_header *register_net_sysctl_sz(struct net *net,
+	const char *path, struct ctl_table *table, size_t table_size)
 {
 	return NULL;
 }
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index d9cbbb51b143..051ed5f6fc93 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -122,12 +122,13 @@ __init int net_sysctl_init(void)
  *    allocated.
  */
 static void ensure_safe_net_sysctl(struct net *net, const char *path,
-				   struct ctl_table *table)
+				   struct ctl_table *table, size_t table_size)
 {
 	struct ctl_table *ent;
 
 	pr_debug("Registering net sysctl (net %p): %s\n", net, path);
-	for (ent = table; ent->procname; ent++) {
+	ent = table;
+	for (size_t i = 0; i < table_size && ent->procname; ent++, i++) {
 		unsigned long addr;
 		const char *where;
 
@@ -160,21 +161,24 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 	}
 }
 
-struct ctl_table_header *register_net_sysctl(struct net *net,
-	const char *path, struct ctl_table *table)
+struct ctl_table_header *register_net_sysctl_sz(struct net *net,
+						const char *path,
+						struct ctl_table *table,
+						size_t table_size)
 {
-	int count = 0;
+	int count;
 	struct ctl_table *entry;
 
 	if (!net_eq(net, &init_net))
-		ensure_safe_net_sysctl(net, path, table);
+		ensure_safe_net_sysctl(net, path, table, table_size);
 
-	for (entry = table; entry->procname; entry++)
-		count++;
+	entry = table;
+	for (count = 0 ; count < table_size && entry->procname; entry++, count++)
+		;
 
 	return __register_sysctl_table(&net->sysctls, path, table, count);
 }
-EXPORT_SYMBOL_GPL(register_net_sysctl);
+EXPORT_SYMBOL_GPL(register_net_sysctl_sz);
 
 void unregister_net_sysctl_table(struct ctl_table_header *header)
 {
-- 
2.30.2

