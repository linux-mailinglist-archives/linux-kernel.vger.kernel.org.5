Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA23C807871
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:15:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379330AbjLFTPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379257AbjLFTPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:15:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E620B193
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 11:15:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EA29C433C7;
        Wed,  6 Dec 2023 19:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701890137;
        bh=SQBCq+vdv0d3tGaClUH0WQbz0FTWgbIDaKT4M0mAh1M=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZW3mQY6IaEElt6DdQcPJRLSzIdWZQ+mW/oGAUfWPF2QMPgjxB9CT2p1Lhiajup1XC
         oDqO70xg+YNQp5jh9A47oedCCkYEThPN9EUufF8iGfoHJHyA2NGwIEjPxW3LJico6Q
         ZRXIGKfWNAV0wC6LYY8h0u3cJuWmILQn7Z/dQQUelRcWo5mnS6Q1KIFwT2u7JCO7YS
         5nWgtdFB4Shah17Pk0zmJYLglrUo1e+SZlKWrXIznjllXhx8Ydf5/Yq7GqDLtYRn0n
         SEiXpR8E422gZuQUqE+CRWSH3WHlEIlFKNKhZQ8RZYYiiBfWVX22Pr6pfyIeFXJk24
         KysCm5H0cGrTw==
Message-ID: <e4823a44-33a9-4dbf-a39d-66ae256b903a@kernel.org>
Date:   Wed, 6 Dec 2023 12:15:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Judy Hsiao <judyhsiao@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Simon Horman <horms@kernel.org>,
        Brian Haley <haleyb.dev@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <joel.granados@gmail.com>,
        Julian Anastasov <ja@ssi.bg>,
        Leon Romanovsky <leon@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
References: <20231206033913.1290566-1-judyhsiao@chromium.org>
 <20231206093917.04fd57b5@hermes.local>
 <efd58582-31b6-47f0-ba14-bf369fddd1c0@kernel.org>
 <CAD=FV=UgPZoXsGTgLV_4X9x2hGTMouO3Tpe9_WkwhU7Bsvav2Q@mail.gmail.com>
From:   David Ahern <dsahern@kernel.org>
In-Reply-To: <CAD=FV=UgPZoXsGTgLV_4X9x2hGTMouO3Tpe9_WkwhU7Bsvav2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/23 11:49 AM, Doug Anderson wrote:
> Hi,
> 
> On Wed, Dec 6, 2023 at 9:51 AM David Ahern <dsahern@kernel.org> wrote:
>>
>> On 12/6/23 10:39 AM, Stephen Hemminger wrote:
>>> On Wed,  6 Dec 2023 03:38:33 +0000
>>> Judy Hsiao <judyhsiao@chromium.org> wrote:
>>>
>>>> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
>>>> index df81c1f0a570..552719c3bbc3 100644
>>>> --- a/net/core/neighbour.c
>>>> +++ b/net/core/neighbour.c
>>>> @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>>>  {
>>>>      int max_clean = atomic_read(&tbl->gc_entries) -
>>>>                      READ_ONCE(tbl->gc_thresh2);
>>>> +    u64 tmax = ktime_get_ns() + NSEC_PER_MSEC;
>>>>      unsigned long tref = jiffies - 5 * HZ;
>>>>      struct neighbour *n, *tmp;
>>>>      int shrunk = 0;
>>>> +    int loop = 0;
>>>>
>>>>      NEIGH_CACHE_STAT_INC(tbl, forced_gc_runs);
>>>>
>>>> @@ -278,11 +280,16 @@ static int neigh_forced_gc(struct neigh_table *tbl)
>>>>                              shrunk++;
>>>>                      if (shrunk >= max_clean)
>>>>                              break;
>>>> +                    if (++loop == 16) {
>>>
>>> Overall looks good.
>>> Minor comments:
>>>       - loop count should probably be unsigned
>>>         - the magic constant 16 should be a sysctl tuneable
>>
>> A tunable is needed here; the loop counter is just to keep the overhead
>> of the ktime_get_ns call in check.
> 
> From context, I'm going to assume you meant a tunable is _NOT_ needed here. ;-)
> 
> -Doug

yes, multitasking fail :-(
