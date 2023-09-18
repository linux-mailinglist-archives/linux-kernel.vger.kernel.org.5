Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02307A4F87
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjIRQpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjIRQpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:45:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6594F2723;
        Mon, 18 Sep 2023 09:37:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DA2C3277D;
        Mon, 18 Sep 2023 14:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695046299;
        bh=AaTX2phhCUtPw9lbKF7scrtBDHqfwrjWgr4HRiqVU9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WDYp+Cu5is1eQJc2E1ihlpN0xCm1i6XxOIKrpDdDUU0vluWEg1NNVqSJK8ilROFzi
         47QcUYJHToFdoEWwIYsSXib8EcR04/G+GfSSffF6fvXjEhGwsHeh8KuUPIMvhYuAUx
         ngj80IvrPh1NScrRbgTQuhWk8Vv6zhjE0quZ1NC/FWX94GkNxmWSfb6zE2uoy1p5pU
         NKHgxXsiGmvgo8tSTzUeatoRvGFMYxQXn8y3ty50fJtwt2/4JohiICbuIou0XBgefM
         KLCvNnmYaIOPM3hX8o9l1AKiLkCnQJ5LLI8nt0ceKCpfYVouRmrTd28zFuQXTfZMyU
         nlsFj886WOczA==
Date:   Mon, 18 Sep 2023 16:11:33 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Da Xue <da@libre.computer>, lee@kernel.org, sashal@kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stable <stable@vger.kernel.org>
Subject: Re: linux-stable 6.1.53 kernel crash on COLOR_ID_MULTI handling
 change
Message-ID: <20230918161133.4c32a0e6@dellmb>
In-Reply-To: <ZQLelWcNjjp2xndY@duo.ucw.cz>
References: <CACqvRUb_X14pjaxA0Q7bQf53TAFmk5rjQOSWqx3Tvi4g+vcNMw@mail.gmail.com>
        <ZQLelWcNjjp2xndY@duo.ucw.cz>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sep 2023 12:21:09 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
> 
> > We have running systems that use COLOR_ID_MULTI. The GPIO toggles
> > between two colors and we have used the identifier. RGB is not a good
> > fit since it is not a RGB LED. Please provide guidance.
> > 
> > This patch causes the system to not start: f741121a2251 leds: Fix
> > BUG_ON check for LED_COLOR_ID_MULTI that is always false
> > 
> > It was also backported to stable causing previously booting systems to
> > no longer boot.  
> 
> Lets cc patch authors.
> 
> And please drop this from stable, it does not belong there.
> 
> Best regards,
> 								Pavel

The BUG_ON was a no-op since it was introduced. It's purpose was to
prevent people from using LED_COLOR_ID_MULTI since it was thought that
non-RGB LEDs are not yet completely agreed on, or something.

But since the BUG_ON was a no-op, someone started using
LED_COLOR_ID_MULTI without noticing that they should not. There are now
even some in-tree device-tree files using LED_COLOR_ID_MULTI.

My patch that fixes the BUG_ON uncovered this and caused a regression
for some people.

I think we have to drop the BUG_ON altoghether now.

I've sent a patch to linux-leds doing just that.

Sorry for the incovenience.

Marek
