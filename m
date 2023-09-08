Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7A2798152
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239292AbjIHEoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbjIHEoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:44:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5AB1BC1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 21:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694148211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+R5PA6kHMvayYFOXlFnPP0p5Z3WLnMw7fxi33dBoYEA=;
        b=KBUg3unY3S/z/V3gUKOqEvwX8Fu/G2W0oiuT+l3luaGYYp7i2DDUh6chLR2U+I3TO2BwvN
        VLTPSvksuA0uBuN4J+BAXXC3p8P9SomDWNoQ9rUEKiN08HDz/qSrSTPD3EgNi9v8JvBf2w
        nKy5WTtIpG1BezfytAmrnr5BkjZ2Arw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-88i7pYxnNHelyDpBFWo-ug-1; Fri, 08 Sep 2023 00:43:23 -0400
X-MC-Unique: 88i7pYxnNHelyDpBFWo-ug-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C85CA101CA85;
        Fri,  8 Sep 2023 04:43:22 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD7DF404119;
        Fri,  8 Sep 2023 04:43:21 +0000 (UTC)
Date:   Fri, 8 Sep 2023 12:43:18 +0800
From:   Baoquan He <bhe@redhat.com>
To:     HAGIO =?utf-8?B?S0FaVUhJVE8o6JCp5bC+44CA5LiA5LuBKQ==?= 
        <k-hagio-ab@nec.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "lijiang@redhat.com" <lijiang@redhat.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>
Subject: Re: [PATCH v2 4/9] mm: vmalloc: Remove global vmap_area_root rb-tree
Message-ID: <ZPqmZq29U4hrJPaG@MiWiFi-R3L-srv>
References: <20230829081142.3619-1-urezki@gmail.com>
 <20230829081142.3619-5-urezki@gmail.com>
 <ZPkyw0nAQSQWj5H1@MiWiFi-R3L-srv>
 <ZPmaYgsT5EdLVUyO@pc636>
 <ZPmesS66PTl+1Mdz@MiWiFi-R3L-srv>
 <8939ea67-ca27-1aa5-dfff-37d78ad59bb8@nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8939ea67-ca27-1aa5-dfff-37d78ad59bb8@nec.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/23 at 01:51am, HAGIO KAZUHITO(萩尾 一仁) wrote:
> On 2023/09/07 18:58, Baoquan He wrote:
> > On 09/07/23 at 11:39am, Uladzislau Rezki wrote:
> >> On Thu, Sep 07, 2023 at 10:17:39AM +0800, Baoquan He wrote:
> >>> Add Kazu and Lianbo to CC, and kexec mailing list
> >>>
> >>> On 08/29/23 at 10:11am, Uladzislau Rezki (Sony) wrote:
> >>>> Store allocated objects in a separate nodes. A va->va_start
> >>>> address is converted into a correct node where it should
> >>>> be placed and resided. An addr_to_node() function is used
> >>>> to do a proper address conversion to determine a node that
> >>>> contains a VA.
> >>>>
> >>>> Such approach balances VAs across nodes as a result an access
> >>>> becomes scalable. Number of nodes in a system depends on number
> >>>> of CPUs divided by two. The density factor in this case is 1/2.
> >>>>
> >>>> Please note:
> >>>>
> >>>> 1. As of now allocated VAs are bound to a node-0. It means the
> >>>>     patch does not give any difference comparing with a current
> >>>>     behavior;
> >>>>
> >>>> 2. The global vmap_area_lock, vmap_area_root are removed as there
> >>>>     is no need in it anymore. The vmap_area_list is still kept and
> >>>>     is _empty_. It is exported for a kexec only;
> >>>
> >>> I haven't taken a test, while accessing all nodes' busy tree to get
> >>> va of the lowest address could severely impact kcore reading efficiency
> >>> on system with many vmap nodes. People doing live debugging via
> >>> /proc/kcore will get a little surprise.
> >>>
> >>>
> >>> Empty vmap_area_list will break makedumpfile utility, Crash utility
> >>> could be impactd too. I checked makedumpfile code, it relys on
> >>> vmap_area_list to deduce the vmalloc_start value.
> >>>
> >> It is left part and i hope i fix it in v3. The problem here is
> >> we can not give an opportunity to access to vmap internals from
> >> outside. This is just not correct, i.e. you are not allowed to
> >> access the list directly.
> > 
> > Right. Thanks for the fix in v3, that is a relief of makedumpfile and
> > crash.
> > 
> > Hi Kazu,
> > 
> > Meanwhile, I am thinking if we should evaluate the necessity of
> > vmap_area_list in makedumpfile and Crash. In makedumpfile, we just use
> > vmap_area_list to deduce VMALLOC_START. Wondering if we can export
> > VMALLOC_START directly. Surely, the lowest va->va_start in vmap_area_list
> > is a tighter low boundary of vmalloc area and can reduce unnecessary
> > scanning below the lowest va. Not sure if this is the reason people
> > decided to export vmap_area_list.
> 
> The kernel commit acd99dbf5402 introduced the original vmlist entry to 
> vmcoreinfo, but there is no information about why it did not export 
> VMALLOC_START directly.
> 
> If VMALLOC_START is exported directly to vmcoreinfo, I think it would be 
> enough for makedumpfile.

