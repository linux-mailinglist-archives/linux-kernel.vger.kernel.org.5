Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3E580E49C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjLLG7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 01:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjLLG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 01:59:15 -0500
X-Greylist: delayed 71897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 22:59:21 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAC3BF;
        Mon, 11 Dec 2023 22:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702364359;
        bh=F41feDTLD6EeSRJQf7rvDdapR+nQMsHfWA39oKGkLZw=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=0ktkwAIOn1gHRVA2zhrHIyNM2u35YJz/y5vQZFlw6eFQbWsCHcaZo3qZv8LihEq9A
         /2yEYGNfbCpbvzn+Xbw4ZGhQMZ1X0nrOOUs8UCu79FRTAltvEmzsIuA1U81di7r9xR
         TykJ4WuqkOCCnrLjXiVqN9fr55Vd08Y8nZ3AGT9qpv9t/m3mQU/yeYvfxeEQ7nhPdT
         7+nBysn+06H6syKxsX5U4s7iVIXYD756YTfSXuDtnEefCci0uNFoo7XTvTynasmLvR
         wU1sBknUJ5aeFVg3DStDQhk/rznCeo5rihTztnZ0gB7AG7wjcZeaCycHBsf1lKUncw
         3pGxxuqMbIbEg==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id A2D7E37809D0;
        Tue, 12 Dec 2023 06:59:15 +0000 (UTC)
Message-ID: <54a02895-26e5-4113-84f4-3f04358f09e6@collabora.com>
Date:   Tue, 12 Dec 2023 11:59:12 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Revert "selftests: error out if kernel header files are
 not yet built"
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <20231209020144.244759-1-jhubbard@nvidia.com>
 <0b35fcbd-ce8c-4c12-9725-01f18ade9fc0@collabora.com>
 <cf4e9f8b-7d31-44d9-93fd-1677918b56f4@nvidia.com>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <cf4e9f8b-7d31-44d9-93fd-1677918b56f4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/23 12:00 AM, John Hubbard wrote:
> On 12/11/23 03:00, Muhammad Usama Anjum wrote:
>> On 12/9/23 7:01 AM, John Hubbard wrote:
>>> This reverts commit 9fc96c7c19df ("selftests: error out if kernel header
>>> files are not yet built").
>> I don't think whole of this commit needs to be reverted. Lets leave the
>> warning message as it is and just remove the condition to abort the
>> compilation.
>>
> 
> Hi Muhammad!
> 
> If we do decide that "make headers" or something like it is required,
> then yes, this patch should be changed from a revert, to a "warn instead
> of failing out" patch.
I support this is as most of the times when the latest headers aren't
installed in the system. Hence the build of all those kselftests would fail
which require the recently added macros. There is no workaround to build
those tests until `make headers` is done or the latest headers are
installed. The former is easier.

If we just turn this into warning, most people reporting issues with `make
headers` would go away. They will be able to build all those kselftest
which don't require latest headers. For example mincore kselftest gets
build without KHDR_INCLUDES. In case people want to build failing tests,
they should add #ifdefs to the tests and submit patches which is idea 4.

> 
> First, though, I'd like us to choose a design direction. The patch as
> written is intended to put us on a design that does not require "make
> headers" before building the selftests, because that approach would work
> for all the cases I've seen so far.
> 
> If we want something else, then David Hildenbrand has listed several
> ideas, and I've added a 4th one to the list, in [1].
> 
> 
> [1] https://lore.kernel.org/3eadd79c-c02a-495f-92c0-0315046ef59f@nvidia.com
> 
> 
> thanks,

-- 
BR,
Muhammad Usama Anjum
