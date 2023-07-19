Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B60F3758AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjGSBZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGSBZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:25:36 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E258B12F;
        Tue, 18 Jul 2023 18:25:34 -0700 (PDT)
Received: from [IPV6:2001:250:4000:5113:b1a1:bdb4:62a:cbc5] ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=PLAIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 36J1P3dQ011344-36J1P3dR011344
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 19 Jul 2023 09:25:03 +0800
Message-ID: <b14a23c8-826e-ad36-1cbb-bea4938b6368@hust.edu.cn>
Date:   Wed, 19 Jul 2023 09:25:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3] wifi: ath9k: fix printk specifier
To:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230706111700.14305-1-dzm91@hust.edu.cn>
 <87cz15s2gv.fsf@toke.dk>
 <CAOiHx=kccbUFGsWMA_31UPW6p=k1qa+HyL5OGyzv50W2Mc111w@mail.gmail.com>
 <87a5w7hm46.fsf@toke.dk>
From:   Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <87a5w7hm46.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/7 21:44, Toke Høiland-Jørgensen wrote:
> Jonas Gorski <jonas.gorski@gmail.com> writes:
>
>> On Thu, 6 Jul 2023 at 13:39, Toke Høiland-Jørgensen <toke@toke.dk> wrote:
>>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>>
>>>> Smatch reports:
>>>>
>>>> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
>>>> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
>>>>
>>>> Fix it by modifying %lx to %p in printk.
>>>>
>>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>> Third time is the charm! :)
>>>
>>> Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
>> But do we *want* to replace %lx with %p? Because this now causes a
>> change in behavior, as the kernel will omit the pointer's address,
>> while before it printed the actual memory address. Using %px would
>> have kept the original behavior.
> So this is basically an informational log message, which really
> shouldn't be leaking kernel pointer addresses. So I think %p is the
> right choice here, and if someone wants to see the real address for
> debugging they should be booting with no_hash_pointers.
>
>> So if the change is desired, it should be noted in the commit message.
> That is a fair point, documenting this in the commit message would be
> good...

Hi Toke,

What's the next? Patch v4 with a note at the end, like the following,

"Note that %p would by default print a hashed value without leaking the 
kernel pointer to user space."


> -Toke
