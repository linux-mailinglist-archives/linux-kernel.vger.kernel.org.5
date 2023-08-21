Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4AF7824DA
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbjHUHsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbjHUHsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:48:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4DF92
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:48:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c0290f0a8so374663066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1692604120; x=1693208920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJHWjcXEkykiw944poxSFMTZcS7Csi+nBW+nX63BvpM=;
        b=GCAFjf9CXoTlHF+Gv9UIMaQOvfrMZXNuDMhb0Q1sSq3Rq9j47swjXwd0CU7wvrKQMn
         G/v7dqyXX6OeCsgvYrdnpJQbb9LpM433uxqBtQtBpoc83NnoGo1y2kFJh3vv3tmdRUe4
         xmhg6mVHVZ/I3bibRVkf3jRqVaSmBv+rJqq10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692604120; x=1693208920;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJHWjcXEkykiw944poxSFMTZcS7Csi+nBW+nX63BvpM=;
        b=FKur64fm4B1hfjzxqiB1KjeNiVFXday9mxBVJOj6Ily3JBlCjTFNSuGhdktZIOMt7O
         VSn+DvSVV/24KqPuzGi4d0scduu4NxF7APp5gSHdIMKV5QMFBDJPbzKziawzURIs1vqD
         GiY7mDlT+kREjTR/XKV+oAkgfGRE9aODn3iu7jCj5brqq9bt0J95Nuk1iLQx4WUv8OW2
         AH9iqZdjY3nexe+RsaT2Sp0wRBRJFL5cdYZ0e+9Ld8KC9yWUrn9UPezAY8Mv0VIC6CpK
         bgZiCNkF+ZGMMcN4/YrAjeJYCNIX9A9Etw2l7Lu4TSvUdlUvHfB+sQvdP8dy+bJl/Xs/
         sGeg==
X-Gm-Message-State: AOJu0YwZLXITV2v0KiC0bhZVh2Z003pXJysHcOcH7UD7TTGYTLOMUQBK
        Y5cvV0ZDdrBV9B+HoG1pm4n3Nw2AzcsvGbpacVC27A==
X-Google-Smtp-Source: AGHT+IGAlm58OKlJJoATdkE3tZSv8bLSeSt36BNqKJ89rux/TLSsJ6GE7t+pAXmbzsUAO7S78lB/Hg==
X-Received: by 2002:a17:907:7845:b0:9a1:8f6f:6873 with SMTP id lb5-20020a170907784500b009a18f6f6873mr2065384ejc.33.1692604120158;
        Mon, 21 Aug 2023 00:48:40 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z24-20020a170906075800b0099bcf563fe6sm6057207ejb.223.2023.08.21.00.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 00:48:39 -0700 (PDT)
Message-ID: <f32995aa-df23-bf51-adb7-f024b76a33aa@rasmusvillemoes.dk>
Date:   Mon, 21 Aug 2023 09:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bitmap: optimize bitmap_remap()
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <20230815235934.47782-1-yury.norov@gmail.com>
 <ZN3qQPeFtdZQrLE4@smile.fi.intel.com> <ZN3qlCd+TcYiZg+s@smile.fi.intel.com>
 <ZN4tB7jkQrX/TKnh@yury-ThinkPad> <ZN4+nZwBu317dVjz@smile.fi.intel.com>
 <ZOAi9PB6+/p4orRN@yury-ThinkPad>
Content-Language: en-US, da
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <ZOAi9PB6+/p4orRN@yury-ThinkPad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2023 04.03, Yury Norov wrote:
> On Thu, Aug 17, 2023 at 06:37:01PM +0300, Andy Shevchenko wrote:

>> But this gives +89 bytes on x86_64... :-(
> 
> Who cares if it gives a boost of performance for regular users?

"Regular users" never ever hit bitmap_remap, it's simply too esoteric.
It has all of _two_ users in the whole tree, one in some gpio driver,
another only reached via a system call that nobody ever uses, and if
they do, it's most likely some one-time-per-process thing. It's about as
far from a hot path that you can come.

If it wasn't for that xilinx user, those bitmap_remap and bitmap_onto
etc. should be moved to be private to the NUMA code.

Anyway, I think those +89 was for Andy's own counterproposal. I haven't
built Yury's patch, but from a quick look, it should not add that much,
if anything - it adds a test, call, early return, but OTOH it helps the
compiler to combine the two set_bit (since only the first argument
differs), and loses the lock prefix.

As for that latter point, I don't think a separate patch is worth it,
just a comment in the commit log - we're already doing a bitmap_zero()
on dst which certainly doesn't use any atomic ops, and in general all
the bitmap_* functions expect the caller to handle locking.

So I don't mind Yury's patch, but I highly doubt it matters at all. The
comment mentions an example, do we even have that put in test code?

Rasmus

