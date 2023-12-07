Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE8807ECF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443123AbjLGCmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443105AbjLGCmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:42:11 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5772CD4B;
        Wed,  6 Dec 2023 18:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701916935;
        bh=QXzk8ooLKZc++zfzdWQzkS/rYyXwsM96nMEiVA0ZJCw=;
        h=Date:From:To:Cc:Subject:From;
        b=hVSU844p8kxE95UTL+8mD1vV6z+Of9YAlFZy09o1FyzXY64E8PB8kONg1VhzRNtUq
         WgiZYoHG62UQ70f8e+14Em2taizhe2aggEctYejIfOFjMQnczIC8pPZXv/117aP6Qt
         9HulSJ7RHNZi16KoK3hVbg1m+UkVxlKRWYQAfbhlvLlAeVGndMRRNuQ8DQPAlWA2Lx
         G48CL4LisFKk/MFGZv6rvVG+06HqO38DuaACVc1Yyt2N8Tncqap3cJxXcoa1B2NPWT
         eB0553X+2wh3hzJY+1M+IxYeXRTdw8IHw8Q6yoNmREFtWOnfh7+0D5Tt0kJVKPZwlM
         3ypIqHFGtVHaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Slz7p1dnMz4wcJ;
        Thu,  7 Dec 2023 13:42:13 +1100 (AEDT)
Date:   Thu, 7 Dec 2023 13:42:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Nhat Pham <nphamcs@gmail.com>
Subject: linux-next: manual merge of the char-misc tree with the mm tree
Message-ID: <20231207134213.25631ae9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PtqX.dtQi+lU980iLXRJcO8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PtqX.dtQi+lU980iLXRJcO8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  drivers/android/binder_alloc.c

between commit:

  8b59d7857c30 ("list_lru: allow explicit memcg and NUMA node selection")

from the mm tree and commits:

  ea9cdbf0c727 ("binder: rename lru shrinker utilities")
  ea2735ce19c1 ("binder: refactor page range allocation")
(and maybe others)

from the char-misc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/android/binder_alloc.c
index f69d30c9f50f,a4a4dc87ba53..000000000000
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@@ -178,55 -175,141 +175,141 @@@ struct binder_buffer *binder_alloc_prep
  	return buffer;
  }
 =20
