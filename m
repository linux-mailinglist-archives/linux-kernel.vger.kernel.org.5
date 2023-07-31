Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05962768A0D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 04:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGaCiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 22:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaCiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 22:38:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11ACDC;
        Sun, 30 Jul 2023 19:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=A0dSOH2m8ipT3K2klg7qGf7lmKLpHt051xKXzyE3rJM=; b=VyNdj1OcZ3+XjZSsavP5dMPZfd
        DD97JrAQxEahFOM/M1BOdotTpd0YDkfMznCWXL9/PywliVdHpWBDEhTauTfF5Nhq4+uvjDNZnVhDT
        YHqlEpwo8/HfJK1l1kPPD5qSNveOe7DlU6wVkf3jfsZ/H0J0WKe4/+TX5ToQe6WWNkjHUw7uc4HKK
        QDnfzSM3q7bIEMux4N45LtqfZz2Qu+HDqEuba9nGuUeNvH1N61GGC4VOip5FbCr+wm984CiopVjIF
        PNqSqDpsRoTC+7ttwLFujsiQp0TgD+uRa6NnQ0nM8hoMJRrWFgAxjXMSYp64URl5AI+O/Rtgpf9Lq
        h2KWXmzw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qQInP-00DXEJ-0Z;
        Mon, 31 Jul 2023 02:38:07 +0000
Message-ID: <3cd0e5b7-7e20-ce3b-e391-eb77443f63b1@infradead.org>
Date:   Sun, 30 Jul 2023 19:38:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] um/drivers: fix hostaudio build errors
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Tejun Heo <tj@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, alsa-devel@alsa-project.org
References: <20230728043013.27776-1-rdunlap@infradead.org>
 <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAK7LNAR4BkAKhZZ8+Zybed3Jm3omxzzdgus-Nqj-9MjWAeSmiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/23 01:51, Masahiro Yamada wrote:
> On Fri, Jul 28, 2023 at 1:30 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Use "select"s to ensure that the required kconfig symbols are set
>> as expected.
>> Drop HOSTAUDIO since it is now equivalent to UML_SOUND.
>>
>> Allow SOUND with UML regardless of HAS_IOMEM. Otherwise there is a
>> kconfig warning for unmet dependencies. (This was not an issue when
>> SOUND was defined in arch/um/drivers/Kconfig. I have done 50 randconfig
>> builds and didn't find any issues.)
>>
>> This fixes build errors when CONFIG_SOUND is not set:
>>
>> ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_cleanup_module':
>> hostaudio_kern.c:(.exit.text+0xa): undefined reference to `unregister_sound_mixer'
>> ld: hostaudio_kern.c:(.exit.text+0x15): undefined reference to `unregister_sound_dsp'
>> ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_init_module':
>> hostaudio_kern.c:(.init.text+0x19): undefined reference to `register_sound_dsp'
>> ld: hostaudio_kern.c:(.init.text+0x31): undefined reference to `register_sound_mixer'
>> ld: hostaudio_kern.c:(.init.text+0x49): undefined reference to `unregister_sound_dsp'
>>
>> and this kconfig warning:
>> WARNING: unmet direct dependencies detected for SOUND
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Fixes: d886e87cb82b ("sound: make OSS sound core optional")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: lore.kernel.org/r/202307141416.vxuRVpFv-lkp@intel.com
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
>> Cc: Johannes Berg <johannes@sipsolutions.net>
>> Cc: linux-um@lists.infradead.org
>> Cc: Tejun Heo <tj@kernel.org>
>> Cc: Takashi Iwai <tiwai@suse.de>
>> Cc: Jaroslav Kysela <perex@perex.cz>
>> Cc: Masahiro Yamada <masahiroy@kernel.org>
>> Cc: Nathan Chancellor <nathan@kernel.org>
>> Cc: Nick Desaulniers <ndesaulniers@google.com>
>> Cc: Nicolas Schier <nicolas@fjasle.eu>
>> Cc: linux-kbuild@vger.kernel.org
>> Cc: alsa-devel@alsa-project.org
>> ---
>> v2: don't delete the HOSTAUDIO Kconfig entry (Masahiro)
>> v3: drop HOSTAUDIO and use CONFIG_UML_SOUND for it in Makefile (Takashi);
>>     add SOUND depends on "|| UML" to HAS_IOMEM
>>
>>  arch/um/drivers/Kconfig  |   14 ++------------
>>  arch/um/drivers/Makefile |    2 +-
>>  sound/Kconfig            |    2 +-
>>  3 files changed, 4 insertions(+), 14 deletions(-)
>>
>> diff -- a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
>> --- a/arch/um/drivers/Kconfig
>> +++ b/arch/um/drivers/Kconfig
>> @@ -111,24 +111,14 @@ config SSL_CHAN
>>
>>  config UML_SOUND
>>         tristate "Sound support"
>> +       select SOUND
> 
> 
> This would be the only instance that select's SOUND.
> Perhaps, this could be 'depends on SOUND'.
> (in that case, arch/um/configs/*_defconfig needs modification).
> 
> Just my two cents.
> 

Oh, good point, and one that I agree with.

I'll send a v4.

> 
> Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>

Takashi, I don't know who will merge the patch, but I would expect
that one of the UML maintainers to merge it.... FWIW.

Thanks.
-- 
~Randy
