Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0230D78DE72
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbjH3TCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343772AbjH3Qvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 12:51:45 -0400
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1612B19A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 09:51:40 -0700 (PDT)
Received: from [192.168.10.7] (unknown [10.0.12.132])
        by kozue.soulik.info (Postfix) with ESMTPSA id 94C17300258;
        Thu, 31 Aug 2023 01:51:33 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 kozue.soulik.info 94C17300258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulik.info; s=mail;
        t=1693414296; bh=/p9VbuiL48VdjIKgkEFVOwtf0FRTsbtp/z+i1lPIXp4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iOG+SETOO2liVEdglTsDBAsW0Y93hYVT8hy0hjuMXEyzPcVkUrSMbacRWuYnPDiDu
         w6849G+MeYHtGkbZXKqwOE4tTS+7UR9AprY+0uMCtqWlT6DEWoh3S/eF76I1xV1i22
         e97JjPwyom0slXk7kvtj7XrFwBPF/4sGuOosTfJs=
Message-ID: <e9f01000-d2ed-8193-420c-fb80f0b96f8f@soulik.info>
Date:   Thu, 31 Aug 2023 00:51:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Stateless Encoding uAPI Discussion and Proposal
To:     Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Hsia-Jun Li <Randy.Li@synaptics.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Michael Tretter <m.tretter@pengutronix.de>,
        =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <ZK2NiQd1KnraAr20@aptenodytes> <ZNTp1e4gJ2zeYmS-@aptenodytes>
 <a2e8e01ea754232dd3562b34702b6600d7358605.camel@collabora.com>
 <ZNaVQ-zxIuCpGGha@aptenodytes>
 <720c476189552596cbd61dd74d6fa12818718036.camel@collabora.com>
 <39270c5e-24ab-8ff6-d925-7718b1fef3c4@synaptics.com>
 <a0fa6559c3933a5a4c8b7502282adae3429e0b57.camel@collabora.com>
 <52e9b710-5011-656b-aebf-8d57e6496ddd@synaptics.com>
 <4d08d98d853d78bbb6dba826d30c3386fe0b31e8.camel@collabora.com>
Content-Language: en-US
From:   Randy Li <ayaka@soulik.info>
In-Reply-To: <4d08d98d853d78bbb6dba826d30c3386fe0b31e8.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/8/30 23:10, Nicolas Dufresne wrote:
> CAUTION: Email originated externally, do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> Le mercredi 23 août 2023 à 11:04 +0800, Hsia-Jun Li a écrit :
>>> Though, if we drop the GOP structure and favour this approach, the latency could
>>> be regain later by introducing fence base streaming. The technique would be for
>>> a video source (like a capture driver) to pass dmabuf that aren't filled yet,
>>> but have a companion fence. This would allow queuing requests ahead of time, and
>>> all we need is enough pre-allocation to accommodate the desired look ahead. Only
>>> issue is that perhaps this violates the fundamental of "short term" delivery of
>>> fences. But fences can also fail I think, in case the capture was stopped.
>>>
>> I don't think it would help. Fence is a thing for DRM/GPU without a queue.
>> Even with a fence, would the video sink tell us the motion delta here?
> It helps with the latency since the encoder can start its search and analyzes as
> soon as frames are available, instead of until you have all N frames available
> (refer to the MIN_BUFFER_FOR controls used when lookahead is needed).

I think the fence in GPU is something attached to per frame 
buffer(IN_FENCE) or completing the render(OUT_FENCE).

So when we enqueue a buffer, what are expecting from the fence?

I think in KMS, you can't enqueue two buffers for the same plane, you 
have to wait the OUT_FENCE.

>
>>> We can certainly move forward with this as a future solution, or just don't
>>> implement future aware RC algorithm in term to avoid the huge task this involves
>>> (and possibly patents?)
>>>
>> I think we should not restrict how the userspace(vendor) operate the
>> hardware.
> Omitting is not restricting. Vendors have to learn to be community members and
> propose/add the tools and APIs they need to support their features. We cannot
> fix vendors in this regard, those who jumps over that fence are wining.

That is not about what vendor would do. I was thinking we are planning 
how we manage the lifetime of the reconstruction buffer, reference 
selecting based on a simple GOP model.
What was designed here would become a barrier for a vendor whose 
hardware has a little capability than this.

All I want to do here is offer my ideas about how we could achieve an 
open interfaces that could cover the future need.

Especially it is hard to expand the V4L2 uAPIs.

>
> Nicolas
