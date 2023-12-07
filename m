Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5AE808A89
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 15:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443209AbjLGO2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 09:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbjLGO2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 09:28:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6783A9F;
        Thu,  7 Dec 2023 06:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701958841; x=1733494841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Rq1Spfo4eAwUy7VqgGqcIE7ynbMB75kkNh01WzthsyI=;
  b=Jg3pFRMAvIiuGymZAqO/Lb9HClCN08w9BMsi67od4TRwBcIgqpP9NLx0
   J4qtWx1j7YP6iCiJu7M8gzI/Xnu5fugodoOeAnNpaN2IkIBuBKiElA3CA
   8OYMWhxysTLktTtra0wEgtQh2nLYjSmbfu3T4bXNFP4tuMi5SORck5skt
   +/eZuBUN+trBFiL1Y5uKUKwW6V0QZa2SRrIM8+Tdr1d66Z9oywP4hOP8C
   MhICxGeyZvjqVNzARhuMcYJQMGKW+wv06uf7JhakI/6Iv5ugBISA2LF64
   iQaQfFF5/OxAGCturQc+6GDWafiT3BWOajxJ0RtjIltPZ0l2RIC9z7dAn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="384643799"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="384643799"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:19:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="747979224"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="747979224"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 06:19:26 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rBFDm-00000002cV0-2UAJ;
        Thu, 07 Dec 2023 16:19:22 +0200
Date:   Thu, 7 Dec 2023 16:19:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/3] device property: Implement device_is_big_endian()
Message-ID: <ZXHUat2Xo1VcAxN2@smile.fi.intel.com>
References: <20231025184259.250588-1-andriy.shevchenko@linux.intel.com>
 <20231025184259.250588-2-andriy.shevchenko@linux.intel.com>
 <2023102624-moonshine-duller-3043@gregkh>
 <ZTpbMVSdKlOgLbwv@smile.fi.intel.com>
 <ZUPBVMdi3hcTyW2n@smile.fi.intel.com>
 <CAMRc=MeV9ZyOzuQFEE_duPTHYgfmr6UZU6bpjDPhrczZX4PHpg@mail.gmail.com>
 <CAMRc=MdSpk_OszeDCyA5_Sp-w=sL9DHB2gGCOFP+FCiobm2cbA@mail.gmail.com>
 <2023111513-stinky-doorframe-8cd1@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2023111513-stinky-doorframe-8cd1@gregkh>
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

On Wed, Nov 15, 2023 at 03:21:29PM -0500, Greg Kroah-Hartman wrote:
> On Wed, Nov 15, 2023 at 03:58:54PM +0100, Bartosz Golaszewski wrote:
> > On Fri, Nov 3, 2023 at 10:08 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > > On Thu, Nov 2, 2023 at 4:33 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Oct 26, 2023 at 03:27:30PM +0300, Andy Shevchenko wrote:
> > > > > On Thu, Oct 26, 2023 at 07:25:35AM +0200, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Oct 25, 2023 at 09:42:57PM +0300, Andy Shevchenko wrote:
> > > > > > > Some users want to use the struct device pointer to see if the
> > > > > > > device is big endian in terms of Open Firmware specifications,
> > > > > > > i.e. if it has a "big-endian" property, or if the kernel was
> > > > > > > compiled for BE *and* the device has a "native-endian" property.
> > > > > > >
> > > > > > > Provide inline helper for the users.
> > > > > >
> > > > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > >
> > > > > Thank you, Greg.
> > > > >
> > > > > Bart, would it be still possible to take this into next?
> > > > > I would like to have at least this patch applied (with the first user)
> > > > > to allow conversion of others (I have some more users of new API).
> > > >
> > > > Okay, seems we missed v6.7 with this, can you then prepare an immutable
> > > > branch / tag with this, so other maintainers can pull in case it's needed?
> > > > (I have something against tty already and perhaps something else, let's
> > > >  see.)
> > >
> > > It arrived too late in the cycle, I needed to send my PR earlier this
> > > time as I was OoO this week.
> >
> > Greg, will you take this patch through your tree and provide me with
> > an immutable tag for this cycle?
> 
> Sure, let me catch up with patches after I return from Plumbers next
> week.

Hope Plumbers went well!

-- 
With Best Regards,
Andy Shevchenko


