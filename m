Return-Path: <linux-kernel+bounces-61540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DEFC85137A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C26EE1C216A9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BA139FE9;
	Mon, 12 Feb 2024 12:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HzxojYNF"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359A739FC0
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707740568; cv=none; b=KWfaLTUQ4YrDfcsb6k6JvN/5NNt5GpWLRZMtnIog2o6tCh/1PvGrkRiydrb2rGLZLRwGL75Hj77jnkMRVwTeaiXsIZyMEZEPyfHuISJ2qDMr/cEHUa529PFTz2K1JG8WiABVT7VQKgBsBspXQCduMPLzXFlT788eFemPNzeZLi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707740568; c=relaxed/simple;
	bh=qR9lDFDeKPAo0DiFqn/cvL6ikhz+xZCI83InXXUT9Us=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D21sC8tU3cC5CeVG41ZHaXCxPfpmcmhyaJ3vAuHdTFl9Ehr3fwSH6lbG7JBOmbQSgRh8guk1+Zky1qQTFHphc1H1gmeJna3avPZL+qSQ9QCUxvuBM6jdTkr4PbIS6fap7SRomjvi+v/oooXpmWVnDfx5TBCAWaGVsRWFJCjR1J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HzxojYNF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-410cb9315f6so6900835e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707740564; x=1708345364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VSmpE+8yO23g+6K8r9vt9Aj1csyqHY8mxoubaVkXygM=;
        b=HzxojYNFva6BC1gaeAGmjBHhoHb0EbJddMQK9L0VGx0kd1LuYYoMDeLuDU3quxQAn+
         IIZ3qDHaSP3abc6rPpsx7WhP9ZMQdOpXvmMWJqHcypnNDim/WKRjfq/Ip79UlsEFVLUW
         GUp3pfefI8LLmvHN7jqfxvxoaJ0JIe4AzKS5GaiRhCENGTefSn9v9/fcrbyFIOCFkpNb
         jL2tec/iLpDElwKBns69B7ikv6NLzq4fd3YT7QGHpAOtD4uuwRW7v5vyqUNUXTLB7fC0
         SOg5Nz2pduo1mLfNcgN6t+t691aOhAlMC1885YqUs63XR0/PRhmpTgVU0RaRp2GxswTr
         wvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707740564; x=1708345364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VSmpE+8yO23g+6K8r9vt9Aj1csyqHY8mxoubaVkXygM=;
        b=ivb46K3rd1HIvet/qoi1vjOts0zwoz5v7Ke20InkM0qHfxJoaVzB60znt/aJbazQdA
         5l3AwbIoCVATu/l4wutNMvkkumYK/1DQRySzBcaxtSB5rmSGMVlz9pz2gbZUAR41JVUt
         DAdJodZXGeg3TLi6iBklkblI8jieXZOSDPa9bEAzpxuyV2CMeI82pJkqKNgjJfucZdJX
         WzUeL14Pgklu6ObeZ9sHKPJcpJ2OfoFc8udK6RwV6W4NePiFs2jyD5OBTvYzOqA23UDz
         UhcsnW+JCEsmb4OVtF3JTjQakVMNvYyABt176y2ORaiH3lK+qd/f8eMKSWHpUFsiesL1
         n+Ig==
X-Gm-Message-State: AOJu0YzaitVHBddWeAyN2ge7wO5VIi0EHIcyblt0z2gO3BM8HDylPLPJ
	9pbRLVwa2AWYsUzOmR3U1C3uyMkUqQfzNxdytnFRnCpX1+4OjixtCTqvPLqlQdo=
X-Google-Smtp-Source: AGHT+IEMZeyONDchq2UzhKfL03sb3Oz1idn2TcW6TYgzx8z5XM5YwzWmRZASiv6oNZHhGiNDr59fEA==
X-Received: by 2002:a05:600c:6014:b0:410:df4b:f769 with SMTP id az20-20020a05600c601400b00410df4bf769mr1460899wmb.24.1707740564468;
        Mon, 12 Feb 2024 04:22:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVjFVn4MaKmiUXEDqozFhQLCpOTa5RJGTa4hA8nm4BpYdwWD6pKfGG4CsvmTKzfIBpcz0NwO7ChEvdW1gYOFd2jFpAeb+9r2TkTs3JmrY34Y8lbT9S9daAnfm5uqB4AAaCfuXJ12Q0XVCEOIAeSzoogIUeuJIj/XNsmuxPsOYZUFiS4bYGRWBCx2qkGLWuHUDznKId5o+C1vz2h+I09WjLBkG4KvakqyBa8FZ/HbwaoFqKMGT3bC9iFq+CG8sXvXzJ8481TOxwUUR2po2XjF5AfBw0pnOqZRwmhS1/Qml62TbY=
Received: from ?IPV6:2001:a61:1366:6801:b2db:904d:e0b0:46ec? ([2001:a61:1366:6801:b2db:904d:e0b0:46ec])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b00410d7e55e5asm2630204wms.3.2024.02.12.04.22.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 04:22:44 -0800 (PST)
Message-ID: <ca89eb86-a566-422c-9448-d8d5254d54b8@suse.com>
Date: Mon, 12 Feb 2024 13:22:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] media: ucvideo: Add quirk for Logitech Rally Bar
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Ricardo Ribalda <ribalda@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 stable@vger.kernel.org
References: <20240108-rallybar-v4-1-a7450641e41b@chromium.org>
 <20240204105227.GB25334@pendragon.ideasonboard.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20240204105227.GB25334@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.02.24 11:52, Laurent Pinchart wrote:
> Hi Ricardo,
> 
> Thank you for the patch.

Hi,

sorry for commenting on this late, but this patch has
a fundamental issue. In fact this issue is the reason the
handling for quirks is in usbcore at all.

If you leave the setting/clearing of this flag to a driver you
are introducing a race condition. The driver may or may not be
present at the time a device is enumerated. And you have
no idea how long the autosuspend delay is on a system
and what its default policy is regarding suspending
devices.
That means that a device can have been suspended and
resumed before it is probed. On a device that needs
RESET_RESUME, we are in trouble.
The inverse issue will arise if a device does not react
well to RESET_RESUME. You cannot rule out that a device
that must not be reset will be reset.

I am sorry, but it seems to me that the exceptions need
to go into usbcore.

	Regards
		Oliver

