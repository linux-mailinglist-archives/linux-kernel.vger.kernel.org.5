Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310077B2305
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 18:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbjI1Qz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 12:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbjI1Qzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:55:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F6F71A3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 09:55:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 829881FB;
        Thu, 28 Sep 2023 09:56:30 -0700 (PDT)
Received: from [10.1.32.180] (e126864.cambridge.arm.com [10.1.32.180])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 90DAA3F5A1;
        Thu, 28 Sep 2023 09:55:49 -0700 (PDT)
Message-ID: <6687f58c-0da9-0583-2dc1-2089f292b745@arm.com>
Date:   Thu, 28 Sep 2023 17:55:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/2] KVM: arm64: Support for Arm v8.8 memcpy
 instructions in KVM guests
Content-Language: en-US
To:     Oliver Upton <oliver.upton@linux.dev>
Cc:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org
References: <20230922112508.1774352-1-kristina.martsenko@arm.com>
 <ZRPE9OcB9ndgFxbs@linux.dev>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <ZRPE9OcB9ndgFxbs@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2023 07:00, Oliver Upton wrote:
> Hi Kristina,

Hi Oliver,

> 
> On Fri, Sep 22, 2023 at 12:25:06PM +0100, Kristina Martsenko wrote:
>> Hi,
>>
>> This is v2 of the series to allow using the new Arm memory copy instructions
>> in KVM guests. See v1 for more information [1].
> 
> 
> Thanks for sending out the series. I've been thinking about what the
> architecture says for MOPS, and I wonder if what's currently in the
> Arm ARM is clear enough for EL1 software to be written robustly.
> 
> While HCRX_EL2.MCE2 allows the hypervisor to intervene on MOPS
> exceptions from EL1, there's no such control for EL0. So when vCPU
> migration occurs EL1 could get an unexpected MOPS exception, even for a
> process that was pinned to a single (virtual) CPU implementation.
> 
> Additionally, the wording of I_NXHPS seems to suggest that EL2 handling
> of MOPS exceptions is only expected in certain circumstances where EL1 is
> incapable of handling an exception. Is the unwritten expectation then
> that EL1 software should tolerate 'unexpected' MOPS exceptions from EL1
> and EL0, even if EL1 did not migrate the PE context?
> 
> Perhaps I'm being pedantic, but I'd really like for there to be some
> documentation that suggests MOPS exceptions can happen due to context
> migration done by a higher EL as that is the only option in the context
> of virtualization.

That's a good point. This shouldn't affect Linux guests as Linux is
always able to handle a MOPS exception coming from EL0. But it would
affect any non-Linux guest that pins all its EL0 tasks and doesn't
implement a handler. It's not clear to me what the expectation for
guests is, I'll ask the architects to clarify and get back to you.

Thanks for the feedback!

Kristina
