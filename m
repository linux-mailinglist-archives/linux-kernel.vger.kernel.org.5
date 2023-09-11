Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8973979B751
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354765AbjIKVzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237641AbjIKNET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:04:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8A3DF;
        Mon, 11 Sep 2023 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694437453; x=1725973453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EMruZn7KJAod3p21S8e62jnjMl5BS9upTMZiKyPocf0=;
  b=IXz+ymP/i47Xc+ZJ+WVAKOGaxBYinE97u8h0ElO/0ptQpCYpWj74BPNS
   lzFpfZR1m6PnAC8v7hRm4ArRUphz/oneauAZWbLvjS2KOwCzMfyrNpl5s
   0+VkHYyg0hay7rK2ZUTUF8cHXolrnRp0a7NvOAPQUwjMg/AapQd/AGB2E
   oyMqnd2EbiyFxW/qiUHr9M95u4B2OyWUniaxDoOd9dxgwPiQ0yw4S799F
   o792ShgQ2a9fdy9zdV5Upf1gZXVCYEJ/ac0wwa6VXkM7yFsrj96tdidPK
   8Xlc034U3UmfFg95KuXkFuIIFithsqsHfxGkof4q+8t6o5RA75RE0+Ubx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="358377179"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="358377179"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:03:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="1074123880"
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="scan'208";a="1074123880"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 06:03:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfgZG-008Kb6-0W;
        Mon, 11 Sep 2023 16:03:06 +0300
Date:   Mon, 11 Sep 2023 16:03:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v8 6/7] iio: accel: kionix-kx022a: Add a function to
 retrieve number of bytes in buffer
Message-ID: <ZP8QCVbOpUOMxV8g@smile.fi.intel.com>
References: <CAFukWp2Z0OCrJdTy+wzVs9jdCm70YNR-66q06=xoyGhaHg=aog@mail.gmail.com>
 <ZOdfeaW6AxE4eeqw@smile.fi.intel.com>
 <CAFukWp0ubncNcMiw-s_h5GoP1_RsjTaw3XxayGMuaeJJJneBow@mail.gmail.com>
 <ZOdrtNQijmhN9RAx@smile.fi.intel.com>
 <20230827190732.5e2215d0@jic23-huawei>
 <61247547-690c-fb8b-3a45-cd60754836a7@gmail.com>
 <ZOx8rAFBXMylgNzm@smile.fi.intel.com>
 <7ca3b60f-e59f-b578-7c22-48487663cfa7@gmail.com>
 <ZPiixW6CiR+z8s/r@smile.fi.intel.com>
 <8b73d2d9-ebba-8f3c-4b39-e3671117acf1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b73d2d9-ebba-8f3c-4b39-e3671117acf1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 09:33:47AM +0300, Matti Vaittinen wrote:
> On 9/6/23 19:03, Andy Shevchenko wrote:
> > On Tue, Aug 29, 2023 at 09:33:27AM +0300, Matti Vaittinen wrote:
> > > On 8/28/23 13:53, Andy Shevchenko wrote:
> > > > On Mon, Aug 28, 2023 at 09:24:25AM +0300, Matti Vaittinen wrote:
> > > > > On 8/27/23 21:09, Jonathan Cameron wrote:

...

