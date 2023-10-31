Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC66E7DC688
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbjJaG1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJaG1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:27:09 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FC4C0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:27:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VvGHJmL_1698733618;
Received: from 30.221.133.171(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VvGHJmL_1698733618)
          by smtp.aliyun-inc.com;
          Tue, 31 Oct 2023 14:27:00 +0800
Message-ID: <59d16fd0-4a9f-b293-18f8-58ed3250ea6c@linux.alibaba.com>
Date:   Tue, 31 Oct 2023 14:26:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH] erofs: fix erofs_insert_workgroup() lockref usage
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <20231031060524.1103921-1-hsiangkao@linux.alibaba.com>
 <CAHk-=wiDZXndsFtCCebQGCxg+y24WtOEMF0P24W4zPMA6VPiyQ@mail.gmail.com>
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAHk-=wiDZXndsFtCCebQGCxg+y24WtOEMF0P24W4zPMA6VPiyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.3 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/10/31 14:20, Linus Torvalds wrote:
> On Mon, 30 Oct 2023 at 20:08, Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> As Linus pointed out [1], lockref_put_return() is fundamentally
>> designed to be something that can fail.  It behaves as a fastpath-only
>> thing, and the failure case needs to be handled anyway.
>>
>> Actually, since the new pcluster was just allocated without being
>> populated, it won't be accessed by others until it is inserted into
>> XArray, so lockref helpers are actually unneeded here.
>>
>> Let's just set the proper reference count on initializing.
> 
>  From a quick superficial look this looks like the right approach.
> Thanks for the quick response.

Thanks, I will trigger a stress test for this and it will be included
in this pull request...

Thanks,
Gao Xiang

> 
>                Linus
