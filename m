Return-Path: <linux-kernel+bounces-155997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D827D8AFC81
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 01:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A97B21ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 23:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B803EA95;
	Tue, 23 Apr 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ahClngsK"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A94738DDD
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713914608; cv=none; b=LKbrKoiwjcfRr0F6TUo7AwtqGYD/OMWGqgXiyffzvy0182LR+8XJbMMb3eORsnL/ivgo+BmTRDjlQJvslN827pggDgh4oDjVyuvftxQCOzXb9hMlZEKQN1v9WbKIH6FhTEKLAxABJFAJNXdHYL0QEH8ZZUJsxfNgSRjxzAsLnMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713914608; c=relaxed/simple;
	bh=II2LKmMUfRHGigyBM+0jUGosvYh7g+30IT9IX31JEaQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=S+woBlzq9GzSu08f2uE+NDU2bpeoGXX8BQajPldyVLFjDuf3Q3rnmOh/24mVwc5lPD+a8cU8e061xdYxHpSM6VNp/u732a9+kjtvMH00mQtoLz8u12S09UMp5suNDZSnKJXVf+C2GWoUG0QwEKHZnG2V7TaF97+CbH0igFO4cDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ahClngsK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso4976083b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713914605; x=1714519405; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4fPhPzodWoubukPurArJ2bR3IF59JD7l2DLF4hJrn6Q=;
        b=ahClngsKDxob+1QlGxi0FH3PNCBUWpyN+FxvuJqvsrLkkN9we/+PzukmF+JOP8LPLt
         qP9BJriyLAzCfKogKTj3soFz7ZSstZaV31F6DxNEDMTecKTzIu78+xc6Jc+B93X75UoJ
         hk6S2rqinLeQqtgxYBhfvvYCyW8HG+MCZNyQpd3knH9M2ZNVWAD5TyxSXw7k6vHDWzil
         CIByFcSETurP284VPXoFzkwrqnO+jRMWQUtIM1781pjt47E7i46r49tgC4u6MdkojAME
         htTCbCCGnGnKnmJUWtGNmtSp/5VCt+Jyoxhi6bTNNDjWhwH8HmQU3dU7CXdKC6qUq33I
         fSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713914605; x=1714519405;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4fPhPzodWoubukPurArJ2bR3IF59JD7l2DLF4hJrn6Q=;
        b=ZT341AefGYCFxsxJUHLeUO3dGrjJuUIt6YZZA1RvA7ZtjBIuCfOeT05ZgtIRtnlRB5
         1oTGJPbg/KPsDT3qvTd35zYTh16mE5vMKMShjlL0tEQZwx0d2XktFq2TfJYgiZidx9bO
         QKrpuS1cFAvX6rmbBlJlhRouiM190criDMMtu4b4L+a5rrPO8zbvzjA4kfAbhslJFlGd
         GJkcE9ta9bppCjub0nSnR38yrIP8UO6Bv7iA4oYNGSorDKqn5XHPmuNjP1Jxm8TT7Ywl
         SdfgU1Q3e+9sqzTizTQOMuIHChv5ftWHQE8CziipLywANOf1cpRDV+1Gqm7oYcPPARl0
         +2AA==
X-Forwarded-Encrypted: i=1; AJvYcCV/lbx/ohYQroMs/88PSM8HMbLdiNSpWBxmTfjeJWkfr22FqSCsJ9T4xNWIdNupGKhBhCxt2NgsZiHpsaN4peBmXFmHpj34XNi8kAMU
X-Gm-Message-State: AOJu0Ywk5xl/UW5ewZ4ZiPnZ8aiVuJoKLOFm3jycpWOjUDyHa+9kiTa8
	UJnf3Uxb+JEnK7S97fPGhX2D1gWqabiAzu6RzCio13/UBAcmkFy7Lon+2j5bKg==
X-Google-Smtp-Source: AGHT+IHDSnAUGUcp3QRYoc9NHEyJSzo74CTkXVzfh+xkMWtkpyZ6YRXrTu69zOQPSoUR8e69dghRiQ==
X-Received: by 2002:a05:6a00:4f87:b0:6ea:b1f5:1134 with SMTP id ld7-20020a056a004f8700b006eab1f51134mr1291341pfb.27.1713914605197;
        Tue, 23 Apr 2024 16:23:25 -0700 (PDT)
Received: from [192.168.60.239] (159.21.83.34.bc.googleusercontent.com. [34.83.21.159])
        by smtp.gmail.com with ESMTPSA id p52-20020a056a0026f400b006ede45680a6sm10169011pfw.59.2024.04.23.16.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 16:23:24 -0700 (PDT)
