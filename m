Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480DA7F736D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjKXMIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXMIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:08:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7878E18B;
        Fri, 24 Nov 2023 04:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700827699; x=1732363699;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lTasg4zfwuBp5HNu3rjNfYk3zMkCWqUCjRSpE0sPDnM=;
  b=Ea6Rz1oKTz3kYYF93vJYeJVEdOvGCjjyi+wz1guN6KO3GfKSgw1nl/tx
   jAHoKzxEpTLwmeD37Xo/v2PDqBkYhLtT0uVk/CfKw872zkhoxIa8NmNg4
   AJStIXg3gIVSASmtdv3Tt02ylqnDKqyBGVULWbHb9jHvUyqPp5uWcQiAE
   EMqZZB55wyFvhHFjEgFUf+7kDJqu/asI9IqqkMFiUxrbiFYCX4qGPPxqk
   Y9nmtYqiA5MqWGjq9ChlMjD6RO2ooK7m0gp7igY+cQFcH0NJyESfW/zax
   AS6fPBhAUAwp6hjqBmxDm9Mpb+AnlmY5GMCdGePguxUAfrCh/rFHProuE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="395229459"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="395229459"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 04:08:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="771241593"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="771241593"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 04:08:11 -0800
Date:   Fri, 24 Nov 2023 14:08:05 +0200
From:   Raag Jadav <raag.jadav@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pinctrl: tangier: simplify locking using cleanup
 helpers
Message-ID: <ZWCSJQoJ1m9PtF_e@black.fi.intel.com>
References: <20231123140212.12135-1-raag.jadav@intel.com>
 <20231123142816.GE1074920@black.fi.intel.com>
 <ZWCEXZrgafGqwBKT@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWCEXZrgafGqwBKT@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 01:09:17PM +0200, Andy Shevchenko wrote:
> On Thu, Nov 23, 2023 at 04:28:16PM +0200, Mika Westerberg wrote:
> > On Thu, Nov 23, 2023 at 07:32:12PM +0530, Raag Jadav wrote:
> > > Use lock guards from cleanup.h to simplify locking.
> > > 
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > 
> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> Pushed to my review and testing queue, thanks!

Awesome, I noticed a few commits having duplicate Acks in Intel tree.

Raag
