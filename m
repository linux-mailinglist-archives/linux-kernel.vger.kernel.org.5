Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52307762FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:29:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjGZI3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbjGZI2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C6344A3;
        Wed, 26 Jul 2023 01:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F078617FE;
        Wed, 26 Jul 2023 08:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927E7C433C7;
        Wed, 26 Jul 2023 08:18:44 +0000 (UTC)
Message-ID: <0b5717cb-8f30-c38c-f20e-e8a81d29423a@xs4all.nl>
Date:   Wed, 26 Jul 2023 10:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
Content-Language: en-US
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>
Cc:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <ZK2NiQd1KnraAr20@aptenodytes>
 <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <c46d0c53b7e5dc8dcdf7925f3d892024390a8b2b.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 20:18, Nicolas Dufresne wrote:
> Le mardi 11 juillet 2023 à 19:12 +0200, Paul Kocialkowski a écrit :
>> Hi everyone!
>>
>> After various discussions following Andrzej's talk at EOSS, feedback from the
>> Media Summit (which I could not attend unfortunately) and various direct
>> discussions, I have compiled some thoughts and ideas about stateless encoders
>> support with various proposals. This is the result of a few years of interest
>> in the topic, after working on a PoC for the Hantro H1 using the hantro driver,
>> which turned out to have numerous design issues.
>>
>> I am now working on a H.264 encoder driver for Allwinner platforms (currently
>> focusing on the V3/V3s), which already provides some usable bitstream and will
>> be published soon.
>>
>> This is a very long email where I've tried to split things into distinct topics
>> and explain a few concepts to make sure everyone is on the same page.
>>
>> # Bitstream Headers
>>
>> Stateless encoders typically do not generate all the bitstream headers and
>> sometimes no header at all (e.g. Allwinner encoder does not even produce slice
>> headers). There's often some hardware block that makes bit-level writing to the
>> destination buffer easier (deals with alignment, etc).
>>
>> The values of the bitstream headers must be in line with how the compressed
>> data bitstream is generated and generally follow the codec specification.
>> Some encoders might allow configuring all the fields found in the headers,
>> others may only allow configuring a few or have specific constraints regarding
>> which values are allowed.
>>
>> As a result, we cannot expect that any given encoder is able to produce frames
>> for any set of headers. Reporting related constraints and limitations (beyond
>> profile/level) seems quite difficult and error-prone.
>>
>> So it seems that keeping header generation in-kernel only (close to where the
>> hardware is actually configured) is the safest approach.
> 
> This seems to match with what happened with the Hantro VP8 proof of concept. The
> encoder does not produce the frame header, but also, it produces 2 encoded
> buffers which cannot be made contiguous at the hardware level. This notion of
> plane in coded data wasn't something that blended well with the rest of the API
> and we didn't want to copy in the kernel while the userspace would also be
> forced to copy to align the headers. Our conclusion was that it was best to
> generate the headers and copy both segment before delivering to userspace. I
> suspect this type of situation will be quite common.
> 
>>
>> # Codec Features
>>
>> Codecs have many variable features that can be enabled or not and specific
>> configuration fields that can take various values. There is usually some
>> top-level indication of profile/level that restricts what can be used.
>>
>> This is a very similar situation to stateful encoding, where codec-specific
>> controls are used to report and set profile/level and configure these aspects.
>> A particularly nice thing about it is that we can reuse these existing controls
>> and add new ones in the future for features that are not yet covered.
>>
>> This approach feels more flexible than designing new structures with a selected
>> set of parameters (that could match the existing controls) for each codec.
> 
> Though, reading more into this emails, we still have a fair amount of controls
> to design and add, probably some compound controls too ?

I expect that for stateless encoders support for read-only requests will be needed:

https://patchwork.linuxtv.org/project/linux-media/list/?series=5647

I worked on that in the past together with dynamic control arrays. The dynamic
array part was merged, but the read-only request part wasn't (there was never a
driver that actually needed it).

I don't know if that series still applies, but if there is a need for it then I
can rebase it and post an RFCv3.

Regards,

	Hans
