Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9AD78DFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjH3Tvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238581AbjH3TvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 15:51:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8836B11A86
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 11:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693421944; x=1724957944;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=TY1mJ29usdKcqE6bUYs7rhlSfyyIauBscwydpG+RkVo=;
  b=CiLUCbQqV6v1PCvNhlBy1vC7BJ4tS3uroCvUGPkibz7QWZrQ151iYZsC
   1YnTDCem58X9AtrihRUYaYRRtT4mTlLmyCxPpNOK0zKe6OSBkDMNyw/0/
   kIRC0pvqBbb5gupQt3Os/GUOOe1k2zy/0Sm8/4fHHMqcqfRi0pxqqtj0B
   SBgFZq8YMlEMvRyORAlBamrVg5ZNYNeH6i1NQFBCuUGpGghbWOQbDEYwZ
   i4J2J4mc/21wzrYemTzovVvFHhOpVB543E43T0QEWE7XD6dWVmlTrFj8w
   n1QHTpWAQb21vqo0oe0VDG4AeyfeSY/29YXl4ATbLcGTQRvdIOmpJWB9/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="355227340"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="355227340"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 11:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882853758"
Received: from ideak-desk.fi.intel.com ([10.237.72.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 11:56:04 -0700
Date:   Wed, 30 Aug 2023 21:56:16 +0300
From:   Imre Deak <imre.deak@intel.com>
To:     Tejun Heo <tj@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] WQ_UNBOUND warning since recent workqueue refactoring
Message-ID: <ZO+Q0Oaw/1GkDx6T@ideak-desk.fi.intel.com>
Reply-To: imre.deak@intel.com
References: <f7e21caa-e98d-e5b5-932a-fe12d27fde9b@gmail.com>
 <ZO-BkaGuVCgdr3wc@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZO-BkaGuVCgdr3wc@slm.duckdns.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 07:51:13AM -1000, Tejun Heo wrote:
Hi,

> Hello,
> 
> (cc'ing i915 folks)
> 
> On Wed, Aug 30, 2023 at 04:57:42PM +0200, Heiner Kallweit wrote:
> > Recently I started to see the following warning on linux-next and presumably
> > this may be related to the refactoring of the workqueue core code.
> > 
> > [   56.900223] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> > [   56.923226] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 4 times, consider switching to WQ_UNBOUND
> > [   97.860430] workqueue: output_poll_execute [drm_kms_helper] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
> > [   97.884453] workqueue: i915_hpd_poll_init_work [i915] hogged CPU for >10000us 8 times, consider switching to WQ_UNBOUND
> > 
> > Adding WQ_UNBOUND to these queues didn't change the behavior.
> 
> That should have made them go away as the code path isn't active at all for
> WQ_UNBOUND workqueues. Can you please double check?
> 
> > Maybe relevant: I run the affected system headless.
> 
> i915 folks, workqueue recently added debug warnings which trigger when a
> per-cpu work item hogs the CPU for too long - 10ms in this case. This is
> problematic because such work item can stall other per-cpu work items.
> 
> * Is it expected for the above two work functions to occupy the CPU for over
>   10ms repeatedly?

No, this shouldn't happen.

I assume it happens in
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

after cfd48ad8c4a9 ("drm/i915: Fix HPD polling, reenabling the output poll work as needed")

which could result in the above problem.

Could you give a try to
https://lore.kernel.org/all/20230809104307.1218058-1-imre.deak@intel.com/

and if that doesn't help provide more information/logs, by opening a
ticket at:
https://gitlab.freedesktop.org/drm/intel/-/issues/new

Thanks,
Imre

> * If so, can we make them use an unbound workqueue instead?
> 
> Thanks.
> 
> -- 
> tejun
