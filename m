Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5209A7A81AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbjITMrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235315AbjITMrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:47:31 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DF692
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:47:25 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3216ba1b01eso1456992f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695214043; x=1695818843; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lMsBM7hXrqR5b7bV/7lky10XsDwyC0vxeuJu6D39beI=;
        b=UnyCo1GSO2O5cf9K4ShZZQZ9pmyPKXdoZfkTotr8553ii5zmKHIaZ+1oRla/hF1+QN
         HYjxgbyrDukCIjTWh6KeOyc5UWdHdrfa26LoVLp04rq0E2PzBd2TPey0va7lgjo+rT1S
         snR/ttczam3PDSEfxBDKjoRY0vJNED7pv65EaIccMWhlceV8RMXWsqTi6bZTWf3P6nuX
         T6VJVqlui9ak2wH1/Snb2+i8dcxfCboAQOWwBRHCufZ8yWeNMAkLfCyHyii66Yq+TCTp
         Ik0hPr88yPGBAGc+O8q0KnojUfhKpJAErcus89hmidsTn7msWYLJe9RPq/k+VqK+MRdw
         zcHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695214043; x=1695818843;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMsBM7hXrqR5b7bV/7lky10XsDwyC0vxeuJu6D39beI=;
        b=U3R4tHimAnbEFb2IlwpGfbDMBccY7zQ8dQexuR3ZxqvJC3v3kQUQMligcddKYhfqf6
         c2Xz2mr3USpj48TkYlvVlr3xlfewb0AMcE9X/Cyiv7tZ+s2CwpnKwQgfUKbfRkOqaWUf
         8WlogSHf0od7i0fJ8sV1lplji96dsPse6ahbN19wRWuS1jv5OsVL6/pHTdzi+hGzn8ok
         3b2tLqeRH2K41TrM89hofpfPVDmzGSf8pupcS3c9BkYWN6Qc6P/eRj8BNaM1+P2h1PQe
         4H5wykn5pJKIn60tvj5Zdran60yZuo0z0gYVf1ORmuKxKPrMiyYFo99Vn9UQALw12TrZ
         oi5w==
X-Gm-Message-State: AOJu0YzwS8pcNvsx1MADDtjJWkFvMT/BoI5JK9Csd0oNK7OjAur73sOs
        qYfVHjNLFOb+IUPodCxr5VNv+BTyfbTnBg==
X-Google-Smtp-Source: AGHT+IEZK9xRjhrzpFZuQpfpn6pJCnRR5xs9Z0h3Oyx469joo2QqWVLiLR5pbNU/4hlEYjm4AGUqNw==
X-Received: by 2002:adf:f3c8:0:b0:315:ad1a:5abc with SMTP id g8-20020adff3c8000000b00315ad1a5abcmr2367374wrp.5.1695214043196;
        Wed, 20 Sep 2023 05:47:23 -0700 (PDT)
Received: from [192.168.1.7] (82-64-78-170.subs.proxad.net. [82.64.78.170])
        by smtp.gmail.com with ESMTPSA id v23-20020adfa1d7000000b003142ea7a661sm16377127wrv.21.2023.09.20.05.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 05:47:22 -0700 (PDT)
Date:   Wed, 20 Sep 2023 14:47:15 +0200
From:   Paul Grandperrin <paul.grandperrin@gmail.com>
Subject: Re: [PATCH] misc: rtsx: Fix some platforms can not boot and move the
 l1ss  judgment to probe
To:     gregkh@linuxfoundation.org
Cc:     Ricky WU <ricky_wu@realtek.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org, Jade Lovelace <lists@jade.fyi>
Message-Id: <RIBA1S.HYP1X2RG9UAF3@gmail.com>
In-Reply-To: <2023092032-blurred-upload-30bd@gregkh>
References: <37b1afb997f14946a8784c73d1f9a4f5@realtek.com>
        <2023092032-blurred-upload-30bd@gregkh>
X-Mailer: geary/43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg and Ricky,
I just finished testing the patch (on top of 6.1.53) and AFAICT it's 
working perfectly:
- system boots and all hardware devices seems to work fine
- nothing weird in kernel and system logs
- suspend-to-ram (S3) works
- the SD card reader works

If there's anything more you want me to test, don't hesitate.

Paul

On Wed, Sep 20 2023 at 11:21:13 +02:00:00, gregkh@linuxfoundation.org 
wrote:
> On Wed, Sep 20, 2023 at 09:11:19AM +0000, Ricky WU wrote:
>>  commit 101bd907b424 ("misc: rtsx: judge ASPM Mode to set PETXCFG 
>> Reg")
>>  some readers no longer force #CLKREQ to low
>>  when the system need to enter ASPM.
>>  But some platform maybe not implement complete ASPM?
>>  it causes some platforms can not boot
>> 
>>  Like in the past only the platform support L1ss we release the 
>> #CLKREQ.
>>  Move the judgment (L1ss) to probe,
>>  we think read config space one time when the driver start is enough
>> 
>>  Fixes: 101bd907b424 ("misc: rtsx: judge ASPM Mode to set PETXCFG 
>> Reg")
>>  Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> 
> What about all of the people that reported this issue?  Have they been
> able to test it?  At least a reported-by line should be added, right?
> 
> And I'd like someone to test it to verify it fixes the issue before
> applying it...
> 
> thanks,
> 
> greg k-h


