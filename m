Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F45A7A6F49
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjISXOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjISXON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:14:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4089C83
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:14:07 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-565e395e7a6so3666102a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695165246; x=1695770046; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+0wJC7iUqUi/VsmoECNjzdaGcwsX7nzVBUm4bndTmRU=;
        b=eWOQDs4LomUPB0FcB5muSb58t8C1pyTV0QDu8t9WcirlQKBh9rK7X0mNPcEX5+EOmM
         hm+RPIv4YKJmmpBgFSYmBPbCzVihl/OFIs65LRvXTv2bLdu3Slvj2RDxov5A+RLNAJAW
         4JGAVe+K9d4dy4gP7YyFqgcjOei6Z5+Crz78QuRKtH8hYlPPSFIoRfT6bXqnsHiePS85
         WDeAqio9dxrSUnrcrG/BVJmZdbRo7PZmYLUOsmGwPNw8EJjSwXeWXFAvtmX6UuhsVfHl
         yQrzNvXeK+y7UNYWhBTvPYthOo6S5GAtFzn1VrBLFLhH9y4b/znnot0AgTiUxmr8aPny
         3ATQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695165246; x=1695770046;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+0wJC7iUqUi/VsmoECNjzdaGcwsX7nzVBUm4bndTmRU=;
        b=JNtHK3Ik+LwTZqQmlJ4npRIzfPE/Xjt5QoIdcuMRBwxtBNQvj4H6NXolLPsTdrW+q2
         TPR4OjuDKj3VJ3lu1HJCTNyQKkVxHoWJG9BVcb+rsAQNfAxFqjHp2fLcXMhH4G60Xt1g
         O9Re5HnHvLfe0mSkB8gqBb6Yy5qBKrtXWzOstQyy68WLKkIWi3qduWjYaTeIvxGkOgIz
         UEi1iOOswhxAFCuYn0dSzLdBV1TNfmw4lddrtMav2opJdIEHtNAB7AxHFaHxgWjeCy2J
         PPajqjcbG5FZaYt+SE/iTFsfHfNmqjixATdT9f8Dy403229WZ/I1oWdw7+i3tt8p8Nka
         1gpA==
X-Gm-Message-State: AOJu0YzwO+75KAjtT1Dx8ZLb7ET1mnlMBUBedRpxLT9MZFXdFQCxPChC
        Pf5TnUphuU5/BryIg/Um4so=
X-Google-Smtp-Source: AGHT+IEZe/2KTsL6EVUWfjL3HIExO8u4xxxki/8R7e4Pplf40roIx+nF/BcODB1F5YyVg3S44WH1Tw==
X-Received: by 2002:a05:6a21:8185:b0:14b:7d8b:cbaf with SMTP id pd5-20020a056a21818500b0014b7d8bcbafmr869151pzb.57.1695165246513;
        Tue, 19 Sep 2023 16:14:06 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090a1f4f00b00276a0d96a2esm123641pjy.46.2023.09.19.16.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 16:14:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a57afd40-71a2-aa68-84cb-44d2a88a1e2b@roeck-us.net>
Date:   Tue, 19 Sep 2023 16:14:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0
 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned
 int[]'}
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, kernel test robot <lkp@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <202309192013.vI4DKHmw-lkp@intel.com>
 <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/23 11:37, Rob Herring wrote:
> On Tue, Sep 19, 2023 at 7:09 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   2cf0f715623872823a72e451243bbf555d10d032
>> commit: f1a43aadb5a690e141a3b6700e2a40c1d4dbe088 watchdog: Enable COMPILE_TEST for more drivers
>> date:   5 weeks ago
>> config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230919/202309192013.vI4DKHmw-lkp@intel.com/config)
>> compiler: m68k-linux-gcc (GCC) 13.2.0
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309192013.vI4DKHmw-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202309192013.vI4DKHmw-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from arch/m68k/include/asm/io_mm.h:25,
>>                      from arch/m68k/include/asm/io.h:8,
>>                      from include/linux/io.h:13,
>>                      from drivers/watchdog/machzwd.c:39:
>>     In function 'zf_set_timer',
>>         inlined from 'zf_timer_on' at drivers/watchdog/machzwd.c:218:2:
>>>> arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned int[]'} [-Warray-bounds=]
>>        91 |         __w = ((*(__force volatile u16 *) ((_addr & 0xFFFF0000UL) + ((__v >> 8)<<1)))); \
>>           |         ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     arch/m68k/include/asm/io_mm.h:228:20: note: in expansion of macro 'rom_out_le16'
>>       228 |                  : rom_out_le16(isa_itw(port), (val)))
>>           |                    ^~~~~~~~~~~~
>>     arch/m68k/include/asm/io_mm.h:356:42: note: in expansion of macro 'isa_rom_outw'
>>       356 | #define outw(val, port) ((port) < 1024 ? isa_rom_outw((val), (port)) : out_le16((port), (val)))
>>           |                                          ^~~~~~~~~~~~
>>     drivers/watchdog/machzwd.c:74:53: note: in expansion of macro 'outw'
>>        74 | #define zf_writew(port, data)  { outb(port, INDEX); outw(data, DATA_W); }
>>           |                                                     ^~~~
>>     drivers/watchdog/machzwd.c:173:17: note: in expansion of macro 'zf_writew'
>>       173 |                 zf_writew(COUNTER_1, new);
>>           |                 ^~~~~~~~~
>>     In function 'zf_timer_on':
>>     cc1: note: source object is likely at address zero
> 
> This seems to be some newish check in gcc which looks for fixed
> pointers below 4KB[1]. The linked issue says more was planned for
> gcc-13, but I haven't found what that is. AFAICT, that shouldn't
> happen with this config because isa_itw() should be variable and the
> compiler shouldn't be able to determine the value of _addr. However, a
> config with CONFIG_Q40=n, CONFIG_AMIGA_PCMCIA=n, and
> CONFIG_ATARI_ROM_ISA=n would have a fixed NULL value and could trigger
> the warning. This should also have warnings everywhere outw() (and
> others) are used with a constant port value.
> 
> Rob
> 
> [1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578

A long time ago, when someone submitted a "cleanup: patch for the machzwd
watchdog driver, I approved it but added this comment.

 > If anyone is still using the HW supported by this driver, it would
 > be a prime target for conversion to use the watchdog subsystem.
 > This would reduce code size and improve driver stability.
 > _That_ would be useful.

 > The only reason for replacing 0 with NULL is to make a static checker
 > happy. This kind of change adds zero value to the code. Instead, it
 > takes time from those who have to review the patches and apply them.

 > If we ignore such patches, we'll get them again and again, taking
 > away even more time. If we don't ignore them, we encourage submitters
 > and get even more useless patches. If we try to discourage them, we
 > risk being accused of being unfriendly. This is a perfect lose-lose
 > situation for maintainers.

I do wonder if enabling BUILD_TEST on such drivers is any better.

Guenter

