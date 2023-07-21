Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5575C526
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjGUK6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjGUK6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:58:01 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF821731;
        Fri, 21 Jul 2023 03:57:55 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1689937072; bh=g0/y5gTWfkk2JQzH50DsaOTRZD0cVu75wCoJfKdJ2OE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PWMbcVtkEqNmU46vpk63Tnbr2JrWwSYk7IAd6DTKGqbgTLkLUyDa5M3GerO4zAYiZ
         TA+WUkOOEly1rNgnWB4Pqw7Wjq/WzkEkC4YK3qyLNmhscyk7F7i6XY4kyHfuhHP5GF
         FedWZnnCLQgm40Mh77ejdeNUcLbDKRxusGMWcrhTleg5q5a/1eU+fx+2qvmRZNuLIV
         k/zNUavZyEAoHsR5yDABj1E3r9v6NWSm3ZntwFIu5c89SXo1TF/M3KbpJb/d890kft
         Wt6YNqJEPV7lY2O1T6gnZgR1lpDxpF8qruaKIVoyRSx93ALGRSWp4PYis5ihgyOj+O
         y8mBhQSDNSjIg==
To:     Dongliang Mu <dzm91@hust.edu.cn>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] wifi: ath9k: fix printk specifier
In-Reply-To: <b14a23c8-826e-ad36-1cbb-bea4938b6368@hust.edu.cn>
References: <20230706111700.14305-1-dzm91@hust.edu.cn>
 <87cz15s2gv.fsf@toke.dk>
 <CAOiHx=kccbUFGsWMA_31UPW6p=k1qa+HyL5OGyzv50W2Mc111w@mail.gmail.com>
 <87a5w7hm46.fsf@toke.dk>
 <b14a23c8-826e-ad36-1cbb-bea4938b6368@hust.edu.cn>
Date:   Fri, 21 Jul 2023 12:57:52 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y1j9sf9r.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> writes:

> On 2023/7/7 21:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Jonas Gorski <jonas.gorski@gmail.com> writes:
>>
>>> On Thu, 6 Jul 2023 at 13:39, Toke H=C3=B8iland-J=C3=B8rgensen <toke@tok=
e.dk> wrote:
>>>> Dongliang Mu <dzm91@hust.edu.cn> writes:
>>>>
>>>>> Smatch reports:
>>>>>
>>>>> ath_pci_probe() warn: argument 4 to %lx specifier is cast from pointer
>>>>> ath_ahb_probe() warn: argument 4 to %lx specifier is cast from pointer
>>>>>
>>>>> Fix it by modifying %lx to %p in printk.
>>>>>
>>>>> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
>>>> Third time is the charm! :)
>>>>
>>>> Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>> But do we *want* to replace %lx with %p? Because this now causes a
>>> change in behavior, as the kernel will omit the pointer's address,
>>> while before it printed the actual memory address. Using %px would
>>> have kept the original behavior.
>> So this is basically an informational log message, which really
>> shouldn't be leaking kernel pointer addresses. So I think %p is the
>> right choice here, and if someone wants to see the real address for
>> debugging they should be booting with no_hash_pointers.
>>
>>> So if the change is desired, it should be noted in the commit message.
>> That is a fair point, documenting this in the commit message would be
>> good...
>
> Hi Toke,
>
> What's the next? Patch v4 with a note at the end, like the following,
>
> "Note that %p would by default print a hashed value without leaking the=20
> kernel pointer to user space."

Yes, please send a new version with the explanation added. However, this
should include not just *what* is changed, but *why* as well. So maybe
something like:

"Note that with this change, the pointer address will be printed as a
hashed value by default. This is appropriate because the kernel
shouldn't leak kernel pointers to user space in an informational
message. If someone wants to see the real address for debugging
purposes, this can be achieved using the no_hash_pointers kernel option"


-Toke
