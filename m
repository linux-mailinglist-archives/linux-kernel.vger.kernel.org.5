Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DF57EC251
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 13:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343779AbjKOMd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 07:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKOMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 07:33:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FACF11F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 04:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700051601; x=1731587601;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t1dW6o2nTHz2o6AFCdNOcaRMy7d6+pwh7NWq+AsApkY=;
  b=iOpV+Foy70E4ZRSgqwc0MG/wNA3SZhycCyRTfquW02vE7cFqHUaaWJSQ
   K9NMTWo7MXjlZmjQ+lOMc89FjVFUdupLNh3yJZjrmJrvJhiueGK9dZ6hU
   /HgQr+zsdONgnWhunWJSOzYBXk7wJCoPNIrDSOsw5zIjCnDFo/WaRGM2N
   1T57HffwjBc6xkc3Sk24A0l4uZ5rHGOJ67fC0wvb60YVwvMuk/uZSHad/
   1l/QiEAWDuN7VYwo8TcQXYlSC52ljz9UrqSaBz91awCRp+37GAOeML2dY
   1U1tkVz4P9t0ST9QZQfcYjiQ4V3lYHWT9ZeGRuxgfThiR9hixek7S6Euw
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="390664924"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="390664924"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:33:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="1096429926"
X-IronPort-AV: E=Sophos;i="6.03,304,1694761200"; 
   d="scan'208";a="1096429926"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.26.106]) ([10.213.26.106])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 04:33:19 -0800
Message-ID: <2f72313b-2fb4-4f62-a9d7-3fe05f1051c4@intel.com>
Date:   Wed, 15 Nov 2023 13:33:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-gfx] [PATCH v3] debugobjects: stop accessing objects after
 releasing spinlock
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Cc:     Nirmoy Das <nirmoy.das@intel.com>
References: <20231025-debugobjects_fix-v3-1-2bc3bf7084c2@intel.com>
From:   Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <20231025-debugobjects_fix-v3-1-2bc3bf7084c2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.10.2023 23:39, Andrzej Hajda wrote:
> After spinlock release object can be modified/freed by concurrent thread.
> Using it in such case is error prone, even for printing object state.
> To avoid such situation local copy of the object is created if necessary.
> 
> Sample buggy scenario:
> 1. Thread tries to deactivate destroyed object, debugobjects detects it,
>     spin lock is released, thread is preempted.
> 2. Other thread frees debugobject, then allocates new one on the same memory
>     location, ie 'obj' variable from 1st thread point to it - it is possible
>     because there is no locking.
> 3. Then preemption occurs, and 1st thread reports error for wrong object.
> 
> Signed-off-by: Andrzej Hajda <andrzej.hajda@intel.com>
> ---
> v2: add missing switch breaks
> v3: abandon single-point-of-unlock approach

Gently ping.

Regards
Andrzej


