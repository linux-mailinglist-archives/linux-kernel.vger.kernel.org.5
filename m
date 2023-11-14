Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDDA7EB0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjKNN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:28:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjKNN16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:27:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861F71A1;
        Tue, 14 Nov 2023 05:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699968475; x=1731504475;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d5U20eRXmG1QWxY9GBKXPXoLC/XUzDWALfgg1Q5yC04=;
  b=jg2VpkU08BQFiKxzk5Mq6q3hAUCaSDNb2tG8E5KRP/rNEGXZamECfC/8
   0UMut3hetU/g6ZhRfgShSdeBGBerio1J38d+6F5on0zB8hAY3A8rjYt4G
   gJPVhUehg3H8BeaIqN5O/kRxgfbguzwnVFR7yt/tBj/b7e+oyNTChKUjD
   hmIo77Mj2odONoKLqZi5F1O2+K7RqyBjd9ZaxqzAYOCVp4HOnCM8Rn/Ls
   i4jNTAmzH7BwOLk7uXSU5tbUbCoto+/5dtarWK1RgE1mrFz9FYU1O4IyF
   Ef3dq47lfqDpvWCFBoWUhlZwUgsPWwb/WHBX262OBKkB1Ln0KO315VO12
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="421751295"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="421751295"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 05:27:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="741092612"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="741092612"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 05:27:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r2tSB-0000000Dp3m-3h5E;
        Tue, 14 Nov 2023 15:27:43 +0200
Date:   Tue, 14 Nov 2023 15:27:43 +0200
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
Message-ID: <ZVN1z5zuCRhVQ2Kw@smile.fi.intel.com>
References: <20231114110456.273844-1-herve.codina@bootlin.com>
 <ZVNyT6qTw6mpy6BY@smile.fi.intel.com>
 <20231114141934.1b0d44e2@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114141934.1b0d44e2@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2023 at 02:19:34PM +0100, Herve Codina wrote:
> On Tue, 14 Nov 2023 15:12:47 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Nov 14, 2023 at 12:04:56PM +0100, Herve Codina wrote:
> > > A refcount issue can appeared in __fwnode_link_del() due to the
> > > pr_debug() call:  

---8<---

> > >   WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
> > >   Call Trace:

> > >   ? refcount_warn_saturate+0xe5/0x110

	...
> > >   of_node_get+0x1e/0x30
> > >   of_fwnode_get+0x28/0x40
> > >   fwnode_full_name_string+0x34/0x90
> > >   fwnode_string+0xdb/0x140
	...

> > >   vsnprintf+0x17b/0x630
	...
> > >   __fwnode_link_del+0x25/0xa0
> > >   fwnode_links_purge+0x39/0xb0
> > >   of_node_release+0xd9/0x180
	...

---8<---

> > Please, do not put so many unrelated lines of backtrace in the commit message.
> > Leave only the important ones (the Submitting Patches document suggests some
> > like ~3-5 lines only).
> 
> Ok, I will remove some of them.

Thanks (my suggestion is above).

-- 
With Best Regards,
Andy Shevchenko


