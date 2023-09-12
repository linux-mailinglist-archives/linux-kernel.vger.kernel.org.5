Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8DB79CF06
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbjILK67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234376AbjILK6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:58:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A7B170A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694516295; x=1726052295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bgdwlrzvBFkSNynjDEfBcTNkpO4Ws0O02LTFY9u0GIc=;
  b=nGlHS4J8QG9WG64vgFtf8fhCSBl2RtmjRws+4jmXnVy1otAqcYEbveuN
   I+dMzgN/7HYl5P+L/J3NGxzKhJyNNA4vzp/kdA7DRBuQAcf/GrfKSz5kt
   gRKuwW8p13qzvLE/hnk5EBbjXm4U9LncNWZ0RhG/ZVh4ftv5UxyG9ugNO
   GRkDySzki9tw9LhFtiqutSbUr+Q7prU+dkdTGALVxORIxYOAAo91fRlli
   nklBQ6tgQAu7fWr6oZd6Fi9vPlMyQMtv8R93RStkHMRvd5cfJNfwM7psp
   0M3xiZqMlI0K/Wq/HL1aKi/sr5mlvAEwJZE4dEwW+SQUDwXXW/H5nlj11
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="378251252"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="378251252"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:58:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="917392364"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="917392364"
Received: from mkidd-mobl.ger.corp.intel.com (HELO [10.251.217.72]) ([10.251.217.72])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 03:58:07 -0700
Message-ID: <597fcee0-a98f-4461-8f00-6033032c99e1@linux.intel.com>
Date:   Tue, 12 Sep 2023 13:58:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: core: Increase the name array size for debugfs
 directory name
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>, Arnd Bergmann <arnd@arndb.de>
Cc:     tiwai@suse.com, Jaroslav Kysela <perex@perex.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230912083910.15994-1-peter.ujfalusi@linux.intel.com>
 <96c5309d-bb06-486e-a1f8-e3d71b275f13@app.fastmail.com>
 <87cyyn7jvs.wl-tiwai@suse.de>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <87cyyn7jvs.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2023 13:42, Takashi Iwai wrote:
> On Tue, 12 Sep 2023 12:18:04 +0200,
> Arnd Bergmann wrote:
>>
>> On Tue, Sep 12, 2023, at 10:39, Peter Ujfalusi wrote:
>>
>>> While the code is correct, we need to silence the compiler somehow.
>>> It could be done by limiting the range in sprintf like
>>> sprintf(name, "card%d", idx % SNDRV_CARDS);
>>> sprintf(name, "card%hhd", idx);
>>> etc
>>>
>>> These are too workaroundish. Increase the name array to 15 instead which
>>> looks better and only adds 7 bytes on stack.
>>
>> It looks like we use the same string for kobject_set_name(), so
>> maybe this would work as well:
>>
>> --- a/sound/core/init.c
>> +++ b/sound/core/init.c
>> @@ -278,9 +278,6 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
>>                          size_t extra_size)
>>  {
>>         int err;
>> -#ifdef CONFIG_SND_DEBUG
>> -       char name[8];
>> -#endif
>>  
>>         if (extra_size > 0)
>>                 card->private_data = (char *)card + sizeof(struct snd_card);
>> @@ -364,8 +361,8 @@ static int snd_card_init(struct snd_card *card, struct device *parent,
>>         }
>>  
>>  #ifdef CONFIG_SND_DEBUG
>> -       sprintf(name, "card%d", idx);
>> -       card->debugfs_root = debugfs_create_dir(name, sound_debugfs_root);
>> +       card->debugfs_root = debugfs_create_dir(kobject_name(&card->card_dev.kobj),
>> +                                               sound_debugfs_root);
> 
> The idea looks neat, but I suppose it's better with
> dev_name(&card->card_dev) instead?

Yes, this looks better, I will send a new patch in a minute.

> 
> thanks,
> 
> Takashi

-- 
Péter
