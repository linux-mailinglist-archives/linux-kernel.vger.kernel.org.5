Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0CE791908
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 15:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbjIDNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbjIDNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 09:45:12 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48C81737
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 06:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693835079; x=1725371079;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BZcWQn/M7knhOmNKLgxCKFVHsgds6q4lKcMqlJ3kHSQ=;
  b=HPAnRe8LnOgT054IDJlqwJi5Ust7T18bAERn8PDcvSRt0NrGa6cNd04/
   C8d/VcAom3XiGzz+nMdnAeWl5Dm/IfnWe6YBRLFRvKCCYbrhRo8B76esU
   KZ3RzeIoxRUXW8GtKfojNf2OvAdCZsSbaXsDgpN1NjvvaBEhVSklNukaw
   Cclxh0OfJ8SYwpG77fWz7lU6AX0kXXXaGhjLPo7hjILys/lnrCHi33U3n
   knFJGBCAV65utpC2uADj7fQieKcWKjlT5rG4ttEJ0L9lJh8dmMrj+4V34
   Ye3EuEO2JcTkU14fNLbKRe79ZXiUoDrDZOHkUJ9+o93FKcASgDEPXjfOi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="375493708"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="375493708"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 06:44:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10823"; a="830918080"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="830918080"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 06:44:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd9s9-006RaN-1A;
        Mon, 04 Sep 2023 16:44:09 +0300
Date:   Mon, 4 Sep 2023 16:44:09 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: [PATCH v1 1/3] parport: Use kasprintf() instead of fixed buffer
 formatting
Message-ID: <ZPXfKcaTW6TXR8rc@smile.fi.intel.com>
References: <CGME20230901134310eucas1p1d9be610c894d46f19bb6c12576aef94b@eucas1p1.samsung.com>
 <20230901134250.1172990-1-andriy.shevchenko@linux.intel.com>
 <20230904131145.tp4umorb3t25tmsq@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904131145.tp4umorb3t25tmsq@localhost>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 03:11:45PM +0200, Joel Granados wrote:
> On Fri, Sep 01, 2023 at 04:42:48PM +0300, Andy Shevchenko wrote:

Thank you for the review, my answers below.

...

> > @@ -431,8 +424,7 @@ int parport_proc_register(struct parport *port)
> >  {
> >  	struct parport_sysctl_table *t;
> >  	char *tmp_dir_path;
> > -	size_t tmp_path_len, port_name_len;
> > -	int bytes_written, i, err = 0;
> > +	int i, err = 0;
> >  
> >  	t = kmemdup(&parport_sysctl_template, sizeof(*t), GFP_KERNEL);
> >  	if (t == NULL)
> > @@ -446,35 +438,23 @@ int parport_proc_register(struct parport *port)
> For this function I would even go a step further and start with the two
> kasprintf calls so we can then free them in the reverse order. And then
> leave the rest as it is.

I'm not sure I see the big picture here. Can you draft what you are proposing
(showing only the lines that are important)?

> I attached an untested diff that applies on
> top of your changes to show you what I mean.

Ah, I see now, it's below. And how is it better?
(LoCs statistics seems to be the same, so...)

What is a downside in my opinion with your code is this line

	return 0; --> goto blablabla.

this makes code less maintainable.

OTOH we may do what you want, but it will take a bit more LoCs and honestly
I don't see the benefit of doing that as in both cases the variable used is
temporary. What may be the good solution here is to split the repetitive
code excerpt to the parameterized helper function. But this will be another
patch which you can build on top of this series, right?

...

> > diff --git a/include/linux/parport.h b/include/linux/parport.h
> > index 999eddd619b7..fff39bc30629 100644
> > --- a/include/linux/parport.h
> > +++ b/include/linux/parport.h
> > @@ -180,8 +180,6 @@ struct ieee1284_info {
> >  	struct semaphore irq;
> >  };
> >  
> > -#define PARPORT_NAME_MAX_LEN 15
> This variable protected against port->name not ending in '\0'. Anyone
> worried that kasprintf could be unbounded?

I'm lost here. kasprintf() guarantees the NUL-termination. Any other concerns?

-- 
With Best Regards,
Andy Shevchenko


