Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54EE7C9E45
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 06:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjJPEeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 00:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbjJPEeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 00:34:21 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6B3D9;
        Sun, 15 Oct 2023 21:34:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 940341C0006;
        Mon, 16 Oct 2023 04:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697430847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bSd0iZihleDxvFOZsaxICx+5Gnpmhq4IMdOHjX7bja4=;
        b=U0Ci1BHZPreo5znGClSqST82AMAFtTX0MsnRBTM7zwqLPx47gVfEPgWBXMrdBXC9POU2R7
        uXvi33tyj5xr7hT5yWI4ZoqOC14jHvaYNqOgHCfdX36qhucjzVkFSTESzvipBHMos7MYcL
        JYxDGBqd5TEEjLikCP9EdzZ/2S9p0f06pIgo066ci27EtJCn8NQX9ATALsqgbtFoq5TlFi
        zj4Wfp1cdHaXBfGxbAxJLEw3vo3yjN8UIjixbF9tRq7mwOf5Xu2sUrm7ntc4AdOS8Tr/9w
        hQXqRIOf3AcDg7UrZarf43zTPE4ymGRUaXkiYtxdTVVULbSJICk3dzQKzeBMuQ==
Date:   Mon, 16 Oct 2023 06:34:05 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the rtc tree
Message-ID: <20231016043405279f25d0@mail.local>
References: <20231016151522.06839671@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016151522.06839671@canb.auug.org.au>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/10/2023 15:15:22+1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the rtc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/rtc/rtc-at91rm9200.c:561:13: error: 'at91_rtc_remove' defined but not used [-Werror=unused-function]
>   561 | static void at91_rtc_remove(struct platform_device *pdev)
>       |             ^~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> Caused by commit
> 
>   48bc8830fbed ("rtc: at91rm9200: Convert to platform remove callback returning void")
> 
> This function lost its __exit attribute (which includes a "used"
> attribute) and exit_p(x) is NULL when not being built with
> CONFIG_MODULE set.  This build has CONFIG_RTC_DRV_AT91RM9200=y
> 
> I have reverted that commit for today.
> 

Thanks for the report, this is fixed now.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
