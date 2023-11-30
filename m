Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0457FF12E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbjK3OFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345800AbjK3OFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:05:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04B71B4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:05:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFACC433C8;
        Thu, 30 Nov 2023 14:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701353153;
        bh=zvxGJDY8FCc6wODfCKIaIRyB/6ybh+E3orrkZkhrxnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSBJceYPB59omKA3n5QjQzqrPZNUgVCHxzp5A3/bSBWrPoxkr4+DhXk2G31qLw5OK
         Op4prX027Qi26OkpeMBbTt9Q55dSFuiw+Uut1ScNa9fSyrGQK443sxPBcR9QkWQiS1
         yghMT2eiiKU+MbV8tGiH/jtGaZLjwkfC9UhNj1kQAAUG54oep0QTIV6fhG8C18J9dQ
         JyuTEuZ/VX2RJfmRPAyYbJPjNTGfunnj7/124YXkvBTgTibrqmgnfaDhNA0lh9VhuX
         wmsr84L1MGtbviIEWT/bTEmQ0qPGKxQVXCL1raNBv3EsPsxcV68JBzy7yxwzmTT14l
         /JbCJjr9Gk8/A==
Date:   Thu, 30 Nov 2023 14:05:48 +0000
From:   Lee Jones <lee@kernel.org>
To:     =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@gmail.com>
Cc:     tony@atomide.com, robh@kernel.org, wens@csie.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: twl6030-irq: Revert to use of_match_device()
Message-ID: <20231130140548.GL1470173@google.com>
References: <20231029114843.15553-1-peter.ujfalusi@gmail.com>
 <20231123103756.GD1184245@google.com>
 <20231123104108.GF1184245@google.com>
 <74b0b808-7b97-4e53-a1a4-6e2e1274ecff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <74b0b808-7b97-4e53-a1a4-6e2e1274ecff@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023, Péter Ujfalusi wrote:

> 
> 
> On 23/11/2023 12:41, Lee Jones wrote:
> >>> @@ -368,10 +368,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
> >>>  	int			nr_irqs;
> >>>  	int			status;
> >>>  	u8			mask[3];
> >>> -	const int		*irq_tbl;
> >>> +	const struct of_device_id *of_id;
> >>>  
> >>> -	irq_tbl = device_get_match_data(dev);
> >>> -	if (!irq_tbl) {
> >>> +	of_id = of_match_device(twl6030_of_match, dev);
> >>
> >> I think you just dropped support for ACPI.
> > 
> > Ah, scrap that.  I was looking at the wrong part of 1e0c866887f4.
> > 
> > So what about the other drivers changed in the aforementioned commit?
> 
> Looking back at it again, I think only this patch is needed.
> This is not a real driver, it is using the twl core's device.
> The twl6030 is for sure broken, let me reply to the twl4030-power in a sec.
> 
> > Ideally we'd have a call that covers all of the various probing APIs.
> > 
> >> Rob, care to follow-up?

Rob, last chance to state your case before I apply it.

-- 
Lee Jones [李琼斯]
