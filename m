Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0595A7EB0A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjKNNN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjKNNNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:13:25 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEEC719D;
        Tue, 14 Nov 2023 05:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699967601; x=1731503601;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=615MD5nkn7JkyN4xZpVO/ZoKT90VKtVl8ldiXoiXB2c=;
  b=cJ+9bhNHOKjLLdiOR/gnRC/i+gpQRvAFqlqHVSqPWPXmgYkq8QbN1jYo
   pkBncVnalYZJ3gV862j6504L9vJcIyCKUMiOQD0Q/9vcj1KwF9zFllrHv
   xl9nWq+VOTPKhkAEC+ulNZwq2R+yxYcqIe49hpy/6YRJHGxkhmBTheOku
   1nb2xoaowculk4dFsADXAYbcct/u+dS5ltcu899vljKUvAYZn9scS1ELS
   xO2+u+gGzRN3Vfv/AFbFY8/sFnfXqsiqmDwwm5Af/ylhcSzVPzTOWnv9Y
   aw888/ImheGOXOXP7UJ2wpwe9nSLcEWjLbQrxt023i4ZyydK6OwzdBxgM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="390444153"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="390444153"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 05:12:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="855274187"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="855274187"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 05:12:51 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2tDj-0000000Dos3-41HX;
        Tue, 14 Nov 2023 15:12:47 +0200
Date:   Tue, 14 Nov 2023 15:12:47 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] lib/vsprintf: Fix %pfwf when current node refcount
 == 0
Message-ID: <ZVNyT6qTw6mpy6BY@smile.fi.intel.com>
References: <20231114110456.273844-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114110456.273844-1-herve.codina@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Please, do not put so many unrelated lines of backtrace in the commit message.
Leave only the important ones (the Submitting Patches document suggests some
like ~3-5 lines only).

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

-- 
With Best Regards,
Andy Shevchenko


