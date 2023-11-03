Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92297E01CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbjKCKb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346471AbjKCKbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:31:52 -0400
X-Greylist: delayed 358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 03 Nov 2023 03:31:45 PDT
Received: from smtp106.ord1d.emailsrvr.com (smtp106.ord1d.emailsrvr.com [184.106.54.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E1A18B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20221208-6x11dpa4; t=1699007147;
        bh=kNQ6Y9aJJpuP/XuTipt3CdSuES1rKcilf6zf4PyPWLw=;
        h=Date:Subject:To:From:From;
        b=t2ca9DYixF48bFpQZ4M3ABJWuhvOTwd+WMLlGhGa4fACFJqU4MDxMk2UOGoLj0Nyj
         cBDVUn/ZAfuk2+EPVHHjcI5LLwxjDXTCkWip7eVnrihVl+G9uoL7zQsWJNH5R6FRLI
         X6gxdVe2/1908cILqLKGoYF9uYcDLHzEBAepk0oY=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 3B5EBE00DD;
        Fri,  3 Nov 2023 06:25:46 -0400 (EDT)
Message-ID: <51e495a4-98d7-402c-a1e6-5c24c43e3118@mev.co.uk>
Date:   Fri, 3 Nov 2023 10:25:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/comedi: copy userspace array safely
Content-Language: en-GB
To:     Philipp Stanner <pstanner@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>
References: <20231102190848.51376-2-pstanner@redhat.com>
 <2023110348-drained-tameness-b943@gregkh>
 <07a220351baa1e6851b90c961aade0ce6d26bcf6.camel@redhat.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <07a220351baa1e6851b90c961aade0ce6d26bcf6.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Classification-ID: 0e0161b1-9789-4e79-b36b-01e1a0233ef7-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-03 09:11, Philipp Stanner wrote:
> On Fri, 2023-11-03 at 06:53 +0100, Greg Kroah-Hartman wrote:
>> On Thu, Nov 02, 2023 at 08:08:49PM +0100, Philipp Stanner wrote:
>>> comedi_fops.c utilizes memdup_user() to copy a userspace array. This
>>> does not check for an overflow.
>>
>> Is there potential for an overflow today?
> 
> None that I'm aware of, no. This is more about establishing the new
> function as the standard for array-copying, thereby improving
> readability and maybe robustness in case of future changes.

I agree there is no potential for overflow.  The chanlist_len in the 
command is bound checked against the len_chanlist in the comedi 
subdevice in __comedi_get_user_cmd(), and the len_chanlist value is set 
by driver code with no user input.  So it should be fine barring some 
rogue comedi driver.

>>> Use the new wrapper memdup_array_user() to copy the array more safely.
>>
>> How about saying something like:
>>          "Use the new function memdup_array_user() in case things change
>>          in the future which would prevent overflows if something were to
>>          change in the size of the structures".
>>
>> Or something to the affect of "all is good today, but make it easy to be
>> correct in the future as well".
> 
> Yes, good idea. I'll send a better wording

Feel free to add my reviewed by line:

Reviewed-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
