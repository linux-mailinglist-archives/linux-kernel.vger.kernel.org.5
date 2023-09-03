Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08408790B42
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 10:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236110AbjICIjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 04:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjICIjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 04:39:46 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654D8CD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693730382;
        bh=yxkc19Yddxx2lm9hSObkxc16S8ET0C2EW0xu5EssMEM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=FlzrZxbQ6JBLaz00gEXjXI50hWB7NUPkxoiuOxH98CecURVCxyz5lHje2uzTsL+vg
         HPONEPB6ID7wTv++XVQV24VAnKxhEGi5RLz204E0onrAld7CoxmQ/iLLSoJX9UMqWv
         F2ujWkfRCh6Ab6YNTkb/VWgb8J7qmsUV46uSKTY1C6w0Xb+KTCobd179qD2hUKSZ1b
         StUcDdDGVLMyEZJL/p5r1mpKX2R1lQtnhfSuOgyu+PHLI6FDJd1I5l/Unz8L23dfPg
         ECw/U7FHOeqD3pgiqlEk9xWPpjY9k/gMHy1d+y/LYtTyV6Wjf1lI8x1/qoX0nXdmr6
         9xjntut/TxVKg==
Received: from [10.20.0.2] (unknown [182.253.126.208])
        by gnuweeb.org (Postfix) with ESMTPSA id 35E9024B3E1;
        Sun,  3 Sep 2023 15:39:38 +0700 (WIB)
Message-ID: <a1cea8e2-610a-c17e-22df-b1a23a226f31@gnuweeb.org>
Date:   Sun, 3 Sep 2023 15:39:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH v3 2/4] tools/nolibc: x86-64: Use `rep stosb` for
 `memset()`
Content-Language: en-US
To:     Willy Tarreau <w@1wt.eu>
Cc:     Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        David Laight <David.Laight@aculab.com>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230902133505.2176434-1-ammarfaizi2@gnuweeb.org>
 <20230902133505.2176434-3-ammarfaizi2@gnuweeb.org>
 <CAOG64qNB+aRU+8VCD5MkM4srQaUnTqzZ7rZ8USxVheDAYzgTsQ@mail.gmail.com>
 <ZPOOPjK+z847Ivq4@biznet-home.integral.gnuweeb.org> <ZPRBBT1ENJIB0cEp@1wt.eu>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
In-Reply-To: <ZPRBBT1ENJIB0cEp@1wt.eu>
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

[ Resend, I sent it using the wrong From address. ]

On 2023/09/03 午後3:17, Willy Tarreau wrote:
> On Sun, Sep 03, 2023 at 02:34:22AM +0700, Ammar Faizi wrote:
>> On Sun, Sep 03, 2023 at 02:28:18AM +0700, Alviro Iskandar Setiawan wrote:
>>> nit: Be consistent. Use \n\t for the memset too.
>>
>> Good catch, I'll fix that in v4 revision.
> 
> Ammar, I'm overall fine with your series. I can as well add the missing \t
> to your patch while merging it, or wait for your v4, just let me know.

I'm now traveling and will be available in Jakarta on Monday. Thus, I
actually planned to send the v4 revision on Monday.

However, since you don't have further objections to this series, I'll
leave the trivial missing bit to you. Please merge this series and I
will not send a v4 revision.

Thanks,
-- 
Ammar Faizi

