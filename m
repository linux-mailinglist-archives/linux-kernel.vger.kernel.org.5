Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9340D78E5EC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239767AbjHaFpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHaFpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:45:13 -0400
Received: from zproxy1.foxvalley.net (zimbra.foxvalley.net [212.78.26.134])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id A9A11E0;
        Wed, 30 Aug 2023 22:45:10 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id 15E3440042;
        Thu, 31 Aug 2023 00:45:10 -0500 (CDT)
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 6M-gKkwQniDA; Thu, 31 Aug 2023 00:45:09 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zproxy1.foxvalley.net (Postfix) with ESMTP id B73E040F9F;
        Thu, 31 Aug 2023 00:45:09 -0500 (CDT)
X-Virus-Scanned: amavis at zproxy1.foxvalley.net
Received: from zproxy1.foxvalley.net ([127.0.0.1])
 by localhost (zproxy1.foxvalley.net [127.0.0.1]) (amavis, port 10026)
 with ESMTP id pwh8NBh1opZu; Thu, 31 Aug 2023 00:45:09 -0500 (CDT)
Received: from [192.168.1.3] (unknown [161.97.241.227])
        by zproxy1.foxvalley.net (Postfix) with ESMTPSA id 54CA740042;
        Thu, 31 Aug 2023 00:45:09 -0500 (CDT)
Message-ID: <82b80554-2042-7dcb-83c5-6a6b640c71be@foxvalley.net>
Date:   Wed, 30 Aug 2023 23:45:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] vt: Fix potential read overflow of kernel memory
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230830160410.3820390-1-azeemshaikh38@gmail.com>
 <2023083035-unpadded-amulet-8c7e@gregkh>
 <CADmuW3Wbgb7s+jRm8F0hcjzreWysVdzNvv778yUbGCOxAJHwjQ@mail.gmail.com>
 <202308301421.997C4034B5@keescook>
 <aa488b1d-51b2-7b55-7a8d-552306ca16dd@foxvalley.net>
 <202308301646.8397A6A11@keescook>
From:   Dan Raymond <draymond@foxvalley.net>
In-Reply-To: <202308301646.8397A6A11@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/2023 5:48 PM, Kees Cook wrote:
> Warning: This email is from an unusual correspondent.
> Warning: Make sure this is someone you trust.
> 
> On Wed, Aug 30, 2023 at 05:17:12PM -0600, Dan Raymond wrote:
>> In my opinion strlcpy() is being used correctly here as a defensive
>> precaution.  If the source string is larger than the destination buffer
>> it will truncate rather than corrupt kernel memory.  However the
>> return value of strlcpy() is being misused.  If truncation occurred
>> the copy_to_user() call will corrupt user memory instead.
>>
>> I also agree that this is not currently a bug.  It is fragile and it
>> could break if someone added a very large string to the table.
>>
>> Why not fix this by avoiding the redundant string copy?  How about
>> something like this:
>>
>> ptr = func_table[kb_func] ? : "";
>> len = strlen(ptr);
>>
>> if (len >= sizeof(user_kdgkb->kb_string))
>> 	return -ENOSPC;
>>
>> if (copy_to_user(user_kdgkb->kb_string, ptr, len + 1))
>> 	return -EFAULT;
> 
> This would work if not for func_buf_lock. The bounce buffer is used to
> avoid needing to hold the spin lock across copy_to_user.
> 

Ah you're right.  Thanks for setting me straight.  Now I realize that my
entire assessment was wrong.  The original author was not using strlcpy()
as a defensive measure to prevent a buffer overflow.  He was using it so
that he could create a copy of the string and measure its length using
only one pass.  This minimizes the time spent holding the spinlock.

The surrounding code was written such that a buffer overflow is
impossible.  No additional checks are needed.  The proposed patch is
unnecessary.  But at least it preserves the spirit of the original
author's code by performing only one pass of the source string
while holding the spinlock.
