Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2687907D4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 14:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352152AbjIBMg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 08:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjIBMg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 08:36:58 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456AB10E4
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693658214;
        bh=NNpqYT9YeF3YXjLBcd5b0oMc+DCin9FvQPyvtuAfieY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=tC8RJvvSbIOd9SJKKD/jaqhMGzVZphMQ1hV0SYvUz/Fv0Gw68sbTtb/HddVovfrx+
         TTMC9Oa8MMjii9AfuPeTBPV2pL3lrrIgdSqJDUAcVHuj/1zN8xYeWGlmQ5ypOug5pW
         lLZl7WwUgH9IyYFkeUMkAyi0XzkapdSgYr/eI8AulwyZk0y8po5uaON1PZRshKQh75
         zep7yOlPe6AE7zinUSe98YHE0+G0XvxwZq3QmBNM/wSxUJ5KCqxlM2JirwRbZi5g7E
         LHI2Nqg8xGEXRwBLKcZgM1AmvEfpTl1hWoEKocDMyxiOoGFGgWrXvMHFSdQF4/cAID
         PPnzg1pBy2xCA==
Received: from [10.20.0.2] (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 766CB24B39E;
        Sat,  2 Sep 2023 19:36:51 +0700 (WIB)
Message-ID: <4459ed19-f603-b4f6-392e-4e1322e06d56@gnuweeb.org>
Date:   Sat, 2 Sep 2023 19:36:47 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v2 1/4] tools/nolibc: x86-64: Use `rep movsb` for
 `memcpy()` and `memmove()`
Content-Language: en-US
To:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230902055045.2138405-1-ammarfaizi2@gnuweeb.org>
 <20230902055045.2138405-2-ammarfaizi2@gnuweeb.org>
 <CAOG64qNw+ZovcC4+5Sqsvi-m=wyoe47eb5K4KAdbO5hcp8ipAA@mail.gmail.com>
 <ZPLR+mO/6/V7wjAJ@biznet-home.integral.gnuweeb.org>
 <20230902062237.GA23141@1wt.eu>
 <ZPLYRENvjAub3wq5@biznet-home.integral.gnuweeb.org>
 <CAOG64qOuAfHREhcsC3THmhvH+NjhZRJtxp8gG39NosdhbZQvLA@mail.gmail.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <CAOG64qOuAfHREhcsC3THmhvH+NjhZRJtxp8gG39NosdhbZQvLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/09/02 午後7:29, Alviro Iskandar Setiawan wrote:
> On Sat, Sep 2, 2023 at 1:38 PM Ammar Faizi wrote:
>> Ok, I'll do that.
> 
> Another micro-optimization. Since the likely case is the forward copy,
> make it the case that doesn't take the jump.
> 
> Pseudo C:
> if (unlikely(dst - src < n))
>          backward_copy();
> else
>          forward_copy();

Point taken.

-- 
Ammar Faizi

