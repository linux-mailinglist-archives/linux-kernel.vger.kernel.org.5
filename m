Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591817D2F50
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233392AbjJWJ7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjJWJ7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:59:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DE11BE2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698055088; x=1729591088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g6hBckh9fabRbZrpBSj1AVoVBjo58Y4pA/dED85ORAE=;
  b=PCibxEcHOGfV+3D6ANbpzBc6CQHZTPUvF3dUJJVKjUpBl/lKDw+EMRNI
   KJXJ9QoYCB5uQ0f4MxW7ZWhMOSzVpIl7Ipio/xcH3CanCrf6rI0b98H7D
   xNjQ/u+1+KwGY/VZQiodMfHHAoV0s7yH5BNUzBTBvb/1KNG3tPJkLIyeA
   SWW/kgxzj0cNllJE+S6xwBd4IAHemtx15JkBM9zPwey8WqMBDD/togsz5
   wFAv/W3J6IfPlkTJ0GGpEGts5ZcG07Ver9ppAESeCeVWiQMShLnjSgQtg
   YL46n+173Pm7x/6AjrHJ2sA8O/QLPQ/6kQiYsbdYJCJc7epfulkTf2Xtu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="8362762"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="8362762"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:58:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="881708102"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="881708102"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 02:58:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qurh4-00000007tyr-1Sfh;
        Mon, 23 Oct 2023 12:57:54 +0300
Date:   Mon, 23 Oct 2023 12:57:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Justin Stitt <justinstitt@google.com>,
        Kent Overstreet <kent.overstreet@linux.dev>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [for-next][PATCH 5/6] tracing: Move readpos from seq_buf to
 trace_seq
Message-ID: <ZTZDocwUP9PU39Mg@smile.fi.intel.com>
References: <20231020222713.074741220@goodmis.org>
 <20231020222740.632819967@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020222740.632819967@goodmis.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 06:27:18PM -0400, Steven Rostedt wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> To make seq_buf more lightweight as a string buf, move the readpos member
> from seq_buf to its container, trace_seq.  That puts the responsibility
> of maintaining the readpos entirely in the tracing code.  If some future
> users want to package up the readpos with a seq_buf, we can define a
> new struct then.

> Link: https://lore.kernel.org/linux-trace-kernel/20231020033545.2587554-2-willy@infradead.org
> 

If we want Link: to be recognized as a tag, we probably should remove the blank
line. Maybe new versions of b4 support that, but not all maintainers use it and
AFAIK the convention was to have no blank lines in the tag block.

> Cc: Kees Cook <keescook@chromium.org>
> Cc: Justin Stitt <justinstitt@google.com>
> Cc: Kent Overstreet <kent.overstreet@linux.dev>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>


-- 
With Best Regards,
Andy Shevchenko


