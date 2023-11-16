Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D1F7EE024
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjKPLwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 06:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPLwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 06:52:30 -0500
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83012182
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 03:52:26 -0800 (PST)
Message-ID: <41039b2a-6122-4392-96e2-4a833f41496d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700135543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ZggfuDdZcTsvVVdCo0UNHxFw+MGuU1EhAQ583oVLKw=;
        b=Mf57//HVeZx+M0RD2orju+Np3OdAXmRqxlMOLPhOkaEIkGSW9KdbDD14G/UwKfli82VHL3
        bdkC7phTzYlLjD3TLvjiJCHPXHrU+ksdfomvXG+7RNzmTY+xKIdK56TgCOHi0gk991Sp2n
        FDZLiiv//A4HcThs5/UJRci0sQSohXc=
Date:   Thu, 16 Nov 2023 06:52:16 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] bpf: kernel/bpf/task_iter.c: don't abuse
 next_thread()
Content-Language: en-GB
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kui-Feng Lee <kuifeng@fb.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
References: <20231114163211.GA874@redhat.com>
 <c768aae4-1c41-41ef-895d-33556b99dc15@linux.dev>
 <20231116095439.GC18748@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231116095439.GC18748@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/16/23 4:54 AM, Oleg Nesterov wrote:
> On 11/15, Yonghong Song wrote:
>> On 11/14/23 11:32 AM, Oleg Nesterov wrote:
>>> Compile tested.
>>>
>>> Every lockless usage of next_thread() was wrong, bpf/task_iter.c is
>>> the last user and is no exception.
>> It would be great if you can give more information in the commit message
>> about why the usage of next_thread() is wrong in bpf/task_iter.c.
> I tried to explain the problems in the changelogs:
>
> 1/3:
> 	task_group_seq_get_next() can return the group leader twice if it races
> 	with mt-thread exec which changes the group->leader's pid.
>
> 2/3:
> 	bpf_iter_task_next() can loop forever, "kit->pos == kit->task" can never
> 	happen if kit->pos execs.
>
>> IIUC, some information is presented in :
>>    https://lore.kernel.org/all/20230824143112.GA31208@redhat.com/
> Yes, Linus and Eric suggest to simply kill next_thread(). I am not
> sure, this needs another discussion.
>
> But as for bpf/task_iter.c... Even _if_ the usage was correct, this
> code simply doesn't need the "circular" next_thread(), NULL at the
> end simplifies the code.
>
>> Also, please add 'bpf' in the subject tag ([PATCH bpf 0/3]) to
>> make it clear the patch should be applied to bpf tree.
> OK, will do next time. Or should I resend this series with 'bpf'
> in the subject tag?

There is no need then. We can wait for maintainers who may or
may not have additional requests.


>
> Thanks,
>
> Oleg.
>
