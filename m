Return-Path: <linux-kernel+bounces-111770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C29458870C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6089E1F237B7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFCD5A4E9;
	Fri, 22 Mar 2024 16:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rAcq/Pr6"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7343D57876
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711124347; cv=none; b=mPcecRVBmpphR3kvkGKs/p4/jIiZJBnwQLz1zBG1JDffThPw1Hfb75pH3VC5XGY6IiOtJwi0e7/97mN0rjNzMpT1mYCi8IXDiZNquL57SeVm9OiimDagAdCCzaFB52SaTx5D7yXwzE3IRU5T0dffgmnrUsfjAD0VADFPBOGU3Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711124347; c=relaxed/simple;
	bh=0wUBpSj/pqvpH82jsIPmTuiXNyhBwsGyIhafpnlup6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caIwX4x8q1Yw9Z86Nvq2Br/RFNrHJBU4uKcsWf28LQCepq2JJlk4wr08dwGHUL7XmL1bBBFMocE+H93PqQLPGWLl8O2bKW5MJtES8yJQj6Lz35QQu8yvylEqYeu8Zh0ETatJEhzDF8xsbQ04DHLIZ4H61I6q3NeK6IJmZqey3SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rAcq/Pr6; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2dbf138f-5112-48e1-85a6-9e3ad84ec4a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711124341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KB5GftMYyC75xN2sRG0i/ixBELjpxJvza4IaI6qq1+0=;
	b=rAcq/Pr6acgADB2ZF7hpy57CL4pr5Hkb9gWfpeXR4lEYG85SU/XKXu/IApF7Y25mcQMjM5
	xgZWPtKC95rPVrPXF0K6vyByn2iKWAdzLWgM1zF8R4gtfH7/4ZWB65Ovz7dZjTMhiRCevr
	ahirJGR9OtB93xVSpOibVK6cMaAV4i4=
Date: Fri, 22 Mar 2024 12:18:57 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 5/8] drm: zynqmp_dp: Don't retrain the link in our IRQ
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Michal Simek <michal.simek@amd.com>, David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
 linux-arm-kernel@lists.infradead.org,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org
References: <20240319225122.3048400-1-sean.anderson@linux.dev>
 <20240319225122.3048400-6-sean.anderson@linux.dev>
 <ca4de45b-302c-4eea-bd6b-8c04e2ed89cb@ideasonboard.com>
 <53b2df23-d5ea-498b-a501-b64f753c0074@linux.dev>
 <0514ef71-5baa-4989-9b7d-8bd9526c4d8d@ideasonboard.com>
 <16ccf678-270c-4770-8cc9-f676b4fabf09@linux.dev>
 <1f27ce69-9ea6-4df4-9147-332d74febdf0@ideasonboard.com>
 <b2bef7f9-fe46-45d0-a09b-50777f71f43c@linux.dev>
 <d6a8bc5c-aed9-4ef4-adb2-dc171106b44b@ideasonboard.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <d6a8bc5c-aed9-4ef4-adb2-dc171106b44b@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/22/24 01:32, Tomi Valkeinen wrote:
> On 21/03/2024 21:17, Sean Anderson wrote:
>> On 3/21/24 15:08, Tomi Valkeinen wrote:
>>> On 21/03/2024 20:01, Sean Anderson wrote:
>>>> On 3/21/24 13:25, Tomi Valkeinen wrote:
>>>>> On 21/03/2024 17:52, Sean Anderson wrote:
>>>>>> On 3/20/24 02:53, Tomi Valkeinen wrote:
>>>>>>> On 20/03/2024 00:51, Sean Anderson wrote:
>>>>>>> Do we need to handle interrupts while either delayed work is being done?
>>>>>>
>>>>>> Probably not.
>>>>>>
>>>>>>> If we do need a delayed work, would just one work be enough which
>>>>>>> handles both HPD_EVENT and HPD_IRQ, instead of two?
>>>>>>
>>>>>> Maybe, but then we need to determine which pending events we need to
>>>>>> handle. I think since we have only two events it will be easier to just
>>>>>> have separate workqueues.
>>>>>
>>>>> The less concurrency, the better...Which is why it would be nice to do it all in the threaded irq.
>>>>
>>>> Yeah, but we can use a mutex for this which means there is not too much
>>>> interesting going on.
>>>
>>> Ok. Yep, if we get (hopefully) a single mutex with clearly defined fields that it protects, I'm ok with workqueues.
>>>
>>> I'd still prefer just one workqueue, though...
>>
>> Yeah, but then we need a spinlock or something to tell the workqueue what it should do.
> 
> Yep. We could also always look at the HPD (if we drop the big sleeps) in the wq, and have a flag for the HPD IRQ, which would reduce the state to a single bit.

How about something like

zynqmp_dp_irq_handler(...)
{
	/* Read status and handle underflow/overflow/vblank */

	status &= ZYNQMP_DP_INT_HPD_EVENT | ZYNQMP_DP_INT_HPD_IRQ;
	if (status) {
		atomic_or(status, &dp->status);
		return IRQ_WAKE_THREAD;
	}

	return IRQ_HANDLED;
}

zynqmp_dp_thread_handler(...)
{
	status = atomic_xchg(&dp->status, 0);
	/* process HPD stuff */
}

which gets rid of the workqueue too.

--Sean