Message-ID: <17192e0f-7f18-49ae-96fc-71054d46f74a@google.com>
Date: Tue, 23 Apr 2024 16:23:23 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Avichal Rakesh <arakesh@google.com>
Subject: Re: [PATCH 0/3] usb: gadget: uvc: allocate requests based on frame
 interval length and buffersize
To: Michael Grzeschik <mgr@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jayant Chowdhary <jchowdhary@google.com>, etalvala@google.com,
 Michael Riesch <michael.riesch@wolfvision.net>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <ZiWga5Kqno1ICv97@pengutronix.de>
 <dcad0089-4105-44bc-a2b4-3cfc6f44164b@google.com>
 <ZifEvUi9-E8M4dp8@pengutronix.de>
Content-Language: en-US
In-Reply-To: <ZifEvUi9-E8M4dp8@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/23/24 07:25, Michael Grzeschik wrote:
> Ccing:
> 
> Michael Riesch <michael.riesch@wolfvision.net>
> Thinh Nguyen <Thinh.Nguyen@synopsys.com>
> 
> On Mon, Apr 22, 2024 at 05:21:09PM -0700, Avichal Rakesh wrote:
>> On 4/21/24 16:25, Michael Grzeschik wrote:
>>> On Tue, Apr 09, 2024 at 11:24:56PM +0200, Michael Grzeschik wrote:
>>>> This patch series is improving the size calculation and allocation
>>>> of the uvc requests. Using the currenlty setup frame duration of the
>>>> stream it is possible to calculate the number of requests based on the
>>>> interval length.
>>>
>>> The basic concept here is right. But unfortunatly we found out that
>>> together with Patch [1] and the current zero length request pump
>>> mechanism [2] and [3] this is not working as expected.
>>>
>>> The conclusion that we can not queue more than one frame at once into
>>> the hw led to [1]. The current implementation of zero length reqeusts
>>> which will be queued while we are waiting for the frame to finish
>>> transferring will enlarge the frame duration. Since every zero-length
>>> request is still taking up at least one frame interval of 125 us.
>>
>> I haven't taken a super close look at your patches, so please feel free
>> to correct me if I am misunderstanding something.
>>
>> It looks like the goal of the patches is to determine a better number
>> and size of usb_requests from the given framerate such that we send exactly
>> nreqs requests per frame where nreqs is determined to be the exact number
>> of requests that can be sent in one frame interval?
> 
> It does not need to be the exact time, actually it may not be exact.
> Scattering the data over all requests would not leave any headroom for
> any latencies or overhead.

IIUC, patch 3/3 sets the number of requests to frameinterval / 125 us, 
which gives us the number of requests we can send in exactly one frame interval, 
and then sets the size of the request as max framesize / nreq, which means the 
frames will be evenly divided up into all available requests (with a little
fuzz factor here and there).

This effectively means that (assuming no other delays) one frame will take
~one frameinterval to be transmitted?

> 
>> As the logic stands, we need some 0-length requests to be circulating to
>> ensure that we don't miss ISOC deadlines. The current logic unconditionally
>> sends half of all allocated requests to be circulated.
>>
>> With those two things in mind, this means than video_pump can at encode
>> at most half a frame in one go, and then has to wait for complete
>> callbacks to come in. In such cases, the theoretical worst case for
>> encode time is
>> 125us * (number of requests needed per frame / 2) + scheduling delays
>> as after the first half of the frame has been encoded, the video_pump
>> thread will have to wait 125us for each of the zero length requests to
>> be returned.
>>
>> The underlying assumption behind the "queue 0-length requests" approach
>> was that video_pump encodes the frames in as few requests as possible
>> and that there are spare requests to maintain a pressure on the
>> ISOC queue without hindering the video_pump thread, and unfortunately
>> it seems like patch 3/3 is breaking both of them?
> 
> Right.
> 
>> Assuming my understanding of your patches is correct, my question
>> is: Why do we want to spread the frame uniformly over the requests
>> instead of encoding it in as few requests as possible. Spreading
>> the frame over more requests artificially increases the encode time
>> required by video_pump, and AFAICT there is no real benefit to it?
> 
> Thinh gave me the advise that it is better to use the isoc stream
> constantly filled. Rather then streaming big amounts of data in the
> beginning of an frameinterval and having then a lot of spare time
> where the bandwidth is completely unsused.
> 
> In our reallife scenario streaming big requests had the impact, that
> the dwc3 core could not keep up with reading the amount of data
> from the memory bus, as the bus is already under heavy load. When the
> HW was then not able to transfer the requested and actually available
> amount of data in the interval, the hw did give us the usual missed
> interrupt answer.
> 
> Using smaller requests solved the problem here, as it really was
> unnecessary to stress the memory and usb bus in the beginning as
> we had enough headroom in the temporal domain.

