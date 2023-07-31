Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC41769549
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjGaLyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjGaLyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:54:01 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3332119F;
        Mon, 31 Jul 2023 04:54:00 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qQRTH-0004qB-Gx; Mon, 31 Jul 2023 13:53:55 +0200
Message-ID: <edb7c56e-92d2-317e-b11b-caaabd33161b@leemhuis.info>
Date:   Mon, 31 Jul 2023 13:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jul 13 (drivers/video/fbdev/ps3fb.c)
Content-Language: en-US, de-DE
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org,
        Linux PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Geoff Levand <geoff@infradead.org>
References: <20230713123710.5d7d81e4@canb.auug.org.au>
 <ccc63065-2976-88ef-1211-731330bf2866@infradead.org>
 <ZLYHtVuS7AElXcCb@debian.me> <874jm1jv9m.fsf@mail.lhotse>
 <d9616a67-23e8-118f-dc0a-7ed4afd4bffd@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <d9616a67-23e8-118f-dc0a-7ed4afd4bffd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690804440;66623b8a;
X-HE-SMSGID: 1qQRTH-0004qB-Gx
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.07.23 18:15, Randy Dunlap wrote:
> On 7/18/23 04:48, Michael Ellerman wrote:
>> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>>> On Thu, Jul 13, 2023 at 09:11:10AM -0700, Randy Dunlap wrote:
>>>> on ppc64:
>>>>
>>>> In file included from ../include/linux/device.h:15,
>>>>                  from ../arch/powerpc/include/asm/io.h:22,
>>>>                  from ../include/linux/io.h:13,
>>>>                  from ../include/linux/irq.h:20,
>>>>                  from ../arch/powerpc/include/asm/hardirq.h:6,
>>>>                  from ../include/linux/hardirq.h:11,
>>>>                  from ../include/linux/interrupt.h:11,
>>>>                  from ../drivers/video/fbdev/ps3fb.c:25:
>>>> ../drivers/video/fbdev/ps3fb.c: In function 'ps3fb_probe':
>>>> ../drivers/video/fbdev/ps3fb.c:1172:40: error: 'struct fb_info' has no member named 'dev'
> [...]
>>
>> Does regzbot track issues in linux-next?

Seems your patch didn't make any progress, at least I can't see it in
-next. Is there a reason why, or did I miss anything?

And yes, sure, I'm aware that it's -next and a driver that people might
not enable regularly. But I noticed it and thought "quickly bring it up,
might be good to fix this rather sooner than later before other people
run into it (and who knows, maybe it'll switch a light in some CI system
from red to green as well)"

Ciao, Thorsten

>> The driver seems to only use info->dev in that one dev_info() line,
>> which seems purely cosmetic, so I think it could just be removed, eg:
>>
>> diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
>> index d4abcf8aff75..a304a39d712b 100644
>> --- a/drivers/video/fbdev/ps3fb.c
>> +++ b/drivers/video/fbdev/ps3fb.c
>> @@ -1168,8 +1168,7 @@ static int ps3fb_probe(struct ps3_system_bus_device *dev)
>>  
>>  	ps3_system_bus_set_drvdata(dev, info);
>>  
>> -	dev_info(info->device, "%s %s, using %u KiB of video memory\n",
>> -		 dev_driver_string(info->dev), dev_name(info->dev),
>> +	dev_info(info->device, "using %u KiB of video memory\n",
>>  		 info->fix.smem_len >> 10);
>>  
>>  	task = kthread_run(ps3fbd, info, DEVICE_NAME);
> 
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested
> 
> Thanks.
> 