- static int binder_update_page_range(struct binder_alloc *alloc, int alloc=
ate,
- 				    void __user *start, void __user *end)
+ static inline void
+ binder_set_installed_page(struct binder_lru_page *lru_page,
+ 			  struct page *page)
+ {
+ 	/* Pairs with acquire in binder_get_installed_page() */
+ 	smp_store_release(&lru_page->page_ptr, page);
+ }
+=20
+ static inline struct page *
+ binder_get_installed_page(struct binder_lru_page *lru_page)
+ {
+ 	/* Pairs with release in binder_set_installed_page() */
+ 	return smp_load_acquire(&lru_page->page_ptr);
+ }
+=20
+ static void binder_lru_freelist_add(struct binder_alloc *alloc,
+ 				    unsigned long start, unsigned long end)
  {
- 	void __user *page_addr;
- 	unsigned long user_page_addr;
  	struct binder_lru_page *page;
- 	struct vm_area_struct *vma =3D NULL;
- 	struct mm_struct *mm =3D NULL;
- 	bool need_mm =3D false;
+ 	unsigned long page_addr;
 =20
- 	binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
- 		     "%d: %s pages %pK-%pK\n", alloc->pid,
- 		     allocate ? "allocate" : "free", start, end);
-=20
- 	if (end <=3D start)
- 		return 0;
-=20
- 	trace_binder_update_page_range(alloc, allocate, start, end);
-=20
- 	if (allocate =3D=3D 0)
- 		goto free_range;
+ 	trace_binder_update_page_range(alloc, false, start, end);
 =20
  	for (page_addr =3D start; page_addr < end; page_addr +=3D PAGE_SIZE) {
- 		page =3D &alloc->pages[(page_addr - alloc->buffer) / PAGE_SIZE];
- 		if (!page->page_ptr) {
- 			need_mm =3D true;
- 			break;
- 		}
- 	}
-=20
- 	if (need_mm && mmget_not_zero(alloc->mm))
- 		mm =3D alloc->mm;
-=20
- 	if (mm) {
- 		mmap_write_lock(mm);
- 		vma =3D alloc->vma;
- 	}
-=20
- 	if (!vma && need_mm) {
- 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
- 				   "%d: binder_alloc_buf failed to map pages in userspace, no vma\n",
- 				   alloc->pid);
- 		goto err_no_vma;
- 	}
-=20
- 	for (page_addr =3D start; page_addr < end; page_addr +=3D PAGE_SIZE) {
- 		int ret;
- 		bool on_lru;
  		size_t index;
+ 		int ret;
+=20
+ 		index =3D (page_addr - alloc->buffer) / PAGE_SIZE;
+ 		page =3D &alloc->pages[index];
+=20
+ 		if (!binder_get_installed_page(page))
+ 			continue;
+=20
+ 		trace_binder_free_lru_start(alloc, index);
+=20
 -		ret =3D list_lru_add(&binder_freelist, &page->lru);
++		ret =3D list_lru_add_obj(&binder_freelist, &page->lru);
+ 		WARN_ON(!ret);
+=20
+ 		trace_binder_free_lru_end(alloc, index);
+ 	}
+ }
+=20
+ static int binder_install_single_page(struct binder_alloc *alloc,
+ 				      struct binder_lru_page *lru_page,
+ 				      unsigned long addr)
+ {
+ 	struct page *page;
+ 	int ret =3D 0;
+=20
+ 	if (!mmget_not_zero(alloc->mm))
+ 		return -ESRCH;
+=20
+ 	/*
+ 	 * Protected with mmap_sem in write mode as multiple tasks
+ 	 * might race to install the same page.
+ 	 */
+ 	mmap_write_lock(alloc->mm);
+ 	if (binder_get_installed_page(lru_page))
+ 		goto out;
+=20
+ 	if (!alloc->vma) {
+ 		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
+ 		ret =3D -ESRCH;
+ 		goto out;
+ 	}
+=20
+ 	page =3D alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
+ 	if (!page) {
+ 		pr_err("%d: failed to allocate page\n", alloc->pid);
+ 		ret =3D -ENOMEM;
+ 		goto out;
+ 	}
+=20
+ 	ret =3D vm_insert_page(alloc->vma, addr, page);
+ 	if (ret) {
+ 		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
+ 		       alloc->pid, __func__, addr - alloc->buffer, ret);
+ 		__free_page(page);
+ 		ret =3D -ENOMEM;
+ 		goto out;
+ 	}
+=20
+ 	/* Mark page installation complete and safe to use */
+ 	binder_set_installed_page(lru_page, page);
+ out:
+ 	mmap_write_unlock(alloc->mm);
+ 	mmput_async(alloc->mm);
+ 	return ret;
+ }
+=20
+ static int binder_install_buffer_pages(struct binder_alloc *alloc,
+ 				       struct binder_buffer *buffer,
+ 				       size_t size)
+ {
+ 	struct binder_lru_page *page;
+ 	unsigned long start, final;
+ 	unsigned long page_addr;
+=20
+ 	start =3D buffer->user_data & PAGE_MASK;
+ 	final =3D PAGE_ALIGN(buffer->user_data + size);
+=20
+ 	for (page_addr =3D start; page_addr < final; page_addr +=3D PAGE_SIZE) {
+ 		unsigned long index;
+ 		int ret;
+=20
+ 		index =3D (page_addr - alloc->buffer) / PAGE_SIZE;
+ 		page =3D &alloc->pages[index];
+=20
+ 		if (binder_get_installed_page(page))
+ 			continue;
+=20
+ 		trace_binder_alloc_page_start(alloc, index);
+=20
+ 		ret =3D binder_install_single_page(alloc, page, page_addr);
+ 		if (ret)
+ 			return ret;
+=20
+ 		trace_binder_alloc_page_end(alloc, index);
+ 	}
+=20
+ 	return 0;
+ }
+=20
+ /* The range of pages should exclude those shared with other buffers */
+ static void binder_lru_freelist_del(struct binder_alloc *alloc,
+ 				    unsigned long start, unsigned long end)
+ {
+ 	struct binder_lru_page *page;
+ 	unsigned long page_addr;
+=20
+ 	trace_binder_update_page_range(alloc, true, start, end);
+=20
+ 	for (page_addr =3D start; page_addr < end; page_addr +=3D PAGE_SIZE) {
+ 		unsigned long index;
+ 		bool on_lru;
 =20
  		index =3D (page_addr - alloc->buffer) / PAGE_SIZE;
  		page =3D &alloc->pages[index];
@@@ -234,7 -317,7 +317,7 @@@
  		if (page->page_ptr) {
  			trace_binder_alloc_lru_start(alloc, index);
 =20
- 			on_lru =3D list_lru_del_obj(&binder_alloc_lru, &page->lru);
 -			on_lru =3D list_lru_del(&binder_freelist, &page->lru);
++			on_lru =3D list_lru_del_obj(&binder_freelist, &page->lru);
  			WARN_ON(!on_lru);
 =20
  			trace_binder_alloc_lru_end(alloc, index);
@@@ -1193,6 -771,448 +771,448 @@@ static void binder_alloc_clear_buf(stru
  	}
  }
 =20
+ /**
+  * binder_alloc_free_buf() - free a binder buffer
+  * @alloc:	binder_alloc for this proc
+  * @buffer:	kernel pointer to buffer
+  *
+  * Free the buffer allocated via binder_alloc_new_buf()
+  */
+ void binder_alloc_free_buf(struct binder_alloc *alloc,
+ 			    struct binder_buffer *buffer)
+ {
+ 	/*
+ 	 * We could eliminate the call to binder_alloc_clear_buf()
+ 	 * from binder_alloc_deferred_release() by moving this to
+ 	 * binder_free_buf_locked(). However, that could
+ 	 * increase contention for the alloc->lock if clear_on_free
+ 	 * is used frequently for large buffers. This lock is not
+ 	 * needed for correctness here.
+ 	 */
+ 	if (buffer->clear_on_free) {
+ 		binder_alloc_clear_buf(alloc, buffer);
+ 		buffer->clear_on_free =3D false;
+ 	}
+ 	spin_lock(&alloc->lock);
+ 	binder_free_buf_locked(alloc, buffer);
+ 	spin_unlock(&alloc->lock);
+ }
+=20
+ /**
+  * binder_alloc_mmap_handler() - map virtual address space for proc
+  * @alloc:	alloc structure for this proc
+  * @vma:	vma passed to mmap()
+  *
+  * Called by binder_mmap() to initialize the space specified in
+  * vma for allocating binder buffers
+  *
+  * Return:
+  *      0 =3D success
+  *      -EBUSY =3D address space already mapped
+  *      -ENOMEM =3D failed to map memory to given address space
+  */
+ int binder_alloc_mmap_handler(struct binder_alloc *alloc,
+ 			      struct vm_area_struct *vma)
+ {
+ 	struct binder_buffer *buffer;
+ 	const char *failure_string;
+ 	int ret, i;
+=20
+ 	if (unlikely(vma->vm_mm !=3D alloc->mm)) {
+ 		ret =3D -EINVAL;
+ 		failure_string =3D "invalid vma->vm_mm";
+ 		goto err_invalid_mm;
+ 	}
+=20
+ 	mutex_lock(&binder_alloc_mmap_lock);
+ 	if (alloc->buffer_size) {
+ 		ret =3D -EBUSY;
+ 		failure_string =3D "already mapped";
+ 		goto err_already_mapped;
+ 	}
+ 	alloc->buffer_size =3D min_t(unsigned long, vma->vm_end - vma->vm_start,
+ 				   SZ_4M);
+ 	mutex_unlock(&binder_alloc_mmap_lock);
+=20
+ 	alloc->buffer =3D vma->vm_start;
+=20
+ 	alloc->pages =3D kcalloc(alloc->buffer_size / PAGE_SIZE,
+ 			       sizeof(alloc->pages[0]),
+ 			       GFP_KERNEL);
+ 	if (alloc->pages =3D=3D NULL) {
+ 		ret =3D -ENOMEM;
+ 		failure_string =3D "alloc page array";
+ 		goto err_alloc_pages_failed;
+ 	}
+=20
+ 	for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+ 		alloc->pages[i].alloc =3D alloc;
+ 		INIT_LIST_HEAD(&alloc->pages[i].lru);
+ 	}
+=20
+ 	buffer =3D kzalloc(sizeof(*buffer), GFP_KERNEL);
+ 	if (!buffer) {
+ 		ret =3D -ENOMEM;
+ 		failure_string =3D "alloc buffer struct";
+ 		goto err_alloc_buf_struct_failed;
+ 	}
+=20
+ 	buffer->user_data =3D alloc->buffer;
+ 	list_add(&buffer->entry, &alloc->buffers);
+ 	buffer->free =3D 1;
+ 	binder_insert_free_buffer(alloc, buffer);
+ 	alloc->free_async_space =3D alloc->buffer_size / 2;
+=20
+ 	/* Signal binder_alloc is fully initialized */
+ 	binder_alloc_set_vma(alloc, vma);
+=20
+ 	return 0;
+=20
+ err_alloc_buf_struct_failed:
+ 	kfree(alloc->pages);
+ 	alloc->pages =3D NULL;
+ err_alloc_pages_failed:
+ 	alloc->buffer =3D 0;
+ 	mutex_lock(&binder_alloc_mmap_lock);
+ 	alloc->buffer_size =3D 0;
+ err_already_mapped:
+ 	mutex_unlock(&binder_alloc_mmap_lock);
+ err_invalid_mm:
+ 	binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
+ 			   "%s: %d %lx-%lx %s failed %d\n", __func__,
+ 			   alloc->pid, vma->vm_start, vma->vm_end,
+ 			   failure_string, ret);
+ 	return ret;
+ }
+=20
+=20
+ void binder_alloc_deferred_release(struct binder_alloc *alloc)
+ {
+ 	struct rb_node *n;
+ 	int buffers, page_count;
+ 	struct binder_buffer *buffer;
+=20
+ 	buffers =3D 0;
+ 	spin_lock(&alloc->lock);
+ 	BUG_ON(alloc->vma);
+=20
+ 	while ((n =3D rb_first(&alloc->allocated_buffers))) {
+ 		buffer =3D rb_entry(n, struct binder_buffer, rb_node);
+=20
+ 		/* Transaction should already have been freed */
+ 		BUG_ON(buffer->transaction);
+=20
+ 		if (buffer->clear_on_free) {
+ 			binder_alloc_clear_buf(alloc, buffer);
+ 			buffer->clear_on_free =3D false;
+ 		}
+ 		binder_free_buf_locked(alloc, buffer);
+ 		buffers++;
+ 	}
+=20
+ 	while (!list_empty(&alloc->buffers)) {
+ 		buffer =3D list_first_entry(&alloc->buffers,
+ 					  struct binder_buffer, entry);
+ 		WARN_ON(!buffer->free);
+=20
+ 		list_del(&buffer->entry);
+ 		WARN_ON_ONCE(!list_empty(&alloc->buffers));
+ 		kfree(buffer);
+ 	}
+=20
+ 	page_count =3D 0;
+ 	if (alloc->pages) {
+ 		int i;
+=20
+ 		for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+ 			unsigned long page_addr;
+ 			bool on_lru;
+=20
+ 			if (!alloc->pages[i].page_ptr)
+ 				continue;
+=20
 -			on_lru =3D list_lru_del(&binder_freelist,
++			on_lru =3D list_lru_del_obj(&binder_freelist,
+ 					      &alloc->pages[i].lru);
+ 			page_addr =3D alloc->buffer + i * PAGE_SIZE;
+ 			binder_alloc_debug(BINDER_DEBUG_BUFFER_ALLOC,
+ 				     "%s: %d: page %d %s\n",
+ 				     __func__, alloc->pid, i,
+ 				     on_lru ? "on lru" : "active");
+ 			__free_page(alloc->pages[i].page_ptr);
+ 			page_count++;
+ 		}
+ 		kfree(alloc->pages);
+ 	}
+ 	spin_unlock(&alloc->lock);
+ 	if (alloc->mm)
+ 		mmdrop(alloc->mm);
+=20
+ 	binder_alloc_debug(BINDER_DEBUG_OPEN_CLOSE,
+ 		     "%s: %d buffers %d, pages %d\n",
+ 		     __func__, alloc->pid, buffers, page_count);
+ }
+=20
+ /**
+  * binder_alloc_print_allocated() - print buffer info
+  * @m:     seq_file for output via seq_printf()
+  * @alloc: binder_alloc for this proc
+  *
+  * Prints information about every buffer associated with
+  * the binder_alloc state to the given seq_file
+  */
+ void binder_alloc_print_allocated(struct seq_file *m,
+ 				  struct binder_alloc *alloc)
+ {
+ 	struct binder_buffer *buffer;
+ 	struct rb_node *n;
+=20
+ 	spin_lock(&alloc->lock);
+ 	for (n =3D rb_first(&alloc->allocated_buffers); n; n =3D rb_next(n)) {
+ 		buffer =3D rb_entry(n, struct binder_buffer, rb_node);
+ 		seq_printf(m, "  buffer %d: %lx size %zd:%zd:%zd %s\n",
+ 			   buffer->debug_id,
+ 			   buffer->user_data - alloc->buffer,
+ 			   buffer->data_size, buffer->offsets_size,
+ 			   buffer->extra_buffers_size,
+ 			   buffer->transaction ? "active" : "delivered");
+ 	}
+ 	spin_unlock(&alloc->lock);
+ }
+=20
+ /**
+  * binder_alloc_print_pages() - print page usage
+  * @m:     seq_file for output via seq_printf()
+  * @alloc: binder_alloc for this proc
+  */
+ void binder_alloc_print_pages(struct seq_file *m,
+ 			      struct binder_alloc *alloc)
+ {
+ 	struct binder_lru_page *page;
+ 	int i;
+ 	int active =3D 0;
+ 	int lru =3D 0;
+ 	int free =3D 0;
+=20
+ 	spin_lock(&alloc->lock);
+ 	/*
+ 	 * Make sure the binder_alloc is fully initialized, otherwise we might
+ 	 * read inconsistent state.
+ 	 */
+ 	if (binder_alloc_get_vma(alloc) !=3D NULL) {
+ 		for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+ 			page =3D &alloc->pages[i];
+ 			if (!page->page_ptr)
+ 				free++;
+ 			else if (list_empty(&page->lru))
+ 				active++;
+ 			else
+ 				lru++;
+ 		}
+ 	}
+ 	spin_unlock(&alloc->lock);
+ 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
+ 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
+ }
+=20
+ /**
+  * binder_alloc_get_allocated_count() - return count of buffers
+  * @alloc: binder_alloc for this proc
+  *
+  * Return: count of allocated buffers
+  */
+ int binder_alloc_get_allocated_count(struct binder_alloc *alloc)
+ {
+ 	struct rb_node *n;
+ 	int count =3D 0;
+=20
+ 	spin_lock(&alloc->lock);
+ 	for (n =3D rb_first(&alloc->allocated_buffers); n !=3D NULL; n =3D rb_ne=
xt(n))
+ 		count++;
+ 	spin_unlock(&alloc->lock);
+ 	return count;
+ }
+=20
+=20
+ /**
+  * binder_alloc_vma_close() - invalidate address space
+  * @alloc: binder_alloc for this proc
+  *
+  * Called from binder_vma_close() when releasing address space.
+  * Clears alloc->vma to prevent new incoming transactions from
+  * allocating more buffers.
+  */
+ void binder_alloc_vma_close(struct binder_alloc *alloc)
+ {
+ 	binder_alloc_set_vma(alloc, NULL);
+ }
+=20
+ /**
+  * binder_alloc_free_page() - shrinker callback to free pages
+  * @item:   item to free
+  * @lock:   lock protecting the item
+  * @cb_arg: callback argument
+  *
+  * Called from list_lru_walk() in binder_shrink_scan() to free
+  * up pages when the system is under memory pressure.
+  */
+ enum lru_status binder_alloc_free_page(struct list_head *item,
+ 				       struct list_lru_one *lru,
+ 				       spinlock_t *lock,
+ 				       void *cb_arg)
+ 	__must_hold(lock)
+ {
+ 	struct binder_lru_page *page =3D container_of(item, typeof(*page), lru);
+ 	struct binder_alloc *alloc =3D page->alloc;
+ 	struct mm_struct *mm =3D alloc->mm;
+ 	struct vm_area_struct *vma;
+ 	struct page *page_to_free;
+ 	unsigned long page_addr;
+ 	size_t index;
+=20
+ 	if (!mmget_not_zero(mm))
+ 		goto err_mmget;
+ 	if (!mmap_read_trylock(mm))
+ 		goto err_mmap_read_lock_failed;
+ 	if (!spin_trylock(&alloc->lock))
+ 		goto err_get_alloc_lock_failed;
+ 	if (!page->page_ptr)
+ 		goto err_page_already_freed;
+=20
+ 	index =3D page - alloc->pages;
+ 	page_addr =3D alloc->buffer + index * PAGE_SIZE;
+=20
+ 	vma =3D vma_lookup(mm, page_addr);
+ 	if (vma && vma !=3D binder_alloc_get_vma(alloc))
+ 		goto err_invalid_vma;
+=20
+ 	trace_binder_unmap_kernel_start(alloc, index);
+=20
+ 	page_to_free =3D page->page_ptr;
+ 	page->page_ptr =3D NULL;
+=20
+ 	trace_binder_unmap_kernel_end(alloc, index);
+=20
+ 	list_lru_isolate(lru, item);
+ 	spin_unlock(&alloc->lock);
+ 	spin_unlock(lock);
+=20
+ 	if (vma) {
+ 		trace_binder_unmap_user_start(alloc, index);
+=20
+ 		zap_page_range_single(vma, page_addr, PAGE_SIZE, NULL);
+=20
+ 		trace_binder_unmap_user_end(alloc, index);
+ 	}
+=20
+ 	mmap_read_unlock(mm);
+ 	mmput_async(mm);
+ 	__free_page(page_to_free);
+=20
+ 	spin_lock(lock);
+ 	return LRU_REMOVED_RETRY;
+=20
+ err_invalid_vma:
+ err_page_already_freed:
+ 	spin_unlock(&alloc->lock);
+ err_get_alloc_lock_failed:
+ 	mmap_read_unlock(mm);
+ err_mmap_read_lock_failed:
+ 	mmput_async(mm);
+ err_mmget:
+ 	return LRU_SKIP;
+ }
+=20
+ static unsigned long
+ binder_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+ {
+ 	return list_lru_count(&binder_freelist);
+ }
+=20
+ static unsigned long
+ binder_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+ {
+ 	return list_lru_walk(&binder_freelist, binder_alloc_free_page,
+ 			    NULL, sc->nr_to_scan);
+ }
+=20
+ static struct shrinker *binder_shrinker;
+=20
+ /**
+  * binder_alloc_init() - called by binder_open() for per-proc initializat=
ion
+  * @alloc: binder_alloc for this proc
+  *
+  * Called from binder_open() to initialize binder_alloc fields for
+  * new binder proc
+  */
+ void binder_alloc_init(struct binder_alloc *alloc)
+ {
+ 	alloc->pid =3D current->group_leader->pid;
+ 	alloc->mm =3D current->mm;
+ 	mmgrab(alloc->mm);
+ 	spin_lock_init(&alloc->lock);
+ 	INIT_LIST_HEAD(&alloc->buffers);
+ }
+=20
+ int binder_alloc_shrinker_init(void)
+ {
+ 	int ret;
+=20
+ 	ret =3D list_lru_init(&binder_freelist);
+ 	if (ret)
+ 		return ret;
+=20
+ 	binder_shrinker =3D shrinker_alloc(0, "android-binder");
+ 	if (!binder_shrinker) {
+ 		list_lru_destroy(&binder_freelist);
+ 		return -ENOMEM;
+ 	}
+=20
+ 	binder_shrinker->count_objects =3D binder_shrink_count;
+ 	binder_shrinker->scan_objects =3D binder_shrink_scan;
+=20
+ 	shrinker_register(binder_shrinker);
+=20
+ 	return 0;
+ }
+=20
+ void binder_alloc_shrinker_exit(void)
+ {
+ 	shrinker_free(binder_shrinker);
+ 	list_lru_destroy(&binder_freelist);
+ }
+=20
+ /**
+  * check_buffer() - verify that buffer/offset is safe to access
+  * @alloc: binder_alloc for this proc
+  * @buffer: binder buffer to be accessed
+  * @offset: offset into @buffer data
+  * @bytes: bytes to access from offset
+  *
+  * Check that the @offset/@bytes are within the size of the given
+  * @buffer and that the buffer is currently active and not freeable.
+  * Offsets must also be multiples of sizeof(u32). The kernel is
+  * allowed to touch the buffer in two cases:
+  *
+  * 1) when the buffer is being created:
+  *     (buffer->free =3D=3D 0 && buffer->allow_user_free =3D=3D 0)
+  * 2) when the buffer is being torn down:
+  *     (buffer->free =3D=3D 0 && buffer->transaction =3D=3D NULL).
+  *
+  * Return: true if the buffer is safe to access
+  */
+ static inline bool check_buffer(struct binder_alloc *alloc,
+ 				struct binder_buffer *buffer,
+ 				binder_size_t offset, size_t bytes)
+ {
+ 	size_t buffer_size =3D binder_alloc_buffer_size(alloc, buffer);
+=20
+ 	return buffer_size >=3D bytes &&
+ 		offset <=3D buffer_size - bytes &&
+ 		IS_ALIGNED(offset, sizeof(u32)) &&
+ 		!buffer->free &&
+ 		(!buffer->allow_user_free || !buffer->transaction);
+ }
+=20
  /**
   * binder_alloc_copy_user_to_buffer() - copy src user to tgt user
   * @alloc: binder_alloc for this proc

--Sig_/PtqX.dtQi+lU980iLXRJcO8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVxMQUACgkQAVBC80lX
0GztjQf+JJqS4KAtp+6ng3e/wIOKRhUwrOXcfQzof67ZXSOglBxTe/uMBqBdEmp5
KpN2zOGhWC7a0J7RovB3Vu3uIhHAVw6fiU1FZ3T8CGt4Ni9cLVuNSW3KoWXY9lCZ
yD7wbR5CnNd2KNQDqSIEXMJaz0Sis1zmRAr9dUJg6xpYhqRtvZ3UXBxJ9voWAyPv
HZqOdll5lmNLyH+x6LtrxWKiG8hH9z1fREsNWQlo60zr/ua5iNMndbLik00KOuHD
jgsDbPIE/7yheYTBV/BpdsPVTd4XUdM9914ZucaoJ9ZmHvUigKC/GwJr1EnCnRJZ
0tv1ImuAqDzZjJ/lQcsXr14EJFBzZg==
=m2hU
-----END PGP SIGNATURE-----

--Sig_/PtqX.dtQi+lU980iLXRJcO8--
