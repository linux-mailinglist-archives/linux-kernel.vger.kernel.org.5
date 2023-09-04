Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CEB7911FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242393AbjIDHXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjIDHXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:23:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AAF99;
        Mon,  4 Sep 2023 00:23:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 45EC7CE0E16;
        Mon,  4 Sep 2023 07:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504BBC433C8;
        Mon,  4 Sep 2023 07:23:06 +0000 (UTC)
Message-ID: <ff0475f0-b48e-ad5d-ae66-54308bf98464@xs4all.nl>
Date:   Mon, 4 Sep 2023 09:23:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5] media: gspca: cpia1: shift-out-of-bounds in
 set_flicker
To:     Rajeshwar Shinde <coolrrsh@gmail.com>, mchehab@kernel.org,
        slark_xiao@163.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com
References: <20230830074401.7696-1-coolrrsh@gmail.com>
 <CA+VNjV0pkR7w5Z_z8wS8WxckfSJ43sN8rGkWO6nxzYNHL4U46Q@mail.gmail.com>
Content-Language: en-US, nl
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <CA+VNjV0pkR7w5Z_z8wS8WxckfSJ43sN8rGkWO6nxzYNHL4U46Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relax :-) I'll pick it up the next time I go through simple bug fix patches
like this one, probably in 2-3 weeks or so.

Regards,

	Hans

On 02/09/2023 19:56, Rajeshwar Shinde wrote:
> Remainder 
> 
> On Wed, 30 Aug, 2023, 1:14 pm , <coolrrsh@gmail.com <mailto:coolrrsh@gmail.com>> wrote:
> 
>     From: Rajeshwar R Shinde <coolrrsh@gmail.com <mailto:coolrrsh@gmail.com>>
> 
>     Syzkaller reported the following issue:
>     UBSAN: shift-out-of-bounds in drivers/media/usb/gspca/cpia1.c:1031:27
>     shift exponent 245 is too large for 32-bit type 'int'
> 
>     When the value of the variable "sd->params.exposure.gain" exceeds the
>     number of bits in an integer, a shift-out-of-bounds error is reported. It
>     is triggered because the variable "currentexp" cannot be left-shifted by
>     more than the number of bits in an integer. In order to avoid invalid
>     range during left-shift, the conditional expression is added.
> 
> 
>     Reported-by: syzbot+e27f3dbdab04e43b9f73@syzkaller.appspotmail.com <mailto:syzbot%2Be27f3dbdab04e43b9f73@syzkaller.appspotmail.com>
>     Closes: https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com <https://lore.kernel.org/all/20230818164522.12806-1-coolrrsh@gmail.com>
>     Link: https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73
>     Signed-off-by <https://syzkaller.appspot.com/bug?extid=e27f3dbdab04e43b9f73Signed-off-by>: Rajeshwar R Shinde <coolrrsh@gmail.com <mailto:coolrrsh@gmail.com>>
>     ---
>     v1->v2
>     Changed the patch. Instead of avoiding shift operation for invalid
>     input of 'exposure.gain', throw an error for invalid range.
>     v2->v3
>     Changed the commit message details
>     v3->v4
>     Removed the trailing spaces in commit message
>     v4->v5
>     Replaced the hardcoded value with inbuilt macro
>     ---
>      drivers/media/usb/gspca/cpia1.c | 3 +++
>      1 file changed, 3 insertions(+)
> 
>     diff --git a/drivers/media/usb/gspca/cpia1.c b/drivers/media/usb/gspca/cpia1.c
>     index 46ed95483e22..5f5fa851ca64 100644
>     --- a/drivers/media/usb/gspca/cpia1.c
>     +++ b/drivers/media/usb/gspca/cpia1.c
>     @@ -18,6 +18,7 @@
> 
>      #include <linux/input.h>
>      #include <linux/sched/signal.h>
>     +#include <linux/bitops.h>
> 
>      #include "gspca.h"
> 
>     @@ -1028,6 +1029,8 @@ static int set_flicker(struct gspca_dev *gspca_dev, int on, int apply)
>                             sd->params.exposure.expMode = 2;
>                             sd->exposure_status = EXPOSURE_NORMAL;
>                     }
>     +               if (sd->params.exposure.gain >= BITS_PER_TYPE(currentexp))
>     +                       return -EINVAL;
>                     currentexp = currentexp << sd->params.exposure.gain;
>                     sd->params.exposure.gain = 0;
>                     /* round down current exposure to nearest value */
>     -- 
>     2.25.1
> 

