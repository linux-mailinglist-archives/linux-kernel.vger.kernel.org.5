Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B118F7EF8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346154AbjKQUyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:54:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjKQUyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:54:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE94D51
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 12:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/34QMA5NbLub0mKSSuyQnE9R/cq6uYurcKuJplDoBJk=; b=kM+hQgjIMtEx9z00gS72cercDk
        H675drS6hKWj/m5mPyCEJItg8gt2chcZdf0ikfenmGfNax4CLSlmar4nGLrBKQlEKY9gNc4/S4KTF
        MOk6LYTfdvfwMzT6FCZV1hFfGRpeU2sm5wz8MGDUKaJCNb5l3EQsAT3ya582AEIZZi2KocZ+Q+35H
        6iXzYWdic9GvQY2EEDCYsVUeUaHogV5TzQ5ojoXYSKYjBZ40vpMFqQ1eOUox59OiDC7u0DA3OdvUv
        gXGvO/2SNs13Dji6KxQvIUHfmp4c18kWGAHQlykWbO3jEwL9yDNGonCEBLaaureWjO49VoOg2QlTu
        18PdQtyw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1r45qr-007Gwi-0R;
        Fri, 17 Nov 2023 20:54:09 +0000
Date:   Fri, 17 Nov 2023 12:54:09 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Daniel Gomez <da.gomez@samsung.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        "willy@infradead.org" <willy@infradead.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 1/2] test_xarray: add tests for advanced multi-index use
Message-ID: <ZVfS8fiudvHADtoR@bombadil.infradead.org>
References: <20231104005747.1389762-2-da.gomez@samsung.com>
 <202311152254.610174ff-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202311152254.610174ff-oliver.sang@intel.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 15, 2023 at 11:02:59PM +0800, kernel test robot wrote:
> [  304.121213][    T1] WARNING: suspicious RCU usage
> [  304.122111][    T1] 6.6.0-12894-g68f563aa7e55 #1 Tainted: G                 N
> [  304.123404][    T1] -----------------------------
> [  304.124297][    T1] include/linux/xarray.h:1200 suspicious rcu_dereference_check() usage!
> [  304.125787][    T1]
> [  304.125787][    T1] other info that might help us debug this:
> [  304.125787][    T1]
> [  304.127648][    T1]
> [  304.127648][    T1] rcu_scheduler_active = 2, debug_locks = 1
> [  304.129454][    T1] no locks held by swapper/1.
> [  304.130560][    T1]
> [  304.130560][    T1] stack backtrace:
> [  304.131863][    T1] CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 6.6.0-12894-g68f563aa7e55 #1
> [  304.132791][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> [  304.132791][    T1] Call Trace:
> [  304.132791][    T1]  <TASK>
> [ 304.132791][ T1] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1)) 
> [ 304.132791][ T1] lockdep_rcu_suspicious (include/linux/context_tracking.h:153 kernel/locking/lockdep.c:6712) 
> [ 304.132791][ T1] xas_start (include/linux/xarray.h:1200 include/linux/xarray.h:1198 lib/xarray.c:190) 
> [ 304.132791][ T1] xas_load (lib/xarray.c:237) 
> [ 304.132791][ T1] xas_store (lib/xarray.c:789) 
> [ 304.132791][ T1] ? xa_load (include/linux/rcupdate.h:306 include/linux/rcupdate.h:780 lib/xarray.c:1465) 
> [ 304.132791][ T1] check_xa_multi_store_adv_delete+0xf0/0x120 

Yup... I forgot to lock on deletion. I also decided to polish this up
some more and also address some soft lockups which can happen on low
end test machines when we test for order 20, which has 1<<20 entries
(1,048,576). The patch below fixes all this. I'll spin this series up
and send a v2.

diff --git a/lib/test_xarray.c b/lib/test_xarray.c
index 3c19d12c1bf5..ac0e887ccbd6 100644
--- a/lib/test_xarray.c
+++ b/lib/test_xarray.c
@@ -32,6 +32,16 @@ void xa_dump(const struct xarray *xa) { }
 } while (0)
 #endif
 
+/*
+ * Can be used in contexts which busy loop on large number of entries but can
+ * sleep and timing is if no importance to test correctness.
+ */
+#define XA_BUG_ON_RELAX(xa, x) do {				\
+	if ((tests_run % 1000) == 0)				\
+		schedule();					\
+	XA_BUG_ON(xa, x);					\
+} while (0)
+
 static void *xa_mk_index(unsigned long index)
 {
 	return xa_mk_value(index & LONG_MAX);
@@ -728,12 +738,17 @@ static noinline void check_multi_store(struct xarray *xa)
 }
 
 #ifdef CONFIG_XARRAY_MULTI
