Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3247EAAAB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 07:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjKNGzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 01:55:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNGzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 01:55:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D82D43;
        Mon, 13 Nov 2023 22:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699944908; x=1731480908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GPkBoNsUMQY8CWS7ia3KzqjIuFIsEAor8fkNZkDALeg=;
  b=G+dE7litinE56E3BZ4VN/qxqNdl0c/HbTC1Zr3ZmBwyTaK9FJpnTLVFi
   lI8/d4mgVFz2qN7z+C03k9IpU3fYGwZn1GFv1tkoAFcPiIqDgDbz7J9gN
   asxl87pgBznxwSlcHxaJNDX9eMGTtBF8ChAVyZr8mEYGYTKFpy9I7nxk/
   9Le8fDNQKszzIPo2rFaMF+uAmg6xEDYdwPk5IJqEeILHYnT3DLnyga5Gy
   uleYmcO5jYIwKtVKMWlky7RxNLkuKzWs7xTrAIk8WcldToW1HxnhPBWnF
   0RowlliN6Im03X15rKvAypy5dmY7kzuC94idBibpkjpuN8YxUlIemqhd/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="421696022"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="421696022"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 22:55:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="881950403"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; 
   d="scan'208";a="881950403"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga002.fm.intel.com with ESMTP; 13 Nov 2023 22:55:06 -0800
Date:   Tue, 14 Nov 2023 14:53:24 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <ZVMZZNyLE0+YtKYz@yilunxu-OptiPlex-7050>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <5c3c3905-67c2-4cc2-8477-c6fc74676fc9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c3c3905-67c2-4cc2-8477-c6fc74676fc9@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 11:58:37PM +0100, Marco Pagani wrote:
> 
> 
> On 2023-11-08 16:52, Xu Yilun wrote:
> > On Fri, Nov 03, 2023 at 09:31:02PM +0100, Marco Pagani wrote:
> >>
> >>
> >> On 2023-10-30 09:32, Xu Yilun wrote:
> >>> On Fri, Oct 27, 2023 at 05:29:27PM +0200, Marco Pagani wrote:
> >>>> Remove unnecessary module reference counting from the core components
> >>>> of the subsystem. Low-level driver modules cannot be removed before
> >>>> core modules since they use their exported symbols.
> >>>
> >>> Could you help show the code for this conclusion?
> >>>
> >>> This is different from what I remember, a module cannot be removed when
> >>> its exported symbols are being used by other modules. IOW, the core
> >>> modules cannot be removed when there exist related low-level driver
> >>> modules. But the low-level driver modules could be removed freely
> >>> without other protecting mechanism.
> >>>
> >>
> >> My understanding was that we wanted to remove module reference counting
> >> from the fpga core and ease it from the responsibility of preventing
> >> low-level driver modules from being unloaded. 
> > 
> > FPGA core needs to prevent low-level driver module unloading sometimes,
> > e.g. when region reprograming is in progress. That's why we get fpga
> > region driver modules & bridge modules in fpga_region_program_fpga().
> > 
> > But we try best to get them only necessary. Blindly geting them all the
> > time results in no way to unload all modules (core & low level modules).
> > 
> >>
> >> If we want to keep reference counting in the fpga core, we could add a
> >> struct module *owner field in the struct fpga_manager_ops (and others
> >> core *_ops) so that the low-level driver can set it to THIS_MODULE.
> >> In this way, we can later use it in fpga_mgr_register() to bump up the
> > 
> > Yes, we should pass the module owner in fpga_mgr_register(), but could
> > not bump up its refcount at once.
> > 
> >> refcount of the low-level driver module by calling
> >> try_module_get(mgr->mops->owner) directly when it registers the manager.
> >> Finally, fpga_mgr_unregister() would call module_put(mgr->mops->owner)
> >> to allow unloading the low-level driver module.
> > 
> > As mentioned above, that makes problem. Most of the low level driver
> > modules call fpga_mgr_unregister() on module_exit(), but bumping up
> > their module refcount prevents module_exit() been executed. That came
> > out to be a dead lock.
> >
> 
> Initially, I considered calling try_module_get(mgr->mops->owner)
> in fpga_mgr_get(). But then, the new kernel-doc description of
> try_module_get() (1) made me question the safety of that approach.
> My concern is that the low-level driver could be removed right when
> someone is calling fpga_mgr_get() and hasn't yet reached
> try_module_get(mgr->mops->owner). In that case, the struct mops
> (along with the entire low-level driver module) and the manager dev
> would "disappear" under the feet of fpga_mgr_get().

I don't get what's the problem. fpga_mgr_get() would first of all
look for mgr_dev via class_find_device(), if low-level module is
unloaded, then you cannot find the mgr_dev and gracefully error out.

If class_find_device() succeed, mgr_dev got a reference and won't
disappear. Finally we may still found module removed when
try_module_get(), but should be another graceful error out.

Am I missing anything?

Thanks,
Yilun

> 
> (1) 557aafac1153 ("kernel/module: add documentation for try_module_get()")
>  
