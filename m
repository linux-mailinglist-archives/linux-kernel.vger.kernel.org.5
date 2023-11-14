Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F27F7EACE1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 10:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjKNJSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 04:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjKNJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 04:18:04 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 786AEF5;
        Tue, 14 Nov 2023 01:18:00 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id D4CB26071E21E;
        Tue, 14 Nov 2023 17:17:50 +0800 (CST)
Message-ID: <9c90dd30-448c-6d1c-76e4-85b36eb739f9@nfschina.com>
Date:   Tue, 14 Nov 2023 17:17:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] wifi: rtl8xxxu: correct the error value of 'timeout'
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <e8b847437ab242d18108d9364360bb8a@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/14 14:42, Ping-Ke Shih wrote:
>> -----Original Message-----
>> From: Su Hui <suhui@nfschina.com>
>> Sent: Monday, November 13, 2023 1:49 PM
>> To: Jes.Sorensen@gmail.com; kvalo@kernel.org
>> Cc: Su Hui <suhui@nfschina.com>; linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>> kernel-janitors@vger.kernel.org
>> Subject: [PATCH] wifi: rtl8xxxu: correct the error value of 'timeout'
>>
>> When 'rtl8xxxu_dma_agg_pages <= page_thresh', 'timeout' should equal to
>> 'page_thresh' rather than '4'. Change the code order to fix this problem.
>>
>> Fixes: 614e389f36a9 ("rtl8xxxu: gen1: Set aggregation timeout (REG_RXDMA_AGG_PG_TH + 1) as well")
> I think this should fix
> Fixes: fd83f1227826 ("rtl8xxxu: gen1: Add module parameters to adjust DMA aggregation parameters")
Agreed. Thanks for your reminder!
>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c    | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 43ee7592bc6e..9cab8b1dc486 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4757,6 +4757,12 @@ void rtl8xxxu_gen1_init_aggregation(struct rtl8xxxu_priv *priv)
>>           *   RxAggPageTimeout = 4 or 6 (absolute time 34ms/(2^6))
>>           */
>>
>> +       /* REG_RXDMA_AGG_PG_TH + 1 seems to be the timeout register on
>> +        * gen2 chips and rtl8188eu. The rtl8723au seems unhappy if we
>> +        * don't set it, so better set both.
>> +        */
>> +       timeout = 4;
>> +
>>          page_thresh = (priv->fops->rx_agg_buf_size / 512);
>>          if (rtl8xxxu_dma_agg_pages >= 0) {
>>                  if (rtl8xxxu_dma_agg_pages <= page_thresh)
> The logic here is:
>
> 	page_thresh = (priv->fops->rx_agg_buf_size / 512);
> 	if (rtl8xxxu_dma_agg_pages >= 0) {
> 		if (rtl8xxxu_dma_agg_pages <= page_thresh)
> 			timeout = page_thresh;
>
> Do you know why 'timeout = page_thresh;'? Intuitively, units of 'timeout' and
> 'thresh' are different. Maybe, we should correct here instead?
I don't know the reason about this. :(
I found this error because clang static checker complains about this 
code that value stored to 'timeout'
is never read.

Su Hui

