Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62107FDAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234311AbjK2PCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjK2PB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:01:59 -0500
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B836A3;
        Wed, 29 Nov 2023 07:02:04 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VxOW.jE_1701270121;
Received: from 30.39.190.97(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0VxOW.jE_1701270121)
          by smtp.aliyun-inc.com;
          Wed, 29 Nov 2023 23:02:02 +0800
Message-ID: <d8262b12-3ac9-8608-fc6f-d48c33a4225e@linux.alibaba.com>
Date:   Wed, 29 Nov 2023 23:02:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/netfilter: bpf: avoid leakage of skb
Content-Language: en-US
To:     Florian Westphal <fw@strlen.de>
Cc:     pablo@netfilter.org, kadlec@netfilter.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        coreteam@netfilter.org, netfilter-devel@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, ast@kernel.org
References: <1701252962-63418-1-git-send-email-alibuda@linux.alibaba.com>
 <20231129131846.GC27744@breakpoint.cc>
 <aa83bf32-789f-fec2-ea42-74b0ae05426e@linux.alibaba.com>
 <20231129144736.GB24754@breakpoint.cc>
From:   "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <20231129144736.GB24754@breakpoint.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/29/23 10:47 PM, Florian Westphal wrote:
> D. Wythe <alibuda@linux.alibaba.com> wrote:
>> And my origin intention was to allow ebpf progs to return NF_STOLEN, we are
>> trying to modify some netfilter modules via ebpf,
>> and some scenarios require the use of NF_STOLEN, but from your description,
> NF_STOLEN can only be supported via a trusted helper, as least as far as
> I understand.
>
> Otherwise verifier would have to guarantee that any branch that returns
> NF_STOLEN has released the skb, or passed it to a function that will
> release the skb in the near future.

Thank you very much for your help. I now understand the difficulty here.
The verifier cannot determine whether the consume_skb() was executed or not,
when the return value  goes to NF_STOLEN.

We may use NF_DROP at first, it won't be make much difference for us now.

Also, do you have any plans to support this helper?

Best wishes,
D. Wythe
