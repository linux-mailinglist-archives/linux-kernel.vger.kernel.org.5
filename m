Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCD777B8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjHNM3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjHNM2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:28:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0159CCC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692016126; x=1723552126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cpc4XVuM51SJ2B/O4lQNuNKlc1XAvLGUzgMfcbN3Plk=;
  b=bGyjhBaPcqSf0s0jL/HRCgE+GpTaVwU8WSXDWV/JanpSBv3oVD3Bo+87
   sw19wJDrR2inHqnZyycSmmcYq9+cE6TB+QnniVgf8S74JbzSO+VvVzdvF
   2VfXcdFWxGty3PBy6Qi6X4rmfUojBgB3lTVyit/PlHpN7IcbY0XBBXCKa
   5gotASGwX1E9yXtNG9Fd40Rm+i9t7o9ATlODkEfRjBlO6pjm1dTjp2au7
   q46E5AJJgKMf4PAUkWOIYnkwya/GY4rV9iDBuppXNJNc8zdT2Ot8IBC8Q
   +6O/dE1UUm1vAYNV0qUJDBHO7xQPK6PVsPMlR7MMMXzdX1eGunH46wfiQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="352353560"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="352353560"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 05:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="823434944"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="823434944"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 14 Aug 2023 05:28:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVWgb-004XHM-19;
        Mon, 14 Aug 2023 15:28:41 +0300
Date:   Mon, 14 Aug 2023 15:28:41 +0300
From:   'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Petr Mladek' <pmladek@suse.com>, Marco Elver <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Split out sprintf() and friends
Message-ID: <ZNod+ewgF6Ginms1@smile.fi.intel.com>
References: <20230805175027.50029-1-andriy.shevchenko@linux.intel.com>
 <20230805175027.50029-3-andriy.shevchenko@linux.intel.com>
 <ZNEHt564a8RCLWon@alley>
 <ZNEJQkDV81KHsJq/@smile.fi.intel.com>
 <ZNEJm3Mv0QqIv43y@smile.fi.intel.com>
 <ZNEKNWJGnksCNJnZ@smile.fi.intel.com>
 <ZNHjrW8y_FXfA7N_@alley>
 <900a99a7c90241698c8a2622ca20fa96@AcuMS.aculab.com>
 <ZNTifGaJdQ588/B5@smile.fi.intel.com>
 <da520d6fa03c4645a28e5f4fae013d35@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da520d6fa03c4645a28e5f4fae013d35@AcuMS.aculab.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 08:12:55AM +0000, David Laight wrote:
> From: Andy Shevchenko
> > Sent: 10 August 2023 14:14
> > On Wed, Aug 09, 2023 at 08:48:54AM +0000, David Laight wrote:

...

> > > > If you split headers into so many small pieces then all
> > > > source files will start with 3 screens of includes. I do not see
> > > > how this helps with maintainability.
> > >
> > > You also slow down compilations.
> > 
> > Ingo's patches showed the opposite. Do you have actual try and numbers?
> 
> The compiler has to open the extra file on every compile.
> If you include it from lots of different places it has to open
> it for each one (to find the include guard).
> Any attempted compiler optimisations have the same much the
> same problem as #pragma once.
> 
> With a long -I list even finding the file can take a while.
> 
> Probably most obvious when using NFS mounted filesystems.
> Especially the 'traditional' NFS protocol that required a
> message 'round trip' for each element of the directory path.

Right, as I said come up with numbers. Ingo did that, so can you.
His numbers shows _increase_ of build speed.

-- 
With Best Regards,
Andy Shevchenko


