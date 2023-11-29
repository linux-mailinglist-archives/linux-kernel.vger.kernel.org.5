Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213CD7FE3A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 23:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjK2W5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 17:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2W5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 17:57:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACB4112
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 14:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701298635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M48/RaAsJTO7wr3y4zLWEdz2znqhlD1yXGnQVky2YMc=;
        b=MYPwv39imdDg5xuarVfl8pXkKQCtg917u4vXf9DgNU/kGh0KYXLmZNUca9/KMn7FbQiGL4
        1gEYZAmy8406th21g0cOtvlR3NHxczMC3y4Un1GZBkxr9Ncdk7CrfLOj3KBgV8rPZMJv0A
        aW9lwBr95nqgUiXbZPoF35HOPVpQegY=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-2K2r8STzP-OlTWufQKZ4IQ-1; Wed,
 29 Nov 2023 17:57:12 -0500
X-MC-Unique: 2K2r8STzP-OlTWufQKZ4IQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E41211C0515D;
        Wed, 29 Nov 2023 22:57:11 +0000 (UTC)
Received: from [10.22.34.102] (unknown [10.22.34.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9852436E2;
        Wed, 29 Nov 2023 22:57:11 +0000 (UTC)
Message-ID: <c0419245-42c8-4df1-9939-a98dd013699a@redhat.com>
Date:   Wed, 29 Nov 2023 17:57:11 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/kmemleak: Add cond_resched() to kmemleak_free_percpu()
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231127194153.289626-1-longman@redhat.com>
 <ZWYPmCLi9XyUdCNT@arm.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZWYPmCLi9XyUdCNT@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

On 11/28/23 11:04, Catalin Marinas wrote:
> On Mon, Nov 27, 2023 at 02:41:53PM -0500, Waiman Long wrote:
>>   /**
>>    * kmemleak_free_percpu - unregister a previously registered __percpu object
>>    * @ptr:	__percpu pointer to beginning of the object
>>    *
>>    * This function is called from the kernel percpu allocator when an object
>> - * (memory block) is freed (free_percpu).
>> + * (memory block) is freed (free_percpu). Since this function is inherently
>> + * slow especially on systems with a large number of CPUs, defer the actual
>> + * removal of kmemleak objects associated with the percpu pointer to a
>> + * workqueue if it is not in a task context.
>>    */
>>   void __ref kmemleak_free_percpu(const void __percpu *ptr)
>>   {
>> -	unsigned int cpu;
>> -
>>   	pr_debug("%s(0x%px)\n", __func__, ptr);
>>   
>> -	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
>> -		for_each_possible_cpu(cpu)
>> -			delete_object_full((unsigned long)per_cpu_ptr(ptr,
>> -								      cpu));
>> +	if (!kmemleak_free_enabled || !ptr || IS_ERR(ptr))
>> +		return;
>> +
>> +	if (!in_task()) {
>> +		struct kmemleak_percpu_addr *addr;
>> +
>> +		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
>> +		if (addr) {
>> +			INIT_WORK(&addr->work, kmemleak_free_percpu_workfn);
>> +			addr->ptr = ptr;
>> +			queue_work(system_long_wq, &addr->work);
>> +			return;
>> +		}
> We can't defer this freeing. It can mess up the kmemleak metadata if the
> per-cpu pointer is re-allocated before kmemleak removed it from its
> object tree.
>
> The problem is looking up the object tree for each per-cpu offset. We
> can make the percpu pointer handling O(1) since freeing is only done by
> the main __percpu pointer, so that's the only one needing a look-up. So
> far the per-cpu pointers are not tracked for leaking, only scanned.
>
> We could just add the per_cpu_ptr(ptr, 0) to the kmemleak
> object_tree_root but when scanning we don't have an inverse function to
> get the __percpu pointer back and calculate the pointers for the other
> CPUs (well, we could with some hacks but they are probably fragile).
>
> What I came up with is a separate object_percpu_tree_root similar to the
> object_phys_tree_root. The only reason for these additional trees is to
> look up the kmemleak metadata when needed (usually freeing). They don't
> contain objects that are tracked for actual leaking, only scanned. A
> briefly tested patch below. I need to go through it again, update some
> comments and write a commit log:
>
> ---------------------8<---------------------------------
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index 1eacca03bedd..7446c9e0b8c8 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -178,6 +178,8 @@ struct kmemleak_object {
>   #define OBJECT_FULL_SCAN	(1 << 3)
>   /* flag set for object allocated with physical address */
>   #define OBJECT_PHYS		(1 << 4)
> +/* flag set for per-CPU pointers */
> +#define OBJECT_PERCPU		(1 << 5)
>   
>   /* set when __remove_object() called */
>   #define DELSTATE_REMOVED	(1 << 0)
> @@ -206,6 +208,8 @@ static LIST_HEAD(mem_pool_free_list);
>   static struct rb_root object_tree_root = RB_ROOT;
>   /* search tree for object (with OBJECT_PHYS flag) boundaries */
>   static struct rb_root object_phys_tree_root = RB_ROOT;
> +/* search tree for object (with OBJECT_PERCPU flag) boundaries */
> +static struct rb_root object_percpu_tree_root = RB_ROOT;
>   /* protecting the access to object_list, object_tree_root (or object_phys_tree_root) */
>   static DEFINE_RAW_SPINLOCK(kmemleak_lock);
>   
> @@ -298,7 +302,7 @@ static void hex_dump_object(struct seq_file *seq,
>   	const u8 *ptr = (const u8 *)object->pointer;
>   	size_t len;
>   
> -	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
> +	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
>   		return;
>   
>   	/* limit the number of lines to HEX_MAX_LINES */
> @@ -392,6 +396,15 @@ static void dump_object_info(struct kmemleak_object *object)
>   		stack_depot_print(object->trace_handle);
>   }
>   
> +static struct rb_root *object_tree(unsigned long objflags)
> +{
> +	if (objflags & OBJECT_PHYS)
> +		return &object_phys_tree_root;
> +	if (objflags & OBJECT_PERCPU)
> +		return &object_percpu_tree_root;
> +	return &object_tree_root;
> +}
> +
>   /*
>    * Look-up a memory block metadata (kmemleak_object) in the object search
>    * tree based on a pointer value. If alias is 0, only values pointing to the
> @@ -399,10 +412,9 @@ static void dump_object_info(struct kmemleak_object *object)
>    * when calling this function.
>    */
>   static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
> -					       bool is_phys)
> +					       unsigned int objflags)
>   {
> -	struct rb_node *rb = is_phys ? object_phys_tree_root.rb_node :
> -			     object_tree_root.rb_node;
> +	struct rb_node *rb = object_tree(objflags)->rb_node;
>   	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
>   
>   	while (rb) {
> @@ -431,7 +443,7 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
>   /* Look-up a kmemleak object which allocated with virtual address. */
>   static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
>   {
> -	return __lookup_object(ptr, alias, false);
> +	return __lookup_object(ptr, alias, 0);
>   }
>   
>   /*
> @@ -544,14 +556,14 @@ static void put_object(struct kmemleak_object *object)
>    * Look up an object in the object search tree and increase its use_count.
>    */
>   static struct kmemleak_object *__find_and_get_object(unsigned long ptr, int alias,
> -						     bool is_phys)
> +						     unsigned int objflags)
>   {
>   	unsigned long flags;
>   	struct kmemleak_object *object;
>   
>   	rcu_read_lock();
>   	raw_spin_lock_irqsave(&kmemleak_lock, flags);
> -	object = __lookup_object(ptr, alias, is_phys);
> +	object = __lookup_object(ptr, alias, objflags);
>   	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
>   
>   	/* check whether the object is still available */
> @@ -565,7 +577,7 @@ static struct kmemleak_object *__find_and_get_object(unsigned long ptr, int alia
>   /* Look up and get an object which allocated with virtual address. */
>   static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
>   {
> -	return __find_and_get_object(ptr, alias, false);
> +	return __find_and_get_object(ptr, alias, 0);
>   }
>   
>   /*
> @@ -575,9 +587,7 @@ static struct kmemleak_object *find_and_get_object(unsigned long ptr, int alias)
>    */
>   static void __remove_object(struct kmemleak_object *object)
>   {
> -	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
> -				   &object_phys_tree_root :
> -				   &object_tree_root);
> +	rb_erase(&object->rb_node, object_tree(object->flags));
>   	if (!(object->del_state & DELSTATE_NO_DELETE))
>   		list_del_rcu(&object->object_list);
>   	object->del_state |= DELSTATE_REMOVED;
> @@ -585,11 +595,11 @@ static void __remove_object(struct kmemleak_object *object)
>   
>   static struct kmemleak_object *__find_and_remove_object(unsigned long ptr,
>   							int alias,
> -							bool is_phys)
> +							unsigned int objflags)
>   {
>   	struct kmemleak_object *object;
>   
> -	object = __lookup_object(ptr, alias, is_phys);
> +	object = __lookup_object(ptr, alias, objflags);
>   	if (object)
>   		__remove_object(object);
>   
> @@ -603,13 +613,13 @@ static struct kmemleak_object *__find_and_remove_object(unsigned long ptr,
>    * by create_object().
>    */
>   static struct kmemleak_object *find_and_remove_object(unsigned long ptr, int alias,
> -						      bool is_phys)
> +						      unsigned int objflags)
>   {
>   	unsigned long flags;
>   	struct kmemleak_object *object;
>   
>   	raw_spin_lock_irqsave(&kmemleak_lock, flags);
> -	object = __find_and_remove_object(ptr, alias, is_phys);
> +	object = __find_and_remove_object(ptr, alias, objflags);
>   	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
>   
>   	return object;
> @@ -648,7 +658,7 @@ static struct kmemleak_object *__alloc_object(gfp_t gfp)
>   }
>   
>   static int __link_object(struct kmemleak_object *object, unsigned long ptr,
> -			 size_t size, int min_count, bool is_phys)
> +			 size_t size, int min_count, unsigned int objflags)
>   {
>   
>   	struct kmemleak_object *parent;
> @@ -661,7 +671,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
>   	INIT_HLIST_HEAD(&object->area_list);
>   	raw_spin_lock_init(&object->lock);
>   	atomic_set(&object->use_count, 1);
> -	object->flags = OBJECT_ALLOCATED | (is_phys ? OBJECT_PHYS : 0);
> +	object->flags = OBJECT_ALLOCATED | objflags;
>   	object->pointer = ptr;
>   	object->size = kfence_ksize((void *)ptr) ?: size;
>   	object->excess_ref = 0;
> @@ -697,12 +707,11 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
>   	 * Only update min_addr and max_addr with object
>   	 * storing virtual address.
>   	 */
> -	if (!is_phys) {
> +	if (!(objflags & (OBJECT_PHYS | OBJECT_PERCPU))) {
>   		min_addr = min(min_addr, untagged_ptr);
>   		max_addr = max(max_addr, untagged_ptr + size);
>   	}
> -	link = is_phys ? &object_phys_tree_root.rb_node :
> -		&object_tree_root.rb_node;
> +	link = &object_tree(objflags)->rb_node;
>   	rb_parent = NULL;
>   	while (*link) {
>   		rb_parent = *link;
> @@ -724,8 +733,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
>   		}
>   	}
>   	rb_link_node(&object->rb_node, rb_parent, link);
> -	rb_insert_color(&object->rb_node, is_phys ? &object_phys_tree_root :
> -					  &object_tree_root);
> +	rb_insert_color(&object->rb_node, object_tree(objflags));
>   	list_add_tail_rcu(&object->object_list, &object_list);
>   
>   	return 0;
> @@ -737,7 +745,7 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
>    * object_phys_tree_root).
>    */
>   static void __create_object(unsigned long ptr, size_t size,
> -				int min_count, gfp_t gfp, bool is_phys)
> +				int min_count, gfp_t gfp, unsigned int objflags)
>   {
>   	struct kmemleak_object *object;
>   	unsigned long flags;
> @@ -748,7 +756,7 @@ static void __create_object(unsigned long ptr, size_t size,
>   		return;
>   
>   	raw_spin_lock_irqsave(&kmemleak_lock, flags);
> -	ret = __link_object(object, ptr, size, min_count, is_phys);
> +	ret = __link_object(object, ptr, size, min_count, objflags);
>   	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
>   	if (ret)
>   		mem_pool_free(object);
> @@ -758,14 +766,21 @@ static void __create_object(unsigned long ptr, size_t size,
>   static void create_object(unsigned long ptr, size_t size,
>   			  int min_count, gfp_t gfp)
>   {
> -	__create_object(ptr, size, min_count, gfp, false);
> +	__create_object(ptr, size, min_count, gfp, 0);
>   }
>   
>   /* Create kmemleak object which allocated with physical address. */
>   static void create_object_phys(unsigned long ptr, size_t size,
>   			       int min_count, gfp_t gfp)
>   {
> -	__create_object(ptr, size, min_count, gfp, true);
> +	__create_object(ptr, size, min_count, gfp, OBJECT_PHYS);
> +}
> +
> +/* Create kmemleak object corresponding to a per-CPU allocation. */
> +static void create_object_percpu(unsigned long ptr, size_t size,
> +				 int min_count, gfp_t gfp)
> +{
> +	__create_object(ptr, size, min_count, gfp, OBJECT_PERCPU);
>   }
>   
>   /*
> @@ -792,11 +807,11 @@ static void __delete_object(struct kmemleak_object *object)
>    * Look up the metadata (struct kmemleak_object) corresponding to ptr and
>    * delete it.
>    */
> -static void delete_object_full(unsigned long ptr)
> +static void delete_object_full(unsigned long ptr, unsigned int objflags)
>   {
>   	struct kmemleak_object *object;
>   
> -	object = find_and_remove_object(ptr, 0, false);
> +	object = find_and_remove_object(ptr, 0, objflags);
>   	if (!object) {
>   #ifdef DEBUG
>   		kmemleak_warn("Freeing unknown object at 0x%08lx\n",
> @@ -812,7 +827,8 @@ static void delete_object_full(unsigned long ptr)
>    * delete it. If the memory block is partially freed, the function may create
>    * additional metadata for the remaining parts of the block.
>    */
> -static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
> +static void delete_object_part(unsigned long ptr, size_t size,
> +			       unsigned int objflags)
>   {
>   	struct kmemleak_object *object, *object_l, *object_r;
>   	unsigned long start, end, flags;
> @@ -826,7 +842,7 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
>   		goto out;
>   
>   	raw_spin_lock_irqsave(&kmemleak_lock, flags);
> -	object = __find_and_remove_object(ptr, 1, is_phys);
> +	object = __find_and_remove_object(ptr, 1, objflags);
>   	if (!object) {
>   #ifdef DEBUG
>   		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
> @@ -844,11 +860,11 @@ static void delete_object_part(unsigned long ptr, size_t size, bool is_phys)
>   	end = object->pointer + object->size;
>   	if ((ptr > start) &&
>   	    !__link_object(object_l, start, ptr - start,
> -			   object->min_count, is_phys))
> +			   object->min_count, objflags))
>   		object_l = NULL;
>   	if ((ptr + size < end) &&
>   	    !__link_object(object_r, ptr + size, end - ptr - size,
> -			   object->min_count, is_phys))
> +			   object->min_count, objflags))
>   		object_r = NULL;
>   
>   unlock:
> @@ -879,11 +895,11 @@ static void paint_it(struct kmemleak_object *object, int color)
>   	raw_spin_unlock_irqrestore(&object->lock, flags);
>   }
>   
> -static void paint_ptr(unsigned long ptr, int color, bool is_phys)
> +static void paint_ptr(unsigned long ptr, int color, unsigned int objflags)
>   {
>   	struct kmemleak_object *object;
>   
> -	object = __find_and_get_object(ptr, 0, is_phys);
> +	object = __find_and_get_object(ptr, 0, objflags);
>   	if (!object) {
>   		kmemleak_warn("Trying to color unknown object at 0x%08lx as %s\n",
>   			      ptr,
> @@ -901,16 +917,16 @@ static void paint_ptr(unsigned long ptr, int color, bool is_phys)
>    */
>   static void make_gray_object(unsigned long ptr)
>   {
> -	paint_ptr(ptr, KMEMLEAK_GREY, false);
> +	paint_ptr(ptr, KMEMLEAK_GREY, 0);
>   }
>   
>   /*
>    * Mark the object as black-colored so that it is ignored from scans and
>    * reporting.
>    */
> -static void make_black_object(unsigned long ptr, bool is_phys)
> +static void make_black_object(unsigned long ptr, unsigned int objflags)
>   {
> -	paint_ptr(ptr, KMEMLEAK_BLACK, is_phys);
> +	paint_ptr(ptr, KMEMLEAK_BLACK, objflags);
>   }
>   
>   /*
> @@ -1046,8 +1062,6 @@ EXPORT_SYMBOL_GPL(kmemleak_alloc);
>   void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
>   				 gfp_t gfp)
>   {
> -	unsigned int cpu;
> -
>   	pr_debug("%s(0x%px, %zu)\n", __func__, ptr, size);
>   
>   	/*
> @@ -1055,9 +1069,7 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
>   	 * (min_count is set to 0).
>   	 */
>   	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> -		for_each_possible_cpu(cpu)
> -			create_object((unsigned long)per_cpu_ptr(ptr, cpu),
> -				      size, 0, gfp);
> +		create_object_percpu((unsigned long)ptr, size, 0, gfp);
>   }
>   EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
>   
> @@ -1098,7 +1110,7 @@ void __ref kmemleak_free(const void *ptr)
>   	pr_debug("%s(0x%px)\n", __func__, ptr);
>   
>   	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
> -		delete_object_full((unsigned long)ptr);
> +		delete_object_full((unsigned long)ptr, 0);
>   }
>   EXPORT_SYMBOL_GPL(kmemleak_free);
>   
> @@ -1116,7 +1128,7 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
>   	pr_debug("%s(0x%px)\n", __func__, ptr);
>   
>   	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> -		delete_object_part((unsigned long)ptr, size, false);
> +		delete_object_part((unsigned long)ptr, size, 0);
>   }
>   EXPORT_SYMBOL_GPL(kmemleak_free_part);
>   
> @@ -1129,14 +1141,10 @@ EXPORT_SYMBOL_GPL(kmemleak_free_part);
>    */
>   void __ref kmemleak_free_percpu(const void __percpu *ptr)
>   {
> -	unsigned int cpu;
> -
>   	pr_debug("%s(0x%px)\n", __func__, ptr);
>   
>   	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
> -		for_each_possible_cpu(cpu)
> -			delete_object_full((unsigned long)per_cpu_ptr(ptr,
> -								      cpu));
> +		delete_object_full((unsigned long)ptr, OBJECT_PERCPU);
>   }
>   EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
>   
> @@ -1204,7 +1212,7 @@ void __ref kmemleak_ignore(const void *ptr)
>   	pr_debug("%s(0x%px)\n", __func__, ptr);
>   
>   	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
> -		make_black_object((unsigned long)ptr, false);
> +		make_black_object((unsigned long)ptr, 0);
>   }
>   EXPORT_SYMBOL(kmemleak_ignore);
>   
> @@ -1278,7 +1286,7 @@ void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
>   	pr_debug("%s(0x%px)\n", __func__, &phys);
>   
>   	if (kmemleak_enabled)
> -		delete_object_part((unsigned long)phys, size, true);
> +		delete_object_part((unsigned long)phys, size, OBJECT_PHYS);
>   }
>   EXPORT_SYMBOL(kmemleak_free_part_phys);
>   
> @@ -1292,7 +1300,7 @@ void __ref kmemleak_ignore_phys(phys_addr_t phys)
>   	pr_debug("%s(0x%px)\n", __func__, &phys);
>   
>   	if (kmemleak_enabled)
> -		make_black_object((unsigned long)phys, true);
> +		make_black_object((unsigned long)phys, OBJECT_PHYS);
>   }
>   EXPORT_SYMBOL(kmemleak_ignore_phys);
>   
> @@ -1303,7 +1311,7 @@ static bool update_checksum(struct kmemleak_object *object)
>   {
>   	u32 old_csum = object->checksum;
>   
> -	if (WARN_ON_ONCE(object->flags & OBJECT_PHYS))
> +	if (WARN_ON_ONCE(object->flags & (OBJECT_PHYS | OBJECT_PERCPU)))
>   		return false;
>   
>   	kasan_disable_current();
> @@ -1459,7 +1467,6 @@ static void scan_object(struct kmemleak_object *object)
>   {
>   	struct kmemleak_scan_area *area;
>   	unsigned long flags;
> -	void *obj_ptr;
>   
>   	/*
>   	 * Once the object->lock is acquired, the corresponding memory block
> @@ -1472,14 +1479,27 @@ static void scan_object(struct kmemleak_object *object)
>   		/* already freed object */
>   		goto out;
>   
> -	obj_ptr = object->flags & OBJECT_PHYS ?
> -		  __va((phys_addr_t)object->pointer) :
> -		  (void *)object->pointer;
> +	if (object->flags & OBJECT_PERCPU) {
> +		unsigned int cpu;
>   
> -	if (hlist_empty(&object->area_list) ||
> +		for_each_possible_cpu(cpu) {
> +			void *start = per_cpu_ptr((void __percpu *)object->pointer, cpu);
> +			void *end = start + object->size;
> +
> +			scan_block(start, end, object);
> +
> +			raw_spin_unlock_irqrestore(&object->lock, flags);
> +			cond_resched();
> +			raw_spin_lock_irqsave(&object->lock, flags);
> +			if (!(object->flags & OBJECT_ALLOCATED))
> +				break;
> +		}
> +	} else if (hlist_empty(&object->area_list) ||
>   	    object->flags & OBJECT_FULL_SCAN) {
> -		void *start = obj_ptr;
> -		void *end = obj_ptr + object->size;
> +		void *start = object->flags & OBJECT_PHYS ?
> +				__va((phys_addr_t)object->pointer) :
> +				(void *)object->pointer;
> +		void *end = start + object->size;
>   		void *next;
>   
>   		do {
> @@ -1494,11 +1514,12 @@ static void scan_object(struct kmemleak_object *object)
>   			cond_resched();
>   			raw_spin_lock_irqsave(&object->lock, flags);
>   		} while (object->flags & OBJECT_ALLOCATED);
> -	} else
> +	} else {
>   		hlist_for_each_entry(area, &object->area_list, node)
>   			scan_block((void *)area->start,
>   				   (void *)(area->start + area->size),
>   				   object);
> +	}
>   out:
>   	raw_spin_unlock_irqrestore(&object->lock, flags);
>   }

The patch looks reasonable to me. It also has a side effect of reducing 
the # of kmemleak objects to track especially for system with large 
number of CPUs. Of course, we still need more testing to make sure that 
it won't break anything.

Cheers,
Longman

