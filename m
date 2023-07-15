Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79444754A32
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjGOQvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOQvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:51:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B9C2120;
        Sat, 15 Jul 2023 09:51:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A90760BB1;
        Sat, 15 Jul 2023 16:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D1DC433C8;
        Sat, 15 Jul 2023 16:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689439906;
        bh=YlFK3AHkaic1SjsI95VZzhKDCOhIMferUe25/lIzgeI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lxRIPk2TJiryZ5c5zEwpaL3ln/exBHBaXxHSQ6dOS5b+H1yedjsaTfaLSGepgYC67
         BbSzY8EckW1OnIlEX9cHumPwrx82JdFtTkRh6SEV//Vl9cCA+Pg+wO7IXiYVuLmYJk
         4hoboHrWn3MX4YxwVTRrxuFIkjVIrhf7Vfsgp68QjY5n7jE7BJuq0x1bR4INmSUHt0
         Z9jHXGddicgKVn418mVeOJXQ6X8AIfqMfTgwjFahRnZApf0u2E92Cb8Y4D+/Bis+7Q
         18i/F+3QX1tGgSsLyXXhEWDLrf3mUOvWoZjzwxeEZ85I9S/iXCTZzcBPr2kzT2ghPn
         vPgg/bIW1627A==
Date:   Sat, 15 Jul 2023 17:51:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <kernel@axis.com>
Subject: Re: [PATCH 2/2] iio: Add driver for Murata IRS-D200
Message-ID: <20230715175139.2b0ebaae@jic23-huawei>
In-Reply-To: <pndcz0xkuka.fsf@axis.com>
References: <cover.1686926857.git.waqarh@axis.com>
        <d2d8f34c09a2ba0504eaba4f451412de41db2f37.1686926857.git.waqarh@axis.com>
        <20230617143508.28309834@jic23-huawei>
        <pndo7lb1mes.fsf@axis.com>
        <20230625120604.3ecc54bf@jic23-huawei>
        <pndcz0xkuka.fsf@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 17:33:09 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Sun, Jun 25, 2023 at 12:06 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> 
> [...]
> 
> >> >> +		dev_err(data->dev, "Could not write hp filter frequency (%d)\n",
> >> >> +			ret);
> >> >> +		return ret;    
> >> >
> >> > drop this return ret out of the if block here.
> >> >
> >> > In general being able to ignore possibility of ret > 0 simplifies handling.    
> >> 
> >> I try to be consistent and it also "helps" the next person potentially
> >> adding code after the `if`-statement and forgetting about adding
> >> `return`. We can drop the `return here, but then we should do the same
> >> in other places with a check just before the last `return` (like
> >> `irsd200_write_timer()`, `irsd200_read_nr_count()`,
> >> `irsd200_write_nr_count()` and many more), right?  
> >
> > I don't feel particulartly strongly about this, but there are scripts
> > that get used to scan for this pattern to simplify the code.
> >
> > Sure on the other cases. I don't tend to try and label all cases of things
> > pointed out, just pick on one and rely on the patch author to generalise.  
> 
> I started to remove the returns but then realized that it got a little
> messy. For example, in some cases we can't drop the return (side effects
> after the return etc.). 
> 
> Since you didn't have any strong opinions on this, I kept them in v2.
> Hope that's fine!

Absolutely.   I wasn't advocating removing separate returns in general, just this
cases where there was nothing after the if check.

Thanks,

Jonathan
