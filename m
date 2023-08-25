Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA72788F37
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 21:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjHYTMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 15:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjHYTLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 15:11:40 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EB62133;
        Fri, 25 Aug 2023 12:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=l+921+INTTmytbRdikj/w1XM0sYIGBKYxXwPysBHkj4=; b=cUl7Wlklv20N6NFHbMMQZ2qkxz
        iOJS50gpsdgah/UsOFg0lq7wUfqKss37dUpIZ9rF7Ee193PFH1Sp37Edkg7Cp8Iml8lJyDcndu1am
        cnn9VjGvF8i+7j/JBBOQaxwBLmAv5YUjaQRXh4mJhkO8WdJ/UmDUCVImvX5MoyZAsqXPWatMLseXu
        QZIlEQi9GudaSu6wkELrAvBFjmWOBDG1x1einQ2rLgTqv4F6cqC82Ad0pTm3uMLheNRrfQzPk+YwH
        2Nt3bG4V5pr+Iz861A6saVF7YHYI9ZKsvlrbNU0EKgwYT6NSJcs+mhkF4TcEK2AFKcsKcbVoP1do8
        cWY77RWA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qZcDR-005vPP-1T;
        Fri, 25 Aug 2023 19:11:29 +0000
Message-ID: <a5d07fee-b950-ea48-c480-dd5a8a575969@infradead.org>
Date:   Fri, 25 Aug 2023 12:11:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] kbuild: Show Kconfig fragments in "help"
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230824223606.never.762-kees@kernel.org>
 <21193a52-0425-f5ae-90f0-10e4c578ae90@infradead.org>
 <202308251119.B93C95A3A7@keescook>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202308251119.B93C95A3A7@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/23 11:20, Kees Cook wrote:
> On Thu, Aug 24, 2023 at 05:04:02PM -0700, Randy Dunlap wrote:
>> Hi Kees,
>>
>> On 8/24/23 15:36, Kees Cook wrote:
>>> Doing a "make help" would show only hard-coded Kconfig targets and
>>> depended on the archhelp target to include ".config" targets. There was
>>> nothing showing global kernel/configs/ targets. Solve this by walking
>>> the wildcard list and include them in the output, using the first comment
>>> line as the help text.
>>>
>>> Update all Kconfig fragments to include help text and adjust archhelp
>>> targets to avoid redundancy.
>>>
>>> Adds the following section to "help" target output:
>>>
>>> Configuration fragment targets (for enabling various Kconfig items):
>>>   debug.config         - Debugging for CI systems and finding regressions
>>>   kvm_guest.config     - Bootable as a KVM guest
>>>   nopm.config          - Disable Power Management
>>>   rust.config          - Enable Rust
>>>   tiny-base.config     - Minimal options for tiny systems
>>>   tiny.config          - Smallest possible kernel image
>>>   x86_debug.config     - Debugging options for tip tree testing
>>>   xen.config           - Bootable as a Xen guest
>>>   tiny.config          - x86-specific options for a small kernel image
>>>   xen.config           - x86-specific options for a Xen virtualization guest
>>
>> ISTM that you are missing the "why" part of this change in the commit
>> description.
> 
> I want to see what fragments are available without needing to know the
> source tree layout for their locations. :)

Why?  :)

but you don't have to answer. I acquiesce (i.e., give up).

>> "make tinyconfig" is the real target here.  The other (tiny.) files are just
>> implementation details.
>> We can't put all implementation details into help messages and it's not
>> difficult to find that the (tiny.) config files are merged to make the
>> final .config file.
> 
> Yeah, this seems true for much of the ppc stuff to, as pointed out by
> mpe. I'll go answer there...
> 

-- 
~Randy
