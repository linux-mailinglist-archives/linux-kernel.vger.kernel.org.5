Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1D97A4CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjIRPmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjIRPmY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:42:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6ACEA;
        Mon, 18 Sep 2023 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051664; x=1726587664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rLtLGIQAKTVI1t+psJ8kukyAGQb0vc5GrHLOZQiF/gQ=;
  b=m0UII/bdBjG3E36bOCGAtqjBPdrfb2y79Otbtw09brFqcxEslwD1j3uk
   Um/FWTU1EDvRkU/xOnj8Gj3FwwDK3PQFBWy5Le3DQPqXn76HD/xRayh/b
   JCk5anszCQ8Vduy+Jb0yym0dapOJWLCldX85gQm3abJBjHl8RSkirFbqW
   lK/HEwRDlEuCSPhPpXy30Cnd2jzi5qzrot2ab0Ja1G1Xv5MOofpn+LzTI
   ql9leJ++3aFnL5lvWhpOh9UIlS58LXjH7GzV4/qN7lyIGLzOkaz/wn+Cy
   KOCZCx62vc4mYvZuFakV2Au8oCMDyFc8OYJcB5B+JhK9rY5TOXIaj63Ot
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377008856"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="377008856"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:31:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="775170732"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="775170732"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 08:31:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qiGDp-0000000CeEP-03YZ;
        Mon, 18 Sep 2023 18:31:37 +0300
Date:   Mon, 18 Sep 2023 18:31:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4] gpio: sim: fix an invalid __free() usage
Message-ID: <ZQhtWNaCiHVu5yzL@smile.fi.intel.com>
References: <20230918145533.14642-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918145533.14642-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 04:55:33PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> gpio_sim_make_line_names() returns NULL or ERR_PTR() so we must not use
> __free(kfree) on the returned address. Split this function into two, one
> that determines the size of the "gpio-line-names" array to allocate and
> one that actually sets the names at correct offsets. The allocation and
> assignment of the managed pointer happens in between.

...

> +	unsigned int size = 0;
>  
>  	list_for_each_entry(line, &bank->line_list, siblings) {
> +		if (!line->name || (line->offset >= bank->num_lines))
>  			continue;
>  
> +		size = line->offset + 1;
>  	}
>  
> +	return size;

So, now the function iterates over all lines and returns the size of the last
match, correct?

Why not

	list_for_each_entry_reversed() {
		if (line->name && ())
			break;
	}

	return size;

?

...

> +static void
> +gpio_sim_set_line_names(struct gpio_sim_bank *bank, char **line_names)
> +{
> +	struct gpio_sim_line *line;
>  
>  	list_for_each_entry(line, &bank->line_list, siblings) {
> -		if (line->offset >= bank->num_lines)
> +		if (!line->name || (line->offset >= bank->num_lines))
>  			continue;
>  
> -		if (line->name && (line->offset <= max_offset))
> -			line_names[line->offset] = line->name;
> +		line_names[line->offset] = line->name;
>  	}
> -
> -	return line_names;
>  }

Can be done in the similar (I see the difference) way for the consistency with
above.

...

> +	line_names_size = gpio_sim_get_line_names_size(bank);

> +	if (line_names_size) {

Of course this can be replace with...

> +		line_names = kcalloc(line_names_size, sizeof(*line_names),
> +				     GFP_KERNEL);

> +		if (!line_names)

ZERO_OR_NULL_PTR() check here, but I assume we discourage use of it.

> +			return ERR_PTR(-ENOMEM);
> +
> +		gpio_sim_set_line_names(bank, line_names);
>  
> -	if (line_names)
>  		properties[prop_idx++] = PROPERTY_ENTRY_STRING_ARRAY_LEN(
>  						"gpio-line-names",
>  						line_names, line_names_size);
> +	}

-- 
With Best Regards,
Andy Shevchenko


