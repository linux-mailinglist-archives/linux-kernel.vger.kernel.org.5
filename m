Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2529D771E59
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjHGKlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjHGKlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:41:08 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D9110FA;
        Mon,  7 Aug 2023 03:41:05 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qSxfX-000663-HB; Mon, 07 Aug 2023 12:40:59 +0200
Message-ID: <d0a6b711-f683-0104-a1c8-09130a160861@leemhuis.info>
Date:   Mon, 7 Aug 2023 12:40:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btrtl: Load FW v2 otherwise FW v1 for
 RTL8852C
Content-Language: en-US, de-DE
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        max.chou@realtek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com,
        kidman@realtek.com, vicamo.yang@canonical.com, Riley.Kao@dell.com,
        stable@vger.kernel.org, jwboyer@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        regressions@lists.linux.dev
References: <20230807014415.12358-1-max.chou@realtek.com>
 <20230807120630.79b9e933@smeagol>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230807120630.79b9e933@smeagol>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691404865;526a6906;
X-HE-SMSGID: 1qSxfX-000663-HB
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.08.23 12:06, Juerg Haefliger wrote:
> On Mon, 7 Aug 2023 09:44:15 +0800
> <max.chou@realtek.com> wrote:
> 
>> From: Max Chou <max.chou@realtek.com>
>>
>> In the commit of linux-firmware project, rtl8852cu_fw.bin is updated as
>> FW v2 format[1]. Consider the case that if driver did not be updated for
>> FW v2 supported[2], it can not use FW v2.
>> By Canonical's suggestion, older driver should be able to load FW v1,
>> so rtl8852cu_fw.bin will be revert to the previous commit as FW v1 and
>> add rtl8852cu_fw_v2.bin as FW v2. This item will be started on
>> linux-firmware project.
>>
>> In this commit, the driver prefers to load FW v2 if available. Fallback to
>> FW v1 otherwise.
>>
>> Note that the driver has supported to extract the data for v1 and v2
>> since the commit[1].
>> The previous FW format of RTL8852C is v1. After the commit[2], the FW
>> format was changed to v2. Only RTL8852C suffered the different FW formats,
>> so we will use rtl8852cu_fw.bin for the original commit as FW v1 and
>> rtl8852cu_fw_v2.bin for the future maintained as FW v2. Other Realtek
>> chips will not been impacted by this patch.
>>
>> To do on linux-firmware project after this commit.
>> 1. revert '55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
>>    to 0x040D_7225")'
>>    => rtl_bt/rtl8852cu_fw.bin: FW v1 (stay at ver. 0xD7B8_FABF)  
>> 2. Add a new commit for rtl8852cu_fw_v2.bin
>>    =>rtl_bt/rtl8852cu_fw_v2.bin: FW v2 (to be maintained)  
>>
>> Reference:
>> [1]'9a24ce5e29b1 ("Bluetooth: btrtl: Firmware format v2 support")'
>> [2]'55e7448533e7 ("rtl_bt: Update RTL8852C BT USB firmware
>>     to 0x040D_7225")'
> 
> IMO this commit message is too confusing. I don't think you need nor should
> refer to linux-firmware commits and what happened in that repo. This commit
> simply fixes the v2 support by trying to load a v2 file for certain chips
> with a fall-back if fw is not found (or failed to load). That's all that
> needs to be mentioned in the commit message.

/me totally agrees that this in confusing the way it is and needs to be
simplified, but explaining things briefly with maybe a Link: to the
linux-firmware commit in question might nevertheless be a good idea (YMMV)

>> Fixes: '9a24ce5e29b ("Bluetooth: btrtl: Firmware format v2 support")'
> 
> No '' quotes.

Max Chou, you could have just picked the two tags I mentioned earlier
just without the space in front of it[1]. If you do so the 0-day robot
will also stop complaining, as you apparently misunderstood what I meant
with stable tag; [2] explains this.

Ciao, Thorsten

[1]
https://lore.kernel.org/all/f11ba0ef-0bb1-b925-3088-2ba7a8d17393@leemhuis.info/
[2] https://docs.kernel.org/process/stable-kernel-rules.html
