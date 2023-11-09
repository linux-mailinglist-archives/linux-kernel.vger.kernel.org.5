Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4726E7E6438
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjKIHSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjKIHSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:18:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98DD93;
        Wed,  8 Nov 2023 23:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699514283; x=1731050283;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XutjDMFh2r4oet7IsMjR0XCGHqBZ1gkGVXh0r4djrns=;
  b=HtOnuyI+u5+PgykXktqeAVd2422lz3DVE15LQHp/hZZceo7VbEGsf+dj
   f17emrR7V2c3gS1xiFdsm349qLqBACvz7acNY6qNUoN3k8YtNQlDo7gqD
   RBdhwO8Qtmbd0B0/G0R57BV8yp77xOI+3L+G1O1lWOrqT6A7euVhtn520
   KoH28boaANe1Gm8gdPFVXHv0uNduOhHyryKADhKZK2n4JEkeH9VxHAOBD
   //4cVQV/EoTvdU8Vo4GNoUAPBoE0GifgQA0paAk+Ce7Tr7ctHeuuUhDWA
   S0bWcz661mjZ4NyXDQCMcWcWJOz4dSzH550VAUbYXN1y1OO0hBMGZhK6h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="387097049"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="387097049"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2023 23:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10888"; a="833744055"
X-IronPort-AV: E=Sophos;i="6.03,288,1694761200"; 
   d="scan'208";a="833744055"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2023 23:18:01 -0800
Date:   Thu, 9 Nov 2023 15:16:26 +0800
From:   Xu Yilun <yilun.xu@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marco Pagani <marpagan@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Alan Tull <atull@opensource.altera.com>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fpga: remove module reference counting from core
 components
Message-ID: <ZUyHSs+oI9AsQdZE@yilunxu-OptiPlex-7050>
References: <20231027152928.184012-1-marpagan@redhat.com>
 <ZT9qENE9fE3Z0KCW@yilunxu-OptiPlex-7050>
 <ae202b70-b106-4805-9ce0-ffbb2738bb04@redhat.com>
 <ZUuu1CgVd4h3Qqu7@yilunxu-OptiPlex-7050>
 <2023110839-jam-relapsing-7f5d@gregkh>
 <ZUxpHk/8pCusjXOb@yilunxu-OptiPlex-7050>
 <2023110922-lurk-subdivide-4962@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023110922-lurk-subdivide-4962@gregkh>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:27:24AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Nov 09, 2023 at 01:07:42PM +0800, Xu Yilun wrote:
> > On Wed, Nov 08, 2023 at 05:20:53PM +0100, Greg Kroah-Hartman wrote:
> > > On Wed, Nov 08, 2023 at 11:52:52PM +0800, Xu Yilun wrote:
> > > > > >>
> > > > > >> In fpga_region_get() / fpga_region_put(): call get_device() before
> > > > > >> acquiring the mutex and put_device() after having released the mutex
> > > > > >> to avoid races.
> > > 
> > > Why do you need another reference count with a lock?  You already have
> > > that with the calls to get/put_device().
> > 
> > The low-level driver module could still be possibly unloaded at the same
> > time, if so, when FPGA core run some callbacks provided by low-level driver
> > module, its referenced page of code is unmapped...
> 
> Then something is designed wrong here, the unloading of the low-level
> driver should remove the access to the device itself.  Perhaps fix that?

Actually the low-level driver module on its own has no way to garantee its
own code page of callbacks not accessed. It *is* accessing its code page
when it tries (to release) any protection.

Core code must help, and something like file_operations.owner is an
effective way.

Thanks,
Yilun
