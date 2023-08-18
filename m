Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6506C780E0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 16:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377704AbjHROdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 10:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377796AbjHROc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 10:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27F53C3D;
        Fri, 18 Aug 2023 07:32:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8828165E3D;
        Fri, 18 Aug 2023 14:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3534C433C9;
        Fri, 18 Aug 2023 14:32:46 +0000 (UTC)
Message-ID: <1c00196c-e64e-119a-fd30-5e8f797c22ec@xs4all.nl>
Date:   Fri, 18 Aug 2023 16:32:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] [media] mxl111sf: Check return value in
 mxl111sf_config_mpeg_in
To:     Artem Chernyshev <artem.chernyshev@red-soft.ru>,
        Michael Ira Krufky <mkrufky@linuxtv.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lvc-project@linuxtesting.org
References: <20221222214607.39737-1-artem.chernyshev@red-soft.ru>
 <CAOcJUby8i=vRu5-cSe6iBKrnLG8ucmatpiPT=VaMS9etwHH_uw@mail.gmail.com>
 <Y6XXF6gffL9aHTuw@localhost.localdomain>
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <Y6XXF6gffL9aHTuw@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/12/2022 17:28, Artem Chernyshev wrote:
> Hi,
> On Fri, Dec 23, 2022 at 07:28:47AM -0500, Michael Ira Krufky wrote:
>> On Thu, Dec 22, 2022, 4:46 PM Artem Chernyshev <artem.chernyshev@red-soft.ru>
>> wrote:
>>
>>> Error check after mxl111sf_read_reg
>>>
>>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>>
>>> Fixes: 4c66c9205c07 ("[media] dvb-usb: add ATSC support for the Hauppauge
>>> WinTV-Aero-M")
>>> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
>>> ---
>>>  drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
>>> b/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
>>> index 40b26712ba4c..ad1888514bd0 100644
>>> --- a/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
>>> +++ b/drivers/media/usb/dvb-usb-v2/mxl111sf-phy.c
>>> @@ -121,7 +121,8 @@ int mxl111sf_config_mpeg_in(struct mxl111sf_state
>>> *state,
>>>         mxl_fail(ret);
>>>
>>>         /* Configure MPEG Clock phase */
>>> -       mxl111sf_read_reg(state, V6_MPEG_IN_CLK_INV_REG, &mode);
>>> +       ret = mxl111sf_read_reg(state, V6_MPEG_IN_CLK_INV_REG, &mode);
>>> +       mxl_fail(ret);
>>>
>>>         if (clock_phase == TSIF_NORMAL)
>>>                 mode &= ~V6_INVERTED_CLK_PHASE;
>>> --
>>> 2.30.3
>>>
>>
>> Artem,
>>
>> Thank you for this.  If I recall correctly, the read from that particular
>> register often returns a failure despite the correct value being read into
>> memory. This needs to be tested before being merged, and if my memory is
>> correct about this we should add a comment about it. Unfortunately, I'm out
>> of town at the moment, I won't be able to test this for some time. Can we
>> hold off on this one for a bit? If you don't hear from me after a few
>> weeks, please feel free to ping me again. Thanks.
>>
>> Best,
>> Michael Krufky
>>
>>>
> 
> Thanks for reply. I'll be waiting for your decision

I'll drop this patch, I never saw a follow-up on this.

If this is really needed, then just resend.

Regards,

	Hans

> 
> Best regards,
> Artem

