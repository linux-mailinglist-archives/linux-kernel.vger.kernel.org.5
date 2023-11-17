Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B83B7EED9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjKQIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjKQIgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:36:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BBFB0;
        Fri, 17 Nov 2023 00:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700210209; x=1731746209;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPWTdnpNJUc5dfTVsK5EG0pPjOoquKeW81JBrUka9FU=;
  b=KszBwRCPxDfZpAYOgB5Veh/w/NHuy7gT+EFX+Hy3cvNXdIw0RgeBAEbW
   Qhezz7BHud4Hzr8D0kOreGnYdVNH/aR5SohGZuDvWGYNaQG9Q2jpBcNit
   DKOpDpjIpmCIAMLiiI7jT22A7oKGZisW9sSqMo2FFLhvw5EX1b4NShG0/
   xigbUqtXmkn4jKpsMl9j8UClYKPIVCEXF/La7dttmhyuZdrugpHzs9HrK
   0Y7pPZZl6L/B9ew1XP38tPSFfqgft6gq5Ou4qoiSP264VWfY15K39i2pv
   QFrnozt2HAcba8f1KDogvQu1guGL0tC1DIIjVkNoRTEhZBBzeVhgDk5ZN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="9920714"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="9920714"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 00:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="769165246"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="769165246"
Received: from kkrolx-mobl2.ger.corp.intel.com (HELO localhost) ([10.249.134.254])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 00:36:46 -0800
Date:   Fri, 17 Nov 2023 09:36:40 +0100
From:   Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To:     junxiao.bi@oracle.com
Cc:     Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH] kernfs: support kernfs notify in memory recliam context
Message-ID: <20231117093640.00006b70@linux.intel.com>
In-Reply-To: <c13b580b-434f-4a4b-b0b4-917f8b042de3@oracle.com>
References: <20231114185947.42829-1-junxiao.bi@oracle.com>
        <ZVPFMzHAx9JVz2ak@slm.duckdns.org>
        <c71f1cb7-14d6-45e4-9df1-dc9bc82deda8@oracle.com>
        <ZVPXd-3TshjeScek@slm.duckdns.org>
        <443775e1-ed94-452e-8f06-eadb777bede4@oracle.com>
        <20231115162915.000064f8@linux.intel.com>
        <c13b580b-434f-4a4b-b0b4-917f8b042de3@oracle.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2023 09:04:34 -0800
junxiao.bi@oracle.com wrote:

> On 11/15/23 7:30 AM, Mariusz Tkaczyk wrote:
> 
> > On Tue, 14 Nov 2023 15:53:47 -0800
> > junxiao.bi@oracle.com wrote:
> >  
> >> Understood, thanks. Sound like depending on Userspace on memory reclaim
> >> path is really bad idea and the only option for fixing it is to remove
> >> that dependency, but i am not sure that is possible without breaking the
> >> consistency of metadata.
> >>
> >> Thanks,
> >>
> >> Junxiao.  
> > Indeed the project of external metadata management if fragile. You cares
> > about IMSM here (same as me) so ideally we should implement metadata
> > management in kernel- I think that IMSM deserved that after 10 years on the
> > market. There is no better option, other options are just "workarounds" for
> > the lack of metadata management in kernel.  
> Agree, sound like that's the way to proceed.
> >
> > Song, any comments here?
> >
> >  From the second hand, there is native raid which should just work, so
> > maybe you can switch to the native raid?  
> 
> Unfortunately that's is not possible, it's a production setup to use 
> imsm raid.

Implementing IMSM in kernel is a goal for months/ years so I don't
see it in a timeline you would need that on to fix your production setup. It
will be a big feature, but let's wait for Song voice first.

Thanks,
Mariusz
