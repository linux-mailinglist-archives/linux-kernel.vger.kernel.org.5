Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD0F80A73B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574284AbjLHPV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574257AbjLHPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:21:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438C410DE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702048922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=v3raiss2uEo+4B2/2jWD3SM9eLFdIuye7z5fprUfGEs=;
        b=RZmYtzXclHQvUXvFlaMp8b38tWT8cW9doFf3zGgXeFEzfc6D91w47soAOsDJo7UoMOgUKw
        7aVVrE+8cPBG201hugmK0uz+wpflVfBG1pJsa78BXqjt0uNLNyF+dbBovbx6Bjo8qfZiym
        QmA3PvO9UPvPBJDgHBoDdhN59cWuJMg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-LIptLboAMDi6C3mTMMxOOQ-1; Fri, 08 Dec 2023 10:22:00 -0500
X-MC-Unique: LIptLboAMDi6C3mTMMxOOQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33335c6d495so1833953f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048919; x=1702653719;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3raiss2uEo+4B2/2jWD3SM9eLFdIuye7z5fprUfGEs=;
        b=X3Ifrw2HGHN0LyqpEIIr1ih+2JaR6YQoxghrN/OD1nshRc4rPOW+WWM17dxxXdDXeW
         R/6r/W5IDIneBXDUzhs5PcfFsGGEv/KK4XfAr80GaIH5g9qLWDHediWcDakuShowyLud
         XIkAnxLo/E93DE7u6zD8d1YKBBDEIc0snvwPcfxz+XO5YbmHjKoPnDL1qxDbAXNjd5c+
         3HiYXocr3gJ1E4Rx4T4VMQU1deN79CiqlnpYfAv5TScD8D00Rh+A7jeCzmVYABQSZJXZ
         mHEq+vjKzAAnmcBOeON6i7s953YWTfnSwIELP/AYU8mm7oh8E09yLSucj1fFVkGaCs3v
         6H+w==
X-Gm-Message-State: AOJu0Yyqmr1QgZoYt+ejBq/B+f7mw75H7m3839epDHb6+3Xm05wNwTuB
        TB9NZdnBDMh2E0wdJuV1a3sYJwLikNO6ZPjTXkohNCAYcIg4pwXoMnoWZw8G6Q6xhWuU3ncv1XM
        ftANwoxXhXYSyii5YrwypLLIB
X-Received: by 2002:a5d:614a:0:b0:336:9f9:6df with SMTP id y10-20020a5d614a000000b0033609f906dfmr113824wrt.5.1702048919695;
        Fri, 08 Dec 2023 07:21:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLgS9qWolessYaG5VTrLIbiadoOzWmYkVXdKEnOILyuEU1JX1wnx9G0HGW3zxhU/vRrSJ6Kw==
X-Received: by 2002:a5d:614a:0:b0:336:9f9:6df with SMTP id y10-20020a5d614a000000b0033609f906dfmr113808wrt.5.1702048919186;
        Fri, 08 Dec 2023 07:21:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c724:2100:3826:4f41:d72c:dc1b? (p200300cbc724210038264f41d72cdc1b.dip0.t-ipconnect.de. [2003:cb:c724:2100:3826:4f41:d72c:dc1b])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b00336103442d2sm830895wru.76.2023.12.08.07.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Dec 2023 07:21:58 -0800 (PST)
Message-ID: <990feea2-c7a8-4cd9-8a6a-bc4bc1c2ffab@redhat.com>
Date:   Fri, 8 Dec 2023 16:21:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <20231103121652.GA6217@noisy.programming.kicks-ass.net>
 <a002f903-723f-40ae-8d7a-421ab2e082e2@redhat.com>
 <20231208151401.GG28727@noisy.programming.kicks-ass.net>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20231208151401.GG28727@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.23 16:14, Peter Zijlstra wrote:
> On Fri, Nov 03, 2023 at 01:22:54PM +0100, David Hildenbrand wrote:
>> On 03.11.23 13:16, Peter Zijlstra wrote:
>>> On Tue, Jun 06, 2023 at 12:16:37AM -0700, John Hubbard wrote:
>>>> As per a discussion with Muhammad Usama Anjum [1], the following is how
>>>> one is supposed to build selftests:
>>>>
>>>>       make headers && make -C tools/testing/selftests/mm
>>>>
>>>> Change the selftest build system's lib.mk to fail out with a helpful
>>>> message if that prerequisite "make headers" has not been done yet.
>>>>
>>>
>>> NAK NAK NAK
>>>
>>> This now means I can no longer run selftests, I thank you very much! :-/
>>>
>>> root@spr:/usr/src/linux-2.6# make O=defconfig-build/ -j64
>>> make[1]: Entering directory '/usr/src/linux-2.6/defconfig-build'
>>> ***
>>> *** The source tree is not clean, please run 'make mrproper'
>>> *** in /usr/src/linux-2.6
>>>
>>>
>>> I've always done:
>>>
>>>     cd tools/testing/selftests/x86; make
>>>
>>> and that has always worked
>>>
>>> Now I can't bloody well build *any* selftest or risk not being able to
>>> do builds.
>>
>> This change landed in 6.5, no? And 6.6 was just released. Just curious why
>> you notice that now.
> 
> And I hit it again (different box etc..)
> 
> Can we please get this garbage fixed already?

I'd suggest to either revert or turn into a warning.

@John?

-- 
Cheers,

David / dhildenb

