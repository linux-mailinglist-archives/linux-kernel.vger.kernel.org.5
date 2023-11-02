Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F403D7DED16
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 08:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjKBHKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 03:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjKBHKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 03:10:43 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CEC112
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 00:10:40 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VvV7iIh_1698909035;
Received: from 30.97.48.61(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VvV7iIh_1698909035)
          by smtp.aliyun-inc.com;
          Thu, 02 Nov 2023 15:10:37 +0800
Message-ID: <4978d86c-c55f-cf26-796d-237c81efeab3@linux.alibaba.com>
Date:   Thu, 2 Nov 2023 15:10:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] mm: huge_memory: batch tlb flush when splitting a
 pte-mapped THP
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, shy828301@gmail.com,
        ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <431d9fb6823036369dcb1d3b2f63732f01df21a7.1698488264.git.baolin.wang@linux.alibaba.com>
 <877cn22e0d.fsf@nvdebian.thelocal>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <877cn22e0d.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.7 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/1/2023 2:13 PM, Alistair Popple wrote:
> 
> Baolin Wang <baolin.wang@linux.alibaba.com> writes:
> 
>> I can observe an obvious tlb flush hotpot when splitting a pte-mapped THP on
> 
>   A tlb flush hotpot does sound delicious, but I think you meant hotspot :-)

Ah, yes. Hope Andrew can help to fix it :)

>> my ARM64 server, and the distribution of this hotspot is as follows:
>>
>>     - 16.85% split_huge_page_to_list
>>        + 7.80% down_write
>>        - 7.49% try_to_migrate
>>           - 7.48% rmap_walk_anon
>>                7.23% ptep_clear_flush
>>        + 1.52% __split_huge_page
>>
>> The reason is that the split_huge_page_to_list() will build migration entries
>> for each subpage of a pte-mapped Anon THP by try_to_migrate(), or unmap for
>> file THP, and it will clear and tlb flush for each subpage's pte. Moreover,
>> the split_huge_page_to_list() will set TTU_SPLIT_HUGE_PMD flag to ensure
>> the THP is already a pte-mapped THP before splitting it to some normal pages.
> 
> The only other user of TTU_SPLIT_HUGE_PMD is vmscan which also sets
> TTU_BATCH_FLUSH so we could make the former imply the latter but that
> seem dangerous given the requirement to call try_to_unmap_flush() so
> best not to.
> 
> Reviewed-by: Alistair Popple <apopple@nvidia.com>

Thanks for reviewing, and also thanks to Ying and Yang.