Ah, I see. This was not a consideration, and it makes sense if USB
bus is under contention from a few different streams. So the solution
seems to be to spread the frame of as many requests as we can transmit 
in one frameinterval?

As an experiment, while we wait for others to respond, could you try 
doubling (or 2.5x'ing to be extra safe) the number of requests allocated
by patch 3/3 without changing the request's buffer size? 

It won't help with the error reporting but should help with ensuring
that frames are sent out in one frameinterval with little to no
0-length requests between them.

The idea is that video_pump will have enough requests available to fully 
encode the frame in one burst, and another frame's worth of request will be 
re-added to req_free list for video_pump to fill up in the time that the next 
frame comes in.

> 
> Which then led to the conclusion that the number of needed requests
> per image frame interval is calculatable since we know the usb
> interval length.
> 
> @Thinh: Correct me if I am saying something wrong here.
> 
>>> Therefor to properly make those patches work, we will have to get rid of
>>> the zero length pump mechanism again and make sure that the whole
>>> business logic of what to be queued and when will only be done in the
>>> pump worker. It is possible to let the dwc3 udc run dry, as we are
>>> actively waiting for the frame to finish, the last request in the
>>> prepared and started list will stop the current dwc3 stream and  for
>>> no underruns will occur with the next ep_queue.
>>
>> One thing to note here: The reason we moved to queuing 0-length requests
>> from complete callback was because even with realtime priority, video_pump
>> thread doesn't always meet the ISOC queueing cadence. I think stopping and
>> starting the stream was briefly discussed in our initial discussion in
>> https://lore.kernel.org/all/20230419001143.pdxflhzyecf4kvee@synopsys.com/
>> and Thinh mentioned that dwc3 controller does it if it detects an underrun,
>> but I am not sure if starting and stopping an ISOC stream is good practice.
> 
> The realtime latency aspect is not an issue anymore if we ensure that we
> always keep only one frame in the hw ring buffer. When the pump worker
> ensure that it will always run through one full frame the scheduler has
> no chance to break our running dwc3 stream. Since the pump is running
> under a while(1) this should be possible.

I'll wait for your patch to see, but are you saying that we should have the 
pump worker busy spinning  when there are no frames available? Cameras cannot
produce frames fast enough for video_pump to be constantly encoding frames. 
IIRC, "encoding" a frame to usb_requests took less than a ms or two on my 
device, and frame interval is 33ms for a 30fps stream, so the CPU would be
busy spinning for ~30ms which is an unreasonable time for a CPU to be
idling.

> 
> Also with the request amount precalculation we can always encode the
> whole frame into all available requests and don't have to wait for
> requests to be available again.
> 
> Together with the latest knowladge about the underlying hw we even need to only
> keep one frame in the HW ring buffer. Since we have some interrupt latency,
> keeping more frames in the ring buffer, would mean that we are not able to tag
> the currently streamed frame properly as errornous if the dwc3 hw ring buffer
> is already telling the host some data about the next frame. And as we already
> need to wait for the end of the frame to finish, based on the assumption that
> only one frame is enqueued in the ring buffer the hw will stop the stream and
> the next requst will start a new stream. So there will no missed underruns be
> happening.
> 
> So the main fact here is, that telling the host some status about a
> frame in the past is impossible! Therefor the first request of the next
> hw stream need to be the one that is telling the Host if the previous frame
> is ment to be drawn or not.

This is a fair point, but the timing on this becomes a little difficult if 
the frame is sent over the entire frameinterval. If we wait for the entire 
frame to be transmitted, then we have 125us between the last request of a 
frame being transmitted and the first request of the next frame being 
queued. The userspace app producing the frames will have timing variations
larger than 125us, so we cannot rely on a frame being available exactly as
one frame is fully transmitted, or of us being notified of transmission
status by the time the next frame comes in.

> 
>> Someone better versed in USB protocol can probably confirm, but it seems
>> somewhat hacky to stop the ISOC stream at the end of the frame and restart
>> with the next frame.
> 
> All I know is that the HW mechanism that is reading from the trb ring buffer is
> started or stopped I don't know if really the ISOC stream is stopped and
> restarted here or what that means on the real wire. And if so, I am unsure if
> that is really a problem or not. Thinh?

Oh? That's great! If the controller can keep the ISOC stream from underruning
without the gadget feeding it 0-length requests, then we can simplify the 
gadget side implementation quite a bit!


Regards,
Avi.

