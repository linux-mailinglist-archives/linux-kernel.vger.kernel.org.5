Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FCC8135D7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443555AbjLNQLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:11:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjLNQLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:11:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D95010E;
        Thu, 14 Dec 2023 08:11:40 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="398975372"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="398975372"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:11:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105760897"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="1105760897"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 08:11:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rDoJA-00000005tGw-2aR6;
        Thu, 14 Dec 2023 18:11:32 +0200
Date:   Thu, 14 Dec 2023 18:11:32 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     xiongxin <xiongxin@kylinos.cn>,
        Thomas Gleixner <tglx@linutronix.de>, jikos@kernel.org,
        benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        stable@vger.kernel.org, Riwen Lu <luriwen@kylinos.cn>,
        hoan@os.amperecomputing.com, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irq: Resolve that mask_irq/unmask_irq may not be called
 in pairs
Message-ID: <ZXspNGWszB9jAown@smile.fi.intel.com>
References: <20231207014003.12919-1-xiongxin@kylinos.cn>
 <87ttosssxd.ffs@tglx>
 <e125491c-4cdb-4870-924a-baeb7453bf78@kylinos.cn>
 <874jgnqwlo.ffs@tglx>
 <bf4004bf-4868-4953-8d8e-0c0e03be673e@kylinos.cn>
 <875y12p2r0.ffs@tglx>
 <1844c927-2dd4-49b4-a6c4-c4c176b1f75d@kylinos.cn>
 <f5vtfoqylht5ijj6tdvxee3f3u6ywps2it7kv3fhmfsx75od2y@ftjlt4t4z4dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f5vtfoqylht5ijj6tdvxee3f3u6ywps2it7kv3fhmfsx75od2y@ftjlt4t4z4dk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 01:06:23PM +0300, Serge Semin wrote:
> On Thu, Dec 14, 2023 at 09:54:06AM +0800, xiongxin wrote:
> > 在 2023/12/13 22:59, Thomas Gleixner 写道:
> > > On Wed, Dec 13 2023 at 10:29, xiongxin wrote:
> > > > 在 2023/12/12 23:17, Thomas Gleixner 写道:
> > > > Sorry, the previous reply may not have clarified the BUG process. I
> > > > re-debugged and confirmed it yesterday. The current BUG execution
> > > > sequence is described as follows:
> > > 
> > > It's the sequence how this works and it works correctly.
> > > 
> > > Just because it does not work on your machine it does not mean that this
> > > is incorrect and a BUG.
> > > 
> > > You are trying to fix a symptom and thereby violating guarantees of the
> > > core code.
> > > 
> > > > That is, there is a time between the 1:handle_level_irq() and
> > > > 3:irq_thread_fn() calls for the 2:disable_irq() call to acquire the lock
> > > > and then implement the irq_state_set_disabled() operation. When finally
> > > > call irq_thread_fn()->irq_finalize_oneshot(), it cannot enter the
> > > > unmask_thread_irq() process.
> > > 
> > > Correct, because the interrupt has been DISABLED in the mean time.
> > > 
> > > > In this case, the gpio irq_chip irq_mask()/irq_unmask() callback pairs
> > > > are not called in pairs, so I think this is a BUG, but not necessarily
> > > > fixed from the irq core code layer.
> > > 
> > > No. It is _NOT_ a BUG. unmask() is not allowed to be invoked when the
> > > interrupt is DISABLED. That's the last time I'm going to tell you that.
> > > Only enable_irq() can undo the effect of disable_irq(), period.
> > > 
> > > > Next, when the gpio controller driver calls the suspend/resume process,
> > > > it is as follows:
> > > > 
> > > > suspend process:
> > > > dwapb_gpio_suspend()
> > > >       ctx->int_mask   = dwapb_read(gpio, GPIO_INTMASK);
> > > > 
> > > > resume process:
> > > > dwapb_gpio_resume()
> > > >       dwapb_write(gpio, GPIO_INTMASK, ctx->int_mask);
> > > 
> > > Did you actually look at the sequence I gave you?
> > > 
> > >     Suspend:
> > > 
> > > 	  i2c_hid_core_suspend()
> > > 	     disable_irq();       <- Marks it disabled and eventually
> > > 				     masks it.
> > > 
> > > 	  gpio_irq_suspend()
> > > 	     save_registers();    <- Saves masked interrupt
> > > 
> > >     Resume:
> > > 
> > > 	  gpio_irq_resume()
> > > 	     restore_registers(); <- Restores masked interrupt
> > > 
> > > 	  i2c_hid_core_resume()
> > > 	     enable_irq();        <- Unmasks interrupt and removes the
> > > 				     disabled marker
> > > 
> > > 
> > > Have you verified that this order of invocations is what happens on
> > > your machine?
> > > 
> > > Thanks,
> > > 
> > >          tglx
> > 
> > As described earlier, in the current situation, the irq_mask() callback of
> > gpio irq_chip is called in mask_irq(), followed by the disable_irq() in
> > i2c_hid_core_suspend(), unmask_irq() will not be executed.
> > 
> > Then call enable_irq() in i2c_hid_core_resume(). Since gpio irq_chip does
> > not implement the irq_startup() callback, it ends up calling irq_enable().
> > 
> > The irq_enable() function is then implemented as follows:
> > 
> > irq_state_clr_disabled(desc);
> > if (desc->irq_data.chip->irq_enable) {
> > 	desc->irq_data.chip->irq_enable(&desc->irq_data);
> > 	irq_state_clr_masked(desc);
> > } else {
> > 	unmask_irq(desc);
> > }
> > 
> > Because gpio irq_chip implements irq_enable(), unmask_irq() is not executed,
> > and gpio irq_chip's irq_unmask() callback is not called. Instead,
> > irq_state_clr_masked() was called to clear the masked flag.
> > 
> > The irq masked behavior is actually controlled by the
> > irq_mask()/irq_unmask() callback function pairs in gpio irq_chip. When the
> > whole situation occurs, there is one more irq_mask() operation, or one less
> > irq_unmask() operation. This ends the i2c hid resume and the gpio
> > corresponding i2c hid interrupt is also masked.
> > 
> > Please help confirm whether the current situation is a BUG, or suggest other
> > solutions to fix it.
> 
> I has just been Cc'ed to this thread from the very start of the thread
> so not sure whether I fully understand the problem. But a while ago an
> IRQ disable/undisable-mask/unmask-unpairing problem was reported for
> DW APB GPIO driver implementation, but in a another context though:
> https://lore.kernel.org/linux-gpio/1606728979-44259-1-git-send-email-luojiaxing@huawei.com/
> We didn't come to a final conclusion back then, so the patch got lost
> in the emails archive. Xiong, is it related to the problem in your
> case?

From what explained it sounds to me that GPIO driver has missing part and
this seems the missing patch (in one or another form). Perhaps we can get
a second round of review,

-- 
With Best Regards,
Andy Shevchenko


