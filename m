Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164F770841
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjHDSzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 14:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjHDSzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 14:55:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513CBA9;
        Fri,  4 Aug 2023 11:55:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D2CD521867;
        Fri,  4 Aug 2023 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691175317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FgAE7IQjxwVpfA4jlJ9XZGVZDnKgpMUh8daSva5w7kE=;
        b=YxdJS32Eg0ImYWEMH1ZHvwEnnUz5x8G7wXa7cq59/GZSToTCAXo6r6mUYSayInK+jPgWil
        snwEYCsecwTFsNvA1Tu95TUyCb+YHPLNqzco2pwzLxpptXKvGoaS1gR3kquonCYLf32O9C
        VKGmirsODf1QEKTN0M1mOSqMWkYmgO4=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 658202C142;
        Fri,  4 Aug 2023 18:55:17 +0000 (UTC)
Date:   Fri, 4 Aug 2023 20:55:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
Message-ID: <ZM1Jk9s3gRYLyagW@alley>
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
 <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-08-01 15:54:45, Rob Herring wrote:
> While originally it was fine to format strings using "%pOF" while
> holding devtree_lock, this now causes a deadlock.  Lockdep reports:
> 
>     of_get_parent from of_fwnode_get_parent+0x18/0x24
>     ^^^^^^^^^^^^^
>     of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
>     fwnode_count_parents from fwnode_full_name_string+0x18/0xac
>     fwnode_full_name_string from device_node_string+0x1a0/0x404
>     device_node_string from pointer+0x3c0/0x534
>     pointer from vsnprintf+0x248/0x36c
>     vsnprintf from vprintk_store+0x130/0x3b4
> 
> To fix this, move the printing in __of_changeset_entry_apply() outside the
> lock. As there's already similar printing of the same changeset actions,
> refactor all of them to use a common action print function. This has the
> side benefit of getting rid of some ifdefs.
> 
> Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Rob Herring <robh@kernel.org>

> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -63,37 +63,31 @@ int of_reconfig_notifier_unregister(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(of_reconfig_notifier_unregister);
>  
> -#ifdef DEBUG
> -const char *action_names[] = {
> +static const char *action_names[] = {
>  	[OF_RECONFIG_ATTACH_NODE] = "ATTACH_NODE",
>  	[OF_RECONFIG_DETACH_NODE] = "DETACH_NODE",
>  	[OF_RECONFIG_ADD_PROPERTY] = "ADD_PROPERTY",
>  	[OF_RECONFIG_REMOVE_PROPERTY] = "REMOVE_PROPERTY",
>  	[OF_RECONFIG_UPDATE_PROPERTY] = "UPDATE_PROPERTY",
>  };
> -#endif
> +
> +static void of_changeset_action_print(unsigned long action, struct device_node *np,
> +				      const char *prop_name)
> +{
> +	if (prop_name)
> +		pr_cont("%-15s %pOF:%s\n", action_names[action], np, prop_name);

Note that pr_cont() does not guarantee that the message will be appended to the
previous part. Any message printed from another CPU or interrupt
context might break the two pieces.

It is better to avoid pr_cont() when possible.

> +	else
> +		pr_cont("%-15s %pOF\n", action_names[action], np);
> +}
>  
>  int of_reconfig_notify(unsigned long action, struct of_reconfig_data *p)
>  {
>  	int rc;
> -#ifdef DEBUG
>  	struct of_reconfig_data *pr = p;
>  
> -	switch (action) {
> -	case OF_RECONFIG_ATTACH_NODE:
> -	case OF_RECONFIG_DETACH_NODE:
> -		pr_debug("notify %-15s %pOF\n", action_names[action],
> -			pr->dn);
> -		break;
> -	case OF_RECONFIG_ADD_PROPERTY:
> -	case OF_RECONFIG_REMOVE_PROPERTY:
> -	case OF_RECONFIG_UPDATE_PROPERTY:
> -		pr_debug("notify %-15s %pOF:%s\n", action_names[action],
> -			pr->dn, pr->prop->name);
> -		break;
> +	if (pr_debug("notify "))
> +		of_changeset_action_print(action, pr->dn, pr->prop ? pr->prop->name : NULL);

If you really want to simplify this, then I would do:

	pr_debug("notify %-15s %pOF%s%s\n",
		  action_names[action], pr->dn,
		  pr->prop ? ":" : ",
		  pr->prop ? pr->prop->name : "");



> -	}
> -#endif
>  	rc = blocking_notifier_call_chain(&of_reconfig_chain, action, p);
>  	return notifier_to_errno(rc);
>  }
> @@ -599,7 +569,8 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
>  	unsigned long flags;
>  	int ret = 0;
>  
> -	__of_changeset_entry_dump(ce);
> +	if (pr_debug("changeset: applying: cset<%p> ", ce))
> +		of_changeset_action_print(ce->action, ce->np, ce->prop ? ce->prop->name : NULL);

One possibility would be to create a macro for this, something like:

#define of_ce_action_print(printk_level, prefix, ce)		\
	printk(printk_level "%s cset<%p> %-15s %pOF%s%s\n"	\
		prefix, ce, action_names[action], pr->dn,	\
		  pr->prop ? ":" : ",				\
		  pr->prop ? pr->prop->name : "");

And use it like:

	of_ce_action_print(KERN_DEBUG, "changeset: applying:", ce);

But I am not sure if it is worth it. Sometimes it is better to
opencode things so that it is clear what is going on.


>  
>  	raw_spin_lock_irqsave(&devtree_lock, flags);
>  	switch (ce->action) {
> @@ -620,21 +591,9 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
>  		}
>  
>  		ret = __of_add_property(ce->np, ce->prop);
> -		if (ret) {
> -			pr_err("changeset: add_property failed @%pOF/%s\n",
> -				ce->np,
> -				ce->prop->name);
> -			break;
> -		}
>  		break;
>  	case OF_RECONFIG_REMOVE_PROPERTY:
>  		ret = __of_remove_property(ce->np, ce->prop);
> -		if (ret) {
> -			pr_err("changeset: remove_property failed @%pOF/%s\n",
> -				ce->np,
> -				ce->prop->name);
> -			break;
> -		}
>  		break;
>  
>  	case OF_RECONFIG_UPDATE_PROPERTY:
> @@ -648,20 +607,17 @@ static int __of_changeset_entry_apply(struct of_changeset_entry *ce)
>  		}
>  
>  		ret = __of_update_property(ce->np, ce->prop, &old_prop);
> -		if (ret) {
> -			pr_err("changeset: update_property failed @%pOF/%s\n",
> -				ce->np,
> -				ce->prop->name);
> -			break;
> -		}
>  		break;
>  	default:
>  		ret = -EINVAL;
>  	}
>  	raw_spin_unlock_irqrestore(&devtree_lock, flags);
>  
> -	if (ret)
> +	if (ret) {
> +		pr_err("changeset: apply failed: cset<%p> ", ce);
> +		of_changeset_action_print(ce->action, ce->np, ce->prop ? ce->prop->name : NULL);
>  		return ret;
> +	}
>  
>  	switch (ce->action) {
>  	case OF_RECONFIG_ATTACH_NODE:

I would suggest to split the changes into two so that the fix is in a
separate patch. And the fix should be first so that it might be
easier for backporting.

Best Regards,
Petr
