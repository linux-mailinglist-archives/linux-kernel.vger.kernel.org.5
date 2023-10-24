Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5987D5075
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjJXM4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjJXM4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:56:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D390610C0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 05:56:48 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698152207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0k8EHTgBuYIMb5TY+j+PPtTNGdHZXI6Ls9DQ9MAsNmk=;
        b=rLBcBr8dvCVZuquAzh672WEPpfBrFWcikNj5FTfBv9PZnSF3iMSIWacvbOCZgMnEDajR3z
        GfmwbayApVpSZChqvv8adT2Mcenm5s4bNnh8KprmpziVvtXgZCoZUdC2xyMdFZTzTFGkbg
        mBjyJ2qaFhWJVKQhx2bNwFm/UQd9XCRZyC0f0MYf1GDVqLHlToLAyvTZOcIbJoQ0khNjzq
        12PPHQtWB0yY7tRqjqGfnncDkxEoY/DBluzkn7QFAF5KhSMLvzXqW6AbhKtbp/9Gx8bKVm
        jab0H2JIALcE4ADMf7Rcfzy44VhzYPyZW3SXGn1DPzsvFa97Slm14+/TwooUMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698152207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0k8EHTgBuYIMb5TY+j+PPtTNGdHZXI6Ls9DQ9MAsNmk=;
        b=HxurSiTuKO2wgC3txgFea08jZZeAAJs30rR0Ke9IgRU24WtZGATMAAdfbbvR7s2lDkpLTQ
        GnYhPtF3hQn+XxCQ==
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Subject: Re: [PATCH v2] debugobjects: stop accessing objects after releasing
 spinlock
In-Reply-To: <20230925131359.2948827-1-andrzej.hajda@intel.com>
References: <20230925131359.2948827-1-andrzej.hajda@intel.com>
Date:   Tue, 24 Oct 2023 14:56:47 +0200
Message-ID: <874jigch68.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25 2023 at 15:13, Andrzej Hajda wrote:
> @@ -620,9 +620,8 @@ static void debug_objects_fill_pool(void)
>  static void
>  __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack)
>  {
> -	enum debug_obj_state state;
>  	struct debug_bucket *db;
> -	struct debug_obj *obj;
> +	struct debug_obj *obj, o;
>  	unsigned long flags;
>  
>  	debug_objects_fill_pool();
> @@ -644,23 +643,19 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>  	case ODEBUG_STATE_INACTIVE:
>  		obj->state = ODEBUG_STATE_INIT;
>  		break;
> -
> -	case ODEBUG_STATE_ACTIVE:
> -		state = obj->state;
> -		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		debug_print_object(obj, "init");
> -		debug_object_fixup(descr->fixup_init, addr, state);
> -		return;
> -
> -	case ODEBUG_STATE_DESTROYED:
> -		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		debug_print_object(obj, "init");
> -		return;
>  	default:
> -		break;
> +		o = *obj;
> +		obj = NULL;
>  	}
>  
>  	raw_spin_unlock_irqrestore(&db->lock, flags);
> +
> +	if (obj)
> +		return;

Hmm. I'd rather write is this way:

 	case ODEBUG_STATE_INIT:
 	case ODEBUG_STATE_INACTIVE:
 		obj->state = ODEBUG_STATE_INIT;
 		raw_spin_unlock_irqrestore(&db->lock, flags);
 		return;
 	default:
 		break;
 	}
 
	o = *obj;
 	raw_spin_unlock_irqrestore(&db->lock, flags);

	debug_print_object(&o, "init");
	if (o.state == ODEBUG_STATE_ACTIVE)
		debug_object_fixup(descr->fixup_init, addr, o.state);

This spares the 'obj' pointer modification and the conditional. The
extra raw_spin_unlock_irqrestore() is not the end of the world.

>  void debug_object_activate(void *addr, const struct debug_obj_descr *descr)
...
>  		default:
> -			ret = 0;
>  			break;
>  		}
> -		raw_spin_unlock_irqrestore(&db->lock, flags);
> -		if (print_object)
> -			debug_print_object(obj, "activate");
> -		return ret;
> +	} else {
> +		o.object = addr;
> +		o.state = ODEBUG_STATE_NOTAVAILABLE;
> +		o.descr = descr;
> +		obj = NULL;

Hrmm. Just keep the

	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };

around and get rid of this else clause.

>  	}
>  
>  	raw_spin_unlock_irqrestore(&db->lock, flags);
>  
> -	/* If NULL the allocation has hit OOM */
> -	if (!obj) {
> -		debug_objects_oom();
> +	if (obj)
>  		return 0;

Plus a similar change as above to get rid of this conditional and just
have the failure path here.

> @@ -788,30 +777,29 @@ void debug_object_deactivate(void *addr, const struct debug_obj_descr *descr)
>  		case ODEBUG_STATE_INIT:
>  		case ODEBUG_STATE_INACTIVE:
>  		case ODEBUG_STATE_ACTIVE:
> -			if (!obj->astate)
> +			if (!obj->astate) {
>  				obj->state = ODEBUG_STATE_INACTIVE;
> -			else
> -				print_object = true;
> -			break;
> -
> +				break;
> +			}
> +			fallthrough;
>  		case ODEBUG_STATE_DESTROYED:
> -			print_object = true;
> +			o = *obj;
> +			obj = NULL;
>  			break;
>  		default:
>  			break;
>  		}
> +	} else {
> +		o.object = addr;
> +		o.state = ODEBUG_STATE_NOTAVAILABLE;
> +		o.descr = descr;
> +		obj = NULL;
>  	}

Same here.
	struct debug_obj o = { .object = addr, .state = ODEBUG_STATE_NOTAVAILABLE, .descr = descr };
        ...
        
 	if (obj) {
 		switch (obj->state) {
		case ODEBUG_STATE_DESTROYED:
			o = *obj;
			break;
 		case ODEBUG_STATE_INIT:
 		case ODEBUG_STATE_INACTIVE:
 		case ODEBUG_STATE_ACTIVE:
			if (obj->astate) {
				o = *obj;
				break;
			}
			obj->state = ODEBUG_STATE_INACTIVE;
			fallthrough;
 		default:
			raw_spin_unlock_irqrestore(&db->lock, flags);
			return;
 		}
 	}

 	raw_spin_unlock_irqrestore(&db->lock, flags);
	debug_print_object(&o, "deactivate");

Hmm?

> @@ -970,28 +962,27 @@ debug_object_active_state(void *addr, const struct debug_obj_descr *descr,
>  	if (obj) {
>  		switch (obj->state) {
>  		case ODEBUG_STATE_ACTIVE:
> -			if (obj->astate == expect)
> +			if (obj->astate == expect) {
>  				obj->astate = next;
> -			else
> -				print_object = true;
> -			break;
> -
> +				break;
> +			}
> +			fallthrough;
>  		default:
> -			print_object = true;
> +			o = *obj;
> +			obj = NULL;
>  			break;
>  		}
> +	} else {
> +		o.object = addr;
> +		o.state = ODEBUG_STATE_NOTAVAILABLE;
> +		o.descr = descr;
> +		obj = NULL;
>  	}

Same pattern here.
  
Thanks,

        tglx
