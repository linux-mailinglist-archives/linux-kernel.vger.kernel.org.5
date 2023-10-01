Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237447B45D8
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 09:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbjJAHu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 03:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJAHu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 03:50:26 -0400
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC14D8
        for <linux-kernel@vger.kernel.org>; Sun,  1 Oct 2023 00:50:24 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id mrDYq8ghSBIhHmrDYqqmz3; Sun, 01 Oct 2023 09:50:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1696146622;
        bh=wPXWPuO+l7Bt1DCLNCWcyq73NlME+4QNpzuzBGS7eHY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=NPRXBdo5D1S5ArsR8ea32mKYx0qkxgU11wt5LG7vWRr2BegBhpi8xxisH80G6FwiP
         LSOi5vaTw4/sF1DpEE/Y7l8G12M/Pkg9cRV/4H7ix6DTvJTCRXJkNXVik3np+mLAF6
         218e6UINweQw3G76HHzz0RtfmYaIWXALkUfDBuAeYxqIN61lOtTuDG3jyLY7oHCTJP
         27CPGqN5iFQ81YORV70cbmXV+/ykyiRoydbeWLiKJRTNyrYnL8BwH5wOgLYVNI2LRH
         7uQVoqOnwTMBqRFWlK9PNzi0qTP6VJ/NFkjIsCEFop4lAMLHAgH8YMqQrBIjYVED1Y
         1ug+sKWxczs9A==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 01 Oct 2023 09:50:22 +0200
X-ME-IP: 86.243.2.178
Message-ID: <7e234efd-413c-ef6b-857b-d364db21141e@wanadoo.fr>
Date:   Sun, 1 Oct 2023 09:50:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] comedi: Annotate struct comedi_lrange with __counted_by
To:     Julia Lawall <julia.lawall@inria.fr>,
        Kees Cook <keescook@chromium.org>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-hardening@vger.kernel.org,
        llvm@lists.linux.dev
References: <5c3b7459b820e22e2ac6ce892d4aadcc119cc919.1696065263.git.christophe.jaillet@wanadoo.fr>
 <202309301342.5B5BED40A1@keescook>
 <alpine.DEB.2.22.394.2310010922250.3166@hadrien>
Content-Language: fr, en-GB, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <alpine.DEB.2.22.394.2310010922250.3166@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/10/2023 à 09:25, Julia Lawall a écrit :
> 
> This is not found due to the regular expression used for the name of the
> alloc function.  Maybe you could drop it entirely?  Maybe you could just
> check for alloc somewhere in the string?

That's how I found it.
I simplified a lot Kees's script and looked for function names that did 
*not* match his regex.

Functions that:
    - return a pointer to a struct
    - are used with struct_size()
    - store the value used to compite the size in another field of the 
struct

are good enough candidates.
I think that removing the regex all together would be just good enough.

CJ

> 
> identifier ALLOC =~ "alloc";
> 
> works in this case.
> 
> Also, I see in the link that you have:
> 
> // Options: --all-includes
> 
> You can actually force this by putting
> 
> #spatch --all-includes

Nice, thanks for the tip.

> 
> and any other options you want.
> 
> julia
> 
> 


