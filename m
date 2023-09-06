Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476047944C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 22:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244528AbjIFUvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 16:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbjIFUvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 16:51:00 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D53ECEB;
        Wed,  6 Sep 2023 13:50:53 -0700 (PDT)
Received: from [10.251.0.9] (unknown [176.126.217.202])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 9247628029E;
        Wed,  6 Sep 2023 20:50:50 +0000 (UTC)
Message-ID: <6422b80a-7588-eeaa-360d-ae12c7628ee0@zonque.org>
Date:   Wed, 6 Sep 2023 22:50:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] gpio: zynq: restore
 zynq_gpio_irq_reqres/zynq_gpio_irq_relres callbacks
To:     Arnd Bergmann <arnd@arndb.de>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        manikanta.guntupalli@amd.com
Cc:     linux-kernel@vger.kernel.org, stable@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230901122424.247070-1-daniel@zonque.org>
 <6406fb2e-afb2-461d-9bac-aa157cf6d16f@leemhuis.info>
 <93e5e75d-3cfc-485b-9f81-54c82c58e24e@app.fastmail.com>
Content-Language: en-US
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <93e5e75d-3cfc-485b-9f81-54c82c58e24e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/23 22:12, Arnd Bergmann wrote:
>> On 01.09.23 14:24, Daniel Mack wrote:
>>> Commit f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip
>>> warning") ditched the open-coded resource allocation handlers in favor
>>> of the generic ones. These generic handlers don't maintain the PM
>>> runtime anymore, which causes a regression in that level IRQs are no
>>> longer reported.
>>>
>>> Restore the original handlers to fix this.
>>>
>>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>>> Fixes: f56914393537 ("gpio: zynq: fix zynqmp_gpio not an immutable chip warning")
>>> Cc: stable@kernel.org
>>
>> This seems to be a regression report that comes straight with a fix, but
>> there wasn't a single reply yet afaics. :-/ Maybe the extended list of
>> recipients will get things moving. But to ensure this doesn't fall
>> through the cracks, I'll add it to the list of tracked regressions.
> 
> I don't understand what the GPIOCHIP_IRQ_RESOURCE_HELPERS change
> intended to do in the first place: Manikanta's patch changed the behavior
> here with the addition of GPIOCHIP_IRQ_RESOURCE_HELPERS, while my patch
> was a cleanup that removed the dead code.

Manikanta's patch (f56914393537 "gpio: zynq: fix zynqmp_gpio not an
immutable chip warning") did many things at once, the move to the
generic resource handlers was just one of the changes. I can only guess
that it intended to simply the code a bit, and the dropped pm runtime
detail was just an oversight.

> Daniel's fix reverts both my cleanup patch and part of the original
> change, which may or may not be what we want here.

Enabling the pm runtime is necessary on my boards, at least for level
IRQs. Edge IRQs are still handled fine, interestingly.


Thanks,
Daniel

