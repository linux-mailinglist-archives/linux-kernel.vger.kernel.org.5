Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AAB7AB084
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 13:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjIVLWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 07:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjIVLWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:22:43 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCC28F;
        Fri, 22 Sep 2023 04:22:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qjeF0-0001kI-Kc; Fri, 22 Sep 2023 13:22:34 +0200
Message-ID: <b5e822ff-4b7c-4617-96c8-5b132df814ab@leemhuis.info>
Date:   Fri, 22 Sep 2023 13:22:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH 1/3] wifi: mt76: mt7915: remove VHT160 capability on
 MT7915
Content-Language: en-US, de-DE
To:     Oleksandr Natalenko <oleksandr@natalenko.name>,
        linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230726091704.25795-1-nbd@nbd.name>
 <12289744.O9o76ZdvQC@natalenko.name>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <12289744.O9o76ZdvQC@natalenko.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695381756;a2ff28c2;
X-HE-SMSGID: 1qjeF0-0001kI-Kc
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 21.09.23 07:02, Oleksandr Natalenko wrote:
> 
> On středa 26. července 2023 11:17:02 CEST Felix Fietkau wrote:
>> The IEEE80211_VHT_CAP_EXT_NSS_BW value already indicates support for half-NSS
>> 160 MHz support, so it is wrong to also advertise full 160 MHz support.
>>
>> Fixes: c2f73eacee3b ("wifi: mt76: mt7915: add back 160MHz channel width support for MT7915")
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  drivers/net/wireless/mediatek/mt76/mt7915/init.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> index ee976657bfc3..78552f10b377 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
>> @@ -414,7 +414,6 @@ mt7915_init_wiphy(struct mt7915_phy *phy)
>>  			if (!dev->dbdc_support)
>>  				vht_cap->cap |=
>>  					IEEE80211_VHT_CAP_SHORT_GI_160 |
>> -					IEEE80211_VHT_CAP_SUPP_CHAN_WIDTH_160MHZ |
>>  					FIELD_PREP(IEEE80211_VHT_CAP_EXT_NSS_BW_MASK, 1);
>>  		} else {
>>  			vht_cap->cap |=
>>
> 
> For some reason this got backported into the stable kernel:
> 
> ```
> $ git log --oneline v6.5.2..v6.5.4 -- drivers/net/wireless/mediatek/mt76/mt7915/
> c43017fbebcc3 wifi: mt76: mt7915: fix power-limits while chan_switch
> edb1afe042c74 wifi: mt76: mt7915: fix tlv length of mt7915_mcu_get_chan_mib_info
> 9ec0dec0baea3 wifi: mt76: mt7915: remove VHT160 capability on MT7915
> 0e61f73e6ebc0 wifi: mt76: mt7915: fix capabilities in non-AP mode
> 6bce28ce28390 wifi: mt76: mt7915: fix command timeout in AP stop period
> 7af917d4864c6 wifi: mt76: mt7915: rework tx bytes counting when WED is active
> feae00c6468ce wifi: mt76: mt7915: rework tx packets counting when WED is active
> 70bbcc4ad6544 wifi: mt76: mt7915: fix background radar event being blocked
> ```
> 
> and this broke my mt7915-based AP.
> 
> However, if I remove `[VT160]` capability from the hostapd config, things go back to normal. It does seem that 160 MHz still works even.
> 
> Is this expected?

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 3ec5ac12ac8a4e..fe0ea395f0a351
#regzbot title wifi: mt76: mt7915: removal of VHT160 capability broke hostap
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
