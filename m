Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38582787885
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243255AbjHXTct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241374AbjHXTc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:32:26 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCD31BE2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 12:32:24 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:3f:e471:aa00::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 285DE3FE;
        Thu, 24 Aug 2023 12:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1692905544;
        bh=ht7+AxhAtjZz6jkzzOwitUf5rEs0+O2PY7QBAk/RXrI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBF+UcIy1EH5t9CZnMocxz+BA54MN4B1ZCQ/u1FG/9VWsyTM/SpI9UGCqbt36wk3W
         BYnPoC0t1isvVJE7y9paPkMqN2teb3PL4FapOvLRb2i5yOrOZOSrnzGx7fj5KhkfUn
         kVTdkJn+plvYV8cm8w6UYSJMBh/c/NH/VTKy0AyE=
Date:   Thu, 24 Aug 2023 12:32:22 -0700
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: userspace-consumer: Use atomic operation
Message-ID: <e1416ea3-9e20-4662-b394-bc9f842bfccb@hatter.bewilderbeest.net>
References: <20230823141558.957526-1-Naresh.Solanki@9elements.com>
 <61279ff7-c1ad-446c-aa5e-4222a5cbd9fb@sirena.org.uk>
 <CABqG17gQEa70kEDVVhNkOeM2SYdZ6-gkYfYJUNV+=NzyogK_PA@mail.gmail.com>
 <ZOeLjbN8i4i+/kd+@finisterre.sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZOeLjbN8i4i+/kd+@finisterre.sirena.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 09:55:41AM PDT, Mark Brown wrote:
>On Thu, Aug 24, 2023 at 04:34:05PM +0530, Naresh Solanki wrote:
>> On Wed, 23 Aug 2023 at 20:41, Mark Brown <broonie@kernel.org> wrote:
>> > On Wed, Aug 23, 2023 at 04:15:57PM +0200, Naresh Solanki wrote:
>
>> > > Replace mutexes with atomic operations.
>
>> > Why?  Generally atomics are more complicated and hard to understand and
>> > get right.
>
>> Since the operations involved here are simple & short & can be managed by
>> atomic operation.
>
>Unless there's a strong positive reason to specifically use atomics it
>seems better to avoid them, like I say they're full of landmines with
>unexpeted behaviours and therefore something that sets off alarm bells
>about needing careful study, the mutex is going to be less preformant
>but is also much more clearly correct.

I assume this patch was posted as a result of a comment I made on the 
original patch [1], but in hindsight I probably shouldn't have suggested 
it as it's a relatively minor issue either way -- I think the other 
things brought up in that email are much more significant concerns.  
Honestly I don't think that patch should be applied in its present form, 
though I see it's still present in the regulator/for-next and 
regulator/for-6.6 branches -- Mark, do you intend to include it as-is in 
your pull request to Linus for the 6.6 merge window?

[1] https://lore.kernel.org/lkml/d3ea0fe2-00bb-493b-aca7-ba7a31bd3c78@hatter.bewilderbeest.net/


Zev

