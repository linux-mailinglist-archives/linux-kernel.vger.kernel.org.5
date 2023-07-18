Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6508D757428
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGRG25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjGRG2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:28:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CB55100;
        Mon, 17 Jul 2023 23:28:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB5D4D75;
        Mon, 17 Jul 2023 23:29:19 -0700 (PDT)
Received: from [10.163.50.249] (unknown [10.163.50.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E0393F6C4;
        Mon, 17 Jul 2023 23:28:20 -0700 (PDT)
Message-ID: <5f7841ad-6bb5-dffd-b1ac-e6d198933075@arm.com>
Date:   Tue, 18 Jul 2023 11:58:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64/ptrace: Fix an error handling path in
 sve_set_common()
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <aa61301ed2dfd079b74b37f7fede5f179ac3087a.1689616473.git.christophe.jaillet@wanadoo.fr>
 <3f78a04c-bafe-4def-8eeb-734589fdaaa0@sirena.org.uk>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <3f78a04c-bafe-4def-8eeb-734589fdaaa0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/23 23:38, Mark Brown wrote:
> On Mon, Jul 17, 2023 at 07:55:05PM +0200, Christophe JAILLET wrote:
>> All error handling paths go to 'out', except this one. Be consistent and
>> also branch to 'out' here.
> 
> This looks like a reasonable cleanup.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> 
>> Fixes: e12310a0d30f ("arm64/sme: Implement ptrace support for streaming mode SVE registers")
> 
>>  		default:
>>  			WARN_ON_ONCE(1);
>> -			return -EINVAL;
>> +			ret = -EINVAL;
>> +			goto out;
>>  		}
> 
> It's not exactly a fix though (probably not worth backporting for

+1

> example, which tends to get keyed off the fixes tag) since something's
> incredibly confused if this code path ever gets executed, we're setting
> an unknown SVE vector type hence the WARN_ON() there.

Agreed.
