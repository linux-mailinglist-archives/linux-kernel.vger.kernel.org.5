Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704C57EB2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjKNOrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:47:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjKNOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:47:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D94CA;
        Tue, 14 Nov 2023 06:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699973254; x=1731509254;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GiTo2oNKnQgB8DobzT7dE9XMXi3HGjrub1UPBLDMX/g=;
  b=c242ZyIul8sBVmnb+sLuaowENsF72Wbez9QyClprVcz/Nbp/ozrHZudG
   34/SVyopQ/9PtrYsqoKpQxFrhC0u0GVJc6arJ5ZHBqyLOo53K9GtdD4kq
   UQBImwcnBfUvcQ2m2rZ93lA3vdMdU3z7kaxLJg4hy2jv3yf8CS6AFYOSt
   U1nZ/rGJ98AMoDjzcySAICq/qtnXSogi/8DNB4Wx2S/323z0HiXbCJfYD
   nySzEcGrkUIYtfOZZ65dAkJt57jZHaPX4IEFKoRz4iZ36Uwd1gyG3h0j9
   lec/zAeV9cgZlRA1Wwn6GR2ehAPIv5Qny0KPOdvTFF4FCSSeDire5i4xL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12210151"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="12210151"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:47:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741110362"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741110362"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 06:47:29 -0800
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id E4C3C11FB5E;
        Tue, 14 Nov 2023 16:47:25 +0200 (EET)
Date:   Tue, 14 Nov 2023 14:47:25 +0000
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
Subject: Re: [PATCH v2 1/1] lib/vsprintf: Fix %pfwf when current node
 refcount == 0
Message-ID: <ZVOIfXV8al5hiMQD@kekkonen.localdomain>
References: <20231114143558.356259-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114143558.356259-1-herve.codina@bootlin.com>
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

On Tue, Nov 14, 2023 at 03:35:58PM +0100, Herve Codina wrote:
> A refcount issue can appeared in __fwnode_link_del() due to the
> pr_debug() call:
>   WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
>   Call Trace:
>   <TASK>
>   ...
>   of_node_get+0x1e/0x30
>   of_fwnode_get+0x28/0x40
>   fwnode_full_name_string+0x34/0x90
>   fwnode_string+0xdb/0x140
>   ...
>   vsnprintf+0x17b/0x630
>   ...
>   __fwnode_link_del+0x25/0xa0
>   fwnode_links_purge+0x39/0xb0
>   of_node_release+0xd9/0x180
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
> Changes v1 -> v2
>   - Avoid handling current node out of the loop. Instead obtain/drop references
>     in the loop based on the depth value.
>   - Remove some of the backtrace lines in the commit log.
> 
>  lib/vsprintf.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index afb88b24fa74..633f5481ac17 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2110,15 +2110,20 @@ char *fwnode_full_name_string(struct fwnode_handle *fwnode, char *buf,
>  
>  	/* Loop starting from the root node to the current node. */
>  	for (depth = fwnode_count_parents(fwnode); depth >= 0; depth--) {
> -		struct fwnode_handle *__fwnode =
> -			fwnode_get_nth_parent(fwnode, depth);
> +		/*
> +		 * Only get a reference for other nodes (ie parents node).

"i.e."

With that,

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> +		 * fwnode refcount may be 0 here.
> +		 */
> +		struct fwnode_handle *__fwnode = depth ?
> +			fwnode_get_nth_parent(fwnode, depth) : fwnode;
>  
>  		buf = string(buf, end, fwnode_get_name_prefix(__fwnode),
>  			     default_str_spec);
>  		buf = string(buf, end, fwnode_get_name(__fwnode),
>  			     default_str_spec);
>  
> -		fwnode_handle_put(__fwnode);
> +		if (depth)
> +			fwnode_handle_put(__fwnode);
>  	}
>  
>  	return buf;

-- 
Regards,

Sakari Ailus
