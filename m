Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADECC760644
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 05:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjGYDFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 23:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbjGYDFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 23:05:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4305210C3;
        Mon, 24 Jul 2023 20:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=oa+so10xLETAgc5pdBX8v/zloJHSFamiykfxB9L3iNQ=; b=pqw9oioaugNc/2kx9y0xlJ9NId
        jyWlek+X1AoKk0llItmIC3Bf3mzcoWu0ZTlj6G2sYvsHiO6+UHsis4MxPhQujAYnQ0Z42oQw3MOUm
        aT1/QNOaq2uLaY9aJkIkqTjTvcxMB7aL12fQ/Vc3M2yGTqobvXOkxeikSUdxkM1cr1WxiIOdyE7ny
        +Gqkh6ljwnDBIToS47UTxIXHDk8B9zX34r2/93tHSoD4aLc9GQOhHrL10cFO7Dxj7xxU3c6KCEofm
        0GPJb3RuDytDWvYT1xQclal3ZH3bsRt6VE4SnFbBhLygs70kHMgmJ+w7zzOo3Q/2D610I+JeyZFt3
        roNC6HaA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qO8M8-005zR5-1M;
        Tue, 25 Jul 2023 03:05:00 +0000
Message-ID: <9fa8e67e-e46b-074d-8406-bfd11303e95f@infradead.org>
Date:   Mon, 24 Jul 2023 20:04:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] rework top page and organize toc on the sidebar
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>,
        Costa Shulyupin <costa.shul@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
        "open list:RUST" <rust-for-linux@vger.kernel.org>
References: <20230724193118.2204673-1-costa.shul@redhat.com>
 <87ila9atuk.fsf@meer.lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87ila9atuk.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/24/23 14:21, Jonathan Corbet wrote:
> Costa Shulyupin <costa.shul@redhat.com> writes:
> 
>> Template {{ toctree(maxdepth=3) }} in
>> Documentation/sphinx/templates/kernel-toc.html
>> uses directives toctree and doesn't use sections on the top page
>> Documentation/index.rst
>> to generate expandable toc on the sidebar.
>>
>> BTW, other template {{ toc }} uses only sections, and doesn't
>> use directives toctree.
>>
>> Summary of changes:
>> - split top page index.rst to several pages
>> - convert sections of Documentation/index.rst to hierarchical toctree
>> - vertical bars '|' add empty lines
>>
>> Benefits:
>> - collapsed toc is just seven short lines length
>> - toc is expandable
>>
>> References:
>> - https://www.sphinx-doc.org/en/master/development/templating.html#toctree
>> - https://www.sphinx-doc.org/en/master/usage/restructuredtext/directives.html#directive-toctree
>> - https://www.sphinx-doc.org/en/master/development/templating.html#toc
>> - https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
>> - https://sphinx-rtd-theme.readthedocs.io/
> 
> What is the purpose of all these links in a patch changelog?
> 
> This patch is somewhat difficult to apply, as a result of:
> 
>> Content-Type: text/plain; charset=true

I didn't have any problem applying and testing it.

> But the real problem is that you seem to have ignored my last message.
> The purpose of the front page isn't to create a nice-looking sidebar, it
> is the entry point to our documentation as a whole.  I am all for a
> better sidebar, but this is not the way to do it.

Regardless of what the purpose of the front page is, I prefer this one
from Costa.  The other one is a huge mess.

-- 
~Randy
