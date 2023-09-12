Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209F779D413
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236088AbjILOwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjILOwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:52:31 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3AD1BB;
        Tue, 12 Sep 2023 07:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=/Dq/kgzmWP9Mq/RztWe10io0Pr7hKjtceCIyaERWgas=; b=qHN5HslgceiWbG/UJUBNn1pF3A
        o22DOKTSiXFEG36QidRahZClCOxse7OpeqaJVrC2GYwMF2H/bbFg2YL1Metn9ZjT3qHyXue1uO+ro
        e4SIeuw7M46xOs/Wib4Fx+qYptqDHQ1zVrKdYPtoNwqOz9uGfYtA+zdzzIf77Ub1uDRG5eZJQ9hbk
        F/OBiXE4ip/BchkJcNmtZDlm1GPHU/u0Uqrh9BCFiuRZni6vi8MN61DMGrVkDsFZ3nJIElCU8Z2Es
        bYROUD+tYwxcJeHADYyJxvyYo0WD9/VyhwlzpWcF2gsS1htfhd7Ul4o358Nqn0kIVgqvwgsCipqo4
        0uHERL/Q==;
Received: from [2601:1c2:980:9ec0::9fed]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qg4kY-003fWJ-1C;
        Tue, 12 Sep 2023 14:52:22 +0000
Message-ID: <4364d453-3560-c3c2-15b1-146f9578755b@infradead.org>
Date:   Tue, 12 Sep 2023 07:52:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: linux-next: Tree for Sep 11
 (drivers/gpu/drm/i915/display/intel_backlight.o)
Content-Language: en-US
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     intel-gfx@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20230911121131.006d3fec@canb.auug.org.au>
 <eac933bb-eb6d-8b21-422a-b8c6255facc3@infradead.org>
 <87a5tresu8.fsf@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87a5tresu8.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/12/23 00:47, Jani Nikula wrote:
> On Mon, 11 Sep 2023, Randy Dunlap <rdunlap@infradead.org> wrote:
>> On 9/10/23 19:11, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Please do *not* include material destined for v6.7 in your linux-next
>>> included branches until *after* v6.6-rc1 has been released.  Also,
>>> do *not* rebase your linu-next included branches onto v6.5.
>>>
>>> Changes since 20230908:
>>>
>>> Non-merge commits (relative to Linus' tree): 643
>>>  614 files changed, 227990 insertions(+), 9502 deletions(-)
>>>
>>> ----------------------------------------------------------------------------
>>
>> on x86_64:
>>
>> # CONFIG_ACPI is not set
>> CONFIG_DRM_I915=y
>> CONFIG_BACKLIGHT_CLASS_DEVICE=m
>>
>> I915 selects BACKLIGHT_CLASS_DEVICE if ACPI is set.
>>
>> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_backlight_device_register':
>> intel_backlight.c:(.text+0x4988): undefined reference to `backlight_device_get_by_name'
>> ld: intel_backlight.c:(.text+0x4a1b): undefined reference to `backlight_device_register'
>> ld: drivers/gpu/drm/i915/display/intel_backlight.o: in function `intel_backlight_device_unregister':
>> intel_backlight.c:(.text+0x4b56): undefined reference to `backlight_device_unregister'
> 
> This comes up periodically. The fix is for i915 to depend on backlight,
> but it's not possible to fix just i915, as it'll lead to circular deps
> unless *all* select backlight is switched to depend on backlight.
> 
> I've gone through it once [1], and not keen on doing it again unless
> there's buy-in.
> 
> IS_REACHABLE() is often suggested as a workaround, but I think it's just
> plain wrong. i915=y backlight=m is not a configuration that makes
> sense. Kernel configuration is hard enough, there's no point in allowing
> dumb configs that just silently don't work.
> 

Yes, IS_REACHABLE() is just fugly nonsense.

Thanks for the reminder of your attempt(s).

> 
> BR,
> Jani.
> 
> 
> [1] https://lore.kernel.org/r/1413580403-16225-1-git-send-email-jani.nikula@intel.com
> 
> 
> 

-- 
~Randy
