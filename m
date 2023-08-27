Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B645789FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 17:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbjH0PIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 11:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjH0PHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 11:07:53 -0400
X-Greylist: delayed 85351 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 27 Aug 2023 08:07:50 PDT
Received: from mail.enpas.org (zhong.enpas.org [46.38.239.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EAAC1;
        Sun, 27 Aug 2023 08:07:50 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.enpas.org (Postfix) with ESMTPSA id F301D101349;
        Sun, 27 Aug 2023 15:07:45 +0000 (UTC)
Message-ID: <84c7f090-b84e-fbea-4e2e-9730a39e2db8@enpas.org>
Date:   Mon, 28 Aug 2023 00:07:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] xpad: XTYPE_XBOX: Report analog buttons
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Vicki Pfau <vi@endrift.com>,
        Pavel Rojtberg <rojtberg@gmail.com>,
        Roderick Colenbrander <roderick@gaikai.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230826152111.13525-1-max@enpas.org>
 <20230826152111.13525-2-max@enpas.org> <87fs45u4o2.fsf@protonmail.com>
Content-Language: en-US
From:   Max Staudt <max@enpas.org>
In-Reply-To: <87fs45u4o2.fsf@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/23 01:52, Rahul Rameshbabu wrote:
> You will want to update the commit message subject to use the prefix
> "Input: xpad -" instead of "xpad:".

Thanks, will do!


>> +/* used for analog face buttons mapped to axes */
>> +static const signed short xpad_abs_analog_face_buttons[] = {
>> +	ABS_MISC + 0, ABS_MISC + 1, /* A, B */
>> +	ABS_MISC + 3, ABS_MISC + 4, /* X, Y */
>> +	ABS_MISC + 2, ABS_MISC + 5, /* C, Z */
>> +	-1
>> +};
> 
> Would it make more sense to use an enum for this?
> Something like the below enum.
> 
>    enum xpad_abs_analog_face_btn {
>         XPAD_ABS_ANALOG_FACE_BTN_A = ABS_MISC,
>         XPAD_ABS_ANALOG_FACE_BTN_B,
>         XPAD_ABS_ANALOG_FACE_BTN_C,
>         XPAD_ABS_ANALOG_FACE_BTN_X,
>         XPAD_ABS_ANALOG_FACE_BTN_Y,
>         XPAD_ABS_ANALOG_FACE_BTN_Z,
>         XPAD_ABS_ANALOG_FACE_BTN_END, /* Must remain as the last element */
>    };
> 
> This would clean up both xpad_process_packet and xpad_set_up_abs a bit
> in my opinion. Your loop for xpad_set_up_abs would look like the
> following.
> 
>    enum xpad_abs_analog_face_btn btn;
> 
>    ...
> 
>    for (btn = XPAD_ABS_ANALOG_FACE_BTN_A; btn != XPAD_ABS_ANALOG_FACE_BTN_END; ++btn)
>            xpad_set_up_abs(input_dev, btn);

I agree, that looks cleaner.

Since it's a step closer to standardising a mapping for those analog buttons, I'd like to wait and see whether there is a consensus across drivers and maintainers. Maybe we can include something like this enum in input-event-codes.h and have a really clean solution.



Thanks!

Max