Thanks for confirmation, Kazu.

Then, below draft patch should be enough to export VMALLOC_START
instead, and remove vmap_area_list. In order to get the base address of
vmalloc area, constructing a vmap_area_list from multiple busy-tree
seems not worth.

diff --git a/Documentation/admin-guide/kdump/vmcoreinfo.rst b/Documentation/admin-guide/kdump/vmcoreinfo.rst
index 599e8d3bcbc3..3cb1ea09ff26 100644
--- a/Documentation/admin-guide/kdump/vmcoreinfo.rst
+++ b/Documentation/admin-guide/kdump/vmcoreinfo.rst
@@ -65,11 +65,11 @@ Defines the beginning of the text section. In general, _stext indicates
 the kernel start address. Used to convert a virtual address from the
 direct kernel map to a physical address.
 
-vmap_area_list
---------------
+VMALLOC_START
+-------------
 
-Stores the virtual area list. makedumpfile gets the vmalloc start value
-from this variable and its value is necessary for vmalloc translation.
+Stores the base address of vmalloc area. makedumpfile gets this value and
+its value is necessary for vmalloc translation.
 
 mem_map
 -------
diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
index 66cde752cd74..2a24199a9b81 100644
--- a/arch/arm64/kernel/crash_core.c
+++ b/arch/arm64/kernel/crash_core.c
@@ -23,7 +23,6 @@ void arch_crash_save_vmcoreinfo(void)
 	/* Please note VMCOREINFO_NUMBER() uses "%d", not "%x" */
 	vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
 	vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
-	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
diff --git a/arch/riscv/kernel/crash_core.c b/arch/riscv/kernel/crash_core.c
index 55f1d7856b54..5c39cedd2c5c 100644
--- a/arch/riscv/kernel/crash_core.c
+++ b/arch/riscv/kernel/crash_core.c
@@ -9,7 +9,6 @@ void arch_crash_save_vmcoreinfo(void)
 	VMCOREINFO_NUMBER(phys_ram_base);
 
 	vmcoreinfo_append_str("NUMBER(PAGE_OFFSET)=0x%lx\n", PAGE_OFFSET);
-	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 	vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
 	vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..91810b4e9510 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -253,7 +253,6 @@ extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
 /*
  *	Internals.  Don't use..
  */
-extern struct list_head vmap_area_list;
 extern __init void vm_area_add_early(struct vm_struct *vm);
 extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
 
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 03a7932cde0a..91af87930770 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -617,7 +617,7 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
 #endif
 	VMCOREINFO_SYMBOL(_stext);
-	VMCOREINFO_SYMBOL(vmap_area_list);
+	vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
 
 #ifndef CONFIG_NUMA
 	VMCOREINFO_SYMBOL(mem_map);
diff --git a/kernel/kallsyms_selftest.c b/kernel/kallsyms_selftest.c
index b4cac76ea5e9..8a689b4ff4f9 100644
--- a/kernel/kallsyms_selftest.c
+++ b/kernel/kallsyms_selftest.c
@@ -89,7 +89,6 @@ static struct test_item test_items[] = {
 	ITEM_DATA(kallsyms_test_var_data_static),
 	ITEM_DATA(kallsyms_test_var_bss),
 	ITEM_DATA(kallsyms_test_var_data),
-	ITEM_DATA(vmap_area_list),
 #endif
 };
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 7f9e9e5a0e12..8c6686176ebd 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -131,8 +131,6 @@ int follow_pfn(struct vm_area_struct *vma, unsigned long address,
 }
 EXPORT_SYMBOL(follow_pfn);
 
-LIST_HEAD(vmap_area_list);
-
 void vfree(const void *addr)
 {
 	kfree(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 50d8239b82df..0a02633a9566 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -729,8 +729,7 @@ EXPORT_SYMBOL(vmalloc_to_pfn);
 
 
 static DEFINE_SPINLOCK(free_vmap_area_lock);
-/* Export for kexec only */
-LIST_HEAD(vmap_area_list);
+
 static bool vmap_initialized __read_mostly;
 
 /*
-- 
2.41.0

