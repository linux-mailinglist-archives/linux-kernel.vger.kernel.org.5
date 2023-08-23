Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2046E785E70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237788AbjHWRTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237791AbjHWRTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:19:14 -0400
Received: from smtp.smtpout.orange.fr (smtp-29.smtpout.orange.fr [80.12.242.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F4310C3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 10:19:06 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id YrVNq4JlBntruYrVOq9cX0; Wed, 23 Aug 2023 19:19:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1692811144;
        bh=mEIOwM53xWNzgwUL0jHd9Fje9pXSrHPFj4ojAfs4iGE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=nnLI6lnJnSOGM/XXP8EclSXVJxK8SI1Y+C9HLufkxtyMcj1Y738B690xm3phjKZ4E
         1xsyizY0jr/PgacTNOdiM268nDBWWu46Z0h5ElAvFE4ataaj/kiS2elGALkA6YnZ0L
         pGv44b+PDbMaoxC2//iOCIoB3DpIDd37LTR55LjEhTexclRWce5nHbstgtohvHPdTP
         t5nM91RxVGTmwt6Nz5fH5DhI4brKSd1DYCO6vek2JoUc3snc00v9R5bZlWH5jHyET8
         vJ7OzjnFp+BsIF/LmraU/aux7fJxSo6yDTQn4LqPNQr22gWoVEtQiIj1B+6QF86XMF
         g9gmuuA2zEINQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 23 Aug 2023 19:19:04 +0200
X-ME-IP: 86.243.2.178
Message-ID: <de106b1f-00fe-b83d-657e-49732ed2b506@wanadoo.fr>
Date:   Wed, 23 Aug 2023 19:18:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ALSA: ac97: Fix possible NULL dereference in
 snd_ac97_mixer
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Su Hui <suhui@nfschina.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        maciej.szmigiero@oracle.com, yangyingliang@huawei.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20230615021732.1972194-1-suhui@nfschina.com>
 <49247018-20fe-8a04-75f2-dad4524aa3a3@wanadoo.fr>
 <878ra1hlk0.wl-tiwai@suse.de>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <878ra1hlk0.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 23/08/2023 à 16:37, Takashi Iwai a écrit :
> On Tue, 22 Aug 2023 22:07:40 +0200,
> Christophe JAILLET wrote:
>>
>> Le 15/06/2023 à 04:17, Su Hui a écrit :
>>> smatch error:
>>> sound/pci/ac97/ac97_codec.c:2354 snd_ac97_mixer() error:
>>> we previously assumed 'rac97' could be null (see line 2072)
>>>
>>> remove redundant assignment, return error if rac97 is NULL.
>>
>> Hi,
>>
>> why is the assigment redundant?
> 
> It's misleading, yeah.  Basically all callers are with non-NULL, hence
> we took rather make it mandatory.  Maybe it should have been with
> WARN_ON() to catch the NULL argument for an out-of-tree stuff.
> 
>> Should an error occur, the 'struct snd_ac97 **' parameter was garanted
>> to be set to NULL, now it is left as-is.
>>
>> I've checked all callers and apparently this is fine because the
>> probes fail if snd_ac97_mixer() returns an error.
>>
>> However, some drivers with several mixers seem to rely on the value
>> being NULL in case of error.
>>
>> See [1] as an example of such code that forces a NULL value on its
>> own, to be sure.
>>
>> So, wouldn't it be safer to leave a "*rac97 = NULL;" just after the
>> added sanity check?
> 
> Yes, we need the NULL initialization.
> Care to submit an additional fix patch?

Hi,

Su Hui already did.

CJ

> 
> 
> thanks,
> 
> Takashi
> 
>>
>>
>> CJ
>>
>>
>> [1]:
>> https://elixir.bootlin.com/linux/v6.5-rc7/source/sound/pci/atiixp.c#L1438
>>
>>>
>>> Fixes: da3cec35dd3c ("ALSA: Kill snd_assert() in sound/pci/*")
>>> Signed-off-by: Su Hui <suhui@nfschina.com>
>>> ---
>>>    sound/pci/ac97/ac97_codec.c | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
>>> index 9afc5906d662..80a65b8ad7b9 100644
>>> --- a/sound/pci/ac97/ac97_codec.c
>>> +++ b/sound/pci/ac97/ac97_codec.c
>>> @@ -2069,8 +2069,8 @@ int snd_ac97_mixer(struct snd_ac97_bus *bus, struct snd_ac97_template *template,
>>>    		.dev_disconnect =	snd_ac97_dev_disconnect,
>>>    	};
>>>    -	if (rac97)
>>> -		*rac97 = NULL;
>>> +	if (!rac97)
>>> +		return -EINVAL;
>>>    	if (snd_BUG_ON(!bus || !template))
>>>    		return -EINVAL;
>>>    	if (snd_BUG_ON(template->num >= 4))
>>
> 

