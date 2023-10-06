Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A6C7BB6EE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbjJFLsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjJFLso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:48:44 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA96CF;
        Fri,  6 Oct 2023 04:48:42 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3965k6oa010374;
        Fri, 6 Oct 2023 13:47:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=7hUXSm4cUGROzEvTuYhVzV1bsIonYgdPmxDalGuj81U=; b=qt
        PvJLLDWgY5DKSI1hBa48qvYC54KaUafXbotwH1wYfiazDiLH8cO5DTg0xMQJxcKB
        AP8zc2noF7+c8K3GxJXp72WWTpKVX+fzBjUSthCGEryaQzmGdLgCw6uMMa9z6b6V
        OQjyD6T1Pjb8/QoUyVdhyBZTYy+K6gOQ6EPkSB5JIMAIlsveHtepF5nsE8Z+ghTt
        ZZcOnS0W1qGZvk5mwLIUxz4ls/xIA4ipVRfeCS1p3W/0gFZ6lnaRnJdfoCQEWHxe
        dFviJrbPhy48sR5G6t9sSZW6H/Ubr4wzBHHpqkXFQIlAlWw8i7uU7032XU5wW1K6
        9G/CFE2XCTLzPWpJWVhQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tj09gbe3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Oct 2023 13:47:28 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 54DA8100053;
        Fri,  6 Oct 2023 13:47:27 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2071722A6EE;
        Fri,  6 Oct 2023 13:47:27 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:47:26 +0200
Message-ID: <ac2e9a54-e232-698f-7c60-ebf669a886f2@foss.st.com>
Date:   Fri, 6 Oct 2023 13:47:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net] net: stmmac: dwmac-stm32: fix resume on STM32 MCU
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        Jacob Keller <jacob.e.keller@intel.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Christophe Roullier <christophe.roullier@st.com>
References: <20230927175749.1419774-1-ben.wolsieffer@hefring.com>
 <681cc4ca-9fd7-9436-6c7d-d7da95026ce3@intel.com>
 <ZRrLmjxoIIx7pIcs@dell-precision-5540>
Content-Language: en-US
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <ZRrLmjxoIIx7pIcs@dell-precision-5540>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-06_09,2023-10-06_01,2023-05-22_02
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/23 15:54, Ben Wolsieffer wrote:
> Hi Jacob,
> 
> On Fri, Sep 29, 2023 at 10:48:47AM -0700, Jacob Keller wrote:
>>
>>
>> On 9/27/2023 10:57 AM, Ben Wolsieffer wrote:
>>> The STM32MP1 keeps clk_rx enabled during suspend, and therefore the
>>> driver does not enable the clock in stm32_dwmac_init() if the device was
>>> suspended. The problem is that this same code runs on STM32 MCUs, which
>>> do disable clk_rx during suspend, causing the clock to never be
>>> re-enabled on resume.
>>>
>>> This patch adds a variant flag to indicate that clk_rx remains enabled
>>> during suspend, and uses this to decide whether to enable the clock in
>>> stm32_dwmac_init() if the device was suspended.
>>>
>>
>> Why not just keep clk_rx enabled unconditionally or unconditionally stop
>> it during suspend? I guess that might be part of a larger cleanup and
>> has more side effects?
> 
> Ideally, you want to turn off as many clocks as possible in suspend to
> save power. I'm assuming there is some hardware reason the STM32MP1
> needs the RX clock on during suspend, but it was not explained in the
> original patch. Without more information, I'm trying to maintain the
> existing behavior.
> 

Sorry for this late answer. We could need RX clock for WOL support.

>>
>>> This approach fixes this specific bug with limited opportunity for
>>> unintended side-effects, but I have a follow up patch that will refactor
>>> the clock configuration and hopefully make it less error prone.
>>>
>>
>> I'd guess the follow-up refactor would target next?
>>
>>> Fixes: 6528e02cc9ff ("net: ethernet: stmmac: add adaptation for stm32mp157c.")
>>> Signed-off-by: Ben Wolsieffer <ben.wolsieffer@hefring.com>
>>> ---
>>
>> This seems pretty small and targeted so it does make sense to me as a
>> net fix, but it definitely feels like a workaround.
>>
>> I look forward to reading the cleanup patch mentioned.
> 
> Sorry, I should have linked this when I re-posted this patch for
> net, but I previously submitted this patch as part of a series with
> the cleanup but was asked to split them up for net and net-next.
> Personally, I would be fine with them going into net-next together (or
> squashed).
> 
> The original series can be found here:
> https://lore.kernel.org/linux-arm-kernel/20230919164535.128125-3-ben.wolsieffer@hefring.com/T/
> 
> Thanks, Ben

