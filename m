Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFB17B6C83
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 16:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbjJCO4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 10:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240658AbjJCO4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 10:56:21 -0400
Received: from out-192.mta0.migadu.com (out-192.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB86CCA
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 07:56:02 -0700 (PDT)
Message-ID: <93aa2ee6-3ee4-0129-7160-d3684ba67f56@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696344960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I7WcBrH/Di0VsPYhysDkPkrET7nqmGMH5mri0ZLFHJ8=;
        b=rsc0l7B6ZKcCYX6Q1nk32Mm/fkPjUNhx6SJGCNWmCBzlMdW3KUc1ZpDlSZv0JFbP5Zh1WW
        OPELUE9YbnZzpqXInOhF6QF2LtKn4Ts4UnJoFHoaQrlJd976ItdxJ9m6ES/ISet2mB2BwB
        +QLe1TasAOWgoAipn1fyTEmIkU6Eg08=
Date:   Tue, 3 Oct 2023 22:55:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4] sched/rt: move back to RT_GROUP_SCHED and rename it
 child
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org,
        kernel test robot <oliver.sang@intel.com>
References: <20230803050317.2240948-1-yajun.deng@linux.dev>
 <ZRvkM1lxsTrHb2Ox@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <ZRvkM1lxsTrHb2Ox@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/10/3 17:51, Ingo Molnar wrote:
> * Yajun Deng <yajun.deng@linux.dev> wrote:
>
>> The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
>> it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED
>> and rename it child.
>>
>> Init child when parent isn't NULL in init_tg_rt_entry().
>>
>> Introduce for_each_sched_rt_entity_reverse() to iterate rt_se from
>> top to down.
>>
>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> Closes: https://lore.kernel.org/oe-lkp/202308031034.4369b15b-oliver.sang@intel.com
> Yeah, so I agree with these changes, but could you please split up this
> patch into 3 separate patches:
>
>     sched/rt: Move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block
>     sched/rt: Rename sched_rt_entity::back to sched_rt_entity::child
>     sched/rt: Introduce for_each_sched_rt_entity_reverse() & use it

Okay, This patch makes sense, it saves a few bytes. But Peter seems to 
have a different opinion.

@Peter, I think I split up this patch into 2 separate patches:

          sched/rt: Introduce for_each_sched_rt_entity_back() & use it

         sched/rt: Move sched_rt_entity::back to under the 
CONFIG_RT_GROUP_SCHED block

Comments, please...

>
> Thanks,
>
> 	Ingo
