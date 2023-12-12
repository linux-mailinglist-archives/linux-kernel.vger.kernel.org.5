Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9D580E26D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345478AbjLLC4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:56:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLC4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:56:52 -0500
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BFF83;
        Mon, 11 Dec 2023 18:56:57 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VyKnpK._1702349814;
Received: from 30.97.48.77(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VyKnpK._1702349814)
          by smtp.aliyun-inc.com;
          Tue, 12 Dec 2023 10:56:55 +0800
Message-ID: <7541f17a-f0a7-486b-9664-3573623d7154@linux.alibaba.com>
Date:   Tue, 12 Dec 2023 10:57:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sprd: Fix eMMC init failure after hw reset
To:     Wenchao Chen <wenchao.chen666@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Wenchao Chen <wenchao.chen@unisoc.com>, zhang.lyra@gmail.com,
        orsonzhai@gmail.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhenxiong.lai@unisoc.com,
        yuelin.tang@unisoc.com
References: <20231204064934.21236-1-wenchao.chen@unisoc.com>
 <CAPDyKFpK2Yjj2oDWCUKHpht6PC9uNG-x2rPYO3EBD6GGWg4VZg@mail.gmail.com>
 <CA+Da2qyB2tQjq5wxoqNwjb5HXhdPHMsWN08Ot7nMEkZzOgQ9LA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CA+Da2qyB2tQjq5wxoqNwjb5HXhdPHMsWN08Ot7nMEkZzOgQ9LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/8/2023 7:52 PM, Wenchao Chen wrote:
> On Thu, 7 Dec 2023 at 21:59, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On Mon, 4 Dec 2023 at 07:50, Wenchao Chen <wenchao.chen@unisoc.com> wrote:
>>>
>>> Some eMMC devices that do not close the auto clk gate
>>> after hw reset will cause eMMC initialization to fail.
>>>
>>> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
>>
>> I assume we want this tagged for stable kernels too, but do we have a
>> corresponding fixes commit that we can point out?
>>
>> Kind regards
>> Uffe
>>
> 
> Hi Uffe
> Sorry, I forgot to add fixes commit.
> 
> Fixes: ff874dbc4f86 ("mmc: sdhci-sprd: Disable CLK_AUTO when the clock
> is less than 400K")

With the Fixes tag, looks goo to me.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>>> ---
>>>   drivers/mmc/host/sdhci-sprd.c | 10 +++++++---
>>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
>>> index 6b8a57e2d20f..bed57a1c64b5 100644
>>> --- a/drivers/mmc/host/sdhci-sprd.c
>>> +++ b/drivers/mmc/host/sdhci-sprd.c
>>> @@ -239,15 +239,19 @@ static inline void _sdhci_sprd_set_clock(struct sdhci_host *host,
>>>          div = ((div & 0x300) >> 2) | ((div & 0xFF) << 8);
>>>          sdhci_enable_clk(host, div);
>>>
>>> +       val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
>>> +       mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN | SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
>>>          /* Enable CLK_AUTO when the clock is greater than 400K. */
>>>          if (clk > 400000) {
>>> -               val = sdhci_readl(host, SDHCI_SPRD_REG_32_BUSY_POSI);
>>> -               mask = SDHCI_SPRD_BIT_OUTR_CLK_AUTO_EN |
>>> -                       SDHCI_SPRD_BIT_INNR_CLK_AUTO_EN;
>>>                  if (mask != (val & mask)) {
>>>                          val |= mask;
>>>                          sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
>>>                  }
>>> +       } else {
>>> +               if (val & mask) {
>>> +                       val &= ~mask;
>>> +                       sdhci_writel(host, val, SDHCI_SPRD_REG_32_BUSY_POSI);
>>> +               }
>>>          }
>>>   }
>>>
>>> --
>>> 2.17.1
>>>
