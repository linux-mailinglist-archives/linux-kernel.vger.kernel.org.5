Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3EB4808D48
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 17:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjLGQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 11:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443690AbjLGQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 11:00:44 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F53121;
        Thu,  7 Dec 2023 08:00:50 -0800 (PST)
Received: from [10.3.2.161] (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BE36A660739F;
        Thu,  7 Dec 2023 16:00:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701964848;
        bh=o60ZivJAjuNVk9lMONJuI83P129Uc3ICsB0e+skvORE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=J+HzaMOmkobFxYMAtj8seSUoTES01PM+gUy6AJ1Rby/oRd0J7+PDOezsV5mD/tn6K
         EkSmnkdqoJuT8pb2R0q7hAurSYtX9c9b2lEnTDBPrmyJ/TIrJppmb14MZFbw8y86I3
         FqvfijCWVaKSW5bq6BY73mzVmS6dSpfajFksSpBuz1tD8SlmOMXZ7zYvChz2eZ+FD/
         NKR9hvbaqcvGJHK2sB9UhMf5OUH9dBlNMribUGYAOrOZ3fqexBu7YRmg4XGYHuJH1h
         71YB2AJZxJOwZKdvEGbB7jC0hPO+HAoOew1HOrDkHkjJlB9iER4S6RVUXfxJ/7FuB9
         3wlZgxaWA9ALg==
Message-ID: <95cc7716-ba01-e239-e7c0-eba0b7da7955@collabora.com>
Date:   Thu, 7 Dec 2023 19:00:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2] i2c: rk3x: fix potential spinlock recursion on poll
Content-Language: en-US
To:     Dragan Simic <dsimic@manjaro.org>,
        Jensen Huang <jensenhuang@friendlyarm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>,
        Benjamin Bara <bbara93@gmail.com>
References: <20231207082200.16388-1-jensenhuang@friendlyarm.com>
 <ebf6cf8ec3b5befd673d295061fa2738@manjaro.org>
 <CAMpZ1qHUnTDQ78gdrQF9Sx_-XfLM-B+H-0bL1-+twKsno+JOvg@mail.gmail.com>
 <5e11553952c02ad20591992be4284bbd@manjaro.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <5e11553952c02ad20591992be4284bbd@manjaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/23 17:10, Dragan Simic wrote:
> On 2023-12-07 10:25, Jensen Huang wrote:
>> On Thu, Dec 7, 2023 at 4:37 PM Dragan Simic <dsimic@manjaro.org> wrote:
>>>
>>> On 2023-12-07 09:21, Jensen Huang wrote:
>>> > Possible deadlock scenario (on reboot):
>>> > rk3x_i2c_xfer_common(polling)
>>> >     -> rk3x_i2c_wait_xfer_poll()
>>> >         -> rk3x_i2c_irq(0, i2c);
>>> >             --> spin_lock(&i2c->lock);
>>> >             ...
>>> >         <rk3x i2c interrupt>
>>> >         -> rk3x_i2c_irq(0, i2c);
>>> >             --> spin_lock(&i2c->lock); (deadlock here)
>>> >
>>> > Store the IRQ number and disable/enable it around the polling
>>> transfer.
>>> > This patch has been tested on NanoPC-T4.
>>>
>>> In case you haven't already seen the related discussion linked below,
>>> please have a look.  I also added more people to the list of recipients,
>>> in an attempt to make everyone aware of the different approaches to
>>> solving this issue.
>>>
>>> https://lore.kernel.org/all/655177f4.050a0220.d85c9.3ba0@mx.google.com/T/#m6fc9c214452fec6681843e7f455978c35c6f6c8b
>>
>> Thank you for providing the information. I hadn't seen this link before.
>> After carefully looking into the related discussion, it appears that
>> Dmitry Osipenko is already working on a suitable patch. To avoid
>> duplication
>> or conflicts, my patch can be discarded.
> 
> Thank you for responding so quickly.  Perhaps it would be best to hear
> from Dmitry as well, before discarding anything.  It's been a while
> since Dmitry wrote about working on the patch, so he might have
> abandoned it.

This patch is okay. In general, will be better to have IRQ disabled by
default like I did in my variant, it should allow to remove the spinlock
entirely. Of course this also can be done later on in a follow up
patches. Jensen, feel free to use my variant of the patch, add my
s-o-b+co-developed tags to the commit msg if you'll do. Otherwise I'll
be able to send my patch next week.

-- 
Best regards,
Dmitry

