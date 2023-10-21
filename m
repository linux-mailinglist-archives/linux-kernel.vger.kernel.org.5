Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F57D1C5B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjJUKF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 06:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjJUKFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 06:05:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03DBD41
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 03:05:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CE8C433C7;
        Sat, 21 Oct 2023 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697882717;
        bh=z7NyvC2nM5GAT4Hdft8Uj9fmtmLiRPX8ReS+qa2TBck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lgJdp3tH0pkgvExwqNs8NGw6bKul5wlqxUFZL/3ob6p0TzlVHz95FplLUSf9eCzw/
         ScFuYLudwphJq5QJ4Um7Dchrxq2GpgnGVGu8SgF2UVf85LYOTyOnqn/JkQCRHHlQ1S
         xCgXbpk8nA+FBAQ0YohgWa2m6BedjFwM3rCmE2H0=
Date:   Sat, 21 Oct 2023 12:05:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
Subject: Re: [PATCH v6 4/4] usb: gadget: uvc: Fix use-after-free for inflight
 usb_requests
Message-ID: <2023102103-casually-wavy-6a54@gregkh>
References: <20231019185319.2714000-5-arakesh@google.com>
 <202310200457.GwPPFuHX-lkp@intel.com>
 <738df245-e7d1-4fc0-9076-3ac5afebaa44@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <738df245-e7d1-4fc0-9076-3ac5afebaa44@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 03:30:00PM -0700, Avichal Rakesh wrote:
> 
> 
> On 10/19/23 13:32, kernel test robot wrote:
> > Hi Avichal,
> > 
> > kernel test robot noticed the following build warnings:
> > 
> > [auto build test WARNING on usb/usb-testing]
> > [also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.6-rc6 next-20231019]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > 
> > url:    https://github.com/intel-lab-lkp/linux/commits/Avichal-Rakesh/usb-gadget-uvc-prevent-use-of-disabled-endpoint/20231020-025512
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > patch link:    https://lore.kernel.org/r/20231019185319.2714000-5-arakesh%40google.com
> > patch subject: [PATCH v6 4/4] usb: gadget: uvc: Fix use-after-free for inflight usb_requests
> > config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310200457.GwPPFuHX-lkp@intel.com/config)
> > compiler: m68k-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200457.GwPPFuHX-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310200457.GwPPFuHX-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>):
> > 
> >>> drivers/usb/gadget/function/uvc_video.c:231: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> >     * Must be called with req_lock held as it modifies the list ureq is held in
> > 
> > 
> 
> Greg, apologies for the newb question: do you want me to upload
> the fix for this as a reply to [PATCH v6 4/4], or upload a new chain of 
> v7s with this patch fixed? 

A whole new v7 series please.

thanks,

greg k-h
