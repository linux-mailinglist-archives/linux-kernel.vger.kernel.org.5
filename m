Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8BD7D3909
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjJWOOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWOOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:14:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C87D6DF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:14:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96CEF1FB;
        Mon, 23 Oct 2023 07:14:58 -0700 (PDT)
Received: from [10.57.5.125] (unknown [10.57.5.125])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E2B23F64C;
        Mon, 23 Oct 2023 07:14:16 -0700 (PDT)
Message-ID: <37b9a97e-4142-4f6f-85c9-7d90abb8f334@arm.com>
Date:   Mon, 23 Oct 2023 15:14:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] perf/arm-cmn: Rework DTC counters (again)
To:     Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
        renyu.zj@linux.alibaba.com
References: <cover.1697824215.git.robin.murphy@arm.com>
 <5f6ade76b47f033836d7a36c03555da896dfb4a3.1697824215.git.robin.murphy@arm.com>
 <8e179525-bba-c577-85cf-4aa0a7af436@os.amperecomputing.com>
 <ZTY3ieLQaRQ4dHYP@FVFF77S0Q05N>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZTY3ieLQaRQ4dHYP@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-23 10:06, Mark Rutland wrote:
> On Fri, Oct 20, 2023 at 03:50:30PM -0700, Ilkka Koskinen wrote:
>> Hi Robin,
>>
>> I have one comment, otherwise the patch looks good to me.
> 
>>> +/* @i is the DTC number, @idx is the counter index on that DTC */
>>> +#define for_each_hw_dtc_idx(hw, i, idx) \
>>> +	for (int i = 0, idx; i < CMN_MAX_DTCS; i++) if ((idx = hw->dtc_idx[i]) >= 0)
>>
>> Isn't that "idx" unnecessary in the initialization?
> 
> That creates the 'idx' variable that's assigned to by `idx = hw->dtc_idx[i]`,
> so that is necessary.

Right, the intent is to take advantage of locally-scoped iterator 
variables since they're a nice thing, but completely-implicit 
definitions aren't so nice (at best they'd be surprising, at worst they 
could confusingly shadow existing variables in the outer scope), so the 
macro invoker still provides their names to at least give some visible 
context to their use within the loop body.

I guess this is still a fairly new paradigm since the C11 switch, and 
I'm not aware of any "standard" style for such iterator macros yet, so I 
just did what seemed most logical.

Thanks,
Robin.
