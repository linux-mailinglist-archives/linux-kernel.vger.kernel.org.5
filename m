Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 960237EBAF9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 02:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjKOBma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 20:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjKOBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 20:42:30 -0500
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC18ECF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 17:42:26 -0800 (PST)
Received: from localhost (88-113-24-34.elisa-laajakaista.fi [88.113.24.34])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 38a819f9-8358-11ee-b3cf-005056bd6ce9;
        Wed, 15 Nov 2023 03:42:24 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Wed, 15 Nov 2023 03:42:22 +0200
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pengfei Xu <pengfei.xu@intel.com>, yi1.lai@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: selftests: gpio: crash on arm64
Message-ID: <ZVQh_nvgqMkd3tN6@surfacebook.localdomain>
References: <CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com>
 <ZAocZRZh4FQRH3lc@smile.fi.intel.com>
 <CA+G9fYsOttth+k3Ki8LK_ZiayvXa0bAg-DmQAaFHZeEyR=6Lrw@mail.gmail.com>
 <CACRpkdbUYWcFiRh+Y=MOekv2RjSP4sB2t5tVrSsz54Eez6wmVg@mail.gmail.com>
 <ZJHWdcP+PDaNrw07@smile.fi.intel.com>
 <CA+G9fYvReHr+ofJAW4yfA5EWT6-MRpR2+fOQG24hROjSd+dY0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvReHr+ofJAW4yfA5EWT6-MRpR2+fOQG24hROjSd+dY0g@mail.gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Nov 07, 2023 at 07:21:32PM +0530, Naresh Kamboju kirjoitti:
> On Tue, 20 Jun 2023 at 22:11, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Apr 11, 2023 at 10:57:28AM +0200, Linus Walleij wrote:
> > > On Mon, Apr 10, 2023 at 11:16 AM Naresh Kamboju
> > > <naresh.kamboju@linaro.org> wrote:

...

> > > Add a pr_info() devm_gpio_chip_release() in drivers/gpio/gpiolib-devres.c
> > > and see if the callback is even called. I think this could be the
> > > problem: if that isn't cleaned up, there will be dangling references.
> >
> > Side note: Since we have devres tracepoints, your patch seems an overkill :-)
> > Just enable devres tracepoints and filter out by the function name. I believe
> > that should work.
> 
> Since I have been tracking open issues on the stable-rc kernel,
> The reported problem on stable-rc linux.6.3.y has been solved
> on the stable-rc linux.6.6.y branch.
> 
> Thanks for fixing this reported issue.
> 
> Upstream links about this fix and discussion,

I'm a bit lost. Is the [3] fixed? Is the fix the below mentioned commit?

> Commit daecca4b8433
> gpiolib: Do not alter GPIO chip fwnode member
> 
> [1] https://lore.kernel.org/linux-gpio/20230703142308.5772-4-andriy.shevchenko@linux.intel.com/
> [2] https://lore.kernel.org/linux-gpio/CAMRc=MfFEBSeJ78NO7XeuzAMJ0KezEPAYWsWnFXXaRyQPAf3dA@mail.gmail.com/
> [3] https://lore.kernel.org/linux-gpio/CA+G9fYv94gx8+-JMzbmQaue3q3y6QdBmsGUCdD-26X5XavL3Ag@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko


