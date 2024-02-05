Return-Path: <linux-kernel+bounces-53255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA46484A2BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282501F23116
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A168482F4;
	Mon,  5 Feb 2024 18:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YmBn/Iqd"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306FA481AE
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159143; cv=none; b=LKmjULdrEnd+K3TL+fn0EBkNfK9Ft6o77UbdA3fbMwuoBxc0FfWhhXzZbjLRZuvLSPLLVrPMIQkHdmckc2lLOicW6n5uqltq9vQDsNYhCJ6RzrM59KinBOuzx2zpwnEtvfjPYWQkoUqDZIDalbRAElZvImf9JJF4/ps1XCqtWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159143; c=relaxed/simple;
	bh=N6bcpMAjEj2Ii2GBiFyYQTkR2a8PxPV9BNCa2EMYar8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TnRJlzpefobb0iMQdVImdaoFSPOAl2VF7ibiWD/yketrHm7mvvxmEEkhd1tL1IPYfCtfkCFAiCDYNttNFbPbvjrAmzeW2sZ25y2R8efWTOs28JB2lLOWnbyOvtiGT/zSXOJ3fWRUNKfelrxFzsvz5x/QOfUej2OpHfgRvMzFbXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YmBn/Iqd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d74045c463so37136665ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 10:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1707159141; x=1707763941; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gm5nF+Ib1GZJbXhttQ2EDUkDbPD2meblIVg5Bzrb2Js=;
        b=YmBn/IqdzV2isIHt513WkVZ+1AAkPDY7cO7hxpEt6nmdTZmzdmqA08hsgfNO9kl4ku
         DixapFVoaidBHoG9DIh0rGrlv+ThL+vV7eDrpfqgipN/O8B2ikNJkcp5XA7AJoBcv+6g
         wF6eURN7Fvg4As4X7inYXhpwJ6R0aWS/jAZiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707159141; x=1707763941;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gm5nF+Ib1GZJbXhttQ2EDUkDbPD2meblIVg5Bzrb2Js=;
        b=IYu7JapwH5ZbI0afSgRk00viRNQegzHSclpOa8ybLWTmJhZqOMLu79PYto0dY/BriT
         viOZGrixEu3TzkK1USUzztXXWbQ3p87gHvZatgF6C+kRCZvI1cL+zTxNiUiZPQqK9ikl
         oqDbQSZQ7/bAdRgQtnKgHTNWs+M9oemRI0ocweNueMLRDFU/JRDnblwYcyjQSv4ta80t
         boeHvPq489yQp8tX9IQquoDGVf5EA15qvwUnWQFiB5BpcL7Et5IJAmhqj34FVVmVz0AN
         PUa13L6pKy3qJumYwO8LxhiFPXUKYUu7eyhkygheKIfiquKjc7T9yj2vsffWaagFrTXz
         xDxA==
X-Gm-Message-State: AOJu0YwHnBll4mOUemk7KqhwC6vT40ZjdzCTxSHAWNGN/7UN8ANtq2hX
	oAiA0DcHq15Fvsba464NooZg0eohV67kCMWGy8cfUTXN0DLguozTls1GKCfFZew=
X-Google-Smtp-Source: AGHT+IHlCw3Q4N09cK+PMPKqJ0gL6iaZJAqCwUasGmC3wGn4JqNcSkKbWW/HZ8LyGxxMm0MAmM12VQ==
X-Received: by 2002:a17:903:2344:b0:1d9:a91b:778 with SMTP id c4-20020a170903234400b001d9a91b0778mr389569plh.30.1707159141618;
        Mon, 05 Feb 2024 10:52:21 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWp05gLEZzPQhZmatIC3ylxldcXYbo9nqi5O50OF2oTkUEzASs2pijAZrDesn4G+hqfs2yjGsYCYAASmC2kLUXmJ/CuYu0TA5VovJfAwWxSTAoDYBRF7vTvDAv7yVbvuMH+vxl5zinuAbEv566ubDiedsjuGIhjYt1AiEeACp3DYt3/8GNlTMyxlFoacsnkaGW7Zf5phfc9IRZcuv8NMwpF3TjPCcNdbNdqDm6fzVnjCrzlFquR6ixj1ccENBp5V1fGPzHyKj7Vk26LuiMhpcUBsyRovJLtjg6l7uG8ASMji3jfKd8fHB0MPVKL9Yae61N/CGVitB7NA17A4X+JRSihYKApsWKanGyI1tkZVTYuA6YxmEcJjNBvFXz3wiFMaBxEm5yr8Hl2l7rNz4IRN7JtsjgiObp2XknylAnum9nSY+bLJMwHD6YhIp4OLL+qVw==
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902eb4600b001d8ffc059e3sm197995pli.119.2024.02.05.10.52.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Feb 2024 10:52:21 -0800 (PST)
Date: Mon, 5 Feb 2024 10:52:18 -0800
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <sdf@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, sridhar.samudrala@intel.com,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, chuck.lever@oracle.com,
	jlayton@kernel.org, linux-api@vger.kernel.org, brauner@kernel.org,
	davem@davemloft.net, alexander.duyck@gmail.com,
	Wei Wang <weiwan@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>
Subject: Re: [net-next 0/3] Per epoll context busy poll support
Message-ID: <20240205185217.GC10463@fastly.com>
References: <CANn89i+YKwrgpt8VnHrw4eeVpqRamLkTSr4u+g1mRDMZa6b+7Q@mail.gmail.com>
 <5faf88de-5063-421f-ad78-ad24d931fd17@intel.com>
 <20240202032806.GA8708@fastly.com>
 <f0b4d813-d7cb-428b-9c41-a2d86684f3f1@intel.com>
 <20240202102239.274ca9bb@kernel.org>
 <20240202193332.GA8932@fastly.com>
 <20240202115828.6fd125bf@kernel.org>
 <20240202202344.GA9283@fastly.com>
 <20240202171539.7347cb01@kernel.org>
 <ZcEmDz3UvAksHFFG@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcEmDz3UvAksHFFG@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Mon, Feb 05, 2024 at 10:17:03AM -0800, Stanislav Fomichev wrote:
> On 02/02, Jakub Kicinski wrote:
> > On Fri, 2 Feb 2024 12:23:44 -0800 Joe Damato wrote:
> > > > Did you see SO_PREFER_BUSY_POLL by any chance? (In combination with
> > > > gro_flush_timeout IIRC). We added it a while back with Bjorn, it seems
> > > > like a great idea to me at the time but I'm unclear if anyone uses it 
> > > > in production..  
> > > 
> > > I have seen it while reading the code, yes. I think maybe I missed
> > > something about its interaction with gro_flush_timeout. In my use case,
> > > the machine has no traffic until after the app is started.
> > > 
> > > In this case, I haven't needed to worry about regular NAPI monopolizing the
> > > CPU and preventing busy poll from working.
> > > 
> > > Maybe I am missing something more nuanced, though? I'll have another look
> > > at the code, just incase.
> > 
> > We reused the gro_flush_timeout as an existing "user doesn't care if
> > packets get delayed by this much in worst case" value. If you set
> > SO_PREFER_BUSY_POLL the next time you busy pool the NAPI will be marked 
> > as "already scheduled" and a timer is set (to gro_flush_timeout).
> > If NIC IRQ fires before gro_flush_timeout it gets ignored, because NAPI
> > is already marked as scheduled.
> > If you busy poll again the timer gets postponed for another
> > gro_flush_timeout nsec.
> > If timer fires we go back to normal NAPI processing.
> > 
> > The idea is that you set gro_flush_timeout to some high value, like 
> > 10 msec, and expect your app to poll more often than every 10 msec. 
> > 
> > Then the normal NAPI processing will never kick in, and there will 
> > be only 1 NIC IRQ after which the HW IRQ remains masked.
> > With high coalescing timer you technically still get an IRQ every
> > so often and interrupt the app. Worst case (UDP flood) you may even
> > get into an overload where the app gets starved out completely..
> 
> Should we also add prefer_busy_poll parameter to EPIOCSPARAMS?
> napi_busy_loop in ep_busy_loop has its prefer_busy_poll argument
> hard-coded as false.

I think making this configurable is a good idea. I can add that in the v6
in addition to fixing the incorrect commit message in patch 1/3.

What do you think, Jakub?

