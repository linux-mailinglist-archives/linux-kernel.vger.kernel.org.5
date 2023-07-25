Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D9676213B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGYST6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjGYST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:19:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31AA1BF8;
        Tue, 25 Jul 2023 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ywOmQ9KEGxGLt/sFlF4nzRuGBxtql0ZMvWFiLXP+ehI=; b=f7MS5QINfxkRvRqk9Dc5NsqNQJ
        nAoyMaHQPjoziMDoQk4Byjmffm8kB/zg7eoHixuQiIXirpUT6hjU4PjvjANjva0vvEbfPpnAjEbzX
        HbyZASV+XeFICCTyaHxMdK+WMKDaR7BgW6PlFq0iHT1pnxZKdyJHEfFdHj1nKzRdihjN+QcHGuWbh
        wV+mlIGdkeUpVSKrhJjafXZVN6JrkE330VqeJZcAaHYvDrvJC2jgx8vrkpvsz1XfaOuL3S6Lf2GhI
        cWYkmf0xtmkirlnGM47RvlkDvsML3iXfIJsNUcfgFZCNDAM/YIQg8+9F028VoRIC2RKn5i7HgOvSF
        7cFwDIPA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qOMdQ-008FPM-33;
        Tue, 25 Jul 2023 18:19:49 +0000
Message-ID: <5e56d4a9-2671-caf7-c267-9beec6f14aa3@infradead.org>
Date:   Tue, 25 Jul 2023 11:19:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] um/drivers: Kconfig: fix hostaudio build errors
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Tejun Heo <tj@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org
References: <20230723215756.18307-1-rdunlap@infradead.org>
 <87jzuoth7s.wl-tiwai@suse.de>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87jzuoth7s.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/25/23 03:31, Takashi Iwai wrote:
> On Sun, 23 Jul 2023 23:57:56 +0200,
> Randy Dunlap wrote:
>>
>> Use "select"s to ensure that the required kconfig symbols are set
>> as expected.
>>
>> This fixes build errors when CONFIG_SOUND is not set.
>>
>> ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_cleanup_module':
>> hostaudio_kern.c:(.exit.text+0xa): undefined reference to `unregister_sound_mixer'
>> ld: hostaudio_kern.c:(.exit.text+0x15): undefined reference to `unregister_sound_dsp'
>> ld: arch/um/drivers/hostaudio_kern.o: in function `hostaudio_init_module':
>> hostaudio_kern.c:(.init.text+0x19): undefined reference to `register_sound_dsp'
>> ld: hostaudio_kern.c:(.init.text+0x31): undefined reference to `register_sound_mixer'
>> ld: hostaudio_kern.c:(.init.text+0x49): undefined reference to `unregister_sound_dsp'
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
>> ---
>> v2: don't delete the HOSTAUDIO Kconfig entry (Masahiro)
>>
>>  arch/um/drivers/Kconfig |   10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff -- a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
>> --- a/arch/um/drivers/Kconfig
>> +++ b/arch/um/drivers/Kconfig
>> @@ -111,20 +111,14 @@ config SSL_CHAN
>>  
>>  config UML_SOUND
>>  	tristate "Sound support"
>> +	select SOUND
>> +	select SOUND_OSS_CORE
>>  	help
>>  	  This option enables UML sound support.  If enabled, it will pull in
>>  	  soundcore and the UML hostaudio relay, which acts as a intermediary
>>  	  between the host's dsp and mixer devices and the UML sound system.
>>  	  It is safe to say 'Y' here.
>>  
>> -config SOUND
>> -	tristate
>> -	default UML_SOUND
>> -
>> -config SOUND_OSS_CORE
>> -	bool
>> -	default UML_SOUND
>> -
>>  config HOSTAUDIO
>>  	tristate
>>  	default UML_SOUND
> 
> And now essentially CONFIG_HOSTAUDIO is equal with CONFIG_UML_SOUND.
> Then isn't it better to replace CONFIG_HOSTAUDIO in
> arch/um/drivers/Makefile with CONFIG_UML_SOUND, so that you can drop
> CONFIG_HOSTAUDIO as well?

OK, I'll send a v3 with that change.

thanks.
-- 
~Randy
