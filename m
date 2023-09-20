Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409E07A835F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbjITN2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjITN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:28:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21E091
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695216527; x=1726752527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WxMtIZ61Id7gLIhG9mLeL9QFJJu0t4qZaBV1PGf0U0c=;
  b=AIrW76fAbc3Y9QKVXha4fa1TQ5O/8Ec3uoHJvN7MNxq6hq5vAtLAdodX
   uxDhLV/96rurSakeIOLqgRWBNfuvkBYGvOL9tJLua+qKW/nuR34pJxYaZ
   w760q5aSiYNrgwF+YGaymuqJWNH8brLe8N9F7g/WZyZw61OrQsMagHC43
   /rNL2bkZV5UvUhcQKvna4C+lE0AvjkfjikO6S8iQvXOEq3c3MzCLcB+kl
   hQp28jQ6JTq8nFq5EkT/un5aBhYyO4Q7y0GHWn7SZzH8YMqWa2thoO/2z
   vb5WvRJEg2L8tJe3vDLq3vPQiqfQTuiI6q2WMvWavlvWjNuY/4fez7Fbj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="365276846"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="365276846"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="836843556"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="836843556"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 06:28:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qixFu-0000000DUbC-3Eh1;
        Wed, 20 Sep 2023 16:28:38 +0300
Date:   Wed, 20 Sep 2023 16:28:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH printk v2 09/11] panic: Add atomic write enforcement to
 oops
Message-ID: <ZQrzhh62pDB5yUyi@smile.fi.intel.com>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-10-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-10-john.ogness@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 01:14:54AM +0206, John Ogness wrote:
> Invoke the atomic write enforcement functions for oops to
> ensure that the information gets out to the consoles.
> 
> Since there is no single general function that calls both
> oops_enter() and oops_exit(), the nesting feature of atomic
> write sections is taken advantage of in order to guarantee
> full coverage between the first oops_enter() and the last
> oops_exit().
> 
> It is important to note that if there are any legacy consoles
> registered, they will be attempting to directly print from the
> printk-caller context, which may jeopardize the reliability of
> the atomic consoles. Optimally there should be no legacy
> consoles registered.

...

> +	if (atomic_read(&oops_cpu) == smp_processor_id()) {
> +		oops_nesting--;
> +		if (oops_nesting == 0) {
> +			atomic_set(&oops_cpu, -1);

Between read and set the variable can change, can't it?
If not, why this variable is atomic then? Or, why it's not a problem?
If the latter is the case, perhaps a comment to explain this?

> +			/* Exit outmost atomic section. */
> +			nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, oops_prev_prio);
> +		}
> +	}
> +	put_cpu();

-- 
With Best Regards,
Andy Shevchenko


