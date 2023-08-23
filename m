Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01978784E22
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 03:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbjHWBZY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 21:25:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbjHWBZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 21:25:23 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5873AE40;
        Tue, 22 Aug 2023 18:25:21 -0700 (PDT)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id 1ED8E6019B71A;
        Wed, 23 Aug 2023 09:24:42 +0800 (CST)
Message-ID: <c2327680-b03c-ca95-b286-12a2e4b2c241@nfschina.com>
Date:   Wed, 23 Aug 2023 09:24:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ALSA: ac97: Fix possible NULL dereference in
 snd_ac97_mixer
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, maciej.szmigiero@oracle.com,
        yangyingliang@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <49247018-20fe-8a04-75f2-dad4524aa3a3@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        RDNS_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/8/23 04:07, Christophe JAILLET wrote:
> Le 15/06/2023 à 04:17, Su Hui a écrit :
>> smatch error:
>> sound/pci/ac97/ac97_codec.c:2354 snd_ac97_mixer() error:
>> we previously assumed 'rac97' could be null (see line 2072)
>>
>> remove redundant assignment, return error if rac97 is NULL.
>
> Hi,
>
> why is the assigment redundant?
>
> Should an error occur, the 'struct snd_ac97 **' parameter was garanted 
> to be set to NULL, now it is left as-is.
>
> I've checked all callers and apparently this is fine because the 
> probes fail if snd_ac97_mixer() returns an error.
>
> However, some drivers with several mixers seem to rely on the value 
> being NULL in case of error.
>
> See [1] as an example of such code that forces a NULL value on its 
> own, to be sure.
>
> So, wouldn't it be safer to leave a "*rac97 = NULL;" just after the 
> added sanity check?
>
Hi,

Really thanks for pointing this mistake.

this assignment is necessary and removing it may cause some problem.

So sorry for my mistake, I will send a patch to fix it right now.

Su Hui

>
> CJ
>
>
> [1]: 
> https://elixir.bootlin.com/linux/v6.5-rc7/source/sound/pci/atiixp.c#L1438
>
>>
>> Fixes: da3cec35dd3c ("ALSA: Kill snd_assert() in sound/pci/*")
>> Signed-off-by: Su Hui <suhui@nfschina.com>
>> ---
>>   sound/pci/ac97/ac97_codec.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
>> index 9afc5906d662..80a65b8ad7b9 100644
>> --- a/sound/pci/ac97/ac97_codec.c
>> +++ b/sound/pci/ac97/ac97_codec.c
>> @@ -2069,8 +2069,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, 
>> struct snd_ac97_template *template,
>>           .dev_disconnect =    snd_ac97_dev_disconnect,
>>       };
>>   -    if (rac97)
>> -        *rac97 = NULL;
>> +    if (!rac97)
>> +        return -EINVAL;
>>       if (snd_BUG_ON(!bus || !template))
>>           return -EINVAL;
>>       if (snd_BUG_ON(template->num >= 4))
>
