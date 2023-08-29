Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5008D78BC21
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 02:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbjH2Aaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 20:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbjH2Aan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 20:30:43 -0400
Received: from out-248.mta1.migadu.com (out-248.mta1.migadu.com [IPv6:2001:41d0:203:375::f8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02BD10B
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 17:30:40 -0700 (PDT)
Message-ID: <25be098a-dc41-7907-5590-1835308ebe28@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693269037; h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9IAzTTcmlJQyO6mSLflkzt3IVsbQUOThQfzVBiQYjgE=;
        b=DPm51MEZctaWaOJT9m6vaXzveCc8r6glQAgwpw6xebEcB1WEmJ9bY0NNlj6jtP3x0A1av0
        OY9WOggNlkslYwD2PCp/KWnBVRhsN2Kr5xPSrsQXEDKIm4Vz5vK6NwXV51YmDuaDFr7zcK
        7JFWShgPHfEPCgADkJJG0pQ6hBPEhcI=
Date:   Mon, 28 Aug 2023 20:30:29 -0400
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Content-Language: en-US
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yonghong Song <yhs@fb.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com> <20230825170406.GA16800@redhat.com>
 <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
 <20230827201909.GC28645@redhat.com>
 <ac60ff18-22b0-0291-256c-0e0c3abb7b62@linux.dev>
 <20230828105453.GB19186@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230828105453.GB19186@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 3:54 AM, Oleg Nesterov wrote:
> On 08/27, Yonghong Song wrote:
>>
>> On 8/27/23 1:19 PM, Oleg Nesterov wrote:
>>>
>>> But. if the group leader M exits then M->files == NULL. And in this case
>>> task_seq_get_next() will need to "inspect" all the sub-threads even if they all
>>> have the same ->files pointer.
>>
>> That is correct. I do not have practical experience on how much
>> possibility this scenario may happen. I assume it should be very low.
> 
> Yes. I just tried to explain why the ->files check looks confusing to me.
> Nevermind.
> 
> Could you review 6/6 as well?

I think we can wait patch 6/6 after
    https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
is merged.

> 
> Should I fold 1-5 into a single patch? I tried to document every change
> and simplify the review, but I do not want to blow the git history.

Currently, because patch 6, the whole patch set cannot be tested by
bpf CI since it has a build failure:
   https://github.com/kernel-patches/bpf/pull/5580
I suggest you get patch 1-5 and resubmit with tag like
   "bpf-next v2"
   [Patch bpf-next v2 x/5] ...
so CI can build with different architectures and compilers to
ensure everything builds and runs fine.

> 
> Oleg.
> 
