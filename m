Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C4880B220
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 06:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjLIEvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 23:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIEva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 23:51:30 -0500
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA4510DA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 20:51:35 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047203;MF=tiwei.btw@antgroup.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---.VgCM59c_1702097490;
Received: from 30.39.230.13(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.VgCM59c_1702097490)
          by smtp.aliyun-inc.com;
          Sat, 09 Dec 2023 12:51:31 +0800
Message-ID: <598033f7-f937-4d32-a4ec-b3e0d094c637@antgroup.com>
Date:   Sat, 09 Dec 2023 12:51:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -tip] sched/fair: gracefully handle EEVDF scheduling
 failures
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, wuyun.abel@bytedance.com,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20231208112100.18141-1-tiwei.btw@antgroup.com>
 <20231208143208.GF28727@noisy.programming.kicks-ass.net>
From:   "Tiwei Bie" <tiwei.btw@antgroup.com>
In-Reply-To: <20231208143208.GF28727@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/23 10:32 PM, Peter Zijlstra wrote:
> On Fri, Dec 08, 2023 at 07:20:59PM +0800, Tiwei Bie wrote:
>> The EEVDF scheduling might fail due to unforeseen issues. Previously,
> 
> I might also fly if I jump up. But is there any actual reason to believe
> something like that will happen?

Thanks for the quick reply! Sorry, after re-reading the commit log,
it looks confusing to me as well. I didn't mean something like that
will happen. I just thought it might be worthwhile to have a sanity
check on 'best'. Because, the 'best' is initialized to NULL and is
conditionally updated. The added 'WARN_ONCE' on '!best' is more like
a 'default' case to catch an unreachable case in a 'switch' block.
There was a similar check in the past that was helpful. And there
seems to be no harm in doing it. If this is reasonable, I'd like to
submit a v2 patch.

PS. I just noticed that the subject line should start with a uppercase
letter according to the rules in the tip tree handbook [1]. The subject
line should be something like: "sched/fair: Sanity check best in pick_eevdf()".

[1] https://www.kernel.org/doc/html/next/process/maintainer-tip.html#patch-subject

Regards,
Tiwei
