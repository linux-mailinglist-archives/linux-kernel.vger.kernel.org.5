Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E5479E20B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238848AbjIMI1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233957AbjIMI1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:27:17 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A24F4198C;
        Wed, 13 Sep 2023 01:27:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 03B028088;
        Wed, 13 Sep 2023 08:27:13 +0000 (UTC)
Date:   Wed, 13 Sep 2023 11:27:11 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com
Subject: Re: [PATCH] bus: ti-sysc: Use fsleep() instead of usleep_range() in
 sysc_reset()
Message-ID: <20230913082711.GH5285@atomide.com>
References: <20230821-fix-ti-sysc-reset-v1-1-5a0a5d8fae55@baylibre.com>
 <20230822092744.GT11676@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822092744.GT11676@atomide.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [230822 09:27]:
> * Julien Panis <jpanis@baylibre.com> [230821 14:24]:
> > The am335x-evm started producing boot errors because of subtle timing
> > changes:
> > 
> > Unhandled fault: external abort on non-linefetch (0x1008) at 0xf03c1010
> > ...
> > sysc_reset from sysc_probe+0xf60/0x1514
> > sysc_probe from platform_probe+0x5c/0xbc
> > ...
> > 
> > The fix consists in using the appropriate sleep function in sysc reset.
> > For flexible sleeping, fsleep is recommended. Here, sysc delay parameter
> > can take any value in [0 - 255] us range. As a result, fsleep() should
> > be used, calling udelay() for a sysc delay lower than 10 us.
> > 
> > Signed-off-by: Julien Panis <jpanis@baylibre.com>
> > Fixes: e709ed70d122 ("bus: ti-sysc: Fix missing reset delay handling")
> > ---
> > Fix boot errors for am335x-evm in sysc_reset(), by using fsleep() instead
> > of usleep_range() function. Thus, udelay() will be called if the configured
> > sysc delay is lower than 10 us (which is usually the case, since the value
> > set in the device tree is currently 2 us).
> 
> OK, interesting. Yeah I've only ever seen values of 2 us needed here.

Applied into fixes thanks

Tony
