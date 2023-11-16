Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3207B7EDAB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 05:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKPEca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 23:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjKPEc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 23:32:29 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5476D193
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 20:32:26 -0800 (PST)
Received: from [172.20.3.153] ([12.191.197.195])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 3AG4VTsl3874940
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 15 Nov 2023 20:31:31 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3AG4VTsl3874940
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023111101; t=1700109095;
        bh=s/zc25Nr5QbueNJaf+sZQ9pbEgcMzpQLK03GqPB48eY=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=Z0uD5qx8lamvhd/sckdPSTVRsFUBAmvUyeXdiMXPI1zWKR4kTndBfAXaXXdwgvdOl
         OVpdbCqMdw0FaaFewKAt01UYpNQi7d0XxIZSh/khCjWVmB3ZcX8M756n3+w//zKHvO
         x9B3rMVwkG0NctcIzOo1XIutAWcj8vs099Sw3mcnD8C4KNI8j3Fau6kaCQ9CoAWX2w
         iNpqlc5g2lJty8MK5a6FhqGGIDfHF2W0LGbc92UbiujDF8l4R7JLLx6bwK+o4V9P8v
         OXeH8+jncH4lHWzwrDR8xWpSyKyrcwMGL5mpdaBv/e0UFO0z7LPw6mR09+gE3reVWT
         2hlQP7TWCGRBg==
Message-ID: <76da1bcd-0d00-4701-8f6f-cc28b5184bce@zytor.com>
Date:   Wed, 15 Nov 2023 20:31:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: Fix 32-bit compatible userspace write size overflow
 error
To:     Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
References: <20231115105626.953273-1-ruanjinjie@huawei.com>
Content-Language: en-US
From:   "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20231115105626.953273-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not clear to me that this is actually the correct behavior; the 
important thing is that it faults (as nothing is mapped above 4 GB anyway.)

	-hpa


On 11/15/23 02:56, Jinjie Ruan wrote:
> For 32-bit compatible userspace program, write with size = -1 return not
> -1 but unexpected other values, which is due to the __access_ok() check is
> insufficient. The specified "ptr + size" is greater than 32-bit limit and
> should return -EFAULT, but it is not checked and can not catch the overflow
> error.
> 
> Fix above error by checking 32-bit limit if it is 32-bit compatible
> userspace program.

	-hpa
