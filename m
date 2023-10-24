Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7157D4C2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbjJXJ2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjJXJ1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:27:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651BD1739
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:27:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809DBC433C9;
        Tue, 24 Oct 2023 09:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698139638;
        bh=+OZ/RtjQyCJCTnws85wXqbhd+IrZjqPDKhLQnwiy5A8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R3F3xzwTzUU3+OaJD4RWUKFcrtjlg/tBftpB0s9sG7U9ER3EIot2eDOCkH8HJbvYb
         PLBrd9bTbcF3dwATX3GHgxjZ18OSFkXPpZyizvyO6Pjpk0IxGuUqrwzRC/uwJckDD0
         oCODsYu4x/dps3+7MgIie741cEhzX9TyEo+hEP+g=
Date:   Tue, 24 Oct 2023 11:27:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Avichal Rakesh <arakesh@google.com>
Cc:     etalvala@google.com, jchowdhary@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        m.grzeschik@pengutronix.de
Subject: Re: [PATCH v6 4/4] usb: gadget: uvc: Fix use-after-free for inflight
 usb_requests
Message-ID: <2023102440-retaining-eskimo-92b0@gregkh>
References: <20231019185319.2714000-5-arakesh@google.com>
 <202310200457.GwPPFuHX-lkp@intel.com>
 <738df245-e7d1-4fc0-9076-3ac5afebaa44@google.com>
 <2023102103-casually-wavy-6a54@gregkh>
 <CAMHf4WKgzvMoL6tKCiQYsuudQWgGBKkhfbmYgUxVXvLEqxi1GQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMHf4WKgzvMoL6tKCiQYsuudQWgGBKkhfbmYgUxVXvLEqxi1GQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2023 at 02:25:30PM -0700, Avichal Rakesh wrote:
> On Sat, Oct 21, 2023 at 3:05 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Oct 19, 2023 at 03:30:00PM -0700, Avichal Rakesh wrote:
> > >
> > >
> > > On 10/19/23 13:32, kernel test robot wrote:
> > > > Hi Avichal,
> > > >
> > > > kernel test robot noticed the following build warnings:
> > > >
> > > > [auto build test WARNING on usb/usb-testing]
> > > > [also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.6-rc6 next-20231019]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > > And when submitting patch, we suggest to use '--base' as documented in
> > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > >
> > > > url:    https://github.com/intel-lab-lkp/linux/commits/Avichal-Rakesh/usb-gadget-uvc-prevent-use-of-disabled-endpoint/20231020-025512
> > > > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > > > patch link:    https://lore.kernel.org/r/20231019185319.2714000-5-arakesh%40google.com
> > > > patch subject: [PATCH v6 4/4] usb: gadget: uvc: Fix use-after-free for inflight usb_requests
> > > > config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310200457.GwPPFuHX-lkp@intel.com/config)
> > > > compiler: m68k-linux-gcc (GCC) 13.2.0
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200457.GwPPFuHX-lkp@intel.com/reproduce)
> > > >
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202310200457.GwPPFuHX-lkp@intel.com/
> > > >
> > > > All warnings (new ones prefixed by >>):
> > > >
> > > >>> drivers/usb/gadget/function/uvc_video.c:231: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> > > >     * Must be called with req_lock held as it modifies the list ureq is held in
> > > >
> > > >
> > >
> > > Greg, apologies for the newb question: do you want me to upload
> > > the fix for this as a reply to [PATCH v6 4/4], or upload a new chain of
> > > v7s with this patch fixed?
> >
> > A whole new v7 series please.
> >
> 
> Had a feeling, so sent out v7 series preemptively. Let me know if that
> doesn't work.
> 
> v7: https://lore.kernel.org/20231020173626.2978356-1-arakesh@google.com/

I have already dropped that from my review queue as your emails crossed
with that, so I thought it was obsolete by now, sorry.

Can you send a v8 please?

thanks,

greg k-h