+/* mimics page cache __filemap_add_folio() */
 static noinline void check_xa_multi_store_adv_add(struct xarray *xa,
 						  unsigned long index,
 						  unsigned int order,
 						  void *p)
 {
 	XA_STATE(xas, xa, index);
+	unsigned int nrpages = 1UL << order;
+
+	/* users are responsible for index alignemnt to the order when adding */
+	XA_BUG_ON(xa, index & (nrpages - 1));
 
 	xas_set_order(&xas, index, order);
 
@@ -750,23 +765,48 @@ static noinline void check_xa_multi_store_adv_add(struct xarray *xa,
 	XA_BUG_ON(xa, xas_error(&xas));
 }
 
+/* mimics page_cache_delete() */
+static noinline void check_xa_multi_store_adv_del_entry(struct xarray *xa,
+						        unsigned long index,
+							unsigned int order)
+{
+	XA_STATE(xas, xa, index);
+
+	xas_set_order(&xas, index, order);
+	xas_store(&xas, NULL);
+	xas_init_marks(&xas);
+}
+
 static noinline void check_xa_multi_store_adv_delete(struct xarray *xa,
 						     unsigned long index,
 						     unsigned int order)
 {
-	unsigned int nrpages = 1UL << order;
-	unsigned long base = round_down(index, nrpages);
-	XA_STATE(xas, xa, base);
+	xa_lock_irq(xa);
+	check_xa_multi_store_adv_del_entry(xa, index, order);
+	xa_unlock_irq(xa);
+}
 
-	xas_set_order(&xas, base, order);
-	xas_store(&xas, NULL);
-	xas_init_marks(&xas);
+/* mimics page cache filemap_get_entry() */
+static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
+{
+	XA_STATE(xas, xa, index);
+	void *p;
+
+	rcu_read_lock();
+repeat:
+	xas_reset(&xas);
+	p = xas_load(&xas);
+	if (xas_retry(&xas, p))
+		goto repeat;
+	rcu_read_unlock();
+
+	return p;
 }
 
 static unsigned long some_val = 0xdeadbeef;
 static unsigned long some_val_2 = 0xdeaddead;
 
-/* mimics the page cache */
+/* mimics the page cache usage */
 static noinline void check_xa_multi_store_adv(struct xarray *xa,
 					      unsigned long pos,
 					      unsigned int order)
@@ -783,13 +823,13 @@ static noinline void check_xa_multi_store_adv(struct xarray *xa,
 	check_xa_multi_store_adv_add(xa, base, order, &some_val);
 
 	for (i = 0; i < nrpages; i++)
-		XA_BUG_ON(xa, xa_load(xa, base + i) != &some_val);
+		XA_BUG_ON_RELAX(xa, test_get_entry(xa, base + i) != &some_val);
 
-	XA_BUG_ON(xa, xa_load(xa, next_index) != NULL);
+	XA_BUG_ON(xa, test_get_entry(xa, next_index) != NULL);
 
 	/* Use order 0 for the next item */
 	check_xa_multi_store_adv_add(xa, next_index, 0, &some_val_2);
-	XA_BUG_ON(xa, xa_load(xa, next_index) != &some_val_2);
+	XA_BUG_ON(xa, test_get_entry(xa, next_index) != &some_val_2);
 
 	/* Remove the next item */
 	check_xa_multi_store_adv_delete(xa, next_index, 0);
@@ -798,7 +838,8 @@ static noinline void check_xa_multi_store_adv(struct xarray *xa,
 	check_xa_multi_store_adv_add(xa, next_index, order, &some_val_2);
 
 	for (i = 0; i < nrpages; i++)
-		XA_BUG_ON(xa, xa_load(xa, next_index + i) != &some_val_2);
+		XA_BUG_ON_RELAX(xa,
+			test_get_entry(xa, next_index + i) != &some_val_2);
 
 	check_xa_multi_store_adv_delete(xa, next_index, order);
 	check_xa_multi_store_adv_delete(xa, base, order);
@@ -812,13 +853,15 @@ static noinline void check_xa_multi_store_adv(struct xarray *xa,
 	check_xa_multi_store_adv_add(xa, next_index, order, &some_val_2);
 
 	for (i = 0; i < nrpages; i++)
-		XA_BUG_ON(xa, xa_load(xa, base + i) != NULL);
+		XA_BUG_ON_RELAX(xa, test_get_entry(xa, base + i) != NULL);
 
 	for (i = 0; i < nrpages; i++)
-		XA_BUG_ON(xa, xa_load(xa, next_index + i) != &some_val_2);
+		XA_BUG_ON_RELAX(xa,
+			test_get_entry(xa, next_index + i) != &some_val_2);
 
 	for (i = 0; i < nrpages; i++)
-		XA_BUG_ON(xa, xa_load(xa, next_next_index + i) != NULL);
+		XA_BUG_ON_RELAX(xa,
+			test_get_entry(xa, next_next_index + i) != NULL);
 
 	check_xa_multi_store_adv_delete(xa, next_index, order);
 	XA_BUG_ON(xa, !xa_empty(xa));
@@ -828,13 +871,15 @@ static noinline void check_xa_multi_store_adv(struct xarray *xa,
 	check_xa_multi_store_adv_add(xa, next_next_index, order, &some_val_2);
 
 	for (i = 0; i < nrpages; i++)
-		XA_BUG_ON(xa, xa_load(xa, base + i) != NULL);
+		XA_BUG_ON_RELAX(xa,
+			test_get_entry(xa, base + i) != NULL);
 
 	for (i = 0; i < nrpages; i++)
-		XA_BUG_ON(xa, xa_load(xa, next_index + i) != NULL);
+		XA_BUG_ON_RELAX(xa, test_get_entry(xa, next_index + i) != NULL);
 
 	for (i = 0; i < nrpages; i++)
-		XA_BUG_ON(xa, xa_load(xa, next_next_index + i) != &some_val_2);
+		XA_BUG_ON_RELAX(xa,
+			test_get_entry(xa, next_next_index + i) != &some_val_2);
 
 	check_xa_multi_store_adv_delete(xa, next_next_index, order);
 	XA_BUG_ON(xa, !xa_empty(xa));
