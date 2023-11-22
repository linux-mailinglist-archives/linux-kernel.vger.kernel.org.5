Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 815977F4DEC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjKVRL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjKVRLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:11:54 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CD1319D;
        Wed, 22 Nov 2023 09:11:50 -0800 (PST)
Received: from [192.168.2.39] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 5E58D20B74C0;
        Wed, 22 Nov 2023 09:11:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5E58D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1700673109;
        bh=82lcUJlL98A5MVMgBDFSuG4FKjH249seXl3nkPglk2w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=P4bMW36WSyjVhutiRQovnLEVVmELocIpw4v3akjDZQutjjOqxIHjo6FjIQkThDAIc
         0wy+XjLgCEyw7ABf38OwAmbZuWWC33ceD1kGMnHU3oJb/Jhn9+QVdAf+P0heVPBm8z
         a/Wf1f4tIQ2WQ4/zxddgATZhCjp/h9AWJWEJdtic=
Message-ID: <9a39a9b4-b58d-4b7c-83f7-460372070f81@linux.microsoft.com>
Date:   Wed, 22 Nov 2023 18:11:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Content-Language: en-US
To:     kirill.shutemov@linux.intel.com
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
 <6feecf9e-10cb-441f-97a4-65c98e130f7a@linux.microsoft.com>
 <20231110124626.ifq3hqaiqvgpnign@box>
 <5a80bfd8-7092-4a85-93a6-189a16725642@linux.microsoft.com>
 <20231110185716.tyhfjim4cnxxboe4@box.shutemov.name>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231110185716.tyhfjim4cnxxboe4@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 19:57, kirill.shutemov@linux.intel.com wrote:
> On Fri, Nov 10, 2023 at 02:42:31PM +0100, Jeremi Piotrowski wrote:
>> On 10/11/2023 13:46, kirill.shutemov@linux.intel.com wrote:
>>> On Fri, Nov 10, 2023 at 01:27:08PM +0100, Jeremi Piotrowski wrote:
>>>>> Maybe just remove incorrect info and that's it?
>>>>>
>>>>
>>>> I disagree, other users and I find the print very useful to see which coco
>>>> platform the kernel is running on and which confidential computing features
>>>> the kernel detected. I'm willing to fix the code to report correct info.
>>>
>>> For TDX, we already have "tdx: Guest detected" in dmesg. sme_early_init()
>>> can do something similar.
>>>
>>
>> That doesn't cover TDX guests with TD partitioning on Hyper-V.
> 
> I am sure Hyper-V can report what mode it runs.
> 

You're right, it could. In that case I would move the AMD print and keep only
"Memory Encryption is active" here.

Lets see whether we find agreement on my new submission first.

Thanks,
Jeremi
