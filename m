Return-Path: <linux-kernel+bounces-100131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8EC879248
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2966283FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053E869D09;
	Tue, 12 Mar 2024 10:37:37 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8034735F18;
	Tue, 12 Mar 2024 10:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239856; cv=none; b=oXKnVHDC4Osb2TrNzidCJH7pKxtEfnWWY0/DSpf3Jq9WWd728677COlH+5KWvdpOq2Pls3aKFzFR/zRqgwni5jlri9w1ZBUhw/qHdII74Y97cfjHlnIjARAN/UEESWHR/WyURhzF8tb0GQsl9pnNidDZoPwzdnHOO73PhgpGKFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239856; c=relaxed/simple;
	bh=Zs/hC5awvf429dQdmQHC6GgeHsRiQtY2P1LueuJh0Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U9pcRG1Swoyzav1R0P9SNU+jYgq8yT4NZCBuBWIOAowfiKxetLzo85VskNTJq7zsedYt9/gm33CqqWZs/c3jqorJxyQUqz3ZbW1USj8paOGfOcXtrwmshdhwtGR3RHCB2SuNjA8vngCAfBL+5ekApInf2E4fYnDmN3Yn5TOoWS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F15AC433F1;
	Tue, 12 Mar 2024 10:37:33 +0000 (UTC)
Message-ID: <d49012ae-4e67-47d0-8e1b-7b0c4b118f7e@xs4all.nl>
Date: Tue, 12 Mar 2024 11:37:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
Content-Language: en-US
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Hans Verkuil <hans.verkuil@cisco.com>, mchehab@kernel.org,
 stanimir.k.varbanov@gmail.com, andersson@kernel.org,
 konrad.dybcio@linaro.org, bryan.odonoghue@linaro.org, agross@kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
 Dikshita Agarwal <quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <8bf182b1-e05f-0c90-a358-e5c8bf6bd430@quicinc.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <8bf182b1-e05f-0c90-a358-e5c8bf6bd430@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Vikash,

On 2/29/24 16:09, Vikash Garodia wrote:
> Hello All,
> 
> On 12/18/2023 5:01 PM, Dikshita Agarwal wrote:
>> This patch series introduces support for Qualcomm new video acceleration
>> hardware architecture, used for video stream decoding/encoding. This driver
>> is based on new communication protocol between video hardware and application
>> processor.
>> This driver comes with below capabilities:
>> - V4L2 complaint video driver with M2M and STREAMING capability.
>> - Supports H264, H265, VP9 decoders.
>> - Supports H264, H265 encoders.
>> This driver comes with below features:
>> - Centralized resource and memory management.
>> - Centralized management of core and instance states.
>> - Defines platform specific capabilities and features. As a results, it provides
>>   a single point of control to enable/disable a given feature depending on 
>>   specific platform capabilities.
>> - Handles hardware interdependent configurations. For a given configuration from
>>   client, the driver checks for hardware dependent configuration/s and updates
>>   the same.
>> - Handles multiple complex video scenarios involving state transitions - DRC,
>>   Drain, Seek, back to back DRC, DRC during Drain sequence, DRC during Seek
>>   sequence.
>> - Introduces a flexible way for driver to subscribe for any property with
>>   hardware. Hardware would inform driver with those subscribed property with any
>>   change in value.
>> - Introduces performance (clock and bus) model based on new hardware
>>   architecture.
>> - Introduces multi thread safe design to handle communication between client and
>>   hardware.
>> - Adapts encoder quality improvements available in new hardware architecture.
>> - Implements asynchronous communication with hardware to achieve better
>>   experience in low latency usecases.
>> - Supports multi stage hardware architecture for encode/decode.
>> - Output and capture planes are controlled independently. Thereby providing a
>>   way to reconfigure individual plane.
>> - Hardware packetization layer supports synchronization between configuration
>>   packet and data packet.
>> - Introduces a flexibility to receive a hardware response for a given command
>>   packet.
>> - Native hardware support of LAST flag which is mandatory to align with port
>>   reconfiguration and DRAIN sequence as per V4L guidelines.
>> - Native hardware support for drain sequence.
> 
> 1. We considered enhancing the venus driver to support iris functionality but
> concluded that the result would essentially be two parallel drivers implemented
> in the same folder.
> 2. Although the underlying hardware for venus and iris are quite similar, but
> there are other factors which brings the need of new driver:
>    a. the host firmware interface (HFI) changed between the two. Venus supports
> HFI protocol 1.0 while iris supports HFI protocol 2.0.
>    b. unlike HFI protocol 1.0, HFI protocol 2.0 is better aligned to V4L2 APIs.
>    c. iris driver modularize platforms, hardware variants, and states to extend
> it for any upcoming SOC. Thereby more extendable to newer SOCs in future.
>    d. Iris also supports many advanced features.
> 3. Based on the comments received on posted iris driver [1], we evaluated it
> further and to better align with the upstream standard and practices, we
> acknowledge that even though iris driver is the way forward, it would be ideal
> to bring in the Venus hardwares enabled in this driver.
> 4. Hence, we decided to rework iris driver to add support of HFI protocol 1.0 as
> well.
> 5. Initially we would start with adding support for one HFI protocol 1.0 based
> platform which would be SM8250.
> 6. SM8250 enablement on iris driver would be incremental, starting with basic
> decode for H264 codec.
> 7. In long-term, all venus supported platforms would be migrated to iris.
> 8. Iris driver and venus driver will co-exist till remaining supported targets
> also gets migrated to iris driver.
> 9. We would continue to support and maintain venus driver during this phased out
> approach.
> 
> Please share your thoughts on the above proposal.

I think this is a reasonable approach: the venus driver is quite old and it was
created when we were at more-or-less the same time also developing better codec
frameworks. So it is not quite up-to-date with all the latest requirements.

Starting with a clean slate for the iris driver and then add support for venus
platforms to the iris driver makes sense.

Just one serious concern: who will do the venus platform migration? Are there resources
available to do that work? Or is this just wishful thinking?

Regards,

	Hans

> 
> [1]
> https://patchwork.kernel.org/project/linux-media/cover/1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com/#25643473
> 
> Regards,
> Vikash
> 


