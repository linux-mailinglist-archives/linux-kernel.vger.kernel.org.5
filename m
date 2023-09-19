Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2A287A6B8D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232729AbjISTX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjISTX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:23:56 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D81EA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 12:23:50 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id igK3qPuY0UbViigK3qXEEn; Tue, 19 Sep 2023 21:23:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1695151428;
        bh=++BRTgczvXAzPLBNoYHwrreKx2h+CPVA7wmJSZbhNqY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kBXQi2x6zRRCRsMwHppbatwDq5rdQeCpZnMo1yhXrGJZCvT+HOZ96T9wLDZh+QmBp
         DEnB0PF+h/V+aY5JgoIR1l4xidrgq9GQYAotfT1+6EbFo9BOBX3DKoO7EzxSF3nMcB
         z9OQlv+pUob+fUsJNO/rULfdx3CzbOzaq6ggyubHvfM94pgi/RBUAJJ3Z5zjPPpbTU
         sDGHSNeGVypOpAnnZ2P31IAkSv7pSPEk7uXkGj7EwYM+X/29UZ8vK7AeGLnN1eSEEM
         7X/Vj1TRRC4hM50uLg2D4q1T3tSugdiT3Wlr0/C4MJcsOFUD9C8mYUv3/wir7V0FLF
         p0yZwCwT54J+Q==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Sep 2023 21:23:48 +0200
X-ME-IP: 86.243.2.178
Message-ID: <011234f5-19f3-21c5-f0cf-8027971397e7@wanadoo.fr>
Date:   Tue, 19 Sep 2023 21:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] bcachefs: Use snprintf() instead of scnprintf() when
 appropriate
Content-Language: fr, en-CA
To:     Kent Overstreet <kent.overstreet@linux.dev>,
        Brian Foster <bfoster@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
References: <9a998be3e2dbedcd3a9eae5f81ae6dcc6c0f98c4.1694849375.git.christophe.jaillet@wanadoo.fr>
 <ZQmfZ/nPMgiJK9eW@bfoster> <20230919190234.2k7v75htqlbfqofh@moria.home.lan>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230919190234.2k7v75htqlbfqofh@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 19/09/2023 à 21:02, Kent Overstreet a écrit :
> On Tue, Sep 19, 2023 at 09:17:27AM -0400, Brian Foster wrote:
>> On Sat, Sep 16, 2023 at 09:30:19AM +0200, Christophe JAILLET wrote:
>>> snprintf() and scnprintf() are the same, except for the returned value.
>>> When this value is not used, it is more logical to use snprintf() which is
>>> slightly simpler.
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>
>> Seems reasonable:
>>
>> Reviewed-by: Brian Foster <bfoster@redhat.com>
> 
> No, let's stay with scnprintf as the default - snprintf should be
> deprecated except for when its return value is actually needed, using it
> incorrectly has been a source of buffer overruns in the past.
> 

Ok, I was not aware of it.

In this case, there are also some s/snprintf/scnprintf/ opportunities in 
fs/bcachefs

Does it make sense to update them or is it too low value changes?

CJ
