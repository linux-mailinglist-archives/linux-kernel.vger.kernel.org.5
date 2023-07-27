Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED7A764FE6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 11:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjG0JfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233007AbjG0Jet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 05:34:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58364EE7;
        Thu, 27 Jul 2023 02:26:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6600C61DE1;
        Thu, 27 Jul 2023 09:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D78C433C7;
        Thu, 27 Jul 2023 09:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690449996;
        bh=kUXhLysuJz2igAetLsPv8M5l4rwBIHgBRT7Gl31+jf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hFMjnaK+KO2aW3q7hRteUVeYF+wY/QkadPWcAIFz5supd0QI7Oacso1EW+0GcmBfO
         1LZNa+nI4IOEUlAGlewGRvRbzkif2vjBcqpFC18p9x11H22TJsrMdiRrAlsRqRBVI2
         7AjiwqGeofWgsEhnxUd4EbVwRWozux9e0S8/uJWhFPKI1C4Ib9tiAtw6MZCzpfSCfr
         qn6R8AR6vTeO5sUDvQi8F3qY14O/tAhekgb4zDcao5CEgQxxoVDcOXZSaqWsR6CiMQ
         WkGDVIf5Cy5ETIj6Sf+Gp1D9HGUbDW93EVQfUiFE4vIin3/c2mKHP676ByMXgoSsjo
         C318sLv+1XqHA==
Date:   Thu, 27 Jul 2023 10:26:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Henning Schild <henning.schild@siemens.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Mark Gross <markgross@kernel.org>,
        Tobias Schaffner <tobias.schaffner@siemens.com>
Subject: Re: [PATCH v2 0/3] platform/x86: move simatic drivers into subdir
Message-ID: <20230727092631.GB8175@google.com>
References: <20230719153518.13073-1-henning.schild@siemens.com>
 <ZLgJ7Oz1XlicGzEn@smile.fi.intel.com>
 <be72ecd8-cec1-41ec-b586-e9fb413b1458@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be72ecd8-cec1-41ec-b586-e9fb413b1458@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023, Hans de Goede wrote:

> Hi,
> 
> On 7/19/23 18:06, Andy Shevchenko wrote:
> > On Wed, Jul 19, 2023 at 05:35:15PM +0200, Henning Schild wrote:
> >> change since v1:
> >>  - switch LED/wdt Kconfig to "default y"
> >>  - remove guard which could hide whole siemens submenu, and default m
> >>
> >> This series does two things. It builds up a Kconfig inheritance chain
> >> for all platform device drivers, namely Watchdog and LED. And then it
> >> puts all Siemens Simatic IPC drivers in the platform/x86/ directory in
> >> a subdirectory called "siemens".
> >>
> >> That is so that users have to flip less config switches, and to ease
> >> maintenance.
> > 
> > All three good enough, although I prefer the ordering that 'tristate'
> > followed by 'default' without interleaved 'depends on'. I leave it
> > to Hans. Other that that,
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you.
> 
> Lee, Guenter do you want me to take the entire series on top of:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=platform-drivers-x86-simatic-ipc (aka ib-pdx86-simatic-v6.6)
> 
> And send an updated pull-req ?

Please apply - no PR required for me.

> Or shall I take just 3/3 and will you take the Kconfig
> changes from 1/3 resp 2/3 directly ?

-- 
Lee Jones [李琼斯]
