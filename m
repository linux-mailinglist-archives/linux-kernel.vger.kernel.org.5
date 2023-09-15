Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB097A1BBD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjIOKGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbjIOKGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:06:23 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 632ED30E6;
        Fri, 15 Sep 2023 03:05:33 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 959CE60AB00DC;
        Fri, 15 Sep 2023 18:05:30 +0800 (CST)
Message-ID: <5bb164e7-c147-64d1-031d-0ba20cfffa77@nfschina.com>
Date:   Fri, 15 Sep 2023 18:05:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH wireless-next 7/9] wifi: ath12k: Remove unnecessary
 (void*) conversions
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>, kvalo@kernel.org
Cc:     ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: yunchuan@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   yunchuan <yunchuan@nfschina.com>
In-Reply-To: <7427d5aa-902a-4013-8aa9-f986bb5218a4@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/9/15 01:06, Jeff Johnson wrote:
> On 9/13/2023 9:05 PM, Wu Yunchuan wrote:
>> No need cast (void*) to (struct hal_rx_ppdu_end_user_stats *),
>> (struct ath12k_rx_desc_info *) or (struct hal_tx_msdu_ext_desc *).
>>
>> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>
>> ---
>>   drivers/net/wireless/ath/ath12k/dp_mon.c | 6 ++----
>>   drivers/net/wireless/ath/ath12k/dp_rx.c  | 2 +-
>>   drivers/net/wireless/ath/ath12k/dp_tx.c  | 2 +-
>>   3 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath12k/dp_mon.c 
>> b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> index f1e57e98bdc6..41cfe7bd865f 100644
>> --- a/drivers/net/wireless/ath/ath12k/dp_mon.c
>> +++ b/drivers/net/wireless/ath/ath12k/dp_mon.c
>> @@ -13,8 +13,7 @@
>>   static void ath12k_dp_mon_rx_handle_ofdma_info(void *rx_tlv,
>>                              struct hal_rx_user_status *rx_user_status)
>>   {
>> -    struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
>> -                (struct hal_rx_ppdu_end_user_stats *)rx_tlv;
>> +    struct hal_rx_ppdu_end_user_stats *ppdu_end_user = rx_tlv;
>>         rx_user_status->ul_ofdma_user_v0_word0 =
>>           __le32_to_cpu(ppdu_end_user->usr_resp_ref);
>> @@ -26,8 +25,7 @@ static void
>>   ath12k_dp_mon_rx_populate_byte_count(void *rx_tlv, void *ppduinfo,
>>                        struct hal_rx_user_status *rx_user_status)
>>   {
>> -    struct hal_rx_ppdu_end_user_stats *ppdu_end_user =
>> -        (struct hal_rx_ppdu_end_user_stats *)rx_tlv;
>> +    struct hal_rx_ppdu_end_user_stats *ppdu_end_user = rx_tlv;
>>       u32 mpdu_ok_byte_count = 
>> __le32_to_cpu(ppdu_end_user->mpdu_ok_cnt);
>>       u32 mpdu_err_byte_count = 
>> __le32_to_cpu(ppdu_end_user->mpdu_err_cnt);
>
> for both of the above IMO the better solution is to change the 
> prototype to replace void *rx_tlv with struct 
> hal_rx_ppdu_end_user_stats *ppdu_end_user and to remove the local 
> variable
>
> further, I think you can add const to that since the TLV is only read, 
> not written
>
> this better describes that the function requires a specific flavor of 
> RX TLV rather than handling any RX TLV
>
Hi,

Sounds like a good idea, I will check other patches for this situation.
Thanks for your suggestions.

Wu Yunchuan


