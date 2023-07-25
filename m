Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB041761295
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 13:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjGYLEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 07:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjGYLDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 07:03:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C3235FCA;
        Tue, 25 Jul 2023 04:00:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 424F215BF;
        Tue, 25 Jul 2023 04:01:19 -0700 (PDT)
Received: from [10.57.2.54] (unknown [10.57.2.54])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 48F503F67D;
        Tue, 25 Jul 2023 04:00:34 -0700 (PDT)
Message-ID: <09ce295f-f8c9-8663-4a7c-cf4a0c43a3ec@arm.com>
Date:   Tue, 25 Jul 2023 12:00:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/kallsyms: Fix build failure by setting errno
 before calling getline()
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kbuild@vger.kernel.org, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Nicolas Schier <n.schier@avm.de>
References: <20230724131741.954624-1-james.clark@arm.com>
 <CANiq72nJP+i10CZysua0QU=V=Cn=jdnLuV8KOqm6_NNFdg9S3w@mail.gmail.com>
 <6c99392f-6189-1835-3090-d5c7f95edaf9@arm.com>
 <CANiq72nPxb8p5YCTohGg5e3c4gPTYsfh8fB182D_SwO-rQm9pg@mail.gmail.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CANiq72nPxb8p5YCTohGg5e3c4gPTYsfh8fB182D_SwO-rQm9pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2023 11:33, Miguel Ojeda wrote:
> On Tue, Jul 25, 2023 at 10:55 AM James Clark <james.clark@arm.com> wrote:
>>
>> But I just checked now and it's just bear [1] that causes the issue.
>> Maybe it sets errno before forking and that persists in the child
>> processes? Not 100% sure how it works. I did debug scripts/kallsyms and
>> errno was already set on the first line of main(), so it's not some
>> other library call in kallsyms that is setting it but not being checked.
> 
> I think this is https://github.com/rizsotto/Bear/issues/469: bear
> preloads a library which was setting it to non-zero.
> 
> Now, even if bear was breaking a guarantee C programs have (`errno`
> for the initial thread at program startup is meant to be 0 according
> to the C standard), it is still a good idea to set `errno` to zero
> here in case something else happens to change `errno` within
> `kallsyms` in the future.
> 
> With the repro and the `bear` link issue added:
> 
>     Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> 
> Cheers,
> Miguel

Oh yeah nice find, that's the issue. I added it and sent a v2.

Thanks
James

