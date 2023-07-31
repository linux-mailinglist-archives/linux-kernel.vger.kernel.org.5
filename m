Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07F7F76A0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbjGaTFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbjGaTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:05:16 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA921BEF;
        Mon, 31 Jul 2023 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690830309; x=1722366309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3HaLW+YJQkDqjakHwU6yyex4wVfQOsIcRsqp+3k46gw=;
  b=eSFsHZof8hNwfMBNEUH+YNZBuRL73NFYH4IETjbKmGY7MjwmVg67VSPn
   mUVOYg6oJRX8b1aDT5bKI0DhZr3KxTNfBm63uQz8/zi139k3rvoYPQUM7
   o9rwryokQm4P+cWDKj0aXKnfLsdL9EZSGf4LyPtBAcJcrRNKcNGapcSYf
   WPw94v+QEFrjJe9ApJLrA4a3UtyzF5DUGfoTl69CwxxB32gMBpkpnlR4y
   tthBHWocwLlWFhS3sarmuDjGxOF2CVExCAoRJmqfai+iB3iksj0uOIgqm
   r9kF7/TqC+R9PDrpC68pQJW2C/GnJ+VpXVJB3NDzc+AJyctHFPv3W//PO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="354029269"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="354029269"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 12:05:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="974996260"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="974996260"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 12:05:05 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 7EDAF11F9B6;
        Mon, 31 Jul 2023 22:05:02 +0300 (EEST)
Date:   Mon, 31 Jul 2023 19:05:02 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Satish Nagireddy <satish.nagireddy@getcruise.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/9] media: i2c: ds90ub9x3: Fix sub-device matching
Message-ID: <ZMgF3pxyx+BCXNN+@kekkonen.localdomain>
References: <20230731-fpdlink-additions-v3-0-8acfc49c215a@ideasonboard.com>
 <20230731-fpdlink-additions-v3-1-8acfc49c215a@ideasonboard.com>
 <20230731144356.GA30939@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731144356.GA30939@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Mon, Jul 31, 2023 at 05:43:56PM +0300, Laurent Pinchart wrote:
> Hi Tomi,
> 
> Thank you for the patch.
> 
> On Mon, Jul 31, 2023 at 04:24:35PM +0300, Tomi Valkeinen wrote:
> > 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode
> 
> s/^/Commit /
> 
> > matching") recently changed how async sub-device matching works. This
> > breaks the UB9x3 drivers, as they set the subdev.fwnode to an endpoint.
> > Afaiu, the fix is simply to not set subdev.fwnode at all.
> > 
> > Fixes: 1029939b3782 ("media: v4l: async: Simplify async sub-device fwnode matching")
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> Sakari, was the v4l2-async series meant to break these drivers ? I
> understand the two series got merged for the same kernel version, is
> this a merge conflict, or is there an issue in the v4l2-async rework ?

The ds90ub9xx drivers were merged after I had written the patch that
converted all drivers and I didn't remember to revisit it.

If you look at the patch, it's doing very similar things than the patch in
the Fixes: tag.

There's also a workaround for sub-device drivers (that register async
sub-devices) but not for drivers that register a notifier. It probably
doesn't make sense to add a workaround for those how, rather remove the one
that exists (after some time).

-- 
Kind regards,

Sakari Ailus
