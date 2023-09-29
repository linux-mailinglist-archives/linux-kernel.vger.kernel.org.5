Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6F7B3150
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 13:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjI2L0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 07:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2L0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 07:26:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2426FB7;
        Fri, 29 Sep 2023 04:26:10 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qmBdH-00016J-Jk; Fri, 29 Sep 2023 13:26:07 +0200
Message-ID: <9c1b89af-4002-4275-88e5-59d6ae1f4bcd@leemhuis.info>
Date:   Fri, 29 Sep 2023 13:26:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: remove VHT160 capability on
 MT7915
Content-Language: en-US, de-DE
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-wireless@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230726091704.25795-1-nbd@nbd.name>
 <12289744.O9o76ZdvQC@natalenko.name> <2023092145-luxury-fender-d5b9@gregkh>
 <4862789.31r3eYUQgx@natalenko.name>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <4862789.31r3eYUQgx@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695986770;987ca405;
X-HE-SMSGID: 1qmBdH-00016J-Jk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Seems nothing happened since this regression was reported more that a
week ago. From a quick search on lore it seems Felix is not around
currently; thus bringing the other mt76 maintainers in, maybe they can
help out here to get this fixed rather sooner than later, as the culprit
unfortunately made it to various stable trees. Ciao, Thorsten.

On 21.09.23 18:03, Oleksandr Natalenko wrote:
> On čtvrtek 21. září 2023 9:19:58 CEST Greg Kroah-Hartman wrote:
>> On Thu, Sep 21, 2023 at 07:02:41AM +0200, Oleksandr Natalenko wrote:
>>>
>>> On středa 26. července 2023 11:17:02 CEST Felix Fietkau wrote:
>>>> The IEEE80211_VHT_CAP_EXT_NSS_BW value already indicates support for half-NSS
>>>> 160 MHz support, so it is wrong to also advertise full 160 MHz support.
>>>>
>>>> Fixes: c2f73eacee3b ("wifi: mt76: mt7915: add back 160MHz channel width support for MT7915")
>>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>>> ---
>>>>  drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>>>> index ee976657bfc3..78552f10b377 100644
>>>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>>>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>>>> @@ -414,7 +414,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
>>>>  			if (!dev->dbdc_support)
>>>>  				vht_cap->cap |=
>>>>  					IEEE80211_VHT_CAP_SHORT_GI_160 |
>>>> -					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
>>>>  					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
>>>>  		} else {
>>>>  			vht_cap->cap |=
>>>>
>>>
>>> For some reason this got backported into the stable kernel:
>>>
>>> ```
>>> $ git log --oneline v6.5.2..v6.5.4 -- drivers/net/wireless/mediatek/mt76/mt7915/
>>> c43017fbebcc3 wifi: mt76: mt7915: fix power-limits while chan_switch
>>> edb1afe042c74 wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
>>> 9ec0dec0baea3 wifi: mt76: mt7915: remove VHT160 capability on MT7915
>>> 0e61f73e6ebc0 wifi: mt76: mt7915: fix capabilities in non-AP mode
>>> 6bce28ce28390 wifi: mt76: mt7915: fix command timeout in AP stop period
>>> 7af917d4864c6 wifi: mt76: mt7915: rework tx bytes counting when WED is active
>>> feae00c6468ce wifi: mt76: mt7915: rework tx packets counting when WED is active
>>> 70bbcc4ad6544 wifi: mt76: mt7915: fix background radar event being blocked
>>> ```
>>>
>>> and this broke my mt7915-based AP.
>>>
>>> However, if I remove `[VT160]` capability from the hostapd config, things go back to normal. It does seem that 160 MHz still works even.
>>>
>>> Is this expected?
>>
>> Is your device also broken in 6.6-rc2?
> 
> Yes, the same behaviour is observed with v6.6-rc2:
> 
> ```
> hostapd[1316]: Configured VHT capability [VHT_CAP_SUPP_CHAN_WIDTH_MASK] exceeds max value supported by the driver (1 > 0)
> ```
> 
> while having `[VT160]` in `vht_capab=`.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot introduced 3ec5ac12ac8a4e
#regzbot ignore-activity