> > > > > I think that people who work on a driver like this should guess what this is
> > > > > for.
> > > > 
> > > > _This_ is the result of what people always forgot to think about, i.e.
> > > > newcomers.
> > > 
> > > Thanks Andy. This was a good heads-up for me. I do also see the need for
> > > fresh blood here - we aren't getting any younger.
> > > 
> > > > What _if_ the newcomer starts with this code and already being puzzled
> > > > enough on what the heck the function does. With all ambiguity we rise
> > > > the threshold for the newcomers and make the kernel project not
> > > > attractive to start with
> > > 
> > > I really appreciate you making a point about attracting newcomers (and there
> > > is no sarcasm in this statement). I however don't think we're rising the bar
> > > here. If a newcomer wants to work on a device-driver, the _first_ thing to
> > > do is to be familiar with the device. Without prior experience of this kind
> > > of devices it is really a must to get the data-sheet and see how the device
> > > operates before jumping into reading the code. I would say that after
> > > reading the fifo lvl description from data-sheet this should be obvious -
> > > and no, I don't think we should replicate the data-sheet documentation in
> > > the drivers for parts that aren't very peculiar.
> > 
> > There are (at least?) two approaches on the contribution:
> > 1) generic / library wise;
> > 2) specific hardware wise.
> > 
> > You are talking about 2), while my remark is about both. I can imagine a
> > newcomer who possess a hardware that looks similar to what this driver is
> > for.
> 
> Yes. I am talking about 2). And my stance is that device drivers belong to
> category 2). If one works with a device driver for some HW, then he/she
> needs to be willing to understand the hardware.
> 
> > Now, they would like to write a new driver (note, that compatibility can be
> > checked by reading the RTL definitions, so no need to dive into the code)
> > and use this as a (nice) reference. With that in mind, they can read a
> > function named get_fifo_bytes() with not so extensive documentation nor
> > fully self-explanatory name. One may mistakenly though about this as a
> > function for something that returns FIFO capacity, but in the reality it is
> > current amount of valid / data bytes in the FIFO for the ongoing
> > communication with the device.
> 
> I can't avoid having a feeling that this is a very unlikely scenario. I am
> afraid that by requesting this type of improvements at patch series which is
> at v8 and has been running for half an year (and which was of a good quality
> to start with, especially knowing this was the author's first driver) is
> going to be more repulsive to the newcomers than the potential obfuscation.

I agree and this is a side talk to the topic.

> I don't try claiming that no-one could ever hit this trap (even if I don't
> see it likely). I still believe that if one does so, he/she will also get
> such a bug fixed without being totally discouraged - it's business as usual.
> 
> I hope this does not come out as rude. I do appreciate your reviews, it's
> comforting to know someone looks my code with sharp eyes and points out
> things like the dead code in BM1390 driver! I just like the words Jonathan
> once spilled out:
> 
> "Don't let the perfect be enemy of good" (or something along those lines).

True.

> > > But the question how to attract newcomers to kernel is very valid and I
> > > guess that not too many of us is thinking of it. Actually, I think we should
> > > ask from the newcomers we have that what has been the most repulsive part of
> > > the work when they have contributed.
> > 
> > > > (besides the C language which is already considered as mastodon among
> > > > youngsters).
> > > 
> > > I think this is at least partially the truth. However, I think that in many
> > > cases one of the issues goes beyond the language - many younger generation
> > > people I know aren't really interested in _why_ things work, they just want
> > > to get things working in any way they can - and nowadays when you can find a
> > > tutorial for pretty much anything - one really can just look up instruction
> > > about how a "foobar can be made to buzz" instead of trying to figure out
> > > what makes a "foobar to buzz" in order to make it to buzz. So, I don't blame
> > > people getting used to take a different approach. (Not sure this makes sense
> > > - don't really know how to express my thoughts about this in a clear way -
> > > besides, it may not even matter).
> > 
> > Yeah, I share your frustration and agree that people are loosing the feel of
> > curiosity. Brave New World in front of us...
> 
> Well, who knows how things will be working out for the new generations?
> Maybe they won't need the kernel in the future? Yes, I am stubbornly hanging
> in the past practices and values. Direction things seem to head do not
> always appeal to me - but perhaps it's just me? Who can say my values and
> practices are the right ones for new generations :) My oldest son just moved
> to his own home and I need to accept that young do build their own lives on
> different values I had. And who knows, maybe the approach of just doing
> things without knowing what exactly happens under the hood makes this world
> very good for them?
> 
> But yes - I don't think it suits the kernel project at all :) This is a
> project of dinosaurs like us XD
> 
> (DISCLAIMER: I don't know quite all young people in the world. Frankly to
> tell, not even 90% XD So, I am not trying to say "all young people are like
> this or that".

Operating in terms of universal quantifier is always wrong (pun intended).

> I just have a feeling that certain way of thinking is more
> common amongst certain generations - but maybe it's just my misjudgement.
> Please, don't be offended).
> 
> > > Anyways, I am pretty sure that - as with any community - the way people
> > > are treated and how their contribution is appreciated is the key to make
> > > them feel good and like the work. I think that in some cases it may
> > > include allowing new contributors to get their code merged when it has
> > > reached "good enough" state - even if it was not perfect. (Sure, when
> > > things are good enough is subject to greater minds than me to ponder) ;)

-- 
With Best Regards,
Andy Shevchenko


