Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8E805C7A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346057AbjLER3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLER3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:29:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E053ACA;
        Tue,  5 Dec 2023 09:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=30oCHSjV0XJwpBvR0k7CZ9r6hmyCke0MwtbeOyHxYIM=; b=KNbRFJJwUKVKBvjeg9UI1heulT
        STPx/h/pj4mkBG4hUsQqS+/eAX2Jx1iihQ2aYw+ih7WOEwNGqlZy4MnVfIIP0spZmY7Fs4HCvz+57
        Qow9ui0tOI9skbgagNIA6S95EJNH3SIaClbhE+E08zw64/K6dKmPsfWXu7uvTc/KpJOV0oVdQytDM
        AbHImRJ+brjQV8E+ZacSkmDqLLt94iiCv1XO890Dsyit+5d7lodxEO6OaVTRz0useJ+Q8LdAMCVTa
        eTvvgYEVkO9e7kjUcVDRg8xVQ9n8kNQiH0o6T9H8v7hsVobuaaIPOmW5AOs9+6JSrUL5rDwryY+tM
        P6oES21Q==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rAZEI-0082LS-0W;
        Tue, 05 Dec 2023 17:29:06 +0000
Message-ID: <a173781e-b3b6-47a7-8bda-fb289fd9ffd5@infradead.org>
Date:   Tue, 5 Dec 2023 09:29:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Dec 5 (soc/qcom/qcom_stats)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
References: <20231205135708.4a5a8413@canb.auug.org.au>
 <50d8f1dd-4df2-446a-bd82-47d96637b507@infradead.org>
In-Reply-To: <50d8f1dd-4df2-446a-bd82-47d96637b507@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/23 09:17, Randy Dunlap wrote:
> 
> 
> On 12/4/23 18:57, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20231204:
>>
> 
> on powerpc 32-bit:
> 
> ERROR: modpost: "__udivdi3" [drivers/soc/qcom/qcom_stats.ko] undefined!
> 
> 

Hi,

Looks like this is coming from the use of mult_frac() if I am reading the
generated .s file correctly:

 # ../drivers/soc/qcom/qcom_stats.c:224: 		entry[i].dur = mult_frac(MSEC_PER_SEC, entry[i].dur, ARCH_TIMER_FREQ);
	mulhwu 3,22,4	 # tmp194, tmp190, MEM[(long long unsigned int *)_107 + 16B]
	mulli 9,9,1000	 # tmp185, MEM[(long long unsigned int *)_107 + 16B],
	mulli 4,4,1000	 # tmp3, MEM[(long long unsigned int *)_107 + 16B],
	add 3,9,3	 #, tmp185, tmp194
	bl __udivdi3		 #

-- 
~Randy
