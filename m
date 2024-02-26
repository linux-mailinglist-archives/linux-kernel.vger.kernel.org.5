Return-Path: <linux-kernel+bounces-81839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D67867AB1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039121F28A39
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 15:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E69E12BF05;
	Mon, 26 Feb 2024 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AgBMC8lo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E548E12BEB6
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708962540; cv=none; b=pze2eMlvH2dnKoiN81pqKUJQ5iYdjrqs+iLR5CcH9RvIZnVYLmkzKBAUijlGtKa4gJtLc13HklhtxmC0xW4FDoShMmAbOepJg78wmte/L0eTn97DkQUB1b/riike++5LwMjZC+jeWTTk8WVuLYaoGagBb9kTiBimd0m/3AaQd7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708962540; c=relaxed/simple;
	bh=KmeL5VPvJW9DxfpDTFTe5jcLiHc1J/9qI2lJvr9W0QE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MpuQnMnrWNB7iIsk7VE5HIVW99sGWNs3JUcnL3UDoWxPqXis+AJAVI48ZIDhsKAWVzz5xfhoRcnSTDwDVC+EVnWAs53N/OcCvsS6tFYDGbQ5Gdak1YQ4BKJpyYkfyfAnjwDJNpw/w7ICu4d5H22JJTs58awxygHOd8wyAp8ADKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AgBMC8lo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708962537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XB2TRwyOPZ4MpC469uTrD2LaYCw03ZG9lAb31+BwZj4=;
	b=AgBMC8lok5VxC5eMagzHLaTZHkyvvJ2Yu37EiwHM4a12t4yGXjkZksJPxO1Y6/m8DK5683
	jrnmWlKpMm/flkL3FbudSoEgNLtO5smeX9ag6JcwTynL3xVCEyZP5cn4CgLWN/+HjIcpCz
	XdTDTeYE9PTCb5NLPNYwB2XHSR6DR7A=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-zLzlcqLzO8CWEEIEs2eOjw-1; Mon, 26 Feb 2024 10:48:56 -0500
X-MC-Unique: zLzlcqLzO8CWEEIEs2eOjw-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6901226a144so6670706d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708962535; x=1709567335;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XB2TRwyOPZ4MpC469uTrD2LaYCw03ZG9lAb31+BwZj4=;
        b=YxSGjBMd42oAAJz1+pEDg0q3h19MB2iqd0swsUVVy/wp4KNimMycTbIflXqPnvJHVS
         avtAbT8fRrZ707NeRSuQA8fde10TTIC66I8Z6KEugZcGCJKYnjspQosWfa4t7m0Yzxfr
         TtMYKtsmkbLNqG1btpCUnfB8Pa3spSqdtO9A4Ebly5TpXrGhnX9+LVk6WaPornR7IUyh
         0bTjJlWD1HR6lXF6b6DFTu4nU4ak19tMRm/5cZiN39w6Gvk0+GVrladmy9DXLWxZlk+f
         b7csXJErIT6T2lZcB2w3u9NjPNYBxKHU42CiscL6pRNO2w9irAGZ+eU0JbZ1s+/tZEh3
         BE3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgx+beC1lCYhgIdz3bzxB02yUvF1mJYTgNXReP98YTWPzq4gV2lv1X7NwmXKxgtuhda7J1TLug9bWIzorWsMi1wqL37Ifw+L/nB5ox
X-Gm-Message-State: AOJu0Yy4Eogs+y86zFRBR1fGOE5Jk1XK9tZA3TFMqoaPBPJdfAn1KJ5X
	mvSaJdH7tetUv0Oty7CUPkBJFPJQhTGsD0CIEjxqmRad3QnD2QYZnAJ0dZelnvXrxi4o/i9WBMZ
	XqbwddYTaVZfPe4NAOQrAxvD8mSLyMzYl5axB72FU+QtXMt5xVHYEPil8lu2QmWW+1j3u
X-Received: by 2002:a0c:9c86:0:b0:68f:9cd7:521 with SMTP id i6-20020a0c9c86000000b0068f9cd70521mr7468088qvf.30.1708962535121;
        Mon, 26 Feb 2024 07:48:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFE3cHrLgsWDANJopb3qHNrAVGtuCMtGFhdeIBXbdNmh8ncWAWnn1WLbEmKkR5oeDI6CxkLog==
X-Received: by 2002:a0c:9c86:0:b0:68f:9cd7:521 with SMTP id i6-20020a0c9c86000000b0068f9cd70521mr7468074qvf.30.1708962534878;
        Mon, 26 Feb 2024 07:48:54 -0800 (PST)
Received: from [192.168.9.34] (net-2-34-30-118.cust.vodafonedsl.it. [2.34.30.118])
        by smtp.gmail.com with ESMTPSA id a10-20020a0c8bca000000b0068fda83f293sm3097135qvc.121.2024.02.26.07.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 07:48:54 -0800 (PST)
Message-ID: <03915b45-94f6-4863-8b11-d0e9dbd0283a@redhat.com>
Date: Mon, 26 Feb 2024 16:48:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Marco Pagani <marpagan@redhat.com>
Subject: Re: [PATCH] drm/test/shmem: set a DMA mask for the mock device
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Guenter Roeck <linux@roeck-us.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240226110028.28009-1-marpagan@redhat.com>
 <d65v7jy4natx22lacw6awmg6iecfr2hqk3puuz3qem5dfsvj2x@hh6vp265hm5p>
Content-Language: en-US
In-Reply-To: <d65v7jy4natx22lacw6awmg6iecfr2hqk3puuz3qem5dfsvj2x@hh6vp265hm5p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2024-02-26 12:26, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Feb 26, 2024 at 12:00:27PM +0100, Marco Pagani wrote:
>> Set a DMA mask for the mock device to avoid warnings generated in
>> dma_map_sgtable().
>>
>> Reported-by: Guenter Roeck <linux@roeck-us.net>
>> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> 
> I've submitted last week this patch:
> https://lore.kernel.org/all/20240221125324.718192-1-mripard@kernel.org/
> 
> Which should be equivalent, but fixes the issue for all users in the
> tree.

Hi, thanks for letting me know. Fixing this issue for all DRM tests that were
using platform devices through the helpers makes perfect sense to me. I'm a
little more thoughtful about setting the mask for all KUnit tests that use fake
devices since there may be specific use cases. Just one curiosity: why setting
the default mask manually instead of using one of the dma_set_*() functions?

Thanks,
Marco