> ---
>   lib/debugobjects.c | 196 +++++++++++++++++++++--------------------------------
>   1 file changed, 77 insertions(+), 119 deletions(-)
> 
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index a517256a270b71..c074dbbec084a6 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -620,9 +620,8 @@ static void debug_objects_fill_pool(void)
>   static void
>   __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
>   {
> -	enum debug_obj_state state;
>   	struct debug_bucket *db;
> -	struct debug_obj *obj;
> +	struct debug_obj *obj, o;
>   	unsigned long flags;
>   
>   	debug_objects_fill_pool();
> @@ -643,24 +642,18 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>   	case ODEBUG_STATE_INIT:
>   	case ODEBUG_STATE_INACTIVE:
>   		obj->state = ODEBUG_STATE_INIT;
> -		break;
> -
> -	case ODEBUG_STATE_ACTIVE:
> -		state = obj->state;
>   		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		debug_print_object(obj, "init");
> -		debug_object_fixup(descr->fixup_init, addr, state);
> -		return;
> -
> -	case ODEBUG_STATE_DESTROYED:
> -		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		debug_print_object(obj, "init");
>   		return;
>   	default:
>   		break;
>   	}
>   
> +	o = *obj;
>   	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	debug_print_object(&o, "init");
> +
> +	if (o.state == ODEBUG_STATE_ACTIVE)
> +		debug_object_fixup(descr->fixup_init, addr, o.state);
>   }
>   
>   /**
> @@ -701,11 +694,9 @@ EXPORT_SYMBOL_GPL(debug_object_init_on_stack);
>   int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>   {
>   	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
> -	enum debug_obj_state state;
>   	struct debug_bucket *db;
>   	struct debug_obj *obj;
>   	unsigned long flags;
> -	int ret;
>   
>   	if (!debug_objects_enabled)
>   		return 0;
> @@ -717,49 +708,38 @@ int debug_object_activate(void *addr, const struct debug_obj_descr *descr)
>   	raw_spin_lock_irqsave(&db->lock, flags);
>   
>   	obj = lookup_object_or_alloc(addr, db, descr, false, true);
> -	if (likely(!IS_ERR_OR_NULL(obj))) {
> -		bool print_object = false;
> -
> +	if (unlikely(!obj)) {
> +		raw_spin_unlock_irqrestore(&db->lock, flags);
> +		debug_objects_oom();
> +		return 0;
> +	} else if (likely(!IS_ERR(obj))) {
>   		switch (obj->state) {
> -		case ODEBUG_STATE_INIT:
> -		case ODEBUG_STATE_INACTIVE:
> -			obj->state = ODEBUG_STATE_ACTIVE;
> -			ret = 0;
> -			break;
> -
>   		case ODEBUG_STATE_ACTIVE:
> -			state = obj->state;
> -			raw_spin_unlock_irqrestore(&db->lock, flags);
> -			debug_print_object(obj, "activate");
> -			ret = debug_object_fixup(descr->fixup_activate, addr, state);
> -			return ret ? 0 : -EINVAL;
> -
>   		case ODEBUG_STATE_DESTROYED:
> -			print_object = true;
> -			ret = -EINVAL;
>   			break;
> +		case ODEBUG_STATE_INIT:
> +		case ODEBUG_STATE_INACTIVE:
> +			obj->state = ODEBUG_STATE_ACTIVE;
> +			fallthrough;
>   		default:
> -			ret = 0;
> -			break;
> +			raw_spin_unlock_irqrestore(&db->lock, flags);
> +			return 0;
>   		}
> -		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		if (print_object)
> -			debug_print_object(obj, "activate");
> -		return ret;
>   	}
>   
> +	o = *obj;
>   	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	debug_print_object(&o, "activate");
>   
> -	/* If NULL the allocation has hit OOM */
> -	if (!obj) {
> -		debug_objects_oom();
> -		return 0;
> +	switch (o.state) {
> +	case ODEBUG_STATE_ACTIVE:
> +	case ODEBUG_STATE_NOTAVAILABLE:
> +		if (debug_object_fixup(descr->fixup_activate, addr, o.state))
> +			return 0;
> +		fallthrough;
> +	default:
> +		return -EINVAL;
>   	}
> -
> -	/* Object is neither static nor tracked. It's not initialized */
> -	debug_print_object(&o, "activate");
> -	ret = debug_object_fixup(descr->fixup_activate, addr, ODEBUG_STATE_NOTAVAILABLE);
> -	return ret ? 0 : -EINVAL;
>   }
>   EXPORT_SYMBOL_GPL(debug_object_activate);
>   
> @@ -770,10 +750,10 @@ EXPORT_SYMBOL_GPL(debug_object_activate);
>    */
>   void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
>   {
> +	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
>   	struct debug_bucket *db;
>   	struct debug_obj *obj;
>   	unsigned long flags;
> -	bool print_object = false;
>   
>   	if (!debug_objects_enabled)
>   		return;
> @@ -785,33 +765,24 @@ void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
>   	obj = lookup_object(addr, db);
>   	if (obj) {
>   		switch (obj->state) {
> +		case ODEBUG_STATE_DESTROYED:
> +			break;
>   		case ODEBUG_STATE_INIT:
>   		case ODEBUG_STATE_INACTIVE:
>   		case ODEBUG_STATE_ACTIVE:
> -			if (!obj->astate)
> -				obj->state = ODEBUG_STATE_INACTIVE;
> -			else
> -				print_object = true;
> -			break;
> -
> -		case ODEBUG_STATE_DESTROYED:
> -			print_object = true;
> -			break;
> +			if (obj->astate)
> +				break;
> +			obj->state = ODEBUG_STATE_INACTIVE;
> +			fallthrough;
>   		default:
> -			break;
> +			raw_spin_unlock_irqrestore(&db->lock, flags);
> +			return;
>   		}
> +		o = *obj;
>   	}
>   
>   	raw_spin_unlock_irqrestore(&db->lock, flags);
> -	if (!obj) {
> -		struct debug_obj o = { .object = addr,
> -				       .state = ODEBUG_STATE_NOTAVAILABLE,
> -				       .descr = descr };
> -
> -		debug_print_object(&o, "deactivate");
> -	} else if (print_object) {
> -		debug_print_object(obj, "deactivate");
> -	}
> +	debug_print_object(&o, "deactivate");
>   }
>   EXPORT_SYMBOL_GPL(debug_object_deactivate);
>   
> @@ -822,11 +793,9 @@ EXPORT_SYMBOL_GPL(debug_object_deactivate);
>    */
>   void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
>   {
> -	enum debug_obj_state state;
>   	struct debug_bucket *db;
> -	struct debug_obj *obj;
> +	struct debug_obj *obj, o;
>   	unsigned long flags;
> -	bool print_object = false;
>   
>   	if (!debug_objects_enabled)
>   		return;
> @@ -836,32 +805,31 @@ void debug_object_destroy(void *addr, const struct debug_obj_descr *descr)
>   	raw_spin_lock_irqsave(&db->lock, flags);
>   
>   	obj = lookup_object(addr, db);
> -	if (!obj)
> -		goto out_unlock;
> +	if (!obj) {
> +		raw_spin_unlock_irqrestore(&db->lock, flags);
> +		return;
> +	}
>   
>   	switch (obj->state) {
> +	case ODEBUG_STATE_ACTIVE:
> +	case ODEBUG_STATE_DESTROYED:
> +		break;
>   	case ODEBUG_STATE_NONE:
>   	case ODEBUG_STATE_INIT:
>   	case ODEBUG_STATE_INACTIVE:
>   		obj->state = ODEBUG_STATE_DESTROYED;
> -		break;
> -	case ODEBUG_STATE_ACTIVE:
> -		state = obj->state;
> +		fallthrough;
> +	default:
>   		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		debug_print_object(obj, "destroy");
> -		debug_object_fixup(descr->fixup_destroy, addr, state);
>   		return;
> -
> -	case ODEBUG_STATE_DESTROYED:
> -		print_object = true;
> -		break;
> -	default:
> -		break;
>   	}
> -out_unlock:
> +
> +	o = *obj;
>   	raw_spin_unlock_irqrestore(&db->lock, flags);
> -	if (print_object)
> -		debug_print_object(obj, "destroy");
> +	debug_print_object(&o, "destroy");
> +
> +	if (o.state == ODEBUG_STATE_ACTIVE)
> +		debug_object_fixup(descr->fixup_destroy, addr, o.state);
>   }
>   EXPORT_SYMBOL_GPL(debug_object_destroy);
>   
> @@ -872,9 +840,8 @@ EXPORT_SYMBOL_GPL(debug_object_destroy);
>    */
>   void debug_object_free(void *addr, const struct debug_obj_descr *descr)
>   {
> -	enum debug_obj_state state;
>   	struct debug_bucket *db;
> -	struct debug_obj *obj;
> +	struct debug_obj *obj, o;
>   	unsigned long flags;
>   
>   	if (!debug_objects_enabled)
> @@ -885,24 +852,26 @@ void debug_object_free(void *addr, const struct debug_obj_descr *descr)
>   	raw_spin_lock_irqsave(&db->lock, flags);
>   
>   	obj = lookup_object(addr, db);
> -	if (!obj)
> -		goto out_unlock;
> +	if (!obj) {
> +		raw_spin_unlock_irqrestore(&db->lock, flags);
> +		return;
> +	}
>   
>   	switch (obj->state) {
>   	case ODEBUG_STATE_ACTIVE:
> -		state = obj->state;
> -		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		debug_print_object(obj, "free");
> -		debug_object_fixup(descr->fixup_free, addr, state);
> -		return;
> +		break;
>   	default:
>   		hlist_del(&obj->node);
>   		raw_spin_unlock_irqrestore(&db->lock, flags);
>   		free_object(obj);
>   		return;
>   	}
> -out_unlock:
> +
> +	o = *obj;
>   	raw_spin_unlock_irqrestore(&db->lock, flags);
> +	debug_print_object(&o, "free");
> +
> +	debug_object_fixup(descr->fixup_free, addr, o.state);
>   }
>   EXPORT_SYMBOL_GPL(debug_object_free);
>   
> @@ -954,10 +923,10 @@ void
>   debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
>   			  unsigned int expect, unsigned int next)
>   {
> +	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
>   	struct debug_bucket *db;
>   	struct debug_obj *obj;
>   	unsigned long flags;
> -	bool print_object = false;
>   
>   	if (!debug_objects_enabled)
>   		return;
> @@ -970,28 +939,20 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
>   	if (obj) {
>   		switch (obj->state) {
>   		case ODEBUG_STATE_ACTIVE:
> -			if (obj->astate == expect)
> +			if (obj->astate == expect) {
>   				obj->astate = next;
> -			else
> -				print_object = true;
> +				raw_spin_unlock_irqrestore(&db->lock, flags);
> +				return;
> +			}
>   			break;
> -
>   		default:
> -			print_object = true;
>   			break;
>   		}
> +		o = *obj;
>   	}
>   
>   	raw_spin_unlock_irqrestore(&db->lock, flags);
> -	if (!obj) {
> -		struct debug_obj o = { .object = addr,
> -				       .state = ODEBUG_STATE_NOTAVAILABLE,
> -				       .descr = descr };
> -
> -		debug_print_object(&o, "active_state");
> -	} else if (print_object) {
> -		debug_print_object(obj, "active_state");
> -	}
> +	debug_print_object(&o, "active_state");
>   }
>   EXPORT_SYMBOL_GPL(debug_object_active_state);
>   
> @@ -999,11 +960,9 @@ EXPORT_SYMBOL_GPL(debug_object_active_state);
>   static void __debug_check_no_obj_freed(const void *address, unsigned long size)
>   {
>   	unsigned long flags, oaddr, saddr, eaddr, paddr, chunks;
> -	const struct debug_obj_descr *descr;
> -	enum debug_obj_state state;
>   	struct debug_bucket *db;
>   	struct hlist_node *tmp;
> -	struct debug_obj *obj;
> +	struct debug_obj *obj, o;
>   	int cnt, objs_checked = 0;
>   
>   	saddr = (unsigned long) address;
> @@ -1026,12 +985,11 @@ static void __debug_check_no_obj_freed(const void *address, unsigned long size)
>   
>   			switch (obj->state) {
>   			case ODEBUG_STATE_ACTIVE:
> -				descr = obj->descr;
> -				state = obj->state;
> +				o = *obj;
>   				raw_spin_unlock_irqrestore(&db->lock, flags);
> -				debug_print_object(obj, "free");
> -				debug_object_fixup(descr->fixup_free,
> -						   (void *) oaddr, state);
> +				debug_print_object(&o, "free");
> +				debug_object_fixup(o.descr->fixup_free,
> +						   (void *) oaddr, o.state);
>   				goto repeat;
>   			default:
>   				hlist_del(&obj->node);
> 
> ---
> base-commit: 201c8a7bd1f3f415920a2df4b8a8817e973f42fe
> change-id: 20231025-debugobjects_fix-66e5292557c4
> 
> Best regards,

