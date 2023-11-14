Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF20B7EAEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjKNL3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjKNL3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:29:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23083D4B;
        Tue, 14 Nov 2023 03:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699961330; x=1731497330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MwCebFLNCTKXnc6Eih1e4puMMQQyAYKkmQMcqyuQuTk=;
  b=aSzoGPZ8HznP7lkImOGccDirjcL5yLlvD2fdhschyldCEj2261XP4WB4
   tn0OtkHhwfkyZI9IzMYXE1OD+S6myaFVc77JN+oSd+Jb8WIWLCruyuXxU
   kxZUEX8IaP9kyZAhNRTbQbdL+hyNvbgupiy5/RNlRl9F7OHnc0G+EaeJB
   VUlzBaQ0l8VLh06TiWPW8Ew++NbpIpRi8JClW0QKgsXVDuAyyjK0pYrWm
   SLR6/sChYS1JF3e3A9+/WPuJYsEZQV4SkXNt4r63Sp5aaT0kHgoHq9HzH
   9OR7AoLkuSxntn57/TwDTRrZheNktkd0uUW8KXU2i1eL0SsdLDage5tsv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="457131167"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="457131167"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="768224189"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="768224189"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 03:28:46 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id A670411F7D1;
        Tue, 14 Nov 2023 13:28:43 +0200 (EET)
Date:   Tue, 14 Nov 2023 11:28:43 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] lib/vsprintf: Fix %pfwf when current node refcount
 == 0
Message-ID: <ZVNZ63HdoRKT4IQ9@kekkonen.localdomain>
References: <20231114110456.273844-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114110456.273844-1-herve.codina@bootlin.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herve,

Thanks for the patch.

On Tue, Nov 14, 2023 at 12:04:56PM +0100, Herve Codina wrote:
> A refcount issue can appeared in __fwnode_link_del() due to the
> pr_debug() call:
>   WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
>   Call Trace:
>   <TASK>
>   ? refcount_warn_saturate+0xe5/0x110
>   ? __warn+0x81/0x130
>   ? refcount_warn_saturate+0xe5/0x110
>   ? report_bug+0x191/0x1c0
>   ? srso_alias_return_thunk+0x5/0x7f
>   ? prb_read_valid+0x1b/0x30
>   ? handle_bug+0x3c/0x80
>   ? exc_invalid_op+0x17/0x70
>   ? asm_exc_invalid_op+0x1a/0x20
>   ? refcount_warn_saturate+0xe5/0x110
>   kobject_get+0x68/0x70
>   of_node_get+0x1e/0x30
>   of_fwnode_get+0x28/0x40
>   fwnode_full_name_string+0x34/0x90
>   fwnode_string+0xdb/0x140
>   vsnprintf+0x17b/0x630
>   va_format.isra.0+0x71/0x130
>   vsnprintf+0x17b/0x630
>   vprintk_store+0x162/0x4d0
>   ? srso_alias_return_thunk+0x5/0x7f
>   ? srso_alias_return_thunk+0x5/0x7f
>   ? srso_alias_return_thunk+0x5/0x7f
>   ? try_to_wake_up+0x9c/0x620
>   ? rwsem_mark_wake+0x1b2/0x310
>   vprintk_emit+0xe4/0x2b0
>   _printk+0x5c/0x80
>   __dynamic_pr_debug+0x131/0x160
>   ? srso_alias_return_thunk+0x5/0x7f
>   __fwnode_link_del+0x25/0xa0
>   fwnode_links_purge+0x39/0xb0
>   of_node_release+0xd9/0x180
>   kobject_put+0x7b/0x190
>   ...
> 
> Indeed, an fwnode (of_node) is being destroyed and so, of_node_release()
> is called because the of_node refcount reached 0.
> From of_node_release() several function calls are done and lead to
> a pr_debug() calls with %pfwf to print the fwnode full name.
> The issue is not present if we change %pfwf to %pfwP.
> 
> To print the full name, %pfwf iterates over the current node and its
> parents and obtain/drop a reference to all nodes involved.
> 
> In order to allow to print the full name (%pfwf) of a node while it is
> being destroyed, do not obtain/drop a reference to this current node.
> 
> Fixes: a92eb7621b9f ("lib/vsprintf: Make use of fwnode API to obtain node names and separators")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  lib/vsprintf.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index afb88b24fa74..74ef229c2783 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2108,8 +2108,8 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
>  {
>  	int depth;
>  
> -	/* Loop starting from the root node to the current node. */
> -	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> +	/* Loop starting from the root node to the parent of current node. */
> +	for (depth = fwnode_count_parents(fwnode); depth > 0; depth--) {
>  		struct fwnode_handle *__fwnode =
>  			fwnode_get_nth_parent(fwnode, depth);

How about, without changing the loop:

		/*
		 * Only get a reference for other nodes, fwnode refcount
		 * may be 0 here.
		 */
		struct fwnode_handle *__fwnode =
			depth ? fwnode_get_nth_parent(fwnode, depth) : fwnode;

>  
> @@ -2121,6 +2121,16 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
>  		fwnode_handle_put(__fwnode);

And:

		if (__fwnode != fwnode)
			fwnode_handle_put(__fwnode);

>  	}
>  
> +	/* Handle current node without calling fwnode_handle_{get,put}().
> +	 * This allows to print the full node name while the current node is
> +	 * being destroyed (ie print from a function called because of
> +	 * refcount == 0) without any refcount issues.
> +	 */
> +	buf = string(buf, end, fwnode_get_name_prefix(fwnode),
> +		     default_str_spec);
> +	buf = string(buf, end, fwnode_get_name(fwnode),
> +		     default_str_spec);

It'd avoid duplicating this part, too, which I find worth the while.

> +
>  	return buf;
>  }
>  

-- 
Kind regards,

Sakari Ailus
