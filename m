Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8707F9717
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 02:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjK0BOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 20:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0BOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 20:14:22 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id CCC2710F;
        Sun, 26 Nov 2023 17:14:27 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 8DFB16018B8D8;
        Mon, 27 Nov 2023 09:13:41 +0800 (CST)
Message-ID: <1bec6c93-aac4-eb95-f4f6-7b8fac65d967@nfschina.com>
Date:   Mon, 27 Nov 2023 09:13:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined
 bitwise shift behavior
Content-Language: en-US
To:     Ping-Ke Shih <pkshih@realtek.com>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
        "trix@redhat.com" <trix@redhat.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linville@tuxdriver.com" <linville@tuxdriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lizetao1@huawei.com" <lizetao1@huawei.com>
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <02f0a505b3a02a3c5e29ac1e327acd1fc946188c.camel@realtek.com>
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

On 2023/11/24 19:19, Ping-Ke Shih wrote:
> On Fri, 2023-11-24 at 18:06 +0800, Su Hui wrote:
>> On 2023/11/24 16:51, Ping-Ke Shih wrote:
>>> Subject: [PATCH v2 2/2] wifi: rtlwifi: rtl8821ae: phy: fix an undefined bitwise shift behavior
>>>
>>> [...]
>>>> diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>>>> b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>>>> index 6df270e29e66..52ab1b0761c0 100644
>>>> --- a/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>>>> +++ b/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/phy.c
>>>> @@ -31,7 +31,12 @@ static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
>>>>    {
>>>>           u32 i = ffs(bitmask);
>>>>
>>>> -       return i ? i - 1 : 32;
>>>> +       if (!i) {
>>>> +               WARN_ON_ONCE(1);
>>>> +               return 0;
>>>> +       }
>>>> +
>>>> +       return i - 1;
>>>>    }
>>> Personally, I prefer to use __ffs(), because in normal case no need additional '-1',
>>> and abnormal cases should not happen.
>> Hi,  Ping-Ke
>>
>> Replace _rtl8821ae_phy_calculate_bit_shift() by __ffs(bitmask) is better,
>> but I'm not sure what callers should do when callers check bitmask is 0 before calling.
>> Maybe this check is useless?
>>
>> I can send a v3 patch if using  __ffs(bitmask) and no check for bitmask is fine.
>> Or could you send this patch if you have a better idea?
>> Thanks for your suggestion!
>>
> Can this work to you?
Looks good to me, briefer and better!
I will send v3 soon.
> static u32 _rtl8821ae_phy_calculate_bit_shift(u32 bitmask)
> {
> 	if (WARN_ON_ONCE(!bitmask))
> 		return 0;
>
> 	return __ffs(bitmask);
> }

