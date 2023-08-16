Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD04877DB14
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242391AbjHPHX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242425AbjHPHXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:23:37 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323AC10DC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:23:35 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99d90ffed68so801462166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1692170613; x=1692775413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sEFICaToFyzUXkOG2roGq++utI+eaCie/kUBC7rJak0=;
        b=KqetDW6z02ZI9nse8ru2airlMkf2Lplckz3bcD8QF65+G7Le81HBHYK79jvlX8eeLj
         jVGhMy8uMnbfGk9riSvXxxIzgV+Kucj508RV8Fs3my2QamH5CTw1AzFJH2Lr2BcLtk7C
         1LLP76vs4x6sKVqm/DjO9cTAuz6OgZju+5mbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692170613; x=1692775413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEFICaToFyzUXkOG2roGq++utI+eaCie/kUBC7rJak0=;
        b=Nyy/ipioGqbQUejZ0lhXiTyXTl0gZPdnJQAwdirKdASeZF/W3WydgApbrprqfewZJz
         le5CyFRwlkFhsal/PGmSBzdXTr8H9LSkkDIOH9ox26EuFpwrmpz3QZ0YeB4G6kSCy2bU
         pQDAPjn/9vCGPNhEOUyMsDZ4PaOVL0RSr8TC9hUyCS3DbEHG0A0i5/i3MbSIGVPtHDP2
         Zjb/3kLe84HwzY8DZXVmN2jGsgzdoYFNseTbBX8SDIfYTRi9z/G5Htoj8BUplaCaLCed
         xJWISUvP5lum8Qji55ky/v1zhI3XgakKSfjjcJDeYAcy2CxMWeKachk6N6X+uOoYSDpn
         H8NQ==
X-Gm-Message-State: AOJu0YwhLvaYpYmoBHzNfMKGplu/f0BBmHbtV/g/GwjFemSjgrpYwsxg
        2tb07YFYgUZ2YHgTWWKQhaBreQ==
X-Google-Smtp-Source: AGHT+IGdqnVbCzppnlmNw8LNRK91Cd5HvbWHi+Mlu+TupBLCfQuYAyI0f1oM68K46ZMxbPckXFf82w==
X-Received: by 2002:a17:907:a42a:b0:988:d841:7f90 with SMTP id sg42-20020a170907a42a00b00988d8417f90mr4218211ejc.27.1692170613526;
        Wed, 16 Aug 2023 00:23:33 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id cw13-20020a170906c78d00b00992e265495csm8041803ejb.212.2023.08.16.00.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 00:23:32 -0700 (PDT)
Message-ID: <a68424ff-b5e5-4dab-5705-5b63084c98eb@rasmusvillemoes.dk>
Date:   Wed, 16 Aug 2023 09:23:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: cleanup: Make no_free_ptr() __must_check
Content-Language: en-US, da
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
 <fcc8a158-f6e4-8963-782f-ba04b47350b8@rasmusvillemoes.dk>
 <20230815135339.GA966323@hirez.programming.kicks-ass.net>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <20230815135339.GA966323@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 15.53, Peter Zijlstra wrote:
> On Tue, Aug 15, 2023 at 01:28:37PM +0200, Rasmus Villemoes wrote:
>
>> Also, isn't it more complicated than necessary? Can we get rid of the
>> inner stmt expr and tmp var by just making it
>>
>>   ((void) (p), ((typeof(p))__no_free_ptr((void **)&(p)))
>>
>> which is more or less the whole reason comma expressions is a thing.
> 
> Ah, so the point of the statement expression before the comma is to
> validate that (p) is in fact a pointer, and to that effect we assign it
> to a 'void *' temporary.
> 
> If that case is invalid, we'll get a compile fail with a dodgy message.
> 
> I did this, because (void **)&(p) looses type integrity due to the cast.
> 
> But yeah, I suppose it all needs a wee comment.

Ah, ok, I thought the purpose was to ensure the p expression gets
evaluated. Well, we can still do without the temp var and weird comma or
statement expressions:

static inline __must_check void * __no_free_ptr(void **pp, const void
*must_be_pointer_dummy)
{ void *p = *pp; *pp = NULL; return p; }

#define no_free_ptr(p) (__no_free_ptr((void **)&(p), p) )

Rasmus

