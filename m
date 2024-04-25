Return-Path: <linux-kernel+bounces-159207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B885A8B2AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 761C9285B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FAF155728;
	Thu, 25 Apr 2024 21:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZMVkJhDJ"
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04EC12C468
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 21:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714080439; cv=none; b=nqxx9o9lpI7EBMSdCs6iQ0ernst3QKxoohnq5FEenZcV+7n1NrJYGht7filbRhQowcBMegJccdPo845j0g9NUankDV7+CIBWyAZqkraQpKLeQvxXcZH9EeMrk81erToKJ27mI1JsZ6ISKd4kRee58LfKxk6mglcNcN0JotJhBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714080439; c=relaxed/simple;
	bh=zbPXoCOqGZC6/7HnGhaHI9KvQcYCKR9cLhj9KPXjWgM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=I7QsT2V8Qm37Dq6hWFrqW5qVgbwKPH/iQsVIBX7ZNzxrdvN0srToF6C6EjpSyTHwRJDdGrtsDIj8BQjGnGJxrmeYRk+a1z0w11k/dLs39dBX2bim6q2mcSswy5+sJ6OK+S1j5aVYMu6F/ZuGNdQA7H6hoRct1GIlUbmumBEcXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZMVkJhDJ; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ad25d716-82d9-4fe4-9ec8-0f0c03e2bf7e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714080435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wno5e6OK2LxI/MavUegUEZHw1sVhkOi0VFaIBqIb1DQ=;
	b=ZMVkJhDJjYJ4s61CcoA7IL87zHVVLyrnupyVAK2ofiAWhg6y09qKRiOpj2waEJEtu/Hq6s
	oKUs4/p1u8QmIFNaZDpd4LEgUNFhxaaS+OHwkN0LSpBMLFm23u6/GK1/fxrzqLmwjPLmQZ
	wC66I5B6DJQ5tIMpsiMgAJEXGxuKboM=
Date: Fri, 26 Apr 2024 05:27:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v1,1/3] drm/panel: ili9341: Correct use of device property APIs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20240425142706.2440113-2-andriy.shevchenko@linux.intel.com>
 <c2d41916-0b6c-43b5-98eb-514eb0511f84@linux.dev>
 <ZiqqiAztCaiAgI8e@smile.fi.intel.com>
 <2599705c-0a64-4742-b1d7-330e9fde6e7a@linux.dev>
Content-Language: en-US
In-Reply-To: <2599705c-0a64-4742-b1d7-330e9fde6e7a@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2024/4/26 04:43, Sui Jingfeng wrote:
> But both of will be safe then. 

But both of us will be safe then.

-- 
Best regards,
Sui


