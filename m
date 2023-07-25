Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD559760DB3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjGYI4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjGYIz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:55:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4378B270E;
        Tue, 25 Jul 2023 01:55:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FBF615BF;
        Tue, 25 Jul 2023 01:55:51 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB1D83F6C4;
        Tue, 25 Jul 2023 01:55:06 -0700 (PDT)
Message-ID: <6c99392f-6189-1835-3090-d5c7f95edaf9@arm.com>
Date:   Tue, 25 Jul 2023 09:54:57 +0100
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
From:   James Clark <james.clark@arm.com>
In-Reply-To: <CANiq72nJP+i10CZysua0QU=V=Cn=jdnLuV8KOqm6_NNFdg9S3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2023 01:41, Miguel Ojeda wrote:
> On Mon, Jul 24, 2023 at 3:18 PM James Clark <james.clark@arm.com> wrote:
>>
>> This fixes the following build failure if scripts/kallsyms launches with
>> a non-zero errno value:
> 
> The code change sounds good to me, but could you please describe the
> situation where you found the build failure?
> 
> Cheers,
> Miguel

I assumed it was something to do with one of the wrappers I'm using but
didn't get to the bottom of it because I'm using quite a few.

But I just checked now and it's just bear [1] that causes the issue.
Maybe it sets errno before forking and that persists in the child
processes? Not 100% sure how it works. I did debug scripts/kallsyms and
errno was already set on the first line of main(), so it's not some
other library call in kallsyms that is setting it but not being checked.

The minimal reproducer for me looks like this:

  bear -- make ARCH=arm64 LLVM=1 O=../build/

[1]: https://manpages.ubuntu.com/manpages/focal/en/man1/bear.1.html
