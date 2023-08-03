Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BF476EF41
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 18:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbjHCQRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 12:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjHCQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 12:17:09 -0400
Received: from kozue.soulik.info (kozue.soulik.info [IPv6:2001:19f0:7000:8404:5400:ff:fe00:d7d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3253C1F;
        Thu,  3 Aug 2023 09:16:59 -0700 (PDT)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 5F27830655C;
        Fri,  4 Aug 2023 01:16:29 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 5F27830655C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1691079393; bh=2cRhygiJP5Ea8at7WCEJOX/seT0t5ZCVIJQiiVgTye8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RwcIFxkmdqxOmD7qQFp4NXbbgfhmgargeAW3z7leK46sUduca52bOTGMg6O6UKVQ1
         TbKRNaP5EhtLY6scwEVKOKjmaT+PeeaTdCm8LT2GGhw1rUkeytEx7J+AuFqXAA7Kpq
         iJYSUNRNG6Z/TfzyGw8ITKEv02kkJpvhZSDsz5wc=
Message-ID: <585fdf97-4ed9-7d9a-78a8-e271d5b05301@soulik.info>
Date:   Fri, 4 Aug 2023 00:16:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] media: v4l2-mem2mem: add a list for buf used by hw
To:     Nicolas Dufresne <nicolas@ndufresne.ca>
Cc:     linux-media@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>,
        Hsia-Jun Li <Randy.Li@synaptics.com>, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com, hiroh@chromium.org,
        hans.verkuil@cisco.com, hverkuil@xs4all.nl,
        linux-kernel@vger.kernel.org,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        p.zabel@pengutronix.de, ezequiel@vanguardiasur.com.ar,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
References: <20230704040044.681850-1-randy.li@synaptics.com>
 <20230704040044.681850-3-randy.li@synaptics.com>
 <20230712093301.nkj2vok2x7esdhb3@chromium.org>
 <f8f766c0166c502e29b06cda71f6531e44a91a17.camel@ndufresne.ca>
 <CAAFQd5CO4TS6wMsnaL7ob4CXogj5KT52x85YUUN1ZwDkOxW0oQ@mail.gmail.com>
 <583e22718b80cc5e1ae631528c83c95e97de5cae.camel@ndufresne.ca>
 <CAAFQd5CAJ7GxiY5=bBAa+L=1WJth6QZ3+PG83=GX+eEx1S4uhg@mail.gmail.com>
 <7d340df3-e14c-24de-4fc2-b7dca619447c@synaptics.com>
 <CAAFQd5BKHQPNVpDvpQaFn-q721BJknJCUB72urc2=EKsAH=OCg@mail.gmail.com>
 <10ad26e6-b2d0-d0e6-40c8-2cc70613188b@synaptics.com>
 <70ed7b3197f34c9f3dce9c83c527884c89df5449.camel@ndufresne.ca>
Content-Language: en-US
From:   Randy Li <ayaka@soulik.info>
In-Reply-To: <70ed7b3197f34c9f3dce9c83c527884c89df5449.camel@ndufresne.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/7/29 00:19, Nicolas Dufresne wrote:
> Le vendredi 28 juillet 2023 à 15:37 +0800, Hsia-Jun Li a écrit :
>>> I think this is one reason to migrate to the stateless decoder design.
>>>
>> I didn't know such plan here. I don't think the current stateless API
>> could export the reconstruction buffers for encoder or post-processing
>> buffer for decoder to us.
> Someone suggested introduce auxiliary queues in our meeting in Lyon a while ago,
> but I bet everyone got too busy with finalizing APIs, fixing fluster tests etc.
> The suggestion felt like it would be possible to add it after the fact. This was
> also being discussed in the context of supporting multi-scalers (standalone our
> inline with the codec, like VC8000D+). It could also cover for primary and
> secondary buffers, along with encoder primary, and reconstruction buffers, but
> also auxiliary reference data. This would also be needed to properly support
> Vulkan Video fwiw, and could also help with a transition to DMABuf Heaps and
> memory accounting.
>
> I've also had corridor discussion around having multi-instance media constroller
> devices. It wasn't clear how to bind the media instance to the video node
> instances, but assuming there is a way, it would be a tad more flexible (but
> massively more complex).

I think we should answer to those questions before we decided what we want:

A. Should a queue only has the buffers for the same format and sizes?

B. How does an application handle those drivers requests additional queue?

C. How to sync multiple buffers in a v4l2 job.

I asked the same question A when I discuss this with media: v4l2: Add 
DELETE_BUF ioctl.

If we would not add extra queue here, how does the driver filter out the 
most proper buffer for the current hardware output(CAPTURE) buffer.

If we have multiple queues in a direction, how to make driver select 
between them?


The question B is the debt we made, some applications have gotten used 
to the case they can't control the lifetime of reconstruction buffer in 
encoding or turn the post-processing off when the display pipeline could 
support tile format output.

We know allow the userspace could decide where we allocate those 
buffers, but could the userspace decided not to handle their lifetime?


The question C may more be more related to the complex case like camera 
senor and ISP. With this auxiliary queue, multiple video nodes are not 
necessary anymore.

But ISP may not request all the data finish its path, ex. the ISP are 
not satisfied with the focus point that its senor detected or the light 
level, it may just drop the image data then shot again.

Also the poll event could only tell us which direction could do the 
dequeue/enqueue work, it can't tell us which queue is ready. Should we 
introduce something likes sync point(fence fd) here?


We may lead way to V4L3 as Tomasz suggested although I don't want to 
take the risk to be. If we would make a V4L3 like thing, we have better 
to decide it correct and could handle any future problem.

>
> Nicolas
>
